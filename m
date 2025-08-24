Return-Path: <linux-kernel+bounces-783597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7426CB32F71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA60208110
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C92D6E51;
	Sun, 24 Aug 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL2E4MEF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AD2D6E49
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756035015; cv=none; b=fj61ij92bLRWevow8hmc3mp3B0zddxm6ERrPLMiNpl0fNvcJgL3izSdmLqHHP00uWByeOmy9TXzAaXyFrIVzFi6CQOJBEoE5zAngUQykUl7t4MER1k+EoflBlNLhedIqSktABTfEx14+UXuefw5CeYNa6IVjcsYWxeeDPmYwFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756035015; c=relaxed/simple;
	bh=6G5mPAtsFaXXL0ExPX41cT4TX9upffLJYDpuVfS9Gmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALnkuPgid8jgO5msJANVNf1pDBOwxLULxltGrL/PoJKG5C63/GKkeccQTXBbanEp5Uwo4DLbRx9i/vyfJ8aT9K1jZNPRSDKq9n2S40FR5/taol/Gfu+jXX5azjo++3Zyv1a1Fn3aKHpJ1gYyLMbCHS3p/UPHvjADi1g0IeUDp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL2E4MEF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756035013; x=1787571013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6G5mPAtsFaXXL0ExPX41cT4TX9upffLJYDpuVfS9Gmc=;
  b=FL2E4MEFAPDcu/PrqyGwODpx99BBUlS7+uxB48lVWgP3CBm8xVA6C27h
   Wbcbauh91jLOJYC2ZS+xNeBUoA8aACRCQa9oV5pFaN77c71uc28cZNKyz
   QaMpcPR6eGHxm+Cz3R1eKkVfcA9nqOxYpXs8QovKrhrX0QXpPZp4eMS1A
   05uZV0CYKcj45GeNYnSk/8H+R3K0MOoqMyYP09JWGXKZwxu71q/skIg8/
   Do7eEIlTualhnVlHxjNR6isVXv5WVwM3HeyV53mFRtKu369fjw+8JPyV3
   9VNKqJgEErzNHSTjqJQFr9yaBUs+sV7QFkHv8K8DvdG8GdbN0EapsU96A
   w==;
X-CSE-ConnectionGUID: aE4GCwCgQ16i5wjK86wWpQ==
X-CSE-MsgGUID: cx+1eNsRTIOI1BpA/Zc9aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75724095"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75724095"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 04:30:13 -0700
X-CSE-ConnectionGUID: qwh2lp8ZQci4E0oyDQb0JA==
X-CSE-MsgGUID: SduyHKJuRhmvP2iETSthtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="192736209"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 24 Aug 2025 04:30:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uq8ur-000Mxr-05;
	Sun, 24 Aug 2025 11:29:53 +0000
Date: Sun, 24 Aug 2025 19:29:11 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Peyton Lee <peytolee@amd.com>, Lang Yu <lang.yu@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a
 granularity of 100
Message-ID: <202508241901.DJ851kiv-lkp@intel.com>
References: <20250824085351.454619-2-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824085351.454619-2-lkml@antheas.dev>

Hi Antheas,

kernel test robot noticed the following build errors:

[auto build test ERROR on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/drm-amd-display-Adjust-AUX-brightness-to-be-a-granularity-of-100/20250824-165633
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250824085351.454619-2-lkml%40antheas.dev
patch subject: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a granularity of 100
config: i386-buildonly-randconfig-002-20250824 (https://download.01.org/0day-ci/archive/20250824/202508241901.DJ851kiv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508241901.DJ851kiv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508241901.DJ851kiv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.o: in function `amdgpu_dm_backlight_set_level':
>> amdgpu_dm.c:(.text+0x8b89): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

