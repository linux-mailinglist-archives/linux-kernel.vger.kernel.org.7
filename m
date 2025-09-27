Return-Path: <linux-kernel+bounces-834877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD79BA5BAC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680837A149A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C332D5940;
	Sat, 27 Sep 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ac2tqydS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51C2D0C98
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963518; cv=none; b=pOSceVH58kM+CaKNkjo2DHBQ/iWYb3mcDhP8amEYHB7P9G5hWxHbMv0gEKDd6K0DeS0kLOR/PUJmVE3kStnz0zek8aAAGewopaIqrHc8+uzl+oxra7k37GBf8AGZrY4+UokKiccddVZmAL3PxTST6SLjVPBJk4vyrcitRuQaOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963518; c=relaxed/simple;
	bh=WMH3ygkCBAtii44YH3MNF9ofM2L+4E5AFh5PlGQA3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvSAEAlfTVPgRXbU4TJYL9l1Xwt9EN3Aqu7GhWo11xzmUruk5ZujOB4PStloVDGLyR2zqC7l/HJpOgj69hixraiqx14Uh2yF0r0K/vPMQypl7VLXMhxI5zvdX8bxF72I7W/NvddP8/RHRMyY2+qSGWne4tngWBKxAa0jCQtf8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ac2tqydS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758963516; x=1790499516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMH3ygkCBAtii44YH3MNF9ofM2L+4E5AFh5PlGQA3vw=;
  b=ac2tqydSjtdKbrMLX0Dy3L7U6veMNdXzEUTFxV1M3ePxeM5w4ZPmiKsc
   5RUDVgjmSYIcY4N/P1ZO0HbhkZaapGXcycPDqHvF78/vex+TZQe+lkz1m
   CQ6Z0nOHc59RtFZpZngVc/lNf05GM6Q4jsj2o3i/JpVZJ9J3M1HjqGVcQ
   C1M6736Styseeja8DKORd5/xGxlBbZhK1uPV6YrQuxfJWkTVky+nOylu+
   hoXUat254Ty36PozGyTztg+4+g0qXH28VHrzjpGvVwcPEtWyFyKETF71g
   ZVshkSUAyyPr3b7jL6xkZ80cdiHR0KvHaAYu2oKpRZQYrTTFTYob1P0vU
   g==;
X-CSE-ConnectionGUID: XMuJcGn3To64EKiNu1/FJg==
X-CSE-MsgGUID: TKRHU7XvRkuuRdn59J+Nkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61201728"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="61201728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 01:58:35 -0700
X-CSE-ConnectionGUID: wH7uek+oTtW/y7uWKmqwzw==
X-CSE-MsgGUID: 3OVluKQxQPeA5vADnYvXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="177850187"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2025 01:58:31 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2QlA-0006vj-0Y;
	Sat, 27 Sep 2025 08:58:28 +0000
Date: Sat, 27 Sep 2025 16:58:00 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Hui Pu <Hui.Pu@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v2 1/2] drm/bridge: add drm_bridge_unplug() and
 drm_bridge_enter/exit()
Message-ID: <202509271654.j3IsjsAJ-lkp@intel.com>
References: <20250926-drm-bridge-atomic-vs-remove-v2-1-69f7d5ca1a92@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-drm-bridge-atomic-vs-remove-v2-1-69f7d5ca1a92@bootlin.com>

Hi Luca,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7acbe30813f04cccf7b2e8b571eb7936cfec0a87]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Ceresoli/drm-bridge-add-drm_bridge_unplug-and-drm_bridge_enter-exit/20250927-003721
base:   7acbe30813f04cccf7b2e8b571eb7936cfec0a87
patch link:    https://lore.kernel.org/r/20250926-drm-bridge-atomic-vs-remove-v2-1-69f7d5ca1a92%40bootlin.com
patch subject: [PATCH v2 1/2] drm/bridge: add drm_bridge_unplug() and drm_bridge_enter/exit()
config: x86_64-buildonly-randconfig-002-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271654.j3IsjsAJ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271654.j3IsjsAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271654.j3IsjsAJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_bridge.c:218 function parameter 'bridge' not described in 'drm_bridge_enter'
>> Warning: drivers/gpu/drm/drm_bridge.c:253 function parameter 'bridge' not described in 'drm_bridge_unplug'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

