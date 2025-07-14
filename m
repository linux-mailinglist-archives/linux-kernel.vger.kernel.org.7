Return-Path: <linux-kernel+bounces-730726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA739B048A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146C316C633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A522376F8;
	Mon, 14 Jul 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2yCalwF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD4231A32
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525312; cv=none; b=ZLD0+MnoCfFB/FFYaAPz9dO3mG5A/8Hsux0ZBa02zlnWCuESIBph/zm14epE5Gze3ZED/6sLD3kY0KbtdisGlJ1onBp7R3OZiRYRbjbChjsErOIyU1MVWN0mr9pdfyXK7EllZqXuk0owg8iTj6G/wS6MX2gRBPOx1wlWq1FIWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525312; c=relaxed/simple;
	bh=d9o1GGJ7p6AQZPByJ803Cs+qEKbmdKWrkFKKV4lTAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i91cKISPMsgq3SpEotaW76blPkyF4PCggEvvbVC++wDIaTHmjtf8dAnTSnekAcKLJI02LBn3tEsDGRHAjlo+UettYRxaz11K5hSHX8SVa/tlICiXDeD7lun1VvQeqY3tiYCikez1KF8CNkOWdGNkT4iFrjiaZrl7zz4YDcTewJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2yCalwF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752525311; x=1784061311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9o1GGJ7p6AQZPByJ803Cs+qEKbmdKWrkFKKV4lTAhE=;
  b=X2yCalwFYz8B8Rqzd3ESLMneR7vqjv5r6GyNwx/da8xuPHLGmUiXAjOu
   r2rFWNVrQi2V85JLw51dZBbpymkUdM8fc6bFTdv5zU6qj+TkLvYauW4d/
   ZXGRQ4v0JVEbTqjvXgDKv1waUduRjF6+mpVkIZ9ZYqiebBf31icaIhYYj
   hNx3bwg0myL1j8hkCxaMiqqEzfQc2WeY9d88lOYW6Sw6u3cSA6BAJ3UK7
   ebzI4ymGYbMZK207I8eJCPhd6tcGS/BHxawUm3m+X0+x9V7Yvqjk65nQx
   8jXX4TUWh6gskNB5cuawDDb8OUjVOHu0Bg43i4+LPeaTzYhNWT4byByE4
   A==;
X-CSE-ConnectionGUID: 4NVPKK2nSWuhxnbS6L0zdA==
X-CSE-MsgGUID: yQEmnW99TIOEIkRkfhR+Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72180345"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="72180345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:35:10 -0700
X-CSE-ConnectionGUID: 7nfCtbUpTbOdzEmbQSHAuQ==
X-CSE-MsgGUID: DnUvKCJ/Tbenx4L3r9R5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161347666"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Jul 2025 13:35:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubPtA-0009JD-2q;
	Mon, 14 Jul 2025 20:35:04 +0000
Date: Tue, 15 Jul 2025 04:34:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH v2 6/6] x86/cpu: <asm/processor.h>: Do not include CPUID
 API header
