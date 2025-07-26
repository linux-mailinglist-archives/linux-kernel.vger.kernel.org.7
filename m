Return-Path: <linux-kernel+bounces-746789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E710B12B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC37A7457
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FB21ABA4;
	Sat, 26 Jul 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEWO2ZFT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919E1E2838;
	Sat, 26 Jul 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544100; cv=none; b=JQ6EJtwGIpgq+4OZOdI5gOeByHdA4DL0RiSQ+UL5019SixLrk9fpqcOrB7PtLF5T4X5I5FFeFgVNUy3Zku6jI/Vz1LUi4B7Me4n56fHPO/Dt9PKnrWmzbmdCgyGPGz+0H47R74KyFber2CrmQ2v+sMertQSLSSUR0N/th7O9rnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544100; c=relaxed/simple;
	bh=xY9+wPXn1/lg9kag6B/JWHLkOJaNNB7YX2ktYzlQODc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0u6zwpiRL8nRBqhOhdh4EM3UHhzVU0YfTvbQ4S+fULez6dO3NYG3twxUlqmw5L5/pJI6fzWrng+nBYjC1j/7TxSJLNzVS1UVSA7Wh/cnT+rLdqzxKFiDz3suQYap+jcFWsan4owKOM3U337Zp9LFeqIwQc5EJEGWyvEktLDMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEWO2ZFT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753544097; x=1785080097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xY9+wPXn1/lg9kag6B/JWHLkOJaNNB7YX2ktYzlQODc=;
  b=jEWO2ZFT7zpzN6Mf8GZxDKVzRzILuFjlwl4baGMi3EXiebaD6R/1WGa5
   fa6dh/W2HAgEHsTlMdzRNhcV9otQSE0uX5L7pc1AABM0aUCLq/lkrPOfv
   AdXfq3/2ydekhhnhNR5srID5+ot9e0qfymd0s+0YD0SloAXPXLBDjFhhH
   bHgJMqS2P+z5ZGTTxIjn3SE03nzAM1gqE3lCPPOCaRU3WeTV4r/yll7+P
   UTtnHn7oJpz8oSSZBhbvnbDSZVzZTjBiMs7LLTjBxddeGpxbyf+hDbGqK
   cgUD0xnm3uijr/VNyiOGmcH0iQRnWkNqatE2nZme9rcnHKRuruMUtpkfw
   Q==;
X-CSE-ConnectionGUID: Z5VpLWx5Qjarm6GIYPngFg==
X-CSE-MsgGUID: GkcBWkcpSwWGpuNLAOJONA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55065317"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55065317"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:34:57 -0700
X-CSE-ConnectionGUID: L3ULkAalT3K8GoBPRFNcCQ==
X-CSE-MsgGUID: YCrCAQXgQi6E8SILg2A9Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161257276"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jul 2025 08:34:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufgvD-000M4R-2z;
	Sat, 26 Jul 2025 15:34:51 +0000
Date: Sat, 26 Jul 2025 23:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507262209.8s76hPFo-lkp@intel.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-Temperature-Sensors/20250725-084850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250725004533.63537-1-derekjohn.clark%40gmail.com
patch subject: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: i386-kismet-CONFIG_LEDS_GPIO-CONFIG_MERAKI_MX100-0-0 (https://download.01.org/0day-ci/archive/20250726/202507262209.8s76hPFo-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250726/202507262209.8s76hPFo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507262209.8s76hPFo-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_GPIO when selected by MERAKI_MX100
   WARNING: unmet direct dependencies detected for LEDS_CLASS
     Depends on [n]: NEW_LEDS [=n]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]
   
   WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
     Selected by [y]:
     - AYN_EC [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && HWMON [=y]
   
   WARNING: unmet direct dependencies detected for LEDS_GPIO
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
     Selected by [y]:
     - MERAKI_MX100 [=y] && X86_PLATFORM_DEVICES [=y] && GPIOLIB [=y] && GPIO_ICH [=y] && LEDS_CLASS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

