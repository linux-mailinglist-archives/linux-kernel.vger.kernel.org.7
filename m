Return-Path: <linux-kernel+bounces-879139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6BC225CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C4A1886C23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972633555E;
	Thu, 30 Oct 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ5yju53"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122624BBEC;
	Thu, 30 Oct 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857791; cv=none; b=GvrbImXjY2ZUnz4cunkH42dhLKdhqm34eLRhSbeT5lZbDex5GK/6ul9OA0NUB/EKsMkEAirqHK/HY9TG5JIl5ZjV4iUqzNlkIf3w8j0VEX50D02DhTlPmURjVlQvywLRtnTxq7trglHAlZ4p6HUz4YGAtGiZK3uyhk57AO/KQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857791; c=relaxed/simple;
	bh=vThwM6bg5dh8w6h8yGfI/6gd9+bsmsZISHcjUp0Wi7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpdwqVynQX1HgbDckGZtNHfaxGApA54EGVb5KGCkkb7+nZ+oWaDk5kXBuCeRctye9fUEtRseVj3mSlTnJUPD7Yw08UJc50wrpLA6Kyxkl2+eBffulG86WlQ7x8QTi+NRQdZlYj07E27EVzAjub30v6cujZXOdQTlm7qtzt0/H3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ5yju53; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761857790; x=1793393790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vThwM6bg5dh8w6h8yGfI/6gd9+bsmsZISHcjUp0Wi7E=;
  b=bQ5yju53h1jiSVl7lYAynbp9SpIUpIx0uQGB9b6GAJCOUIPC7hI9/HBm
   KuGGKVqeqGY99BNKj9IBmy0vYKXCS/UDwRqNQl5iHjLJZ331o65EBCP/M
   XkxT45k8M54o0S4kKXuFGb5d3qnsqGb8ItrBvPcbGQUamgoootXXIfMtz
   5Vjyvl5uMLRwix/BdFk/SyKdBIcUCwy5FJl90rMa+rIUULyqxMZRDR3R8
   3VKOwKmJRpSaZsJvYWsmV366UNfVW1LZ8GrDXOCtD1EURwE16SORRssyl
   CYOZmMKhaAtVAjEmyedVr6jifOgC4NLumKl9bWsiijHKmloH4uN6QWrsh
   w==;
X-CSE-ConnectionGUID: fqbl8ENvRky3g910FADgRw==
X-CSE-MsgGUID: wQj2WbKPQa6RQ5SN+Z+ckQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67849505"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67849505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:56:30 -0700
X-CSE-ConnectionGUID: wuDqC9JaQY2quEW6MtBc5g==
X-CSE-MsgGUID: iESQHGsTTD6bVq08VVjuJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185933452"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2025 13:56:25 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEZh1-000MWi-13;
	Thu, 30 Oct 2025 20:56:23 +0000
Date: Fri, 31 Oct 2025 04:56:07 +0800
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
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC
 Clock Controller
Message-ID: <202510310450.vQV7FK3n-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/clk-mediatek-Split-out-registration-from-mtk_clk_register_gates/20251027-191633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20251027111343.21723-8-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller
config: arm64-randconfig-003-20251031 (https://download.01.org/0day-ci/archive/20251031/202510310450.vQV7FK3n-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310450.vQV7FK3n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310450.vQV7FK3n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/mediatek/clk-mtk-spmi.c: In function 'mtk_spmi_clk_simple_probe':
   drivers/clk/mediatek/clk-mtk-spmi.c:48:13: error: implicit declaration of function 'devm_spmi_subdevice_alloc_and_add' [-Werror=implicit-function-declaration]
      48 |  sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/mediatek/clk-mtk-spmi.c:48:11: warning: assignment to 'struct spmi_subdevice *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      48 |  sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
         |           ^
   In file included from drivers/clk/mediatek/clk-mtk-spmi.c:16:
   drivers/clk/mediatek/clk-mtk-spmi.c:52:46: error: invalid use of undefined type 'struct spmi_subdevice'
      52 |  regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
         |                                              ^~
   include/linux/regmap.h:775:6: note: in definition of macro '__regmap_lockdep_wrapper'
     775 |   fn(__VA_ARGS__, &_key,     \
         |      ^~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk-spmi.c:52:11: note: in expansion of macro 'devm_regmap_init_spmi_ext'
      52 |  regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +48 drivers/clk/mediatek/clk-mtk-spmi.c

80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  21  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  22  int mtk_spmi_clk_simple_probe(struct platform_device *pdev)
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  23  {
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  24  	struct regmap_config mtk_spmi_clk_regmap_config = {
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  25  		.reg_bits = 16,
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  26  		.val_bits = 8,
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  27  		.fast_io = true
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  28  	};
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  29  	struct device_node *node = pdev->dev.of_node;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  30  	const struct mtk_spmi_clk_desc *mscd;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  31  	struct spmi_subdevice *sub_sdev;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  32  	struct spmi_device *sparent;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  33  	struct regmap *regmap;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  34  	int ret;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  35  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  36  	ret = of_property_read_u32(node, "reg", &mtk_spmi_clk_regmap_config.reg_base);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  37  	if (ret)
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  38  		return ret;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  39  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  40  	/* If the max_register was not declared the pdata is not valid */
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  41  	mscd = device_get_match_data(&pdev->dev);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  42  	if (mscd->max_register == 0)
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  43  		return -EINVAL;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  44  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  45  	mtk_spmi_clk_regmap_config.max_register = mscd->max_register;
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  46  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  47  	sparent = to_spmi_device(pdev->dev.parent);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27 @48  	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  49  	if (IS_ERR(sub_sdev))
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  50  		return PTR_ERR(sub_sdev);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  51  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  52  	regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  53  	if (IS_ERR(regmap))
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  54  		return PTR_ERR(regmap);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  55  
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  56  	return mtk_clk_simple_probe_internal(pdev, node, mscd->desc, regmap);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  57  }
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  58  EXPORT_SYMBOL_GPL(mtk_spmi_clk_simple_probe);
80a000281742dc0 AngeloGioacchino Del Regno 2025-10-27  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

