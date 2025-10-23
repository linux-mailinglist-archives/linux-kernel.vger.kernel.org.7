Return-Path: <linux-kernel+bounces-867757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5267C03722
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C2B5041C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8226F29F;
	Thu, 23 Oct 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxTeEZwL"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A850238159
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252718; cv=none; b=JMYAteKUneiUB8lF4iB+0WQDG9GP+y09TTZ9iBuUpiCT6NvwEnidiG0X9fWnHtYZQJqWf/3x15HednRk1Y9/Xld7LiWEcgM4i/UfJ15KewGZ4jm0l6fNZM4/JntMf6Ns2oDeAS1syKhWSa91tAsCxd/K0ImqjsaKe6cuRcbYnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252718; c=relaxed/simple;
	bh=O18x3Adf1I2GW7QMsvbxZRfOrktiDauNKtc7QS4D6Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUXW5CAaipljMUkPNs4YajatkoXsLkrgPgDFhJFWmQSlvwJh3XRd51T6ThvipzhbYqJvm2WzcV7cEgpam5pydH0ZjFB1o2AqLBAz7Qk4ZBSasVt+ifRjwZDBipnJRcy6e6bUG0fpprsNQQm5IY2E2DZFj2i7kj9AbwT50yiEo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxTeEZwL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso2360377a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252714; x=1761857514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DPBx+VpLdJYC28+zIXvWQItkrfqNP0uWnOQyMoNV9I=;
        b=QxTeEZwL7c367dtx41P+LE0BW4B8wbXT5dfLehf2TW4cwWLlGNBCStS5QQI/uircv9
         GpQ+PPiaYW8c2EGHf4Z/ElDEOSYLP3T0UVmUGRR9REqd3Q0fOcMs8z8qInLH3Tl1iPii
         85261w1cdeqVWlSa6nqMcWpH6zPMPVa6Bw1X3iMZuo/3+P5A4yS+VBAwtt+65YaFFZ+4
         +43orpY9JH3g0EV9pV4QVzGIF6SCfeFrG/RTYn08A8JQ2emQ5wNU27ymj1idTVWqIOAr
         PqN9kMjWuNvCmbbBl7WHSYJv+fYz0lIxYv5+qXA6TzuogDCXoX5tH5AVkAMKhBBzmzJz
         jNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252714; x=1761857514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DPBx+VpLdJYC28+zIXvWQItkrfqNP0uWnOQyMoNV9I=;
        b=Aa5bPHs50RBgr/Tsdr1l4b/yxo6x9HKGjk4jXFj/exu8DJerA3AXwm0KPh3wqCruVe
         98M5tX0heA8iHYZ7MxwWcKj2BEnxd30dLzvHgIqhNmYxNXOss4XAeGWz+Jutg9IDLipa
         gxv95DY9t/+NxVaWJEL1+VORmrDLHzY4XBfvBaxtAEQ4PZGJQIVqPLGxfA7626zAvlDr
         Vsj+KPHkPo+pzSHV6rQWDrvpSmTzCy+BeMIiloPHMlj4qPUwAEMkZra0GbiECsn4C4d8
         qfKWsmywes6LydoQgSW2U4WGgaYLmGWGtGACMCp78BKt/TsjGuodOBqyhnT07ho0T1TE
         gncg==
X-Forwarded-Encrypted: i=1; AJvYcCX57+iLwlLBidTcRL81kyReCkp+Kxp86UBm0IYoq4ZmZdbvzTVPCdUYKeh+jsmSgSwvn9JeozZGnBJCQqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXr29ZMMrMyZA2BBc/usBWSdfIwOzBf9j8wz6psZlfmEZZ5+D
	uOgtnOkvSdPk4aBl9pCICwmQNS83uQBmyX6lXsYlWsg+ZDH84CYfxct4
