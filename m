Return-Path: <linux-kernel+bounces-781403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017DB31214
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5736DAC801B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3232EDD73;
	Fri, 22 Aug 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3XocRdy"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF92ECEBE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852177; cv=none; b=dXvabPdrJFLYD0WYZ4wX96ZmL3F1eoo1Xu3yuWvBDW6oShRr3wz4g0qt877kyl9RGDRIAw9ncDZWC+NoG9PkF7jSz7o/hAu5FDN7p7OxkM+VaRy2pMXkWGgGY9u14ihila6ZFnGunu+B92tOF8hpW2LOCrU4Zusw6oah7PPszn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852177; c=relaxed/simple;
	bh=cBnYlOvskfx5sm6Y4IKbX2kYZoyJZJkrtZoMqj5Kt9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uXv0e1IH7+akMtwhroYadOIrxldiknHmS2wJghaG5fizbIaHt6bt/Z45xs9qVI2bs/qyuQQHmB96OsmfOhUq6oLRFzh3CCCAAT8pgyDeN5GSB+axib/wB8G8Q04t72TRGkFXO6sm2qSdeUgB9n1JXBtYUg1es3yBFIItzIN/cM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3XocRdy; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb7a4132eso134539666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852173; x=1756456973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLgm1xonn2W8CnafnexlfU+hOmm/BVh9s7sKWTQeHB0=;
        b=d3XocRdyfysA142wqX+x4RzOQNCCAvBxDhACULcY3JryRCb6Fs0ZmeERgWRCvCuYNf
         2kQZ8ubY2dBaP/ZtzNXOr3QdbSoISG7i3kc3RbvHvl84ID3ONId1hLTtnxLFrNFARWBW
         vpARBOsaF4ZBiate3xzE8m7QZM8VbWvC3bGD9Te3TtA6t6xsstGS7VVZyTUe7Mr47JUv
         vu0itrx+ZlA0sO0kAFYohak3RG7qHhlRbjdh+9P319EujEIefo/wp0rjg4x+EWsQEldk
         Ru/HWpsHjuDgDlxHsIObZ2p6qFt6btqgP/Ugio7u9hqBJTsYOYp3sesOkRs2mVXSotl2
         qqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852173; x=1756456973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLgm1xonn2W8CnafnexlfU+hOmm/BVh9s7sKWTQeHB0=;
        b=uUY71p2R7JYxDOosFa5WHPQIogoYtBdKwL1USNmLVwemtYo8inX4qKKciXTIofYYT6
         XTsFvkCH6ZxMLccbBPvjOf/lElAHE0UH9AmWWlpWGuEKH+qQaoPQEZMLy6eouW2GdyyJ
         /loH1R6PcC1Ma5daGsV8eS490pqZtEG+JEmLCnSOABM5YQ0i8aXswaiX2bmsbkdpsBtC
         lTCSCd0CBQbLJQ102PToJymBGiec66x3ToVJLbJEjaCa9fP3VwLEu7UYrearC0YNag8s
         RRCvyDSJF2LS84HvfGiFb57fKkhN1OQQhXkfqAXqvgNdE0G67bJ3LUeAT1jWFhvT9nEu
         mizg==
X-Forwarded-Encrypted: i=1; AJvYcCXXOX+kN8Uiqf5TGV7RqcEcf8iLXcc0dDSvM3SViHC+3VDJRFREuXOeIWt5c7S091Eq3tbfkcuoZFppjb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcXvjQ61DFWtAbY2d/tOUXPkK8unK/0goE+W1Yfa/vGysqh3O
	zdHqhqhxz+ls70mwmD2tsOj+J3Sn/PTdU9WEHFz2Rk/wVwWtYmaKBw+qrGWYFFypjoLNNIMvQ2u
	PvS0BD+Wy87WuSBxB1Q==
