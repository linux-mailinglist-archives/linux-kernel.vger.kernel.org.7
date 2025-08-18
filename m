Return-Path: <linux-kernel+bounces-773772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0BEB2A98D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFEB1BA5329
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F07322A35;
	Mon, 18 Aug 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNQR1zH2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E97322A20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525591; cv=none; b=FT89PW5+rZ8+kl4O+pBHJjVip3SvEUZ+5FQ3Tb2plH/lIKlA+BVt42WXH1Bwf/0Pgc1MaRHKfZ6ySkzxx3ND4KlVqysDmE6QzCENY50aqoTVXN7kFAbh6492Wp4++sgDuaPYaeitLPMg0G58ZWbRRpA5otWWGeeZa1pKOm54yOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525591; c=relaxed/simple;
	bh=cgwwu95M0/PjQLKh9VcFW9sZO8JImGY2MFIZ04G52J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acaAXRsAMUwgEvU0kp7zcs2OPgqYlomQIubeVt7YnddDlSvWgW/Lkf1mTLmmvTVEQ+Zp1d6tp1GMSx3pFCvp4q+nHMDT7zIZmgIy2mXKk6ayh4kOz9392/UijCJmQzeIpjmZUEapFg6B7gXTZ86SR5+Whxvuc5+9SJ/mbKh7YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNQR1zH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755525588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2CKq6YUad3/DjmNn/azhMuZRDmF+l+ZwOAVkMKXPNs=;
	b=JNQR1zH28BjKjDGtsNSpqfZim77Z/vqEI1BhSkod+r30K2gqdEjnap55uCHcxN+E1A4ek6
	rVET9xWIl2SLhSHrP9dOoTjicmnd6RFJ5Ns616yrjeg2GiNWR0Qdj8AEwRLJeSUoVgvQYU
	/+r9Jaow5nKdus8tNQ68xm1Ecgf9Lr8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3eE1a3RkNJeILLsF9fWpBQ-1; Mon, 18 Aug 2025 09:59:46 -0400
X-MC-Unique: 3eE1a3RkNJeILLsF9fWpBQ-1
X-Mimecast-MFC-AGG-ID: 3eE1a3RkNJeILLsF9fWpBQ_1755525586
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so7984204a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525586; x=1756130386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2CKq6YUad3/DjmNn/azhMuZRDmF+l+ZwOAVkMKXPNs=;
        b=JSBXnIbHCCgSxgMRmauIA1lLPN/Yb44OQ2vqF9NQu9sQmcUMjgGuL2etPQYW0y5CkL
         5tajGxyurQPhgL9h2T/tSCWKyOZo1lh97M8Q9/9OAu4tLrC0PBMTEm7498FDwAbElNh5
         RQyEc6alrkWyi9qQT9UFP+cQdgxLcVrIfUa5TI8hcU00COS0Ye9pQFk6PxIoZRGR/D7w
         UQ76E5v9RSzistP0BHz4vTcxkALzSnvw5mftQPPQRylUf7eh0CuCZUv85cj7cu9gsfZ/
         Cf9AF/yV/OttfABMlxXS6Tv/q9hIdci1mMJydzYYoPnkjH14/6e9R4MXPx9/um1D6d4d
         qugg==
X-Forwarded-Encrypted: i=1; AJvYcCUcT2LNgmNj2dUS+iCwxP+L3MzMP7WhL1I+UqVrfi3VdJBsO6GmIVgW1T7TSPGsOlOHSc8OrlExV+GQn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHv14xpz2zvzYTOj3ZX4Mx8CXRkT/Hl4rj6uxy7Xzds7tVChuv
	nUesm29NCmXij545W9Qxj6yOfNIpGZq1WZ0iSU7WfwDj6mKhwwoBYr7TmWOS/lABQWT3Pwuth3m
	xIOIbdcHy8TB57ra/Ge68QRkQ17lI/Br4zTa6AS0zy9EcdIennbFJoc37IJPk3dPbEQ==
X-Gm-Gg: ASbGncsKRfoYrb5TtG/fdqDsC56wqVj72n0PEmdzUJYH637is/nXV1O01qYuhNQjaUY
	fV5gcMk79xtzx9H3fgAJ4eLgw1YpmPaz+0NhcgUMUD+0sbRb1sEIAIZ8gVEf4we0cnZHzb3+3LB
	K4LLD7KknjMlBAwq8REAuSlHHRINPMNAYYlH26NkDZcRNYr45Qo1BS55XSSl+T0MejLcho6PhCK
	6n0ucJ57NuRMS1yOBC8Odqve7+n6dJPxRJDXMsHEBJTp4WZ8PfJ5z1aeyyliLcVVncuFf7/Heh8
	oGUox9mf5g6cbKzHBN/1q854OcV4Cs76Nw==
X-Received: by 2002:a05:6a20:939f:b0:240:a53:79fc with SMTP id adf61e73a8af0-240d2fb95ffmr17025513637.29.1755525585642;
        Mon, 18 Aug 2025 06:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELiXPnW7YPO4rEF/tv+C6PkkDunFLclnjtOiZ6LrUtYCR63sCROrCmDGY+0H8Di4y4hwCxWg==
X-Received: by 2002:a05:6a20:939f:b0:240:a53:79fc with SMTP id adf61e73a8af0-240d2fb95ffmr17025476637.29.1755525585240;
        Mon, 18 Aug 2025 06:59:45 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d60978fsm8269896a12.26.2025.08.18.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:59:44 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lee@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
Date: Mon, 18 Aug 2025 22:58:38 +0900
Message-ID: <20250818135846.133722-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818135846.133722-1-ryasuoka@redhat.com>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to write a file_operations->llseek hook in Rust when
using the miscdevice abstraction.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..597e7b66e493 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -125,6 +125,16 @@ fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
+    /// Handler for llseek.
+    fn llseek(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _offset: i64,
+        _whence: i32,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handle for mmap.
     ///
     /// This function is invoked when a user space process invokes the `mmap` system call on
@@ -245,6 +255,27 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         0
     }
 
+    /// # Safety
+    ///
+    /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+    unsafe extern "C" fn llseek(file: *mut bindings::file, offset: i64, whence: c_int) -> i64 {
+        // SAFETY: The llseek call of a file can access the private data.
+        let private = unsafe { (*file).private_data };
+        // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in `open` and
+        // `from_foreign` in `release`, and `fops_llseek` is guaranteed to be called between those
+        // two operations.
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        // SAFETY:
+        // * The file is valid for the duration of this call.
+        // * There is no active fdget_pos region on the file on this thread.
+        let file = unsafe { File::from_raw_file(file) };
+
+        match T::llseek(device, file, offset, whence) {
+            Ok(res) => res as i64,
+            Err(err) => i64::from(err.to_errno()),
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -340,6 +371,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
+        llseek: if T::HAS_LLSEEK {
+            Some(Self::llseek)
+        } else {
+            None
+        },
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
         unlocked_ioctl: if T::HAS_IOCTL {
             Some(Self::ioctl)
-- 
2.50.1


