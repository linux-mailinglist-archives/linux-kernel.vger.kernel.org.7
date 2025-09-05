Return-Path: <linux-kernel+bounces-802824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB04B45777
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113705C27E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86D5475E;
	Fri,  5 Sep 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="edj1Iy8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alqr6W/0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BC345738
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074524; cv=none; b=qdLqoGNU+kTQ+P+DK9swDSKhiPHOvdlSxh6jiavLzLvtbKgxjtAjkNDKtL8y06Je/QKBXW7duYrV0uL6fT+X2uU0q/J4epiQlmImQKTeJXJcWvQ+JBjA2fXE//OqkInCZn0wsr9ITGIKz0/WcpkBC5H3mklSNYhssCaLFNtCsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074524; c=relaxed/simple;
	bh=uUrOoxxEtBBQco8q2pTs5vNtczuV8IgF/1OO5wMbgpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AY1clqqVy559riJ5C443Dc1Qb3fO1+UKz8QcAqfR8kjKcv7eVFm80Q/qZE5kL9KSguAfRo0tZGT4pzs/ilcJcyflgAPkY5Ci7u8wXhKAjXDn3ui78yjIFGvHzB+bny0lCexw9dAhXiQfpXBE2tGHHiVhLgw8yetQYrhrbSDjQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=edj1Iy8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alqr6W/0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ipHhnLFXZje9OcKfaFz59t1kxOa0l2R4IyNpNFOYv5g=;
	b=edj1Iy8+j1ov4z03jJ24JYHdgBv+qFjNWuYg6FoMrBVmZ7AuW6fBuxMHpL9Al5ALsV9Qm8
	EKii65rAk3D71Jrqa0woozt52KtnPVr6ufpMXjwSVKUl0Hnpm0Nmx6QEEA8c5KVAx7g4NI
	RI4tgOBUrQ/3JtETDtIXEIZHT5/UgtJ5QB9g01EExJ11R4Rcrd2YXHq9I9ek6TbirA0UZl
	YJ56Ia23XjfhTvIbhIkGamIM2pcjBehbFBjB/a4dFsBlDnzIvBR0qYirijjXCQ35MGJV0L
	VkQNFvt8lbwgVOspnQnEoneWV5UmKM81NJy2WbMMl+G41eV2G27/J97XtveS2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ipHhnLFXZje9OcKfaFz59t1kxOa0l2R4IyNpNFOYv5g=;
	b=alqr6W/0k5dwB0MY+k4hutlE1bhp9midB5e9xs7XiSp98W4t5w+TsrLD1mtKP4SL3NgVCM
	CmINVKPG8Za9/4BA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 00/35] x86: Introduce a centralized CPUID data model
Date: Fri,  5 Sep 2025 14:14:40 +0200
Message-ID: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series introduces a centralized CPUID model for the x86 subsystem.

Rationale for this work can be found at:

    https://lore.kernel.org/lkml/874ixernra.ffs@tglx

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db

The first 4 patches can be independently applied.

Patch #5 is already at tip:x86/cpu, but it is included here since it
conflicts with a lot of patches later in the queue.

Changelog v5
~~~~~~~~~~~~

* Thanks a lot to Sean Christopherson for his very valuable feedback on
  the last iteration!  The CPUID parser API now becomes:

    /*
     * For CPUID leaves with a dynamic subleaf range
     */

    cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf)
    cpuid_subleaf_n_raw(_cpuinfo, _leaf, _subleaf)
    cpuid_subleaf_count(_cpuinfo, _leaf)

    /*
     * For CPUID leaves with a static, compile-time, subleaf
     */

    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_leaf_raw(_cpuinfo, _leaf)
    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)

