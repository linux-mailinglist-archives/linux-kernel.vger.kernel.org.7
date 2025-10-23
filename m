Return-Path: <linux-kernel+bounces-866346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886DBFF882
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135933AA281
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E82DC78C;
	Thu, 23 Oct 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3V4d8Ts"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883582DAFAF;
	Thu, 23 Oct 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203942; cv=none; b=j97fwDvX4P3KEgh+8iBe6Qje/bQESZ07sunlYaYKGW6Q6A0oghsy32hPSd4sKY1iK9TmR8r9Fhjz7LCy9dGzY+APLQwf2RQOOy6Xc8GJMPg3zId3jLbmKeTE+59gfUJPctclCGWa1GklmbXdZkl5un9FX8NFPFjtCJ7vycw3r1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203942; c=relaxed/simple;
	bh=Wdv4KhYwTEUc/LA/L05ZFeU6Lf3l77gTzl2aS1om74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgP5yWLcim1DD+wv16u26vFbo5D48tL5SZ1WgulWWFC5jryDhuc3XeE1f19PRRrzflm9dL8NT2wzrgV3Eq0YG4da7x3gjHgyAUiVecemiAmXAOxuRif1d+3lf7mkEGrfQ1t4tuEMoTvBtFeGDBOMkyfh7OqNXEXJtptIEtEEchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3V4d8Ts; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761203940; x=1792739940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wdv4KhYwTEUc/LA/L05ZFeU6Lf3l77gTzl2aS1om74o=;
  b=d3V4d8Tso50YmS3UxjG1O+Fi7I+z/9dBoDy/bc+nOLS9w2o8BcTEQW3v
   rI9orz8cjmq+RPNqQNxZauBLvYrwmtgW7fXwxVzo8Y5zVuHcup6NcindU
   p9EESJbCUMKRzXeG7TNnwLru7NS5me62qgRFvGHYq690OpxUt3ViuqRr/
   Vq/6FFKGZjtHjJE7+eQpA4hoLcJnXlUKtyl+h0EkZFjcY0lacHD4Tgw4m
   d7KyRxk2eDFz62+PmDwQkVrgYto9esGr+QFK2Dvx5ka30I2SJ3XenXubW
   WHvRJ6K3XHH5SQK+7AP0uZqwv0urdBROR4FHVe4qNKM2udEfDABa64xTW
   Q==;
X-CSE-ConnectionGUID: U1xLmsi0QzC1vW/+KwUiNA==
X-CSE-MsgGUID: gZWnCcy3RBGtMIe6iLs1cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62574148"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="62574148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 00:19:00 -0700
X-CSE-ConnectionGUID: CJfyOGOqQ6Sa/dhY/2ZvGw==
X-CSE-MsgGUID: I8JKyANbTqWWDWeiP+PORg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184563304"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Oct 2025 00:18:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBpb5-000D8v-0M;
	Thu, 23 Oct 2025 07:18:55 +0000
Date: Thu, 23 Oct 2025 15:18:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/amd/ras: Fix memory corruption in
 ras_core_convert_timestamp_to_time()
Message-ID: <202510231558.5UzBX0ox-lkp@intel.com>
References: <aPi6I5z5oenppEuu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPi6I5z5oenppEuu@stanley.mountain>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251022]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/drm-amd-ras-Fix-memory-corruption-in-ras_core_convert_timestamp_to_time/20251022-190512
base:   next-20251022
patch link:    https://lore.kernel.org/r/aPi6I5z5oenppEuu%40stanley.mountain
patch subject: [PATCH next] drm/amd/ras: Fix memory corruption in ras_core_convert_timestamp_to_time()
config: arm-randconfig-003-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231558.5UzBX0ox-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510231558.5UzBX0ox-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510231558.5UzBX0ox-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

