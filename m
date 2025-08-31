Return-Path: <linux-kernel+bounces-793339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FDEB3D209
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E517D914
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386492253FD;
	Sun, 31 Aug 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFpKJ7Tn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737E42065
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635344; cv=none; b=YlGssw7e/FT9xp09C8wL53fLceoreuX2mBQckgZaqhAH9Oboru90H+ZzK/UmtrD6RSJ+A2ufK/95uq75wLHNwASNg/NCD6cCG1cPMqzYZAD03yeKWQZpYRATUyhQowHvSjiE4022JRl/4Br34JxiLP8NcxcA/bCPOEzrJ3lo5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635344; c=relaxed/simple;
	bh=p3WI4FCDeL4So+P3eBVdNKKy1LNMbXqDY5+OtJLZkQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bWw83cWWhhwjLpB8lmdVjg2ZwLIGcuvrtjs0btJ4WBLVtSow4IQtjq3rc6BcIEgfdlA5EXdx2kIZbxg4NV9KzhFvQB7se15PXqMA5IuPLIjaWhGkK7rGuW7YegDUfyKVMY+k5FP3eRj3kBWMczdWAy4t/rifet1ElfjIOWOLPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFpKJ7Tn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756635343; x=1788171343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p3WI4FCDeL4So+P3eBVdNKKy1LNMbXqDY5+OtJLZkQc=;
  b=mFpKJ7TnDzKwVODTcYTctosqrrg7UzUPWJw80fDvUeElTjYuxhTTwCBU
   LEn17pVEcvIU+r43T+leFbzDQu3X72uijWqfvxOhRmufV4I1qxy5ZDUQ0
   DZ5VvtAB8o/Y3uUe1opTckU7JgXDVCQ39+2KXibNQPAcunQ/Ddp0xGuC5
   VcD9eyAWbwxZnEySyWNiUWHlzgUKD0mPQjAVlPoSC8CzKLPRSdHRwrmr6
   9pa5AK939wYxgcbUcJAQYLuU53iSq34uDM63O/jTj64EqyjKVT8AkzNg+
   7kvRvh6kYhyLy0JsR60anqstKFQTBW/AUxONw+MK9ug846iXxV+dVi2Ms
   w==;
X-CSE-ConnectionGUID: AbCHhZXGScmLgiJVPcyTAA==
X-CSE-MsgGUID: EAti6D+GRV2CbVteyCUeOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="61492377"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="61492377"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 03:15:42 -0700
X-CSE-ConnectionGUID: Yd7pGHJCS8a9JmBAGnJB0g==
X-CSE-MsgGUID: FjUQrYhLTKmLfPBtkw2XBg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 Aug 2025 03:15:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usf5x-000W4h-1a;
	Sun, 31 Aug 2025 10:15:35 +0000
Date: Sun, 31 Aug 2025 18:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/mprotect.c:450:23: sparse: sparse: cast to non-scalar
Message-ID: <202508311724.Mp4RhDNi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8bc81a52d5a2ac2e4b257ae123677cf94112755
commit: cb0f01beb16669e91510fcdb2cea213931aee017 mm/mprotect: fix dax pud handlings
date:   12 months ago
config: arm64-randconfig-r121-20250831 (https://download.01.org/0day-ci/archive/20250831/202508311724.Mp4RhDNi-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project ac23f7465eedd0dd565ffb201f573e7a69695fa3)
reproduce: (https://download.01.org/0day-ci/archive/20250831/202508311724.Mp4RhDNi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508311724.Mp4RhDNi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/mprotect.c: note: in included file (through include/linux/pgtable.h, include/linux/mm.h, include/linux/pagewalk.h):
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   mm/mprotect.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:869:25: sparse: sparse: context imbalance in 'change_pte_range' - unexpected unlock
>> mm/mprotect.c:450:23: sparse: sparse: cast to non-scalar
>> mm/mprotect.c:450:23: sparse: sparse: cast from non-scalar
   mm/mprotect.c: note: in included file (through include/linux/mm.h, include/linux/pagewalk.h):
   include/linux/pgtable.h:324:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:324:16: sparse: sparse: cast from non-scalar
   mm/mprotect.c: note: in included file (through include/linux/pgtable.h, include/linux/mm.h, include/linux/pagewalk.h):
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   arch/arm64/include/asm/pgtable.h:315:16: sparse: sparse: cast from non-scalar

vim +450 mm/mprotect.c

   428	
   429	static inline long change_pud_range(struct mmu_gather *tlb,
   430			struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
   431			unsigned long end, pgprot_t newprot, unsigned long cp_flags)
   432	{
   433		struct mmu_notifier_range range;
   434		pud_t *pudp, pud;
   435		unsigned long next;
   436		long pages = 0, ret;
   437	
   438		range.start = 0;
   439	
   440		pudp = pud_offset(p4d, addr);
   441		do {
   442	again:
   443			next = pud_addr_end(addr, end);
   444			ret = change_prepare(vma, pudp, pmd, addr, cp_flags);
   445			if (ret) {
   446				pages = ret;
   447				break;
   448			}
   449	
 > 450			pud = READ_ONCE(*pudp);
   451			if (pud_none(pud))
   452				continue;
   453	
   454			if (!range.start) {
   455				mmu_notifier_range_init(&range,
   456							MMU_NOTIFY_PROTECTION_VMA, 0,
   457							vma->vm_mm, addr, end);
   458				mmu_notifier_invalidate_range_start(&range);
   459			}
   460	
   461			if (pud_leaf(pud)) {
   462				if ((next - addr != PUD_SIZE) ||
   463				    pgtable_split_needed(vma, cp_flags)) {
   464					__split_huge_pud(vma, pudp, addr);
   465					goto again;
   466				} else {
   467					ret = change_huge_pud(tlb, vma, pudp,
   468							      addr, newprot, cp_flags);
   469					if (ret == 0)
   470						goto again;
   471					/* huge pud was handled */
   472					if (ret == HPAGE_PUD_NR)
   473						pages += HPAGE_PUD_NR;
   474					continue;
   475				}
   476			}
   477	
   478			pages += change_pmd_range(tlb, vma, pudp, addr, next, newprot,
   479						  cp_flags);
   480		} while (pudp++, addr = next, addr != end);
   481	
   482		if (range.start)
   483			mmu_notifier_invalidate_range_end(&range);
   484	
   485		return pages;
   486	}
   487	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

