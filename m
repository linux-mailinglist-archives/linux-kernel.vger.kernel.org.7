Return-Path: <linux-kernel+bounces-740831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F70B0D9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0321AA4544
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A42E424A;
	Tue, 22 Jul 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AXn9v2C"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB142E9ED5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187642; cv=none; b=C5k+o5DMg8lmBtLHGrKnwfWsBii9sro8b475/6EK64HCbCz9lEpFqVqrCcccfhYof75lA1Q1jNmgvc12g8ud9WkBej/FXeGs81MeDrFWfFS1/6tbpboieHH2Fh5EXcN4CSL96/ZvybWeCJSMSTmFth48fMcYTN7Pdhvu9bPkpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187642; c=relaxed/simple;
	bh=FG99A8uKS0EE4jq/yYyxx3nPSnCQfslijrkZLCnqBt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z4M5K8r55YMuKuYAXrKM4sbAMPQpRv1jUIVtqeXqLjTPer86WYpGFuJKSh8IGp0g/xn1dhe6oZSsmztwsIsn5NqVc4aNbYr5SWjM32kxld5TAKWZt9iP58NuKaPlkEZKLaNHN+K25rVnJZQFC6K85iVvaue5fqVDpoIun1Pi7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AXn9v2C; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45639e6a320so27573575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753187639; x=1753792439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPTngAVTQIfkddyJSfXZqoosOR6+zBrLPpEZoe8PuFU=;
        b=2AXn9v2CZymy/HmSziNh6om8JigbDX5WxoaYBCbd9IemTGFV9MmNYqNGgdRYL6FNL+
         nFsFpmYeblo4wuAWOE7nbgY+4bGsdAhcpIt76v3j1M74uQGFYY0DSXDHti8BuBqmd0DH
         nTDxi22ICOjYSLS1WmJQ137vNccsLob6vwLl+Qef5zvzcXcOobwdl5vJnSrY+Q55jEzd
         4f0jIBfBrGeLBoMZBpxsHKXlZURMJ3ZjNr/11XMsfwTuXE7hCN6lGZpNoS+eFJVeEXn8
         9fT+LMHvpJ4zT7IppM2o4dibVWZz8z2RRQFHvmRXkwggwAMPtDkT16wgh/j1rWD6aRrs
         flkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187639; x=1753792439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPTngAVTQIfkddyJSfXZqoosOR6+zBrLPpEZoe8PuFU=;
        b=FseThMabUrLWsBVE76TKGFx2zR62CK6jUTG6KVzbAUBMdEKZCOLYJp+75vHWaEdNeu
         l3qyr1N9DFv++IUmzr8M4I7qgXJjY/EX+2N86Mi2zw+14a+mYwL8sHWrhTZRHTD3VgDA
         eVAKJPCHluS1w64mBEwHVY+xacpJCxkg7oVF39pCKkJC+S4HwJdAc/lq/cvalU8EVCP+
         gTRsD0mSaj/vKmfke+qWw2jikmvYzM+hntdlzK6GACptM27OaVZ+hKfJ34cpqdr+KqHo
         GmUxPrcdGedJ8xe7IxvPab9K0ySCaTyL6j16GInnqMM/5r7Sw3gXbf3tF2F9APguzgpa
         oqpA==
X-Forwarded-Encrypted: i=1; AJvYcCWSRLTxJ897h01hEZSwzCWI/9LzngSGZvtMp2/bbj4t0SR03xmjwYOGJ2Qf9fSTfVsCxez4Yop/CsNR2NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsufTMd1FGTUzXiRtRXMG9SZRkfNiL3V1nKW/N5cZtJOXkoSBO
	Xiaev5aA9lxfTVUMJ+6irHIln14Nt66Tz/D2YxUoUjAaImiennq6OiLVAZZ5FO+5hYlJC4UpKGM
	R5uylid+TkhwT6qzpEg==
