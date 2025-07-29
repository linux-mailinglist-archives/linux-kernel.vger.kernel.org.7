Return-Path: <linux-kernel+bounces-749905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB8B1548C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C43F7B1FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F04279DD3;
	Tue, 29 Jul 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpDTtzfn"
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED31277C8C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823212; cv=none; b=GycKgApqbg7uZzDVikCuWiF1xAiqjHjnS3zlcg8zisqGmA/4W97dcKsf8YcnLmzKzvIcOInGLeCPf6n6EwbeRjTd1ssxHjIwPqPIYvOeq41dlfirfXzV50S3Fgz3kt8HvqnncN32kEsSAAQEKvTJbPsOSDoVHzo0rhl5K65i0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823212; c=relaxed/simple;
	bh=xXxOaypf1O0c2TmYy3E8NrMsFx/7ywXWJDE5Hp5oImI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SvA5TA7neK9m+c7AEeh2m9peMGYWxNsKxNM7nXTve4sw0bZULYJdyZGjuy0l/TDXkFbDZhaeeskhYAsgVY318XRcEnG1E3Xe9AX7Y9r4qgEmLsnmhAoL1Jnvrc9TNLWn1Tx1j6Wem6ZtuEgRJco411M+gZMklBd6CKKY4AmSI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpDTtzfn; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-73e8ddac4d2so436298a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753823210; x=1754428010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G6k6rF4VXujQbr0gf19z0lGEBcf3iyQdves2PsQcakU=;
        b=lpDTtzfnums4k5/HlDtqQz2/OqW1LVfNQbCIDxagrikFJ+8/p2rD3MgkKz16h3JmJL
         TbqiGFjiOz4fD0uVWli3pPe9vnOs0oSWE9lpFiZmDC6U92R1r26dr7dc0gZ7x07ZSxby
         FZ+0I0pJY+XgCEyS1DH7xE6qQEZPGHV/HelYCh9ReThnAmRpJ3u2YS7r9L52bHhmtQVI
         rfJGttjTuORA6WvTYMNmYb+94ea/++tUTIxPZf0IbpYlYIN6j2lQVk0Hdighk3N42nU2
         8LSW9Pjx0dQGgQ6T/Ep1yyDpr9SI0Tjd2Ji9oqSDgVWy/VYYMq2oKnp23X4sge+Gy1Ac
         i1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753823210; x=1754428010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6k6rF4VXujQbr0gf19z0lGEBcf3iyQdves2PsQcakU=;
        b=vNdAWYWMWsyGXaiRZ3xLaHAdzJc0AJgp9aFOE4Y4Ru7OOME1TL2HSwNy1kObG4QQsu
         c3VjYyTVZUyJ4njSYZ/b4rkFXdGQ5kozNEAi6wpzRyoPA7T/wCr9H7o0qaLEQsOxMGt6
         M/dALs4ghhJx9sNG9uhaf4F2WX8GN+qk2hIjQ6b3+rhd5h9EgVEi45QOW8l+6GKUyDLN
         XO6l5lXb8nNL8mN+RrUQINaMYH1ey6bByf4fVnWIXTnEop9wrWq//H11oxpq5Y8Dd5xC
         GT2cXbSiD0AgxA0DP/rd9DphybTzacafd8jnDAzyRPUSitxPXKydBRaNopDCyziaPzx6
         OB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzrJ0OMdwz85qsA5qmfY+81Wk7Vgbcuv+ioEqv2MmUGY7U+7VuLk0+PhPDJYBWC8JK6FBcZRQODrCG/eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dz4sTNeaUgn7lQ7ZouwNhZZ2/1DA09PiHyub7psu7uis+FCn
	v3psRi61tcQNNZBtO+4XmH/Hqkq+DdD3UiHwVw6YHJiJSNZsy7VJsCpVfA5mTLF7pl2bckJuZbs
	pg94SpBRgtw==
X-Google-Smtp-Source: AGHT+IEdDyp+BjUiIv+U9x5e1bEY3i3OfuxGF5rUpR2eomh89r+PqVcOQdhBuhPRclIawhrP0gMOvkGnjamH
X-Received: from otbdy16.prod.google.com ([2002:a05:6830:2110:b0:73e:63da:b19e])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:7196:b0:73a:8bf8:56b9
 with SMTP id 46e09a7af769-74177a49ffamr908477a34.1.1753823209769; Tue, 29 Jul
 2025 14:06:49 -0700 (PDT)
