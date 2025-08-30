Return-Path: <linux-kernel+bounces-793038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A8B3CC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99BB1B251DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED772C324F;
	Sat, 30 Aug 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjQGjz4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8961E1DF2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569951; cv=none; b=MPmymc18DoFkz2tpk+tw8dytzzEOoKGeRFODa3UByf/inPMMpW3vey46R3JcJRxGGDjPqbzbZpkuDroSXmYBJhduS4+PIUnaxGLB6tme8SqdVublDzw7EFOqDc6mfyhhH7l4UaFCa8FSNA45yqKGAKN4AQPPamLcNZusNEsmlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569951; c=relaxed/simple;
	bh=nZInpuDDYcV/s2vcTKuZGi+aQmE/qU6SPFQgzHBBnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET+nMj7WB0sPoiWV+nCsXk37v5iFKPHR0xQIERZwRKHmjjcTM1kZKiNJ31y89EdBnwlrPBw0OfYcQ/gm0dDrAXOJZ/hjzNQL2UfoRlsgyi4orV+UWUwDlAhDUoFxO3Hp/tJkY+kLbrXhhouHpAkAlzUnIoJMskXtSCm9mGVuPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjQGjz4h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756569950; x=1788105950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nZInpuDDYcV/s2vcTKuZGi+aQmE/qU6SPFQgzHBBnfg=;
  b=EjQGjz4hNPc7S0iaOyXms/xmXCRIfRkq+VmmbWXpHqb5JWUZ/XkwjNDB
   ZaKojOJVh1fmtqofViJOyERIczY7nsTZyQzf6INk+maNGi1qM3EGDE4ZK
   OZ3rSmZuiajJ3u5p/sJhzxsYjmAXxwwVUCEeC+lpjYuRFu10xdkZsI49H
   TglOpZuPkjcdzgZ/I524K4ICEYR1+hyKbvZombgU3n2MTWEex16jUa8ZA
   ho1lyzKaM3ZeaCOz6lcV49snGg+6j1NM3K439MxDiPMnNci796Nipm+sj
   pq0OaZpTvMoNqltijZY535rtFOrOOwGAXZKMhE7vqPqWTU24JLGUb4DOA
   A==;
X-CSE-ConnectionGUID: sT5zTVPdSniVlBGJ9JFcoQ==
X-CSE-MsgGUID: ffAfu957TyKsKqhSBP+XXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58764856"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58764856"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 09:05:49 -0700
X-CSE-ConnectionGUID: gKpngiHdQkukULAx74a8uw==
X-CSE-MsgGUID: tT5xE8p/SCe6K8/5WYxT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171003721"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2025 09:05:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usO4r-000VUl-1r;
	Sat, 30 Aug 2025 16:05:28 +0000
Date: Sun, 31 Aug 2025 00:03:46 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	david@redhat.com, axelrasmussen@google.com, yuanchu@google.com,
	willy@infradead.org, hughd@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH 08/12] arch, mm/util: add const to
 arch_pick_mmap_layout() parameter
Message-ID: <202508302325.b9umktOw-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/mm-shmem-add-const-to-lots-of-pointer-parameters/20250830-023442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250829183159.2223948-9-max.kellermann%40ionos.com
patch subject: [PATCH 08/12] arch, mm/util: add const to arch_pick_mmap_layout() parameter
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20250830/202508302325.b9umktOw-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project ac23f7465eedd0dd565ffb201f573e7a69695fa3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508302325.b9umktOw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508302325.b9umktOw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/s390/mm/mmap.c:187:44: error: passing 'const struct rlimit *' to parameter of type 'struct rlimit *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     187 |                 mm->mmap_base = mmap_base(random_factor, rlim_stack);
         |                                                          ^~~~~~~~~~
   arch/s390/mm/mmap.c:50:26: note: passing argument to parameter 'rlim_stack' here
      50 |                                       struct rlimit *rlim_stack)
         |                                                      ^
   1 error generated.


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

