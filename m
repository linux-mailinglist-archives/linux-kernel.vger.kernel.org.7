Return-Path: <linux-kernel+bounces-768017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C6B25BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DEA1C837BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED4252917;
	Thu, 14 Aug 2025 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7Am7xHG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E52550D8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153452; cv=none; b=WvenHxCWm8S2ehRFc1s9tgCIRRyv0lmWfTHXuMTLJR2N9z563GJku/wdW9o/RIxHyTx1fXtVt5g773TaMwnHwUV2b2bmQ6+cEdf7FxxZJAIU4d6nvVJYsj281O7AyRyIWzlKlhrEP+7+JnMzk7i2fmiWAszaY1qTrRLAKTv0gpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153452; c=relaxed/simple;
	bh=nrqwDzxcIkD3ejQh6YfVPxcLZik5Dyh3XVG3HXFpYzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWXUO3r/jRNw4dB3j2qMnenMnziRpLsi4yAUmN8+ZBkX1GKOdn5emdXgybjHWS6M4dAc2X/1pc13S5Sb7Pv9yRyP2LdKHyMjEqAqfnZcO4Cq3prIeMMBVem1WfuFaAwQMIl5gliUEcnhmDeQHv6y/BQ+AEPBVGxZG8b20jszrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7Am7xHG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755153451; x=1786689451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nrqwDzxcIkD3ejQh6YfVPxcLZik5Dyh3XVG3HXFpYzo=;
  b=O7Am7xHG2RbznA26YTfhvHV3XLLFZFpKYM8Rd276zonADFs7K73+4WBS
   QyeMI5jQqKyUXcNJxg62hi6/z0oxvLDCbRI7TXnPa7XiPXiz3L7OAcSFY
   FS3hceY4qRgtPSZAYAfnB2SKRaDzrLn+9adHqRbiLnseaXCJoyPmRyfEB
   IJNH/3JPLE/JzoflTodSTdDsqnYdm0veOJU+nEFHfMu0Mk0eq+A+vjemg
   P2ffjIgEe4mMwT65XgxEYcjtqhqlrx8EtBeDyBfzNsLauPZpCtdRaBH7z
   qKcEbboLGPakoUFreC/K7in1YbJKqc+cWz68EnjkAm3K12UWhXZMiPBQg
   g==;
X-CSE-ConnectionGUID: ycqVS/AgR4y3hLIDmXlZag==
X-CSE-MsgGUID: O1ZL9A/9TtyUQ05M4sKhkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57329135"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57329135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:37:30 -0700
X-CSE-ConnectionGUID: 4MG2ptl6QhGg+ECJckr8vw==
X-CSE-MsgGUID: GKT132VxThKNG1WqwMZt5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167487347"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 23:37:27 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umRaX-000Aem-1A;
	Thu, 14 Aug 2025 06:37:25 +0000
Date: Thu, 14 Aug 2025 14:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Horvath <s.horvath@outlook.com.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Message-ID: <202508141439.JO8YA6fq-lkp@intel.com>
References: <20250813112020.345622-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813112020.345622-1-s.horvath@outlook.com.au>

Hi Stephen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.17-rc1 next-20250814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Horvath/x86-tsc-Read-AMD-CPU-frequency-from-Core-X86-Msr-PStateDef/20250813-192644
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250813112020.345622-1-s.horvath%40outlook.com.au
patch subject: [PATCH] x86/tsc: Read AMD CPU frequency from Core::X86::Msr::PStateDef
config: i386-randconfig-007-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141439.JO8YA6fq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141439.JO8YA6fq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141439.JO8YA6fq-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/tsc_msr.o: in function `cpu_khz_from_msr_amd':
>> arch/x86/kernel/tsc_msr.c:307: undefined reference to `__udivdi3'


vim +307 arch/x86/kernel/tsc_msr.c

   237	
   238	/*
   239	 * MSR-based CPU/TSC frequency discovery for AMD Zen CPUs.
   240	 *
   241	 * Return processor base frequency in KHz, or 0 on failure.
   242	 */
   243	unsigned long cpu_khz_from_msr_amd(void)
   244	{
   245		u64 hwcr, pstatedef;
   246		unsigned long cpufid, cpudfsid, p0_freq;
   247	
   248		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
   249			return 0;
   250	
   251		/*
   252		 * This register mapping is only valid for Zen and later CPUs.
   253		 * X86_FEATURE_ZEN is not set yet, so we just check the cpuid.
   254		 */
   255		if (boot_cpu_data.x86 < 0x17)
   256			return 0;
   257	
   258		/*
   259		 * PPR states for MSR0000_0010:
   260		 * The TSC increments at the P0 frequency. The TSC counts at the
   261		 * same rate in all P-states, all C states, S0, or S1.
   262		 */
   263	
   264		/* Read the Hardware Configuration MSR (MSRC001_0015) */
   265		if (rdmsrq_safe(MSR_K7_HWCR, &hwcr))
   266			return 0;
   267	
   268		/*
   269		 * Check TscFreqSel (bit 24) is set.
   270		 * This verifies the TSC does actually increment at P0 frequency.
   271		 * E.g. VMs may be configured to increment at a different rate.
   272		 */
   273		if (!(hwcr & BIT_64(24)))
   274			return 0;
   275	
   276		/* Read the zeroth PStateDef MSR (MSRC001_0064) */
   277		if (rdmsrq_safe(MSR_AMD_PSTATE_DEF_BASE, &pstatedef))
   278			return 0;
   279	
   280		/* Check PstateEn is set (bit 63) */
   281		if (!(pstatedef & BIT_64(63)))
   282			return 0;
   283	
   284		/* CpuFid is the first 8 bits (7:0) */
   285		cpufid = pstatedef & 0xff;
   286	
   287		/* Values between 0Fh-00h are reserved */
   288		if (cpufid < 0x0F)
   289			return 0;
   290	
   291		/* The PPR defines the core multiplier as CpuFid * 25MHz */
   292		p0_freq = cpufid * 25;
   293	
   294		/* Convert from MHz to KHz before dividing */
   295		p0_freq *= 1000;
   296	
   297		/* CpuDfsId is the next 6 bits (13:8) */
   298		cpudfsid = (pstatedef >> 8) & 0x3f;
   299	
   300		/* Calculate the core divisor */
   301		switch (cpudfsid) {
   302		case 0x08:
   303			/* VCO/1 */
   304			break;
   305		case 0x09:
   306			/* VCO/1.125 */
 > 307			p0_freq = (unsigned long)(p0_freq * 1125ull / 1000);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

