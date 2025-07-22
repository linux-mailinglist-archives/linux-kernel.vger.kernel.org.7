Return-Path: <linux-kernel+bounces-740647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3FB0D736
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238B53A6A18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827E2E0917;
	Tue, 22 Jul 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Czb51UGD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A521FF28;
	Tue, 22 Jul 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179588; cv=none; b=HWCPY9RrVTnUQEjSItMVfNRnArccUt6sZjc+XvFUSKrgwUg9NkeI21YBNH+FZ36V4aUp6HMQsp7o+N51cfyZDrSoAzBs8ph11mxlyMnpmPlwFt4sfHnMcURmT7ce+U6U3Xap2b79ofcxXhTI9r/CHlCb9y4DrVUgGh2PFiy2lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179588; c=relaxed/simple;
	bh=Tz5n3cJgHCeCA+szGpMErb/vCpyRhzAIpcTVreqonGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfO+GjVH6NL/53dhBFjvUJH29wR6NkVQs4tbiFckoE8uAfBuApftEtTXHvLfMCyX8y3E2eqguhTpVXq7yEz+ygIu6WxVf66Trkej8YK30DmLQcJo+3Te6wKadISFKStHZfCTbMQWgeke8sScHh42aKI9iHPSp0VeDWDi5aiEAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Czb51UGD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753179587; x=1784715587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tz5n3cJgHCeCA+szGpMErb/vCpyRhzAIpcTVreqonGA=;
  b=Czb51UGDOmZVjlviP0zDnzXjDrqL6SXve5kCNCm8a7ciK8kKI8ZKxmHF
   R9K/KCHoahgw0wJF3uz53/Zj7ix8KE3OrbJXSHiQ2onZkd+azeVqeq1sg
   zmBY+rWhZVV9N3FkfuRMfLzaLI2ll8JTQF0ESCF4KzsL8aB+pd6jiaWZQ
   cCybhRCGVNbMTBp1JhK1tHKsmilj8hTKMyvFRQWqis9zn+UTFWqSsA9K5
   nVnhVVswym950AO7l66C8c+ayyyjSurTZXZU5CSdzww3XGHN2RouYaKIK
   zi4DNLkDbQ3RlJvOOGX5Olrcw5K6k8AZL6cvzHshv3amVlVHL2x2XYkIo
   Q==;
X-CSE-ConnectionGUID: 7Ed90FniS5KTUrCGvILJAQ==
X-CSE-MsgGUID: AdOlF02DQBu6Pnhv8ZVoEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55533094"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55533094"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 03:19:46 -0700
X-CSE-ConnectionGUID: 0IiCCiNSSCaxhbb+aeEcTA==
X-CSE-MsgGUID: TcLhLlinTMm+abtXnqB9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163650163"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Jul 2025 03:19:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueA5z-000HgZ-2a;
	Tue, 22 Jul 2025 10:19:39 +0000
Date: Tue, 22 Jul 2025 18:19:39 +0800
From: kernel test robot <lkp@intel.com>
To: Joy Zou <joy.zou@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] regulator: pf0900: Add PMIC PF0900 support
Message-ID: <202507221720.jxsGRfcE-lkp@intel.com>
References: <20250721-b4-pf09-v2-v2-2-e2c568548032@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-b4-pf09-v2-v2-2-e2c568548032@nxp.com>

Hi Joy,

kernel test robot noticed the following build errors:

[auto build test ERROR on d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

url:    https://github.com/intel-lab-lkp/linux/commits/Joy-Zou/dt-bindings-regulator-add-PF0900-regulator-yaml/20250721-151818
base:   d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
patch link:    https://lore.kernel.org/r/20250721-b4-pf09-v2-v2-2-e2c568548032%40nxp.com
patch subject: [PATCH v2 2/2] regulator: pf0900: Add PMIC PF0900 support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250722/202507221720.jxsGRfcE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507221720.jxsGRfcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507221720.jxsGRfcE-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/pf0900-regulator.c: In function 'pf0900_regmap_read':
>> drivers/regulator/pf0900-regulator.c:377:64: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     377 |                 crc = crc8_j1850(pf0900->addr << 1 | 0x1, reg, FIELD_GET(GENMASK(7, 0), *val));
         |                                                                ^~~~~~~~~
   drivers/regulator/pf0900-regulator.c: In function 'pf0900_regmap_write':
>> drivers/regulator/pf0900-regulator.c:416:23: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     416 |                 val = FIELD_PREP(GENMASK(15, 8), data[1]) | data[0];
         |                       ^~~~~~~~~~


vim +/FIELD_GET +377 drivers/regulator/pf0900-regulator.c

   351	
   352	static int pf0900_regmap_read(void *context, unsigned int reg,
   353				      unsigned int *val)
   354	{
   355		struct device *dev = context;
   356		struct i2c_client *i2c = to_i2c_client(dev);
   357		struct pf0900 *pf0900 = dev_get_drvdata(dev);
   358		int ret;
   359		u8 crc;
   360	
   361		if (!pf0900 || !pf0900->dev)
   362			return -EINVAL;
   363	
   364		if (reg >= PF0900_MAX_REGISTER) {
   365			dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
   366			return -EINVAL;
   367		}
   368	
   369		if (pf0900->crc_en) {
   370			ret = i2c_smbus_read_word_data(i2c, reg);
   371			if (ret < 0) {
   372				dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
   373				return ret;
   374			}
   375	
   376			*val = (u16)ret;
 > 377			crc = crc8_j1850(pf0900->addr << 1 | 0x1, reg, FIELD_GET(GENMASK(7, 0), *val));
   378			if (crc != FIELD_GET(GENMASK(15, 8), *val)) {
   379				dev_err(pf0900->dev, "Crc check error!\n");
   380				return -EINVAL;
   381			}
   382			*val = FIELD_GET(GENMASK(7, 0), *val);
   383		} else {
   384			ret = i2c_smbus_read_byte_data(i2c, reg);
   385			if (ret < 0) {
   386				dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
   387				return ret;
   388			}
   389			*val = ret;
   390		}
   391	
   392		return 0;
   393	}
   394	
   395	static int pf0900_regmap_write(void *context, unsigned int reg,
   396				       unsigned int val)
   397	{
   398		struct device *dev = context;
   399		struct i2c_client *i2c = to_i2c_client(dev);
   400		struct pf0900 *pf0900 = dev_get_drvdata(dev);
   401		uint8_t data[2];
   402		int ret;
   403	
   404		if (!pf0900 || !pf0900->dev)
   405			return -EINVAL;
   406	
   407		if (reg >= PF0900_MAX_REGISTER) {
   408			dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
   409			return -EINVAL;
   410		}
   411	
   412		data[0] = val;
   413		if (pf0900->crc_en) {
   414			/* Get CRC */
   415			data[1] = crc8_j1850(pf0900->addr << 1, reg, data[0]);
 > 416			val = FIELD_PREP(GENMASK(15, 8), data[1]) | data[0];
   417			ret = i2c_smbus_write_word_data(i2c, reg, val);
   418		} else {
   419			ret = i2c_smbus_write_byte_data(i2c, reg, data[0]);
   420		}
   421	
   422		if (ret) {
   423			dev_err(pf0900->dev, "Write reg=0x%x error!\n", reg);
   424			return ret;
   425		}
   426	
   427		return 0;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

