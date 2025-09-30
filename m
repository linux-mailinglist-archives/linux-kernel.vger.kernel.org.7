Return-Path: <linux-kernel+bounces-837568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE5EBACA21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D71E3C7C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EC221275;
	Tue, 30 Sep 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+WHo3vt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6D1F1932
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230431; cv=none; b=om8gRP9/Qw88l6+c33dISlouGny8Y0pK2+lkcSOaioR09PR3JPsAJqUP5Yqst48TRtvs9KpqlDzEFKZdEDq9BAYDFeCKT1Oc6STxwkyMtIUgE7v9fTQIshhSU6L1o0LxPZrOkwt8dwyKR60Tico9JknJmFbjPiIqNCVt9Y1uO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230431; c=relaxed/simple;
	bh=JkEgfrFobUvPs9WUhYazXemTzj5bNBhLW05gn5e7dd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQqzQw9LII7EB7yHLhuSlXEEwM02Pqk49VY/bInKY/VxHGIg2W0aZEvonJ7X/xyiCYj0owS/CGpR3hSNkIEjpSvUHUg3V971oGfYaSgAlHHikDhjHoPqOiv+KHi4SNUrw/g6Ylwd347bh02314CMOUPsYDh4zGWklbMbMNkKB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+WHo3vt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759230429; x=1790766429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JkEgfrFobUvPs9WUhYazXemTzj5bNBhLW05gn5e7dd8=;
  b=C+WHo3vt7xPUc7iYxUexZY7llARR+9vmE9GiqLTQbjP9KWDIIzQLq0gG
   1vGubEAiZlfUN2Y+9Td/2XmpyyHDrBxCgBrFHuZPgYgDO8w8mlmynf8DY
   AjY0s5D9aXQf2R+YK1/w2IplSsJaF7XVpAumZaYHS6FolpznX2dsarh7q
   gpBhm1JU27ThKcPIbTXf4kIsI4AlRNsTADvD4nQiZ1pkK6Su2tusHqac1
   RIyA8MIzOR6J+tu+QstFVPTOQoJ6YhEhntg7kpA4y7NI6R4Z0qJZffHmf
   MvFhBRGcQBsIO9m6CfWE3hdWn8Yv83vnlGTkrRD9X8Zp687O5MiiU5Kle
   w==;
X-CSE-ConnectionGUID: wC59RZQHQeO8IfZVbOuIDw==
X-CSE-MsgGUID: kmJs11VfRSqfEgxe+bEqPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72907808"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72907808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:07:09 -0700
X-CSE-ConnectionGUID: MY9ov9QwQ5GXH8kC6Jesqg==
X-CSE-MsgGUID: HZtVzlPZRheexbv1wLS3bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="177763539"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Sep 2025 04:07:01 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3YCB-0001CR-16;
	Tue, 30 Sep 2025 11:06:59 +0000
Date: Tue, 30 Sep 2025 19:06:41 +0800
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
Subject: Re: [PATCH 4/8] drm/i915: Use huge tmpfs mount point helpers
Message-ID: <202509301837.pQ2TiJkx-lkp@intel.com>
References: <20250929200316.18417-5-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929200316.18417-5-loic.molinari@collabora.com>

Hi Loïc,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[cannot apply to akpm-mm/mm-everything linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-shmem-helper-Add-huge-page-fault-handler/20250930-040600
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250929200316.18417-5-loic.molinari%40collabora.com
patch subject: [PATCH 4/8] drm/i915: Use huge tmpfs mount point helpers
config: i386-randconfig-013-20250930 (https://download.01.org/0day-ci/archive/20250930/202509301837.pQ2TiJkx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509301837.pQ2TiJkx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509301837.pQ2TiJkx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/gem/i915_gemfs.c: In function 'i915_gemfs_init':
>> drivers/gpu/drm/i915/gem/i915_gemfs.c:29:17: error: implicit declaration of function 'drm_gem_shmem_huge_mnt_create' [-Wimplicit-function-declaration]
      29 |         gemfs = drm_gem_shmem_huge_mnt_create("within_size");
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/gem/i915_gemfs.c:29:15: error: assignment to 'struct vfsmount *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      29 |         gemfs = drm_gem_shmem_huge_mnt_create("within_size");
         |               ^
   drivers/gpu/drm/i915/gem/i915_gemfs.c: In function 'i915_gemfs_fini':
>> drivers/gpu/drm/i915/gem/i915_gemfs.c:46:9: error: implicit declaration of function 'drm_gem_shmem_huge_mnt_free' [-Wimplicit-function-declaration]
      46 |         drm_gem_shmem_huge_mnt_free(i915->mm.gemfs);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_gem_shmem_huge_mnt_create +29 drivers/gpu/drm/i915/gem/i915_gemfs.c

     9	
    10	void i915_gemfs_init(struct drm_i915_private *i915)
    11	{
    12		struct vfsmount *gemfs;
    13	
    14		/*
    15		 * By creating our own shmemfs mountpoint, we can pass in
    16		 * mount flags that better match our usecase.
    17		 *
    18		 * One example, although it is probably better with a per-file
    19		 * control, is selecting huge page allocations ("huge=within_size").
    20		 * However, we only do so on platforms which benefit from it, or to
    21		 * offset the overhead of iommu lookups, where with latter it is a net
    22		 * win even on platforms which would otherwise see some performance
    23		 * regressions such a slow reads issue on Broadwell and Skylake.
    24		 */
    25	
    26		if (GRAPHICS_VER(i915) < 11 && !i915_vtd_active(i915))
    27			return;
    28	
  > 29		gemfs = drm_gem_shmem_huge_mnt_create("within_size");
    30		if (IS_ERR(gemfs))
    31			goto err;
    32	
    33		i915->mm.gemfs = gemfs;
    34		drm_info(&i915->drm, "Using Transparent Hugepages\n");
    35		return;
    36	
    37	err:
    38		drm_notice(&i915->drm,
    39			   "Transparent Hugepage support is recommended for optimal performance%s\n",
    40			   GRAPHICS_VER(i915) >= 11 ? " on this platform!" :
    41						      " when IOMMU is enabled!");
    42	}
    43	
    44	void i915_gemfs_fini(struct drm_i915_private *i915)
    45	{
  > 46		drm_gem_shmem_huge_mnt_free(i915->mm.gemfs);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

