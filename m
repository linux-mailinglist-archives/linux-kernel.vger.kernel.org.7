Return-Path: <linux-kernel+bounces-724448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B367EAFF302
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18473B1D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1922D4DD;
	Wed,  9 Jul 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpxKj+w1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOtNHqny"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AFE18A6DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093039; cv=none; b=IdCQjRaZ0QaS6bYaR93XJuG2vBhRRBDguGqlKA7WZBp2mr5BeWumH1tX3uczBrEfWlfBp38U2h7FyL5Av+LqY/FpYjOlVL+w73z6vh5qn/n8knEMmd6VAbeO81sCYDRM0q7eIVbMW6KrPVFrU3cJ4ISdGXu2Nw+KIKIqQTCL4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093039; c=relaxed/simple;
	bh=aAJ9CO9TJZsIAKCMKauUGz8l6QuIvGUbq0DSHRR6/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLaQZRY+MrqZ3wr8HsObBzy5cPF9+QdRk8T4A8jjacKHtl+BMkyWbxjQ/orCT+AeA5yv+mHJ2uZVuufZIjh6JEIoQeVmD8/cOXnQh6TwL6t5h4M6/sfH2VQ94z945LspdXmHfPd8Dp0ppI3gcjP66i4zsU4eZ4CopOFSJILq0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpxKj+w1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOtNHqny; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752093036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQPJrJ48atGHYV43MDxx2Tsp1Q8oCNTQ+WipfCzt5ac=;
	b=kpxKj+w1g0su5ONGbWTLvyWmIa4hs8s6/eDiq+uNLp7SWpyRnDLeB5MMCQw/xXsQ2vj+cj
	8DexiPoFuS4y33XgrHLL4KtXlBIojwvPtEHZBdc8xcVgZf4cKtXpo/3MVxJrI12WupRvuG
	PGNw2/9LvLU+W4D78k6IBjKhjckrNFT/FpKdt2JNIS8I9qZ+rDi8JDBlR7MBDMrCCweJ2g
	ao/0Xhm15g3qxz0Dl/WMkyr2j7s27EuNdJfqu85uPVDnICeF+yPFRZx7mVmpRIUQocjJRA
	Y0FAkTpD78RtQxR7m71IsHzj5OQkSLYJPxstGSc1Xf6GRqa0QlboxZyS7FsDLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752093036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQPJrJ48atGHYV43MDxx2Tsp1Q8oCNTQ+WipfCzt5ac=;
	b=iOtNHqnyTG18O2qBeGx33/S9h3kPmJmuVeugvsVhTW61BtgxnR0fBQrXBwjzNvAg+dEz19
	xnFDWSZ2bpGvZLBQ==
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
Date: Wed,  9 Jul 2025 22:30:26 +0200
Message-ID: <20250709203033.90125-1-darwi@linutronix.de>
In-Reply-To: <20250709170454.74854-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
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


