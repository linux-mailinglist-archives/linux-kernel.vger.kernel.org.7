Return-Path: <linux-kernel+bounces-837482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E8BAC684
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72447A3A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFC2F5482;
	Tue, 30 Sep 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOGVF1ml"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF8254848
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226751; cv=none; b=cnITr2FcIw4AHWndsfYMWdQX9rmsSm4T/qtUAEF75rUrw59nS9PKrr7ItdaqzArVteJoh/lvnK9l8j/wVIowefHhQ0SI9c/SHCDMgogkqHkcbcvwOCkdACjjPs9omDVLeR3146t3hZCo21DpAieFE6i55cwkEE5zuJwHGypoYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226751; c=relaxed/simple;
	bh=npvtgCQVERmCarOfKSvie70oeT0wMLmYdU95Di6tZxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHzCHs5B4Pzp9y9O7Kcs/IR0mrzxWLII8ABiYmj5DNcIcCxKtY9cYpYKPk46rk0NUp5ENTGAWhb7IoH88J8pQmFIhNfIiiBCYGMFMLhr737Taf1n1bkbRXieGPtelOkRE+wS5AFfFjdCO73mF00RnIBsyT7JIpk2/iLWjDRX/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOGVF1ml; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759226750; x=1790762750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=npvtgCQVERmCarOfKSvie70oeT0wMLmYdU95Di6tZxk=;
  b=gOGVF1mlA0+lFGOqGZxGDLEala+0OHUHvQ5YBJg9a0EZi/Rgm8FChSPz
   bdLuOhr4a6qM0APrAwtkg6vgw7OybUh/p+lIMYWXp+JrRW5ccl5A3S0Q9
   J1KOtyQTPFylcP/wlCrbUUhpZI6u5FTNPY7vG7ZRMqslUIOamdqPVzHLU
   FyGai2uuS7OkxB1vgoeO+3/HszP3OhARUZI6DPuB6Qog1jNzC59xX62E6
   30+6gf1VEOxQjvibzEs3kfM4KkwHPzXZ/Ozr4oxHqZ4zCH946MB1e2g+u
   LZK4oEwVtsuqsIv6VRt/RgTYv3FFjptXmCeNtCk4vNEfBs9Y2SUVdz9v/
   w==;
X-CSE-ConnectionGUID: 59tOVTRISu6r8R5oTk7j4w==
X-CSE-MsgGUID: GZn9e/4STK6+afu/3gKWaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72097641"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72097641"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 03:05:49 -0700
X-CSE-ConnectionGUID: PV+0NBfaTwSqEdenvWAgLQ==
X-CSE-MsgGUID: K51ZkYz/TQmtpVOD/uXFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178889093"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Sep 2025 03:05:43 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3XEq-00019L-1H;
	Tue, 30 Sep 2025 10:05:40 +0000
Date: Tue, 30 Sep 2025 18:05:36 +0800
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
Subject: Re: [PATCH 2/8] drm/gem: Introduce drm_gem_get_unmapped_area() fop
Message-ID: <202509301702.DL6CeU62-lkp@intel.com>
References: <20250929200316.18417-3-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929200316.18417-3-loic.molinari@collabora.com>

Hi Loïc,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.17 next-20250929]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-shmem-helper-Add-huge-page-fault-handler/20250930-040600
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250929200316.18417-3-loic.molinari%40collabora.com
patch subject: [PATCH 2/8] drm/gem: Introduce drm_gem_get_unmapped_area() fop
config: arm-randconfig-002-20250930 (https://download.01.org/0day-ci/archive/20250930/202509301702.DL6CeU62-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509301702.DL6CeU62-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509301702.DL6CeU62-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_gem.c: In function 'drm_gem_get_unmapped_area':
>> drivers/gpu/drm/drm_gem.c:1280:9: error: implicit declaration of function 'mm_get_unmapped_area'; did you mean 'shmem_get_unmapped_area'? [-Werror=implicit-function-declaration]
     return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0, flags);
            ^~~~~~~~~~~~~~~~~~~~
            shmem_get_unmapped_area
   cc1: some warnings being treated as errors


vim +1280 drivers/gpu/drm/drm_gem.c

  1238	
  1239	/**
  1240	 * drm_gem_get_unmapped_area - get memory mapping region routine for GEM objects
  1241	 * @filp: DRM file pointer
  1242	 * @uaddr: User address hint
  1243	 * @len: Mapping length
  1244	 * @pgoff: Offset (in pages)
  1245	 * @flags: Mapping flags
  1246	 *
  1247	 * If a driver supports GEM object mapping, before ending up in drm_gem_mmap(),
  1248	 * mmap calls on the DRM file descriptor will first try to find a free linear
  1249	 * address space large enough for a mapping. Since GEM objects are backed by
  1250	 * shmem buffers, this should preferably be handled by the shmem virtual memory
  1251	 * filesystem which can appropriately align addresses to huge page sizes when
  1252	 * needed.
  1253	 *
  1254	 * Look up the GEM object based on the offset passed in (vma->vm_pgoff will
  1255	 * contain the fake offset we created) and call shmem_get_unmapped_area() with
  1256	 * the right file pointer.
  1257	 *
  1258	 * If a GEM object is not available at the given offset or if the caller is not
  1259	 * granted access to it, fall back to mm_get_unmapped_area().
  1260	 */
  1261	unsigned long drm_gem_get_unmapped_area(struct file *filp, unsigned long uaddr,
  1262						unsigned long len, unsigned long pgoff,
  1263						unsigned long flags)
  1264	{
  1265	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1266		struct drm_gem_object *obj;
  1267		unsigned long ret;
  1268	
  1269		obj = drm_gem_object_lookup_from_offset(filp, pgoff, len >> PAGE_SHIFT);
  1270		if (IS_ERR(obj))
  1271			return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0,
  1272						    flags);
  1273	
  1274		ret = shmem_get_unmapped_area(obj->filp, uaddr, len, 0, flags);
  1275	
  1276		drm_gem_object_put(obj);
  1277	
  1278		return ret;
  1279	#else
> 1280		return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0, flags);
  1281	#endif
  1282	}
  1283	EXPORT_SYMBOL(drm_gem_get_unmapped_area);
  1284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

