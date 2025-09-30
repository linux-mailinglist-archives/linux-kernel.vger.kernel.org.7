Return-Path: <linux-kernel+bounces-837543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52150BAC886
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FA19419FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CB2F9DB2;
	Tue, 30 Sep 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOhG212l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B24298CAB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228623; cv=none; b=p+VKmEpRfjWP6Mi/EPQM7aK5HbFY0+lOIqm/NLQG8EmyhQHLJ0peU2XZCI7rqSH83bV62aIpo9fi25sTS8mnwun9j6Yv9nx7aVR+LXPxKGpRB69eBKeNAm3Dj7HbmxnFxvxSGMr60tEMrmTC2RAG5Ktad9MnvWMOFP5qHK6h3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228623; c=relaxed/simple;
	bh=sbz5AL1wVvoPI4VgrY33BmNwLhxdJAx+xAgmOKchchs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBZAGH5Ziqbd/kSi7jHVRTK2OvCDz6GHDcnSy4eRa6oqcO0LVlVAhHqEth/DbrLuwWQQGL1RH0xEo4K9H3R96WYQ+eM7ZMIGoJqCvFClJehUVmmDySzDmrZzzM7bb2foF6ONrioM8z3ZfiM41Gq/s7AC7CekLaVw/TRnAqNOQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOhG212l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759228621; x=1790764621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sbz5AL1wVvoPI4VgrY33BmNwLhxdJAx+xAgmOKchchs=;
  b=gOhG212lYe7nM4+126PMGBLhNV2b8krkSQwam1YrdfMFLqQvRVYAdqbO
   nw5UvIkn0YKJKI0mQxU4Vns7Lu30uUpnoxh8z6bDlVqrfF1whMmJq2F/3
   4ZEfekh/DNW3tjMOpCyKqBUw/z6lp+5hIrl4lQ3bzGc7JtLDx97RFjuGB
   5advPSwlgVPGaoSYLsJq6yaj1kUg/nlPjtnuGoUuPHu7eVr/8qe9cLYiN
   Ml/aoFqVAYjuTZGKgGVw7jYzBU1tEXnEUOr6l6pI8oegiXF0qLMC9ejZw
   BeQHmCfw2Vnn5ZeI1wIengDGZ3jxo40XG+9L+xzUnjmjOkBvQT1CS6Iku
   g==;
X-CSE-ConnectionGUID: nUnHR9lyTGuMCmgzU91odw==
X-CSE-MsgGUID: kNRSYRwPR16qPkl5h4e4vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61589880"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61589880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 03:37:00 -0700
X-CSE-ConnectionGUID: 1JEwtSrhQpaqBfQvrOYe3A==
X-CSE-MsgGUID: ORJaRpGvQfCsMc7rucxYXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178283490"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Sep 2025 03:36:52 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3Xj0-0001Ax-0s;
	Tue, 30 Sep 2025 10:36:50 +0000
Date: Tue, 30 Sep 2025 18:36:07 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Lo=EFc?= Molinari <loic.molinari@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH 6/8] drm/panthor: Introduce huge tmpfs mount point option
Message-ID: <202509301834.aoEcLO0C-lkp@intel.com>
References: <20250929200316.18417-7-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929200316.18417-7-loic.molinari@collabora.com>

Hi Loïc,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[cannot apply to akpm-mm/mm-everything linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-shmem-helper-Add-huge-page-fault-handler/20250930-040600
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250929200316.18417-7-loic.molinari%40collabora.com
patch subject: [PATCH 6/8] drm/panthor: Introduce huge tmpfs mount point option
config: i386-buildonly-randconfig-004-20250930 (https://download.01.org/0day-ci/archive/20250930/202509301834.aoEcLO0C-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509301834.aoEcLO0C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509301834.aoEcLO0C-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panthor/panthor_gem.c: In function 'panthor_gem_init':
>> drivers/gpu/drm/panthor/panthor_gem.c:24:14: error: 'panthor_transparent_hugepage' undeclared (first use in this function); did you mean 'has_transparent_hugepage'?
      24 |         if (!panthor_transparent_hugepage)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              has_transparent_hugepage
   drivers/gpu/drm/panthor/panthor_gem.c:24:14: note: each undeclared identifier is reported only once for each function it appears in


vim +24 drivers/gpu/drm/panthor/panthor_gem.c

    19	
    20	void panthor_gem_init(struct panthor_device *ptdev)
    21	{
    22		struct vfsmount *huge_mnt;
    23	
  > 24		if (!panthor_transparent_hugepage)
    25			return;
    26	
    27		huge_mnt = drm_gem_shmem_huge_mnt_create("within_size");
    28		if (IS_ERR(huge_mnt)) {
    29			drm_warn(&ptdev->base, "Can't use Transparent Hugepage (%ld)\n",
    30				 PTR_ERR(huge_mnt));
    31			return;
    32		}
    33	
    34		ptdev->huge_mnt = huge_mnt;
    35	
    36		drm_info(&ptdev->base, "Using Transparent Hugepage\n");
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

