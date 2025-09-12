Return-Path: <linux-kernel+bounces-813198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC0B541DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E80C1C235FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315027280C;
	Fri, 12 Sep 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXRld1qB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7BA1C4A10
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757653757; cv=none; b=geiG0+CNoe5GYGtoA3nigPRkPq8h50TqYNoQGbw0V+vP+D3uXMjsRiOHJBrXl/CIw97VfZk9gfUUFzYsVnQ2AcmTK8DzPhENnwPItin9Wm0gLWFGbqnwSeepZ20hFUWLAd2vEgQNqkdmBZXAAeyEEQ71DXQe7eAYhJqYfwbk+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757653757; c=relaxed/simple;
	bh=5Sv52k5u28oEP7ozheRx2UKgazKeixsYXp9Xrw63D20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+XJGa81uN7Oo4zH/xDWeJBTP8dLm+MjdFw81lO+wyEsagWfTx7H4Jv4x/9A2pMGMjaLWgwYf9bHXQYJ/FqrUqwerxVlUxGf2QtTzW1TyQySqwy0L0D0u81A14+aJ62D1iGCXoOcnlAcjYpwqjsJYAyRMdwqGB6wTE5bWXSIcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXRld1qB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757653755; x=1789189755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Sv52k5u28oEP7ozheRx2UKgazKeixsYXp9Xrw63D20=;
  b=UXRld1qBEpbNqDVeFxvE9h0xxkAlMovroWsC8EVrgcIYLq5SFKA089LM
   9mFmysi1dmWfry+19h+WZCuoFPJqqUNA8nZpRNc7TQ4GrD8sGDC6LwzqW
   kn8Aa5rdyu+SU8M5wxZM6kdCPELzMfyI7YY19Lnvy5uh9Z3HBcL8qOlmJ
   F1BKBr9TQ1IIoJH+2DwbsBagKVq3K921Fpv8tF8tCyyszlzCmj+WZkBrR
   Np5Vkl8pc29dOohdbZ87WGyHXq6e5UbOHDRlTvVBLfm5EqqZvZonXKH4U
   qkts7rYV3gkml+I0tHUrDLHhDRyTznXZjOxbpi3x4ok2vcJzvPCzZ3RdP
   Q==;
X-CSE-ConnectionGUID: F063AmpaQyi3lec73LaGlQ==
X-CSE-MsgGUID: CVJWNDoCTBKdggp2K38ctw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59035019"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59035019"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:09:14 -0700
X-CSE-ConnectionGUID: Chkn6f1JSeqZFCMjjKycKA==
X-CSE-MsgGUID: UIGyh3Q8S1+iLeSJ6X/vNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173165172"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2025 22:09:09 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uww1y-0000rE-0r;
	Fri, 12 Sep 2025 05:09:06 +0000
Date: Fri, 12 Sep 2025 13:08:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 8/9] mm/vma: Use unmap_desc in vms_clear_ptes() and
 exit_mmap()
Message-ID: <202509121212.sx5Tfe4e-lkp@intel.com>
References: <20250909190945.1030905-9-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-9-Liam.Howlett@oracle.com>

Hi Liam,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[cannot apply to linus/master v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/mm-mmap-Move-exit_mmap-trace-point/20250910-031555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250909190945.1030905-9-Liam.Howlett%40oracle.com
patch subject: [PATCH v1 8/9] mm/vma: Use unmap_desc in vms_clear_ptes() and exit_mmap()
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20250912/202509121212.sx5Tfe4e-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509121212.sx5Tfe4e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509121212.sx5Tfe4e-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/filemap.c:53:
   In file included from mm/internal.h:23:
>> mm/vma.h:173:22: error: use of undeclared identifier 'USER_PGTABLES_CEILING'
     173 |         desc->last_pgaddr = USER_PGTABLES_CEILING;
         |                             ^~~~~~~~~~~~~~~~~~~~~
   In file included from mm/filemap.c:65:
   mm/swap.h:461:10: error: call to undeclared function 'swp_offset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     461 |                 return swp_offset(folio->swap);
         |                        ^
   2 errors generated.
--
   In file included from mm/oom_kill.c:50:
   In file included from mm/internal.h:23:
>> mm/vma.h:173:22: error: use of undeclared identifier 'USER_PGTABLES_CEILING'
     173 |         desc->last_pgaddr = USER_PGTABLES_CEILING;
         |                             ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/USER_PGTABLES_CEILING +173 mm/vma.h

   166	
   167	static inline void unmap_all_init(struct unmap_desc *desc,
   168			struct vma_iterator *vmi, struct vm_area_struct *vma)
   169	{
   170		desc->mas = &vmi->mas;
   171		desc->first = vma;
   172		desc->first_pgaddr = FIRST_USER_ADDRESS;
 > 173		desc->last_pgaddr = USER_PGTABLES_CEILING;
   174		desc->vma_min = 0;
   175		desc->vma_max = ULONG_MAX;
   176		desc->tree_max = ULONG_MAX;
   177		desc->tree_reset = vma->vm_end;
   178		desc->mm_wr_locked = false;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

