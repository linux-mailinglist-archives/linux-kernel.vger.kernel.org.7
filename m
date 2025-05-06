Return-Path: <linux-kernel+bounces-635191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2589AABA92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5839D3A4660
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B5241CB2;
	Tue,  6 May 2025 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9YsNc2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6XOx6gqb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C9236453
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507892; cv=none; b=nXU67izzljk1zmt+qmKnSiuDJgPYgGoqSPqk6JPst8Fh3aieAEtKxpnDXSNV6kXWJXorko/aa78O8vPck3PvWyOllz/c83JGynHd1YQZD0rPZ62ggHDTDZjlEOYLMOuxnLI0rHo4WhPP0rYQpnqNyKZqrPn7GD6riOYPLsFojKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507892; c=relaxed/simple;
	bh=Dt83nl4B2xzO2NM0lnS4WTVuVcuk3DrT8BLKf1u7RTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp+yvyFJCWBz+Z2BFpf+T7e2IKBKTBkqbVusdmVj3q2fumTitsPoKlHhBici6xKng2dlwxskEaXnjxQ/cuE/VnDizcpbKp8XFMdoh5tdeBnrsMju/3jfagUVR17GLIH020ARNX2D/eDolLM9ZguUn2XRiGwvygumLN9Zi2ZMevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9YsNc2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6XOx6gqb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746507888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RE0FzwBNbP2qiUNlof3w2C9glPDQWBbB4yNrHKQl1mM=;
	b=C9YsNc2ReYS/mqjTnWjFG13n1q9TotSrPvKriPVpxDRGjnyuesOIYBL63K2dkVbwKtqSce
	pGYD7n1N7/d7okC2zw2A6rfBUcqwPczKgGCkAgEyD0tY5EalVUF8txI/XDPHJ08Ek3esGe
	aiL+D3aWSd/3g2HlLCwr0q4LI7VbgaVCIDzwAkOd0AzxXrEK6P6NepbPaaT1jrnBrby1I2
	oifMolkX+uWz/4pKKyAC4N5Pa8wSaR1fxreaA4ArVQ7tneehZAtqOIIKJl1dq40xgj0Qd5
	5OWsY1nQ34Dm1MRa0dXTdBIcMKluLHI0DxgEXOW3QLOtXnBQH8XRnohhEKMLLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746507888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RE0FzwBNbP2qiUNlof3w2C9glPDQWBbB4yNrHKQl1mM=;
	b=6XOx6gqbKNHrQ/VItqbmMQnrv0AD5z02S8V5vDWqRSpdhBdVOryapCbEM5Uk0mOEjA9pm/
	v4WPR2izZa3pshCA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 00/26] x86: Introduce centralized CPUID model
Date: Tue,  6 May 2025 07:04:11 +0200
Message-ID: <20250506050437.10264-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces a CPUID model for the x86 subsystem.

It is based on top of the CPUID refactorings and bugfixes currently
merged at tip:x86/cpu:

    https://lore.kernel.org/lkml/20250304085152.51092-1-darwi@linutronix.de
    https://lore.kernel.org/lkml/20250324133324.23458-1-darwi@linutronix.de
    https://lore.kernel.org/lkml/20250409122233.1058601-1-darwi@linutronix.de
    https://lore.kernel.org/lkml/20250324142042.29010-1-darwi@linutronix.de

