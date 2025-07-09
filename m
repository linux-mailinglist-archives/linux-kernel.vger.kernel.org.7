Return-Path: <linux-kernel+bounces-724440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B022AFF2F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42E65A71DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121F243378;
	Wed,  9 Jul 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYOv5jWa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIpwKhZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378A1FF5F9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092836; cv=none; b=TzdVy3YEDrc4/yDcM/WDjy1Bhy0dL/sqbt70bVsrZCiRSNbQ2Qbfyz9vrI+G2XEmfqAxxBDg1sTjgPVtgVdKgaS/baMVoM/tYx0peitjG0eqznBpZBwKyP/5yaGO7cyXUyR+vDsR9ot2XTGAk03ZCmsO5OZW984o0J1v5VfRkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092836; c=relaxed/simple;
	bh=aAJ9CO9TJZsIAKCMKauUGz8l6QuIvGUbq0DSHRR6/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keiWzB2ke1Zd0pp0Rl3iyPDgkk11bQKHMms23UCoisFE5pKDkiCTEpzrZFzNQ43F56/9jSd8dfUkaMKlC+mpgLsKhu2HDXFQW8rvrA0+kpAlcPhgmJzyHxUexdsV25oPUYUYjIewd4pSYqe66xfd1IgWuiYK0AQ24yDUXorSZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rYOv5jWa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIpwKhZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752092833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQPJrJ48atGHYV43MDxx2Tsp1Q8oCNTQ+WipfCzt5ac=;
	b=rYOv5jWa7rI3z6AqImNU+SWJuqCtCy5A3OptyaDyE/sLxakMWXLmtvz/PxTCGi5T4XSqvl
	y62rnN4OB/tZ4wnkRH0YPqrDxwo4bo7nBYDIh5XDysfBmEkBMBQylgmn2Pxj6y3zMZhl6p
	+iSAc6hdPd+fWRBv4dglFO5/sAKVdKiuDhZwXV7Kc5X190OyBTBIkHND13lPZyYtK1yBUj
	xRANPhH4mUw1ZsBcGRGLp9R5CqajAQijWyn9gUAC7dsqpl5lQmse+zqYhJf5BJYAf84fhY
	Gt/BNeETSKfT1IP4EumuE8N/U/il4WJJaMUiUqSY+j5I4EQaX5yn4p/OQ5Oyvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752092833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQPJrJ48atGHYV43MDxx2Tsp1Q8oCNTQ+WipfCzt5ac=;
	b=OIpwKhZJBdUAhTEQX0Q0BmweNJ0q5BgYTsz0NALh4R2tplVLFKj4ZOGmVyLpYerqSlWyKf
	231gx8zTopBy4rCQ==
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
Subject: [PATCH v2 0/6] x86: Disentangle <asm/processor.h> dependency on CPUID headers
Date: Wed,  9 Jul 2025 22:26:27 +0200
Message-ID: <20250709202635.89791-1-darwi@linutronix.de>
In-Reply-To: <20250612234010.572636-1-darwi@linutronix.de>
References: <20250612234010.572636-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Changelog v2
~~~~~~~~~~~~

Remove all CPUID includes from <asm/processor.h> since only the upcoming
CPUID model needed <asm/processor.h> to include <asm/cpuid/types.h> — not
current mainline code.

Let arch/x86/kvm/reverse_cpuid.h include <asm/cpuid/types.h> since it
references its CPUID_EAX to CPUID_EDX macros.  At this series v1, it
implicitly included the CPUID types header through <asm/cpufeature.h>
through <asm/processor.h>.

Drop the "x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs" patch from
this series.  After a second look, it should be part of the CPUID model
PQ instead.

Changelog v1
~~~~~~~~~~~~

( [PATCH v1 0/7] x86: Disentangle <asm/processor.h> dependency on CPUID APIs
  https://lore.kernel.org/lkml/20250612234010.572636-1-darwi@linutronix.de )
  
This series avoids including the full CPUID API from <asm/processor.h>.
That header only needs the CPUID data types and not the full API.

Let <asm/processor.h> include <asm/cpuid/types.h> instead of
<asm/cpuid/api.h>.

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
    drivers/cpufreq/longrun.c
    drivers/cpufreq/powernow-k7.c
    drivers/cpufreq/powernow-k8.c

to explicitly include <asm/cpuid/api.h>.

Based on v6.16-rc5.

Thanks!

8<----

Ahmed S. Darwish (6):
  x86/cpuid: Remove transitional <asm/cpuid.h> header
  ASoC: Intel: avs: Include CPUID header at file scope
  x86: Reorder headers alphabetically
  drivers: Reorder headers alphabetically
  treewide: Explicitly include CPUID headers
  x86/cpu: <asm/processor.h>: Do not include CPUID API header

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
 arch/x86/include/asm/microcode.h             |  1 +
 arch/x86/include/asm/processor.h             |  1 -
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
 arch/x86/kernel/cpu/topology_amd.c           |  1 +
 arch/x86/kernel/cpu/topology_common.c        |  3 +-
 arch/x86/kernel/cpu/topology_ext.c           |  1 +
 arch/x86/kernel/cpu/transmeta.c              |  3 +
 arch/x86/kernel/cpu/zhaoxin.c                |  1 +
 arch/x86/kernel/cpuid.c                      |  1 +
 arch/x86/kernel/paravirt.c                   | 29 ++++-----
 arch/x86/kvm/cpuid.h                         |  3 +
 arch/x86/kvm/mmu/spte.c                      |  1 +
 arch/x86/kvm/reverse_cpuid.h                 |  2 +
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
 49 files changed, 229 insertions(+), 165 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.49.0