Date: Tue, 29 Jul 2025 21:06:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729210644.830364-1-rananta@google.com>
Subject: [PATCH v2] KVM: arm64: Move bundling vLPI and vSGI to vgic_supports_direct_msis()
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit <c652887a9288> ("KVM: arm64: vgic-v3: Allow userspace to write
GICD_TYPER2.nASSGIcap") bundles the vLPIs and vSGIs behind the
GICD_TYPER2.nASSGIcap field. While the vGIC v4 initialization and
teardown is handled correctly, it erroneously left out the cases when
KVM sets/unset vGIC v4 forwarding, which leads to a kernel panic of the
following nature:

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a8
   Mem abort info:
     ESR = 0x0000000096000044
     EC = 0x25: DABT (current EL), IL = 32 bits
     SET = 0, FnV = 0
     EA = 0, S1PTW = 0
     FSC = 0x04: level 0 translation fault
   Data abort info:
     ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
     CM = 0, WnR = 1, TnD = 0, TagAccess = 0
     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
   user pgtable: 4k pages, 48-bit VAs, pgdp=00000073a453b000
   [00000000000000a8] pgd=0000000000000000, p4d=0000000000000000
   Internal error: Oops: 0000000096000044 [#1] SMP
   pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
   pc : its_irq_set_vcpu_affinity+0x58c/0x95c
   lr : its_irq_set_vcpu_affinity+0x1e0/0x95c
   sp : ffff8001029bb9e0
   pmr_save: 00000060
   x29: ffff8001029bba20 x28: ffff0001ca5e28c0 x27: 0000000000000000
   x26: 0000000000000000 x25: ffff00019eee9f80 x24: ffff0001992b3f00
   x23: ffff8001029bbab8 x22: ffff00001159fb80 x21: 00000000000024a7
   x20: 00000000000024a7 x19: ffff00019eee9fb4 x18: 0000000000000494
   x17: 000000000000000e x16: 0000000000000494 x15: 0000000000000002
   x14: ffff0001a7f34600 x13: ffffccaad1203000 x12: 0000000000000018
   x11: ffff000011991000 x10: 0000000000000000 x9 : 00000000000000a2
   x8 : 00000000000020a8 x7 : 0000000000000000 x6 : 000000000000003f
   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
   x2 : 0000000000000000 x1 : ffff8001029bbab8 x0 : 00000000000000a8
   Call trace:
    its_irq_set_vcpu_affinity+0x58c/0x95c
    irq_set_vcpu_affinity+0x74/0xc8
    its_map_vlpi+0x4c/0x94
    kvm_vgic_v4_set_forwarding+0x134/0x298
    kvm_arch_irq_bypass_add_producer+0x28/0x34
    irq_bypass_register_producer+0xf8/0x1d8
    vfio_msi_set_vector_signal+0x2c8/0x308
    vfio_pci_set_msi_trigger+0x198/0x2d4
    vfio_pci_set_irqs_ioctl+0xf0/0x104
    vfio_pci_core_ioctl+0x6ac/0xc5c
    vfio_device_fops_unl_ioctl+0x128/0x370
    __arm64_sys_ioctl+0x98/0xd0
    el0_svc_common+0xd8/0x1d8
    do_el0_svc+0x28/0x34
    el0_svc+0x40/0xb8
    el0t_64_sync_handler+0x70/0xbc
    el0t_64_sync+0x1a8/0x1ac
   Code: 321f0129 f940094a 8b080148 d1400900 (39000009)
   ---[ end trace 0000000000000000 ]---

Fix this by moving the bundling logic to vgic_supports_direct_msis()
instead. This would still handle the vGIC v4 initialization
appropriately, while also helping with the vLPI set/unset forwarding.

Fixes: c652887a9288 ("KVM: arm64: vgic-v3: Allow userspace to write GICD_TYPER2.nASSGIcap")
Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |  8 ++++++++
 arch/arm64/kvm/vgic/vgic.h         | 10 +---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index a3ef185209e9..70d50c77e5dc 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -50,6 +50,14 @@ bool vgic_has_its(struct kvm *kvm)
 
 bool vgic_supports_direct_msis(struct kvm *kvm)
 {
+	/*
+	 * Deliberately conflate vLPI and vSGI support on GICv4.1 hardware,
+	 * indirectly allowing userspace to control whether or not vPEs are
+	 * allocated for the VM.
+	 */
+	if (system_supports_direct_sgis() && !vgic_supports_direct_sgis(kvm))
+		return false;
+
 	return kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm);
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 1384a04c0784..de1c1d3261c3 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -396,15 +396,7 @@ bool vgic_supports_direct_sgis(struct kvm *kvm);
 
 static inline bool vgic_supports_direct_irqs(struct kvm *kvm)
 {
-	/*
-	 * Deliberately conflate vLPI and vSGI support on GICv4.1 hardware,
-	 * indirectly allowing userspace to control whether or not vPEs are
-	 * allocated for the VM.
-	 */
-	if (system_supports_direct_sgis())
-		return vgic_supports_direct_sgis(kvm);
-
-	return vgic_supports_direct_msis(kvm);
+	return vgic_supports_direct_msis(kvm) || vgic_supports_direct_sgis(kvm);
 }
 
 int vgic_v4_init(struct kvm *kvm);

base-commit: 18ec25dd0e97653cdb576bb1750c31acf2513ea7
-- 
2.50.1.552.g942d659e1b-goog


