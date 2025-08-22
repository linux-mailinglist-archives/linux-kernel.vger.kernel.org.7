Return-Path: <linux-kernel+bounces-781924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A56B318BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6B3640592
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362C2FDC3B;
	Fri, 22 Aug 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="gAJKGmdK"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A4307490
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867411; cv=none; b=QEVtuNx1nA1itEjgaTZ6/vGM7dTBjqrPS8qM0UtdAZs6O75zq1WRK0RtE/B9eqFblIz4zANo+ShOyO9LdN3kjwlqsw8mQLhUugwTf6Q9jUrwtohsMmKXOjd0qYExKgUCNKZbfFQkafZBK+ydzWng0hp7hpT+mG+RWlDki7YYR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867411; c=relaxed/simple;
	bh=Kgha9M2aktOgnDSytFmmY+NS6OnOUezCcL8YMo7VSnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr2aYsWyajWRrEMAODQXP5xFNdjUYH4EVMuMdOFt0PwDwUkwkbDJb6EXxp5jRa9D1FBUU65UIurYUMisDRtoO2itLdL74iWTSXqtvbhRLNyE4FblhLDJ2F6y+E0OcoCTpkILYKM3qNMC1zEUdeYIlkxhlyYk/AgqcMt6iMVkq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=gAJKGmdK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so1907890b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867409; x=1756472209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpc3G4jkNpPP+8gbkzeuRuDbKnBFZfB7UrIuz+P/mto=;
        b=gAJKGmdKnDBU/z1X6hNTP4jUPFXoiSJCsx2GxsWmYl3fDO0WYvP2uJj2j8I32acloV
         cygrRrktHOCubpd+blNL1p9nUdDdrOnS8Kx4LwyUTgRhUPh+2E7/NViaIJF7K7MCEJ9p
         wRfEqjNXCGKn+C9n1uozPKVRCBjR9OgS0//VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867409; x=1756472209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpc3G4jkNpPP+8gbkzeuRuDbKnBFZfB7UrIuz+P/mto=;
        b=Dh/L6JPKy/uQuIQ1FfkzWX1iVqkcMqy6CkmPSWb1Pd8sNBUSsSXmSsD+HLanutfX1y
         Z28nUhIMXRs8dbSuwTL3L6by6cBCDLjz9SUhXpItE1DNjbw0N137JyttomWU/pkU7/W9
         4iV847dKdK6g8mCW2NcfHgC/3fzxu4KBLUpvpmiI0gU/KWMduVbNgeC91WPxbcCOevwE
         3y8z/m3lwnWcgG0NRr4C/yIpUBOoluqu3mORBWxzPjuHlUbCt2aDM6zUuASLRjVQWbMw
         L97dbJRytGu3s7qGQZAYPVsyS17DkQ96XGNjfvMqShahdiv3zlG9Ynvauk3MNDk4Nq/s
         ZjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdbN/tnkvWJmepa+CbLINSKOovdWweVrQ7jxzSKQ5CxWliP9wlwpTmFb8+qJ9fvYhTZ35ANxbkn34Ng0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGrRbrHyGUN368+tJ2apekZHz7kzrbwmLsOtWR2KWwqYNBdYu
	kRLMbWizMIgrPlyuMfijkhYd/GHJ2gOlFNJkWWh+kHxeJf6QaaJ8WPWNfdXfc/Pk+ADy1kePdtF
	nAzLL
X-Gm-Gg: ASbGncsu85z0DProCPG6MdLX4s29L6I0KQUkgRdwsoJ+bNJp4V4QlTTYY0Vj6nAwB+r
	QFTTrjbMjAcS5Mfh7T5AKpd3rnLLvZfIGve2sZPEu3DaiGSAHzccoKh0Yug19LdhAyeLuUz0f4M
	okcxaTXyXz/VRrKhQTH2JLI8uzypfUFrLR7logYfibOMfnDk44wr1ThlhFM7jip/Y3P8PbZkuvY
	FAtgE0svedKZxNbbWofhefooqWZdX9gxMPYumCWCWVR0WNUCUXfWk5ubJEWDZw1COOzkJM9fQl2
	Uo92i7HGBMb6eYkrOSo6Wbig8AZdWvjnH6mgZXd1S6+mRfF8mncTOeRj5hQtzlUNAiEFTopy13F
	zKGkDkYy0TWGHEhmOuVPUIg6qbBvNHMJeNlTzCc+6loFnyDW7xQC9wmRc5/RZx6pD9sL4QtO1
