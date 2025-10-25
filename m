Return-Path: <linux-kernel+bounces-869681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82610C087FF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8343BD620
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37921CFF7;
	Sat, 25 Oct 2025 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiOQoZ2E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6721C9F4
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761355481; cv=none; b=EUJ0Uq2XS9IsRwHTybWGIk3HDV/cygX9kMTSk7TytU2zSWTFoAUTlD3EoesO0fp9yo6ODPtfCb+f99LyzExjZ4XaaDRSv22mbM7Pxit/YksgrwJ02yEEggVUFdQgZXToxOqbNUIigPT40Ol/V5HUC0odiRTI4BqunZdgN+opaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761355481; c=relaxed/simple;
	bh=fytU8tlszGgmAG+kPqj4fV0nEPzg/wdifyHqcSQID9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z26YmFeUUHf5ApAsZ2Ukrxjpy9mT3KSZUOoNSXjjCmGCqY/BMzEfER0Td8VphLsHCi+vXEymJ1N4MdqHk3BcM9mDIk1hdbXC3W25iweYndpBDNAuy126gAR1RFEmvGQ7dgY34sOGC0Oifg3kmPtJ3h4fMSNCrZo6AhWfZmBm3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiOQoZ2E; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761355479; x=1792891479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fytU8tlszGgmAG+kPqj4fV0nEPzg/wdifyHqcSQID9E=;
  b=XiOQoZ2EYTrWZs+SVzem+SnU8YNuFvpgbWEU8/S/ueVbolqPXEiuXGMl
   qYwLoLs0kq3DqZ1cSaDVBgwvsG3oDCPltBDrCv8Q/3XB/dRv3swRu+4hU
   7cVqWl9q50ShTIiJtXMp/xXtRc6IeBW8QbUZ2chIF4K5CwsU/Ibq0iGm8
   5lbwAYMTiwmN0Nbqbp1FbnnwlOKUm0QHchgAzYS7No531IbJmLG9LrsJy
   a2zO1wwJ32n88/Ss4SBa3GwUaUjP55UzccFPAttrz0/Kug/33Sh7zHgvZ
   GI3h6pBzQFjRHLGstv1ZV4uh20Eji70qRXg+FL6K7ZrgQd7IRohMF/BSF
   A==;
X-CSE-ConnectionGUID: 4qbnz/ddSry1JcGHsdKE8Q==
X-CSE-MsgGUID: ZkWjPoZNQ4qey5aNdrKKvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80968035"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="80968035"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 18:24:39 -0700
X-CSE-ConnectionGUID: ZlVDuy5LQby6ocrjtzJKMg==
X-CSE-MsgGUID: P9D4xzioRMKD5H2bURQLig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="189690766"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 24 Oct 2025 18:24:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCT1G-000F2L-2H;
	Sat, 25 Oct 2025 01:24:34 +0000
Date: Sat, 25 Oct 2025 09:23:55 +0800
From: kernel test robot <lkp@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 6/6] drm/sitronix/st7571-spi: add support for SPI
 interface
Message-ID: <202510250945.hB9LcnfV-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 7e73cefd2bede5408d1aeb6145261b62d85d23be]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcus-Folkesson/drm-sitronix-st7571-i2c-rename-struct-drm_device-in-st7571_device/20251024-192347
base:   7e73cefd2bede5408d1aeb6145261b62d85d23be
patch link:    https://lore.kernel.org/r/20251024-st7571-split-v1-6-d3092b98130f%40gmail.com
patch subject: [PATCH 6/6] drm/sitronix/st7571-spi: add support for SPI interface
config: i386-randconfig-014-20251025 (https://download.01.org/0day-ci/archive/20251025/202510250945.hB9LcnfV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250945.hB9LcnfV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510250945.hB9LcnfV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module st7571-spi uses symbol st7567_config from namespace DRM_ST7571, but does not import it.
>> ERROR: modpost: module st7571-spi uses symbol st7571_config from namespace DRM_ST7571, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

