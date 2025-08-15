Return-Path: <linux-kernel+bounces-770404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61957B27A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3B05647DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBA29AB1B;
	Fri, 15 Aug 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYMv7CWX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721E1553A3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244283; cv=none; b=dMszk0mwxO+yUdVFsFLcasTnP29pvdeKsmKy05yD7Do0wsQBoGQrWCMCNexIlvIa7ndouXCjK3AqyHLjArJMqhk9ZdY5evfXkfduarfIT4LeTYcG1wFqbp1wcHk3rskXZ2nSh4LkNLdELBYQs/QkOfoSR3sWK72Ql/130lC59/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244283; c=relaxed/simple;
	bh=yCi0y5C1AdrH8qfRQCZ8ewKN8DVm8Tax3hNTKd/guSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iql5Cv1/5mA5wGxKNF0GAgpNHti6TndkBNTk94pJeTW9S1CH4j/Y/D1GINMMizD1x5dEEnU1jPKi24huL1lK8U4VOr+VEWtGptINd84FlDfOb72da7Uaa2V2fJswoTBnLbIyUGylJLWCOQ98BxPOE2Lmzj7+ATIoWBMQVAM9BCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYMv7CWX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755244282; x=1786780282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yCi0y5C1AdrH8qfRQCZ8ewKN8DVm8Tax3hNTKd/guSU=;
  b=YYMv7CWX6Ui7NLiurhaiXaiJMo/m9h0si1ALkcicBRCeMM+bq29jyiiJ
   7PmPtaVl6K9ToWmUx3J+EcFtd87HSAjmHCOPvCp0vQan1yeoJSaU6mfkb
   sHPsOv2VpcBxvgu5WXbfLYO8AxviHwNG4ihJa7YtJsQ6HBWxJKHO3Rxg3
   fwToH3rZtmihJNc19dLLoFYIvKZ45aVlDYsFgJMC+GRkFR8nhO3zpjaHg
   7VLUzUH14IfrhmTsefSWNMp8XN9ibPAaA+KHmRh8UiqpPrQNe63GST9Vn
   DTnpK1QX89SFv4tRn7H7Z2FUulCHnd1rt6Py2qMZ8GrpiO2raBFdPuxGp
   Q==;
X-CSE-ConnectionGUID: w9YSAY4bR66CG4y4qrvUTg==
X-CSE-MsgGUID: DqgCrNJPS1qYPSJbn/qJOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57677826"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57677826"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:51:22 -0700
X-CSE-ConnectionGUID: q2JjhX4qQi2cu0HJNAThTg==
X-CSE-MsgGUID: pr+ZKuM9Rdi8YhY8yF1lIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166173849"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 00:51:20 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umpDZ-000BhU-1R;
	Fri, 15 Aug 2025 07:51:17 +0000
Date: Fri, 15 Aug 2025 15:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: kismet: WARNING: unmet direct dependencies detected for I2C_GPIO
 when selected by VIDEO_MMP_CAMERA
Message-ID: <202508151548.USSyv44H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7ee5bdce7892643409dea7266c34977e651b479
commit: 1eb07e99ef39808612e12edaac6ef10f27485a27 arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
date:   5 weeks ago
config: arm64-kismet-CONFIG_I2C_GPIO-CONFIG_VIDEO_MMP_CAMERA-0-0 (https://download.01.org/0day-ci/archive/20250815/202508151548.USSyv44H-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250815/202508151548.USSyv44H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151548.USSyv44H-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for I2C_GPIO when selected by VIDEO_MMP_CAMERA
   WARNING: unmet direct dependencies detected for I2C_GPIO
     Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (GPIOLIB [=n] || COMPILE_TEST [=n])
     Selected by [y]:
     - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=n]) && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

