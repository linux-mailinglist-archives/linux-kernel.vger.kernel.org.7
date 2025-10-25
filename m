Return-Path: <linux-kernel+bounces-869801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1CC08C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C89E400D68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933002DA776;
	Sat, 25 Oct 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joUPdBdm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648152D97A8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761374638; cv=none; b=bY8DmhTOi+4kEq1CbDd99y4OGgnLxtiz6V5pbtnX+i/doFAwvBcOfL5WBf+sT9GvwAh6HmBWYtXBNaifbIRun0OtxFZRUFedqzgi6/wVFNdjzAPDdWb/QvWuovMM6I5T81QblknttY3fsNFoppRzjpDyGE46u1R12hDh5+QRaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761374638; c=relaxed/simple;
	bh=5Xd2T2aNTl8c9Ga1fQDjXYNrqheu8xPazvqz7CR1xeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckfyJJOtk8BowizVcPH/JvusieNR7vJzSuPxePA5vUqitfJnHv2XIbQ0l7wci2OhLOxR79PoaV1cQ2LIUm2M02/+KxXQVphq+pPEdpGTCvOMOeHcBgDTQ7Fjja1xB6O4WWNFbDmmeZ0Y6oZkYmANfSDOAjCSevzQujMmX03/CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joUPdBdm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761374637; x=1792910637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Xd2T2aNTl8c9Ga1fQDjXYNrqheu8xPazvqz7CR1xeE=;
  b=joUPdBdmQ09BcKjp57waKNFsyBPA+/tIfF2ce1U41SUPYYDEsYIVMaYn
   2abb6BM083f7xYBXOS3KeFhXztpPe8hx94edtXV2MQwmcHIsw8Uow6f5k
   HsMDY78YG0Z9T9UY6Ow6KrH4HTUgcMzmNTxwXYXX/cN9xjumeEFfJXTih
   +BYrYddxA53GCJFjBcKO2TzsIcrkHNb/AYByxHBdXIO7VFTTVyKg6NldA
   Y5Qp1DtMKigZbDVn2ZC3ZTheVKsLGUxAVBRcByuelbtV/xfdlQ+ZmjXzI
   /aQHevonsuZdWvZcyJ3k8CROz+J5hu/CH0yYmQIlyxbetb8DqD43QJgbo
   A==;
X-CSE-ConnectionGUID: f0yNwP45RYer5HAbOBwZxg==
X-CSE-MsgGUID: aDY2sKi3R7KfEKT6cT/WrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67189552"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="67189552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 23:43:56 -0700
X-CSE-ConnectionGUID: GPcfqCRKSqWteCHwySs0PA==
X-CSE-MsgGUID: y5IAKaXKSUOW6cbBl86z4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="184671266"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2025 23:43:53 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCY0F-000F9d-1c;
	Sat, 25 Oct 2025 06:43:51 +0000
Date: Sat, 25 Oct 2025 14:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 6/6] drm/sitronix/st7571-spi: add support for SPI
 interface
Message-ID: <202510251430.rl42LCVH-lkp@intel.com>
References: <20251024-st7571-split-v1-6-d3092b98130f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-st7571-split-v1-6-d3092b98130f@gmail.com>

Hi Marcus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7e73cefd2bede5408d1aeb6145261b62d85d23be]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcus-Folkesson/drm-sitronix-st7571-i2c-rename-struct-drm_device-in-st7571_device/20251024-192347
base:   7e73cefd2bede5408d1aeb6145261b62d85d23be
patch link:    https://lore.kernel.org/r/20251024-st7571-split-v1-6-d3092b98130f%40gmail.com
patch subject: [PATCH 6/6] drm/sitronix/st7571-spi: add support for SPI interface
config: x86_64-randconfig-005-20251025 (https://download.01.org/0day-ci/archive/20251025/202510251430.rl42LCVH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510251430.rl42LCVH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510251430.rl42LCVH-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: module st7571-i2c uses symbol st7567_config from namespace DRM_ST7571, but does not import it.
WARNING: modpost: module st7571-i2c uses symbol st7571_config from namespace DRM_ST7571, but does not import it.
>> WARNING: modpost: module st7571-spi uses symbol st7567_config from namespace DRM_ST7571, but does not import it.
>> WARNING: modpost: module st7571-spi uses symbol st7571_config from namespace DRM_ST7571, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

