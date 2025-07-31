Return-Path: <linux-kernel+bounces-752006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E541EB17040
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2045C1AA5342
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DE2C08AA;
	Thu, 31 Jul 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKDXkwHc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E972BF00B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960668; cv=none; b=aZ6pyMCC/URPCuFPyT9muGLa/6kWZerUgkqeUVEp22OeBM+NslqrlfVgtoDiz/s+wXTx2oAzwSLUxVkVPl/XbliEun2ds28JfdlsrqY4e3h8l6M428exlckPBlQUbI9SEd6LDFH8etBbdmdE1S36wiM1xgdOVPXPkTlNpGsfUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960668; c=relaxed/simple;
	bh=rp+0Ud6ehj2ssIqu0fmCm5PueYl31CGyOdfu1XfJBvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwInQXjiWbHyCW1Aq05e87TL0eSKN0jVRfXBWL2mvMcMaJv6qSMFfHMbQkS1FP/ZTeU17wIUhAcG7c5p4YTzq9pzI9Czg+rWAtLPVaPH0pm1wf1JDNYAV3V9oKAk3nNAeB+Lo1rvGjsQmQP5ecz6aPrmepsOSj7l2gRqH1BppkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKDXkwHc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753960666; x=1785496666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rp+0Ud6ehj2ssIqu0fmCm5PueYl31CGyOdfu1XfJBvU=;
  b=MKDXkwHcNHZcMCwqXgbKuKZ+w1sKIkpISSu0zubxpVv+jUyd7ipNl9SP
   WMB/5wtPUoqg0Vge7fMUlumPaSW5bqBk+Z8WL2FkGFcwNBfjQ/s0DgUC1
   9azGAQW0q0rvX8PXQ4TYFGcQf+TgzN1DP7jy8fZCDcTEjPSi/UbAtOhXq
   PFEAlGjsxk5FcVr6M94utSXEjoaQN9HhUM6pUjvU+RzUvaFcIal34MknJ
   Nu0CyPzbXEkO7suhxiDutEcB75xZHV/cpTQuf4S1S4eKG26rxogJuyrCV
   etHMbMtJwqpj2lT+DWznYF+J7K7knwA99LeUicx7f37M7dUrwno/3/ZgI
   w==;
X-CSE-ConnectionGUID: WZESzeCoRB+7Xhl0F3qMKA==
X-CSE-MsgGUID: yzkngJ6ATY6rmchdqo/UNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73870124"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="73870124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:17:45 -0700
X-CSE-ConnectionGUID: jjq065fqSki3wdC2rxWRMQ==
X-CSE-MsgGUID: JIqMra71RlKfKrcgWid8zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="162514846"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Jul 2025 04:17:39 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhRI0-0003iS-1j;
	Thu, 31 Jul 2025 11:17:36 +0000
Date: Thu, 31 Jul 2025 19:17:31 +0800
From: kernel test robot <lkp@intel.com>
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
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
Subject: Re: [v2 05/11] lib/test_hmm: test cases and support for zone device
 private THP
Message-ID: <202507311818.V6HUiudq-lkp@intel.com>
References: <20250730092139.3890844-6-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730092139.3890844-6-balbirs@nvidia.com>