X-Google-Smtp-Source: AGHT+IFXjGJcAEeFdu7nCu1d3cAti7GtSz1mDB/R5nXZkei19JW0FzweFSjBngPkIB+aR+qo5Q6rT1Owp4+hWy8=
X-Received: from wmbhc5.prod.google.com ([2002:a05:600c:8705:b0:456:302:6de0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64ce:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-4562e373d8emr252182475e9.17.1753187639039;
 Tue, 22 Jul 2025 05:33:59 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:33:12 +0000
In-Reply-To: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vIurSXFz5k4sNYySp9jntD8+LsMhT8UnySSZFixYeks=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBof4UwHa+JoiPxu/gVzVFNUGRHnO+trTQnz90Nh
 OMduI9/IiKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaH+FMAAKCRAEWL7uWMY5
 Rk0fEAChnUhKY4xTDqQJb7E2xrWr4MRDPfVt6PsD0vqz0rt+dr5aWhfmkfRO4ms2XN7X/WkG3lE
 6F83T5W9Bcj8036QqK/0tXR4l5ayYNKaHojafT5kmNx3VZjcC6kqG3BHIPjDtdS6DZ32dOms/0T
 EPrGWRPeW6L7YY/qlSqNQuwSDvnoatVEQxWIFb8N0QHJas/6wUULuBsNbCA5gUDrg3c/ZIV80d0
 BIjEitlJG5dT6tksa3dTLZAO5WYsrVyX2tEwesfP9hz3PgIJf8wtIZ75xL/Vda+zuEFDZfmE5ZG
 lJ1m2Rs5q4vZzl67kCT4kbhZkNKYjAvdW5DBs9g5T+TUgsVbxg+Yox5GEea2RSqet+QgAbHZNTM
 NtWVVFM08DYr08zhK52/Et8AuSWNKTD+T/N75J4+zf908P4bOCuGGSfjn06DeAo8HB4VE7YidzY
 0dSm3/yk+xZ8398A/jS4DEvdgEy0peb2o+AHaXat2v1gzXmxOjXYkanD0AngnPQDv10g14wt2BH
 JtOkls5OA3NlUeuVnvuyJVX76nCMGojQwU7KC6KW39akC2ymktFFyE7ABGtzsVpLHiN7s8C98nE
 XdMAyv+rGnshUGy3tx9+ejJ7O/fAxGet2lpqfKzqEp75TiiKr4K0yF9cqqTKd9EeI450C6iAvrY Jh87Cas0nEP3IeA==
X-Mailer: b4 0.14.2
Message-ID: <20250722-iov-iter-v3-4-3efc9c2c2893@google.com>
Subject: [PATCH v3 4/4] samples: rust_misc_device: Expand the sample to
 support read()ing from userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Lee Jones <lee@kernel.org>

A userland application can now operate on the char device with read() in
order to consume a locally held buffer.  Memory for the buffer is to be
provisioned and the buffer populated in its subsequently provided
write() counterpart.

Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 samples/rust/rust_misc_device.rs | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f754906615b6f89d72b51fa268f6c41..9e4005e337969af764e57a937ae5481d7710cfc9 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -100,8 +100,9 @@
 use kernel::{
     c_str,
     device::Device,
-    fs::File,
+    fs::{File, Kiocb},
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
+    iov::{IovIterDest, IovIterSource},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
@@ -144,6 +145,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 struct Inner {
     value: i32,
+    buffer: KVVec<u8>,
 }
 
 #[pin_data(PinnedDrop)]
@@ -165,7 +167,10 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         KBox::try_pin_init(
             try_pin_init! {
                 RustMiscDevice {
-                    inner <- new_mutex!( Inner{ value: 0_i32 } ),
+                    inner <- new_mutex!(Inner {
+                        value: 0_i32,
+                        buffer: KVVec::new(),
+                    }),
                     dev: dev,
                 }
             },
@@ -173,6 +178,33 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         )
     }
 
+    fn read_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterDest<'_>) -> Result<usize> {
+        let me = kiocb.file();
+        dev_info!(me.dev, "Reading from Rust Misc Device Sample\n");
+
+        let inner = me.inner.lock();
+        // Read the buffer contents, taking the file position into account.
+        let read = iov.simple_read_from_buffer(kiocb.ki_pos_mut(), &inner.buffer)?;
+
+        Ok(read)
+    }
+
+    fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> Result<usize> {
+        let me = kiocb.file();
+        dev_info!(me.dev, "Writing to Rust Misc Device Sample\n");
+
+        let mut inner = me.inner.lock();
+
+        // Replace buffer contents.
+        inner.buffer.clear();
+        let len = iov.copy_from_iter_vec(&mut inner.buffer, GFP_KERNEL)?;
+
+        // Set position to zero so that future `read` calls will see the new contents.
+        *kiocb.ki_pos_mut() = 0;
+
+        Ok(len)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 

-- 
2.50.0.727.gbf7dc18ff4-goog


