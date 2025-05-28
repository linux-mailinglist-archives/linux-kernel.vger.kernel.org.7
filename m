Return-Path: <linux-kernel+bounces-666128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3714AC72CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C13B08D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E986207E03;
	Wed, 28 May 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7TwRbPP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724D1F1527
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468039; cv=none; b=ZsEsiICaEz92UhFQpq2mWFndbye4OT4zgXSbIeHCwzqhbCyoWyrInOJUoXhrYv1GIThq7sLuFaqTkBpgfvcrG1PTDs8WIQAme2aBrSOF+OLJnxYtjKkK+Q5+KNqLNqs+wFo1a4BuGkJgIcjM/dFUiIguh/CfKogBDpxZVo+2vJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468039; c=relaxed/simple;
	bh=4x/CfwI3oZ4LOtKzLsZo44K26JZIvbERBXUZGkl6Ovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S08plsGKppFmOXCC3ZBxLQ7pwkwe6dwvzig5YqINYU2TA5kxx8KYwG7us9ba2IyPqtcfJ2liXC5uifxioUOTYNAJv1poo3AGn9WiEnQd/u7+IEpbmgoOrJQ2Sux5ae18bFixp6xPn9VMqwdOhHWqDo5H0LgHq8/Hi+UtVdvW9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7TwRbPP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748468037; x=1780004037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4x/CfwI3oZ4LOtKzLsZo44K26JZIvbERBXUZGkl6Ovk=;
  b=E7TwRbPPTmqwj7Ks2MkyGEVerglMoARX4o3pjderQ6mH77Wt5zdmrgnq
   lnw4DTbjcMXHV1BGzug+pMERLx4vcgYcFisihRtoAqYk12qKKs7UwUytp
   HPS+yXcp7jjmoNQRMxnEbEt7nMEKSfoAaQe1/Ox+dIh/HO8n9ePs+cV5Z
   ALW0jSZTFTF1oXvB6YH/vgUpuJZVJxMcoeENUd/1X72xEr9eEnju3xwCu
   5ModXbhBsonefay0vZ6/PiGkUJ4qEJlkIrM5Pu+fY+JpuQ47SDSXf8ghU
   gZ3LYYF051JolAudOy+VK46j+zK2UtJbcymq+GlbYeAcRIt9uMv913WAE
   g==;
X-CSE-ConnectionGUID: DOUOXHZdRruNTMBK7Q1qpQ==
X-CSE-MsgGUID: xDrgL3HiQCiXlU33vUk7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61147128"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="61147128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 14:33:56 -0700
X-CSE-ConnectionGUID: L8akFu5qRvm3z9WJkhoxNA==
X-CSE-MsgGUID: CiahDGc0TCGgtl9cMSvwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="147245154"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 May 2025 14:33:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKOPG-000W5A-2v;
	Wed, 28 May 2025 21:33:50 +0000
Date: Thu, 29 May 2025 05:33:18 +0800
From: kernel test robot <lkp@intel.com>
To: wangchuanguo <wangchuanguo@inspur.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, sj@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, david@redhat.com, mhocko@kernel.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, damon@lists.linux.dev,
	wangchuanguo <wangchuanguo@inspur.com>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Message-ID: <202505290538.2zlscryI-lkp@intel.com>
References: <20250528111038.18378-3-wangchuanguo@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528111038.18378-3-wangchuanguo@inspur.com>

Hi wangchuanguo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on sj/damon/next next-20250528]
[cannot apply to linus/master v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wangchuanguo/mm-migrate-restore-the-nmask-after-successfully-allocating-on-the-target-node/20250528-191141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250528111038.18378-3-wangchuanguo%40inspur.com
patch subject: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
config: arc-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505290538.2zlscryI-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290538.2zlscryI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290538.2zlscryI-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/damon/paddr.c: In function '__damon_pa_migrate_folio_list':
>> mm/damon/paddr.c:409:18: error: implicit declaration of function 'get_tier_nodemask'; did you mean 'set_user_sigmask'? [-Werror=implicit-function-declaration]
      allowed_mask = get_tier_nodemask(target_nid);
                     ^~~~~~~~~~~~~~~~~
                     set_user_sigmask
>> mm/damon/paddr.c:409:16: error: incompatible types when assigning to type 'nodemask_t' {aka 'struct <anonymous>'} from type 'int'
      allowed_mask = get_tier_nodemask(target_nid);
                   ^
   cc1: some warnings being treated as errors


vim +409 mm/damon/paddr.c

   383	
   384	static unsigned int __damon_pa_migrate_folio_list(
   385			struct list_head *migrate_folios, struct pglist_data *pgdat,
   386			int target_nid, bool use_nodes_of_tier)
   387	{
   388		unsigned int nr_succeeded = 0;
   389		nodemask_t allowed_mask = NODE_MASK_NONE;
   390		struct migration_target_control mtc = {
   391			/*
   392			 * Allocate from 'node', or fail quickly and quietly.
   393			 * When this happens, 'page' will likely just be discarded
   394			 * instead of migrated.
   395			 */
   396			.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
   397				__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
   398			.nid = target_nid,
   399			.nmask = &allowed_mask
   400		};
   401	
   402		if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
   403			return 0;
   404	
   405		if (list_empty(migrate_folios))
   406			return 0;
   407	
   408		if (use_nodes_of_tier)
 > 409			allowed_mask = get_tier_nodemask(target_nid);
   410	
   411		/* Migration ignores all cpuset and mempolicy settings */
   412		migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
   413			      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
   414			      &nr_succeeded);
   415	
   416		return nr_succeeded;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

