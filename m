Return-Path: <linux-kernel+bounces-870240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CBC0A415
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9199D3AF451
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C027815D;
	Sun, 26 Oct 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTV7F87f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031E1D514B;
	Sun, 26 Oct 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761463804; cv=none; b=lLPDClSeAgCh7whSrT/mccePa9neBFoDBjzy7mEbeBUDqHh3EKTM90Q5S82xBWalP1PSjHoZQk2JOS8Kg/ZNepjvldlCr2rmloZHNN4e7n/yi1SB62IDGYLbRiB46RhYOgRFrvA/202F55AWelIm9m4LDXwxeZvrtBC71cpXMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761463804; c=relaxed/simple;
	bh=htiWAq6iMZXxfabupy1JM4kiUVfrOnJOCEMU/JiJmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXbH4IRDzkidZdEiKQd0amVXuJxlUUXmw0ez6YxHR7DuBuGifm7/gDVYXl9lfFpihTApKAiM+E770H5V6U3XSe+Hy8O/PY106QLpYwBypWwnObI7t0CX1vXDa2jVF+T1s1qMsoJKexAYdf+Qtmrnkz4HG/WhluoKtiF47qm1n1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTV7F87f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761463803; x=1792999803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htiWAq6iMZXxfabupy1JM4kiUVfrOnJOCEMU/JiJmzQ=;
  b=KTV7F87fO2rpZ1J76GKuDG8eTnj5ySeFDrS3DBFvKA9bM/VTwN6+tmW4
   pHVmzhA9LUBAu61dojWbef7cknEcL/JDg4cP5tdqNtc62Vhcai96G1FQg
   WQXRGBaLADPpYT1C1M+pnwmg/W3Q29kp2wYzMB1fEuDdJhhQnk5fUAtJs
   RNjBKXvMNka/Bcl2RiNQBegUMY08wqlr4GkbyVqfuNoNz8QKnSfIFJ7gT
   65tGl7Z0hnpwp3O6HZKJHtTez08IKyR+e+wGvb+XT5aO1xw3kR4Pr6dFn
   ARiNkLTx6TkgZOpwku3SmhJ5wqyqhKPYi9ZDj5Sc5Vw0ntDoExtrPWR46
   w==;
X-CSE-ConnectionGUID: GqaU80cKQV6vJU6g7l/nwg==
X-CSE-MsgGUID: joiY2BoqRQq6noyNRyTLgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81005631"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="81005631"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 00:30:02 -0700
X-CSE-ConnectionGUID: IOhbygVPQmG+sECxKbCJdQ==
X-CSE-MsgGUID: FpsA08v6Q5KZpnC9I5OBIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="189155119"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Oct 2025 00:29:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCvCN-000FxV-0H;
	Sun, 26 Oct 2025 07:29:55 +0000
Date: Sun, 26 Oct 2025 15:29:29 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, laura.nao@collabora.com,
	nfraprado@collabora.com, wenst@chromium.org,
	y.oudjana@protonmail.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC
 Clock Controller
Message-ID: <202510261450.oYPrwZwR-lkp@intel.com>
References: <20251024083301.25845-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024083301.25845-8-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.18-rc2 next-20251024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/clk-mediatek-Split-out-registration-from-mtk_clk_register_gates/20251024-164213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20251024083301.25845-8-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v1 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20251026/202510261450.oYPrwZwR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261450.oYPrwZwR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510261450.oYPrwZwR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/mediatek/clk-mtk-spmi.c: In function 'mtk_spmi_clk_simple_probe':
>> drivers/clk/mediatek/clk-mtk-spmi.c:48:20: error: implicit declaration of function 'devm_spmi_subdevice_alloc_and_add' [-Wimplicit-function-declaration]
      48 |         sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/mediatek/clk-mtk-spmi.c:48:18: error: assignment to 'struct spmi_subdevice *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      48 |         sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |                  ^
   In file included from drivers/clk/mediatek/clk-mtk-spmi.c:16:
>> drivers/clk/mediatek/clk-mtk-spmi.c:52:53: error: invalid use of undefined type 'struct spmi_subdevice'
      52 |         regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
         |                                                     ^~
   include/linux/regmap.h:775:20: note: in definition of macro '__regmap_lockdep_wrapper'
     775 |                 fn(__VA_ARGS__, &_key,                                  \
         |                    ^~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk-spmi.c:52:18: note: in expansion of macro 'devm_regmap_init_spmi_ext'
      52 |         regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/devm_spmi_subdevice_alloc_and_add +48 drivers/clk/mediatek/clk-mtk-spmi.c

0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  21  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  22  int mtk_spmi_clk_simple_probe(struct platform_device *pdev)
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  23  {
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  24  	struct regmap_config mtk_spmi_clk_regmap_config = {
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  25  		.reg_bits = 16,
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  26  		.val_bits = 8,
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  27  		.fast_io = true
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  28  	};
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  29  	struct device_node *node = pdev->dev.of_node;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  30  	const struct mtk_spmi_clk_desc *mscd;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  31  	struct spmi_subdevice *sub_sdev;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  32  	struct spmi_device *sparent;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  33  	struct regmap *regmap;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  34  	int ret;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  35  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  36  	ret = of_property_read_u32(node, "reg", &mtk_spmi_clk_regmap_config.reg_base);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  37  	if (ret)
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  38  		return ret;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  39  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  40  	/* If the max_register was not declared the pdata is not valid */
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  41  	mscd = device_get_match_data(&pdev->dev);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  42  	if (mscd->max_register == 0)
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  43  		return -EINVAL;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  44  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  45  	mtk_spmi_clk_regmap_config.max_register = mscd->max_register;
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  46  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  47  	sparent = to_spmi_device(pdev->dev.parent);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24 @48  	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  49  	if (IS_ERR(sub_sdev))
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  50  		return PTR_ERR(sub_sdev);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  51  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24 @52  	regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  53  	if (IS_ERR(regmap))
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  54  		return PTR_ERR(regmap);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  55  
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  56  	return mtk_clk_simple_probe_internal(pdev, node, mscd->desc, regmap);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  57  }
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  58  EXPORT_SYMBOL_GPL(mtk_spmi_clk_simple_probe);
0986bdc04bd40e AngeloGioacchino Del Regno 2025-10-24  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