X-Gm-Gg: ASbGncv44ujjcMT7KPd9JWDYP3UBjWli0hokHc7yznTnpuFWZQ92T43vxUdH9O2t4O0
	YDOno2Fwacz84GN80cFaNg0GxyOQWytiR6fs4LBKdXYaUcjxJbuN67fPXD0WFZ0l9MMbBAyCtND
	lxmnmJ8sRO4i1Eb1Z57Nk7fEGeKI3AlSdjUrLu76kkACLh9IOAbX4mn1pbTsAYKdcY61/8ZehFn
	6DlsmHfdXOfYl8sFc2TCEtxP6GSpVdRvKqcmN7N81FLCj79TfAeHJ4eznENTVxQ052oEI6MWHNc
	Ktn91cueSWjJtyfsiyTXZLatlt53gqaVj81AoHFPe04FrCzKpUFXRMDpYuozgoRcYBJdRaSxAmj
	e+Gc6bgl7v2mK1DAyKG24oo1JZzLEWWAM//fP2v83/gogH3Osdki7ghHUWGjX9Y52Gh3aFLOnV9
	7zYKujMgTNPEp29s/3Pg==
X-Google-Smtp-Source: AGHT+IElvfU33Lmr81xAhhsBvHVkVfrWPuYa9W4pML5y67Llk+0+RGk0cOgxbDzkB4XKg1UV2rHjTQ==
X-Received: by 2002:a05:6402:51d1:b0:634:b4cb:c892 with SMTP id 4fb4d7f45d1cf-63e600995c8mr72861a12.32.1761252714148;
        Thu, 23 Oct 2025 13:51:54 -0700 (PDT)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3299sm2564120a12.2.2025.10.23.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:51:53 -0700 (PDT)
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Subject: [PATCH v2 1/3] nova-core: Simplify `transmute` and `transmute_mut` in fwsec.rs
Date: Thu, 23 Oct 2025 22:51:35 +0200
Message-ID: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch solves one of the existing mentions of COHA, a task
in the Nova task list about improving the `CoherentAllocation` API.
It uses the new `from_bytes` method from the `FromBytes` trait as
well as the `as_slice` and `as_slice_mut` methods from
`CoherentAllocation`.

Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>

---

I confirmed by talking to Alexandre Courbot, that the reading/writing
methods in `CoherentAllocation` can never be safe, so
this patch doesn't actually change `CoherentAllocation`, but rather
tries to solve one of the existing references to [COHA].

V1 -> V2: Split previous patch into two. One per reference to COHA.
          Improved comments. Let me know if they are okay now.
          Use of `{...}` syntax for the `if let`

 drivers/gpu/nova-core/firmware/fwsec.rs | 129 +++++++++++-------------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 8edbb5c0572c..507ef3868565 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -11,12 +11,12 @@
 //! - The ucode signature, so the GSP falcon can run FWSEC in HS mode.
 
 use core::marker::PhantomData;
-use core::mem::{align_of, size_of};
+use core::mem::size_of;
 use core::ops::Deref;
 
 use kernel::device::{self, Device};
 use kernel::prelude::*;
-use kernel::transmute::FromBytes;
+use kernel::transmute::{AsBytes, FromBytes};
 
 use crate::dma::DmaObject;
 use crate::driver::Bar0;
