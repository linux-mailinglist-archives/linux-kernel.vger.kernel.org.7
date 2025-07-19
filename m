Return-Path: <linux-kernel+bounces-737923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91513B0B1F5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C86AA4435
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A792264B7;
	Sat, 19 Jul 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGFGg6G6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB6148838
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752960549; cv=none; b=mlLa9k9RREMSbB3IK5mpByyvBngQ5Mf+oPLH3BOIqgwClL6hNssVTAT37aSCkg7JutBLnVqxlf0Jin4eFc4wYBoRGH9lyQ/NuWO4wrL5CK4yltCT78ZjFB1fbIl8tAAoJmEtyGfA97p1pABKI3pfH3Bs8rLXik1rjxqtwUwdoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752960549; c=relaxed/simple;
	bh=S+IAogN4RSr4qVuiZ51VRNqMJuK8sEvXC5Of2Dn9YK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6CjGQ93ujOg/odOHXwoEY/jQgNuZY64jNuTP8d0nAboN6nVkeosBFdj/AOiGKfMTFCZMn6LZ6wj5jvMMSyyEHQV2/16aK89leI4KVDz6kSme3n7mlx10yzYPNwbUOc3hoD8f2s7XxXBBPN8TMvWXfTFtTh3kNX6k2fn304HJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGFGg6G6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752960546; x=1784496546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S+IAogN4RSr4qVuiZ51VRNqMJuK8sEvXC5Of2Dn9YK8=;
  b=VGFGg6G6qtKGixNFNy4bXfF1mDwXHlC4pHcO5aUrFhYHCpd+iBvf1Usx
   xHPQS6ok7/NCnJa6qBq5H1JfbYjgGFlGZFkpf5xrSZY8wq1eC/6VLqM6B
   XiV44Vs69/IZXWT9S1L8QfF4WyAFMMRS05YPoQVe5g48YWlF24wDiTrYL
   IUXoE/P3xSY4aHZDXdWCg7gEjxFXL/go96kSZ6P5cHFoBuJ9ZR0tNf7jc
   lzCmxiFN0CMvD3XMM7nMN+9g4W3WckYxQegcsj3iRu+XR63wLwBgIl2ov
   bBQ0xgr73wRa2aHmmt1sILgN3SbHn7CSNbx/CLCbEedzbbwrzatnGwSi7
   g==;
X-CSE-ConnectionGUID: E4u1Xv5sSbCs0TPmNypr6Q==
X-CSE-MsgGUID: rfTe3443TvSxgkvpRi21cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="66570231"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="66570231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 14:29:05 -0700
X-CSE-ConnectionGUID: BGXElBXgRTCAEG1ImpsmqA==
X-CSE-MsgGUID: EOvTOH1PR6ihuaTKCY7RAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="195575550"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jul 2025 14:29:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udF77-000FnN-0m;
	Sat, 19 Jul 2025 21:29:01 +0000
Date: Sun, 20 Jul 2025 05:28:43 +0800
From: kernel test robot <lkp@intel.com>
To: jeff_chang@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, jeff_chang@richtek.com
Subject: Re: [PATCH v2] regulator: rt5133: Add RT5133 PMIC regulator Support
Message-ID: <202507200505.u1UDlUuV-lkp@intel.com>
References: <20250718081052.2685826-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081052.2685826-1-jeff_chang@richtek.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jeff_chang-richtek-com/regulator-rt5133-Add-RT5133-PMIC-regulator-Support/20250718-161216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250718081052.2685826-1-jeff_chang%40richtek.com
patch subject: [PATCH v2] regulator: rt5133: Add RT5133 PMIC regulator Support
config: alpha-kismet-CONFIG_MFD_STMFX-CONFIG_PINCTRL_STMFX-0-0 (https://download.01.org/0day-ci/archive/20250720/202507200505.u1UDlUuV-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250720/202507200505.u1UDlUuV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507200505.u1UDlUuV-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_STMFX when selected by PINCTRL_STMFX
   WARNING: unmet direct dependencies detected for OF_GPIO
     Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
     Selected by [y]:
     - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y]
   
   WARNING: unmet direct dependencies detected for MFD_STMFX
     Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
     Selected by [y]:
     - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && OF_GPIO [=y]
   
   WARNING: unmet direct dependencies detected for GPIO_SYSCON
     Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF [=n]
     Selected by [y]:
     - GPIO_SAMA5D2_PIOBU [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF_GPIO [=y] && (ARCH_AT91 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

