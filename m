Return-Path: <linux-kernel+bounces-859522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7EFBEDE38
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 728AF4E2C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA921579F;
	Sun, 19 Oct 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0v079He"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4E20297E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850011; cv=none; b=fLtBWjT7xDrXJoaQusJqdLi7Q6QrrP9mnMJm8QZMLfCyl+OpIypDQC2jorqJpFkIz/tcTgNALw2vt1f78Jbo5mBx5zA1XJQsQ28BaAA6M0ddJoHR/rlmlbtS5paE+pAVnSMIF7GHH9mviG/nMPNvNROAqo4jHEPsMtAWgCDdSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850011; c=relaxed/simple;
	bh=o1PUC2wc1mAokO+mTBqq622zLzBZ0C7jG04WPD4ze+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixfivPA7RzRgL80zqUFl8P8AsD+WO6avR4Hds9cL3ecE9OOYGXBG8f+J33pqwVcCtp+X67tCKDdZfaSCH3GjGQu/JwtCehi4b2/B19CicP5snf3fY1ni5+HVm0lMYKzPTW1mi2LhVgTNJYFkgN/xVn0Uo4BSuDIZNzoZM25mwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0v079He; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760850008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6j42bXIK7vhHm/hVQ0KPPWv9prcOGiEtMxLoqJlyhY=;
	b=i0v079Hed/WgwvyK0cBqNP/HL3UEigF5cOzoESIJdnQS9gZFwXyuaHxCQXQFalSKOsMeIm
	d8X6bjf16t2cWrVnKYzRYP/5PGOx0BYgMx4XrI4G2vyPQJLtXBUdl1aIJYigv4142t3xT0
	yIo6YZ8VhynuBzcQPe6J0k1gD+cPxzU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-tyE-DX8JMOqFRTDxi9F5cA-1; Sun, 19 Oct 2025 01:00:06 -0400
X-MC-Unique: tyE-DX8JMOqFRTDxi9F5cA-1
X-Mimecast-MFC-AGG-ID: tyE-DX8JMOqFRTDxi9F5cA_1760850006
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c171369aaso142212556d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850006; x=1761454806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6j42bXIK7vhHm/hVQ0KPPWv9prcOGiEtMxLoqJlyhY=;
        b=dl2hVSlVNC+9JMUggouzDwn14A9O65+1/BAx6bT67ezrPzYHfProb7UwNuEDcfjUfQ
         +mw1L41cnT4H9yIbbWEs2TFKQ/NOK8DmBSb414yPc4v2oAVklp/tvxwq8mg1tmgtHybm
         +ic8m9HAKBGky7yl5Nx67arl8Ly3tdvM67I0UOwPr+PWpIylp67C5Fy9B3fEF9kUR8bh
         S5XW8ahATDd04s551XCAdRBIOQRV3T6dpHrQQiWJVyjPe5rjLYRqFC9jVbcbVkjoMIIM
         HgSPXf/FiZcBwV+SyoaW1uHAPyepv+HwuQkiQUL+EWfwJHKNc/tiAxEo4YM59Bt3Pojd
         o+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUnelhBn5QxiFgJRzs5CYnVZ0yKpa5AycepaEYhFMiorlWwaSmeKj6BWP47rKRjCfP0ecDiGivfBtCrnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtvKO0fFuJUM7Ozq+JS8C+RDWq7w+OC5yXjJjakKsnn+dFqUa
	Af0TC8T8qV89KsN7kcJNOCd/qm34Rpf8QfVpjBG4yNhsmt6PiShdlwdz9GBuKogWtxfO/9oDZMw
	8gUR00dTae4FUEma8HWGgw1qitaL7CJPSAnmLLEk+VSksyFNLwHjKDuZBTTIu9/CH1w==
X-Gm-Gg: ASbGncugKI15NZLS8a/npkqHZCmEXsgBGoCHcW1wUf5IeLQOQMshizf9SO1NkEoDv/6
	empprPg0+4s98+vzLGyMKxCPSnozlyLJ5pG7yYHHd/y+yIilu5gkiVUs7GFVotR8diejjkgwXT7
	LkxZmztSSfpXNicp13oobBAZfvGC2J8WCsVEHfdo4gG76xufB+VL/BWWxC7dDHpl6IFm3FKlchj
	TBAu4khkRbGiK9f/blXzt2LB8/WMrdvKNpmhSZVLGlQ29Ivir4lTB7zoo0wP1I7wZMqfmGMRmcr
	yh/DAYeXrLdXWt0hhgaldxkrQqriulWGETxUmLOpNSAJBSC84Ztk3OteavDLUn0k0Ju+uRjYUG1
	A89F+clf5Zioc
X-Received: by 2002:a05:6214:1c4e:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-87c202ca12cmr129730616d6.24.1760850005641;
        Sat, 18 Oct 2025 22:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5wLeuxoiCHUZOMNbVk/R58So9DiHQPQPxCkQ0dtuezAPPgfbIhF/Hy0u9hiLd/d1yjKIlOQ==
X-Received: by 2002:a05:6214:1c4e:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-87c202ca12cmr129730306d6.24.1760850005241;
        Sat, 18 Oct 2025 22:00:05 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 22:00:04 -0700 (PDT)
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
Subject: [PATCH 1/2] rust: pci: refer to legacy as INTx interrupts
Date: Sun, 19 Oct 2025 04:56:19 +0000
Message-ID: <20251019045620.2080-2-pcolberg@redhat.com>
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

Consistently use INTx, as in the description of IrqType::Intx, to refer
to the four legacy PCI interrupts, INTA#, INTB#, INTC#, and INTD#.

Link: https://lore.kernel.org/rust-for-linux/20251015230209.GA960343@bhelgaas/
Link: https://github.com/Rust-for-Linux/linux/issues/1196
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d91ec9f008ae..18f9b92a745e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -56,7 +56,7 @@ const fn as_raw(self) -> u32 {
 pub struct IrqTypes(u32);
 
 impl IrqTypes {
-    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
+    /// Create a set containing all IRQ types (MSI-X, MSI, and INTx).
     pub const fn all() -> Self {
         Self(bindings::PCI_IRQ_ALL_TYPES)
     }
@@ -66,7 +66,7 @@ pub const fn all() -> Self {
     /// # Examples
     ///
     /// ```ignore
-    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
+    /// // Create a set with only MSI and MSI-X (no INTx interrupts).
     /// let msi_only = IrqTypes::default()
     ///     .with(IrqType::Msi)
     ///     .with(IrqType::MsiX);
@@ -722,9 +722,9 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
     /// Allocate IRQ vectors for this PCI device with automatic cleanup.
     ///
     /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
-    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
+    /// The allocation will use MSI-X, MSI, or INTx interrupts based on the `irq_types`
     /// parameter and hardware capabilities. When multiple types are specified, the kernel
-    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
+    /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
     /// The allocated vectors are automatically freed when the device is unbound, using the
     /// devres (device resource management) system.
@@ -748,7 +748,7 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
     /// // Allocate using any available interrupt type in the order mentioned above.
     /// let vectors = dev.alloc_irq_vectors(1, 32, pci::IrqTypes::all())?;
     ///
-    /// // Allocate MSI or MSI-X only (no legacy interrupts).
+    /// // Allocate MSI or MSI-X only (no INTx interrupts).
     /// let msi_only = pci::IrqTypes::default()
     ///     .with(pci::IrqType::Msi)
     ///     .with(pci::IrqType::MsiX);
-- 
2.51.0


