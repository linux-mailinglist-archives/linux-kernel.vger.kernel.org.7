Return-Path: <linux-kernel+bounces-724126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA2AFEEED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF7E18827D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A521FF23;
	Wed,  9 Jul 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZckHUamg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73521FF28;
	Wed,  9 Jul 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079138; cv=none; b=Hl8gJGBietg1x0f5Y139xv4tqijjBatQId92+8xCpNVIe9ZvsvRafbBerAeJ/dajBGfIGTNpVVpwBwDx7MnhlK72tU+U/+TyMV2O8WSYrxxmTqtlL4z2tGrJvnUXXaaqcRJ5ZGtRV57hA+2ewn1fvhz0KDy0348F6la86Nn5yA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079138; c=relaxed/simple;
	bh=sscLlVLSTqX6Ja4Jl6uAsGtdoJXwQqGex1/xNaJecj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lntX6nCMtXTtuy5F0tJ/XKn+D3usNimi5Oh4SWO1JWtobmdS9cNMZjnCPScmdzWqIfnVHDeklMxyPXhSwilcsLjgAa8YqVvJdLmeERS+h6FDTtlxy+NsrSgv1cbYRMoom9uMeHbs5UR4zaFKf/B/VgSlwt/LJBhivalpp5Ng71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZckHUamg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752079136; x=1783615136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sscLlVLSTqX6Ja4Jl6uAsGtdoJXwQqGex1/xNaJecj8=;
  b=ZckHUamga3SnDxO5PCz+61nE8RotqJ67Nh0mCDZO7/+39rN5flX3oExD
   Oal6WhK4YHDJvfoBRb7DQZmBOLeJQCqn8MN3WCfCrn+w49Kh8aZx/UYeH
   qaAnuVbrZZGhJpfquJVEqpTLb8B9WWMPzQmXeiH9EJth2PsIhYo4jMDE1
   I/HTA4UiQBK1m7lNs7JDmb3rQP744uYTRDJXbiiOBeyL2X7yB9RSvgh6U
   eT+GczIgrS4TnT16o1bD1MGQu7XxgDC35NGx/qkrZtSa9E/sn4GpVh7nj
   odonphuQ8S+BdSVbJoLtjJlU+Cb8Z5vfhDJOMiegrkf8lvJU4XINtJ8Qv
   g==;
X-CSE-ConnectionGUID: dWaPdqxJT1mxOuOagKk+fw==
X-CSE-MsgGUID: iOyNQ9LBREWBZzJh32Lujw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54441017"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54441017"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 09:38:54 -0700
X-CSE-ConnectionGUID: j9qyy7HuTXKiHRMwQfnudw==
X-CSE-MsgGUID: FFKNPH+ST/Wz/xZfw4p7PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155236464"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2025 09:38:52 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZXon-0003lT-13;
	Wed, 09 Jul 2025 16:38:49 +0000
Date: Thu, 10 Jul 2025 00:38:25 +0800
From: kernel test robot <lkp@intel.com>
To: Guoqing Jiang <guoqing.jiang@canonical.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	angelogioacchino.delregno@collabora.com, amergnat@baylibre.com
Cc: oe-kbuild-all@lists.linux.dev, zoran.zhan@mediatek.com,
	guoqing.jiang@canonical.com, linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8365-dai-i2s: pass correct size to
 mt8365_dai_set_priv
Message-ID: <202507100010.qEVMavru-lkp@intel.com>
References: <20250709053900.55171-1-guoqing.jiang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709053900.55171-1-guoqing.jiang@canonical.com>

Hi Guoqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on broonie-spi/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.16-rc5 next-20250709]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/ASoC-mediatek-mt8365-dai-i2s-pass-correct-size-to-mt8365_dai_set_priv/20250709-134028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20250709053900.55171-1-guoqing.jiang%40canonical.com
patch subject: [PATCH] ASoC: mediatek: mt8365-dai-i2s: pass correct size to mt8365_dai_set_priv
config: csky-randconfig-001-20250709 (https://download.01.org/0day-ci/archive/20250710/202507100010.qEVMavru-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250710/202507100010.qEVMavru-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507100010.qEVMavru-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/mediatek/mt8365/mt8365-dai-i2s.c: In function 'mt8365_dai_i2s_set_priv':
>> sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:819:43: error: invalid operands to binary & (have 'unsigned int' and 'struct mtk_afe_i2s_priv')
     819 |                                           &mt8365_i2s_priv[i]);
         |                                           ^~~~~~~~~~~~~~~~~~~
         |                                                           |
         |                                                           struct mtk_afe_i2s_priv
>> sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:817:23: error: too few arguments to function 'mt8365_dai_set_priv'; expected 4, have 3
     817 |                 ret = mt8365_dai_set_priv(afe, mt8365_i2s_priv[i].id,
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:14:
   sound/soc/mediatek/mt8365/mt8365-afe-common.h:428:5: note: declared here
     428 | int mt8365_dai_set_priv(struct mtk_base_afe *afe,
         |     ^~~~~~~~~~~~~~~~~~~


vim +819 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c

402bbb13a195ca Alexandre Mergnat 2024-07-22  811  
402bbb13a195ca Alexandre Mergnat 2024-07-22  812  static int mt8365_dai_i2s_set_priv(struct mtk_base_afe *afe)
402bbb13a195ca Alexandre Mergnat 2024-07-22  813  {
402bbb13a195ca Alexandre Mergnat 2024-07-22  814  	int i, ret;
402bbb13a195ca Alexandre Mergnat 2024-07-22  815  
402bbb13a195ca Alexandre Mergnat 2024-07-22  816  	for (i = 0; i < DAI_I2S_NUM; i++) {
402bbb13a195ca Alexandre Mergnat 2024-07-22 @817  		ret = mt8365_dai_set_priv(afe, mt8365_i2s_priv[i].id,
08cb0e42ff0631 Guoqing Jiang     2025-07-09  818  					  sizeof(mt8365_i2s_priv[i])
402bbb13a195ca Alexandre Mergnat 2024-07-22 @819  					  &mt8365_i2s_priv[i]);
402bbb13a195ca Alexandre Mergnat 2024-07-22  820  		if (ret)
402bbb13a195ca Alexandre Mergnat 2024-07-22  821  			return ret;
402bbb13a195ca Alexandre Mergnat 2024-07-22  822  	}
402bbb13a195ca Alexandre Mergnat 2024-07-22  823  	return 0;
402bbb13a195ca Alexandre Mergnat 2024-07-22  824  }
402bbb13a195ca Alexandre Mergnat 2024-07-22  825  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

