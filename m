Return-Path: <linux-kernel+bounces-748449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6BB14172
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633DE18C06D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA027464A;
	Mon, 28 Jul 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRUrGmcp"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACA219A89
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725214; cv=none; b=jdMXYWjumJ+oqaVnBpwz5t8PaqzR7ev+nuSCibqgw3LKSY9dOaxr9hzJVmN03+XApmiBZ61QsOMuwtAOJLeKZ1aTmkg490OXGIACRMGA+afFQgMkExaQwrZeHQmWPsLCCa7zBrZ/JA9R/kELuCqFjsRWWAy87M+Ua37N03el+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725214; c=relaxed/simple;
	bh=vm+16aMp3Hj96bAQIzHygIiRcER8sN0pB9SdWCvxidc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hHEgcPBT+Ui7u8uifE++saUrvfvNg5IJHA6n/GpkuahKpr/yqxebJO1mk67/sfSPC00pYBYP/cFgLziqXc3EiFRAqzETvNq3NSugKjv9p38eaS1hhJAJtONg94VJFgYEJ5PG46IObLs7BMwea+XwJz/isXaiLbhZLT1XGVy9yK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRUrGmcp; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so2859160f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725211; x=1754330011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8yreLd+QpacId3F3pRUlLCmWTAXUiBp3fqE2+4w1mPs=;
        b=vRUrGmcpBFAs69OUVQnPFUK7f3AfWkx8tuB6IR3kYSBfTWKyA1vRxQDXoFTHbmSDv1
         B5VTPlspwbPyZM6zl2DAyKWAFAaXouIpfSJ6pCcwWEcGwl89qmFDkxgc3of3TMOwGkBI
         Miam8Qt7r5Koqw6QFJC0vlwGdxq1J7KuIigMkM1XSqlfku/UCpoybFurd0Pi0tsqWOFL
         xOkMb5US3rpWc6B3RU/Pljfv4sj8bD3byfZphmxHkp7bOEnCFYFEaBXCtVgZPNN4lOcc
         wObDGa8FN+C5syG+IdDoari9fvFaJhg6iW1AxElsDAF5G5tzmZCYHmr1pFqWBmGfcAWW
         1gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725211; x=1754330011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yreLd+QpacId3F3pRUlLCmWTAXUiBp3fqE2+4w1mPs=;
        b=voUUPLeQKQREi6P1ClSqv5F/rFbobz3T5gY6HsR8meTucif3UjwV/V9MPQrjJwCEKD
         Z7OYx9KialyiP7o0Ywj+bhB0JBaJ5gOeiYD2h6nwpHZebE/Xoupml0KkZM2DT5+Y3Z9g
         1fogY9Gq0hnz/ZPJzgr/w/2jfNhXu2Z+0wW/4W08lvTgqvlk30z3RM6I2iLcSpkWqmAt
         tzsx0t4N1Sc9ZU3Xf9ePkdWQk7cIW0EdPcgKVeNcFOtVcN6g4DFZ0BlX4R8XHpgb7IsC
         5JzvikyG/Hs5ImYjYlg+oszdNAuKkpESoSjXLQxzuaKUUeQQniItQLo3KUrqKX6M+1UQ
         d08w==
X-Gm-Message-State: AOJu0YzYRJNFvu0byjcIMs2f2/A6+x7g+G/li972RyhtS9iso6uJ5yND
	xi6VF3e56YEegi47mCw297lLMKHzdxPuTUx0Fki7UqqKRSy0kfaoIvSXjyV9Km1kIVCmE67+orD
	tTrJFPsmrJjhS9J3/voG2pr7dJs3HEeOllRTLkNC1q1IP2b2SZV8vQHVaJylqeQxx1HTKcCiYCu
	/UP5kbR1SPK92gXFsZzr3E7dBkNJEETImUmKR8TOKEBBxgD8nI2rVgCJg=
