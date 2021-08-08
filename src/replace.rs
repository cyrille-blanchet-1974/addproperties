use std::sync::mpsc::Receiver;
use std::sync::mpsc::Sender;
use std::thread::{spawn, JoinHandle};

pub fn start_thread_search(
    from_read: Receiver<String>,
    to_write: Sender<String>,
    key: &str,
    value: &str,
) -> JoinHandle<()> {
    let mut str_key = String::from(key);
    str_key.push('=');
    let str_value = String::from(value);
    spawn(move || {
        let mut key_maj = false;
        for l in from_read {
            let mut res = String::new();
            if key_maj {
                //already done -> simply pass lines
                res.push_str(&l);
            } else if l.to_uppercase().starts_with(&str_key.to_uppercase()) {
                //key found
                if str_value.is_empty() {
                    //need to remove (comment the key)
                    res.push('#');
                    res.push_str(&l)
                } else {
                    //-> update
                    //cut string
                    let mut line = l;
                    let _after = line.split_off(str_key.len());
                    res.push_str(&line);
                    res.push_str(&str_value);
                }
                key_maj = true;
            } else {
                res.push_str(&l);
            }
            if to_write.send(res).is_err() {
                println!("error sending to write");
                return;
            }
        }
        if !key_maj {
            //key not found
            if !&str_value.is_empty() {
                //no value equals remove key. Key not found so nothing to do
                //else  just add key
                let mut res = String::new();
                res.push_str(&str_key);
                res.push_str(&str_value);
                if to_write.send(res).is_err() {
                    println!("error sending to write");
                }
            }
        }
    })
}
