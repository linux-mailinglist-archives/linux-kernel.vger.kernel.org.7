Return-Path: <linux-kernel+bounces-747125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8AB13008
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5019A178E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436A21FF57;
	Sun, 27 Jul 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="ir2XY/E5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9B21D583
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628677; cv=none; b=NYLLgf8ltARApOAcZcgri3biRiMXBgD6xyDApzXVvP3WJRsTY0WxqlQ0uZA5g3Em3pD7upv+52VOyxGKcLgd0+klpg7mugp5SvkSBp0nsvXmML+ckU7gEldcg1dB/Zo/sFmWc4lSuwp1YizT1+FCxF3+CBvZou09QbJ7CYjyZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628677; c=relaxed/simple;
	bh=jNgn+CIvun+R8VfNUxSXEoyphazpmnbHYWrUF62SfyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv+OBfd+6i+hN/Bd1PNkGsLe7cy0yn1vwKnU/yRxbBTg287UA/bUb38LVSGd9Ids0N1UbGWXXYNFeR5W7uqTLqdn8rHqtDAxcS/GXXn1fQFhlpeNU1LVxAXPPFKAd8hTcG8y7e1bqwAGWO3JAmkEzZ6qammzzLpSlyECn24LA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=ir2XY/E5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23aeac7d77aso33109995ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753628676; x=1754233476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeNP/PP8zrdwI/UScK/RcuZJZ4ARpjDlW5AwHswNcR4=;
        b=ir2XY/E5gcnilqBBkpD/V/9/SfBhZ7t9ruUs6al5TzEx9aAlEQVjHbnT7fZMytQ3B7
         ThmxRCNLpXgdlsxhk3Lv2VBKvY9YL0bD40MMMOh2YDgEPrQ0/TsJIiOpiF7H1aEVSXnQ
         tTnl/W6Ite76U7giSmcpHIo5y2CdiWO8cA6pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753628676; x=1754233476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeNP/PP8zrdwI/UScK/RcuZJZ4ARpjDlW5AwHswNcR4=;
        b=TAzWHt09B5DIMJQD7811kWn8KoZpuqpTozspL8YHY3ezMihtos87JqxIS8FX8arXHJ
         nA/YivK89kckFhorQI+Czl5i6Gs5nc0Lis2g0qarNQedrhUKYwJI6xSdilbtrfbb1872
         uzTc8gPAL8iW7yx4NsEFlV8OmijL5w1OgDCaAD1hBBvCOcW9OUhTErVcZfaZQbuG7KuT
         oSHTfoVYZJrckM2Zewcap4xKf0FGeNRVac+XbKGeQ7bRRI/4A/Sx1Q4/L9fPsB8snG6b
         Z1C/JiCiF5RVYRiceXe/SKKz8xMsvmNVE+NNacKTLiKT18LvIzu3BHv9eDKlsNRKW5y6
         Ob3w==
X-Forwarded-Encrypted: i=1; AJvYcCWXONubsGO4cIiqWC/b7smBw7H3PdzEWmhbzSKhXIgBJsnlAz4JuDhKVwPzGmQEGpvqhMSsT8hcZL4LQrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC97gJI0rCXYtND1narJgRnVyWPLeJoPsYLWE6OUyhs+0jQQhS
	rkYit+0FzCr+6tuA8LWW/v3r+uh0Nhpb3vIzqCfOc92xgbd4jFJ497dmFUN6KLzaweo=
X-Gm-Gg: ASbGnctFYbOvHjNoUjfzaBwvIREsyawtqBALmFf7sDi37euZkfU2FSeIwpTugmt2W5L
	C+fx4nSWl2cDfFVvaRTSSR5CGRe4z5FRg5X8BaKCXvxBREIYFFvKA9kKpz/X2P110/9/vViQ573
	PBVQMPRZq5cif88bPQZazNLK7hpCsHsgbQ7GgZZrBkfpaveIJPx41DeJAytnKJCl4R5sh3xWcQi
	yIXu/bFMeP5T/lhbU97oHFnPtdBx/L2tKwnni6OWHMOjMdVe5pBEdgyIYDGf0DdcmWpkXX9LEN2
	/XmDLKsRBuJ55sLYIz+rwzdeg3IMsU3Ia0VadyOX/0vGgvfQAD3Yx5stcXLPv72K0wlz5OWF+Cf
	ESyuXSszi7WImuIC6F5ztghRjde//j5t6yhKyeBhIRE61vGEJvfYVQwDVxF9Iug==
X-Google-Smtp-Source: AGHT+IEcwUGTvIwSkq572UO1/rKsozpV5VbkWfGTO1wB9NAisfgejoLG5RhSTngcNuD/suDu9l8M6g==
X-Received: by 2002:a17:903:3c4d:b0:234:c8f6:1afb with SMTP id d9443c01a7336-23fb2ee8a67mr118373005ad.0.1753628675847;
        Sun, 27 Jul 2025 08:04:35 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdec96aesm15381965ad.165.2025.07.27.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:04:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/4] samples: rust: rust_misc_device: add uring_cmd example
Date: Sun, 27 Jul 2025 15:03:29 +0000
Message-ID: <20250727150329.27433-5-sidong.yang@furiosa.ai>
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

This patch makes rust_misc_device handle uring_cmd. Command ops are like
ioctl that set or get values in simple way.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 samples/rust/rust_misc_device.rs | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index c881fd6dbd08..1044bde86e8d 100644
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
 
+const RUST_MISC_DEV_URING_CMD_SET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x83);
+const RUST_MISC_DEV_URING_CMD_GET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x84);
+
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
@@ -190,6 +194,36 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result
 
         Ok(0)
     }
+
+    fn uring_cmd(
+        me: Pin<&RustMiscDevice>,
+        io_uring_cmd: Pin<&mut IoUringCmd>,
+        _issue_flags: u32,
+    ) -> Result<i32> {
+        dev_info!(me.dev, "UringCmd Rust Misc Device Sample\n");
+
+        let cmd = io_uring_cmd.cmd_op();
+        let cmd_data = io_uring_cmd.sqe().cmd_data().as_ptr() as *const usize;
+
+        // SAFETY: `cmd_data` is guaranteed to be a valid pointer to the command data
+        // within the SQE structure.
+        // FIXME: switch to read_once() when it's available.
+        let addr = unsafe { core::ptr::read_volatile(cmd_data) };
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


