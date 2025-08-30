Return-Path: <linux-kernel+bounces-793091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9CB3CE27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593057AFE0D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D66D2D3738;
	Sat, 30 Aug 2025 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2oOEfCk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95F2D0630
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574884; cv=none; b=nqfcFvapvDjXRumFZLXV6DbamkZZfe5o++osoN3DV1AzZ5pUZsmAKpAMCVY2g8otUDYaOwfUvtdgmXGNpxfEINoqSjUogchTWZgeB8J9dG+W1Y1HeoEX4afnWpVISyXZXnmCxo00cBmcJcebegvU9TIkZLQP3PfCDWgYFzViBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574884; c=relaxed/simple;
	bh=WUfCPkzFUj71u7WVWssbAcnhvyk6h57lStw9l7AzM8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8hZGfQ47Q1VlY1cuWDe6sRcJws7BGa71BnrF9PM+KhZmrPk1/os7KJ89mPJflpBI9gCp+1btqfP/RcLKwPOVvu1gLPvmJ70R1ovuKE1bvqQHDks1m5rEav6LGs8qPn0Hvj4OIz/MD1DyqErrwcxnBlsS5vH4CsJA+ucaKf9xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2oOEfCk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756574882; x=1788110882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WUfCPkzFUj71u7WVWssbAcnhvyk6h57lStw9l7AzM8U=;
  b=V2oOEfCkphvZvZPnT7c4HGzj+uiDpSSoJHGK+rgcbgyKtIcUI669fhs5
   w+cHRe2gqpZ9gxl3Nm7og1m3VTdGP2Mdai2vFlozp3Zm3yh3KYCUM9i/n
   Gc/y/bnZsPNIZhBJGYIT0wa1g68xCF5ICT/rSLALkl/MyOam0jyVFfadW
   M4yrQJE3lTXshR6GLsL8nKxvia+0/4n1g7KdxTGNDtbjoruWmAJjnh9wL
   mAEhopdHE9na0n4vxorOyHN1lw3uAbNo6ZNRyM4a+CBBNYS9XsMNnLgmG
   SkLAAUij8b8Fr9VYGOdzOvahfkEhsKUyj71Fn78c5pNgBzfpxaVdp/CrD
   g==;
X-CSE-ConnectionGUID: 9P15GkNVRTKFHx9YzFo0bg==
X-CSE-MsgGUID: nxK5JjHJRuCNxQJHTMcwng==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="57857467"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="57857467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 10:28:02 -0700
X-CSE-ConnectionGUID: yIewHApFRHyJSdoRoYbYbg==
X-CSE-MsgGUID: dfuZ6CsuSSCvvWECCVmATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="169922695"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 30 Aug 2025 10:27:57 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usPLg-000VZf-17;
	Sat, 30 Aug 2025 17:27:24 +0000
Date: Sun, 31 Aug 2025 01:26:13 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	david@redhat.com, axelrasmussen@google.com, yuanchu@google.com,
	willy@infradead.org, hughd@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH 08/12] arch, mm/util: add const to
 arch_pick_mmap_layout() parameter
Message-ID: <202508310153.i186f6o5-lkp@intel.com>
References: <20250829183159.2223948-9-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-9-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/mm-shmem-add-const-to-lots-of-pointer-parameters/20250830-023442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250829183159.2223948-9-max.kellermann%40ionos.com
patch subject: [PATCH 08/12] arch, mm/util: add const to arch_pick_mmap_layout() parameter
config: s390-randconfig-002-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310153.i186f6o5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250831/202508310153.i186f6o5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508310153.i186f6o5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/mm/mmap.c: In function 'arch_pick_mmap_layout':
>> arch/s390/mm/mmap.c:187:44: warning: passing argument 2 of 'mmap_base' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      mm->mmap_base = mmap_base(random_factor, rlim_stack);
                                               ^~~~~~~~~~
   arch/s390/mm/mmap.c:50:26: note: expected 'struct rlimit *' but argument is of type 'const struct rlimit *'
              struct rlimit *rlim_stack)
              ~~~~~~~~~~~~~~~^~~~~~~~~~


vim +187 arch/s390/mm/mmap.c

9b11c7912d00d0 Martin Schwidefsky 2017-04-24  167  
6252d702c5311c Martin Schwidefsky 2008-02-09  168  /*
6252d702c5311c Martin Schwidefsky 2008-02-09  169   * This function, called very early during the creation of a new
6252d702c5311c Martin Schwidefsky 2008-02-09  170   * process VM image, sets up which VM layout function to use:
6252d702c5311c Martin Schwidefsky 2008-02-09  171   */
f547a726bf8dd8 Max Kellermann     2025-08-29  172  void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
6252d702c5311c Martin Schwidefsky 2008-02-09  173  {
8e89a356feb6f1 Kees Cook          2015-04-14  174  	unsigned long random_factor = 0UL;
8e89a356feb6f1 Kees Cook          2015-04-14  175  
8e89a356feb6f1 Kees Cook          2015-04-14  176  	if (current->flags & PF_RANDOMIZE)
2b68f6caeac271 Kees Cook          2015-04-14  177  		random_factor = arch_mmap_rnd();
8e89a356feb6f1 Kees Cook          2015-04-14  178  
6252d702c5311c Martin Schwidefsky 2008-02-09  179  	/*
6252d702c5311c Martin Schwidefsky 2008-02-09  180  	 * Fall back to the standard layout if the personality
6252d702c5311c Martin Schwidefsky 2008-02-09  181  	 * bit is set, or if the expected stack growth is unlimited:
6252d702c5311c Martin Schwidefsky 2008-02-09  182  	 */
8f2af155b51358 Kees Cook          2018-04-10  183  	if (mmap_is_legacy(rlim_stack)) {
8e89a356feb6f1 Kees Cook          2015-04-14  184  		mm->mmap_base = mmap_base_legacy(random_factor);
40ae96eabea408 Lorenzo Stoakes    2025-08-12  185  		mm_flags_clear(MMF_TOPDOWN, mm);
6252d702c5311c Martin Schwidefsky 2008-02-09  186  	} else {
8f2af155b51358 Kees Cook          2018-04-10 @187  		mm->mmap_base = mmap_base(random_factor, rlim_stack);
c52d638d6b5da2 Lorenzo Stoakes    2025-08-13  188  		mm_flags_set(MMF_TOPDOWN, mm);
6252d702c5311c Martin Schwidefsky 2008-02-09  189  	}
6252d702c5311c Martin Schwidefsky 2008-02-09  190  }
fd5d210fa66bee Anshuman Khandual  2022-07-11  191  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

