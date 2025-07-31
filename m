Return-Path: <linux-kernel+bounces-751909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA1B16F25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80591C20084
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1B2BD019;
	Thu, 31 Jul 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSNLBaVv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6F224B1E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956277; cv=none; b=NvaHe6B6iqlcJF0Jm3Kl7nLB+NxbX1hL1OnsLXUdOIIiBrU/kA5pkGMZGN6PEGR/fU/6xzKI8hs7SQ1I+F6J6dO6KutLq9972EWYxTx9BtegKigUiP/lVpUQph6qZYVX5CPSh6SldKjU/tIzPk63bcnqUmLBWzoREv35dsYALeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956277; c=relaxed/simple;
	bh=6+ao0BB2eP9Lbd+emGj1G640tLXJbZdN7LjBCYC17sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrhCKvvhXKX9WJ5Z6V5wny10RODMh1VgpGft6z6tep5Yhl2X9OAmMJBip99iCCDZsLJTs/bLWlA5bPSTiDXAk4x7iDasCzogmWqK3+0smsIP47o44oVBXl2+W9XMfaZ1+8bTtF9hFE4qNhRi8O8xTy66f3ofQ5GlCxFFfDV5ZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSNLBaVv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753956276; x=1785492276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+ao0BB2eP9Lbd+emGj1G640tLXJbZdN7LjBCYC17sI=;
  b=ZSNLBaVvmzsmmPg3xa5V4zxmTIoT6epzT+Ns8Ntsgc/YQHOYcvoylXm6
   yp4rz9GDeNTMi+T+ojow98448KkYDVKNMe12qQvz0MvI+kF4i2+z+2GEb
   VPAB7VRPK/PU4LKx1wVN47D09yi3YDRK2O+xt6XwgcqCV6SJa7qkF34bN
   LutcQRex5+R8ulYDIaMS0v/d+b/S6xxdp7EOWfNWRKCsVm1hURbacm7AR
   iDGlgt1H3H8GXHJdqKLFKOc8XueridV1IcBPVTLJJDj0CBrCKSAp08DDj
   3lycIPUuC/DqwMZEg3dxgmZeYCtex3uXiZkElTZVr8dVAYrZa9FxatTJz
   A==;
X-CSE-ConnectionGUID: zz5OylNUSaGpefuopnjmzg==
X-CSE-MsgGUID: hL0kw/KFQE263lZP+dILuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60098345"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="60098345"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 03:04:35 -0700
X-CSE-ConnectionGUID: /YULmVUrS1OPxbNT2GS1mg==
X-CSE-MsgGUID: b+5Hrj5WR82NXclqcajgyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167398722"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2025 03:04:29 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhQ9D-0003ds-23;
	Thu, 31 Jul 2025 10:04:27 +0000
Date: Thu, 31 Jul 2025 18:04:07 +0800
From: kernel test robot <lkp@intel.com>
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v2 07/11] mm/thp: add split during migration support
Message-ID: <202507311724.mavZerV1-lkp@intel.com>
References: <20250730092139.3890844-8-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730092139.3890844-8-balbirs@nvidia.com>

