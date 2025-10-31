Return-Path: <linux-kernel+bounces-880115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6DC24EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A983AA8A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA133E35F;
	Fri, 31 Oct 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPLWZYXg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EA3081AB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912349; cv=none; b=Mc7ziyvfY2lCNKwvKpOj0kzNux+GIkMOoybveUAjqQ1QIDUJP49y6jNAe+AP+zOVR5CUgnx/0EB4XAqv7OO6BkyfODpfCXuaf5fIxzCtd1P/mrU2W6HB+9z94N089Tb7L+sSzjeIakeNQ9cUTFuKWinBiPL+lGG4YCKvClqUK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912349; c=relaxed/simple;
	bh=VkVOBBztHbf5OnMunexhusiVEZtxdXW/RGu9oNoL5xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2/xv+O42wRPXGnSB611qFzKSwm4XnyGziYFpLp/TBrvw8JHWXai23oGMmlXXswbPGHq3buaM4FbM5LH3s3lTPjTFHGDSXWxI1zLsQW2+RINT+0VttqFQy9RJ5ttP2EkRIxlNJFI6Cdmwt/gciGyk2QfMuoqHwfPcV0NOdClg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPLWZYXg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761912347; x=1793448347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VkVOBBztHbf5OnMunexhusiVEZtxdXW/RGu9oNoL5xI=;
  b=KPLWZYXgAA860D4YcY35kD7CO6LOWD/c9zT3YKiO/br4QO5bNZGxfA+4
   3usK+aH+ENeteq5ZxICq+hXkU6DZcp+K3YraYTB1M1mKstw6/yMTM3k3b
   zO7S/W01dkyOulDaSZIT+IOJPrEInfer1a+JP6LJ6orNFubgsSbAHOJnK
   bSalOvsD6A/nV2GtKB53x5NiQ1ikf88bM1WrYJEZHkQzp6rJ1uxU4IRbk
   B5SXVgavINcb0OloLDM2qPMPiboij3/hEKV/pPJItfSfSr8HaVJunZAw0
   fOiMEyTptwLIg802MlFRotpzg8fVy3CBorn+TR6wMIhL0ZocTgT5YNScz
   Q==;
X-CSE-ConnectionGUID: RbeZhffLS2uKNB2rfW73yA==
X-CSE-MsgGUID: 3nO9dGqAQFWmU/t8s8de4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63277378"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63277378"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:05:47 -0700
X-CSE-ConnectionGUID: C0gg40gQRlaq0xn+9CjnhQ==
X-CSE-MsgGUID: aZ8dwoVUT5eHJEPOW6wF5Q==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2025 05:05:44 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEnt0-000N4s-00;
	Fri, 31 Oct 2025 12:05:42 +0000
Date: Fri, 31 Oct 2025 20:04:54 +0800
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
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: Re: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
Message-ID: <202510311903.wAzY7iCb-lkp@intel.com>
References: <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com>

Hi Mohamed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohamed-Ahmed/drm-nouveau-uvmm-Prepare-for-larger-pages/20251031-070600
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251030230357.45070-3-mohamedahmedegypt2001%40gmail.com
patch subject: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
config: alpha-randconfig-r064-20251031 (https://download.01.org/0day-ci/archive/20251031/202510311903.wAzY7iCb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311903.wAzY7iCb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510311903.wAzY7iCb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_uvmm.c: In function 'op_map_aligned_to_page_shift':
>> drivers/gpu/drm/nouveau/nouveau_uvmm.c:462:37: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     462 |  return op->va.addr & non_page_bits == 0 &&
         |                       ~~~~~~~~~~~~~~^~~~
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:463:38: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     463 |         op->va.range & non_page_bits == 0 &&
         |                        ~~~~~~~~~~~~~~^~~~
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:464:40: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     464 |         op->gem.offset & non_page_bits == 0;
         |                          ~~~~~~~~~~~~~~^~~~


vim +462 drivers/gpu/drm/nouveau/nouveau_uvmm.c

   456	
   457	static bool
   458	op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_shift)
   459	{
   460		u64 non_page_bits = (1ULL << page_shift) - 1;
   461	
 > 462		return op->va.addr & non_page_bits == 0 &&
   463		       op->va.range & non_page_bits == 0 &&
   464		       op->gem.offset & non_page_bits == 0;
   465	}
   466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

