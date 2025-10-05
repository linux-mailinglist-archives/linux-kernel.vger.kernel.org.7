Return-Path: <linux-kernel+bounces-842253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AEBB9569
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EE43B9C57
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656F26C399;
	Sun,  5 Oct 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4eag9q4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DA25D1FC
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759659755; cv=none; b=AeXItgwev22Fkx+mCu6Mj23OIMw8g5GkrbgOTvPryi5pUjhFiLJOQJfJE485gpTo+EfG530zbahzOVnbcV3za1HXLbEqLT3vh5TdC9nBntsBT60uzzXlZqrDr5DIzp73VmRmidBqyGPF1ABDTYmUuv6euCkz/QyffUpXFMKEPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759659755; c=relaxed/simple;
	bh=014TfYqN3Jm51Kwrsshh0C7lrXndtjXKzXJvEQMsYt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lo1hNzPaiQcyBLw/Q9YkV9GNcNfIcWIg7J3Zrnmx6qfItZZEl8DDWU7p/CLVKgXOL+zUNTdmh2SW59qMCK9WwyxLZYfjQlYQTlE091apfABZ20wxVjUMg9h1DZojmbQsuenSeLo8Enbr4GJl0xB8uflgvjWkvzhLwxvKkAFg32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4eag9q4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2552556f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759659751; x=1760264551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOWcLazJ0KI6bew1rjQOg+oZIoGTP/PL0YVWlyFt/TI=;
        b=f4eag9q4K8US4NHOBPyaW6BCDZMdEjxZMP8StfPTaOYVtE8aOL0p2uTAN3CFNQWOHE
         YkyK4phzHrcuFoveoOzBnLpVMVp7Q/8cQ0NSbnki4Bxf0NoKgOYVfpx2PA4RanHbETTC
         4J/w1uahtYX5zAuf6piMxQOSkVh49QonABdades0KTSBzDApyZ0D7q+4XC5KEf+vcY5G
         OANOfmJaRrhkqc7+BsW4275XNxBP7FAr8kbJcWGeM7YdPnwm2lRC+baqF0pI/P2pm0eK
         vxOpZh2K3cbATjZIZDP97iOiomuhNFeFA4NkR/C9DmqaSNVj2VmU25o4ZlqSdxTDQqMN
         kwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759659751; x=1760264551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOWcLazJ0KI6bew1rjQOg+oZIoGTP/PL0YVWlyFt/TI=;
        b=HA8ki1t8gpLHUzhJwwy7y9JUyu3HDJ82WCb83VuBGlO562KglWONOhBGulHs423epo
         JDjCUXzabzvbz48U7bylcNTcLjJs1844AywV+UneHUbM9ewGD8K+28DK0OBAE4j2xKkS
         wnTDww15c/KIlNh3QepLWaSqLFbDzD0RPYMibliS8tDovuQ+Vci4SoMAo0idA3ik14cc
         r0QLzfdaHJSQ6u2IWxoBXbPFRS0FYR8ntOF4+Lt0jD7JQMsDNInj+fncyXzDKZQ9TDGO
         1qumv1pgDaOMF6tTFEDb/As6NBhoNwb8gQljOwbdJnpwAjkAHmEXrDIDslM+4GfOQGqC
         NXPA==
X-Forwarded-Encrypted: i=1; AJvYcCWYraq/XVt/4gCAldkPPpa2GfDp1SXngOIwRokewjUIgSI6Fbilyt2SPZrE1+MaamNqkreNP4zctKXOjp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZB5CORdmkYJAXlD4hvOG/fpqqMqphYxLJqbS9aeAtjDRiJ5jz
	utglUEPUOBawkhyFZaOy72PAHqzh7ThvxBXeMWdQpWS2bP3Nsoa7D6cI
X-Gm-Gg: ASbGncuTMjlLg2FS+eGmC+VfZBSniF5nbXzRaTH/jBH/0VZZkyK1x5pVGBSrqWkh62l
	ggev15UqfRusGdpbQWxWt+C16/x2rmGScZ1xAhC1DMxt1nXVNBtaESKHy+JPTB/buau10v3JR01
	2V/10ecPQlrqJO7cmDjTKljT+WHcnyhC3uRc73/jJQfurPaf1kGWJz3z/lrFHyqG0rDJbgR7hjK
	NVVUT5aPkP/2C2Cp4rzbFZ2J/6D9fGXt6CMBpMEDegUy79mAIQvydLdiNlz9ktSz+asIfcKElfb
	67743mHyKHWm8ccG/P3GIapJXJL8ClWxB/8ECgwhNzOCrUCcSHN7/ovmmN6rydlqSZsA9PMSe+c
	JL11Lnrbu/TFUc2cA9UAD4gUkao9AkpNcVMrHt9m0QADI/nSY45BBQLrn
