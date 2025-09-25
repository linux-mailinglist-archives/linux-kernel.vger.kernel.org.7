Return-Path: <linux-kernel+bounces-832535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774FB9F9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A267BE510
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1832727E6;
	Thu, 25 Sep 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDGUuAA0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E192609D9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807440; cv=none; b=QwDM+yDQ1fLrw5KP9Hnks9TNhbrIYH0H9Rs7BV5OUTvFlYEISxryYj8Zud1PkHfK9G+uoemJV6GfOZJhV46R5YST6nMYiX6s24tGhFU54Vl0MPLmQaO7hPwOpOzES3ESI0Hr9Gd0zx3ktg/ifwDwyd+BZHTMs5Q/eTTwcRUONZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807440; c=relaxed/simple;
	bh=1PwuzYRVc23Mq8CgsDZzvk5lpGEPYfH8eH4KmEqBYAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie+87/ijYYLIO84NxjBe+p57Zexgot1NXLu95mvv6WVbs0g40n/Aaqq7qfoFsCJQBaGw2XLN601CArHiHy6jJ5bgPeDN9iQwNMlXBZhq1oIDTey9QiLbxmfRxk9AX5xl0Fn5G2qUYva/e7JU9j7zP1h4KPWl84Gu9jLsPbWa8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDGUuAA0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758807438; x=1790343438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PwuzYRVc23Mq8CgsDZzvk5lpGEPYfH8eH4KmEqBYAc=;
  b=dDGUuAA0X6CPUcqT3st8lSMXjCSN5HH0BVhiHgh7zwUiLjxNyAqwJ4S+
   QIXytj8hj3FZ53fcWN1YHjsIduNbvmaPTExqDUEyJR20114Hf4qe23sIC
   CzqUg8UPJXrYJpueo1iHMoIgIpoDIZ8n5OFYyrdEE2llynUZ5WaBeWBru
   OCStKya1S9STW63Ivx0gQMf6o1fnl09eBOL+cmkxq7GOOh1sNWzVrYAUH
   SihrkdY7pKcB70YedMk2SHi/OM0fgqgZ5Mz53qq/YeG1P5dDV4npwff0s
   7EWDEsTJIME70inCAiOedsiS+BHeZnE948sEUPncpbXGraZkNd2mLLk7t
   w==;
X-CSE-ConnectionGUID: GHLeGmgvREmB2v87mnobtg==
X-CSE-MsgGUID: ZL51nkTrShmlyMJtOQEE3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64933493"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64933493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:37:17 -0700
X-CSE-ConnectionGUID: RqjohgBhTrK2Brz6zCpW4A==
X-CSE-MsgGUID: kePJyFd+RPis6CrCcuMkcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177393010"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 25 Sep 2025 06:37:10 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1m9k-0005GJ-05;
	Thu, 25 Sep 2025 13:37:08 +0000
Date: Thu, 25 Sep 2025 21:36:47 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org, bp@alien8.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH 13/21] mm/page_alloc_test: unit test pindex helpers
Message-ID: <202509252146.WmdVQlgy-lkp@intel.com>
References: <20250924-b4-asi-page-alloc-v1-13-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-13-2d861768041f@google.com>

Hi Brendan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bf2602a3cb2381fb1a04bf1c39a290518d2538d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/x86-mm-asi-Add-CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION/20250924-230633
base:   bf2602a3cb2381fb1a04bf1c39a290518d2538d1
patch link:    https://lore.kernel.org/r/20250924-b4-asi-page-alloc-v1-13-2d861768041f%40google.com
patch subject: [PATCH 13/21] mm/page_alloc_test: unit test pindex helpers
config: x86_64-buildonly-randconfig-006-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252146.WmdVQlgy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252146.WmdVQlgy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252146.WmdVQlgy-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_alloc_test.c: In function 'test_pindex_helpers':
>> mm/page_alloc_test.c:19:30: error: implicit declaration of function 'pcp_allowed_order' [-Wimplicit-function-declaration]
      19 |                         if (!pcp_allowed_order(order))
         |                              ^~~~~~~~~~~~~~~~~
>> mm/page_alloc_test.c:24:55: error: implicit declaration of function 'order_to_pindex' [-Wimplicit-function-declaration]
      24 |                                 unsigned int pindex = order_to_pindex(ft, order);
         |                                                       ^~~~~~~~~~~~~~~
>> mm/page_alloc_test.c:44:45: error: implicit declaration of function 'pindex_to_order'; did you mean 'next_order'? [-Wimplicit-function-declaration]
      44 |                                 got_order = pindex_to_order(pindex);
         |                                             ^~~~~~~~~~~~~~~
         |                                             next_order


vim +/pcp_allowed_order +19 mm/page_alloc_test.c

     8	
     9	/* This just checks for basic arithmetic errors. */
    10	static void test_pindex_helpers(struct kunit *test)
    11	{
    12		unsigned long bitmap[bitmap_size(NR_PCP_LISTS)];
    13	
    14		/* Bit means "pindex not yet used". */
    15		bitmap_fill(bitmap, NR_PCP_LISTS);
    16	
    17		for (unsigned int order = 0; order < NR_PAGE_ORDERS; order++) {
    18			for (unsigned int mt = 0; mt < MIGRATE_PCPTYPES; mt++)  {
  > 19				if (!pcp_allowed_order(order))
    20					continue;
    21	
    22				for (int sensitive = 0; sensitive < NR_SENSITIVITIES; sensitive++) {
    23					freetype_t ft = migrate_to_freetype(mt, sensitive);
  > 24					unsigned int pindex = order_to_pindex(ft, order);
    25					int got_order;
    26	
    27					KUNIT_ASSERT_LT_MSG(test, pindex, NR_PCP_LISTS,
    28						"invalid pindex %d (order %d mt %d sensitive %d)",
    29						pindex, order, mt, sensitive);
    30					KUNIT_EXPECT_TRUE_MSG(test, test_bit(pindex, bitmap),
    31						"pindex %d reused (order %d mt %d sensitive %d)",
    32						pindex, order, mt, sensitive);
    33	
    34					/*
    35					 * For THP, two migratetypes map to the
    36					 * same pindex, just manually exclude one
    37					 * of those cases.
    38					 */
    39					if (!(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
    40					      order == HPAGE_PMD_ORDER &&
    41					      mt == min(MIGRATE_UNMOVABLE, MIGRATE_RECLAIMABLE)))
    42						clear_bit(pindex, bitmap);
    43	
  > 44					got_order = pindex_to_order(pindex);
    45					KUNIT_EXPECT_EQ_MSG(test, order, got_order,
    46						"roundtrip failed, got %d want %d (pindex %d mt %d sensitive %d)",
    47						got_order, order, pindex, mt, sensitive);
    48	
    49				}
    50			}
    51		}
    52	
    53		KUNIT_EXPECT_TRUE_MSG(test, bitmap_empty(bitmap, NR_PCP_LISTS),
    54			"unused pindices: %*pbl", NR_PCP_LISTS, bitmap);
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

