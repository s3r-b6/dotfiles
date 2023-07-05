#!/usr/bin/env -S cargo +nightly -Zscript

use std::{println, process::Command};

fn main() {
    let output = Command::new("python")
        .arg("/home/ser/.local/bin/razer-cli")
        .arg("-ls")
        .output()
        .expect("razer-cli did not start correctly");

    let str = String::from_utf8(output.stdout).unwrap();
    let charge_pos = str.find("charge: ").unwrap() + 8;
    let charge_percent = str.get(charge_pos..charge_pos + 3).unwrap().trim();

    if charge_percent == "0" {
        println!("󰍾");
    } else {
        let charging_pos = charge_pos + 19;
        let not_charging = str.get(charging_pos..charging_pos + 1).unwrap() == "F";

        if not_charging {
            println!("󰍽  {}%", charge_percent);
        } else {
            println!("󰚥󰍽 {}%", charge_percent);
        }
    }
}