* Add compile-time safety checks for the new cpuid_subleaf_n() API:

    /*
     * Correct API usage
     */

    const struct leaf_0xd_0 *ld0	= cpuid_subleaf(c, 0xd, 0);
    const struct leaf_0xd_1 *ld1	= cpuid_subleaf(c, 0xd, 1);
    const struct leaf_0xd_n *ldn	= cpuid_subleaf_n(&boot_cpu_data, 0xd, 2);

    /*
     * Compile-time failure: Using the dynamic API for the static
     * subleaves CPUID(0xd).1 and CPUID(0xd).2
     */

    cpuid_subleaf_n(&boot_cpu_data, 0xd, 0);
    cpuid_subleaf_n(&boot_cpu_data, 0xd, 1);

    /*
     * Compile-time failure: Requested subleaf > max dynamic subleaf
     * CPUID(0xd).n, n > 62
     */

    cpuid_subleaf_n(&boot_cpu_data, 0xd, 63);

    /*
     * Compile-time failure: Requested subleaf < min dynamic subleaf
     * CPUID(0xd).n, n < 2
     */

    const struct leaf_0xd_n *l;
    for (int i = XFEATURE_SSE; i < XFEATURE_MAX; i++) {
	l = cpuid_subleaf_n(c, 0xd, i);
    }

* Mandate that all call sites access the model's cached centralized CPUID
  data through const pointers:

    /*
     * Compile-time failure: lvalue needs a 'const' qualifier
     */

    struct leaf_0x0_0 *l0 = cpuid_leaf(c, 0x0);

* Integrate x86-cpuid-db 'v2.5' release, which was just pushed out:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.5/CHANGELOG.rst

  This releases generates the symbols necessary for the new CPUID API.

  At <asm/cpuid/leaf_types.h>, we now have the following types and CPP
  symbols for CPUID leaves with a dynamic subleaf range:

    struct leaf_0x4_n { ... };
    struct leaf_0xb_n { ... };
    struct leaf_0xd_n { ... };
    ...

    #define LEAF_0x4_SUBLEAF_N_FIRST	0
    #define LEAF_0x4_SUBLEAF_N_LAST	31

    #define LEAF_0xb_SUBLEAF_N_FIRST	0
    #define LEAF_0xb_SUBLEAF_N_LAST	1

    #define LEAF_0xd_SUBLEAF_N_FIRST	2
    #define LEAF_0xd_SUBLEAF_N_LAST	63
    ...

  That v2.5 release also includes some bitfield and leaf descriptions
  verbosity cleanups requested by Boris over LKML, plus a new AMD bit
  ("Page Modification Logging") and better CPUID(0xd) XSAVE area size
  caclculation descriptions.

* Convert CPU brand string leaves, CPUID(0x80000002) -> CPUID(0x80000004),
  to the new centralized model.  They only have a single simple callsite.

* Call-site patche changes vs. previous iterations:

  - Patch 26/35 ("x86/cacheinfo: Use parsed CPUID(0x4)") now removes a
    CPUID max level check that is not needed.

  - Patche 26-27/35 ("x86/cacheinfo: Use parsed CPUID(0x4)") and
    ("x86/cacheinfo: Use parsed CPUID(0x8000001d)") now check
    cpuid_subleaf_n() outputs for NULL.  This sticks to the CPUID parser
    APIs contract.

* State of affairs:

  Below are the CPUID leaves converted to the model:

    CPUID(0x0)
    CPUID(0x1)			# except CPU feature flags
    CPUID(0x2)
    CPUID(0x4)
    CPUID(0x16)
    CPUID(0x80000000)
    CPUID(0x80000002)
    CPUID(0x80000003)
    CPUID(0x80000004)
    CPUID(0x80000005)
    CPUID(0x80000006)
    CPUID(0x8000001d)

  Remaining leaves have dependencies on X86_FEATURE.  For example, some
  callsites _directly_ enumerate CPUID(0x15), [ grep for ART_CPUID_LEAF
  and CPUID_LEAF_TSC ], even though that leaf has important dependencies
  on X86_FEATURE_ART and its tsc_async_resets flag.

  The CPUID parser will need to integrate the X86_FEATURE dependencies
  machinery first, before converting such call sites.  Integrating the
  X86_FEATURE machinery will also allow us to use this centralized CPUID
  model for the <asm/cpufeatures.h> flags enumerated through CPUID(0x1),
  CPUID(0x7), CPUID(0x80000001), and CPUID(0x80000008).

