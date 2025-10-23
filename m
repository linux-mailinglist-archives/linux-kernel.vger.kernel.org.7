Return-Path: <linux-kernel+bounces-867653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35259C03354
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 941A93497C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0434D918;
	Thu, 23 Oct 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAeQ6mZa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63528E00;
	Thu, 23 Oct 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248383; cv=none; b=f68bDfuVRlUaOnsJC0BVYbTllUcnbDQJnilLvvjHCkN1Sgg1tVe4LTGX9PfFdfd1yqomkJCUJF4SNLnyiPmlz+Vmjx5lzgoWRrbPmgot1NVv7X6H9PvuNw8xiBa7ED13gUdjSvDBnHhq+XNvLsHWC/d7RWIx5CBptVf2gK8Dhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248383; c=relaxed/simple;
	bh=OSmpnNs0/AMNUFsS6Fsz1K/9p0tTe3Vtc+ysYl6ffNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXUuAhkqJT4XN0trD+H1+TrgCNyJa+kPx9Ht2oblMERuQLJ7VeCTALyb/2cZaSiClz6loz6E1tMcjxZ8LBAO/hY9KuSRo9oJKB9rouJUjTvZ6tFetWzbBNdpjT+BKEnUUh0gJ7iGE96MLELEn7QS/sFWD86MZINR94/27NG6YYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAeQ6mZa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761248381; x=1792784381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSmpnNs0/AMNUFsS6Fsz1K/9p0tTe3Vtc+ysYl6ffNc=;
  b=XAeQ6mZaj+99SBbudJtBXL7VTy5F6psQ0Rk03lHA8SrJzl+PL3fHFQ4s
   vsAd3As4QtmFv2rSPj/OBMNxP5Bd391LI5C+me31socaDXGnL3qvHQtXM
   OMcoR1emqtw1r7ZaGtM/Owg9natBKgj0OucERSekk+Ar39wYxZJf6+tKL
   pBlCm0haMKeNfy9WsesZppREX7fAieQbQ6S6rj2FwxoG0YK9763t8G7+9
   SOGzm1wTLi1sMQDZHuF69XBY1ouZG7UcAC+PdnzIdP1t6sdutSs//v3hz
   kW1+HsawrnLSFx5Dj3eOXtFJWOfhdCwsXFyQD9gXFZs3cLbKS0vfRGp2f
   w==;
X-CSE-ConnectionGUID: N8c3r/eIRSaa4HjMQwZx0g==
X-CSE-MsgGUID: n5cPS0uWTAanF4sA5a1CHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63134815"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63134815"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 12:39:40 -0700
X-CSE-ConnectionGUID: f2VFH6p4QSS41LQ8JPt06g==
X-CSE-MsgGUID: 2AGvUH8MQj+9jbyOus63oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184168230"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 12:39:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC19q-000DoX-35;
	Thu, 23 Oct 2025 19:39:34 +0000
Date: Fri, 24 Oct 2025 03:38:35 +0800
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
Message-ID: <202510240310.WujwpVmw-lkp@intel.com>
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
config: i386-randconfig-014-20251023 (https://download.01.org/0day-ci/archive/20251024/202510240310.WujwpVmw-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240310.WujwpVmw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240310.WujwpVmw-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__udivmoddi4" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