X-Google-Smtp-Source: AGHT+IGiC9Ykz4abp/5AXBZeDzha8KmgpOY98sijHceaASfXiYptrI7RlujdHFTa8jXCsWPvXzoudFEja3KmhkM=
X-Received: from ejctq7.prod.google.com ([2002:a17:907:c507:b0:af9:2a5f:c194])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f17:b0:ad8:85df:865b with SMTP id a640c23a62f3a-afe290443fcmr188578566b.33.1755852173287;
 Fri, 22 Aug 2025 01:42:53 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:35 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4089; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=cBnYlOvskfx5sm6Y4IKbX2kYZoyJZJkrtZoMqj5Kt9I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2F43Y5g8DOun815uNXvdJQldub+TxdA26Ti
 Z1UU1EB/z6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgthQAKCRAEWL7uWMY5
 Rq2QEACoDE1bUPaRQCRZz8fPX5A/0CfEqNAo3Cd5E+dEODUDamxYbUnnhYuGxV+lChHpfJb2es+
 UD63WK+l+iidAoCPao57Dx1md35hCRKSVCWv1Tpxh5ITTBn87FKBS1qgpPnUW9hIpXOi+HLyKVW
 lEkdGtYNw9FO1jcEZ6YM30mGIcmdBGceCf5jTiur5Kt4k+FkU9Ig8gPsKmqdtNtvTPGnHrA1Xji
 ZFW4zJCnKt4VXUdynwZ0lRpudg/Q6ZVWrBppcp3YkZOa6OaezTvScAYKs+stTKk2zrhZpxMU39n
 aa+0N+oiyXuAtLCCZW9owpBq1KmKNviASSqxLO8B0SxzxxJEIp+DkyiJpYUuPIiOEt0MUZ1i3YQ
 n22JtGWLTau9VKXeqzEhpP2OImGS5A8aOhTIxzrEmR1xvuBY6moxYSi/XIhijmAGuwChpWGGEX7
 /goEjvuPfCIsaMUMI48w/TcEwC4i2UpbS3OUxGcYXBYexPVjlQVJNPEFZyOKo2TCQgOTkxxgxdJ
 fC/wm5/u6aFttwkZ1m4Ki9yb+I2nQhKjQERu6JNfB8qXzhExLkUbNEljwfco9K4EpqtUcbPvD97
 4adUhaE0HMJivOd9skc5zxWFovAXx7kppIWHPu/hfG+dCTDAz0O9DM/vdibZfpFBn4ypsWwbc04 S5deTcWMDKgBuHg==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-4-6ce4819c2977@google.com>
Subject: [PATCH v5 4/5] rust: miscdevice: Provide additional abstractions for
 iov_iter and kiocb structures
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

These will be used for the read_iter() and write_iter() callbacks, which
are now the preferred back-ends for when a user operates on a char device
with read() and write() respectively.

Co-developed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b2748162988b45d7ed8f563045d3b4d..35630fc638751c416d009fcf0c0ffdf0a4da1218 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -13,7 +13,8 @@
     device::Device,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
-    fs::File,
+    fs::{File, Kiocb},
+    iov::{IovIterDest, IovIterSource},
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
@@ -141,6 +142,16 @@ fn mmap(
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Read from this miscdevice.
+    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Write to this miscdevice.
+    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilities in [`kernel::ioctl`].
@@ -245,6 +256,46 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         0
     }
 
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn read_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        // SAFETY: The caller provides a valid `struct kiocb` associated with a
+        // `MiscDeviceRegistration<T>` file.
+        let kiocb = unsafe { Kiocb::from_raw(kiocb) };
+        // SAFETY: This is a valid `struct iov_iter` for writing.
+        let iov = unsafe { IovIterDest::from_raw(iter) };
+
+        match T::read_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn write_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        // SAFETY: The caller provides a valid `struct kiocb` associated with a
+        // `MiscDeviceRegistration<T>` file.
+        let kiocb = unsafe { Kiocb::from_raw(kiocb) };
+        // SAFETY: This is a valid `struct iov_iter` for reading.
+        let iov = unsafe { IovIterSource::from_raw(iter) };
+
+        match T::write_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -341,6 +392,16 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         open: Some(Self::open),
         release: Some(Self::release),
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
+        read_iter: if T::HAS_READ_ITER {
+            Some(Self::read_iter)
+        } else {
+            None
+        },
+        write_iter: if T::HAS_WRITE_ITER {
+            Some(Self::write_iter)
+        } else {
+            None
+        },
         unlocked_ioctl: if T::HAS_IOCTL {
             Some(Self::ioctl)
         } else {

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


