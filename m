Return-Path: <linux-kernel+bounces-835067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38DBA62D7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 21:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F2189B989
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CB2288D5;
	Sat, 27 Sep 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCrEnyQS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B94C9D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759001409; cv=none; b=XXZcmJDPRpNDj4uTmivMS+3PKFdUWtEZ04zGOG3iKbn9HO+hTuLkly7NvXWnDcJqZxWZnScGBfREYk9l7JVoimMO/xAFkNFjkn6uJTyomCeLkYZBxDyiw0ywbOx8vbUpP8punBsbdei9dt4uZNwPJOK2sQ51Ck2LGQqZncPEglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759001409; c=relaxed/simple;
	bh=ZmqKSfvKG8Sl31zQDeeEeXhIAVgZkEJsrGTFgAnGr9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIAZXXX0ZS4q5sodjl//9GrxDOWb9V2sWtDvALgVsqKSV9s9ywHs/j90n/kaLR5XBXcdm14pNKtF+rxwLRSVIlso+QvqXLrBoJoaHaThQcB9b7T9iFGu/8miUYj0pGkbctzLnxUNFC0taptQfK0j13x2f4kaYkZHcz9CTa6eGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCrEnyQS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759001408; x=1790537408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmqKSfvKG8Sl31zQDeeEeXhIAVgZkEJsrGTFgAnGr9Q=;
  b=NCrEnyQSjrOTEdIQiQYp6KpgAUOKuzPNtEB2UAeBRzSCMb13mlMMxuLk
   h21Vb4+YX7zlUXeIsZuk2L6POPvRLZ0l4LiQNB+abl0Y7TraVhoYv9SHa
   iS+MT/52Wss8mYw0vTkvwm/1q/hIDVHLo309ctIgaRgXAFKf4jtI4MCrt
   IN3UaXz396ewJ7gEIydGOzdXpQbqZk1ycOyahb8h0DRghIzbUCx0ZRKWD
   OLCM9F3CIA91KY3JZNzJ+jc/trYn+3jez0OGDcfFFAyOUaLqTjJvgDd35
   GEBD1Q29lP8IVaexz+a+p/uS89t6lzNfpH/Wum5/Xd9oNcFFeV6HL2R2I
   Q==;
X-CSE-ConnectionGUID: EMqk5TEaTvGvQXe2k5KKGQ==
X-CSE-MsgGUID: 8N9Y1SKLSmO8GO1uXqFcuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="48862108"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="48862108"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 12:30:07 -0700
X-CSE-ConnectionGUID: sGeoqd44RgymTRqe2XoVgg==
X-CSE-MsgGUID: R+Dp0UylSICLl5YeQhgHnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="182175568"
Received: from igk-lkp-server01.igk.intel.com (HELO 0e586ad5e7f7) ([10.91.175.65])
  by orviesa004.jf.intel.com with ESMTP; 27 Sep 2025 12:30:00 -0700
Received: from kbuild by 0e586ad5e7f7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1v2acH-000000005YD-3TdQ;
	Sat, 27 Sep 2025 19:29:57 +0000
Date: Sat, 27 Sep 2025 21:29:35 +0200
From: kernel test robot <lkp@intel.com>
To: Brendan Jackman <jackmanb@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bp@alien8.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
Message-ID: <202509272136.N4ELb64u-lkp@intel.com>
References: <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>

Hi Brendan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bf2602a3cb2381fb1a04bf1c39a290518d2538d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/x86-mm-asi-Add-CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION/20250924-230633
base:   bf2602a3cb2381fb1a04bf1c39a290518d2538d1
patch link:    https://lore.kernel.org/r/20250924-b4-asi-page-alloc-v1-3-2d861768041f%40google.com
patch subject: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250927/202509272136.N4ELb64u-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509272136.N4ELb64u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509272136.N4ELb64u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/mm/init_64.c:747:23: warning: variable 'vaddr_start' set but not used [-Wunused-but-set-variable]
     747 |         unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
         |                              ^
   1 warning generated.


