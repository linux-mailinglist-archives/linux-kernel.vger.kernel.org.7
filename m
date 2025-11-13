Return-Path: <linux-kernel+bounces-898675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FBC55B81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED44C34E90B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E298305044;
	Thu, 13 Nov 2025 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbsyubLG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDA30276D;
	Thu, 13 Nov 2025 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009609; cv=none; b=jfb0qOjwXlH0CKROfcqIdDG8mrTCCbaCbiVD3bwKbrcikIP5fS/8pioI7wMkQSrMPJKmpu3Ke1vudScHDO2lESEchZt2dKKIRL9Dkhqci9SAJ6wIxfIdaM59zDbi2xJ5aBhdrMpe9a8PQmgKpegwqtT3j7Xa7pyZgzrghWgO6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009609; c=relaxed/simple;
	bh=/S+WjjUSEkVtvCHe8svQ+akEl//PD1NKJVfzgDfMQlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoKI5py5kn1S038enrKI5TjZ/G561MTvP28dzZnwJaLnr9BgpV8IfLtsI4Mxvy0WVrk4Uq9k5NvGf/Wk7pZrWSKuKOpC3pfeA3x0j0il3z5IP1OgDWhVxgpLNZm7azAFPZ9SqIqxgX9oM/9ZPxtgSDnir4ACi0OAcqG1poQWTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbsyubLG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009608; x=1794545608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/S+WjjUSEkVtvCHe8svQ+akEl//PD1NKJVfzgDfMQlE=;
  b=JbsyubLG8eI61XEnNBHr0aecFkwUxb+G2js0gGbitbq39CaMtsKb89tA
   AvKDLBDWLL34GyFk5ZwKcEoV1T4K/SZkT2j/exiIX0KVFs9BsnMr3Y8zl
   xCQZnpKBSDthP/ZU02jzBT9ejWmFOlmoKoBTnCwu6710rADLU03upJLJ7
   xUDe4q+UR8ul3jYYcLvu5fOsqVOH6oCzbyxi3Pk6+ig+SKMPXMgiKXszG
   VPVDv1eYoT7k1PWVQi0cfVPzGx9YWjKuDaH8E/vnkLQMT9cthx6jFMLKV
   qs+FEZRWXZDQ1bfQc7TeRSpUM4VZGqRPKzL6Nds8I+jJX+Iumz3XMyLFe
   g==;
X-CSE-ConnectionGUID: cYmnKD5jSraGiFZy+XB8fw==
X-CSE-MsgGUID: KLGYLXJtSQGBCcXcUWLMVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82480088"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82480088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:53:28 -0800
X-CSE-ConnectionGUID: de5TNagITzuMYBg/6vVGzA==
X-CSE-MsgGUID: 6ZLSdvckRpGmIxHl17leoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189415465"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 20:53:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPKh-0004tx-1F;
	Thu, 13 Nov 2025 04:53:19 +0000
Date: Thu, 13 Nov 2025 12:53:18 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH v3 06/22] mm: Always use page table accessor functions
Message-ID: <202511131136.6CBuWpof-lkp@intel.com>
References: <20251113014656.2605447-7-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113014656.2605447-7-samuel.holland@sifive.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 24172e0d79900908cf5ebf366600616d29c9b417]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/mm-ptdump-replace-READ_ONCE-with-standard-page-table-accessors/20251113-095117
base:   24172e0d79900908cf5ebf366600616d29c9b417
patch link:    https://lore.kernel.org/r/20251113014656.2605447-7-samuel.holland%40sifive.com
patch subject: [PATCH v3 06/22] mm: Always use page table accessor functions
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511131136.6CBuWpof-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131136.6CBuWpof-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131136.6CBuWpof-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/pgtable-generic.c:27:2: error: cannot take the address of an rvalue of type 'pgd_t'
      27 |         pgd_ERROR(pgdp_get(pgd));
         |         ^         ~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_64.h:50:29: note: expanded from macro 'pgd_ERROR'
      50 |                __FILE__, __LINE__, &(e), pgd_val(e))
         |                                    ^ ~
   include/linux/printk.h:555:33: note: expanded from macro 'pr_err'
     555 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> mm/pgtable-generic.c:34:2: error: cannot take the address of an rvalue of type 'p4d_t'
      34 |         p4d_ERROR(p4dp_get(p4d));
         |         ^         ~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_64.h:46:29: note: expanded from macro 'p4d_ERROR'
      46 |                __FILE__, __LINE__, &(e), p4d_val(e))
         |                                    ^ ~
   include/linux/printk.h:555:33: note: expanded from macro 'pr_err'
     555 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> mm/pgtable-generic.c:42:2: error: cannot take the address of an rvalue of type 'pud_t'
      42 |         pud_ERROR(pudp_get(pud));
         |         ^         ~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_64.h:42:29: note: expanded from macro 'pud_ERROR'
      42 |                __FILE__, __LINE__, &(e), pud_val(e))
         |                                    ^ ~
   include/linux/printk.h:555:33: note: expanded from macro 'pr_err'
     555 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> mm/pgtable-generic.c:54:2: error: cannot take the address of an rvalue of type 'pmd_t'
      54 |         pmd_ERROR(pmdp_get(pmd));
         |         ^         ~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_64.h:39:29: note: expanded from macro 'pmd_ERROR'
      39 |                __FILE__, __LINE__, &(e), pmd_val(e))
         |                                    ^ ~
   include/linux/printk.h:555:33: note: expanded from macro 'pr_err'
     555 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   4 errors generated.


vim +/pgd_t +27 mm/pgtable-generic.c

    18	
    19	/*
    20	 * If a p?d_bad entry is found while walking page tables, report
    21	 * the error, before resetting entry to p?d_none.  Usually (but
    22	 * very seldom) called out from the p?d_none_or_clear_bad macros.
    23	 */
    24	
    25	void pgd_clear_bad(pgd_t *pgd)
    26	{
  > 27		pgd_ERROR(pgdp_get(pgd));
    28		pgd_clear(pgd);
    29	}
    30	
    31	#ifndef __PAGETABLE_P4D_FOLDED
    32	void p4d_clear_bad(p4d_t *p4d)
    33	{
  > 34		p4d_ERROR(p4dp_get(p4d));
    35		p4d_clear(p4d);
    36	}
    37	#endif
    38	
    39	#ifndef __PAGETABLE_PUD_FOLDED
    40	void pud_clear_bad(pud_t *pud)
    41	{
  > 42		pud_ERROR(pudp_get(pud));
    43		pud_clear(pud);
    44	}
    45	#endif
    46	
    47	/*
    48	 * Note that the pmd variant below can't be stub'ed out just as for p4d/pud
    49	 * above. pmd folding is special and typically pmd_* macros refer to upper
    50	 * level even when folded
    51	 */
    52	void pmd_clear_bad(pmd_t *pmd)
    53	{
  > 54		pmd_ERROR(pmdp_get(pmd));
    55		pmd_clear(pmd);
    56	}
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