Message-ID: <202507150403.hKKg9xjJ-lkp@intel.com>
References: <20250709203033.90125-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709203033.90125-7-darwi@linutronix.de>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on d7b8f8e20813f0179d8ef519541a3527e7661d3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-S-Darwish/x86-cpuid-Remove-transitional-asm-cpuid-h-header/20250710-043320
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250709203033.90125-7-darwi%40linutronix.de
patch subject: [PATCH v2 6/6] x86/cpu: <asm/processor.h>: Do not include CPUID API header
config: i386-randconfig-005-20250714 (https://download.01.org/0day-ci/archive/20250715/202507150403.hKKg9xjJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150403.hKKg9xjJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150403.hKKg9xjJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/agp/efficeon-agp.c: In function 'efficeon_create_gatt_table':
>> drivers/char/agp/efficeon-agp.c:197:37: error: implicit declaration of function 'cpuid_ebx' [-Werror=implicit-function-declaration]
     197 |         const int clflush_chunk = ((cpuid_ebx(1) >> 8) & 0xff) << 3;
         |                                     ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpuid_ebx +197 drivers/char/agp/efficeon-agp.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  177  
^1da177e4c3f41 Linus Torvalds  2005-04-16  178  
^1da177e4c3f41 Linus Torvalds  2005-04-16  179  /*
d6e05edc59ecd7 Andreas Mohr    2006-06-26  180   * Since we don't need contiguous memory we just try
^1da177e4c3f41 Linus Torvalds  2005-04-16  181   * to get the gatt table once
^1da177e4c3f41 Linus Torvalds  2005-04-16  182   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  183  
^1da177e4c3f41 Linus Torvalds  2005-04-16  184  #define GET_PAGE_DIR_OFF(addr) (addr >> 22)
^1da177e4c3f41 Linus Torvalds  2005-04-16  185  #define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr) - \
^1da177e4c3f41 Linus Torvalds  2005-04-16  186  	GET_PAGE_DIR_OFF(agp_bridge->gart_bus_addr))
^1da177e4c3f41 Linus Torvalds  2005-04-16  187  #define GET_GATT_OFF(addr) ((addr & 0x003ff000) >> 12)
^1da177e4c3f41 Linus Torvalds  2005-04-16  188  #undef  GET_GATT
^1da177e4c3f41 Linus Torvalds  2005-04-16  189  #define GET_GATT(addr) (efficeon_private.gatt_pages[\
^1da177e4c3f41 Linus Torvalds  2005-04-16  190  	GET_PAGE_DIR_IDX(addr)]->remapped)
^1da177e4c3f41 Linus Torvalds  2005-04-16  191  
^1da177e4c3f41 Linus Torvalds  2005-04-16  192  static int efficeon_create_gatt_table(struct agp_bridge_data *bridge)
^1da177e4c3f41 Linus Torvalds  2005-04-16  193  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  194  	int index;
^1da177e4c3f41 Linus Torvalds  2005-04-16  195  	const int pati    = EFFICEON_PATI;
^1da177e4c3f41 Linus Torvalds  2005-04-16  196  	const int present = EFFICEON_PRESENT;
^1da177e4c3f41 Linus Torvalds  2005-04-16 @197  	const int clflush_chunk = ((cpuid_ebx(1) >> 8) & 0xff) << 3;
^1da177e4c3f41 Linus Torvalds  2005-04-16  198  	int num_entries, l1_pages;
^1da177e4c3f41 Linus Torvalds  2005-04-16  199  
^1da177e4c3f41 Linus Torvalds  2005-04-16  200  	num_entries = A_SIZE_LVL2(agp_bridge->current_size)->num_entries;
^1da177e4c3f41 Linus Torvalds  2005-04-16  201  
^1da177e4c3f41 Linus Torvalds  2005-04-16  202  	printk(KERN_DEBUG PFX "efficeon_create_gatt_table(%d)\n", num_entries);
^1da177e4c3f41 Linus Torvalds  2005-04-16  203  
^1da177e4c3f41 Linus Torvalds  2005-04-16  204  	/* There are 2^10 PTE pages per PDE page */
^1da177e4c3f41 Linus Torvalds  2005-04-16  205  	BUG_ON(num_entries & 0x3ff);
^1da177e4c3f41 Linus Torvalds  2005-04-16  206  	l1_pages = num_entries >> 10;
^1da177e4c3f41 Linus Torvalds  2005-04-16  207  
^1da177e4c3f41 Linus Torvalds  2005-04-16  208  	for (index = 0 ; index < l1_pages ; index++) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  209  		int offset;
^1da177e4c3f41 Linus Torvalds  2005-04-16  210  		unsigned long page;
^1da177e4c3f41 Linus Torvalds  2005-04-16  211  		unsigned long value;
^1da177e4c3f41 Linus Torvalds  2005-04-16  212  
^1da177e4c3f41 Linus Torvalds  2005-04-16  213  		page = efficeon_private.l1_table[index];
^1da177e4c3f41 Linus Torvalds  2005-04-16  214  		BUG_ON(page);
^1da177e4c3f41 Linus Torvalds  2005-04-16  215  
^1da177e4c3f41 Linus Torvalds  2005-04-16  216  		page = get_zeroed_page(GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds  2005-04-16  217  		if (!page) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  218  			efficeon_free_gatt_table(agp_bridge);
^1da177e4c3f41 Linus Torvalds  2005-04-16  219  			return -ENOMEM;
^1da177e4c3f41 Linus Torvalds  2005-04-16  220  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  221  
^1da177e4c3f41 Linus Torvalds  2005-04-16  222  		for (offset = 0; offset < PAGE_SIZE; offset += clflush_chunk)
6619a8fb594486 H. Peter Anvin  2007-10-17  223  			clflush((char *)page+offset);
^1da177e4c3f41 Linus Torvalds  2005-04-16  224  
^1da177e4c3f41 Linus Torvalds  2005-04-16  225  		efficeon_private.l1_table[index] = page;
^1da177e4c3f41 Linus Torvalds  2005-04-16  226  
6a12235c7d2d75 David Woodhouse 2009-07-29  227  		value = virt_to_phys((unsigned long *)page) | pati | present | index;
^1da177e4c3f41 Linus Torvalds  2005-04-16  228  
^1da177e4c3f41 Linus Torvalds  2005-04-16  229  		pci_write_config_dword(agp_bridge->dev,
^1da177e4c3f41 Linus Torvalds  2005-04-16  230  			EFFICEON_ATTPAGE, value);
^1da177e4c3f41 Linus Torvalds  2005-04-16  231  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  232  
^1da177e4c3f41 Linus Torvalds  2005-04-16  233  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  234  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  235  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

