Return-Path: <linux-kernel+bounces-858326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A444BEA104
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C177F1896592
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8A330B2B;
	Fri, 17 Oct 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N63Ei1RZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD88330B01
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715427; cv=none; b=UFXVkjaQ8w2esnfTWL3QjQgsDTHhZwxcKYMW4RSvFt4GmbCc91+Vg82mMSEh3Fl0yxn/+8bd6r434upKxCwW+07ZNv0aN246DdfdCR3+0S+uFhZYK6B0hhAD87PG0uC6MCbf7vDiimdvuGWKy84GLPQPr87vXN7bkSzkuA7qzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715427; c=relaxed/simple;
	bh=vIEZrRHrlEzmS11dx5nsWwEw2hyuS46NdLsdrPbkYG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krzIySz0sdx+LpEt6Lq8KqriV6YVvVy5V2aBf2KfgD+MbtV2yAN7TNTPHP5WRW6/nIe4q5y1hzw5j1MOa4jaHEVPfJKcZmuqHl9TLbwshPDl3gjcUHnWIIaCL8UGubCpmvHIy8EtAz+pviqoRVyZc+8qgmMSc+7y/87tKXXdZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N63Ei1RZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760715423; x=1792251423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vIEZrRHrlEzmS11dx5nsWwEw2hyuS46NdLsdrPbkYG4=;
  b=N63Ei1RZ3k5kyAVVWRQV1B7LlHQhnay+4DiQ7wM2HMMtWj79K329KjTh
   zJIwQLwtfXOFSHGsbO3nsRZPxOPUH/oTpsOIUImxEsQRA/zrdGJji3eQP
   BDYXfs4vu161hwL9TF5JN5u4gCIa2y5JZ2w/HfSOcSoW5g2EBt9Y+lVx1
   PynvnObDFgRV9emjf+8oWd6okt9GyvyW5YSx99gQOxNytq9//KmVdZ6so
   gZ2vmukx73IJBM0Ox1nLDhGixKXGFn5H4NCwqE4w/fpkVOz3iTit1Ue/7
   fInvJnNnCyn4n8IQa1X4gr4/t4FbMIudRA6DoNfIghMBVTsqnt1X27f32
   w==;
X-CSE-ConnectionGUID: QFQsjzZdRp+XIDHvaI3p7Q==
X-CSE-MsgGUID: cP9XROuUSdiv1A6UlnUomA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="80374266"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="80374266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:37:01 -0700
X-CSE-ConnectionGUID: ofdjjNXNSsO2O8IsTcy1yA==
X-CSE-MsgGUID: mL68K+CMSBO/gg5NN+ezPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="187168608"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:37:00 -0700
Date: Fri, 17 Oct 2025 08:36:59 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	=?utf-8?Q?Lauren=C8=9Biu_P=C4=83ncescu?= <lpancescu@gmail.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
	1117002@bugs.debian.org
Subject: Re: WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123
 do_clear_cpu_cap+0xdc/0x130 on Intel(R) Atom(TM) CPU N450 system
Message-ID: <aPJim0ofgtL8RV5s@tassilo>
References: <aPJNPPFKsPKJWlLn@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJNPPFKsPKJWlLn@eldamar.lan>

> [    0.351035] smp: Bringing up secondary CPUs ...
> [    0.351876] smpboot: x86: Booting SMP configuration:
> [    0.351888] .... node  #0, CPUs:      #1
> [    0.008282] Disabled fast string operations

It's probably caused by that. I guess he disabled fast strings in his
BIOS and if he switches that setting it would go away.

The related code would need to be moved earlier in the boot sequence to
make the alternative patching work.

But in practice it's unlikely it causes any real functional problems

-Andi



