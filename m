Return-Path: <linux-kernel+bounces-724164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4EBAFEF5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF3585D90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172252236F4;
	Wed,  9 Jul 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="26zMKA1B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="920GCBly"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B13222593
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080755; cv=none; b=QK4MpnkKBFOU7V9vYZcexMVB83tujwzXvjIUtpRtYzuucG2MoOr5rTj0w/7x2fDy3CS9DoyvuPGIr9KsrgQ0EnpMdAOl4OPy4cBs8lzy6ogCutFfVejwjPuHlR0689zS5KEH32p9lbl7+p2ZEb0kz/LQf0Cy0RxvF/CIQrnhhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080755; c=relaxed/simple;
	bh=A0G4H8bFuqnqiTXuCjWbiwsUJVx82gdpTgPkj3RdNM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azpfVTQ4Zr9DSMUoKxM0JV6Hybtj+PmrMLS2Q/c43T6PTu+QSf8O3XPOVmnUjJBt9mBy0PlbrXdnUbg/eVKvYl39kUEgOHgGcFIuLfBk1lGSAO1B0TQANI317fOTEHt++g/JA6SqWLsvHhKWSFPPErLGF73jTyhN7xzDZNv3MSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=26zMKA1B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=920GCBly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752080750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LM3qQLQa6SKBGtPoteE/M1Ffa5SV889eaJhM4o1iua4=;
	b=26zMKA1BI/7jtNaIh+9fZdhRin2ltLpBQJ31R4SmB8zv6WD9B8IXauNPFVvKsh+jzRbuwM
	K7eyJ2CpQt/OwuqFuqEJs9lXqo8h+mth79PU30zDFAl00IZtkBSllrkW+PsY5gHqyZIQL9
	rc7ETG+N0g72EfRCp6gTrtOxmIFF8UjHRYWd0jvccihwsOJiv7UXpL0Ekks4vvvvqoKrIr
	9imVcGgbZu5dAq+vy/jd22chyX5uk5eVGVToGfB8svKvU0vGJAE2XAjruYxDrMkNaAkbK2
	hkq/aI1yLEEkmK5gFeuhywSA9HhLYNtZ+nxIpWCu8xkZLTctjKXDUb70F+3naQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752080750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LM3qQLQa6SKBGtPoteE/M1Ffa5SV889eaJhM4o1iua4=;
	b=920GCBlywpol85C01s1e5q7p6B8OxhBrsIKdlPLvAvdc6MhtXjHtJuSKkiJf1/vRxyMOJa
	AKRWvDHe72uWewAw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 0/7] x86: Disentangle <asm/processor.h> dependency on CPUID APIs
Date: Wed,  9 Jul 2025 19:04:46 +0200
Message-ID: <20250709170454.74854-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series avoids including the full CPUID API from <asm/processor.h>.
That header only needs the CPUID data types and not the full API.

Replace the <asm/cpuid/api.h> inclusion in <asm/processor.h> with an
include of <asm/cpuid/types.h>.

Modify all CPUID call sites which implicitly included the CPUID API
though <asm/processor.h> to explicitly include <asm/cpuid/api.h> instead.

This work prepares for an upcoming v4 of the CPUID model:

    [PATCH v3 00/44] x86: Introduce a centralized CPUID data model
    https://lore.kernel.org/lkml/20250612234010.572636-1-darwi@linutronix.de

where <asm/cpuid/api.h> needs to include <asm/processor.h>, thus creating
a circular dependency if not resolved beforehand…  Patches 1->19 of the
v3 above had parts of this series circular dependency disentanglement.

Per Boris' remarks above, merge the header includes reorderings into two
patches only: one patch for x86 and one for drivers.

The 0-day bot x86-32 compilation error:

    Re: [PATCH v3 41/44] x86/cpu: <asm/processor.h>: Do not include CPUID…
    https://lore.kernel.org/lkml/202506132039.imS2Pflx-lkp@intel.com

is also fixed in this series.

Beside the call sites converted at CPUID model v3 above, this series also
switches below files:

    arch/x86/kernel/cpu/microcode/core.c
    arch/x86/kernel/cpu/microcode/intel.c
    arch/x86/kernel/cpu/mshyperv.c
    arch/x86/kvm/lapic.c
    arch/x86/kvm/svm/sev.c
    drivers/acpi/acpi_processor.c
    drivers/acpi/processor_core.c
    drivers/cpufreq/longrun.c
    drivers/cpufreq/powernow-k7.c
    drivers/cpufreq/powernow-k8.c
    drivers/hwtracing/coresight/coresight-platform.c
    drivers/xen/xen-acpi-processor.c

