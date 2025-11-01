Return-Path: <linux-kernel+bounces-881158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E65C27942
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82889188E49F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B526ED4C;
	Sat,  1 Nov 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJlkvtxw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2C258ECC;
	Sat,  1 Nov 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983838; cv=none; b=cLLRtPMD4pKo/rAiU+mGYzdcQch1vX4zh9l44S5WaKfgu34S/TAEdemlG523Y0d+u6Yqb//k3rbPr9Smga069ZGc1hjGn/nzPbv0JOsH33pz+nNf6vSkbOL6MwDi52P/2SA4lrcpeMyDxX3Dcc706I6KnTMbcBUzrywvYzc8WUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983838; c=relaxed/simple;
	bh=5l6XRwzZKsnytv0pszvZHGNvjbLNPdZfFglWR7zjF60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o83m3CCL7VgwCbkPnuZskA+YKYHeE4YiTAF72M+Tsds9JhlsDKHkRHFCniLDyV3cwl2osDafWmHZdt76Xoee7vNjWqzLZPMb5iD4diX/B0yGHdiV6vg8yGwTOn/XKDo6b35JvzbaxbkAenVtiMWRagmIn+bG9K7iN0178wQp3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJlkvtxw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761983837; x=1793519837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5l6XRwzZKsnytv0pszvZHGNvjbLNPdZfFglWR7zjF60=;
  b=LJlkvtxwOEkUVQtBPS5fYpk0v/qVx0qApxCyvjGxHDS4XFz0/WLstrIe
   Q5YdrMQnZlqCgbkKq39/+8uJF2DTNb1sfy5P58jzMSSjMXkNtZ9/mKBJo
   btJwACIAWM6SGY+iJa8Iq2JcuKlo/z6B+qSbxJMvBX0W9iurcxh/F8pxQ
   jHw5XlzeyDYCoOhfUDBhAZoHCi//raaAEoEF9yrr/ipHWkFNQU0tSOVKq
   eH42wyY8hnbS1vCSqvv/ox+W7fzpBpXry2wlTr9ClS4MOOU0/NsoX4G4J
   MlpPhA34oNh4zLJaO3KNVBC51EO1Fzl8eCTeWqm6Mha9jOEGkQTnONGLf
   A==;
X-CSE-ConnectionGUID: rRRCmi9TQu61sAhAZI4fag==
X-CSE-MsgGUID: L0V/SIpgTtKmQzMVN9r86A==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64169420"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="64169420"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 00:57:15 -0700
X-CSE-ConnectionGUID: R1dMWY33SMC/exy6kVUwnw==
X-CSE-MsgGUID: a8gUVw5kSwqTYqY+tMzaWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="223659476"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Nov 2025 00:57:10 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF6Tz-000O1Q-2M;
	Sat, 01 Nov 2025 07:57:07 +0000
Date: Sat, 1 Nov 2025 15:56:49 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, laura.nao@collabora.com,
	nfraprado@collabora.com, wenst@chromium.org,
	y.oudjana@protonmail.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC
 Clock Controller
Message-ID: <202511011537.ccyYOMhK-lkp@intel.com>
References: <20251027111343.21723-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027111343.21723-8-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/clk-mediatek-Split-out-registration-from-mtk_clk_register_gates/20251027-191633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20251027111343.21723-8-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251101/202511011537.ccyYOMhK-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011537.ccyYOMhK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011537.ccyYOMhK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mtk-spmi.c:48:13: error: call to undeclared function 'devm_spmi_subdevice_alloc_and_add'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      48 |         sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |                    ^
>> drivers/clk/mediatek/clk-mtk-spmi.c:48:11: error: incompatible integer to pointer conversion assigning to 'struct spmi_subdevice *' from 'int' [-Wint-conversion]
      48 |         sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/mediatek/clk-mtk-spmi.c:52:46: error: incomplete definition of type 'struct spmi_subdevice'
      52 |         regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
         |                                             ~~~~~~~~^
   include/linux/regmap.h:1116:5: note: expanded from macro 'devm_regmap_init_spmi_ext'
    1116 |                                 dev, config)
         |                                 ^~~
   include/linux/regmap.h:775:6: note: expanded from macro '__regmap_lockdep_wrapper'
     775 |                 fn(__VA_ARGS__, &_key,                                  \
         |                    ^~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk-spmi.c:31:9: note: forward declaration of 'struct spmi_subdevice'
      31 |         struct spmi_subdevice *sub_sdev;
         |                ^
   3 errors generated.


vim +/devm_spmi_subdevice_alloc_and_add +48 drivers/clk/mediatek/clk-mtk-spmi.c

80a000281742dc AngeloGioacchino Del Regno 2025-10-27  21  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  22  int mtk_spmi_clk_simple_probe(struct platform_device *pdev)
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  23  {
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  24  	struct regmap_config mtk_spmi_clk_regmap_config = {
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  25  		.reg_bits = 16,
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  26  		.val_bits = 8,
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  27  		.fast_io = true
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  28  	};
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  29  	struct device_node *node = pdev->dev.of_node;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  30  	const struct mtk_spmi_clk_desc *mscd;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  31  	struct spmi_subdevice *sub_sdev;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  32  	struct spmi_device *sparent;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  33  	struct regmap *regmap;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  34  	int ret;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  35  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  36  	ret = of_property_read_u32(node, "reg", &mtk_spmi_clk_regmap_config.reg_base);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  37  	if (ret)
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  38  		return ret;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  39  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  40  	/* If the max_register was not declared the pdata is not valid */
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  41  	mscd = device_get_match_data(&pdev->dev);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  42  	if (mscd->max_register == 0)
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  43  		return -EINVAL;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  44  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  45  	mtk_spmi_clk_regmap_config.max_register = mscd->max_register;
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  46  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  47  	sparent = to_spmi_device(pdev->dev.parent);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27 @48  	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  49  	if (IS_ERR(sub_sdev))
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  50  		return PTR_ERR(sub_sdev);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  51  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27 @52  	regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  53  	if (IS_ERR(regmap))
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  54  		return PTR_ERR(regmap);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  55  
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  56  	return mtk_clk_simple_probe_internal(pdev, node, mscd->desc, regmap);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  57  }
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  58  EXPORT_SYMBOL_GPL(mtk_spmi_clk_simple_probe);
80a000281742dc AngeloGioacchino Del Regno 2025-10-27  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

