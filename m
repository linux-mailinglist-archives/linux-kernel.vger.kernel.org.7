Return-Path: <linux-kernel+bounces-792107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A715B3C038
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443BC7BF585
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8731F0E2E;
	Fri, 29 Aug 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fs9FKQog"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081B207A0B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483512; cv=none; b=Y7lLFZIcSLvGiQ+9wKBpD67WyGbCpNgFGqBpOoBiJ9N2GijHh7/pEdLkRo7p7vz+DTltILMYAzFmH+vW2A0DYap4hMEuGCQdh583y4/O5/tKcTOClVXBvrmCFdBVjPC5nQIBEeCwmTnMfC2WfMROopX54ukBsjcWq0Emi+pfXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483512; c=relaxed/simple;
	bh=7UM0FD0nPpb3mzbygjK+kjr6bv55vtEB+0Pk2c00m+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a158+3thRei9SMQGdGTd2tWwQ9YTeOqaJixm1c7C0+XUApqj7s5oIrGDEyx7edvYffMNN5lbC2oDGP5vj85AP+pBjYskLpM3/+OjkjPbFWHSdTD0PmuEVHyHiexVrutqKsH/XkJ3w8P6M4PvGy6zByPWX8EyHqnfqm5qEJZD9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fs9FKQog; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756483511; x=1788019511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7UM0FD0nPpb3mzbygjK+kjr6bv55vtEB+0Pk2c00m+8=;
  b=fs9FKQogyZxX81X1w8mGF1LlDzFzt1yJ8fpcjJvzMBS1V8SfHkXNqhID
   0FScHRWe/TWy40uW875K9ebvMip/NDcfJIQT/WOTF85fCi1Y9WofLOYBU
   AQTzo2lMv1XIuqCp4qhhXUK4TbVdzLY2glcg2+sY+T3cqFJephk1YBaDv
   GtVJaXxpI90v0y6BEj1oUXi/2iV1MWPf5UmS4aUPzgo9gVgIarlVw+Ess
   ldzG8KDo5y2UvIXEAeVrkP78BxJoRoNc8/GwNvu/4X9x/pJedY0tyPOFQ
   kEtZ8W4ROlGbuzrDBNG0dBDWGOM1AtJ1aOfzMYgCczFshDYF1qivAA0bd
   g==;
X-CSE-ConnectionGUID: Efp63oKSShSpAJ8tFwcgEw==
X-CSE-MsgGUID: 9yfz1mv4Rdyds7Tm7Dj5pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69480932"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69480932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 09:05:10 -0700
X-CSE-ConnectionGUID: nlaYczmlS6aMQdFdavZzMA==
X-CSE-MsgGUID: 2sxxk3dQTnu2wxoDNOnMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170312745"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 29 Aug 2025 09:05:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us1aO-000UkF-25;
	Fri, 29 Aug 2025 16:04:32 +0000
Date: Sat, 30 Aug 2025 00:03:23 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_LDB
Message-ID: <202508292352.89QRqWdm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07d9df80082b8d1f37e05658371b087cb6738770
commit: f673055a46784ccea04465b9213e999f7bc5187e drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
date:   11 months ago
config: x86_64-kismet-CONFIG_DRM_BRIDGE_CONNECTOR-CONFIG_DRM_IMX_LDB-0-0 (https://download.01.org/0day-ci/archive/20250829/202508292352.89QRqWdm-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250829/202508292352.89QRqWdm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508292352.89QRqWdm-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_LDB
   WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_DISPLAY_HELPER [=n]
     Selected by [y]:
     - DRM_IMX_LDB [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_IMX [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