First, deploy <asm/cpuid/leaves.h>, as generated by x86-cpuid-db. [*]
The header is in the form:

    /* SPDX-License-Identifier: MIT */
    /* Generator: x86-cpuid-db v2.4 */

    /*
     * Leaf 0x0
     * Maximum standard leaf number + CPU vendor string
     */

    struct leaf_0x0_0 {
     	u32	max_std_leaf		: 32; // Highest standard CPUID leaf supported
     	u32	cpu_vendorid_0		: 32; // CPU vendor ID string bytes 0 - 3
     	u32	cpu_vendorid_2		: 32; // CPU vendor ID string bytes 8 - 11
     	u32	cpu_vendorid_1		: 32; // CPU vendor ID string bytes 4 - 7
    };

    /*
     * Leaf 0x1
     * CPU FMS (Family/Model/Stepping) + standard feature flags
     */

    struct leaf_0x1_0 {
	// eax
	u32	stepping		:  4, // Stepping ID
		base_model		:  4, // Base CPU model ID
		base_family_id		:  4, // Base CPU family ID
		...;
	// ebx
	u32	brand_id		:  8, // Brand index
		clflush_size		:  8, // CLFLUSH instruction cache line size
		n_logical_cpu		:  8, // Logical CPU count
		local_apic_id		:  8; // Initial local APIC physical ID
	// ecx		
	...
    };

    ...

where for each 'struct leaf_0xN_M', N is the leaf number and M is the
subleaf.  The bitfields mirror the x86-cpuid-db kcpuid auto-generated
file, as already merged mainline at tools/arch/x86/kcpuid/cpuid.csv.

Create a 'struct cpuid_leaves' in <cpuid/types.h> to hold scanned CPUID
data:

    struct cpuid_leaves {
     	struct leaf_0x0_0	leaf_0x0_0[1];
     	struct leaf_query_info	leaf_0x0_0_info;

     	struct leaf_0x1_0	leaf_0x1_0[1];
     	struct leaf_query_info	leaf_0x0_0_info;

     	struct leaf_0x4_0	leaf_0x4_0[8];
     	struct leaf_query_info	leaf_0x4_0_info;
     	...
    };

where the 'struct leaf_0xN_M' definitions are auto-generated.  Use arrays
to handle CPUID leaves with uniform subleaf structures, which is typical
for enumerating hierarchical objects; e.g., CPUID(0x4) cache topology
enumeration, CPUID(0xd) XSAVE enumeration, CPUID(0x12) SGX enclaves
enumeration, and CPUID(0x8000001d) AMD cache enumeration.

For each entry in the CPUID table, associate a 'struct leaf_query_info'.
It is to be filled for each available CPUID leaf by the generic CPUID
scanning logic.

Define a 'struct cpuid_table' for caching each CPU's CPUID table, and
embed in it a 'struct cpuid_leaves' instance.  This way, global table
data can also be added.  Embed an instance of 'struct cpuid_table' in the
'struct cpuinfo_x86' CPU capability structure(s):

    struct cpuinfo_x86 {
     	...
     	struct cpuid_table	cpuid_table;
     	...
    };

This way, centralized CPUID data can be accessed on early boot using
'boot_cpu_data', and later on a per-CPU basis using the 'cpu_info'
per-CPU CPU capability structures.

Build the CPUID data in that "struct leaf_0xN_M leaf_0xN_M" format to
facilitate direct CPUID table and CPUID bitfields access.  Accessing
scanned CPUID bitfields can be done using statements like:

    u32 level = cpudata_cpuid(c, 0x0)->max_std_leaf;

    const struct leaf_0x1_0 *l1 = cpudata_cpuid(c, 0x1);
    c->x86_stepping		= l1->stepping;
    c->x86_clflush_size		= l1->clflush_size * 8;

    const struct leaf_0x80000005_0 *el5 = cpudata_cpuid(c, 0x80000005);
    unsigned assoc		= el5->l1_dcache_assoc;
    unsigned line_size		= el5->l1_dcache_line_size;

    unsigned l1d_index = 0;	// CPUID(0x4) subleaf 0: L1 data cache
    unsigned l1i_index = 1;	// CPUID(0x4) subleaf 1: L1 inst cache
    const struct leaf_0x4_0 *l1d = cpudata_cpuid_index(0x4, l1d_index);
    const struct leaf_0x4_0 *l1i = cpudata_cpuid_index(0x4, l1i_index);
    
    /* Then access l1d->cache_nways, l1d->cache_nsets, ... */