> [    0.008282] ------------[ cut here ]------------
> [    0.008282] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123 do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Modules linked in:
> [    0.008282] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.9+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.9-1
> [    0.008282] Hardware name: ASUSTeK Computer INC. 1005PE/1005P, BIOS 1202    06/23/2010
> [    0.008282] RIP: 0010:do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Code: 44 24 60 65 48 2b 05 6b 21 96 02 75 67 48 83 c4 68 5b 5d 41 5c 41 5d c3 cc cc cc cc 8b 15 54 1e 03 02 85 d2 0f 84 6f ff ff ff <0f> 0b e9 68 ff ff ff 48 c7 c7 a0 0b f2 b8 e8 11 ff ff ff f0 4c 0f
> [    0.008282] RSP: 0000:ffffcd5fc00bfda8 EFLAGS: 00010002
> [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfda8 RCX: 0000000000000000
> [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffcd5fc00bfe08
> [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09: 706f20676e697274
> [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12: 0000000000000000
> [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15: 0000000000000000
> [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000) knlGS:0000000000000000
> [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4: 00000000000006f0
> [    0.008282] Call Trace:
> [    0.008282]  <TASK>
> [    0.008282]  early_init_intel.cold+0x4d/0x11a
> [    0.008282]  init_intel+0x2a/0x2c0
> [    0.008282]  identify_cpu+0x18c/0x750
> [    0.008282]  identify_secondary_cpu+0x50/0xa0
> [    0.008282]  start_secondary+0x7c/0x160
> [    0.008282]  common_startup_64+0x13e/0x141
> [    0.008282]  </TASK>
> [    0.008282] ---[ end trace 0000000000000000 ]---
> [    0.008282] ------------[ cut here ]------------
> [    0.008282] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123 do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Modules linked in:
> [    0.008282] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.16.9+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.9-1
> [    0.008282] Tainted: [W]=WARN
> [    0.008282] Hardware name: ASUSTeK Computer INC. 1005PE/1005P, BIOS 1202    06/23/2010
> [    0.008282] RIP: 0010:do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Code: 44 24 60 65 48 2b 05 6b 21 96 02 75 67 48 83 c4 68 5b 5d 41 5c 41 5d c3 cc cc cc cc 8b 15 54 1e 03 02 85 d2 0f 84 6f ff ff ff <0f> 0b e9 68 ff ff ff 48 c7 c7 a0 0b f2 b8 e8 11 ff ff ff f0 4c 0f
> [    0.008282] RSP: 0000:ffffcd5fc00bfd18 EFLAGS: 00010002
> [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfd18 RCX: 0000000000000000
> [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffcd5fc00bfd78
> [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09: 706f20676e697274
> [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12: ffffffffb8f20ba0
> [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15: 0000000000000000
> [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000) knlGS:0000000000000000
> [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4: 00000000000006f0
> [    0.008282] Call Trace:
> [    0.008282]  <TASK>
> [    0.008282]  do_clear_cpu_cap+0x106/0x130
> [    0.008282]  early_init_intel.cold+0x4d/0x11a
> [    0.008282]  init_intel+0x2a/0x2c0
> [    0.008282]  identify_cpu+0x18c/0x750
> [    0.008282]  identify_secondary_cpu+0x50/0xa0
> [    0.008282]  start_secondary+0x7c/0x160
> [    0.008282]  common_startup_64+0x13e/0x141
> [    0.008282]  </TASK>
> [    0.008282] ---[ end trace 0000000000000000 ]---
> [    0.354753] smp: Brought up 1 node, 2 CPUs
> [    0.354797] smpboot: Total of 2 processors activated (6666.06 BogoMIPS)
> 
> Any ideas?
> 
> Regards,
> Salvatore

> [    0.000000] Linux version 6.16.9+deb14-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 14.3.0-8) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) #1 SMP PREEMPT_DYNAMIC Debian 6.16.9-1 (2025-09-27)
> [    0.000000] Command line: BOOT_IMAGE=/live/vmlinuz boot=live components quiet splash initrd=/live/initrd.img
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e2000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f68ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007f690000-0x000000007f69dfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007f69e000-0x000000007f6dffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007f6e0000-0x000000007f6fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fff80000-0x00000000ffffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] SMBIOS 2.6 present.
> [    0.000000] DMI: ASUSTeK Computer INC. 1005PE/1005P, BIOS 1202    06/23/2010
> [    0.000000] DMI: Memory slots populated: 1/2
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 1666.516 MHz processor
> [    0.002639] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.002653] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.002675] last_pfn = 0x7f69e max_arch_pfn = 0x400000000
> [    0.002689] MTRR map: 8 entries (6 fixed + 2 variable; max 22), built from 8 variable MTRRs
> [    0.002697] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.011991] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
> [    0.012871] RAMDISK: [mem 0x748fd000-0x7f68ffff]
> [    0.014550] ACPI: Early table checksum verification disabled
> [    0.014563] ACPI: RSDP 0x00000000000FBF40 000024 (v02 ACPIAM)
> [    0.014580] ACPI: XSDT 0x000000007F690100 00006C (v01 _ASUS_ Notebook 06001023 MSFT 00000097)
> [    0.014600] ACPI: FACP 0x000000007F690290 0000F4 (v04 A_M_I_ OEMFACP  06001023 MSFT 00000097)
> [    0.014623] ACPI: DSDT 0x000000007F690490 008BDE (v02 A1414  A1414000 00000000 INTL 20060113)
> [    0.014638] ACPI: FACS 0x000000007F69E000 000040
> [    0.014650] ACPI: FACS 0x000000007F69E000 000040
> [    0.014662] ACPI: APIC 0x000000007F690390 00005C (v02 A_M_I_ OEMAPIC  06001023 MSFT 00000097)
> [    0.014676] ACPI: MCFG 0x000000007F6903F0 00003C (v01 A_M_I_ OEMMCFG  06001023 MSFT 00000097)
> [    0.014691] ACPI: ECDT 0x000000007F690430 000055 (v01 A_M_I_ OEMECDT  06001023 MSFT 00000097)
> [    0.014705] ACPI: OEMB 0x000000007F69E040 000061 (v01 A_M_I_ AMI_OEM  06001023 MSFT 00000097)
> [    0.014720] ACPI: HPET 0x000000007F699070 000038 (v01 A_M_I_ OEMHPET  06001023 MSFT 00000097)
> [    0.014735] ACPI: GSCI 0x000000007F69E0B0 002024 (v01 A_M_I_ GMCHSCI  06001023 MSFT 00000097)
> [    0.014749] ACPI: SSDT 0x000000007F6A0C80 0004F0 (v01 PmRef  CpuPm    00003000 INTL 20060113)
> [    0.014764] ACPI: SLIC 0x000000007F6990B0 000176 (v01 _ASUS_ Notebook 06001023 MSFT 00000097)
> [    0.014776] ACPI: Reserving FACP table memory at [mem 0x7f690290-0x7f690383]
> [    0.014783] ACPI: Reserving DSDT table memory at [mem 0x7f690490-0x7f69906d]
> [    0.014788] ACPI: Reserving FACS table memory at [mem 0x7f69e000-0x7f69e03f]
> [    0.014792] ACPI: Reserving FACS table memory at [mem 0x7f69e000-0x7f69e03f]
> [    0.014797] ACPI: Reserving APIC table memory at [mem 0x7f690390-0x7f6903eb]
> [    0.014801] ACPI: Reserving MCFG table memory at [mem 0x7f6903f0-0x7f69042b]
> [    0.014806] ACPI: Reserving ECDT table memory at [mem 0x7f690430-0x7f690484]
> [    0.014810] ACPI: Reserving OEMB table memory at [mem 0x7f69e040-0x7f69e0a0]
> [    0.014815] ACPI: Reserving HPET table memory at [mem 0x7f699070-0x7f6990a7]
> [    0.014819] ACPI: Reserving GSCI table memory at [mem 0x7f69e0b0-0x7f6a00d3]
> [    0.014823] ACPI: Reserving SSDT table memory at [mem 0x7f6a0c80-0x7f6a116f]
> [    0.014828] ACPI: Reserving SLIC table memory at [mem 0x7f6990b0-0x7f699225]
> [    0.015353] No NUMA configuration found
> [    0.015358] Faking a node at [mem 0x0000000000000000-0x000000007f69dfff]
> [    0.015450] NODE_DATA(0) allocated [mem 0x748d2500-0x748fcfff]
> [    0.016741] Zone ranges:
> [    0.016746]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.016756]   DMA32    [mem 0x0000000001000000-0x000000007f69dfff]
> [    0.016762]   Normal   empty
> [    0.016766]   Device   empty
> [    0.016770] Movable zone start for each node
> [    0.016781] Early memory node ranges
> [    0.016783]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.016788]   node   0: [mem 0x0000000000100000-0x000000007f68ffff]
> [    0.016795] Initmem setup node 0 [mem 0x0000000000001000-0x000000007f68ffff]
> [    0.016817] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.016929] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.019624] On node 0, zone DMA32: 2416 pages in unavailable ranges
> [    0.019645] Reserving Intel graphics memory at [mem 0x7f800000-0x7fffffff]
> [    0.019824] ACPI: PM-Timer IO Port: 0x808
> [    0.019870] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> [    0.019884] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.019892] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.019908] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.019913] ACPI: HPET id: 0xffffffff base: 0xfed00000
> [    0.019956] CPU topo: Max. logical packages:   1
> [    0.019960] CPU topo: Max. logical dies:       1
> [    0.019963] CPU topo: Max. dies per package:   1
> [    0.019989] CPU topo: Max. threads per core:   2
> [    0.019992] CPU topo: Num. cores per package:     1
> [    0.019995] CPU topo: Num. threads per package:   2
> [    0.019998] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
> [    0.020040] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.020048] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
> [    0.020055] PM: hibernation: Registered nosave memory: [mem 0x7f690000-0x7f69dfff]
> [    0.020063] [mem 0x80000000-0xfedfffff] available for PCI devices
> [    0.020067] Booting paravirtualized kernel on bare hardware
> [    0.020075] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.037102] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
> [    0.038832] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u1048576
> [    0.038856] pcpu-alloc: s217088 r8192 d28672 u1048576 alloc=1*2097152
> [    0.038868] pcpu-alloc: [0] 0 1 
> [    0.038931] Kernel command line: BOOT_IMAGE=/live/vmlinuz boot=live components quiet splash initrd=/live/initrd.img
> [    0.039351] Unknown kernel command line parameters "components splash BOOT_IMAGE=/live/vmlinuz boot=live", will be passed to user space.
> [    0.039370] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
> [    0.040668] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.041376] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.041551] Fallback order for Node 0: 0 
> [    0.041571] Built 1 zonelists, mobility grouping on.  Total pages: 521774
> [    0.041577] Policy zone: DMA32
> [    0.041610] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.078918] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.096378] ftrace: allocating 46385 entries in 184 pages
> [    0.096391] ftrace: allocated 184 pages with 4 groups
> [    0.097986] Dynamic Preempt: lazy
> [    0.098428] rcu: Preemptible hierarchical RCU implementation.
> [    0.098432] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
> [    0.098438] 	Trampoline variant of Tasks RCU enabled.
> [    0.098440] 	Rude variant of Tasks RCU enabled.
> [    0.098442] 	Tracing variant of Tasks RCU enabled.
> [    0.098445] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.098448] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.098474] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
> [    0.098482] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
> [    0.098487] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
> [    0.125891] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
> [    0.126358] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.129308] Console: colour VGA+ 80x25
> [    0.129321] printk: legacy console [tty0] enabled
> [    0.130043] ACPI: Core revision 20250404
> [    0.130625] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.130663] APIC: Switch to symmetric I/O mode setup
> [    0.131176] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.150664] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1805981d82a, max_idle_ns: 440795237583 ns
> [    0.150690] Calibrating delay loop (skipped), value calculated using timer frequency.. 3333.03 BogoMIPS (lpj=6666064)
> [    0.150737] CPU0: Thermal monitoring enabled (TM2)
> [    0.150795] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 0
> [    0.150804] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
> [    0.150818] process: using mwait in idle threads
> [    0.150838] x86/fpu: x87 FPU will use FXSAVE
> [    0.229330] Freeing SMP alternatives memory: 44K
> [    0.229368] pid_max: default: 32768 minimum: 301
> [    0.231033] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
> [    0.232069] landlock: Up and running.
> [    0.232076] Yama: disabled by default; enable with sysctl kernel.yama.*
> [    0.232362] AppArmor: AppArmor initialized
> [    0.232435] TOMOYO Linux initialized
> [    0.233048] LSM support for eBPF active
> [    0.234145] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> [    0.234175] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> [    0.348822] smpboot: CPU0: Intel(R) Atom(TM) CPU N450   @ 1.66GHz (family: 0x6, model: 0x1c, stepping: 0xa)
> [    0.350287] Performance Events: PEBS fmt0+, Atom events, 8-deep LBR, Intel PMU driver.
> [    0.350352] ... version:                3
> [    0.350357] ... bit width:              40
> [    0.350362] ... generic registers:      2
> [    0.350366] ... value mask:             000000ffffffffff
> [    0.350371] ... max period:             000000007fffffff
> [    0.350375] ... fixed-purpose events:   3
> [    0.350379] ... event mask:             0000000700000003
> [    0.350677] signal: max sigframe size: 1440
> [    0.350677] rcu: Hierarchical SRCU implementation.
> [    0.350677] rcu: 	Max phase no-delay instances is 1000.
> [    0.350677] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    0.350677] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.351035] smp: Bringing up secondary CPUs ...
> [    0.351876] smpboot: x86: Booting SMP configuration:
> [    0.351888] .... node  #0, CPUs:      #1
> [    0.008282] Disabled fast string operations
> [    0.008282] ------------[ cut here ]------------
> [    0.008282] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123 do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Modules linked in:
> [    0.008282] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.9+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.9-1 
> [    0.008282] Hardware name: ASUSTeK Computer INC. 1005PE/1005P, BIOS 1202    06/23/2010
> [    0.008282] RIP: 0010:do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Code: 44 24 60 65 48 2b 05 6b 21 96 02 75 67 48 83 c4 68 5b 5d 41 5c 41 5d c3 cc cc cc cc 8b 15 54 1e 03 02 85 d2 0f 84 6f ff ff ff <0f> 0b e9 68 ff ff ff 48 c7 c7 a0 0b f2 b8 e8 11 ff ff ff f0 4c 0f
> [    0.008282] RSP: 0000:ffffcd5fc00bfda8 EFLAGS: 00010002
> [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfda8 RCX: 0000000000000000
> [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffcd5fc00bfe08
> [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09: 706f20676e697274
> [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12: 0000000000000000
> [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15: 0000000000000000
> [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000) knlGS:0000000000000000
> [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4: 00000000000006f0
> [    0.008282] Call Trace:
> [    0.008282]  <TASK>
> [    0.008282]  early_init_intel.cold+0x4d/0x11a
> [    0.008282]  init_intel+0x2a/0x2c0
> [    0.008282]  identify_cpu+0x18c/0x750
> [    0.008282]  identify_secondary_cpu+0x50/0xa0
> [    0.008282]  start_secondary+0x7c/0x160
> [    0.008282]  common_startup_64+0x13e/0x141
> [    0.008282]  </TASK>
> [    0.008282] ---[ end trace 0000000000000000 ]---
> [    0.008282] ------------[ cut here ]------------
> [    0.008282] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123 do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Modules linked in:
> [    0.008282] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.16.9+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.9-1 
> [    0.008282] Tainted: [W]=WARN
> [    0.008282] Hardware name: ASUSTeK Computer INC. 1005PE/1005P, BIOS 1202    06/23/2010
> [    0.008282] RIP: 0010:do_clear_cpu_cap+0xdc/0x130
> [    0.008282] Code: 44 24 60 65 48 2b 05 6b 21 96 02 75 67 48 83 c4 68 5b 5d 41 5c 41 5d c3 cc cc cc cc 8b 15 54 1e 03 02 85 d2 0f 84 6f ff ff ff <0f> 0b e9 68 ff ff ff 48 c7 c7 a0 0b f2 b8 e8 11 ff ff ff f0 4c 0f
> [    0.008282] RSP: 0000:ffffcd5fc00bfd18 EFLAGS: 00010002
> [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfd18 RCX: 0000000000000000
> [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffcd5fc00bfd78
> [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09: 706f20676e697274
> [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12: ffffffffb8f20ba0
> [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15: 0000000000000000
> [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000) knlGS:0000000000000000
> [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4: 00000000000006f0
> [    0.008282] Call Trace:
> [    0.008282]  <TASK>
> [    0.008282]  do_clear_cpu_cap+0x106/0x130
> [    0.008282]  early_init_intel.cold+0x4d/0x11a
> [    0.008282]  init_intel+0x2a/0x2c0
> [    0.008282]  identify_cpu+0x18c/0x750
> [    0.008282]  identify_secondary_cpu+0x50/0xa0
> [    0.008282]  start_secondary+0x7c/0x160
> [    0.008282]  common_startup_64+0x13e/0x141
> [    0.008282]  </TASK>
> [    0.008282] ---[ end trace 0000000000000000 ]---
> [    0.354753] smp: Brought up 1 node, 2 CPUs
> [    0.354797] smpboot: Total of 2 processors activated (6666.06 BogoMIPS)
> [    0.383040] node 0 deferred pages initialised in 28ms
> [    0.383066] Memory: 1816540K/2087096K available (16707K kernel code, 3261K rwdata, 12300K rodata, 4364K init, 5652K bss, 266180K reserved, 0K cma-reserved)
> [    0.383829] devtmpfs: initialized
> [    0.383829] x86/mm: Memory block size: 128MB
> [    0.387080] ACPI: PM: Registering ACPI NVS region [mem 0x7f69e000-0x7f6dffff] (270336 bytes)
> [    0.387205] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.387205] posixtimers hash table entries: 1024 (order: 2, 16384 bytes, linear)
> [    0.387205] futex hash table entries: 512 (32768 bytes on 1 NUMA nodes, total 32 KiB, linear).
> [    0.388418] pinctrl core: initialized pinctrl subsystem
> [    0.394827] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.395538] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
> [    0.395710] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.395903] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.395991] audit: initializing netlink subsys (disabled)
> [    0.396095] audit: type=2000 audit(1760375272.264:1): state=initialized audit_enabled=0 res=1
> [    0.396095] thermal_sys: Registered thermal governor 'fair_share'
> [    0.396095] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.396095] thermal_sys: Registered thermal governor 'step_wise'
> [    0.396095] thermal_sys: Registered thermal governor 'user_space'
> [    0.396095] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.396095] cpuidle: using governor ladder
> [    0.396095] cpuidle: using governor menu
> [    0.396095] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.396095] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.396095] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
> [    0.396095] PCI: Using configuration type 1 for base access
> [    0.398917] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.414818] HugeTLB: allocation took 0ms with hugepage_allocation_threads=1
> [    0.414852] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.414860] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.471488] ACPI: Added _OSI(Module Device)
> [    0.471500] ACPI: Added _OSI(Processor Device)
> [    0.471507] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.504837] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    0.506331] ACPI: EC: EC started
> [    0.506339] ACPI: EC: interrupt blocked
> [    0.507234] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.507244] ACPI: EC: Boot ECDT EC used to handle transactions
> [    0.515619] ACPI: Dynamic OEM Table Load:
> [    0.515649] ACPI: SSDT 0xFFFF8AD2C1811000 000326 (v01 PmRef  Cpu0Ist  00003000 INTL 20060113)
> [    0.517195] ACPI: Dynamic OEM Table Load:
> [    0.517222] ACPI: SSDT 0xFFFF8AD2C13D7800 000724 (v01 PmRef  Cpu0Cst  00003001 INTL 20060113)
> [    0.517234] ACPI: Dynamic OEM Table Load:
> [    0.517234] ACPI: SSDT 0xFFFF8AD2C1C91F00 0000AB (v01 PmRef  Cpu1Ist  00003000 INTL 20060113)
> [    0.517234] ACPI: Dynamic OEM Table Load:
> [    0.517234] ACPI: SSDT 0xFFFF8AD2C1C91000 000085 (v01 PmRef  Cpu1Cst  00003000 INTL 20060113)
> [    0.517534] ACPI: Interpreter enabled
> [    0.517602] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.517610] ACPI: Using IOAPIC for interrupt routing
> [    0.517750] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.519082] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
> [    0.519147] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.519155] PCI: Using E820 reservations for host bridge windows
> [    0.519641] ACPI: Enabled 4 GPEs in block 00 to 1F
> [    0.535454] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.540163] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.540195] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.540220] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> [    0.540230] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> [    0.540237] acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
> [    0.541051] PCI host bridge to bus 0000:00
> [    0.541073] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.541087] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.541095] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.541104] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
> [    0.541112] pci_bus 0000:00: root bus resource [mem 0x7f700000-0xfed8ffff window]
> [    0.541122] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.541162] pci 0000:00:00.0: [8086:a010] type 00 class 0x060000 conventional PCI endpoint
> [    0.541406] pci 0000:00:02.0: [8086:a011] type 00 class 0x030000 conventional PCI endpoint
> [    0.541437] pci 0000:00:02.0: BAR 0 [mem 0xf7e00000-0xf7e7ffff]
> [    0.541448] pci 0000:00:02.0: BAR 1 [io  0xdc00-0xdc07]
> [    0.541457] pci 0000:00:02.0: BAR 2 [mem 0xd0000000-0xdfffffff pref]
> [    0.541467] pci 0000:00:02.0: BAR 3 [mem 0xf7d00000-0xf7dfffff]
> [    0.541497] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.541798] pci 0000:00:02.1: [8086:a012] type 00 class 0x038000 conventional PCI endpoint
> [    0.541829] pci 0000:00:02.1: BAR 0 [mem 0xf7e80000-0xf7efffff]
> [    0.542052] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
> [    0.542102] pci 0000:00:1b.0: BAR 0 [mem 0xf7cf8000-0xf7cfbfff 64bit]
> [    0.542186] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.542409] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400 PCIe Root Port
> [    0.542446] pci 0000:00:1c.0: PCI bridge to [bus 04]
> [    0.542543] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.542944] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400 PCIe Root Port
> [    0.542984] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
> [    0.543000] pci 0000:00:1c.1:   bridge window [mem 0xf8000000-0xfbffffff]
> [    0.543018] pci 0000:00:1c.1:   bridge window [mem 0xf0000000-0xf6ffffff 64bit pref]
> [    0.543106] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.543477] pci 0000:00:1c.3: [8086:27d6] type 01 class 0x060400 PCIe Root Port
> [    0.543516] pci 0000:00:1c.3: PCI bridge to [bus 01]
> [    0.543529] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
> [    0.543540] pci 0000:00:1c.3:   bridge window [mem 0xf7f00000-0xf7ffffff]
> [    0.543632] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    0.544009] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.544069] pci 0000:00:1d.0: BAR 4 [io  0xd400-0xd41f]
> [    0.544365] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.544423] pci 0000:00:1d.1: BAR 4 [io  0xd480-0xd49f]
> [    0.544714] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.544771] pci 0000:00:1d.2: BAR 4 [io  0xd800-0xd81f]
> [    0.545072] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.545129] pci 0000:00:1d.3: BAR 4 [io  0xd880-0xd89f]
> [    0.545426] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320 conventional PCI endpoint
> [    0.545483] pci 0000:00:1d.7: BAR 0 [mem 0xf7cf7c00-0xf7cf7fff]
> [    0.545549] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.545866] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401 conventional PCI bridge
> [    0.545901] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
> [    0.546260] pci 0000:00:1f.0: [8086:27bc] type 00 class 0x060100 conventional PCI endpoint
> [    0.546795] pci 0000:00:1f.2: [8086:27c1] type 00 class 0x010601 conventional PCI endpoint
> [    0.546848] pci 0000:00:1f.2: BAR 0 [io  0xd080-0xd087]
> [    0.546859] pci 0000:00:1f.2: BAR 1 [io  0xd000-0xd003]
> [    0.546868] pci 0000:00:1f.2: BAR 2 [io  0xcc00-0xcc07]
> [    0.546878] pci 0000:00:1f.2: BAR 3 [io  0xc880-0xc883]
> [    0.546887] pci 0000:00:1f.2: BAR 4 [io  0xc800-0xc81f]
> [    0.546897] pci 0000:00:1f.2: BAR 5 [mem 0xf7cf7800-0xf7cf7bff]
> [    0.546961] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.547298] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.547368] pci 0000:00:1f.3: BAR 4 [io  0x0400-0x041f]
> [    0.547644] pci 0000:00:1c.0: PCI bridge to [bus 04]
> [    0.547804] pci 0000:02:00.0: [168c:002b] type 00 class 0x028000 PCIe Legacy Endpoint
> [    0.547877] pci 0000:02:00.0: BAR 0 [mem 0xfbff0000-0xfbffffff 64bit]
> [    0.548011] pci 0000:02:00.0: supports D1
> [    0.548019] pci 0000:02:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.548314] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
> [    0.548470] pci 0000:01:00.0: [1969:1062] type 00 class 0x020000 PCIe Endpoint
> [    0.548543] pci 0000:01:00.0: BAR 0 [mem 0xf7fc0000-0xf7ffffff 64bit]
> [    0.548555] pci 0000:01:00.0: BAR 2 [io  0xec00-0xec7f]
> [    0.548602] pci 0000:01:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
> [    0.548677] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.548955] pci 0000:00:1c.3: PCI bridge to [bus 01]
> [    0.549000] pci_bus 0000:05: extended config space not accessible
> [    0.549109] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
> [    0.549130] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    0.549139] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
> [    0.549148] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    0.549156] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
> [    0.549165] pci 0000:00:1e.0:   bridge window [mem 0x7f700000-0xfed8ffff window] (subtractive decode)
> [    0.552450] ACPI: PCI: Interrupt link LNKA configured for IRQ 15
> [    0.552656] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    0.552854] ACPI: PCI: Interrupt link LNKC configured for IRQ 7
> [    0.553051] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    0.553248] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    0.553257] ACPI: PCI: Interrupt link LNKE disabled
> [    0.553451] ACPI: PCI: Interrupt link LNKF configured for IRQ 5
> [    0.553649] ACPI: PCI: Interrupt link LNKG configured for IRQ 4
> [    0.553866] ACPI: PCI: Interrupt link LNKH configured for IRQ 3
> [    0.554718] ACPI: EC: interrupt unblocked
> [    0.554728] ACPI: EC: event unblocked
> [    0.554734] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.554740] ACPI: EC: GPE=0x1c
> [    0.554750] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot ECDT EC initialization complete
> [    0.554766] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle transactions and events
> [    0.558858] iommu: Default domain type: Translated
> [    0.558858] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.559268] pps_core: LinuxPPS API ver. 1 registered
> [    0.559281] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.559298] PTP clock support registered
> [    0.559351] EDAC MC: Ver: 3.0.0
> [    0.559852] NetLabel: Initializing
> [    0.559864] NetLabel:  domain hash size = 128
> [    0.559871] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.559936] NetLabel:  unlabeled traffic allowed by default
> [    0.559957] PCI: Using ACPI for IRQ routing
> [    0.568344] PCI: pci_cache_line_size set to 64 bytes
> [    0.568434] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    0.568444] e820: reserve RAM buffer [mem 0x7f690000-0x7fffffff]
> [    0.568581] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.568581] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.568581] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.568581] vgaarb: loaded
> [    0.568581] tsc: Marking TSC unstable due to TSC halts in idle states deeper than C2
> [    0.570903] hpet: 3 channels of 0 reserved for per-cpu timers
> [    0.570903] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.570903] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
> [    0.573036] clocksource: Switched to clocksource hpet
> [    0.576490] VFS: Disk quotas dquot_6.6.0
> [    0.576665] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.577677] AppArmor: AppArmor Filesystem Enabled
> [    0.577822] pnp: PnP ACPI init
> [    0.578106] system 00:00: [mem 0xfed14000-0xfed19fff] has been reserved
> [    0.578123] system 00:00: [mem 0xfed90000-0xfed93fff] has been reserved
> [    0.579291] system 00:04: [io  0x025c-0x025f] has been reserved
> [    0.579309] system 00:04: [io  0x0380-0x0383] has been reserved
> [    0.579319] system 00:04: [io  0x0400-0x041f] has been reserved
> [    0.579328] system 00:04: [io  0x04d0-0x04d1] has been reserved
> [    0.579337] system 00:04: [io  0x0800-0x087f] has been reserved
> [    0.579345] system 00:04: [io  0x0480-0x04bf] has been reserved
> [    0.579360] system 00:04: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.579372] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.579383] system 00:04: [mem 0xfed50000-0xfed8ffff] has been reserved
> [    0.579394] system 00:04: [mem 0xffb00000-0xffbfffff] has been reserved
> [    0.579404] system 00:04: [mem 0xfff00000-0xffffffff] could not be reserved
> [    0.579816] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.579833] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.580082] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.580707] pnp 00:07: disabling [mem 0x000c0000-0x000cffff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
> [    0.580898] system 00:07: [mem 0x00000000-0x0009ffff] could not be reserved
> [    0.580912] system 00:07: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.580922] system 00:07: [mem 0x00100000-0x7f6fffff] could not be reserved
> [    0.580933] system 00:07: [mem 0xfed90000-0xffffffff] could not be reserved
> [    0.581490] pnp: PnP ACPI: found 8 devices
> [    0.597915] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.598760] NET: Registered PF_INET protocol family
> [    0.599001] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.641761] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
> [    0.641868] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.641953] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.642352] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.642630] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.643302] MPTCP token hash table entries: 2048 (order: 3, 49152 bytes, linear)
> [    0.643568] UDP hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.643659] UDP-Lite hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.644169] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.644210] NET: Registered PF_XDP protocol family
> [    0.645274] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
> [    0.645295] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
> [    0.645309] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 04] add_size 200000 add_align 100000
> [    0.645321] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 02-03] add_size 1000
> [    0.645335] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
> [    0.645372] pci 0000:00:1c.0: bridge window [mem 0x80000000-0x801fffff]: assigned
> [    0.645387] pci 0000:00:1c.0: bridge window [mem 0x80200000-0x803fffff 64bit pref]: assigned
> [    0.645400] pci 0000:00:1c.3: bridge window [mem 0x80400000-0x805fffff 64bit pref]: assigned
> [    0.645413] pci 0000:00:1c.0: bridge window [io  0x1000-0x1fff]: assigned
> [    0.645424] pci 0000:00:1c.1: bridge window [io  0x2000-0x2fff]: assigned
> [    0.645438] pci 0000:00:1c.0: PCI bridge to [bus 04]
> [    0.645449] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    0.645462] pci 0000:00:1c.0:   bridge window [mem 0x80000000-0x801fffff]
> [    0.645472] pci 0000:00:1c.0:   bridge window [mem 0x80200000-0x803fffff 64bit pref]
> [    0.645486] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
> [    0.645495] pci 0000:00:1c.1:   bridge window [io  0x2000-0x2fff]
> [    0.645507] pci 0000:00:1c.1:   bridge window [mem 0xf8000000-0xfbffffff]
> [    0.645517] pci 0000:00:1c.1:   bridge window [mem 0xf0000000-0xf6ffffff 64bit pref]
> [    0.645531] pci 0000:00:1c.3: PCI bridge to [bus 01]
> [    0.645540] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
> [    0.645551] pci 0000:00:1c.3:   bridge window [mem 0xf7f00000-0xf7ffffff]
> [    0.645562] pci 0000:00:1c.3:   bridge window [mem 0x80400000-0x805fffff 64bit pref]
> [    0.645577] pci 0000:00:1e.0: PCI bridge to [bus 05]
> [    0.645595] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.645604] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.645612] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.645620] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
> [    0.645627] pci_bus 0000:00: resource 8 [mem 0x7f700000-0xfed8ffff window]
> [    0.645636] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
> [    0.645643] pci_bus 0000:04: resource 1 [mem 0x80000000-0x801fffff]
> [    0.645651] pci_bus 0000:04: resource 2 [mem 0x80200000-0x803fffff 64bit pref]
> [    0.645659] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [    0.645666] pci_bus 0000:02: resource 1 [mem 0xf8000000-0xfbffffff]
> [    0.645674] pci_bus 0000:02: resource 2 [mem 0xf0000000-0xf6ffffff 64bit pref]
> [    0.645682] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
> [    0.645690] pci_bus 0000:01: resource 1 [mem 0xf7f00000-0xf7ffffff]
> [    0.645697] pci_bus 0000:01: resource 2 [mem 0x80400000-0x805fffff 64bit pref]
> [    0.645706] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
> [    0.645714] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
> [    0.645721] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.645729] pci_bus 0000:05: resource 7 [mem 0x000d0000-0x000dffff window]
> [    0.645737] pci_bus 0000:05: resource 8 [mem 0x7f700000-0xfed8ffff window]
> [    0.647396] PCI: CLS 32 bytes, default 64
> [    0.647845] Trying to unpack rootfs image as initramfs...
> [    0.749505] Initialise system trusted keyrings
> [    0.749599] Key type blacklist registered
> [    0.750093] workingset: timestamp_bits=36 max_order=19 bucket_order=0
> [    0.752840] fuse: init (API version 7.44)
> [    0.754480] integrity: Platform Keyring initialized
> [    0.754549] integrity: Machine keyring initialized
> [    0.879054] Key type asymmetric registered
> [    0.879076] Asymmetric key parser 'x509' registered
> [    4.344181] Freeing initrd memory: 177740K
> [    4.362895] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    4.363152] io scheduler mq-deadline registered
> [    4.369244] ledtrig-cpu: registered to indicate activity on CPUs
> [    4.369431] pcieport 0000:00:1c.0: enabling device (0104 -> 0107)
> [    4.369793] pcieport 0000:00:1c.1: enabling device (0106 -> 0107)
> [    4.386950] thermal LNXTHERM:00: registered as thermal_zone0
> [    4.386968] ACPI: thermal: Thermal Zone [TZ00] (44 C)
> [    4.387740] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    4.390783] Linux agpgart interface v0.103
> [    4.392575] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    4.410542] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.410575] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    4.411106] mousedev: PS/2 mouse device common for all mice
> [    4.411233] rtc_cmos 00:01: RTC can wake from S4
> [    4.412078] rtc_cmos 00:01: registered as rtc0
> [    4.412137] rtc_cmos 00:01: setting system clock to 2025-10-13T17:07:56 UTC (1760375276)
> [    4.412274] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    4.412525] intel_pstate: CPU model not supported
> [    4.414262] NET: Registered PF_INET6 protocol family
> [    4.426665] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    4.433745] Segment Routing with IPv6
> [    4.433759] RPL Segment Routing with IPv6
> [    4.433831] In-situ OAM (IOAM) with IPv6
> [    4.433915] mip6: Mobile IPv6
> [    4.433935] NET: Registered PF_PACKET protocol family
> [    4.434167] mpls_gso: MPLS GSO support
> [    4.434879] microcode: Current revision: 0x00000107
> [    4.438355] IPI shorthand broadcast: enabled
> [    4.449767] registered taskstats version 1
> [    4.450236] Loading compiled-in X.509 certificates
> [    4.709025] Loaded X.509 cert 'Build time autogenerated kernel key: af458c5ddcf6d9d84d6fc52cfe2b6200d7c3ea34'
> [    4.720714] Demotion targets for Node 0: null
> [    4.721385] Key type .fscrypt registered
> [    4.721396] Key type fscrypt-provisioning registered
> [    4.784214] Key type encrypted registered
> [    4.784247] AppArmor: AppArmor sha256 policy hashing enabled
> [    4.784418] ima: No TPM chip found, activating TPM-bypass!
> [    4.784433] ima: Allocated hash algorithm: sha256
> [    4.784473] ima: No architecture policies found
> [    4.784566] evm: Initialising EVM extended attributes:
> [    4.784572] evm: security.selinux
> [    4.784577] evm: security.SMACK64 (disabled)
> [    4.784581] evm: security.SMACK64EXEC (disabled)
> [    4.784586] evm: security.SMACK64TRANSMUTE (disabled)
> [    4.784590] evm: security.SMACK64MMAP (disabled)
> [    4.784594] evm: security.apparmor
> [    4.784597] evm: security.ima
> [    4.784601] evm: security.capability
> [    4.784605] evm: HMAC attrs: 0x1
> [    5.005988] RAS: Correctable Errors collector initialized.
> [    5.107856] Unstable clock detected, switching default tracing clock to "global"
>                If you want to keep using the local clock, then add:
>                  "trace_clock=local"
>                on the kernel command line
> [    5.180317] clk: Disabling unused clocks
> [    5.180332] PM: genpd: Disabling unused power domains
> [    5.195158] Freeing unused decrypted memory: 2028K
> [    5.216799] Freeing unused kernel image (initmem) memory: 4364K
> [    5.216948] Write protecting the kernel read-only data: 32768k
> [    5.220639] Freeing unused kernel image (text/rodata gap) memory: 1724K
> [    5.223488] Freeing unused kernel image (rodata/data gap) memory: 2036K
> [    5.395991] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    5.396021] Run /init as init process
> [    5.396030]   with arguments:
> [    5.396037]     /init
> [    5.396043]     components
> [    5.396049]     splash
> [    5.396055]   with environment:
> [    5.396061]     HOME=/
> [    5.396067]     TERM=linux
> [    5.396072]     BOOT_IMAGE=/live/vmlinuz
> [    5.396078]     boot=live
> [    6.970457] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> [    6.970638] ACPI: button: Lid Switch [LID]
> [    6.970876] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
> [    6.971033] ACPI: button: Sleep Button [SLPB]
> [    6.971262] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
> [    6.971413] ACPI: button: Power Button [PWRB]
> [    6.971681] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
> [    6.992502] ACPI: button: Power Button [PWRF]
> [    7.205776] ACPI: battery: Slot [BAT0] (battery present)
> [    7.414394] ACPI Warning: SystemIO range 0x0000000000000400-0x000000000000041F conflicts with OpRegion 0x0000000000000400-0x000000000000040F (\SMRG) (20250404/utaddress-204)
> [    7.414432] ACPI Warning: SystemIO range 0x0000000000000400-0x000000000000041F conflicts with OpRegion 0x0000000000000400-0x000000000000040F (\_SB.PCI0.SBRG.SMRG) (20250404/utaddress-204)
> [    7.414457] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [    7.424783] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000800-0x000000000000087F (\PMIO) (20250404/utaddress-204)
> [    7.424830] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x000000000000082F (\_SB.PCI0.SBRG.IELK.GPSE) (20250404/utaddress-204)
> [    7.424858] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [    7.424872] ACPI Warning: SystemIO range 0x00000000000004B0-0x00000000000004BF conflicts with OpRegion 0x0000000000000480-0x00000000000004BF (\_SB.PCI0.SBRG.GPBX) (20250404/utaddress-204)
> [    7.424899] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [    7.424909] ACPI Warning: SystemIO range 0x0000000000000480-0x00000000000004AF conflicts with OpRegion 0x0000000000000480-0x00000000000004BF (\_SB.PCI0.SBRG.GPBX) (20250404/utaddress-204)
> [    7.424936] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [    7.424943] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [    7.933643] atl1c 0000:01:00.0 enp1s0: renamed from eth0
> [    7.995822] ACPI: bus type drm_connector registered
> [    8.027078] ACPI: bus type USB registered
> [    8.027327] usbcore: registered new interface driver usbfs
> [    8.027419] usbcore: registered new interface driver hub
> [    8.027489] usbcore: registered new device driver usb
> [    8.079446] SCSI subsystem initialized
> [    8.213722] iTCO_vendor_support: vendor-support=0
> [    8.400796] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    8.400847] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
> [    8.400886] ehci-pci 0000:00:1d.7: debug port 1
> [    8.404953] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf7cf7c00
> [    8.420365] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    8.420797] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.16
> [    8.420815] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.420827] usb usb1: Product: EHCI Host Controller
> [    8.420837] usb usb1: Manufacturer: Linux 6.16.9+deb14-amd64 ehci_hcd
> [    8.420847] usb usb1: SerialNumber: 0000:00:1d.7
> [    8.424150] iTCO_wdt iTCO_wdt.1.auto: Found a NM10 TCO device (Version=2, TCOBASE=0x0860)
> [    8.428813] hub 1-0:1.0: USB hub found
> [    8.428887] hub 1-0:1.0: 8 ports detected
> [    8.443459] iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=30 sec (nowayout=0)
> [    8.585639] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    8.585679] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> [    8.585706] uhci_hcd 0000:00:1d.0: detected 2 ports
> [    8.585877] uhci_hcd 0000:00:1d.0: irq 23, io port 0x0000d400
> [    8.586362] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.16
> [    8.586379] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.586391] usb usb2: Product: UHCI Host Controller
> [    8.586401] usb usb2: Manufacturer: Linux 6.16.9+deb14-amd64 uhci_hcd
> [    8.586411] usb usb2: SerialNumber: 0000:00:1d.0
> [    8.587215] hub 2-0:1.0: USB hub found
> [    8.587287] hub 2-0:1.0: 2 ports detected
> [    8.588781] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    8.588857] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> [    8.588890] uhci_hcd 0000:00:1d.1: detected 2 ports
> [    8.589041] uhci_hcd 0000:00:1d.1: irq 19, io port 0x0000d480
> [    8.589603] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.16
> [    8.589625] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.589640] usb usb3: Product: UHCI Host Controller
> [    8.589653] usb usb3: Manufacturer: Linux 6.16.9+deb14-amd64 uhci_hcd
> [    8.589663] usb usb3: SerialNumber: 0000:00:1d.1
> [    8.596619] hub 3-0:1.0: USB hub found
> [    8.596705] hub 3-0:1.0: 2 ports detected
> [    8.598494] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    8.598534] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> [    8.598564] uhci_hcd 0000:00:1d.2: detected 2 ports
> [    8.598709] uhci_hcd 0000:00:1d.2: irq 18, io port 0x0000d800
> [    8.599314] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.16
> [    8.599338] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.599353] usb usb4: Product: UHCI Host Controller
> [    8.599366] usb usb4: Manufacturer: Linux 6.16.9+deb14-amd64 uhci_hcd
> [    8.599379] usb usb4: SerialNumber: 0000:00:1d.2
> [    8.600436] hub 4-0:1.0: USB hub found
> [    8.600550] hub 4-0:1.0: 2 ports detected
> [    8.602280] uhci_hcd 0000:00:1d.3: UHCI Host Controller
> [    8.602359] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
> [    8.602391] uhci_hcd 0000:00:1d.3: detected 2 ports
> [    8.602573] uhci_hcd 0000:00:1d.3: irq 16, io port 0x0000d880
> [    8.609121] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.16
> [    8.609147] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    8.609161] usb usb5: Product: UHCI Host Controller
> [    8.609174] usb usb5: Manufacturer: Linux 6.16.9+deb14-amd64 uhci_hcd
> [    8.609186] usb usb5: SerialNumber: 0000:00:1d.3
> [    8.610227] hub 5-0:1.0: USB hub found
> [    8.610331] hub 5-0:1.0: 2 ports detected
> [    8.672561] libata version 3.00 loaded.
> [    8.680406] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    8.846187] usb 1-1: New USB device found, idVendor=1307, idProduct=0165, bcdDevice= 1.00
> [    8.846212] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    8.846225] usb 1-1: Product: Intenso Premium Line
> [    8.846236] usb 1-1: Manufacturer: USBest Technology
> [    8.846246] usb 1-1: SerialNumber: 09020400025304
> [    8.895828] ahci 0000:00:1f.2: AHCI vers 0001.0100, 32 command slots, 3 Gbps, SATA mode
> [    8.895854] ahci 0000:00:1f.2: 1/4 ports implemented (port mask 0x1)
> [    8.895866] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
> [    8.908606] scsi host0: ahci
> [    8.913417] scsi host1: ahci
> [    8.920539] scsi host2: ahci
> [    8.921870] scsi host3: ahci
> [    8.922370] ata1: SATA max UDMA/133 abar m1024@0xf7cf7800 port 0xf7cf7900 irq 24 lpm-pol 3
> [    8.922392] ata2: DUMMY
> [    8.922400] ata3: DUMMY
> [    8.922407] ata4: DUMMY
> [    8.968385] usb 1-6: new high-speed USB device number 3 using ehci-pci
> [    9.118661] usb 1-6: New USB device found, idVendor=13d3, idProduct=5111, bcdDevice= 9.17
> [    9.118687] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=2
> [    9.118699] usb 1-6: Product: USB2.0 UVC VGA WebCam
> [    9.118708] usb 1-6: Manufacturer: Image Processor
> [    9.118717] usb 1-6: SerialNumber: USB2.0 UVC VGA WebCam
> [    9.232346] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    9.236919] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [    9.240342] ata1.00: ATA-8: Hitachi HTS545025B9A300, PB2OC60N, max UDMA/133
> [    9.252360] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    9.253979] usb-storage 1-1:1.0: USB Mass Storage device detected
> [    9.255549] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [    9.255968] ata1.00: configured for UDMA/133
> [    9.256869] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54502 C60N PQ: 0 ANSI: 5
> [    9.263303] scsi host4: usb-storage 1-1:1.0
> [    9.263853] usbcore: registered new interface driver usb-storage
> [    9.268367] psmouse serio1: synaptics: queried max coordinates: x [..5808], y [..4842]
> [    9.332115] usbcore: registered new interface driver uas
> [    9.414331] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
> [    9.414416] sd 0:0:0:0: [sda] Write Protect is off
> [    9.414431] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    9.414554] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    9.414782] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    9.416739] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1a0b1, caps: 0xd04731/0xa40000/0xa0000/0x0, board id: 0, fw id: 570166
> [    9.488815] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
> [    9.864434]  sda: sda1 sda2 < sda5 >
> [    9.865323] sd 0:0:0:0: [sda] Attached SCSI disk
> [   10.281756] scsi 4:0:0:0: Direct-Access     Intenso  Premium          0.00 PQ: 0 ANSI: 2
> [   10.398199] sd 4:0:0:0: [sdb] 7897088 512-byte logical blocks: (4.04 GB/3.77 GiB)
> [   10.399212] sd 4:0:0:0: [sdb] Write Protect is off
> [   10.399236] sd 4:0:0:0: [sdb] Mode Sense: 00 00 00 00
> [   10.400225] sd 4:0:0:0: [sdb] Asking for cache data failed
> [   10.400381] sd 4:0:0:0: [sdb] Assuming drive cache: write through
> [   10.750237]  sdb: sdb1 sdb2
> [   10.751189] sd 4:0:0:0: [sdb] Attached SCSI removable disk
> [   12.754885] i915 0000:00:02.0: [drm] Found pineview (device ID a011) integrated display version 3.00 stepping N/A
> [   12.755516] pci 0000:00:00.0: Intel GMA3150 Chipset
> [   12.755581] pci 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
> [   12.755705] pci 0000:00:00.0: detected 8192K stolen memory
> [   12.755977] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   12.756947] Console: switching to colour dummy device 80x25
> [   12.777080] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   12.790260] i915 0000:00:02.0: [drm] Initialized overlay support.
> [   12.792174] i915 0000:00:02.0: [drm] Skipping intel_backlight registration
> [   12.792627] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
> [   12.793513] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
> [   12.794938] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
> [   12.806663] acpi device:0d: registered as cooling_device2
> [   12.824156] fbcon: i915drmfb (fb0) is primary device
> [   13.562760] Console: switching to colour frame buffer device 128x37
> [   13.582089] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [   14.060305] raid6: sse2x4   gen()  2666 MB/s
> [   14.128307] raid6: sse2x2   gen()  2218 MB/s
> [   14.196349] raid6: sse2x1   gen()  1615 MB/s
> [   14.196363] raid6: using algorithm sse2x4 gen() 2666 MB/s
> [   14.264302] raid6: .... xor() 922 MB/s, rmw enabled
> [   14.264311] raid6: using ssse3x2 recovery algorithm
> [   14.292161] xor: measuring software checksum speed
> [   14.292759]    prefetch64-sse  :  5646 MB/sec
> [   14.293362]    generic_sse     :  5561 MB/sec
> [   14.293367] xor: using function: prefetch64-sse (5646 MB/sec)
> [   14.319689] async_tx: api initialized (async)
> [   15.036209] ISO 9660 Extensions: Microsoft Joliet Level 3
> [   15.037590] ISO 9660 Extensions: RRIP_1991A
> [   15.255387] loop: module loaded
> [   15.338512] loop0: detected capacity change from 0 to 3463272
> [   15.495582] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   15.572969] evm: overlay not supported
> [   18.112365] random: crng init done
> [   18.778984] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> [   20.560765] systemd[1]: Inserted module 'autofs4'
> [   20.757670] systemd[1]: systemd 258-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
> [   20.757708] systemd[1]: Detected architecture x86-64.
> [   20.824517] systemd[1]: Initializing machine ID from random generator.
> [   20.851769] systemd[1]: Hostname set to <localhost.localdomain>.
> [   21.401093] systemd[1]: bpf-restrict-fs: LSM BPF program attached
> [   22.276348] systemd[1]: /usr/lib/systemd/system/xfs_scrub_all.service:26: Support for option CPUAccounting= has been removed and it is ignored
> [   22.279782] systemd[1]: /usr/lib/systemd/system/system-xfs_scrub.slice:15: Support for option CPUAccounting= has been removed and it is ignored
> [   22.720812] systemd[1]: Queued start job for default target graphical.target.
> [   22.805782] systemd[1]: Created slice system-cups.slice - CUPS Slice.
> [   22.809024] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
> [   22.811913] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> [   22.815080] systemd[1]: Created slice system-xfs_scrub.slice - xfs_scrub background service slice.
> [   22.817492] systemd[1]: Created slice user.slice - User and Session Slice.
> [   22.817987] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
> [   22.818338] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> [   22.819580] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> [   22.819819] systemd[1]: Reached target imports.target - Image Downloads.
> [   22.820036] systemd[1]: Reached target remote-fs.target - Remote File Systems.
> [   22.820138] systemd[1]: Reached target slices.target - Slice Units.
> [   22.820345] systemd[1]: Reached target swap.target - Swaps.
> [   22.821047] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
> [   22.821647] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
> [   22.835515] systemd[1]: Listening on systemd-ask-password.socket - Query the User Interactively for a Password.
> [   22.840955] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
> [   22.848712] systemd[1]: Listening on systemd-factory-reset.socket - Factory Reset Management.
> [   22.849490] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> [   22.850201] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
> [   22.850468] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   22.850589] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   22.851233] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> [   22.851691] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> [   22.852251] systemd[1]: Listening on systemd-udevd-varlink.socket - udev Varlink Socket.
> [   22.873566] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> [   22.884751] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> [   22.896701] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> [   22.912725] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> [   22.932760] systemd[1]: Starting blk-availability.service - Availability of block devices...
> [   22.968769] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
> [   23.028827] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> [   23.041142] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [   23.085621] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> [   23.085983] systemd[1]: modprobe@drm.service - Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
> [   23.100151] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> [   23.100539] systemd[1]: modprobe@fuse.service - Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
> [   23.110347] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> [   23.110861] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
> [   23.136264] systemd[1]: Starting systemd-journald.service - Journal Service...
> [   23.219829] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> [   23.219966] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   23.251329] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> [   23.251717] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   23.273688] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
> [   23.296767] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> [   23.320957] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> [   23.322045] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> [   23.323252] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> [   23.324271] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> [   23.337307] systemd[1]: Finished blk-availability.service - Availability of block devices.
> [   23.340220] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> [   23.342033] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> [   23.356447] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> [   23.614129] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> [   23.615576] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> [   23.701897] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> [   23.759006] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because no trigger condition checks were met.
> [   23.759376] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> [   23.790431] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> [   23.790592] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   23.827587] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [   23.830236] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> [   23.845805] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> [   23.970965] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> [   24.012496] lp: driver loaded but no devices found
> [   24.108980] systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
> [   24.147824] systemd-journald[425]: Collecting audit messages is disabled.
> [   24.184400] ppdev: user-space parallel port driver
> [   24.193269] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> [   24.375271] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> [   24.403361] systemd[1]: Starting systemd-sysusers.service - Create System Users...
> [   24.406067] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> [   24.417372] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> [   24.855266] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> [   25.119243] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
> [   25.184871] systemd[1]: Finished systemd-sysusers.service - Create System Users.
> [   25.192693] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> [   25.483522] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
> [   25.509935] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
> [   25.676669] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [   25.676836] device-mapper: uevent: version 1.0.3
> [   25.677397] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
> [   25.877798] systemd[1]: Finished lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> [   25.878619] systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
> [   25.896717] systemd[1]: Mounting tmp.mount - /tmp...
> [   25.981735] systemd[1]: Started systemd-journald.service - Journal Service.
> [   26.273048] systemd-journald[425]: Received client request to flush runtime journal.
> [   32.947113] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   32.966390] sd 4:0:0:0: Attached scsi generic sg1 type 0
> [   34.331802] ACPI: AC: AC Adapter [AC0] (on-line)
> [   37.146003] 8021q: 802.1Q VLAN Support v1.8
> [   38.477230] input: PC Speaker as /devices/platform/pcspkr/input/input8
> [   39.395496] mc: Linux media interface: v0.10
> [   40.522789] asus_wmi: ASUS WMI generic driver loaded
> [   42.637096] intel_powerclamp: No package C-state available
> [   42.638066] eeepc_wmi: Found legacy ATKD device (ASUS010)
> [   42.638082] eeepc_wmi: WMI device present, but legacy ATKD device is also present and enabled
> [   42.638089] eeepc_wmi: You probably booted with acpi_osi="Linux" or acpi_osi="!Windows 2009"
> [   42.638094] eeepc_wmi: Can't load eeepc-wmi, use default acpi_osi (preferred) or eeepc-laptop
> [   42.638105] eeepc-wmi eeepc-wmi: probe with driver eeepc-wmi failed with error -16
> [   42.679464] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   42.801595] videodev: Linux video capture interface: v2.00
> [   42.866119] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
> [   42.868202] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
> [   42.887065] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   42.929777] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   43.739056] usb 1-6: Found UVC 1.00 device USB2.0 UVC VGA WebCam (13d3:5111)
> [   43.786000] input: USB2.0 UVC VGA WebCam as /devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/input/input9
> [   43.786394] usbcore: registered new interface driver uvcvideo
> [   44.525923] snd_hda_codec_realtek hdaudioC0D0: ALC269: picked fixup  for PCI SSID 1043:83ce
> [   44.526475] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   44.526496] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   44.526509] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [   44.526521] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   44.526530] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   44.526540] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
> [   44.526551] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [   44.636471] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
> [   44.637186] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
> [   44.637738] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> [   46.072872] ath: phy0: ASPM enabled: 0x42
> [   46.072899] ath: EEPROM regdomain: 0x60
> [   46.072907] ath: EEPROM indicates we should expect a direct regpair map
> [   46.072919] ath: Country alpha2 being used: 00
> [   46.072925] ath: Regpair used: 0x60
> [   46.078732] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   46.124506] ieee80211 phy0: Atheros AR9285 Rev:2 mem=0x000000007000cbdc, irq=17
> [   46.345386] ath9k 0000:02:00.0 wlp2s0: renamed from wlan0
> [   62.555775] perf: interrupt took too long (2562 > 2500), lowering kernel.perf_event_max_sample_rate to 78000
> [  488.716372] perf: interrupt took too long (3222 > 3202), lowering kernel.perf_event_max_sample_rate to 62000
> [  506.273608] wlp2s0: authenticate with 0c:72:74:4f:ae:46 (local address=00:25:d3:f6:64:82)
> [  506.273638] wlp2s0: send auth to 0c:72:74:4f:ae:46 (try 1/3)
> [  506.276097] wlp2s0: authenticated
> [  506.284461] wlp2s0: associate with 0c:72:74:4f:ae:46 (try 1/3)
> [  506.288824] wlp2s0: RX AssocResp from 0c:72:74:4f:ae:46 (capab=0x1411 status=0 aid=23)
> [  506.289112] wlp2s0: associated
> [  506.290657] ath: EEPROM regdomain: 0x8114
> [  506.290686] ath: EEPROM indicates we should expect a country code
> [  506.290699] ath: doing EEPROM country->regdmn map search
> [  506.290709] ath: country maps to regdmn code: 0x37
> [  506.290722] ath: Country alpha2 being used: DE
> [  506.290734] ath: Regpair used: 0x37
> [  506.290748] ath: regdomain 0x8114 dynamically updated by country element
> [  506.444619] wlp2s0: Limiting TX power to 20 (20 - 0) dBm as advertised by 0c:72:74:4f:ae:46


