Return-Path: <linux-kernel+bounces-848963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D11DBCEEAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AEE422C77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEAE1A5B92;
	Sat, 11 Oct 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5ZwjEFg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101B1957FC;
	Sat, 11 Oct 2025 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760151490; cv=none; b=g2OVHIjd7sQHSiGiS1FuG8E1p3EydzdPLCM8uYfvoEptY2twe5Ah3u4VtvzvT0iUFoOAb797k5kVpR1QtDznoSqf/dvTIor8eqFP6ZXa9IbGGKI/jC5JyR1aKKIur0mDNM4TYJEFJpbYQKO001aEYFeZWnA9VpCNOSua+rSDGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760151490; c=relaxed/simple;
	bh=n3Cf2XbDxUMzoSgHrQU9R6SSN64Mq364sx/VyZ4IhmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCq0A0JsSTS5KchuuI8DlIemdBUj7LpKiRBDVEvbVgjrenfSzBudl3oyhkdS79mYN5JvxBJz6qHSyS65NgpVG1jKAHr6RPecHi3gPwvnHCMUMkktcvYiLwM1czPEtr7PEYgGbvpI5iRVIGFwlJ+8CEzymgrw/l9qdvWKmKrEvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5ZwjEFg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760151488; x=1791687488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3Cf2XbDxUMzoSgHrQU9R6SSN64Mq364sx/VyZ4IhmQ=;
  b=h5ZwjEFg4v885bhFR6KzxZj/fVVo0QmQYEBCj4x8S71fEJFdI1dASU06
   zFzIpOTjNqmpxQm2g7TidzOJQA5uPLo2+4KZ1U/KM1K46mUqCYHy+dcg9
   dSKHe+6GL98nfSb0Y9gtaTHEzfkvvYQFEPU0DUOQ7qMGRP8tz+FtLKEC4
   YLldkWSZB+rc7FKW4SRs3eNFXkNyaVibW6WLLRLMs74bDpzzsf5zClGAk
   V7WdzVE1OLrpd8K5vkh46HKyiE9X3FqRKQmVzoQWNGiU7b20OQLdmNH6T
   Ff3J681rZ8fHoYcaTotchlpOzB7DB4MD2P6nwgWss5XFkGYQO7R1Ai5EW
   g==;
X-CSE-ConnectionGUID: zXDQaE2eSvGtQCD1z3Mrvw==
X-CSE-MsgGUID: b/Nq6Qz7RLeo9IF5GwUxig==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62267674"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62267674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 19:58:07 -0700
X-CSE-ConnectionGUID: YrfVI3RNRcqF0tl0N/g1FA==
X-CSE-MsgGUID: kzR2Jx+RQBOJsvHCexOGmw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Oct 2025 19:58:01 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Pny-0003S7-2G;
	Sat, 11 Oct 2025 02:57:58 +0000
Date: Sat, 11 Oct 2025 10:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org,
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] mm/tests: add cleancache kunit test
Message-ID: <202510111059.aKceYLLH-lkp@intel.com>
References: <20251010011951.2136980-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010011951.2136980-6-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 70478cb9da6fc4e7b987219173ba1681d5f7dd3d]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-implement-cleancache/20251010-134501
base:   70478cb9da6fc4e7b987219173ba1681d5f7dd3d
patch link:    https://lore.kernel.org/r/20251010011951.2136980-6-surenb%40google.com
patch subject: [PATCH 5/8] mm/tests: add cleancache kunit test
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251011/202510111059.aKceYLLH-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111059.aKceYLLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111059.aKceYLLH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/tests/cleancache_kunit.c:358:6: warning: variable 'unused' set but not used [-Wunused-but-set-variable]
     358 |         int unused = 0;
         |             ^
   1 warning generated.


vim +/unused +358 mm/tests/cleancache_kunit.c

   353	
   354	static void cleancache_backend_api_test(struct kunit *test)
   355	{
   356		struct folio *folio;
   357		LIST_HEAD(folios);
 > 358		int unused = 0;
   359		int used = 0;
   360	
   361		/* Store inode folios into cleancache */
   362		fill_cleancache(test);
   363	
   364		/* Get all donated folios back */
   365		for (int fidx = 0; fidx < FOLIO_COUNT; fidx++) {
   366			KUNIT_EXPECT_EQ(test, cleancache_backend_get_folio(test_data.pool_id,
   367							test_data.pool_folios[fidx]),  0);
   368			set_page_refcounted(&test_data.pool_folios[fidx]->page);
   369		}
   370	
   371		/* Try putting a refcounted folio */
   372		KUNIT_EXPECT_NE(test, cleancache_backend_put_folio(test_data.pool_id,
   373						test_data.pool_folios[0]), 0);
   374	
   375		/* Put some of the folios back into cleancache */
   376		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
   377			folio_ref_freeze(test_data.pool_folios[fidx], 1);
   378			KUNIT_EXPECT_EQ(test, cleancache_backend_put_folio(test_data.pool_id,
   379							test_data.pool_folios[fidx]), 0);
   380		}
   381	
   382		/* Put the rest back into cleancache but keep half of folios still refcounted */
   383		for (int fidx = FOLIOS_PER_INODE; fidx < FOLIO_COUNT; fidx++) {
   384			if (fidx % 2) {
   385				folio_ref_freeze(test_data.pool_folios[fidx], 1);
   386				unused++;
   387			} else {
   388				used++;
   389			}
   390			list_add(&test_data.pool_folios[fidx]->lru, &folios);
   391		}
   392		KUNIT_EXPECT_NE(test, cleancache_backend_put_folios(test_data.pool_id,
   393						&folios), 0);
   394		/* Used folios should be still in the list */
   395		KUNIT_EXPECT_EQ(test, list_count_nodes(&folios), used);
   396	
   397		/* Release refcounts and put the remaining folios into cleancache */
   398		list_for_each_entry(folio, &folios, lru)
   399			folio_ref_freeze(folio, 1);
   400		KUNIT_EXPECT_EQ(test, cleancache_backend_put_folios(test_data.pool_id,
   401						&folios), 0);
   402		KUNIT_EXPECT_TRUE(test, list_empty(&folios));
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