where in the above snippet, 'c' is the CPU's capability structure.
Define all macros at <cpuid/table_api.h>, and add proper kernel docs.

Beside the model's centralization benefits, this also avoids using the
ugly manual bit-fiddling common in a lot of CPUID call sites.  The late
part of this PQ clearly shows this.  As a start, switch the following
leaves to scanned CPUID access:

    CPUID(0x0)
    CPUID(0x1)
    CPUID(0x2)
    CPUID(0x4)
    CPUID(0x80000000)
    CPUID(0x80000005)
    CPUID(0x80000006)
    CPUID(0x8000001d)

With these converted, the entirety of the x86/cacheinfo code is void of
any direct CPUID queries.

Introduce the debugfs files 'x86/scanned_cpuid/[0-ncpus]' to dump the
cached CPUID table for each CPU.  This should help with tricky bug
reports in the future, if/when the scanned CPUID tables get
(unexpectedly) out of sync with actual hardware state.  Example output
from an Intel Core i5-8250U laptop:

   $ cat /sys/kernel/debug/x86/scanned_cpuid/cpus/1

    Leaf 0x00000000, subleaf 0:
    cached: EAX=0x00000016	EBX=0x756e6547	ECX=0x6c65746e	EDX=0x49656e69
    actual: EAX=0x00000016	EBX=0x756e6547	ECX=0x6c65746e	EDX=0x49656e69

    Leaf 0x00000001, subleaf 0:
    cached: EAX=0x000806ea	EBX=0x02100800	ECX=0x7ffafbbf	EDX=0xbfebfbff
    actual: EAX=0x000806ea	EBX=0x02100800	ECX=0x7ffafbbf	EDX=0xbfebfbff

    Leaf 0x00000002, subleaf 0:
    cached: EAX=0x76036301	EBX=0x00f0b5ff	ECX=0x00000000	EDX=0x00c30000
    actual: EAX=0x76036301	EBX=0x00f0b5ff	ECX=0x00000000	EDX=0x00c30000

    Leaf 0x00000004, subleaf 0:
    cached: EAX=0x1c004121	EBX=0x01c0003f	ECX=0x0000003f	EDX=0x00000000
    actual: EAX=0x1c004121	EBX=0x01c0003f	ECX=0x0000003f	EDX=0x00000000

    Leaf 0x00000004, subleaf 1:
    cached: EAX=0x1c004122	EBX=0x01c0003f	ECX=0x0000003f	EDX=0x00000000
    actual: EAX=0x1c004122	EBX=0x01c0003f	ECX=0x0000003f	EDX=0x00000000

    Leaf 0x00000004, subleaf 2:
    cached: EAX=0x1c004143	EBX=0x00c0003f	ECX=0x000003ff	EDX=0x00000000
    actual: EAX=0x1c004143	EBX=0x00c0003f	ECX=0x000003ff	EDX=0x00000000

    Leaf 0x00000004, subleaf 3:
    cached: EAX=0x1c03c163	EBX=0x02c0003f	ECX=0x00001fff	EDX=0x00000006
    actual: EAX=0x1c03c163	EBX=0x02c0003f	ECX=0x00001fff	EDX=0x00000006

    Leaf 0x80000000, subleaf 0:
    cached: EAX=0x80000008	EBX=0x00000000	ECX=0x00000000	EDX=0x00000000
    actual: EAX=0x80000008	EBX=0x00000000	ECX=0x00000000	EDX=0x00000000

    Leaf 0x80000005, subleaf 0:
    cached: EAX=0x00000000	EBX=0x00000000	ECX=0x00000000	EDX=0x00000000
    actual: EAX=0x00000000	EBX=0x00000000	ECX=0x00000000	EDX=0x00000000

    Leaf 0x80000006, subleaf 0:
    cached: EAX=0x00000000	EBX=0x00000000	ECX=0x01006040	EDX=0x00000000
    actual: EAX=0x00000000	EBX=0x00000000	ECX=0x01006040	EDX=0x00000000

