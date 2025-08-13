Return-Path: <linux-kernel+bounces-766251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A9B24452
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FFC1BC2DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165B2F1FDF;
	Wed, 13 Aug 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hyd8uJxD"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC112F0C59
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073658; cv=none; b=cBniTbfGH9mQigk8+wqXG9k0UCJjhULKO+1ijYSqpxWtZJKmYYSUMu2O0O41l0cNmnpgITGvXL1FZt686qpyTIRphFBxjJixnQIN8EAGemc3ud8XlE3bm+bj4+Ik4R/GL3LBGx2jv7EqvtyGasC90DLGN8U91kBwaX3Zm7T8/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073658; c=relaxed/simple;
	bh=NvRCQIGdGJIWo6z/G2tCNyjPRInHwov/dUCUXA2+eg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LzxtXxhy4A1dS+nCOsTgG8rdVYxDhiZXZ8M2lUcQRsdYc2wp6PBYIhAQwOkXa9kiSr4QYyzVuADfWMwHKYYPc1qxLLEA3CbVZqZMbihReaJ8yqPo/cdaikbdjNXe3k3nve+Ob3m8XuB1YZ07FqjxXkY8szRyf2AdnDRANx+GLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hyd8uJxD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61530559847so4695928a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073654; x=1755678454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIJ+x4zOPX38S26xHW3ogZFnx98GYdUErZ7Lc5KD+uk=;
        b=Hyd8uJxD4wJXtBpX3Y6w8nX1ZqHtObQrXPPOwzUdI3ZxQx+oXQddFhfQnye574YRTT
         +rnGipbDAtalXeNbqrRmplkb1UDrPLhz9u3N+lVtU1hE1zGLOcc6lkTU1Hv5W179etdn
         o4rvL46NQGYImi9IlplxCHuiRoCyD90QwGDaIeAOpR82UpI8BjYBqqR9iVe9vpjA0/MG
         u4uyzd8I3bN3a6wxfmafo6auCR/VA0q905jo+cYuTIZTmWldRzNfyj5a1wYxnNkifsyz
         mbS7BXvObLZPReApsmp8x9A18WLxpqzJnufCHA7DeTEuVvznI9vW3rGptd4vy7gcBQYO
         fK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073655; x=1755678455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIJ+x4zOPX38S26xHW3ogZFnx98GYdUErZ7Lc5KD+uk=;
        b=XzNOp0h5v5DnIzFct+opIifJ43t9XjB4RzBEZZRufQSPlzTQDODA3q+1IA57VE7Wwz
         d0XalMm5gyFzI1RCm8/yEAGczA2nxntkbBuAb4BqM2ZpkiBHIR2Tjt0YzUQnTJBhDnRF
         xoORFUXeJW8j7kVC4pCkQOqk43jAm55EyoDByTwtn8av/3bSAIGrM/P+K7hCFKzD3yzB
         sUdD5mYxVSPXpFnZS6kyniTBdzR/ypCXoRRZb1svU0nQ9OoMtwhycWHrY7vjJ0Wt6jQ8
         1+4SNBJ3Rt3IJ0Hzd8eOSLxtCs1Osh7g8vHq7vTHobmMNRvNHtAtE6S/ZlmLF9rnFcIn
         cfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwpfB6wxqpQz+99QI4M4C4GCKW8wbcvvZCJ5MaeqCr7CyWujdgxJTFYc1Pby+rmNASD4EyLt2qxbu2SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCv4dcCN+27x2lnhm4XhmAVFv6ZjBSS9tykhTy/x1P57qr0qRJ
	PUmEsyLdMO3MXI4OPOG6ZydRPGDkMwrVr6ZajA0zHUBOjJxVktGabgVO9fNS+hdWlqBPHApSRwg
	2SHzKJqbq/cUST3CWqw==
X-Google-Smtp-Source: AGHT+IE8ydanFwGG7KesQpAN8skGF2NnY35RVGG+5pSg3DQ1udrmQq4PkLWonfAcxDhio26JiagvnS+7olbq9ac=
X-Received: from edn14.prod.google.com ([2002:a05:6402:a0ce:b0:615:49c7:ddf6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:44c9:b0:618:273b:4f51 with SMTP id 4fb4d7f45d1cf-6186bfd5757mr1340836a12.23.1755073654306;
 Wed, 13 Aug 2025 01:27:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:27:20 +0000
In-Reply-To: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=eF5bCKQbWoDK+4GDnO0XjfTUd6tLFH3Wpg7SaPmi7HE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonExt5tmxz5dadRkEbyP/qbVmEqwLito1TQxGa
 v2Wm02OrvCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxMbQAKCRAEWL7uWMY5
 RpmfD/0SM46L161T6o/+tvWN8XkkrrDFh1/r3CbeOCqgv8y6x9N1PLE1/g48HWviJyhJ/pOqUO9
 LD8siSkS1DgF7oZJuvPfMZN+Zh5J4hhqLsoQgvuDAe6tZa4uQjTFF4N9hcF/6ikgxBpUwZq6wBa
 muQbThm+pD/m6TGglZIeVlIbia1tVO9LwbTMXPUlhdq3OWP9D7NQ2TaYlm1fryLb7vdC6CCb98S
 Czw1+YvaoVVEflEX7/mMvNBE4gM6mdmthjDsDW4OdggnMjCp8OHn6GOd4FACMYbY5mHBi6vSUL0
 Y9FRNAxJapcHlJqbfFi/r9g5hz9gIvLfRiI30G3UtlUGJ4bHP9zxsFdVR0UGzHWnzLpHAMTlKsJ
 Z3Tis7T6h4UPTZ05WdcULNVAO/QumFEJF2xdnsjZ0fSmJ3N0HV0z5Fi1vitRQuRQ9pk3o3QdVL9
 ALvHnfOJsLgyeaQAbClEHbXhbWxEMfzeReDhVmqTlG/pvS7MBCZMiKtzVtdqvTn0A8tbdrSQ8p1
 kynBLZ1oNqksBSJRedldc0rDMuF2R3nqMd6ZJh0bHYAe/gegvTuiXIeoEie3M6e7jlPnjQwcQ2e
 HA4bPUiYawyvDt+jJUzv8GdE91FRXoT9QrP1qL64/eUD2zXFuP7u+j1VL0GLfr8M6JcyonHjbjM YAyPkNAoT385bCw==
X-Mailer: b4 0.14.2
Message-ID: <20250813-iov-iter-v4-4-c4f1932b05ef@google.com>
Subject: [PATCH v4 4/4] samples: rust_misc_device: Expand the sample to
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
2.51.0.rc0.205.g4a044479a3-goog


