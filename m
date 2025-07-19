Return-Path: <linux-kernel+bounces-737780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65EB0B07E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA855640EC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7D288CA3;
	Sat, 19 Jul 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="kFegiSQF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA70288538
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935659; cv=none; b=XXnCXSh2QBTedWLuz/8Pd2SJirt1YQQmRYeCsXFewfmvqm6wMVkUX7dsUdD/iLXxh16ySB4F0ySWrGJDJy2YeTcrYwnIk8gSjbtpnW/mYOj2K6Rt4Ot+QB1887KH0AdR1YYfpR3sAO7apYMBNQL5evOoqLHEi33bpYHEAcpjKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935659; c=relaxed/simple;
	bh=sLwtCfowiTS4RrXXFn1Q5b/rrzQ0SHWiAbzOJPGBWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO1lbwDvWWBWofmFbC3eBUC3RTDP6WpkvEriPRZalkNOw76WSAs0bsQp22mosvvHx8KPQTSWdMCcwYyCkYVszlYY3D6o3g9UtGc1vv/rMuBaP8A7QJ9FBfWqoJmvrw7kRhaTFcJMpW8IziJ81EH5O3WEyMes8dtIOyZo14vAv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=kFegiSQF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c703c471dso43329405ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1752935657; x=1753540457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJB64qIr1jI1unz5Cd2pxQc3wV9oq6+knIF/UbqEYPk=;
        b=kFegiSQF1cM/J6yqx8kDEapU2dFaoYgFZCRO5bDFccXG/JHj15c9/T1SUpDB7nPnX8
         gTEViRWVHOTt0X91zdQu1cbjyphTiSbzpjQh94MjjEop8nSxGgSZIS67LE4yonXMK8xd
         MDQdTkZUJJTQfZrCq1wLZuGSZ1LHN/KaataNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935657; x=1753540457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJB64qIr1jI1unz5Cd2pxQc3wV9oq6+knIF/UbqEYPk=;
        b=Y0kay+AWLdRu3wW3549CQvdIYJILd9CqBMEYjtvW25uL9y75X/aeCsGKGa2yBFZg2+
         +6KByZ7hrPcv4dTI7iGgBih16MDa579iUsEwGuM7HTQ5HDKdxbPUg5dugZkJWoEqMHG7
         9DLIK+thgiUXEnolk3ttXkrHHWsz9c7Fgn4ABsrhFyN1dujUXnUBt+Y8fF5CNZgd3Eda
         0lwPRBmRUojpnmMb9JlV4/KgJwABcExGNEvpG/yIwtDQ4/fFx1UjRPWv99RKIUqrU1RH
         qmjvkaqZZvJjqpwJqBCGINvsD/3hzialU17hiliMt3vsisH7fK32aOZWmTrJkjevPNQB
         X9zA==
X-Forwarded-Encrypted: i=1; AJvYcCWLp7vB8cqQk/jOdXMM/Z7WQ/dZdyrUgrD+sTib5VvWAgIdHAMK7zZqocIFEQHwpqY/M+lFyvDaCJuzEY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkE3H31VPCr761SPrmi3Q9a8Zk6IPkslu62/sIp98ztUjH6Mf
	O55WtuFzPPYugNEDGA1/G5MYpexJ72xC2xfkOJk8WfZ2lcKz7VITydsvmzNeuwVtwUk=
X-Gm-Gg: ASbGncscBKFfERkD8eepa/mRLDEnXg5UXt+8+taqZScfRerpGSG73g5nUtL3Rmumsso
	hpfLPMsh38vCCGs5Z7trbgCi3rp9g6xkp8GxA29WMI7rBGpdnsWSUAHx7IZLZmyfYapupHAHeM4
	UcpqFJzfIYKZebOzcS/vJymII1Q7U4SlNHuOVwmV3fMV1DbugSNOaBsAC3bmxAN1nnRmDtY2Hm0
	VwXAfc1PZFQVekHc2DzORksspd6QdnyCWZMFMBHKNeZa+PqwVXIW3+VmQH5rC9tA8F6nh3djEEh
	ZcpRF0kMdAB3EZ1XOwjqJB8likPlMRgkwKBVLrl9mrGbXtny02aT7Em+t/ZnBta4/ARhqS79zwO
	m9gqpdwFZns4vlSBve6PkEHpXUAqv4//IVUj3XPkeROB6P/6zVXcfPz6yPx8=
X-Google-Smtp-Source: AGHT+IEHwNE8IADSH4GO3pbWUP0SVea1fLKYm82T+O7m/zHFp+l1HBmhBGrJcNYJqAEcFH8nEvTaHw==
X-Received: by 2002:a17:903:19eb:b0:221:751f:cfbe with SMTP id d9443c01a7336-23e2f73fea7mr182817445ad.19.1752935657000;
        Sat, 19 Jul 2025 07:34:17 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm30017525ad.23.2025.07.19.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:34:16 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 3/4] rust: miscdevice: add uring_cmd() for MiscDevice trait
Date: Sat, 19 Jul 2025 14:33:57 +0000
Message-ID: <20250719143358.22363-4-sidong.yang@furiosa.ai>
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

This patch adds uring_cmd() function for MiscDevice trait and its
callback implementation. It uses IoUringCmd that io_uring_cmd rust
abstraction.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/kernel/miscdevice.rs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 288f40e79906..5255faf27934 100644
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
@@ -175,6 +176,15 @@ fn show_fdinfo(
     ) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
+
+    fn uring_cmd(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _io_uring_cmd: &IoUringCmd,
+        issue_flags: u32,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// A vtable for the file operations of a Rust miscdevice.
@@ -332,6 +342,25 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         T::show_fdinfo(device, m, file);
     }
 
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
+        // SAFETY: Ioctl calls can borrow the private data of the file.
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+
+        match T::uring_cmd(device, file, ioucmd, issue_flags) {
+            Ok(ret) => ret as ffi::c_int,
+            Err(err) => err.to_errno() as ffi::c_int,
+        }
+    }
+
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
@@ -354,6 +383,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
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