@@ -35,7 +35,7 @@ struct FalconAppifHdrV1 {
     entry_size: u8,
     entry_count: u8,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifHdrV1 {}
 
 #[repr(C, packed)]
@@ -44,7 +44,7 @@ struct FalconAppifV1 {
     id: u32,
     dmem_base: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifV1 {}
 
 #[derive(Debug)]
@@ -68,8 +68,10 @@ struct FalconAppifDmemmapperV3 {
     ucode_cmd_mask1: u32,
     multi_tgt_tbl: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifDmemmapperV3 {}
+// SAFETY: This struct doesn't contain unitialized bytes and doesn't have interior mutability.
+unsafe impl AsBytes for FalconAppifDmemmapperV3 {}
 
 #[derive(Debug)]
 #[repr(C, packed)]
@@ -80,8 +82,10 @@ struct ReadVbios {
     size: u32,
     flags: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for ReadVbios {}
+// SAFETY: This struct doesn't contain unitialized bytes and doesn't have interior mutability.
+unsafe impl AsBytes for ReadVbios {}
 
 #[derive(Debug)]
 #[repr(C, packed)]
@@ -92,8 +96,10 @@ struct FrtsRegion {
     size: u32,
     ftype: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FrtsRegion {}
+// SAFETY: This struct doesn't contain unitialized bytes and doesn't have interior mutability.
+unsafe impl AsBytes for FrtsRegion {}
 
 const NVFW_FRTS_CMD_REGION_TYPE_FB: u32 = 2;
 
@@ -102,8 +108,10 @@ struct FrtsCmd {
     read_vbios: ReadVbios,
     frts_region: FrtsRegion,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FrtsCmd {}
+// SAFETY: This struct doesn't contain unitialized bytes and doesn't have interior mutability.
+unsafe impl AsBytes for FrtsCmd {}
 
 const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS: u32 = 0x15;
 const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB: u32 = 0x19;
@@ -147,26 +155,15 @@ impl FirmwareSignature<FwsecFirmware> for Bcrt30Rsa3kSignature {}
 ///
 /// # Safety
 ///
-/// Callers must ensure that the region of memory returned is not written for as long as the
-/// returned reference is alive.
-///
-/// TODO[TRSM][COHA]: Remove this and `transmute_mut` once `CoherentAllocation::as_slice` is
-/// available and we have a way to transmute objects implementing FromBytes, e.g.:
-/// https://lore.kernel.org/lkml/20250330234039.29814-1-christiansantoslima21@gmail.com/
-unsafe fn transmute<'a, 'b, T: Sized + FromBytes>(
-    fw: &'a DmaObject,
-    offset: usize,
-) -> Result<&'b T> {
-    if offset + size_of::<T>() > fw.size() {
-        return Err(EINVAL);
-    }
-    if (fw.start_ptr() as usize + offset) % align_of::<T>() != 0 {
-        return Err(EINVAL);
-    }
-
-    // SAFETY: we have checked that the pointer is properly aligned that its pointed memory is
-    // large enough the contains an instance of `T`, which implements `FromBytes`.
-    Ok(unsafe { &*(fw.start_ptr().add(offset).cast::<T>()) })
+/// * Callers must ensure that the device does not read/write to/from memory while the returned
+///   reference is live.
+/// * Callers must ensure that this call does not race with a write to the same region while
+///   the returned reference is live.
+unsafe fn transmute<T: Sized + FromBytes>(fw: &DmaObject, offset: usize) -> Result<&T> {
+    // SAFETY: The safety requirements of the function guarantee the device won't read
+    // or write to memory while the reference is alive and that this call won't race
+    // with writes to the same memory region.
+    T::from_bytes(unsafe { fw.as_slice(offset, size_of::<T>())? }).ok_or(EINVAL)
 }
 
 /// Reinterpret the area starting from `offset` in `fw` as a mutable instance of `T` (which must
@@ -174,22 +171,18 @@ unsafe fn transmute<'a, 'b, T: Sized + FromBytes>(
 ///
 /// # Safety
 ///
-/// Callers must ensure that the region of memory returned is not read or written for as long as
-/// the returned reference is alive.
-unsafe fn transmute_mut<'a, 'b, T: Sized + FromBytes>(
-    fw: &'a mut DmaObject,
+/// * Callers must ensure that the device does not read/write to/from memory while the returned
+///   slice is live.
+/// * Callers must ensure that this call does not race with a read or write to the same region
+///   while the returned slice is live.
+unsafe fn transmute_mut<T: Sized + FromBytes + AsBytes>(
+    fw: &mut DmaObject,
     offset: usize,
-) -> Result<&'b mut T> {
-    if offset + size_of::<T>() > fw.size() {
-        return Err(EINVAL);
-    }
-    if (fw.start_ptr_mut() as usize + offset) % align_of::<T>() != 0 {
-        return Err(EINVAL);
-    }
-
-    // SAFETY: we have checked that the pointer is properly aligned that its pointed memory is
-    // large enough the contains an instance of `T`, which implements `FromBytes`.
-    Ok(unsafe { &mut *(fw.start_ptr_mut().add(offset).cast::<T>()) })
+) -> Result<&mut T> {
+    // SAFETY: The safety requirements of the function guarantee the device won't read
+    // or write to memory while the reference is alive and that this call won't race
+    // with writes or reads to the same memory region.
+    T::from_bytes_mut(unsafe { fw.as_slice_mut(offset, size_of::<T>())? }).ok_or(EINVAL)
 }
 
 /// The FWSEC microcode, extracted from the BIOS and to be run on the GSP falcon.
@@ -260,32 +253,35 @@ fn new_fwsec(dev: &Device<device::Bound>, bios: &Vbios, cmd: FwsecCommand) -> Re
 
         // Find the DMEM mapper section in the firmware.
         for i in 0..hdr.entry_count as usize {
-            let app: &FalconAppifV1 =
             // SAFETY: we have exclusive access to `dma_object`.
-            unsafe {
+            let app: &FalconAppifV1 = unsafe {
                 transmute(
                     &dma_object,
-                    hdr_offset + hdr.header_size as usize + i * hdr.entry_size as usize
+                    hdr_offset + hdr.header_size as usize + i * hdr.entry_size as usize,
                 )
             }?;
 
             if app.id != NVFW_FALCON_APPIF_ID_DMEMMAPPER {
                 continue;
             }
+            let dmem_base = app.dmem_base;
 
             // SAFETY: we have exclusive access to `dma_object`.
             let dmem_mapper: &mut FalconAppifDmemmapperV3 = unsafe {
-                transmute_mut(
-                    &mut dma_object,
-                    (desc.imem_load_size + app.dmem_base) as usize,
-                )
+                transmute_mut(&mut dma_object, (desc.imem_load_size + dmem_base) as usize)
             }?;
 
+            dmem_mapper.init_cmd = match cmd {
+                FwsecCommand::Frts { .. } => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS,
+                FwsecCommand::Sb => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB,
+            };
+            let cmd_in_buffer_offset = dmem_mapper.cmd_in_buffer_offset;
+
             // SAFETY: we have exclusive access to `dma_object`.
             let frts_cmd: &mut FrtsCmd = unsafe {
                 transmute_mut(
                     &mut dma_object,
-                    (desc.imem_load_size + dmem_mapper.cmd_in_buffer_offset) as usize,
+                    (desc.imem_load_size + cmd_in_buffer_offset) as usize,
                 )
             }?;
 
@@ -296,24 +292,19 @@ fn new_fwsec(dev: &Device<device::Bound>, bios: &Vbios, cmd: FwsecCommand) -> Re
                 size: 0,
                 flags: 2,
             };
-
-            dmem_mapper.init_cmd = match cmd {
-                FwsecCommand::Frts {
-                    frts_addr,
-                    frts_size,
-                } => {
-                    frts_cmd.frts_region = FrtsRegion {
-                        ver: 1,
-                        hdr: size_of::<FrtsRegion>() as u32,
-                        addr: (frts_addr >> 12) as u32,
-                        size: (frts_size >> 12) as u32,
-                        ftype: NVFW_FRTS_CMD_REGION_TYPE_FB,
-                    };
-
-                    NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS
-                }
-                FwsecCommand::Sb => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB,
-            };
+            if let FwsecCommand::Frts {
+                frts_addr,
+                frts_size,
+            } = cmd
+            {
+                frts_cmd.frts_region = FrtsRegion {
+                    ver: 1,
+                    hdr: size_of::<FrtsRegion>() as u32,
+                    addr: (frts_addr >> 12) as u32,
+                    size: (frts_size >> 12) as u32,
+                    ftype: NVFW_FRTS_CMD_REGION_TYPE_FB,
+                };
+            }
 
             // Return early as we found and patched the DMEMMAPPER region.
             return Ok(Self(dma_object, PhantomData));
-- 
2.51.1


