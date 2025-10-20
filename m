Return-Path: <linux-kernel+bounces-861385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA638BF2976
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C961D4E37FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2696221FB6;
	Mon, 20 Oct 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIRw80Ah"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A382330B34
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979767; cv=none; b=ge7OHLLn1f81se+mI373lKjAScHdaGR4YdRi3nEd8DR6/enqslqMCbH3j0rMVwoB4fhYAuj7jJ4zzSoIXEQSfw7r8BafFG3cd2WL/2o0gmAJuKn5Hbcpu7axPfNEW/ur25dwYjVvojgCD1dLcL4rGpWZwGBKcfBrRaIXTR/K6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979767; c=relaxed/simple;
	bh=kMtr8rxMNB8DiOzifUqvwMtBN3H+SuqhXgD87exLlow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhaznRfz0wtpEDZhXB5ogKzS5lp2HmvQBgkzI5Ua6OipqnkaabfDbL3fV4gJJnCa84AoyiF6c6kHl1klD2Otc06xHCYNL320FQ3KycjVY7fy09uQtAkOk+mGW42iNLcsr8xCeTvQb7W9ofOfcyHHfLo7RTeTdZIlE9VuMSjfzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIRw80Ah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60e0IVore7boCdNupv+ILyCAnntv+WCulzbwmbp4u7k=;
	b=TIRw80AhjqON/EgqlbPhJIol4oPabBP/dBOKgPKaPA1eu3fAL5ik/X81ro5l5cmQ76ln4i
	YHrVJk5Z3v3mI7o3v0lbAiXYWVAoLsabiF6kxjyBam3PE/EGxcvWY1aWJGRuYyip6jaPPm
	sofizdxh4dy6EGmS9CfxkDMK2oXEpZI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-IEwHIGfkOIC-caUyghS_Vg-1; Mon, 20 Oct 2025 13:02:42 -0400
X-MC-Unique: IEwHIGfkOIC-caUyghS_Vg-1
X-Mimecast-MFC-AGG-ID: IEwHIGfkOIC-caUyghS_Vg_1760979761
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ec911196aso1783426985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979761; x=1761584561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60e0IVore7boCdNupv+ILyCAnntv+WCulzbwmbp4u7k=;
        b=AaWefPgLWb6gEtzlAB1KRxYD70zKGgB8Qb8lpR4Dcd0bUcqp+g1WKBh6OsAxkD4Zws
         iGZtFh3RYr/v1nKpufpCBVvFzsx7yscAl+XatG8F+rNEM8CsBLXCwGZxt3FDLMGHpgnQ
         HwzSw5miIka0/Yd5LGEDMSpaJZw9VAI2WH7LjR2e67jT+InJCGuK82wuVA+zALf8RasD
         DHU9g3nVQt+Sk4SFfoHqaQDRr0I1RDAK1hc3+EIw3/zAUaIR6M3D2hiQ8ZCJ/guq9/+8
         Z9csiTt5X+0YlKTrc5suc0Y1BUcpmuQB/IPmX9+rmGDAYfyH1NInOSr+nRySy9NoeVmg
         eGhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzI6hVKaMpFjEUAzT8WSd0hvGd7a8WGZAZEmrNe4io52CNK1TV10oxamqQnN3d3Uh05UpDF+fiOwz9oxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+K12H9GBXtAFeXnLmKdQM4yDbC6Av6TRq+GeYWAT1g9beP40
	1AGuKGZCUBMTC7sKqiKjtIYTIJy+/fZjkz6urf6g7M0K9ZSlPl0CMlIowwbZRL55SJiRqCS40m4
	o1zdaIej+L89WqNqljrTVuiWMAut57tKtf05iAdM1JUTtTY2/dedknL5wviXDICQH1A==
X-Gm-Gg: ASbGncv8vhHbPdGQk09Mkf5Ji0ri7Wc539kTaJPjmACCTtN8/kpQFmgkO0b1ptMys5T
	eXEDwDIZlkF4uF1BrOCb+JXdYVcXnpCcF9G6+Ls6S0bJzE00lgmARZdxq65fRg04qf+GNGjvo+d
	At8D2Oqu0RN7cI6Bk2kMZzEuYUNFMAfAMDvsSdyGFbzOyXzEpVuQFNLhF7LCFvksiYGtFIgfffR
	FGIMOUA2VY+73ebyrFJH5offg9zSyhwjwnZn1OHpa/8Rpj5jRnzM0gkX5MeyvdhnJJFoQAIKWZO
	I0ix5yb6/FQQAiDYtGx+uNu2LpG3Zl9Wuh+uTeb5HE75isQKc/beCUa4tjyhH1JIZ5xW83n7yPL
	/DUvUAXVtAXgW
X-Received: by 2002:ac8:7d0c:0:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4e8ad2adf32mr111401381cf.30.1760979761233;
        Mon, 20 Oct 2025 10:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbwVmn9czv79qyCwEl1SriY3PLMsY5z230eFIqxhHynrytOJV25/qzzTjQIcPMDVhjxQP5Qw==
X-Received: by 2002:ac8:7d0c:0:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4e8ad2adf32mr111400681cf.30.1760979760572;
        Mon, 20 Oct 2025 10:02:40 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eecbsm589945985a.49.2025.10.20.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:02:40 -0700 (PDT)
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
Subject: [PATCH v2 2/2] rust: pci: normalise spelling of PCI BAR
Date: Mon, 20 Oct 2025 17:02:23 +0000
Message-ID: <20251020170223.573769-3-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020170223.573769-1-pcolberg@redhat.com>
References: <20251020170223.573769-1-pcolberg@redhat.com>
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
v2:
- Rebase onto driver-core-testing to follow "Rust PCI housekeeping"
  patches, which move I/O and IRQ specific code into sub-modules.
---
 rust/kernel/pci.rs    | 4 ++--
 rust/kernel/pci/io.rs | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ce612c9b7b56..3100d37eba2b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -377,7 +377,7 @@ pub fn subsystem_device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).subsystem_device }
     }
 
-    /// Returns the start of the given PCI bar resource.
+    /// Returns the start of the given PCI BAR resource.
     pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -389,7 +389,7 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
-    /// Returns the size of the given PCI bar resource.
+    /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 65151a0a1a41..3684276b326b 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,7 @@
 /// # Invariants
 ///
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
-/// memory mapped PCI bar and its size.
+/// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
     io: IoRaw<SIZE>,
@@ -78,7 +78,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
 
     /// # Safety
     ///
-    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    /// `ioptr` must be a valid pointer to the memory mapped PCI BAR number `num`.
     unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // SAFETY:
         // `pdev` is valid by the invariants of `Device`.
@@ -120,7 +120,7 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl Device<device::Bound> {
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
@@ -130,7 +130,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    /// Maps an entire PCI BAR after performing a region-request on it.
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-- 
2.51.0


