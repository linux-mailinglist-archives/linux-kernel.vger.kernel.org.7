Return-Path: <linux-kernel+bounces-859523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76278BEDE3E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647AB4E5DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ECC21D3E8;
	Sun, 19 Oct 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuO73zBV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27421772A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850014; cv=none; b=SbJsSuSgYlOZ/7uw+frDLeotuCiqmlF2wqq/tb1aRlC5chwxd3BBV0iO5PkugPLbVOxs8hUMRBVSGMcmcv0icq8JBdmmRLrZgoE9piPpzZ2WICBpsjskuKwtvkKvNqSTCcqyM6EebL6DqIKFKT9PbmO0JXERVnlGZrFXalkUxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850014; c=relaxed/simple;
	bh=YUyYgzYm9tbG09HLL/WAwoU4M99Mv0yjyKmgERRoNjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zpez4TK9GRaE/ELbuWp+PHXy9dIQ5cIrOoMYsJ6zrcDDnK7cPHxtBk+8wrRVzQ8RA0FuXMbb9A2xEnHOLgMrDFdIRspP7w5IVcnm/NpeqQavtk9U6korWpYaURDibEUDc3++iUkF9Ap7KMo7uj55ySfSUj0Q0BEW01s3U1bmUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuO73zBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760850011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQXW79VD1VDqu9OOdSqXUG39KL0/s9L9/QkyIlNgoV0=;
	b=IuO73zBVixJVgDFN1OwpQOMWBY1TpPYIDWRHp0NvQR3JeRuS3j4ZnpQmrK2b70kHH7AQN9
	4pmJYv0I4MH7Icfuru+31r2y0p4eJEtQHaqayObNjEsKcwtLi0CQ+3qZKeF6W1UHBilD6v
	1WDkrzri8zWkmpAxHO9TFN1aTUYdxts=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-Y9swl5yWNC-dHr0w689e4g-1; Sun, 19 Oct 2025 01:00:09 -0400
X-MC-Unique: Y9swl5yWNC-dHr0w689e4g-1
X-Mimecast-MFC-AGG-ID: Y9swl5yWNC-dHr0w689e4g_1760850008
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7a758650abdso137370696d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850008; x=1761454808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQXW79VD1VDqu9OOdSqXUG39KL0/s9L9/QkyIlNgoV0=;
        b=pUzIny2iNbm7ejaQLPVnyJCZp1p80u0XMitS32FT1mF28FyXf4s/KymdAyIgb8HFbg
         t8zIomo9Ls3FLsPkBD1RhwVUaRstUfaLxtqNoOY3kE/rrx+DW1H2jRQStsCLWq2xPqhc
         bP/Bi2QOwm5+85adajarQXycdzrIug6ynb6ldvFpWXiKmcDx66o5b4YCQQDz4eJnVNtH
         eSZZILE1UbCTGjNDPQjZENcaX/3hSDfk0XGn/LZcJON3V9tohOGDaiXiswQsoHaugqxN
         a3y7Y5vtb8u+V8wbDDhY6y034yD9S6S3Ujl/VS5k54b9mvfnfZLbh7Y2tf+KbP8pOwGq
         fp5g==
X-Forwarded-Encrypted: i=1; AJvYcCUwsymG4lPX2zOmt1z0xmFVW102sWnVwMaHpnq8aVF1PSnR9XCbHdAxHQa/vRTrwNwPuEXRzAlZacXnC7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUIuujBblVxW9h1q3l2EsqBACFO5zjgTslftXGhwjk2ZF3tNZ
	zP+E8KMyThNoJnyuQNw+h3+xUC++k/7KdsAd6X0qU3mGS0EFSdurdF1FEZX2FnmCVfbxjQ1WAV0
	MwEIVV7Nm+vULqRTbwMoEiB7B8I31Xo0sktbXIQUl8RF5SqDt/gAw6L7oIiTEoyg3xg==
X-Gm-Gg: ASbGncs+y+AObPe+PeDEYLb+U4Q4Dcdf5IdlDmOryXgaFu3y1raCFahw/rh8j89Xuee
	33S0dW60rkOAy4f+UW4S1FXlnQE7ptjo0nSAIvzWHiKbVFQrLQKLLOOaiaI2CRv2mQo0gp0MMGc
	xxCsjEW4muyFbesVptrWDgav34UnWBp+CSt3Q6I6xYvpSL27eoLZ9ZkH/giyaWEsLHsuNKYX+uG
	fuaREqUECFNoyMgZIpvbGV3lqzGIXbyfp4RZ+mDeGM8HqGbqG0srg0eXzvaqP6ohkkRhTc+eZf/
	iuItYseepQw61w1nCJh9Qd++Ogm1v9isFVyFuiONdqttDclKbNXmAytImhK9ChUNGod5kaWBj54
	qa4iHt/Hb+7lJ
X-Received: by 2002:ac8:5ad0:0:b0:4e8:aee7:c559 with SMTP id d75a77b69052e-4e8aee7c85cmr47240341cf.31.1760850008590;
        Sat, 18 Oct 2025 22:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2GCOUQgg388o06Q5JSqBle/dvEc3Un/4442RGMFaboTta85NJv6+LnGnnuvBC07NDv3meCA==
X-Received: by 2002:ac8:5ad0:0:b0:4e8:aee7:c559 with SMTP id d75a77b69052e-4e8aee7c85cmr47240031cf.31.1760850008184;
        Sat, 18 Oct 2025 22:00:08 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 22:00:07 -0700 (PDT)
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 2/2] rust: pci: normalise spelling of PCI BAR
Date: Sun, 19 Oct 2025 04:56:20 +0000
Message-ID: <20251019045620.2080-3-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019045620.2080-1-pcolberg@redhat.com>
References: <20251019045620.2080-1-pcolberg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently refer to PCI base address register as PCI BAR.
Fix spelling mistake "Mapps" -> "Maps".

Link: https://lore.kernel.org/rust-for-linux/20251015225827.GA960157@bhelgaas/
Link: https://github.com/Rust-for-Linux/linux/issues/1196
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 18f9b92a745e..747a0487d1e5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -363,7 +363,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 /// # Invariants
 ///
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
-/// memory mapped PCI bar and its size.
+/// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
     io: IoRaw<SIZE>,
@@ -423,7 +423,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
 
     /// # Safety
     ///
-    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    /// `ioptr` must be a valid pointer to the memory mapped PCI BAR number `num`.
     unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // SAFETY:
         // `pdev` is valid by the invariants of `Device`.
@@ -537,7 +537,7 @@ pub fn subsystem_device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).subsystem_device }
     }
 
-    /// Returns the start of the given PCI bar resource.
+    /// Returns the start of the given PCI BAR resource.
     pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -549,7 +549,7 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
-    /// Returns the size of the given PCI bar resource.
+    /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -656,7 +656,7 @@ fn drop(&mut self) {
 }
 
 impl Device<device::Bound> {
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
@@ -666,7 +666,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    /// Maps an entire PCI BAR after performing a region-request on it.
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-- 
2.51.0


