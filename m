Return-Path: <linux-kernel+bounces-747124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B3B13005
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A0C1898BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242E21D3F1;
	Sun, 27 Jul 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="oYvpybBo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31921CC55
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628675; cv=none; b=AjYlcp7oQR4N0u4d+SEx7wuSi1OVQ+WTkgFLlCy8gxzmLpMwaUYF9jjlb0OaiMiNeHc8d2IqFFZKk6mtig0fE2aeVLQcOZ7+YoR1U9YlZnS7pd+WfPt4m7R+zwHnsuM5IbSt0CZxl7YjkYjEnKy9YP0nhYmTkFUUslRdSpQIG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628675; c=relaxed/simple;
	bh=LYz4BJjEcxej4a2hfZQjwwKXuLLfa6KFrpaj5RCmjU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxhOEwBmcfJ894r6K3/DA0g0Vo1VMUDoP0PWTBSG/5X59vHODtlwrKdDfh7BiA8drPNfO09jqLHHzqWEK05lgv/mypuXNrzr2w8g/mmYuC2TKPiLvNufz2m0JSwq9+aL2H3fSMGJnIQjj1XebIsvttRv9qh/tLOFfatGgBCDqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=oYvpybBo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24014cd385bso3901085ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753628672; x=1754233472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF8dNyFHhR5n7ctm1h4dvcd/FHv92TBiu95SBZTfIhs=;
        b=oYvpybBozPeNGcX9sJTU7BAvYgyef8KzlEzqS72ym5+zHa0LXdxdWXDMjZExT3q3Ht
         wN4kArx/GmqEUXs6VdgDze9FWxp4bLm2t9lobECX1fV6XdG0nGRwzhmRnJevvuX+McHH
         Unjpe6rXvWlPPAMUGlhntd4Iu6bxmslgI9NZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753628672; x=1754233472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PF8dNyFHhR5n7ctm1h4dvcd/FHv92TBiu95SBZTfIhs=;
        b=xBitl0dZ2RecuhI2v2kgGiBpvY/+rnmmHEaKCWdYPf8YgjIra4M0iVNZZxoqDN3NDG
         vU/PQpn3o/JVO+nUuwajgfkZFMk4Hz6S5Y1WIjJYZGf4U53KcScnlBZv2tkBmnPY95tO
         i3dxhZuvcxNvUnZuogiahTY6gMaxqeaPku3EDH7DlriwL9vSMsQyIs80+59C1DKgQOd6
         F+Gt/xGBkN40xH2VTv0ygsWoB8hC5vFVpsw7pG20GzZpbrcRjSOsOKHBpXZksSo0m31h
         mjzB3Nx83/9G+JLC/aze1n9EjKe/69oHg3VcZZlhFH+pU2AEo+ZILfAsnTrZFitd7FJI
         P1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUoMQj7CK6CN1DRgA+9RuugQx8JNxXEqlsKvN4AqtCqE0t7LXZN6ftmIDi+xVi1JPVt0t6W3UQ+yBVob1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9Z1/klp6kolipp2mhNtRWMZz13gaRGxNAc4UJMfiND3j7Wky
	0zuEpCR11BLpkLs0NqobFlwVoiAc5VdhHKTX+8w3z6qeNmYxravPmu/jn28ihQfmZXDJg9Jg1fq
	vRaRO
X-Gm-Gg: ASbGncv4j/VKIQa/EeCsYs4NXPbe9mtQd//AM38U59oH7qLf3DQ0pFGomDQ7/7S7PwO
	lrsID4uIRXpAdBdK89FwNdXIU5hBzW2f4gGdhAJRpbdP+FOJkwm8dtdHuHInlpMQD5EbGWsVQwf
	1W8dn7UnuBJxi1qXN7lDe/sMYL1pj8m20GUksF3FbYkRScQCjJq6/DUzz163gF2u/e/mhjXe80q
	vOZTNTPlkO4/xKnUWA6AyYF6oXiMQ0pkkrKoSuVbjBmg39iWHEoib8ftpFy8eq06Z41zNucpNpw
	AwBDZw7zuG9cVmiwpHYDiKuqVlDog1NuMHPaBssteGVdn1rj0q+6I1yVZo6Yb8J9n7UWvogNYMV
	ageXHTdCaIWqK6mfU7PqFxxB4R52x7vMItnjA4zpToFW7OVjHLcMYCBMsBiWYBT1Y3bOmYKm/
X-Google-Smtp-Source: AGHT+IFB6M/iK5b+VX6qsLhQzXTdgj2DRxrKstCfZsGXDnZr07n3sQDXtrRVVzTp4bMKr/agcoYYRA==
X-Received: by 2002:a17:902:ccc9:b0:240:2eb6:d5cc with SMTP id d9443c01a7336-2402eb6d9e9mr6477695ad.17.1753628672438;
        Sun, 27 Jul 2025 08:04:32 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdec96aesm15381965ad.165.2025.07.27.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:04:32 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 3/4] rust: miscdevice: add uring_cmd() for MiscDevice trait
Date: Sun, 27 Jul 2025 15:03:28 +0000
Message-ID: <20250727150329.27433-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727150329.27433-1-sidong.yang@furiosa.ai>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds uring_cmd() function for MiscDevice trait and its
callback implementation. It uses IoUringCmd that io_uring_cmd rust
abstraction.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/kernel/miscdevice.rs | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 288f40e79906..54be866ea7ff 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -14,6 +14,7 @@
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
     fs::File,
+    io_uring::IoUringCmd,
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
@@ -175,6 +176,19 @@ fn show_fdinfo(
     ) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
+
+    /// Handler for uring_cmd.
+    ///
+    /// This function is invoked when userspace process submits the uring_cmd op
+    /// on io_uring submission queue. The `io_uring_cmd` would be used for get
+    /// arguments cmd_op, sqe, cmd_data.
+    fn uring_cmd(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _io_uring_cmd: Pin<&mut IoUringCmd>,
+        _issue_flags: u32,
+    ) -> Result<i32> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// A vtable for the file operations of a Rust miscdevice.
@@ -332,6 +346,28 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         T::show_fdinfo(device, m, file);
     }
 
+    /// # Safety
+    ///
+    /// `ioucmd` is not null and points to a valid `bindings::io_uring_cmd`.
+    unsafe extern "C" fn uring_cmd(
+        ioucmd: *mut bindings::io_uring_cmd,
+        issue_flags: ffi::c_uint,
+    ) -> ffi::c_int {
+        // SAFETY: The file is valid for the duration of this call.
+        let ioucmd = unsafe { IoUringCmd::from_raw(ioucmd) };
+        let file = ioucmd.file();
+
+        // SAFETY: The file is valid for the duration of this call.
+        let private = unsafe { (*file.as_ptr()).private_data }.cast();
+        // SAFETY: uring_cmd calls can borrow the private data of the file.
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+
+        match T::uring_cmd(device, ioucmd, issue_flags) {
+            Ok(ret) => ret as ffi::c_int,
+            Err(err) => err.to_errno() as ffi::c_int,
+        }
+    }
+
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
@@ -354,6 +390,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
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