X-Google-Smtp-Source: AGHT+IHdGQE2wwXM49+MVAqJUkEY8InyH8twrQm1c7DxW3HjRHCRjNGwP+usERmU6WFHjlMI/yRPQ1WqhtAlzg==
X-Received: from wmco2.prod.google.com ([2002:a05:600c:a302:b0:455:e7d7:cae9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2410:b0:3b7:8b88:e3a2 with SMTP id ffacd0b85a97d-3b78b88e59fmr1783148f8f.58.1753725210911;
 Mon, 28 Jul 2025 10:53:30 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-1-smostafa@google.com>
Subject: [PATCH v3 00/29] KVM: arm64: SMMUv3 driver for pKVM
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v3 of the support for DMA isolation with SMMUv3 on pKVM.
v2: https://lore.kernel.org/kvmarm/20241212180423.1578358-1-smostafa@google.com/
v1: https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/

Main changes (see design section for details):
- This version applies directly to upstream with no out of tree pKVM
  dependencies and is not an RFC
- This version adds minimum support for DMA isolation by identity
  mapping the SMMU S2 as opposed to the paravirtual interface in the
  previous versions.
- This version has much more code re-use as a new shared file (and
  structs, macros) for hyp-kernel smmu-v3 code, which makes the
  hyp SMMUv3 specific code smaller.

pKVM overview:
=============
The pKVM hypervisor arm64, provides a separation of privileges
between the host and hypervisor parts of KVM, where the hypervisor
is trusted by guests but the host is not [1][2]. The host is initially
trusted during boot, but its privileges are reduced after KVM is
initialized so that, if an adversary later gains access to the large
attack surface of the host, it cannot access guest data.

Currently with pKVM, the host can still instruct DMA-capable devices
like the GPU to access guest and hypervisor memory, which undermines
this isolation. Preventing DMA attacks requires an IOMMU, owned by the
hypervisor.

This series adds a hypervisor driver for the Arm SMMUv3 IOMMU. Since the
hypervisor part of pKVM (called nVHE here) is minimal, moving the whole
host SMMU driver into nVHE isn't really an option. It is too large and
complex and requires infrastructure from all over the kernel. We add a
reduced nVHE driver that deals with populating the SMMU tables and the
command queue, and the host driver still deals with probing and some
Initialization.

Most of SMMUv3 specific source code would still be shared through common source files.

Patches overview
================
The patches are split as follows:

Patches 01-03: Core hypervisor: Add donation for NC, dealing with MMIO,
               and arch timer abstraction.
Patches 04-13: SMMUv3 driver split: Split the SMMUv3 driver to 3 parts
               (shared kernel, shared hyp, driver specific) and io-pgtable-arm
               to 2 parts (shared hyp, driver specific)
               Most of these patches are better viewed with --color-moved
Patches 14-17: Hypervisor IOMMU core: two hypercall to enable/disable
               devices, IOMMU pagetable management
Patches 18-25: Hypervisor KVM SMMUv3 driver: Setup shadow pgtables, STEs...
Patches 26-29 Kernel KVM SMMUv3 driver: Probe of devices, and populating
              info to the hypervisor, IOMMU ops

A development branch is available at:
https://android-kvm.googlesource.com/linux/+log/refs/heads/for-upstream/pkvm-smmu-v3

Design and future work
===============
This patch series is designed to be minimal and include patches only
required for functionality.

The hypervisor SMMUv3 driver will load early before KVM initialises
and registers itself as a KVM IOMMU driver; if it finds SMMUv3 on the platform.

Then after KVM initialises and before it de-privileges it will initialise
the kernel part of the driver, that will probe the SMMUs, initialise some
of the HW and populate a list of SMMUs to the hypervisor part to deal with.
The kernel driver exposes an IOMMU driver to the kernel that only supports
IDENTITY domains.

Then the hypervisor part of the driver will initialise before de-privilege
which then take over the shared structs, cmdq and create a shadow page table
for the SMMU.

In addition to the patches in this series, I am working on part-2 which adds
more features (EVTQ support for debuggability and RPM and possibly some
optimizations such as sharing page tables, split block unmap logic...)
https://android-kvm.googlesource.com/linux/+log/refs/heads/for-upstream/pkvm-smmu-v3-part-2

After that I plan to post 2 RFCs which adds support for translating
domains, one with paravirtual interface(similar to V2) and one with SMMUv3
emulation (similar to[3])

This series is tested on Morello board and Qemu.

[1] https://lore.kernel.org/kvmarm/20220519134204.5379-1-will@kernel.org/
[2] https://www.youtube.com/watch?v=9npebeVFbFw
[3] https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/android15-6.6-smmu-nesting-wip-2


Jean-Philippe Brucker (11):
  iommu/io-pgtable-arm: Split initialization
  iommu/arm-smmu-v3: Move some definitions to a new common file
  iommu/arm-smmu-v3: Extract driver-specific bits from probe function
  iommu/arm-smmu-v3: Move some functions to arm-smmu-v3-common.c
  iommu/arm-smmu-v3: Move firmware probe to arm-smmu-v3-common
  iommu/arm-smmu-v3: Move IOMMU registration to arm-smmu-v3-common.c
  iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
  iommu/arm-smmu-v3-kvm: Initialize registers
  iommu/arm-smmu-v3-kvm: Reset the device
  iommu/arm-smmu-v3-kvm: Add host driver for pKVM
  iommu/arm-smmu-v3-kvm: Pass a list of SMMU devices to the hypervisor

Mostafa Saleh (18):
  KVM: arm64: Add a new function to donate memory with prot
  KVM: arm64: Donate MMIO to the hypervisor
  KVM: arm64: pkvm: Add pkvm_time_get()
  iommu/io-pgtable-arm: Split the page table driver
  iommu/arm-smmu-v3: Move queue and table allocation to
    arm-smmu-v3-common.c
  iommu/arm-smmu-v3: Split cmdq code with hyp
  iommu/arm-smmu-v3: Move TLB range invalidation into a macro
  KVM: arm64: iommu: Introduce IOMMU driver infrastructure
  KVM: arm64: iommu: Shadow host stage-2 page table
  KVM: arm64: iommu: Add a memory pool
  KVM: arm64: iommu: Add enable/disable hypercalls
  iommu/arm-smmu-v3-kvm: Setup command queue
  iommu/arm-smmu-v3-kvm: Setup stream table
  iommu/arm-smmu-v3-kvm: Support io-pgtable
  iommu/arm-smmu-v3-kvm: Shadow the CPU stage-2 page table
  iommu/arm-smmu-v3-kvm: Add enable/disable device HVCs
  iommu/arm-smmu-v3-kvm: Allocate structures and reset device
  iommu/arm-smmu-v3-kvm: Add IOMMU ops

 arch/arm64/include/asm/kvm_asm.h              |   2 +
 arch/arm64/include/asm/kvm_host.h             |  14 +
 arch/arm64/kvm/Makefile                       |   3 +-
 arch/arm64/kvm/arm.c                          |   8 +-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h       |  23 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   3 +
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |   2 +
 arch/arm64/kvm/hyp/nvhe/Makefile              |  10 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  19 +
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c         | 129 +++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  80 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  17 +
 arch/arm64/kvm/hyp/nvhe/timer-sr.c            |  33 +
 arch/arm64/kvm/hyp/pgtable.c                  |   9 +-
 arch/arm64/kvm/iommu.c                        |  65 ++
 arch/arm64/kvm/pkvm.c                         |   1 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm/Kconfig                     |   9 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   6 +
 .../arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c  | 114 +++
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 700 ++++++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-common.h      | 624 ++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 393 ++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 904 +-----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 532 +----------
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 676 +++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  51 +
 .../arm/arm-smmu-v3/pkvm/io-pgtable-arm.c     | 115 +++
 drivers/iommu/io-pgtable-arm-common.c         | 694 ++++++++++++++
 drivers/iommu/io-pgtable-arm.c                | 870 +----------------
 drivers/iommu/io-pgtable-arm.h                | 274 +++++-
 31 files changed, 4102 insertions(+), 2280 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
 create mode 100644 arch/arm64/kvm/iommu.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.h
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm.c
 create mode 100644 drivers/iommu/io-pgtable-arm-common.c

-- 
2.50.1.552.g942d659e1b-goog