X-Google-Smtp-Source: AGHT+IFQqIQ2T67iM4l0Z9hio/dmJ+0gCd9LzgbFU3MTDe0hCh0YE0mZQ4+Qxw9DEq0sf2IHE4GZfw==
X-Received: by 2002:a5d:64e9:0:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-42566c00d2fmr6523458f8f.6.1759659750540;
        Sun, 05 Oct 2025 03:22:30 -0700 (PDT)
Received: from Vasilio.Home ([2.127.51.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm15822332f8f.38.2025.10.05.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 03:22:30 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 0/3] rust: i2c: Add basic I2C driver abstractions
Date: Sun,  5 Oct 2025 11:22:26 +0100
Message-ID: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series lays the groundwork for writing Linux I2C drivers in 
Rust by:

 1. Core abstractions 
    Introduce `i2c::I2cClient`, `i2c::I2cAdapter`, `i2c::Driver` and 
    built on the existing `struct i2c_client`, `struct i2c_adapter` 
    and `struct i2c_driver`, with safe Rust wrappers around probe, 
    transfer, and teardown logic.

 2. Manual device creation  
    Provide an API to register an I2C device at runtime from Rust using
    `I2cBoardInfo` and `I2cAdapter`, including automatic cleanup when 
    the driver unloads.

 3. Sample driver (legacy table, OF & ACPI)  
    Add `rust_driver_i2c`, a sample that:
      - creates an I2C client device using `i2c::Registration::new()`
      - binds to an I2C client via: 
        - legacy I2C-ID table, 
        - Open Firmware (device-tree) compatible strings, or
        - ACPI IDs.
      - destroyes the I2C client device on exit.

Together, these three patches:

- Establish the essential Rust traits and types for I2C drivers.
- Enable driver binding via legacy ID table, device-tree (OF), or ACPI
- Enable manual device creation at runtime.
- Ship a samples showing typical usage 

Igor Korotin (3):
  rust: i2c: add basic I2C device and driver abstractions
  rust: i2c: add manual I2C device creation abstractions
  samples: rust: add Rust I2C sample driver

Changelog
---------
v6:
 - Add implementation of unbind for `i2c::Driver` trait;
 - Add argument `Pin<&Self>` to `i2c::Driver::shutdown` method; 
 - Adjust usage of `i2c::Driver::shutdown` in 
   `i2c::Adapter::shutdown_callback` in `i2c::Driver` trait code 
   example and in rust_driver_i2c code;
 - Remove dummy AsRef implementation for I2cAdapter. Adjust code 
   in rust_driver_i2c;
 - Add `i2c::I2cAdapter::get_nr` method that returns I2cAdapter index;
 - Optimize unsafe sections in inc_ref/dec_ref in AlwaysRefCounted 
   for I2cAdapter implementation;
 - Remove unnecessary Drop implementation for I2cAdapter, because 
   I2cAdapter is always a reference;
 - Remove unnecessary type definition `Ops<T>` in rust_driver_i2c
 - Simplify call of `i2c::I2cAdapter::get` in `try_pin_init!` macro 
   for rust_driver_i2c
 - Link to v5: https://lore.kernel.org/rust-for-linux/20250911154717.96637-1-igor.korotin.linux@gmail.com/ 
v5:
 - Rename missed pdev variables to idev (thanks to Daniel).
 - Import `crate::device_id::RawDeviceIdIndex` and 
   `crate::types::AlwaysRefCounted` in i2c.rs.
 - Switch dev_dbg to dev_info in the sample I2C driver messages.
 - Make `I2cAdapter::get()` return `ARef<I2cAdapter>` instead of 
   `&I2cAdapter`.
 - Remove `TryFrom<device::Device<Ctx>> for I2cAdapter<Ctx>` (unused; 
   to be reintroduced in a later I2C series).
 - Remove `AsRef<device::Device<Ctx>> for I2cAdapter<Ctx>` (unused; 
   to be reintroduced in a later I2C series).
 - Add `AsRef<I2cAdapter> for I2cAdapter<Ctx>`.
 - Use i2c_get/put_adapter instead of get/put_device for 
   `AlwaysRefCounted<I2cAdapter>`.
 - Update safety comment for `unsafe impl Sync for Registration {}`.
 - Tweak comment for `I2cBoardInfo::new`.
 - Adjust build-time assertion message in `Adapter::register`.
 - Link to v4: https://lore.kernel.org/rust-for-linux/20250820151427.1812482-1-igor.korotin.linux@gmail.com/ 
v4:
 - Renamed `i2c::I2cAdapterRef` to `i2c::I2cAdapter`.
 - Renamed `i2c::Device` to `i2c::I2cClient` for consistency with 
   `i2c::I2cAdapter` and to avoid confusion with `i2c::Adapter`
 - Reworked `i2c::I2cAdapter` to be an Opaque around `i2c_adapter` struct
 - Implemented AlwaysRefCounted trait for `i2c::I2cAdapter`. 
 - Fixed numerous comment mistakes and typos all over the code, thanks 
   to Danilo and Daniel
 - Got rid of all unwrap() use-cases in i2c.rs and rust_driver_i2c.rs.
   This covers 0-day kernel panic <202508071027.8981cbd4-lkp@intel.com>
 - Removed unnecessary casts.
 - Replaced all addr_of_mut! macros to &raw mut.
 - In `i2c::Adapter::register` method build assert if all ID tables are 
   None.
 - Renamed all pdrv and pdev instances to idrv and idev respectivly 
 - Implemented an ealry return in `i2c::Adapter::i2c_id_info`
 - Added all missing Safety comments. 
 - Removed `unsafe impl<Ctx: device::DeviceContext> crate::types::AlwaysRefCounted for Device<Ctx>` 
   implementation which came to v3 from v2 by mistake.
 - Added more details regarding i2c-stub driver usage in rust_driver_i2c
   comment.
 - Changed `i2c::I2cAdapter::get` return type from `Option<Self>` to 
   `Result<&'static Self>`.
 - Added Daniel Almeida as a reviewer to the "I2C Subsystem [RUST]" entry 
   in MAINTAINERS, per his offer.
 - Link to v3: https://lore.kernel.org/rust-for-linux/20250801153742.13472-1-igor.korotin.linux@gmail.com/
v3: 
 - removed unnecessary i2c_get_clientdata and i2c_set_clientdata rust 
   helpers. Using generic accessors implemented in [1] instead.
 - Reimplemented i2c::DeviceId based on changes in [2].
 - Using from_result in i2c::Adapter::probe_callback
 - Using explicit drop() for i2c client private data in 
   `i2c::Adapter::remove_callback`
 - replaced device::Device::as_ref() with device::Device::from_raw in 
   `i2c::Device::as_ref()`. It is renamed in device::Device.
 - Build Rust I2C only if I2C is built-in
 - Reimplement overcomplicated trait i2c::DeviceOwned the same way it is 
   implemented in auxiliary [3].
 - Merge rust_device_i2c and rust_driver_i2c samples. Resulting 
   rust_driver_i2c creates pined i2c_client using i2c::Registration::new 
   and probes newly created i2c_client.
 - Created a new entry in MAINTAINERS file containing i2c.rs and 
   rust_driver_i2c.rs in it.
 - Link to v2: [4] 

 [1] https://lore.kernel.org/lkml/20250621195118.124245-3-dakr@kernel.org/
 [2] https://lore.kernel.org/rust-for-linux/20250711040947.1252162-1-fujita.tomonori@gmail.com/
 [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/auxiliary.rs?h=v6.16-rc4#n299
 [4] https://lore.kernel.org/rust-for-linux/20250704153332.1193214-1-igor.korotin.linux@gmail.com/ 

v2:
 - Merged separated ACPI support patches since ACPI-table support is 
   merged into driver-core-next.
 - Added I2cAdapterRef and I2cBoardInfo abstractions 
 - Added DeviceState generic parameter which is used for `i2c::Device`
   as a sign if the device is created manually
 - Added `DeviceOwned` abstraction which is a safe reference to a 
   manually created `i2c::Device<Ctx, state::Owned>`. 
 - Added Rust manual I2C device creation sample
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250626174623.904917-1-igor.korotin.linux@gmail.com/

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/i2c.rs              | 565 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_i2c.rs | 126 +++++++
 7 files changed, 715 insertions(+)
 create mode 100644 rust/kernel/i2c.rs
 create mode 100644 samples/rust/rust_driver_i2c.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