to explicitly include <asm/cpuid/api.h>.

Based on v6.16-rc5.

Note, the last patch is a CPUID API naming change in preparation for the
model as well.  It can be skipped if merging it is not desired at this
stage.

Thanks!

8<-----

Ahmed S. Darwish (7):
  x86/cpuid: Remove transitional <asm/cpuid.h> header
  ASoC: Intel: avs: Include CPUID header at file scope
  x86: Reorder headers alphabetically
  drivers: Reorder headers alphabetically
  treewide: Explicitly include <asm/cpuid/api.h>
  x86/cpu: <asm/processor.h>: Do not include CPUID API header
  x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs

 arch/x86/boot/compressed/pgtable_64.c        |  1 +
 arch/x86/boot/startup/sme.c                  |  9 +--
 arch/x86/coco/tdx/tdx.c                      |  6 +-
 arch/x86/events/amd/core.c                   |  2 +
 arch/x86/events/amd/ibs.c                    |  1 +
 arch/x86/events/amd/lbr.c                    |  2 +
 arch/x86/events/amd/power.c                  |  3 +
 arch/x86/events/amd/uncore.c                 | 15 ++---
 arch/x86/events/intel/core.c                 |  1 +
 arch/x86/events/intel/lbr.c                  |  1 +
 arch/x86/events/zhaoxin/core.c               | 12 ++--
 arch/x86/include/asm/acrn.h                  |  2 +
 arch/x86/include/asm/cpuid.h                 |  8 ---
 arch/x86/include/asm/cpuid/api.h             |  6 +-
 arch/x86/include/asm/microcode.h             |  1 +
 arch/x86/include/asm/processor.h             |  2 +-
 arch/x86/include/asm/xen/hypervisor.h        |  1 +
 arch/x86/kernel/cpu/amd.c                    | 26 ++++----
 arch/x86/kernel/cpu/centaur.c                |  1 +
 arch/x86/kernel/cpu/hygon.c                  |  1 +
 arch/x86/kernel/cpu/mce/core.c               | 63 ++++++++++----------
 arch/x86/kernel/cpu/mce/inject.c             |  1 +
 arch/x86/kernel/cpu/microcode/core.c         | 23 +++----
 arch/x86/kernel/cpu/microcode/intel.c        | 12 ++--
 arch/x86/kernel/cpu/mshyperv.c               | 29 +++++----
 arch/x86/kernel/cpu/resctrl/core.c           |  6 +-
 arch/x86/kernel/cpu/resctrl/monitor.c        |  1 +
 arch/x86/kernel/cpu/scattered.c              |  3 +-
 arch/x86/kernel/cpu/sgx/main.c               |  3 +
 arch/x86/kernel/cpu/topology_amd.c           |  3 +-
 arch/x86/kernel/cpu/topology_common.c        |  3 +-
 arch/x86/kernel/cpu/topology_ext.c           |  3 +-
 arch/x86/kernel/cpu/transmeta.c              |  3 +
 arch/x86/kernel/cpu/zhaoxin.c                |  1 +
 arch/x86/kernel/cpuid.c                      |  6 +-
 arch/x86/kernel/paravirt.c                   | 29 ++++-----
 arch/x86/kvm/cpuid.h                         |  3 +
 arch/x86/kvm/mmu/spte.c                      |  1 +
 drivers/cpufreq/longrun.c                    |  7 ++-
 drivers/cpufreq/powernow-k7.c                | 14 ++---
 drivers/cpufreq/powernow-k8.c                | 17 +++---
 drivers/cpufreq/speedstep-lib.c              |  6 +-
 drivers/firmware/efi/libstub/x86-5lvl.c      |  1 +
 drivers/hwmon/fam15h_power.c                 | 14 +++--
 drivers/hwmon/k10temp.c                      |  2 +
 drivers/hwmon/k8temp.c                       | 12 ++--
 drivers/thermal/intel/intel_hfi.c            |  1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 15 ++---
 sound/soc/intel/avs/tgl.c                    | 25 +++++---
 49 files changed, 235 insertions(+), 173 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.49.0