* Testing: each mainline iteration is tested on multiple Intel and AMD
  machines, comparing the before and after of:

    /proc/cpuinfo				
    /sys/devices/system/cpu/
    /sys/kernel/debug/x86/topo/    
    /sys/bus/event_source/devices/intel_pt/	

  plus manual inspection of the new 'x86/cpuid/N' CPUID table debugfs
  files.

Changelog v4
~~~~~~~~~~~~

( Subject: [PATCH v4 00/34] x86: Introduce a centralized CPUID data model
  https://lore.kernel.org/lkml/20250815070227.19981-1-darwi@linutronix.de )

* Add x86 vendor support to the model.

  Attach a "compatible x86 vendors" list to CPUID leaves which are vendor
  specific; e.g., CPUID(0x2), CPUID(0x4), CPUID(0x16), and
  CPUID(0x8000001d).

  Split the CPUID parsing table into an "early boot" table and a standard
  one.  The early boot phase parses only CPUID(0x0) and CPUID(0x1), where
  they will be needed to identify the CPU's x86 vendor.

  Once the kernel boot code saves the vendor info to the boot CPU's
  capability structure, invoke the CPUID parser again to parse the rest
  of the CPUID leaves.  In that second phase, the parser assumes that
  "boot_cpu_data.x86_vendor" is valid and uses it for CPUID leaf x86
  vendor validity checks.

  This offers the following benefits:

    (a) Even when a CPUID leaf falls within a CPU's standard or extended
    maximum leaf range, querying architecturally unsupported and reserved
    CPUID leaves may trigger new kernel boot behaviors or subtle bugs,
    especially on legacy machines.

    (b) Associating x86 vendor information with CPUID leaves enables the
    CPUID parser to emit (lightweight) error messages when malformed
    CPUID leaf output is detected.  This is due to the parser now being
    more certain that the queried leaf is valid on the machine.

    (c) Attaching x86 vendor information to CPUID leaves relieves call
    sites, especially drivers, from ugly x86 vendor checks before
    querying a CPUID leaf.  If the CPUID parsers API like cpuid_leaf() or
    cpuid_subleaf() return NULL, it simply implies the leaf is
    unavailable (or should not be queried) on the current machine.

* CPUID(0x2) parsing error messages was dropped on v3, as they triggered
  false positives on AMD machines.  Restore the error messages back,
  since now CPUID(0x2) is enumerated only on supported Intel(-like) CPUs.

* Add CPUID(0x16) support to the parser.  It shows a nice case of x86
  vendor checks and maximum standard leaf checks being removed from the
  call site.  Thus, transforming the TSC code below:

    static unsigned long cpu_khz_from_cpuid(void)
    {
  	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;

  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
  		return 0;

  	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
  		return 0;

  	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
  	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, ...);

  	return eax_base_mhz * 1000;
    }

  to just:

    static unsigned long cpu_khz_from_cpuid(void)
    {
	const struct leaf_0x16_0 *l16 = cpuid_leaf(&boot_cpu_data, 0x16);

	return l16 ? (l16->cpu_base_mhz * 1000) : 0;
    }

* Include the CPUID headers disentanglement work (v5):

    [PATCH v5 0/4] x86: Disentangle <asm/processor.h> dependency on CPUID headers
    https://lore.kernel.org/lkml/20250724193706.35896-1-darwi@linutronix.de

  to the top of this PQ, as they are needed by the CPUID parser.

Changelog v3
~~~~~~~~~~~~

