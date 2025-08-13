Return-Path: <linux-kernel+bounces-766152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18FB242EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0433A37AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA402D6E46;
	Wed, 13 Aug 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lG29F3jJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284C2D238C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070823; cv=none; b=p5aSfTBQISkH9bYbExVDG/c2joyXLS1Jc4PSCMe859Bu7Vs9r9NKJ/dOEUPglg1Y+xzMflUoG5Vpy6KM0btvqI1Ps0G4Db7vc0Z1ixzInfI5YeH/xHQ884b1DhRtkKBe4GFUMbXmvGheNCdC4gZXBu6ECBDjPupO46myuxdegbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070823; c=relaxed/simple;
	bh=WKYPMchJPeoCGBpYS0+31pC4PeqRcgJxD/lMF5bIcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fam5n8VwSK7VQjNbnUZGtTArEc9k+2m1mAQTwxG9q6KfUz+ptWGkghzriNCYnVKG8JJKe/lekPvlfg3T6gS0D0vtNRqNjjxJBLys8MQoSGOmn/f23Vk5oZTfYg0Y4V5OzPBCahgTewXPQljIesAddCM3moCBwidpSqTYiEXOGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lG29F3jJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070823; x=1786606823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKYPMchJPeoCGBpYS0+31pC4PeqRcgJxD/lMF5bIcDQ=;
  b=lG29F3jJu0WOltdmqdyEy3G1mpFBBX0Cnm2w5EzSrnqr/EzfoU9JinQI
   9rP0xkiF9TxoJQwfrR8ypR+l7DjMxXLg+v48m3GnvSGQF7JuBTVsV7eEN
   IBcAnk1OWkK4ELUaHM++MUGjyUsRjvXrQC8ndJGFR3fKTNIwOXNPVSqR0
   Z8RYA5fQHKYkyc8PlorOkP9cDeIah3ODEYJNlpuicyISAkxGjt6RJQ9DK
   KFIQV7p4yCE96wmhrevjKKuMSm/oUbhzDDHsYVCPFYr7aamSfWIWJDMUC
   AAPuuNlEWzc0KfCwJ7q4S5BDYQ12eVXAhwFeoXwvLj4NhwY3d90iz4izD
   g==;
X-CSE-ConnectionGUID: jzGdju+sRCaKkAZUyhkNAw==
X-CSE-MsgGUID: rc3YnGvCTM24wfgwuvuJiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74934940"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74934940"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:40:21 -0700
X-CSE-ConnectionGUID: a9L3jeQlQIyyqEIAKPsWQQ==
X-CSE-MsgGUID: Ip2e9YrPR3mWL1IxZlg4ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170540055"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 13 Aug 2025 00:40:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um65n-0009fw-1C;
	Wed, 13 Aug 2025 07:40:15 +0000
Date: Wed, 13 Aug 2025 15:39:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Mike Looijmans <mike.looijmans@topic.nl>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
Message-ID: <202508131549.DaogZRF9-lkp@intel.com>
References: <20250812145256.135645-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812145256.135645-3-mike.looijmans@topic.nl>

Hi Mike,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 53e760d8949895390e256e723e7ee46618310361]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Looijmans/dt-bindings-drm-bridge-ti-tmds181-Add-TI-TMDS181-and-SN65DP159-bindings/20250812-225413
base:   53e760d8949895390e256e723e7ee46618310361
patch link:    https://lore.kernel.org/r/20250812145256.135645-3-mike.looijmans%40topic.nl
patch subject: [PATCH 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250813/202508131549.DaogZRF9-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508131549.DaogZRF9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131549.DaogZRF9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/ti-tmds181.c:273:41: warning: initializer-string for character array is too long, array size is 8 but initializer has size 9 (including the null terminating character); did you mean to use the 'nonstring' attribute? [-Wunterminated-string-initialization]
     273 | static const u8 tmds181_id_tmds181[8] = "TMDS181 ";
         |                                         ^~~~~~~~~~
   drivers/gpu/drm/bridge/ti-tmds181.c:274:41: warning: initializer-string for character array is too long, array size is 8 but initializer has size 9 (including the null terminating character); did you mean to use the 'nonstring' attribute? [-Wunterminated-string-initialization]
     274 | static const u8 tmds181_id_dp159[8]   = "DP159   ";
         |                                         ^~~~~~~~~~
   2 warnings generated.


vim +/nonstring +273 drivers/gpu/drm/bridge/ti-tmds181.c

   272	
 > 273	static const u8 tmds181_id_tmds181[8] = "TMDS181 ";
   274	static const u8 tmds181_id_dp159[8]   = "DP159   ";
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

