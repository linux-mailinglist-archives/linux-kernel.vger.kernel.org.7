Return-Path: <linux-kernel+bounces-737781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B59B0B080
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC9AA7F2D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DF28936F;
	Sat, 19 Jul 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="aJfYuXOx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B050288CBA
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935662; cv=none; b=jJPzfnoLH268FA6rM2Ez9AEyxdNBVCQVBjCzdCHqQO/HpLa/C2QHS/6kdle3k2pnfYqqQSSE1pL6yM6kiMwRwlMn52c9tqtfgVJrSHYh0eYCKRHQ7MBK4qkyWt3OHTICOTgsTIISDs1ZbXKbfCvkaFuxaN5ri5/jpVlnNxU9sGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935662; c=relaxed/simple;
	bh=R8jGhX8GJtxbiAjtt52NeFBV/TnGPSvZljPJO54V9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg9bKlbxEn9Ax8BWlW+qEe7TvDTDRfO0/qTyYLtUDNofbSHc8kUWGJDnB6tPToveXmrcoJ3pQNQTfcXMS/4GffuCl+42R6rv6uFyXltUmMjooaoXx4tLwKEylJcLx+LSxoSyRaVhn/2scLXDeppGwIeEog21cUpljkqoVze8q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=aJfYuXOx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234fcadde3eso34956825ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1752935660; x=1753540460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXkaSAeBjzAQ8y2xwh0Xd1YosILeCAcR4SjyO3knpT8=;
        b=aJfYuXOxg5aGSwJytWRSxA2iVptDm6BSlt+stdfturMsUIiU+oTsmKsEAMyLSlaXqO
         G5TkolIGNV00tg7nANLFhpxuXloH+FwRnvq47kzMKJDEsSy22Q18K+MBRk7NVP3mYCLE
         nbmrHP2KLJhOGX47b3qAg/oVkz0Bny0npGBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935660; x=1753540460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXkaSAeBjzAQ8y2xwh0Xd1YosILeCAcR4SjyO3knpT8=;
        b=pcWe+xgWtadBFd7tHdnfAObdmvKOTUaN+uouYUy2yF+/2EppuS686H+Qm0hIiRiM2J
         UQKerIV2G34z54FD4QT4wg5B9ZIIBjRB15VBhBo/wUvpaMHoo82l15lWafHF5KsdklRa
         g254Xn+udtApMub8TRIJikyBG5dfYhaKCVO2D7zCWkt3+gNmfsBq5m0ut4q0aeoheyEg
         kv2zkbx6aaRpH+mzDbZA5KqYllmanY36x9y2hHIZp1lvFJgTBJo09txGxuifO6wQZCyP
         A2ERFAxfxaQgzej6V2dICi99x7ml8VktKV+0nVwpUcBYKrGeEAkkATxiG0utcbMzxEtC
         NlZA==
X-Forwarded-Encrypted: i=1; AJvYcCXP2mhcTLtXU4jBGIutQ5GhVdHoiCjIUuFYYFWPmgKiDJd0pflhFDRMe1VoZEJrGx0aVdTNzDQ4o9H0O9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAY8YH6yxnlL9plhMPDgUZolXpqfDlbgn82UpNLkjXYZ2bUKhc
	wZgeyaBgNWVGasyyKe9nRPzvJvx0Xd7noWuIxitRXB9pp486s9wQxOm2WTF4sn7rr8Y=
X-Gm-Gg: ASbGncu/9F2tpYUR25m01OxHAeCRyFAyUQCQM4Hzx1l/hXkpc8C52iIj1x4+p3D3TlI
	/nItDdVgSf87o2hUmSmAsuKjby8L+uvnTwPHREyOkuJk3Kmv8KLWgL+hkWdLI/w/+JG4NsPd3v+
	2eoc9s2f9iB0+1zoO7u2T4L0CFVNMBDudGPwxTSWRB1iKizCxq5LBHMZyabL1m7A4adCQLoTQb5
	G+SXJpg4GSWHoomMTQAhVdFAe03VqY1lhSk7irmLgVmWqyYFS/dOc/S49NNkinvizl+ol824Kr2
	5JXtZ/w5iKqGGuPfnckNHxnF614xnpPAGj3upu952YVb5Kyhn+gDv3Y5Kw07pcT4BMPVfwHoNZK
	5+s6NSZE/2G3WWRy1drtd7qi84GibPN362KwtNp4uUwkZC2CW0KYc5kV8tCc=
X-Google-Smtp-Source: AGHT+IH1voNmCvwGJvMrZvclPm+sCwPYvCoAW1RlSoHG0ImiAoioy10GrH2F7hsoOibb8Z+aHB5r3g==
X-Received: by 2002:a17:903:1b6c:b0:234:8ec1:4aea with SMTP id d9443c01a7336-23e2579eed1mr218928065ad.52.1752935659962;
        Sat, 19 Jul 2025 07:34:19 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm30017525ad.23.2025.07.19.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:34:19 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 4/4] samples: rust: rust_misc_device: add uring_cmd example
Date: Sat, 19 Jul 2025 14:33:58 +0000
Message-ID: <20250719143358.22363-5-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719143358.22363-1-sidong.yang@furiosa.ai>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes rust_misc_device handle uring_cmd. Command ops are like
ioctl that set or get values in simple way.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 samples/rust/rust_misc_device.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index c881fd6dbd08..cd0e578231d2 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -101,6 +101,7 @@
     c_str,
     device::Device,
     fs::File,
+    io_uring::IoUringCmd,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
@@ -114,6 +115,9 @@
 const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
 const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
+const RUST_MISC_DEV_URING_CMD_SET_VALUE: u32 = 0x83;
+const RUST_MISC_DEV_URING_CMD_GET_VALUE: u32 = 0x84;
+
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
@@ -190,6 +194,32 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result
 
         Ok(0)
     }
+
+    fn uring_cmd(
+        me: Pin<&RustMiscDevice>,
+        _file: &File,
+        io_uring_cmd: &IoUringCmd,
+        _issue_flags: u32,
+    ) -> Result<isize> {
+        dev_info!(me.dev, "UringCmd Rust Misc Device Sample\n");
+        let cmd = io_uring_cmd.cmd_op();
+        let cmd_data = io_uring_cmd.sqe().cmd_data().as_ptr() as *const usize;
+        let addr = unsafe { *cmd_data };
+
+        match cmd {
+            RUST_MISC_DEV_URING_CMD_SET_VALUE => {
+                me.set_value(UserSlice::new(addr, 8).reader())?;
+            }
+            RUST_MISC_DEV_URING_CMD_GET_VALUE => {
+                me.get_value(UserSlice::new(addr, 8).writer())?;
+            }
+            _ => {
+                dev_err!(me.dev, "-> uring_cmd not recognised: {}\n", cmd);
+                return Err(ENOTTY);
+            }
+        }
+        Ok(0)
+    }
 }
 
 #[pinned_drop]
-- 
2.43.0


