Return-Path: <linux-kernel+bounces-748629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A03B143E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4235318C0488
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B2274B5E;
	Mon, 28 Jul 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYkmGxe7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EA21D3DC;
	Mon, 28 Jul 2025 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738486; cv=none; b=EybjF2JHZqbypixEGBTWHnTzBZQrzDs2psLDCRW5M54EsOgN/fEk22D4sK/XMtKYmHvMkv2H3uJU0L0AvzlxJeFWdxp01uWFIOrXKLqWjF7XGQpIy9c6meoMaQVvFzX8dXlI3Ux6OPpdvd/YAAEoDaDFi0pOW5FTq6xVNCWyglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738486; c=relaxed/simple;
	bh=09+3cj/H9xhQx1h5p2k3oDYMaYndL8xtT5K4eP4BUYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzuR5a1p0GNwOk1WBU9UOlnMwpk38Xa6DCVD89o3/NmQo7LWS3MjdD1cOp9VeHS1L4SFDiKuGtHPHx7QkYGiuC9nmGm8MW/+aRzTJHgcmHO4FmDaQv+yAYOWXARGhzx8NkcWJpLvlPWr1Wavj02BBov/EFXAX+lvsn76GSiy0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYkmGxe7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753738485; x=1785274485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09+3cj/H9xhQx1h5p2k3oDYMaYndL8xtT5K4eP4BUYk=;
  b=SYkmGxe7N6i3OYlO0qGjCQnmagIqeIbPEtcESHNNF/QiNhbdMnKd5VJA
   uFYiPA96MKlRZMl1C8zwn1+28jPY+W2wWkg8xLphvrFN4sdVrHAjhKopQ
   +cKNzv8ptYSTkzlFPtrU663l5HygA/GVH0UbiHNhsFQLPC/BeLWugBabU
   ayK/b3YYke2emCOyw2oltcTvSnR8Vj21XJf53wWGv6dzzQZbp6uowdgfd
   HvaFSHOkD3QpBEAwu2bWkMQp1fxKu3YgP2O2pxS072wxyanx0R7EAE4UA
   7F1WtrXIYGaEIP1fp6jruXsCPddbvWXcKO+Ru9vr4QLF9ZbIYLEggDULg
   g==;
X-CSE-ConnectionGUID: 9beFoTmuTeyYjDyk5v229Q==
X-CSE-MsgGUID: L2ZQwI+bTdOpNMj3UFr9ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56148105"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56148105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 14:34:45 -0700
X-CSE-ConnectionGUID: UYXoobVVS/GdHlEUFIp9Jw==
X-CSE-MsgGUID: 5gsvI4JQRSq1dyoN3+FwYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162391619"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 14:34:42 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugVUV-0000m7-1i;
	Mon, 28 Jul 2025 21:34:39 +0000
Date: Tue, 29 Jul 2025 05:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507290516.RaQHv1WD-lkp@intel.com>
References: <20250726204041.516440-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726204041.516440-2-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-PWM-Fan-HWMON-Interface/20250727-044332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250726204041.516440-2-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: i386-randconfig-061-20250728 (https://download.01.org/0day-ci/archive/20250729/202507290516.RaQHv1WD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290516.RaQHv1WD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290516.RaQHv1WD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/ayn-ec.c:67:5: sparse: sparse: symbol 'ayn_pwm_curve_registers' was not declared. Should it be static?

vim +/ayn_pwm_curve_registers +67 drivers/platform/x86/ayn-ec.c

    66	
  > 67	int ayn_pwm_curve_registers[10] = {
    68		AYN_SENSOR_PWM_FAN_SPEED_1_REG,
    69		AYN_SENSOR_PWM_FAN_SPEED_2_REG,
    70		AYN_SENSOR_PWM_FAN_SPEED_3_REG,
    71		AYN_SENSOR_PWM_FAN_SPEED_4_REG,
    72		AYN_SENSOR_PWM_FAN_SPEED_5_REG,
    73		AYN_SENSOR_PWM_FAN_TEMP_1_REG,
    74		AYN_SENSOR_PWM_FAN_TEMP_2_REG,
    75		AYN_SENSOR_PWM_FAN_TEMP_3_REG,
    76		AYN_SENSOR_PWM_FAN_TEMP_4_REG,
    77		AYN_SENSOR_PWM_FAN_TEMP_5_REG,
    78	};
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

