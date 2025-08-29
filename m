Return-Path: <linux-kernel+bounces-792315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401AB3C298
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68207BF197
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233A3451D5;
	Fri, 29 Aug 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5hwzzeW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF73375DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492784; cv=none; b=C4SeYAZuOZCI7OI8HjaBo01Qrg0H4XzI0xpqy5PPCNA1UE0Q5CVuGZTI8x1qBr62hw+xgY1SOxVeTyR06aaDqcop3yqKXM93HXdyi4Iisxk72pDrTa4qM48JR7FSjHtWJsOuBKOfCsYajSn7NMpEuKSR0GokFQJXrJO+2iriFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492784; c=relaxed/simple;
	bh=iT4hRDR5NEQHZtSnWoUmsw/1UWPAvlvxFGwEgY18EQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EWsBcC4U5/ZfFYSS1cO8SbLqUNQkruWwI0Tv+SCwO32+lVivKUeJdiHlwdma+l35tHf+boZ9VznAGSy5vaRGzohA/WjlVd4ss3IZz/cT5E+yICaCSVOFn7AJqQ199/2gx+Oh1Li0C/PuEUcZExDIU2hOIZiVZ624iE5WtDJwKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5hwzzeW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756492783; x=1788028783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iT4hRDR5NEQHZtSnWoUmsw/1UWPAvlvxFGwEgY18EQ4=;
  b=O5hwzzeWIGFZaEHvvtmRPIm1VKU5YMdGxf3aIaL5vvgHSAZb2RGo7jgK
   1pid8003Xby5fpKPovKjOV6wuAn4YjJCKF2VavscmTZ50HBcLIADIFHU5
   Xp9rZfEHo8/TenQDnyHlyP37+XF7QxAL94jVg9IQEdc0L3JiKgBoK6Anr
   lWWvByN8VwJmvWUazM42mATQdvygZwFDwgnJ+I0FMMEmOK6kN3ty89Da/
   nfDm0xIzxlYEL6F6+E7i9w8YasEZ+alkcQn2NWMieun4sTyxA3/GhgpRo
   oOPIlDB602xtMTxa7S4X1xlVgDixIBBTq7NW7IviVK/eFB47E796QWlYz
   Q==;
X-CSE-ConnectionGUID: lWmglM3VRVKc8Z4E3LWdAA==
X-CSE-MsgGUID: lZo2EURxQZmmRTXdNzdctQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69494944"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69494944"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 11:39:42 -0700
X-CSE-ConnectionGUID: G6M+TpvES2aDFGWzTmLtqg==
X-CSE-MsgGUID: ZB1NvdeAQTiXQqjZkOkEAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174814305"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 29 Aug 2025 11:39:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us40V-000UsR-1E;
	Fri, 29 Aug 2025 18:39:31 +0000
Date: Sat, 30 Aug 2025 02:39:25 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_PARALLEL_DISPLAY
Message-ID: <202508300242.0G74ljn8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb679c832b6497f19fffb8274c419783909c0912
commit: f673055a46784ccea04465b9213e999f7bc5187e drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
date:   11 months ago
config: x86_64-kismet-CONFIG_DRM_BRIDGE_CONNECTOR-CONFIG_DRM_IMX_PARALLEL_DISPLAY-0-0 (https://download.01.org/0day-ci/archive/20250830/202508300242.0G74ljn8-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250830/202508300242.0G74ljn8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300242.0G74ljn8-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_PARALLEL_DISPLAY
   WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_DISPLAY_HELPER [=n]
     Selected by [y]:
     - DRM_IMX_PARALLEL_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_IMX [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

