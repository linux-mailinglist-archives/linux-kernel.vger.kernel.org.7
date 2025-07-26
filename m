Return-Path: <linux-kernel+bounces-746671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6EB129E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1155438D8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782642264A6;
	Sat, 26 Jul 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M52CqRVw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64321A454
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753522525; cv=none; b=soDOs8own5DXuEdJQX+IvdIOs/gZIZ0qDhy6Z5RCYFo1UwVO1iaCSLJ3EV0eSG+kbXPaB+dlJWiWodB5aX8yPWDNTKjxF2kMf0maEuLLYYwKH2I3PHcFnO594GwDuVYGHD+A+138jKoUYpzevvH526PATwKUX2pIfDJuo4bqgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753522525; c=relaxed/simple;
	bh=KQ3txyy3YUW77dQq7TyYbTrF1SrO05+NIgynyFTKF+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfKtOIZzYLSoszLaAM+WWcORlYZuR9AlZ7JS30gCSySyK/BUfkRB9XPrDRsBpBXXhfe0b1GoMK7DfMHDskw0kI5wtQ9/GtVsHvYCaAlByXvB7X0XdbSYvCdEnHdCTN0MM8FFnGdHsjiYFnV5DnAJq7k/U0FoFb/0wAd32+AAodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M52CqRVw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753522524; x=1785058524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQ3txyy3YUW77dQq7TyYbTrF1SrO05+NIgynyFTKF+E=;
  b=M52CqRVw6Pf+zjPqz1ya6C3M2erlg3xNV9K0JxKzwWbfTfD/d025KnNf
   iE51/Hf3rTWGaC1xf/zT0CtFBaElwJddwCySNSbJvBMejAhgvdhCtzUN6
   i4IqTSsR3iIpoMcvDjijxpjsNuattcrD4G5wR4hr9xVWompCDQuPmwLNm
   /Y/5T4Y0VXTLApoWXbXPS0lRm4U0IVlxJYJRlsTASK0w0NDIpQaJMHh2n
   g2zaB92L3kfxbicyJWcIKM3hTgSz1izlozKmBPe/lZzRW4COJQ0NaXrVT
   zH5DWT+fK1Y4qjXy0Og1Vn34DyevNvzTYCRrCB0TQgZ2LAV88R5+tMWEy
   w==;
X-CSE-ConnectionGUID: Q8aMhRgyQYCaCNdiUD8s/g==
X-CSE-MsgGUID: BjKQX5AXS2W0AUR7raD0pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59644499"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59644499"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 02:35:23 -0700
X-CSE-ConnectionGUID: Pt9d/288Saqm6crfNeloDQ==
X-CSE-MsgGUID: ViYr2/H5SwSCtIEMBAV7Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161836535"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Jul 2025 02:35:20 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufbJF-000LqR-2D;
	Sat, 26 Jul 2025 09:35:17 +0000
Date: Sat, 26 Jul 2025 17:34:42 +0800
From: kernel test robot <lkp@intel.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>,
	dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nd@arm.com,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: Re: [PATCH v5 4/7] drm/panthor: Introduce sampling sessions to
 handle userspace clients
Message-ID: <202507261719.EKOvj9uv-lkp@intel.com>
References: <1a56b67cf8849bc3a6140d2163a0206d03bb9a60.1753449448.git.lukas.zapolskas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a56b67cf8849bc3a6140d2163a0206d03bb9a60.1753449448.git.lukas.zapolskas@arm.com>

Hi Lukas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e48123c607a0db8b9ad02f83c8c3d39918dbda06]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Zapolskas/drm-panthor-Add-performance-counter-uAPI/20250725-230250
base:   e48123c607a0db8b9ad02f83c8c3d39918dbda06
patch link:    https://lore.kernel.org/r/1a56b67cf8849bc3a6140d2163a0206d03bb9a60.1753449448.git.lukas.zapolskas%40arm.com
patch subject: [PATCH v5 4/7] drm/panthor: Introduce sampling sessions to handle userspace clients
config: x86_64-buildonly-randconfig-005-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261719.EKOvj9uv-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261719.EKOvj9uv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261719.EKOvj9uv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/panthor/panthor_perf.c:420 function parameter 'file' not described in 'panthor_perf_session_setup'
>> Warning: drivers/gpu/drm/panthor/panthor_perf.c:420 Excess function parameter 'ptdev' description in 'panthor_perf_session_setup'
>> Warning: drivers/gpu/drm/panthor/panthor_perf.c:420 Excess function parameter 'pfile' description in 'panthor_perf_session_setup'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