( [PATCH v3 00/44] x86: Introduce a centralized CPUID data model
  https://lore.kernel.org/lkml/20250612234010.572636-1-darwi@linutronix.de )

* Transform the final CPUID(0x80000006) call site, inline C function
  cpuid_amd_hygon_has_l3_cache() at <asm/cpuid/api.h>, to the new parsed
  CPUID API.

  Due to this C inline function requiring access to 'struct cpuinfo_x86',
  a circular dependency emerged in the headers:

    <asm/cpuid/api.h>    includes    <asm/processor.h>	# for 'struct cpuinfo_x86'
    <asm/processor.h>    includes    <asm/cpuid/api.h>	# for CPUID types

  Turns out, <asm/processor.h> does not need <asm/cpuid/api.h>, and
  <asm/cpuid/types.h> is enough for it.

  Thus, let <asm/processor.h> include <asm/cpuid/types.h> instead.

  For all call sites that included the CPUID API header implicitly
  through <asm/processor.h>, transform them to explicitly include
  <asm/cpuid/api.h> instead.

  This asm/processor.h<=>CPUID-API headers disentanglement is done by
  patches 1=>19.

* Initially (at v1, v2), there were two CPUID parser functions to fill a
  CPUID table: cpuid_parser_scan_cpu() and cpuid_parser_rescan_cpu().
  The latter zeroed-out the CPUID table beforehand, while the former did
  not.

  For v3, let the CPUID parser provide only one function where the CPUID
  table is always zeroed beforehand: cpuid_parser_scan_cpu(),

  Rationale for this decision is explained at patch 21/44 ("x86/cpuid:
  Introduce a centralized CPUID parser"), inside
  cpuid_parser_scan_cpu()'s implementation.

* Minimize the code for leaf-specific CPUID parser code by removing some
  redundant steps: remove initial zeroing of "output->info->nr_entries",
  remove a static assert, etc.

* Drop the v2 patch, ("x86/cpuid: Warn once on invalid CPUID(0x2)
  iteration count"), from this model v3.  On AMD machines with zeroed
  CPUID(0x2) output, a false warning will be triggered.

  This is because the CPUID model generic leaves parser has no vendor
  filtering so far; i.e. all CPUID leaves are queried on all CPU vendors.
  This keeps the parser simple, but I'll think a bit if adding minimal
  vendor filtering will be useful for this PQ's next iteration.

* Apply more CPUID parser code readability enhancements.

* Series is on top of v6.16-rc1.

Changelog v2
~~~~~~~~~~~~

( [PATCH v2 00/27] x86: Introduce a centralized CPUID data model
  https://lore.kernel.org/x86-cpuid/20250605192356.82250-1-darwi@linutronix.de )

* Pre-requisite CPUID headers cleanups, requested by Ingo, are now merged:

    [PATCH v1 0/9] x86/cpuid: Headers cleanup
    https://lore.kernel.org/lkml/20250508150240.172915-1-darwi@linutronix.de

    [PATCH v2 0/2] x86/cpuid: Headers cleanup
    https://lore.kernel.org/lkml/20250515202143.34448-1-darwi@linutronix.de

  This v2 series is rebased on top of the above restructuring, where the
  CPUID headers become:

    include/asm/cpuid/
    ├── api.h
    ├── leaf_types.h		// x86-cpuid-db auto-generated file
    └── types.h

* At <asm/cpuid/api.h>, add a clear rational for call sites to use the
  new API:

   /*
    * External APIs for accessing parsed CPUID data:
    *
    * Call sites should use below APIs instead of invoking direct CPUID
    * queries.  Benefits include:
    *
    * - Return CPUID output as typed C structures that are auto-generated
    *   from a centralized database (see <cpuid/leaf_types.h).  Such data
    *   types have a full C99 bitfield layout per CPUID leaf/subleaf
    *   combination.  Call sites can thus avoid doing ugly and cryptic
    *   bitwise operations on raw CPUID data.
    *
    * - Return cached, per-CPU, CPUID output.  Below APIs do not invoke
    *   any CPUID queries, thus avoiding their side effects like
    *   serialization and VM exits.  Call-site-specific hard coded
    *   constants and macros for caching CPUID query outputs can also be
    *   avoided.
    *
    * - Return sanitized CPUID data.  Below APIs return NULL if the given
    *   CPUID leaf/subleaf input is not supported by hardware, or if the
    *   hardware CPUID output was deemed invalid by the CPUID parser.
    *   This centralizes all CPUID data sanitization in one place (the
    *   kernel's CPUID parser.)
    *
    * - A centralized global view of system CPUID data.  Below APIs will
    *   reflect any kernel-enforced feature masking or overrides, unlike
    *   ad hoc parsing of raw CPUID output by drivers and individual call
    *   sites.
    */

* Since this model's APIs will be the official kernel CPUID API, free the
  cpuid_subleaf() and cpuid_leaf() namespace and dedicate it to the model:

    patch 02/27 ("x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs")

  After some local iterative work, I've found below API names to make the
  most sense.  They look "so obvious" now, which is IMHO a good sign.
  The CPUID model APIs become:

    /*
     * For CPUID leaves with static, compile-time, subleaves
     */

    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)
    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_leaf_regs(_cpuinfo, _leaf)

    /*
     * For CPUID leaves with dynamic subleaves
     */

    cpuid_subleaf_index(_cpuinfo, _leaf, _idx)
    cpuid_subleaf_index_regs(_cpuinfo, _leaf, _idx)
    cpuid_subleaf_count(_cpuinfo, _leaf)

  The difference between the static and dynamic parts of the API is
  described in detail at patch 04/27 ("x86/cpuid: Introduce a centralized
  CPUID data model").

  In general, all of the above APIs translate to a /single/ assembly
  instruction offset calculation.  For example:

    const struct leaf_0x7_0 *l7_0;
    const struct leaf_0x7_1 *l7_1;

    l7_0 = cpuid_subleaf(c, 0x7, 0);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_0[0]

    l7_1 = cpuid_subleaf(c, 0x7, 1);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_1[0]

* Per Ingo's feedback, avoid the "CPUID scanner" terminology and
  standardize on "CPUID parser".  Use the new terminology for all of the
  relevent data structures, functions, and file names: "cpuid_parser.h",
  cpuid_parser.c, 'struct cpuid_parse_entry', cpuid_parser_scan_cpu(),
  cpuid_parser_rescan_cpu(), etc.

* Standardize on "__cpuid_leaves_" and "__cpuid_table_" prefixes for all
  of the <cpuid/api.h> macros that are intended for internal CPUID usage.

* Apply multiple code clarity enhancements to the CPUID parser.  No
  change in functionality.

* For the series main patch, 04/27 ("x86/cpuid: Introduce a centralized
  CPUID data model"), expand it with full design and implementation
  details rational.

* Per Sohil's feedback, apply output formatting enhancements to the new
  CPUID debugfs files x86/cpuid/[0-ncpu]:

    patch 07/27 ("x86/cpuid: Introduce CPUID parser debugfs interface")

* Per Ingo's feedback, (lightly) log the cases where the CPUID parser
  encounters bogus hardware CPUID data:

    patch 13/27 ("x86/cpuid: Warn once on invalid CPUID(0x2) iteration count")

* Per Ingo's feedback, break CPUID(0x4) call-site patch into:

    patch 19/27 ("x86/cacheinfo: Pass a 'struct cpuinfo_x86' refrence to CPUID(0x4) code")
    patch 20/27 ("x86/cacheinfo: Use parsed CPUID(0x4)")

* Enhance all of the project's APIs kernel-doc.

* Massage all commit logs and code comments for overall clarity.

Changelog v1
~~~~~~~~~~~~

( [PATCH v1 00/26] x86: Introduce centralized CPUID model
  https://lore.kernel.org/lkml/20250506050437.10264-1-darwi@linutronix.de )

This series introduces a CPUID model for the x86 subsystem.

It is based on top of the CPUID refactorings and bugfixes currently
merged at tip:x86/cpu:

    [PATCH v1 00/40] x86: Leaf 0x2 and leaf 0x4 refactorings
    https://lore.kernel.org/lkml/20250304085152.51092-1-darwi@linutronix.de

    [PATCH v4 00/29] x86: Leaf 0x2 and leaf 0x4 refactorings
    https://lore.kernel.org/lkml/20250324133324.23458-1-darwi@linutronix.de

    [PATCH v2 0/2] x86/cacheinfo: Fixes for CPUID(0x80000005) and CPUID(0x80000006)
    https://lore.kernel.org/lkml/20250409122233.1058601-1-darwi@linutronix.de

    [PATCH v1 0/2] x86: CPUID refactorings: follow-up
    https://lore.kernel.org/lkml/20250411070401.1358760-1-darwi@linutronix.de

    [PATCH v3 00/20] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3
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
    ...

Thanks!

8<-----

Ahmed S. Darwish (34):
  ASoC: Intel: avs: Include CPUID header at file scope
  treewide: Explicitly include the x86 CPUID headers
  x86/cpu: <asm/processor.h>: Do not include the CPUID API header
  x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs
  x86/cpuid: Introduce <asm/cpuid/leaf_types.h>
  x86: Introduce a centralized CPUID data model
  x86/cpuid: Introduce a centralized CPUID parser
  x86/cpu: Use parsed CPUID(0x0)
  x86/lib: Add CPUID(0x1) CPU family and model calculation
  x86/cpu: Use parsed CPUID(0x1)
  x86/cpuid: Parse CPUID(0x80000000)
  x86/cpu: Use parsed CPUID(0x80000000)
  x86/cpuid: Parse CPUID(0x80000002) to CPUID(0x80000004)
  x86/cpu: Use parsed CPUID(0x80000002)..CPUID(0x80000004)
  x86/cpuid: Introduce a parser leaf x86 vendor table
  x86/cpuid: Introduce a parser debugfs interface
  x86/cpuid: Parse CPUID(0x2)
  x86/cpuid: Warn once on invalid CPUID(0x2) iteration count
  x86/cpuid: Introduce parsed CPUID(0x2) API
  x86/cpu: Use parsed CPUID(0x2)
  x86/cacheinfo: Use parsed CPUID(0x2)
  x86/cpuid: Remove direct CPUID(0x2) query API
  x86/cpuid: Parse 'deterministic cache parameters' CPUID leaves
  x86/cacheinfo: Pass a 'struct cpuinfo_x86' refrence to CPUID(0x4) code
  x86/cacheinfo: Use parsed CPUID(0x4)
  x86/cacheinfo: Use parsed CPUID(0x8000001d)
  x86/cpuid: Parse CPUID(0x80000005) and CPUID(0x80000006)
  x86/cacheinfo: Use auto-generated data types
  x86/cacheinfo: Use parsed CPUID(0x80000005) and CPUID(0x80000006)
  x86/cacheinfo: Use parsed CPUID(0x80000006)
  x86/cpu: Rescan CPUID table after PSN disable
  x86/cpu: Rescan CPUID table after unlocking full CPUID range
  x86/cpuid: Parse CPUID(0x16)
  x86/tsc: Use parsed CPUID(0x16)

K Prateek Nayak (1):
  x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using
    _cpuid4_info

 MAINTAINERS                                   |    1 +
 arch/x86/boot/compressed/pgtable_64.c         |    1 +
 arch/x86/boot/startup/sme.c                   |    1 +
 arch/x86/coco/tdx/tdx.c                       |    1 +
 arch/x86/events/amd/core.c                    |    2 +
 arch/x86/events/amd/ibs.c                     |    1 +
 arch/x86/events/amd/lbr.c                     |    2 +
 arch/x86/events/amd/power.c                   |    3 +
 arch/x86/events/amd/uncore.c                  |    1 +
 arch/x86/events/intel/core.c                  |    1 +
 arch/x86/events/intel/lbr.c                   |    1 +
 arch/x86/events/zhaoxin/core.c                |    1 +
 arch/x86/include/asm/acrn.h                   |    2 +
 arch/x86/include/asm/cpu.h                    |    6 +
 arch/x86/include/asm/cpuid/api.h              |  342 ++-
 arch/x86/include/asm/cpuid/leaf_types.h       | 2090 +++++++++++++++++
 arch/x86/include/asm/cpuid/types.h            |  142 ++
 arch/x86/include/asm/microcode.h              |    1 +
 arch/x86/include/asm/processor.h              |    3 +-
 arch/x86/include/asm/xen/hypervisor.h         |    1 +
 arch/x86/kernel/amd_nb.c                      |    3 +-
 arch/x86/kernel/apic/apic.c                   |    1 +
 arch/x86/kernel/cpu/Makefile                  |    3 +-
 arch/x86/kernel/cpu/amd.c                     |    1 +
 arch/x86/kernel/cpu/cacheinfo.c               |  329 +--
 arch/x86/kernel/cpu/centaur.c                 |    1 +
 arch/x86/kernel/cpu/common.c                  |   74 +-
 arch/x86/kernel/cpu/cpuid_debugfs.c           |  108 +
 arch/x86/kernel/cpu/cpuid_parser.c            |  281 +++
 arch/x86/kernel/cpu/cpuid_parser.h            |  189 ++
 arch/x86/kernel/cpu/hygon.c                   |    1 +
 arch/x86/kernel/cpu/intel.c                   |   17 +-
 arch/x86/kernel/cpu/mce/core.c                |    1 +
 arch/x86/kernel/cpu/mce/inject.c              |    1 +
 arch/x86/kernel/cpu/microcode/amd.c           |    1 +
 arch/x86/kernel/cpu/microcode/core.c          |    1 +
 arch/x86/kernel/cpu/microcode/intel.c         |    1 +
 arch/x86/kernel/cpu/mshyperv.c                |    1 +
 arch/x86/kernel/cpu/resctrl/core.c            |    1 +
 arch/x86/kernel/cpu/resctrl/monitor.c         |    1 +
 arch/x86/kernel/cpu/scattered.c               |    1 +
 arch/x86/kernel/cpu/sgx/driver.c              |    3 +
 arch/x86/kernel/cpu/sgx/main.c                |    3 +
 arch/x86/kernel/cpu/topology_amd.c            |    3 +-
 arch/x86/kernel/cpu/topology_common.c         |    1 +
 arch/x86/kernel/cpu/topology_ext.c            |    3 +-
 arch/x86/kernel/cpu/transmeta.c               |    3 +
 arch/x86/kernel/cpu/vmware.c                  |    1 +
 arch/x86/kernel/cpu/zhaoxin.c                 |    1 +
 arch/x86/kernel/cpuid.c                       |    6 +-
 arch/x86/kernel/jailhouse.c                   |    1 +
 arch/x86/kernel/kvm.c                         |    1 +
 arch/x86/kernel/paravirt.c                    |    1 +
 arch/x86/kernel/tsc.c                         |   24 +-
 arch/x86/kvm/mmu/mmu.c                        |    1 +
 arch/x86/kvm/mmu/spte.c                       |    1 +
 arch/x86/kvm/reverse_cpuid.h                  |    2 +
 arch/x86/kvm/svm/sev.c                        |    1 +
 arch/x86/kvm/svm/svm.c                        |    1 +
 arch/x86/kvm/vmx/pmu_intel.c                  |    1 +
 arch/x86/kvm/vmx/sgx.c                        |    1 +
 arch/x86/kvm/vmx/vmx.c                        |    1 +
 arch/x86/lib/cpu.c                            |   41 +-
 arch/x86/mm/pti.c                             |    1 +
 arch/x86/pci/xen.c                            |    2 +-
 arch/x86/xen/enlighten_hvm.c                  |    1 +
 arch/x86/xen/pmu.c                            |    1 +
 arch/x86/xen/time.c                           |    1 +
 drivers/char/agp/efficeon-agp.c               |    1 +
 drivers/cpufreq/longrun.c                     |    1 +
 drivers/cpufreq/powernow-k7.c                 |    2 +-
 drivers/cpufreq/powernow-k8.c                 |    1 +
 drivers/cpufreq/speedstep-lib.c               |    1 +
 drivers/firmware/efi/libstub/x86-5lvl.c       |    1 +
 drivers/gpu/drm/gma500/mmu.c                  |    2 +
 drivers/hwmon/fam15h_power.c                  |    1 +
 drivers/hwmon/k10temp.c                       |    2 +
 drivers/hwmon/k8temp.c                        |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |    1 +
 drivers/ras/amd/fmpm.c                        |    1 +
 drivers/thermal/intel/intel_hfi.c             |    1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |    1 +
 drivers/virt/acrn/hsm.c                       |    1 +
 drivers/xen/events/events_base.c              |    1 +
 drivers/xen/grant-table.c                     |    1 +
 drivers/xen/xenbus/xenbus_xs.c                |    3 +
 sound/soc/intel/avs/tgl.c                     |   25 +-
 87 files changed, 3428 insertions(+), 347 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_types.h
 create mode 100644 arch/x86/kernel/cpu/cpuid_debugfs.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_parser.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_parser.h

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.50.1


