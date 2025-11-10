Return-Path: <linux-kernel+bounces-892790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A89C45D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E486C4EEFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76442FFF84;
	Mon, 10 Nov 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giRz8wQD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4B2FC866
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769193; cv=none; b=H1aBfc5Twn4qjc8NptgwotpMDl4qwqtFBuxmBEAOHrMxDAUEuwPOkVUHgG5U0w/G6dwEzIR6reH+8WcuqTf3jobQjglQLLgBteDak31qclPR3gfIPauNkJa0VfDuSyYMcQ+r+hxf+/4SgR5+AEQQbcfbuhZMnrByQYeXNqxGnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769193; c=relaxed/simple;
	bh=njMvkb3GKogZWduhp71RZ/0zgC5Z05aRgumYU/Ofx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPjm2kI90yzTgjGx5gLPX3UQmpYiE+wd0mEdtBTR1yffqWzFuBLMuLkGUK7pMIxhCp/P6gpF4Q+fGhxGkx/lX6S9roNQoP/Mtsj30Qjuw1YqSKCabOKLvr5PgNq2e01GcMJBpkw8/UCPzhaK1Bt6qvHg8WuteGUpLPqjxTjSLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giRz8wQD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762769191; x=1794305191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njMvkb3GKogZWduhp71RZ/0zgC5Z05aRgumYU/Ofx3k=;
  b=giRz8wQDVQoUYMDCrehXgXrZpLGwTg8rRwOx4+5s4E8EMKHqyRK9L3+U
   IR4z70zPF5sNMUQ133bZg6BPjWC2NJj25WIxD3a4pCRCfe7SukAEPN651
   ahNVvTOf1I6HJP9F/2trp/TZ9lYivopw4lH7YM63f9Wo0EH+kp+3tfzHH
   ee18mLtpFvamhgyC00C2t59AWLshQD0zczYee47bV9PMy840lk6jBGk9z
   n92NZ9/WId0RTVcdKQKudigj5UwU6QMBloTtb6g/+i7NkD7X0zgJnwYn8
   IVWnPlV+CQB0ZbrJviUbVsS8YKTINpMdUVXgaEww92EWjJaU9uhTYkL+t
   A==;
X-CSE-ConnectionGUID: ZUnq8wIVRN+Zd9LGVQVHuw==
X-CSE-MsgGUID: rUjmkg7eS5mSzZMZ3cwYeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="76164162"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="76164162"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:06:30 -0800
X-CSE-ConnectionGUID: NKU8XwPTQqCuTvGu0yP1NQ==
X-CSE-MsgGUID: GSJ8l7dqQwCwM32MrKNugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="212032316"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2025 02:06:26 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIOn2-0000HD-1v;
	Mon, 10 Nov 2025 10:06:24 +0000
Date: Mon, 10 Nov 2025 18:06:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	James Jones <jajones@nvidia.com>
Subject: Re: [PATCH v5 2/5] drm/nouveau/uvmm: Allow larger pages
Message-ID: <202511101750.gQGInWw5-lkp@intel.com>
References: <20251108194919.68754-3-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108194919.68754-3-mohamedahmedegypt2001@gmail.com>

Hi Mohamed,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.18-rc5 next-20251110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohamed-Ahmed/drm-nouveau-uvmm-Prepare-for-larger-pages/20251109-035142
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251108194919.68754-3-mohamedahmedegypt2001%40gmail.com
patch subject: [PATCH v5 2/5] drm/nouveau/uvmm: Allow larger pages
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20251110/202511101750.gQGInWw5-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101750.gQGInWw5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101750.gQGInWw5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:8,
                    from drivers/gpu/drm/nouveau/include/nvif/object.h:4,
                    from drivers/gpu/drm/nouveau/include/nvif/client.h:5,
                    from drivers/gpu/drm/nouveau/nouveau_drv.h:42,
                    from drivers/gpu/drm/nouveau/nouveau_uvmm.c:23:
   drivers/gpu/drm/nouveau/nouveau_uvmm.c: In function 'select_page_shift':
>> drivers/gpu/drm/nouveau/nouveau_uvmm.c:508:34: error: passing argument 1 of '_dev_warn' from incompatible pointer type [-Wincompatible-pointer-types]
     508 |         dev_warn_once(op->gem.obj->dev, "Could not find an appropriate page size.\n");
         |                       ~~~~~~~~~~~^~~~~
         |                                  |
         |                                  struct drm_device *
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:181:17: note: in expansion of macro 'dev_warn'
     181 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                 ^~~~~~~~~
   include/linux/dev_printk.h:201:9: note: in expansion of macro 'dev_level_once'
     201 |         dev_level_once(dev_warn, dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:508:9: note: in expansion of macro 'dev_warn_once'
     508 |         dev_warn_once(op->gem.obj->dev, "Could not find an appropriate page size.\n");
         |         ^~~~~~~~~~~~~
   include/linux/dev_printk.h:52:37: note: expected 'const struct device *' but argument is of type 'struct drm_device *'
      52 | void _dev_warn(const struct device *dev, const char *fmt, ...);
         |                ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_warn +508 drivers/gpu/drm/nouveau/nouveau_uvmm.c

   466	
   467	static u8
   468	select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op)
   469	{
   470		struct nouveau_bo *nvbo = nouveau_gem_object(op->gem.obj);
   471	
   472		/* nouveau_bo_fixup_align() guarantees that the page size will be aligned
   473		 * for most cases, but it can't handle cases where userspace allocates with
   474		 * a size and then binds with a smaller granularity. So in order to avoid
   475		 * breaking old userspace, we need to ensure that the VA is actually
   476		 * aligned before using it, and if it isn't, then we downgrade to the first
   477		 * granularity that will fit, which is optimal from a correctness and
   478		 * performance perspective.
   479		 */
   480		if (op_map_aligned_to_page_shift(op, nvbo->page))
   481			return nvbo->page;
   482	
   483		struct nouveau_mem *mem = nouveau_mem(nvbo->bo.resource);
   484		struct nvif_vmm *vmm = &uvmm->vmm.vmm;
   485		int i;
   486	
   487		/* If the given granularity doesn't fit, let's find one that will fit. */
   488		for (i = 0; i < vmm->page_nr; i++) {
   489			/* Ignore anything that is bigger or identical to the BO preference. */
   490			if (vmm->page[i].shift >= nvbo->page)
   491				continue;
   492	
   493			/* Skip incompatible domains. */
   494			if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
   495				continue;
   496			if ((mem->mem.type & NVIF_MEM_HOST) &&
   497			    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
   498				continue;
   499	
   500			/* If it fits, return the proposed shift. */
   501			if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
   502				return vmm->page[i].shift;
   503		}
   504	
   505		/* If we get here then nothing can reconcile the requirements. This should never
   506		 * happen.
   507		 */
 > 508		dev_warn_once(op->gem.obj->dev, "Could not find an appropriate page size.\n");
   509	
   510		return PAGE_SHIFT;
   511	}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

