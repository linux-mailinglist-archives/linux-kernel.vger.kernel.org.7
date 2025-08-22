Return-Path: <linux-kernel+bounces-781925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61554B3189A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BEBB610D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB7308F17;
	Fri, 22 Aug 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="jhgwxhRh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F73074AE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867415; cv=none; b=pdgVT2Epd1OSbnlh3Wibc4et3sGW09pN0ybRktXxt6VaTNZAXB7AXRU7ugLwsyNXf9dSeZs8EMubHVcXwKu84bSU4kajIL/iq0/aZ0wfCrGWwywHn5qw02XygKYWIeZ5CzP24oWqlvCfCyWbXiPS4UaowqWHWUI0b7jYnkscwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867415; c=relaxed/simple;
	bh=jDvtrC5CYptCtxvl1U1Uu8QRkjqDfNI+DFDh7ZSPlf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw646oycG8Rd7dmN/TCqeol2SahGoOKxQacNnQ27mkDpc3ngqAptcvUXftXK87fylBEiN1Hy/9MMiHX7ZZ9RJ4XicZDQd5nViASctsMQuPejm5aT52gMnXBEUO+ZI3W6drRhIcHYVt2CbvXtaFCA6yXjyUdhtDbTBEjB6Mo0wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=jhgwxhRh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1951554b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867413; x=1756472213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXCktcs4uaU2hiRFJow79+DYdsVC7eWvfPeFta3o3tc=;
        b=jhgwxhRhJ50Lutz1dhkRQLf4/yEHXMm6f+B7VFIw1Rk6gldvVYPMYe57LHmaQwWg4b
         0vyZDhFUoT3nSVKLQTZRn9M/24iBgVNyrl0iJzgNj/tvcuK8rMLu4+ECv8IQH2xDcpUh
         qrTEWA70pmMjfbsRObwEwZhDhoJNBvHEeHG9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867413; x=1756472213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXCktcs4uaU2hiRFJow79+DYdsVC7eWvfPeFta3o3tc=;
        b=wG7l7iGFuBupyaBFWxHOObcMrhvQmu2Cj0xC7kgnfWYFV/lcHZwc4VkT45Qqu02W2W
         VJ4URFVPBWJi1qvrqcojiWC0bGsb6FyD0IWuE+MZITXVgm2Qb9a1RQD3LxyLpVEriL9A
         QHCHiMQ/qd/OPzfyOHv/82rxdDUCsJVuTNy1VJhl7aGvx9EPNnspYVInl6SLuIIh8gi/
         aax1qIOoU72+VtBkVMTIDxdYxGfYCosq2qWh8AmVuO51vxBMt/p2I0IHU0BRe/rE1VGt
         Y4dRT7zNpNURIwlusPwN2Ny/nttJ0i1kA9d2v2loa2jtPvBTZgEGcrE+i2KQJgUg3Im5
         /KWg==
X-Forwarded-Encrypted: i=1; AJvYcCVJPRvAEJ5RikvOm3END5U8MIxNpuKtrzSmPCDvWeDX42y2r2ppu+0Vb3TQbdu1iP+Y522kI3js3FlZQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9Nv3TqsCytFnfUBHGGKgR/2nErMwWIvcllMBBs2xuEffBEFS
	WLGIYNc6R5//axa8S0XidlbbEICe8sjTFGtd2UU6sa+mlMyfv/iyUq3LFCeVxyWArxM=
X-Gm-Gg: ASbGncv4MVqlVzl65Wm3maSqeeRWBsfH2aw9ps2bFETFj1Px/Xt3dd0OU49YanDqziq
	fPvumiQn/N7EJnQpWROphnRvoWQXt4j9Cdctnj2IuGWXoGj+Xc3o0pBgOn4Eran/vveovydTMCF
	b17lNEwK0QA6k8loCoWxXphnrCD/nA6kBT2rtoHUtqAoVyhSTmH1n6YWEmWGK7QDqb0k41Fbhv2
	i82FZkCLsF/4n314RjhUdmMNKzJ3tzYvGEVKiMaEiV8WVCzofj1QNQrK3SeJ791Pxs4KEzQiglX
	o47OTBuWXJkuSqZlZwOt/FVzH3GQZVx8wBZ5yKxieSFItcoFlOpPLX5pfMrPZF3TMxzyXguKBNY
	o9yhmP+XKlDQLFENiM2tXE+40hhFogiwMylXzq0QdaWHWaIDAZ5MLWDpdG9MnrjAOyC004Hde
X-Google-Smtp-Source: AGHT+IFGbkRU2SiqYXwwtNzw8KR7yGF/eBcv+rngOtyo7AEtcczOr+DJBGYp8ZsX+UVe04WKTVUGEQ==
X-Received: by 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr4973342637.14.1755867412700;
        Fri, 22 Aug 2025 05:56:52 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:52 -0700 (PDT)
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
Subject: [RFC PATCH v3 5/5] samples: rust: Add `uring_cmd` example to `rust_misc_device`
Date: Fri, 22 Aug 2025 12:55:55 +0000
Message-ID: <20250822125555.8620-6-sidong.yang@furiosa.ai>
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

This patch extends the `rust_misc_device` sample to demonstrate how to
use the `uring_cmd` interface for asynchronous device operations.

The new implementation handles two `uring_cmd` operations:

*   `RUST_MISC_DEV_URING_CMD_SET_VALUE`: Sets a value in the device.
*   `RUST_MISC_DEV_URING_CMD_GET_VALUE`: Gets a value from the device.

To use this new functionality, users can submit `IORING_OP_URING_CMD`
operations to the `rust_misc_device` character device.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 samples/rust/rust_misc_device.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..1f25d2b1f4d8 100644
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
@@ -192,6 +196,29 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result
 
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
+        let addr: usize = io_uring_cmd.sqe().cmd_data()?;
+        let user_ptr = UserPtr::from_addr(addr);
+        let user_slice = UserSlice::new(user_ptr, 8);
+
+        match cmd {
+            RUST_MISC_DEV_URING_CMD_SET_VALUE => me.set_value(user_slice.reader())?,
+            RUST_MISC_DEV_URING_CMD_GET_VALUE => me.get_value(user_slice.writer())?,
+            _ => {
+                dev_err!(me.dev, "-> uring_cmd not recognised: {}\n", cmd);
+                return Err(ENOTTY);
+            }
+        };
+        Ok(0)
+    }
 }
 
 #[pinned_drop]
-- 
2.43.0