Hi Balbir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20250731]
[cannot apply to akpm-mm/mm-nonmm-unstable shuah-kselftest/next shuah-kselftest/fixes linus/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balbir-Singh/mm-zone_device-support-large-zone-device-private-folios/20250730-172600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250730092139.3890844-6-balbirs%40nvidia.com
patch subject: [v2 05/11] lib/test_hmm: test cases and support for zone device private THP
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250731/202507311818.V6HUiudq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311818.V6HUiudq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311818.V6HUiudq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/test_hmm.c:1111:6: warning: variable 'dst_pfns' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1111 |         if (!src_pfns)
         |             ^~~~~~~~~
   lib/test_hmm.c:1176:8: note: uninitialized use occurs here
    1176 |         kfree(dst_pfns);
         |               ^~~~~~~~
   lib/test_hmm.c:1111:2: note: remove the 'if' if its condition is always false
    1111 |         if (!src_pfns)
         |         ^~~~~~~~~~~~~~
    1112 |                 goto free_mem;
         |                 ~~~~~~~~~~~~~
   lib/test_hmm.c:1097:25: note: initialize the variable 'dst_pfns' to silence this warning
    1097 |         unsigned long *dst_pfns;
         |                                ^
         |                                 = NULL
   1 warning generated.


vim +1111 lib/test_hmm.c

  1084	
  1085	static int dmirror_migrate_to_device(struct dmirror *dmirror,
  1086					struct hmm_dmirror_cmd *cmd)
  1087	{
  1088		unsigned long start, end, addr;
  1089		unsigned long size = cmd->npages << PAGE_SHIFT;
  1090		struct mm_struct *mm = dmirror->notifier.mm;
  1091		struct vm_area_struct *vma;
  1092		struct dmirror_bounce bounce;
  1093		struct migrate_vma args = { 0 };
  1094		unsigned long next;
  1095		int ret;
  1096		unsigned long *src_pfns;
  1097		unsigned long *dst_pfns;
  1098	
  1099		start = cmd->addr;
  1100		end = start + size;
  1101		if (end < start)
  1102			return -EINVAL;
  1103	
  1104		/* Since the mm is for the mirrored process, get a reference first. */
  1105		if (!mmget_not_zero(mm))
  1106			return -EINVAL;
  1107	
  1108		ret = -ENOMEM;
  1109		src_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*src_pfns),
  1110				  GFP_KERNEL | __GFP_NOFAIL);
> 1111		if (!src_pfns)
  1112			goto free_mem;
  1113	
  1114		dst_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*dst_pfns),
  1115				  GFP_KERNEL | __GFP_NOFAIL);
  1116		if (!dst_pfns)
  1117			goto free_mem;
  1118	
  1119		ret = 0;
  1120		mmap_read_lock(mm);
  1121		for (addr = start; addr < end; addr = next) {
  1122			vma = vma_lookup(mm, addr);
  1123			if (!vma || !(vma->vm_flags & VM_READ)) {
  1124				ret = -EINVAL;
  1125				goto out;
  1126			}
  1127			next = min(end, addr + (PTRS_PER_PTE << PAGE_SHIFT));
  1128			if (next > vma->vm_end)
  1129				next = vma->vm_end;
  1130	
  1131			args.vma = vma;
  1132			args.src = src_pfns;
  1133			args.dst = dst_pfns;
  1134			args.start = addr;
  1135			args.end = next;
  1136			args.pgmap_owner = dmirror->mdevice;
  1137			args.flags = MIGRATE_VMA_SELECT_SYSTEM |
  1138					MIGRATE_VMA_SELECT_COMPOUND;
  1139			ret = migrate_vma_setup(&args);
  1140			if (ret)
  1141				goto out;
  1142	
  1143			pr_debug("Migrating from sys mem to device mem\n");
  1144			dmirror_migrate_alloc_and_copy(&args, dmirror);
  1145			migrate_vma_pages(&args);
  1146			dmirror_migrate_finalize_and_map(&args, dmirror);
  1147			migrate_vma_finalize(&args);
  1148		}
  1149		mmap_read_unlock(mm);
  1150		mmput(mm);
  1151	
  1152		/*
  1153		 * Return the migrated data for verification.
  1154		 * Only for pages in device zone
  1155		 */
  1156		ret = dmirror_bounce_init(&bounce, start, size);
  1157		if (ret)
  1158			goto free_mem;
  1159		mutex_lock(&dmirror->mutex);
  1160		ret = dmirror_do_read(dmirror, start, end, &bounce);
  1161		mutex_unlock(&dmirror->mutex);
  1162		if (ret == 0) {
  1163			if (copy_to_user(u64_to_user_ptr(cmd->ptr), bounce.ptr,
  1164					 bounce.size))
  1165				ret = -EFAULT;
  1166		}
  1167		cmd->cpages = bounce.cpages;
  1168		dmirror_bounce_fini(&bounce);
  1169		goto free_mem;
  1170	
  1171	out:
  1172		mmap_read_unlock(mm);
  1173		mmput(mm);
  1174	free_mem:
  1175		kfree(src_pfns);
  1176		kfree(dst_pfns);
  1177		return ret;
  1178	}
  1179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

