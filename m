Return-Path: <linux-kernel+bounces-863978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9BBF9A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2C54FB0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A951FE47C;
	Wed, 22 Oct 2025 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc+6sG1E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0C217733
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097665; cv=none; b=NEp50YnqUvP48ksmP5kvDqrGeQZ5vb4ZQC6UMHP5DhEhosfdQUSnfpf69QNeqwgYszENasgcq/fr4c/xsk/r4ZR9QteQsB7TrMfO4N+FFA6g0NnKchmBVyEhFyYELAYEitOQjdIc9KsWF82Sw7Ne+6gMDAtN11dQOrk7BzleCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097665; c=relaxed/simple;
	bh=SYrjklv5yaqTa9b2Mz801w7XycbmljMb3/5NvgufkhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QowB2dOUo7S0a7S4Gp3XVZz+uNzLynux+AXH9JvJ/WUQIgSToK7LDkL4FQ9NDFh2XJB0w6cLOt0xfgVIQvunQbWsNdxRQkIcohm5L5Rr3BVq1oGxjDGCCsfWP1eRs1dlmnS+BB7yLJBEfn/0dtUxTt/J7DbEwvAPGL49O9OCzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc+6sG1E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761097664; x=1792633664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SYrjklv5yaqTa9b2Mz801w7XycbmljMb3/5NvgufkhA=;
  b=Hc+6sG1El1YdxhoxfIyWV/qinMO7MO2qQdqI1jAjm2AjF0tAH0KUvo3M
   5+XzWxlAeKuse4zdhKTsuQH0+e59xfoyWd43dGu32BeGDiu4lNebAWgqq
   +npOuoatmhyDr2Fkz3CUz/qGQb4S6uLbIClGcK/VeOUZuz5GIYoxIizHH
   ++bBxr58JUeCwJD1vqjgKj7YrLSqElZAmyx54d91kj/Yn1rQFTpToCYo0
   GpygqVKU0wVR67l+1HI+LvGIzOjClegsvnmtUtLpBCBUpjvd35kw0G772
   ZvXbMj3VvBoQ8ahilBffmvXU+nAAqEjT5J8xdt3eXdCDJ2Emoe6UXLxNE
   g==;
X-CSE-ConnectionGUID: pcdDA2OzQZGPByT3jlr4mQ==
X-CSE-MsgGUID: DlH/bnQ7T4uXnjcBbzqhQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63383975"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="63383975"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:47:44 -0700
X-CSE-ConnectionGUID: 64Y6jRp/QL6Aq2MJZAFxRg==
X-CSE-MsgGUID: fNuSc6gfQGOh7smNgfyucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="182947416"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Oct 2025 18:47:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBNws-000BuR-28;
	Wed, 22 Oct 2025 01:47:34 +0000
Date: Wed, 22 Oct 2025 09:47:33 +0800
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
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christopher Healy <healych@amazon.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpers
Message-ID: <202510220918.LOLA5KIF-lkp@intel.com>
References: <20251021113049.17242-7-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021113049.17242-7-loic.molinari@collabora.com>

Hi Loïc,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251021]
[also build test ERROR on v6.18-rc2]
[cannot apply to akpm-mm/mm-everything drm-misc/drm-misc-next linus/master v6.18-rc2 v6.18-rc1 v6.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-shmem-helper-Simplify-page-offset-calculation-in-fault-handler/20251021-193355
base:   next-20251021
patch link:    https://lore.kernel.org/r/20251021113049.17242-7-loic.molinari%40collabora.com
patch subject: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpers
config: x86_64-buildonly-randconfig-001-20251022 (https://download.01.org/0day-ci/archive/20251022/202510220918.LOLA5KIF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220918.LOLA5KIF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510220918.LOLA5KIF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gem/i915_gem_shmem.c:511:46: error: no member named 'huge_mnt' in 'struct drm_device'
     511 |                 filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
         |                                                  ~~~~~~~~~ ^
   1 error generated.


vim +511 drivers/gpu/drm/i915/gem/i915_gem_shmem.c

   486	
   487	static int __create_shmem(struct drm_i915_private *i915,
   488				  struct drm_gem_object *obj,
   489				  resource_size_t size)
   490	{
   491		unsigned long flags = VM_NORESERVE;
   492		struct file *filp;
   493	
   494		drm_gem_private_object_init(&i915->drm, obj, size);
   495	
   496		/* XXX: The __shmem_file_setup() function returns -EINVAL if size is
   497		 * greater than MAX_LFS_FILESIZE.
   498		 * To handle the same error as other code that returns -E2BIG when
   499		 * the size is too large, we add a code that returns -E2BIG when the
   500		 * size is larger than the size that can be handled.
   501		 * If BITS_PER_LONG is 32, size > MAX_LFS_FILESIZE is always false,
   502		 * so we only needs to check when BITS_PER_LONG is 64.
   503		 * If BITS_PER_LONG is 32, E2BIG checks are processed when
   504		 * i915_gem_object_size_2big() is called before init_object() callback
   505		 * is called.
   506		 */
   507		if (BITS_PER_LONG == 64 && size > MAX_LFS_FILESIZE)
   508			return -E2BIG;
   509	
   510		if (drm_gem_has_huge_mnt(&i915->drm))
 > 511			filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
   512							 size, flags);
   513		else
   514			filp = shmem_file_setup("i915", size, flags);
   515		if (IS_ERR(filp))
   516			return PTR_ERR(filp);
   517	
   518		/*
   519		 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on shmem
   520		 * objects by setting O_LARGEFILE.
   521		 */
   522		if (force_o_largefile())
   523			filp->f_flags |= O_LARGEFILE;
   524	
   525		obj->filp = filp;
   526		return 0;
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

