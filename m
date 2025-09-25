Return-Path: <linux-kernel+bounces-832534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15904B9F9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A704E8384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B326CE0F;
	Thu, 25 Sep 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Etj80bXy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA083267B07
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807439; cv=none; b=QQL3Q/5qp2GNFC1Ynzc6t/E1Aba2/0gXQVPK3Hct4cBwamNq4Osf72KqVuUVGkBCAcD2e8/Ypu5O7hEhQqmzCrZhVZOnAZusXjLAOynm+l8/cOOtQHZlneIg3AULMj0OJFJoaJpZLuec0Bjp+I4nAZo3sws8sANKNx4gYE7Q/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807439; c=relaxed/simple;
	bh=LTr4oshAkMcVoBpx4J040ZcczOQeM7IvBewq8YixS1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3/9e+sgUuD7khR8pq9LRb+nR/DEKd3GSKDe4HJFJcZXCSR7fWbNkJkYClLa+qEmiMQbxW0hM9gBUNdYatooPh7WkGj9BR97pa5mGj1B9SHNXmp4ieTWWk1N8M26GSMnErOg+I5XzLtnSriKX0nMq81MIFywNfhc2DGqq94xbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Etj80bXy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758807438; x=1790343438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LTr4oshAkMcVoBpx4J040ZcczOQeM7IvBewq8YixS1g=;
  b=Etj80bXyLLl4pV3RTGZaBtgKnocR6C777CYkpL6pq9KDDGdFr3p5AGGa
   nelRG9IF8T0iM84+h0xQTdQs96+p7JB/kYEvkH6MsK5UW3jutELTFzEXK
   ZkrAZ3qKHzbsZGJb4TrCUctVj4qBSdfqs0t36Gtu6J8gee+uJg8Huf5lU
   aZimO8lROENRI8Mmbt5O2dwMeYSRZTGz9wYWBFgptMGeJaoZ/9M2U5fTp
   zyqz4U4D4f0cqQLcD3kxPT7dNuDMyEPOJWunIj9sm4g7jw4sltIhbr8HN
   82gYJ3nuqisi77HTlSOzPvBH4Gj8XlNSJiNoQeHY8EuPBMld6WvfafgZ4
   g==;
X-CSE-ConnectionGUID: TPhk/FyYQemWDHbXWNW5eA==
X-CSE-MsgGUID: Q9rxzE9RSzyiGpCY/X1GqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="63755046"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="63755046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:37:17 -0700
X-CSE-ConnectionGUID: CAKflSAnTA2IHm58h9lsPQ==
X-CSE-MsgGUID: mNkaVc6/T1Cn7dX6zZBZFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="176467467"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 25 Sep 2025 06:37:11 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1m9k-0005GH-01;
	Thu, 25 Sep 2025 13:37:08 +0000
Date: Thu, 25 Sep 2025 21:36:46 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
Message-ID: <202509252153.JhjsdZ6c-lkp@intel.com>
References: <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com>

Hi Brendan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bf2602a3cb2381fb1a04bf1c39a290518d2538d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/x86-mm-asi-Add-CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION/20250924-230633
base:   bf2602a3cb2381fb1a04bf1c39a290518d2538d1
patch link:    https://lore.kernel.org/r/20250924-b4-asi-page-alloc-v1-5-2d861768041f%40google.com
patch subject: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
config: x86_64-buildonly-randconfig-002-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252153.JhjsdZ6c-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252153.JhjsdZ6c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252153.JhjsdZ6c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c: In function 'mirror_asi_direct_map':
>> arch/x86/mm/pat/set_memory.c:1995:25: warning: variable 'asi_cpa' set but not used [-Wunused-but-set-variable]
    1995 |         struct cpa_data asi_cpa = *cpa;
         |                         ^~~~~~~


vim +/asi_cpa +1995 arch/x86/mm/pat/set_memory.c

  1988	
  1989	/*
  1990	 * Having updated the unrestricted PGD, reflect this change in the ASI
  1991	 * restricted address space too.
  1992	 */
  1993	static inline int mirror_asi_direct_map(struct cpa_data *cpa, int primary)
  1994	{
> 1995		struct cpa_data asi_cpa = *cpa;
  1996	
  1997		if (!asi_enabled_static())
  1998			return 0;
  1999	
  2000		/* Only need to do this for the real unrestricted direct map. */
  2001		if ((cpa->pgd && cpa->pgd != init_mm.pgd) || !is_direct_map(*cpa->vaddr))
  2002			return 0;
  2003		VM_WARN_ON_ONCE(!is_direct_map(*cpa->vaddr + (cpa->numpages * PAGE_SIZE)));
  2004	
  2005		asi_cpa.pgd = asi_nonsensitive_pgd;
  2006		asi_cpa.curpage = 0;
  2007		return __change_page_attr(cpa, primary);
  2008	}
  2009	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

