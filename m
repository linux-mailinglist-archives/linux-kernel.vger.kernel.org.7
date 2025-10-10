Return-Path: <linux-kernel+bounces-848802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17469BCE99F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C492F3BC01A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71626057A;
	Fri, 10 Oct 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuv5sTZI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCB217705;
	Fri, 10 Oct 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131116; cv=none; b=tDINQ8nVJFBtuZL628UZQ3WXe8q6wpAnMlzwTcesHs0sXYkL/cy2iV3SAc9czg0agkjB2jYxaiCtWQVqAyFtkxI6qjXjHGRHHqxg3vMnRUFQrbd8fr7mtUAtNZUztxdC0YtEsQMk45CaDQGw7mR8r5fxLRZMvtGfsT7mOW3w5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131116; c=relaxed/simple;
	bh=GN7rcJAiHiN13Nol7hN0X++FKuoiO/51+O8PBd+pOZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4Jp0UcTnAuvmg0eXjUZ+grmojJKJkIo0h7ttfNIyUL2EoF9ZC0MH/F8m4MgrS5N69VezgJvjx/udAHEG4OF+DlGSaKlqD4axWJyjNw4fy0Q3dTg2YZGqRRthP5kBb2RZcCY8G4o3LoGFjsjXzSUQ+ROhNUMVlby1FgNHmi9JBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuv5sTZI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760131114; x=1791667114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GN7rcJAiHiN13Nol7hN0X++FKuoiO/51+O8PBd+pOZc=;
  b=nuv5sTZIGZvBGqX2+OpUZiH8iOb/XJzi2IEdDP+8KNFk0NzJydabMhPP
   F8iz2T9gCHAuxDpsRsNNkMvYHw1t3miONt4ehrVb1Z09hztdNMUyzhs7o
   7te4q2v6ZN7p1RAkcS3teRyopZ2sri4cP4OLJuhozXUADmtiFSHtsia1X
   llSyPXuKG9v6hX+eMMCFwl8AW6vyC9xQ2GxzgNAD833V/hrQjzXGmRLts
   F3kb+DEmeCjz96Qq7JF7XCjp+NVWZ2CQKbAhC03ailgKrqf6MFj4O4m8a
   ID3ykUJl1D6cHFhJoInl5vnHmismIUnCJjRmAH0oheXZmPQiEi71Trpb5
   A==;
X-CSE-ConnectionGUID: s4BwFRyQTRGXGkqaD6/gbQ==
X-CSE-MsgGUID: qNJCGa6cTW68P8eGk9tZUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62386916"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62386916"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:18:33 -0700
X-CSE-ConnectionGUID: JObruKedS+20xN/RXkZcDQ==
X-CSE-MsgGUID: UCTRP3WUQ8esTkwdSkvYUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180653183"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 14:18:26 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7KVM-0003B9-13;
	Fri, 10 Oct 2025 21:18:24 +0000
Date: Sat, 11 Oct 2025 05:17:56 +0800
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
Subject: Re: [PATCH 1/8] mm: implement cleancache
Message-ID: <202510110501.92Srmvgx-lkp@intel.com>
References: <20251010011951.2136980-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010011951.2136980-2-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build errors:

[auto build test ERROR on 70478cb9da6fc4e7b987219173ba1681d5f7dd3d]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-implement-cleancache/20251010-134501
base:   70478cb9da6fc4e7b987219173ba1681d5f7dd3d
patch link:    https://lore.kernel.org/r/20251010011951.2136980-2-surenb%40google.com
patch subject: [PATCH 1/8] mm: implement cleancache
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251011/202510110501.92Srmvgx-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110501.92Srmvgx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110501.92Srmvgx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/cleancache.c:119:13: error: casting from randomized structure pointer type 'struct address_space *' to 'struct cleancache_inode *'
     119 |         *ccinode = (struct cleancache_inode *)folio->mapping;
         |                    ^
   1 error generated.


vim +119 mm/cleancache.c

   113	
   114	static void folio_attachment(struct folio *folio, struct cleancache_inode **ccinode,
   115				     unsigned long *offset)
   116	{
   117		lockdep_assert_held(&(folio_pool(folio)->lock));
   118	
 > 119		*ccinode = (struct cleancache_inode *)folio->mapping;
   120		*offset = folio->index;
   121	}
   122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

