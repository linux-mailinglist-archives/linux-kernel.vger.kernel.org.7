Return-Path: <linux-kernel+bounces-737416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0DB0AC3B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3706E7B6682
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C1222593;
	Fri, 18 Jul 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCBlkBe4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264C22157B;
	Fri, 18 Jul 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878470; cv=none; b=KB/5w8gZzhjbqJIxCg2L1vF5MJBB6GewV7WTGPHT0FFFjzA/r1+zmR4ZdFAozOTo3/cuUEU68ERiS7rsWAyPaVT2pXbZyQ2VNKO9Fk67lmPGk57c4MffDJooudWYxBJ70/yEZjeDst5IkJTTrr4QECj3E35WVxGnpTtEUx1Qlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878470; c=relaxed/simple;
	bh=qU06W8zbKrTz5z2CespTGjAICSgUpUohcKCCIZfLFxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB3liP30LlHrh5jphmMQe8sB7vL28GUhQCk58K/riZ72RnklBJuMBEUcN9Lu6o60MXUzIoi6ZmfZAt5gUYoFqnT53NhJ0W/zaDhoX7fQvne/ctHgyRyujbb53/OXMUtcJCImPuS4NO7alWtEKSOygGUUL+yNOO/UF7PQkfPWv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCBlkBe4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752878469; x=1784414469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qU06W8zbKrTz5z2CespTGjAICSgUpUohcKCCIZfLFxs=;
  b=gCBlkBe47SvKQbctfmIt3npiUQbNGwQ2n8VFzfrIAoiL4SxY2RX4yaW2
   3ZVpv2iZwJVU12vf1CG3295QfXscDti3Oa9rjjQBwCO8tG2BJGtHg46tP
   XeWcCJuELQdP7lC4C91rHJY/AcrDWtVKvWj0szfcCsWr8vzL4U+Q1umDo
   cskdxUw236tK7JbwRmC3pMxaLGF+RaneHn4NB56WbWMMaN789kvtUX9zH
   zlsrbk/Tyf8B8y42g7MFG7MZgyz19OENjZH0/OOVrriIvvJT+U6og6YBd
   hZLdpyWIv0IIGi4KkjlJvU03JOxouLS8QQy6im4vBn3UBe8kl9oO2zxpe
   g==;
X-CSE-ConnectionGUID: wb+e6yCKSpuP6QntalYGWw==
X-CSE-MsgGUID: v26nWtbkRVmvtGEAUkKkAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72746511"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="72746511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:41:08 -0700
X-CSE-ConnectionGUID: BRs99GICQ6SC4GIBCtc3iA==
X-CSE-MsgGUID: 82Hah+c3SNKGHmGeFMf0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158373830"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jul 2025 15:41:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uctlF-000F6V-2R;
	Fri, 18 Jul 2025 22:41:01 +0000
Date: Sat, 19 Jul 2025 06:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: Nick <nick.li@foursemi.com>, lgirdwood@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	perex@perex.cz, tiwai@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <202507190618.Gu5xvSUt-lkp@intel.com>
References: <20250718121221.76957-5-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718121221.76957-5-nick.li@foursemi.com>

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ed73a24357531e1747a6e140c329015da6429629]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick/dt-bindings-vendor-prefixes-Add-Shanghai-FourSemi-Semiconductor-Co-Ltd/20250718-201609
base:   ed73a24357531e1747a6e140c329015da6429629
patch link:    https://lore.kernel.org/r/20250718121221.76957-5-nick.li%40foursemi.com
patch subject: [PATCH v3 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
config: i386-buildonly-randconfig-004-20250719 (https://download.01.org/0day-ci/archive/20250719/202507190618.Gu5xvSUt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190618.Gu5xvSUt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507190618.Gu5xvSUt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/fs210x.c:1086:2: warning: variable 'ret' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
    1086 |         default:
         |         ^~~~~~~
   sound/soc/codecs/fs210x.c:1092:9: note: uninitialized use occurs here
    1092 |         return ret;
         |                ^~~
>> sound/soc/codecs/fs210x.c:1077:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1077 |                 if (!fs210x->clk_bclk)
         |                     ^~~~~~~~~~~~~~~~~
   sound/soc/codecs/fs210x.c:1092:9: note: uninitialized use occurs here
    1092 |         return ret;
         |                ^~~
   sound/soc/codecs/fs210x.c:1077:3: note: remove the 'if' if its condition is always false
    1077 |                 if (!fs210x->clk_bclk)
         |                 ^~~~~~~~~~~~~~~~~~~~~~
    1078 |                         break;
         |                         ~~~~~
   sound/soc/codecs/fs210x.c:1062:9: note: initialize the variable 'ret' to silence this warning
    1062 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +/ret +1086 sound/soc/codecs/fs210x.c

  1056	
  1057	static int fs210x_playback_event(struct snd_soc_dapm_widget *w,
  1058					 struct snd_kcontrol *kc, int event)
  1059	{
  1060		struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
  1061		struct fs210x_priv *fs210x = snd_soc_component_get_drvdata(cmpnt);
  1062		int ret;
  1063	
  1064		mutex_lock(&fs210x->lock);
  1065	
  1066		if (fs210x->is_suspended) {
  1067			mutex_unlock(&fs210x->lock);
  1068			return 0;
  1069		}
  1070	
  1071		switch (event) {
  1072		case SND_SOC_DAPM_PRE_PMU:
  1073			/*
  1074			 * If there is no bclk for us to set the clock output,
  1075			 * we will enable the device(start_work) in dai trigger.
  1076			 */
> 1077			if (!fs210x->clk_bclk)
  1078				break;
  1079			fs210x_bclk_set(fs210x, true);
  1080			ret = fs210x_dev_play(fs210x);
  1081			break;
  1082		case SND_SOC_DAPM_POST_PMD:
  1083			ret = fs210x_dev_stop(fs210x);
  1084			fs210x_bclk_set(fs210x, false);
  1085			break;
> 1086		default:
  1087			break;
  1088		}
  1089	
  1090		mutex_unlock(&fs210x->lock);
  1091	
  1092		return ret;
  1093	}
  1094	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

