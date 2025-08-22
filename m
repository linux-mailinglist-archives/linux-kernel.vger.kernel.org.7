Return-Path: <linux-kernel+bounces-781404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9244B31216
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBAF56812D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A72ED147;
	Fri, 22 Aug 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlNMgTLq"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69472ED845
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852178; cv=none; b=AJJrH/klaSfu4Z1LRe+CryRjXjK7v36KctEUwXPA4Ec3Ojpz3tK5+QwG9I0wcasRPFOQST1nvtqzccWpWRUW0zhPyX2QrlHiW2QhAzHF0f38H+ya3Xg4BLYzPa7MlC/oy/nPV1PP1YFM3hhA29AC0QXBDMeLLPoPO6QC2VJn38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852178; c=relaxed/simple;
	bh=rB/mZF8xBrMCzSbeYYPQ0DaqjXVp8y/1e3Ssslw3iIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0yXlIPRa4sJdCY28Dhtj/EAB8o1p/hGKQTmLZ3nRXrrtFs2fvpxOZhQeBdIFfQImkmJEN3efrvRh8+nzvAIO4nbZyEqCxqVzdkKinAw6y5gjqOafE/zip4YsNfZ8P+el+JXz3baEGn7YDfRoimTbCoqF6ssY+BG6+fnLTHbDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlNMgTLq; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3c68ee43c76so75972f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852175; x=1756456975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/u4XDf1WVNqmU+JT0FI8dpt88Rxm4l0HCKQQVKeyjc=;
        b=HlNMgTLqL5Z8G2mmlmwDCkK9KBRyXjStXsfOA81JQVHsuXnNiXFOilnINQr2rZe8hz
         UqT0d73lzb0L5AjenW2SzNsScJtfylK7YlCUoKc0FlqIpl1c8rerRcvqr7IELurE8tLx
         YGMbhhy1FI3YxRbqElX6eFcvefbd3enwsM+K1TZr9u0ubPUSIAF6qLk+mk4Ij3cWto+a
         QHLQkk6T6O3rGlYCJakB2ydG+IiHofAYWYAu3QG9bcE5F4uPd2eDJLsDoJK2hXXA0WGU
         MVzTVNjo1GN2PtLuomY3iVg4UDOWKubiuejn+QUr15hQ3kJogJEP/ACSQU8o/YO61kQP
         waeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852175; x=1756456975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/u4XDf1WVNqmU+JT0FI8dpt88Rxm4l0HCKQQVKeyjc=;
        b=vkNH5utEoE2Ged/vJrkGiqSxHZmxBcy5k+62Ac813LvNaoa/tqMVHwo3N2dip8NYDz
         9HKaRBaj0/e4sCS+cZsQUjwUtDbV5J+IGx4IZd1ldT7wDql2mgMjj3yWEMpENJ7Q+KWH
         c9Ujsr62jTwBmC7TMcVyc2Yz4TriHye9SJQ81NcoBDFuMd+l649D5oVGDBJw60YkH8vV
         P/D+ywxT8PTfNiY5b2KbQJosCjWMDcAxD3wtYryVnMYgAaJ2eswark9prZ8T0wnbCRaH
         2Emexa91F79sTnwuSEcxlTy9WqVhogt4po833jX1kVJNP+/MvRHWYX9EJOGs3wqx/AQu
         v6SA==
X-Forwarded-Encrypted: i=1; AJvYcCUozsGBDEpNbkbvunqRleE6Tw4IMPLo9/f8SRL+bXsNUpFx742m/tDcnuOuuhole7SQUdD2IySM9KQXetw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEFDSzYJQ46B+7bTXUm4a4UeOl6wyEC3f3fndtKEcbYaRYiaG
	Z92uOcwAA1xVqyMLAbKNhoSwTUcsY8DRFD1dQNKxz6qxkwMlQcTH0huNrK0WfYkg+oU+C/Wg5nA
	ifD5/6ph4N8oNMX8JpA==
X-Google-Smtp-Source: AGHT+IFsvYdHV4/lLRj0b7l8g/4es08yFobDgfpUGx3RVdmcuZme238QYK2UJaceJcGeVU7iLpwV8UZBNenTMvo=
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:459:db77:fc89])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2485:b0:3b7:664a:8416 with SMTP id ffacd0b85a97d-3c5dae06637mr1497131f8f.23.1755852174560;
 Fri, 22 Aug 2025 01:42:54 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:36 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bBziUhAZe2zo8uvOtUQGB4HG8Cb4inbaTy33bNyXEno=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2GKQ0nWwuudCr7dtkC0pIcAouFTgw+Q0UhT
 L0+6NKp0XqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgthgAKCRAEWL7uWMY5
 RqF6D/95Phco70OrE20deLCWG0QdG/eE5+5DqPpoBcT+MJq3+9eOOi4AARuy+Cic2AEwQxy2I4Y
 Xts0hr+n8ywXlGL5VNdWQ0CcHYyu3GZQsHZ9jYav1NGxUSiPSey9c4CFOMYGXXLL3I9ZNMj89jn
 CJPsl4w8nNaVgTiELlk90Jv/LCIg6XVCNUl5pvzRQbm3wpMlDheeo4xAGpXuLK5tM2J4C4Sotqz
 N7bZNG/QPWooMk25aGm7V1gYkeAEVrHy4tzXmsPaQesB9a8UGp0sgaiUf0b+NTqhM6k3fX/G17g
 vZqmtEgi9nzO2+v2oBatMrDlwbtXpZg5Vqs7rv2l9yMMbe9XwjPR4I/IIUVSrVZWnVZcBeK3cIg
 PkgUTXqPFM2njh1sNUKnUS6TA6cjWBdnQQDs8rmo4FKcZ6n6LhMnu8Lqy/CcxMZ8m6ZNXAQDpls
 JPO/28dOrkJLNeG76JnIKPRtumnC/oMbjsBe3sRSlY6ycw8XBo8m/XYGCaAYAsGb2y8auRPH6s0
 /aEdeYeeXxPJb1/PVS6zTaBtpAKwxbKJlw1y2j7l/hj5YfU0FqYvY25xSZ1Ni1jEaVMtcN2UgBS
 m4wguwcAqSpBOrARfDb8DtsBsSl36cfz5qw2iv5bqkw4gR6J1RGveIEW87ST/NYTrFtkfLC6pxl 5ESxG4XpnZ2Dh0Q==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-5-6ce4819c2977@google.com>
Subject: [PATCH v5 5/5] samples: rust_misc_device: Expand the sample to
 support read()ing from userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