X-Google-Smtp-Source: AGHT+IEKR0Ev77BkY8PeWKbKpMu9lsAQ4CC61YA/ParYg5pJ6IvbBCFoZtzUSMCIDkhNoiLwiTh+1g==
X-Received: by 2002:a05:6a21:3297:b0:243:78a:82c5 with SMTP id adf61e73a8af0-243302e2cfcmr8212059637.26.1755867408937;
        Fri, 22 Aug 2025 05:56:48 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:48 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 4/5] rust: miscdevice: Add `uring_cmd` support
Date: Fri, 22 Aug 2025 12:55:54 +0000
Message-ID: <20250822125555.8620-5-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125555.8620-1-sidong.yang@furiosa.ai>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces support for `uring_cmd` to the `miscdevice`
framework. This is achieved by adding a new `uring_cmd` method to the
`MiscDevice` trait and wiring it up to the corresponding
`file_operations` entry.

The `uring_cmd` function provides a mechanism for `io_uring` to issue
commands to a device driver.

The new `uring_cmd` method takes the device, an `IoUringCmd` object,
and issue flags as arguments. The `IoUringCmd` object is a safe Rust
abstraction around the raw `io_uring_cmd` struct.

To enable `uring_cmd` for a specific misc device, the `HAS_URING_CMD`
constant must be set to `true` in the `MiscDevice` implementation.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/kernel/miscdevice.rs | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..fcef579218ba 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,9 +11,10 @@
 use crate::{
     bindings,
     device::Device,
-    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    error::{from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
     fs::File,
+    io_uring::IoUringCmd,
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
@@ -180,6 +181,21 @@ fn show_fdinfo(
     ) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
+
+    /// Handler for uring_cmd.
+    ///
+    /// This function is invoked when userspace process submits an uring_cmd op
+    /// on io-uring submission queue. The `device` is borrowed instance defined
+    /// by `Ptr`. The `io_uring_cmd` would be used for get arguments cmd_op, sqe,
+    /// cmd_data. The `issue_flags` is the flags includes options for uring_cmd.
+    /// The options are listed in `kernel::io_uring::cmd_flags`.
+    fn uring_cmd(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _io_uring_cmd: Pin<&mut IoUringCmd>,
+        _issue_flags: u32,
+    ) -> Result<i32> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// A vtable for the file operations of a Rust miscdevice.
@@ -337,6 +353,36 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         T::show_fdinfo(device, m, file);
     }
 
+    /// # Safety
+    ///
+    /// The caller must ensure that:
+    /// - The pointer `ioucmd` is not null and points to a valid `bindings::io_uring_cmd`.
+    unsafe extern "C" fn uring_cmd(
+        ioucmd: *mut bindings::io_uring_cmd,
+        issue_flags: ffi::c_uint,
+    ) -> c_int {
+        // SAFETY: `file` referenced by `ioucmd` is valid pointer. It's assigned in
+        // uring cmd preparation. So dereferencing is safe.
+        let raw_file = unsafe { (*ioucmd).file };
+
+        // SAFETY: `private_data` is guaranteed that it has valid pointer after
+        // this file opened. So dereferencing is safe.
+        let private = unsafe { (*raw_file).private_data }.cast();
+
+        // SAFETY: `ioucmd` is not null and points to valid memory `bindings::io_uring_cmd`
+        // and the memory pointed by `ioucmd` is valid and will not be moved or
+        // freed for the lifetime of returned value `ioucmd`
+        let ioucmd = unsafe { IoUringCmd::from_raw(ioucmd) };
+
+        // SAFETY: This call is safe because `private` is returned by
+        // `into_foreign` in [`open`]. And it's guaranteed
+        // that `from_foreign` is called by [`release`] after the end of
+        // the lifetime of `device`
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+
+        from_result(|| T::uring_cmd(device, ioucmd, issue_flags))
+    }
+
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
@@ -359,6 +405,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         } else {
             None
         },
+        uring_cmd: if T::HAS_URING_CMD {
+            Some(Self::uring_cmd)
+        } else {
+            None
+        },
         // SAFETY: All zeros is a valid value for `bindings::file_operations`.
         ..unsafe { MaybeUninit::zeroed().assume_init() }
     };
-- 
2.43.0


