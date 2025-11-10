Return-Path: <linux-kernel+bounces-892984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF0C46456
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0EC3A6D98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82FD30AACB;
	Mon, 10 Nov 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noVYNl7Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED81D7E41;
	Mon, 10 Nov 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774239; cv=none; b=nYeKISX6buDCfGFjt1a4otoB2S+JNEkGissOh+fUImr6pg9ghgRWMwzz6SW1GuyYM5qB9soJYK81cbVE9o8GGViWRHccYJzGTvIqtbewhlJVHmGAR3Akqqbzzh/jr7CjEI4ULIApsbOPkwMXiAkozTUwIPOiJZnnzP73HDAGbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774239; c=relaxed/simple;
	bh=LGfNnwD/weg7hFUalWkhbY8vT84PU5rfjzkafeFhtu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMvsTYERPXspfKKtr0g5XIij76uvpqgLgUJdc2zCgC3pdyiATO9rslCGXKhQ+Rg50kq8p8A+y0xQVWMbtuOhOxfT8S+/9vF7HVv5R+9yaJaVhpGNAAzmQlK1/0vbwnLPEMTx94JwMTNwzwKNNfmBcAIPqU3MdtEWFpdPt3W5h9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noVYNl7Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774238; x=1794310238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGfNnwD/weg7hFUalWkhbY8vT84PU5rfjzkafeFhtu4=;
  b=noVYNl7Qwu87W7kf1DbUS7ieSiaL+OxYduzLUrj1Gags2w2tSLljQNM+
   dDznxz2hMsSdG2aaFNVzgZMfE2KOJWE9Gp+bwd8lqnlXLsEsOeSSn14RY
   x6eL6pwy8xyg2rlsNhdiZw8JHYocunRpvUM3bhgevvD17bn3hwP4IiVLF
   2p9cvFvtGOE+JgOBp+e7cU+OiBHOCbi5ncei7pJCEJE/dKEmAm+gfU7Co
   lco7yP6dg5HWrnAe+d8s3hmuDZs9qA7rns0ryN+lehMz5IfHPXFtDJ1On
   NL6qN8nyHjz+COtdfr7WcVKAxBbKGEUAD33q/RHKLECp+05Bzw2/xfCbc
   Q==;
X-CSE-ConnectionGUID: apiKMVMlSW28exSob0Ws8A==
X-CSE-MsgGUID: 1JU15bnUQdq2F2teXXTS1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64977655"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64977655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:30:38 -0800
X-CSE-ConnectionGUID: XYTUUqmxSIiAF3qeeyiawg==
X-CSE-MsgGUID: /VNA7VkEQNCz1fIg1MqD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="212047006"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2025 03:30:34 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIQ6S-0000LJ-13;
	Mon, 10 Nov 2025 11:30:32 +0000
Date: Mon, 10 Nov 2025 19:29:57 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Kemnade <andreas@kemnade.info>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 3/3] regulator: Add FP9931/JD9930 driver
Message-ID: <202511101911.sdETGGNC-lkp@intel.com>
References: <20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/dt-bindings-vendor-prefixes-Add-Fitipower/20251108-040835
base:   dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
patch link:    https://lore.kernel.org/r/20251107-fp9931-submit-v1-3-aa7b79d9abb6%40kemnade.info
patch subject: [PATCH 3/3] regulator: Add FP9931/JD9930 driver
config: mips-randconfig-r134-20251110 (https://download.01.org/0day-ci/archive/20251110/202511101911.sdETGGNC-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d445cba39f4dd3dcda4fa1433eca825cf8fc09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101911.sdETGGNC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101911.sdETGGNC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/regulator/fp9931.c:402:18: sparse: sparse: Initializer entry defined twice
   drivers/regulator/fp9931.c:409:18: sparse:   also defined here

vim +402 drivers/regulator/fp9931.c

   398	
   399	static const struct regulator_desc regulators[] = {
   400		{
   401			.name = "V3P3",
 > 402			.of_match = of_match_ptr("V3P3"),
   403			.id = 0,
   404			.ops = &fp9931_v3p3ops,
   405			.type = REGULATOR_VOLTAGE,
   406			.owner = THIS_MODULE,
   407			.enable_reg = FP9931_REG_CONTROL_REG1,
   408			.enable_mask = BIT(1),
   409			.of_match = of_match_ptr("v3p3"),
   410			.n_voltages = 1,
   411			.min_uV = 3300000
   412		},
   413		{
   414			.name = "VPOSNEG",
   415			.of_match = of_match_ptr("VPOSNEG"),
   416			.id = 1,
   417			.ops = &fp9931_vposneg_ops,
   418			.type = REGULATOR_VOLTAGE,
   419			.owner = THIS_MODULE,
   420			.n_voltages = ARRAY_SIZE(VPOSNEG_table),
   421			.vsel_reg = FP9931_REG_VPOSNEG_SETTING,
   422			.vsel_mask = 0x3F,
   423			.volt_table = VPOSNEG_table,
   424		},
   425		{
   426			.name = "VCOM",
   427			.of_match = of_match_ptr("VCOM"),
   428			.id = 2,
   429			.ops = &fp9931_vcom_ops,
   430			.type = REGULATOR_VOLTAGE,
   431			.owner = THIS_MODULE,
   432			.n_voltages = 255,
   433			.min_uV = 0,
   434			.uV_step = 5000000 / 255,
   435			.vsel_reg = FP9931_REG_VCOM_SETTING,
   436			.vsel_mask = 0xFF
   437		},
   438	};
   439	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