The first patch in the series is an independent bugfix.

Thanks!

[*] https://gitlab.com/x86-cpuid.org/x86-cpuid-db
    https://x86-cpuid.org

8<-----

Ahmed S. Darwish (26):
  tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.4
  x86/cpu: Sanitize CPUID(0x80000000) output
  x86/cpuid: Introduce <asm/cpuid/leaves.h>
  x86/cpuid: Introduce centralized CPUID data
  x86/cpuid: Introduce CPUID scanner
  x86/cpuid: Scan CPUID(0x80000000)
  x86/cpuid: Introduce debugfs 'x86/scanned_cpuid/[0-ncpus]'
  x86/cpuid: Introduce external CPUID table accessors
  x86/cpu: Use scanned CPUID(0x0)
  x86/cpu: Use scanned CPUID(0x80000001)
  x86/lib: Add CPUID(0x1) CPU family and model calculation
  x86/cpu: Use scanned CPUID(0x1)
  x86/cpuid: Scan CPUID(0x2)
  x86/cpuid: Introduce scanned CPUID(0x2) API
  x86/cpu: Use scanned CPUID(0x2)
  x86/cacheinfo: Use scanned CPUID(0x2)
  x86/cpuid: Remove direct CPUID(0x2) query API
  x86/cpuid: Scan deterministic cache params CPUID leaves
  x86/cacheinfo: Use scanned CPUID(0x4)
  x86/cacheinfo: Use scanned CPUID(0x8000001d)
  x86/cpuid: Scan CPUID(0x80000005) and CPUID(0x80000006)
  x86/cacheinfo: Use auto-generated data types
  x86/cacheinfo: Use scanned CPUID(0x80000005) and CPUID(0x80000006)
  x86/cpuid: scanner: Add CPUID table rescan support
  x86/cpu: Rescan CPUID table after PSN disable
  x86/cpu: Rescan CPUID table after unlocking the full CPUID range

 MAINTAINERS                               |    1 +
 arch/x86/include/asm/cpu.h                |    6 +
 arch/x86/include/asm/cpuid.h              |    1 +
 arch/x86/include/asm/cpuid/internal_api.h |   62 +
 arch/x86/include/asm/cpuid/leaf_0x2_api.h |   57 +-
 arch/x86/include/asm/cpuid/leaves.h       | 2055 +++++++++++++++++++++
 arch/x86/include/asm/cpuid/table_api.h    |  120 ++
 arch/x86/include/asm/cpuid/types.h        |   74 +
 arch/x86/include/asm/processor.h          |    1 +
 arch/x86/kernel/cpu/Makefile              |    2 +
 arch/x86/kernel/cpu/cacheinfo.c           |  280 +--
 arch/x86/kernel/cpu/common.c              |   65 +-
 arch/x86/kernel/cpu/cpuid_debugfs.c       |   98 +
 arch/x86/kernel/cpu/cpuid_scanner.c       |  209 +++
 arch/x86/kernel/cpu/cpuid_scanner.h       |  117 ++
 arch/x86/kernel/cpu/intel.c               |   17 +-
 arch/x86/lib/cpu.c                        |   41 +-
 tools/arch/x86/kcpuid/cpuid.csv           |    4 +-
 18 files changed, 2926 insertions(+), 284 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/internal_api.h
 create mode 100644 arch/x86/include/asm/cpuid/leaves.h
 create mode 100644 arch/x86/include/asm/cpuid/table_api.h
 create mode 100644 arch/x86/kernel/cpu/cpuid_debugfs.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_scanner.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_scanner.h

base-commit: 06e09002bc1d46505d6b3bd947ebaf3cec7acab8
-- 
2.49.0


