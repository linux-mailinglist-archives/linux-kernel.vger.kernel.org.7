Return-Path: <linux-kernel+bounces-758770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A570B1D3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD0384E03C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01224886F;
	Thu,  7 Aug 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0ovFJNB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651424DD00;
	Thu,  7 Aug 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552966; cv=none; b=dBUsFV56Bh3WkzEyxwFSbKcIbSvAqxgEmhnrm2/9r7HVd/axOK17tXQpk2YcsnU1/xiyzrkfATGgrWbIsu8KKH/iE9m0ZUkEdvosVr3+bZMeCPKAt1MttE+UgGh30dhl3+zeM1DQDRxnoboLWZE97dgB+q63gLKyw0qnMWVZGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552966; c=relaxed/simple;
	bh=zuI1C1HRVJfMkiRebwbzbuKkjROv+QYbG6sOYJiM1KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmfIn+Bs3C4WQtnPfXWytZd+o4ew8gngG51cWwZGRRp6KrGV7cSHp26VxuuY9EVCuIiuWd9yarj83GQ9uEESxZQf3wZuCVlBO2F8CRWBn/xFB3oKVPf1iyyvxSFxgSer+seMg3YPjTjQrKSNODu1jX1SV+lEq9YF+tH4KbPz5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0ovFJNB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754552965; x=1786088965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zuI1C1HRVJfMkiRebwbzbuKkjROv+QYbG6sOYJiM1KQ=;
  b=N0ovFJNBgoSzqXoX4HOtEwcHsgDJTmPjVpttldlqqop81ndVoIc5g87x
   WScfFy+lzopXU+Oth4olTax0TTbxsUwz3EiA/cM+XhPYdPwrR8kBH19WL
   BFaDmJ35cJWNSBKXaeuTRAEKmKwdSaERZpoD9VhQ8uR8GGENzYQXbYMHo
   TILGvHmKQazV5pr+1MluMl4b0rFjq8XVpatu/jU+xa/hQrzVUOZe0G3Wi
   ROOgdoKC3k/h6Me0fWheaZn91WHw6KdyOUkLHltCBvqYaxmaQI97gNcCm
   5tmV7T3o5sLSCumCbKXItE0DYPU7e4iurfq7qPGEywBwR+Z/r7kVPhg8M
   g==;
X-CSE-ConnectionGUID: vVC02Xh/SO+Jk24JXfMrwg==
X-CSE-MsgGUID: KvrpxoAiSz2TRRMp8rbJUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56797708"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56797708"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 00:49:24 -0700
X-CSE-ConnectionGUID: zFWSQLVWRp6rIWqOCSweeQ==
X-CSE-MsgGUID: 468e9o/TT3K9ahfZKP6BQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165355844"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Aug 2025 00:49:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujvMn-0002X4-0C;
	Thu, 07 Aug 2025 07:49:01 +0000
Date: Thu, 7 Aug 2025 15:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 1/3] drm: Add driver for Sitronix ST7920 LCD displays
Message-ID: <202508071554.hJ1Avou0-lkp@intel.com>
References: <20250806-st7920-v1-1-64ab5a34f9a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-st7920-v1-1-64ab5a34f9a0@gmail.com>

Hi Iker,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c571cb70e1ed43ee543c70151e61a001ab2eefa2]

url:    https://github.com/intel-lab-lkp/linux/commits/Iker-Pedrosa/drm-Add-driver-for-Sitronix-ST7920-LCD-displays/20250806-205210
base:   c571cb70e1ed43ee543c70151e61a001ab2eefa2
patch link:    https://lore.kernel.org/r/20250806-st7920-v1-1-64ab5a34f9a0%40gmail.com
patch subject: [PATCH 1/3] drm: Add driver for Sitronix ST7920 LCD displays
config: riscv-kismet-CONFIG_DRM_GEM_SHMEM_HELPER-CONFIG_DRM_ST7920-0-0 (https://download.01.org/0day-ci/archive/20250807/202508071554.hJ1Avou0-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250807/202508071554.hJ1Avou0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508071554.hJ1Avou0-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER when selected by DRM_ST7920
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
     Selected by [y]:
     - DRM_ST7920 [=y] && HAS_IOMEM [=y] && DRM [=y] && SPI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