vim +/vaddr_start +747 arch/x86/mm/init_64.c

7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  742  
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  743  static unsigned long __meminit
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  744  phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_end,
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  745  	      unsigned long page_size_mask, pgprot_t prot, bool init, bool *pgd_changed)
^1da177e4c3f41 arch/x86_64/mm/init.c Linus Torvalds      2005-04-16  746  {
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21 @747  	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
^1da177e4c3f41 arch/x86_64/mm/init.c Linus Torvalds      2005-04-16  748  
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  749  	*pgd_changed = false;
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  750  
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  751  	paddr_last = paddr_end;
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  752  	vaddr = (unsigned long)__va(paddr_start);
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  753  	vaddr_end = (unsigned long)__va(paddr_end);
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  754  	vaddr_start = vaddr;
^1da177e4c3f41 arch/x86_64/mm/init.c Linus Torvalds      2005-04-16  755  
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  756  	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  757  		pgd_t *pgd = pgd_offset_pgd(pgd_page, vaddr);
f2a6a7050109e0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-03-17  758  		p4d_t *p4d;
44df75e629106e arch/x86_64/mm/init.c Matt Tolentino      2006-01-17  759  
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  760  		vaddr_next = (vaddr & PGDIR_MASK) + PGDIR_SIZE;
4f9c11dd49fb73 arch/x86/mm/init_64.c Jeremy Fitzhardinge 2008-06-25  761  
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  762  		if (pgd_val(*pgd)) {
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  763  			p4d = (p4d_t *)pgd_page_vaddr(*pgd);
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  764  			paddr_last = phys_p4d_init(p4d, __pa(vaddr),
59b3d0206d74a7 arch/x86/mm/init_64.c Thomas Garnier      2016-06-21  765  						   __pa(vaddr_end),
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  766  						   page_size_mask,
c164fbb40c43f8 arch/x86/mm/init_64.c Logan Gunthorpe     2020-04-10  767  						   prot, init);
4f9c11dd49fb73 arch/x86/mm/init_64.c Jeremy Fitzhardinge 2008-06-25  768  			continue;
4f9c11dd49fb73 arch/x86/mm/init_64.c Jeremy Fitzhardinge 2008-06-25  769  		}
4f9c11dd49fb73 arch/x86/mm/init_64.c Jeremy Fitzhardinge 2008-06-25  770  
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  771  		p4d = alloc_low_page();
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  772  		paddr_last = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
c164fbb40c43f8 arch/x86/mm/init_64.c Logan Gunthorpe     2020-04-10  773  					   page_size_mask, prot, init);
8ae3a5a8dff2c9 arch/x86/mm/init_64.c Jan Beulich         2008-08-21  774  
8ae3a5a8dff2c9 arch/x86/mm/init_64.c Jan Beulich         2008-08-21  775  		spin_lock(&init_mm.page_table_lock);
ed7588d5dc6f5e arch/x86/mm/init_64.c Kirill A. Shutemov  2018-05-18  776  		if (pgtable_l5_enabled())
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  777  			pgd_populate_init(&init_mm, pgd, p4d, init);
7e82ea946ae4d0 arch/x86/mm/init_64.c Kirill A. Shutemov  2017-06-06  778  		else
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  779  			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  780  					  (pud_t *) p4d, init);
eccd906484d1cd arch/x86/mm/init_64.c Brijesh Singh       2019-04-17  781  
8ae3a5a8dff2c9 arch/x86/mm/init_64.c Jan Beulich         2008-08-21  782  		spin_unlock(&init_mm.page_table_lock);
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  783  		*pgd_changed = true;
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  784  	}
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  785  
46b7f8ebabd0a2 arch/x86/mm/init_64.c Brendan Jackman     2025-09-24  786  	return paddr_last;
^1da177e4c3f41 arch/x86_64/mm/init.c Linus Torvalds      2005-04-16  787  }
9b861528a8012e arch/x86/mm/init_64.c Haicheng Li         2010-08-20  788  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