Hi Balbir,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20250731]
[cannot apply to akpm-mm/mm-nonmm-unstable shuah-kselftest/next shuah-kselftest/fixes linus/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balbir-Singh/mm-zone_device-support-large-zone-device-private-folios/20250730-172600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250730092139.3890844-8-balbirs%40nvidia.com
patch subject: [v2 07/11] mm/thp: add split during migration support
config: x86_64-randconfig-071-20250731 (https://download.01.org/0day-ci/archive/20250731/202507311724.mavZerV1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311724.mavZerV1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311724.mavZerV1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/migrate_device.c:1082:5: error: statement requires expression of scalar type ('void' invalid)
    1082 |                                 if (migrate_vma_split_pages(migrate, i, addr,
         |                                 ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1083 |                                                                 folio)) {
         |                                                                 ~~~~~~
   1 error generated.


vim +1082 mm/migrate_device.c

   999	
  1000	static void __migrate_device_pages(unsigned long *src_pfns,
  1001					unsigned long *dst_pfns, unsigned long npages,
  1002					struct migrate_vma *migrate)
  1003	{
  1004		struct mmu_notifier_range range;
  1005		unsigned long i, j;
  1006		bool notified = false;
  1007		unsigned long addr;
  1008	
  1009		for (i = 0; i < npages; ) {
  1010			struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
  1011			struct page *page = migrate_pfn_to_page(src_pfns[i]);
  1012			struct address_space *mapping;
  1013			struct folio *newfolio, *folio;
  1014			int r, extra_cnt = 0;
  1015			unsigned long nr = 1;
  1016	
  1017			if (!newpage) {
  1018				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
  1019				goto next;
  1020			}
  1021	
  1022			if (!page) {
  1023				unsigned long addr;
  1024	
  1025				if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE))
  1026					goto next;
  1027	
  1028				/*
  1029				 * The only time there is no vma is when called from
  1030				 * migrate_device_coherent_folio(). However this isn't
  1031				 * called if the page could not be unmapped.
  1032				 */
  1033				VM_BUG_ON(!migrate);
  1034				addr = migrate->start + i*PAGE_SIZE;
  1035				if (!notified) {
  1036					notified = true;
  1037	
  1038					mmu_notifier_range_init_owner(&range,
  1039						MMU_NOTIFY_MIGRATE, 0,
  1040						migrate->vma->vm_mm, addr, migrate->end,
  1041						migrate->pgmap_owner);
  1042					mmu_notifier_invalidate_range_start(&range);
  1043				}
  1044	
  1045				if ((src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
  1046					(!(dst_pfns[i] & MIGRATE_PFN_COMPOUND))) {
  1047					nr = HPAGE_PMD_NR;
  1048					src_pfns[i] &= ~MIGRATE_PFN_COMPOUND;
  1049				} else {
  1050					nr = 1;
  1051				}
  1052	
  1053				for (j = 0; j < nr && i + j < npages; j++) {
  1054					src_pfns[i+j] |= MIGRATE_PFN_MIGRATE;
  1055					migrate_vma_insert_page(migrate,
  1056						addr + j * PAGE_SIZE,
  1057						&dst_pfns[i+j], &src_pfns[i+j]);
  1058				}
  1059				goto next;
  1060			}
  1061	
  1062			newfolio = page_folio(newpage);
  1063			folio = page_folio(page);
  1064			mapping = folio_mapping(folio);
  1065	
  1066			/*
  1067			 * If THP migration is enabled, check if both src and dst
  1068			 * can migrate large pages
  1069			 */
  1070			if (thp_migration_supported()) {
  1071				if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
  1072					(src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
  1073					!(dst_pfns[i] & MIGRATE_PFN_COMPOUND)) {
  1074	
  1075					if (!migrate) {
  1076						src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
  1077								 MIGRATE_PFN_COMPOUND);
  1078						goto next;
  1079					}
  1080					nr = 1 << folio_order(folio);
  1081					addr = migrate->start + i * PAGE_SIZE;
> 1082					if (migrate_vma_split_pages(migrate, i, addr,
  1083									folio)) {
  1084						src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
  1085								 MIGRATE_PFN_COMPOUND);
  1086						goto next;
  1087					}
  1088				} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
  1089					(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
  1090					!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
  1091					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
  1092				}
  1093			}
  1094	
  1095	
  1096			if (folio_is_device_private(newfolio) ||
  1097			    folio_is_device_coherent(newfolio)) {
  1098				if (mapping) {
  1099					/*
  1100					 * For now only support anonymous memory migrating to
  1101					 * device private or coherent memory.
  1102					 *
  1103					 * Try to get rid of swap cache if possible.
  1104					 */
  1105					if (!folio_test_anon(folio) ||
  1106					    !folio_free_swap(folio)) {
  1107						src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
  1108						goto next;
  1109					}
  1110				}
  1111			} else if (folio_is_zone_device(newfolio)) {
  1112				/*
  1113				 * Other types of ZONE_DEVICE page are not supported.
  1114				 */
  1115				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
  1116				goto next;
  1117			}
  1118	
  1119			BUG_ON(folio_test_writeback(folio));
  1120	
  1121			if (migrate && migrate->fault_page == page)
  1122				extra_cnt++;
  1123			for (j = 0; j < nr && i + j < npages; j++) {
  1124				folio = page_folio(migrate_pfn_to_page(src_pfns[i+j]));
  1125				newfolio = page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
  1126	
  1127				r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
  1128				if (r != MIGRATEPAGE_SUCCESS)
  1129					src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
  1130				else
  1131					folio_migrate_flags(newfolio, folio);
  1132			}
  1133	next:
  1134			i += nr;
  1135		}
  1136	
  1137		if (notified)
  1138			mmu_notifier_invalidate_range_end(&range);
  1139	}
  1140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

