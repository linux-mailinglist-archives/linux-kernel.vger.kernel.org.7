Return-Path: <linux-kernel+bounces-745688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF6B11D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31113A79F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526E2E543A;
	Fri, 25 Jul 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7W6UML2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7A2405F5;
	Fri, 25 Jul 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441587; cv=none; b=RNwolRrR1Rrx21o+KZJBB4XubsgU9jRF725ycYgVxegUQF14FzA8wztegfOz+81L+P6NyyYPMr89b8w1BM1ngUe/M3SxzEqoH5cdnlAUP9kyuCjRA0NxOAdy10TMth9aY43eXq5ahrfxch6dMky1bQz4VXtkg2rz/H3ou/EPth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441587; c=relaxed/simple;
	bh=4ODTp0UV/5yld+rfWin+qb9F8EdCt5NLU8TsGWCsgrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/OXTiMoniGVq/PncIxi+Y9EyfAsCzmC7+EE/dXtA7R8dbb35Xoag5A/vlzwjcEQ84LrlHdMvbGSKEMshWUr42Fw7rwgaNWVhiZMKfi0I2afm2iS6sn29I0KXRGnWqusW3QvmE2prkeQg/FYrtmPVPxCAwdLbPIrvdJHTr6vR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7W6UML2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753441586; x=1784977586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ODTp0UV/5yld+rfWin+qb9F8EdCt5NLU8TsGWCsgrM=;
  b=N7W6UML2ztUZTEHyCft2dCh8aNbm34grXdmu0y0oQxoz79peKge0D46W
   xRW0CoNvqgcQYuShaNPfs1Do9CbCtBbTew9yhNZhbJLmXCNh/Ftz25Sl9
   8xLvxo6d+VNnTFaibVqVR6BdqUwL+jO/5pzuXYITH5AOQpfN9yHI8aaAa
   AZvzYEa2Sr/D5y3sJBydJz2hca7XNKe94McWIEPEjXlNQoGaYDDr0jePq
   dpeLJsnbjm+aZsFHpqmTqWhaqbIjMHSxqNp+LxfKwT3caSovdTHIbMNaN
   Pu2AyNRqqXyedUtAF2X0zBVGLzjuVRMMf6nFeI9bGwIjauO4FIX8szndd
   w==;
X-CSE-ConnectionGUID: NwjIlvs1TpeqtyccGEBJqA==
X-CSE-MsgGUID: tstdTvB7SROMGpNqhHcgoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73355861"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73355861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 04:06:25 -0700
X-CSE-ConnectionGUID: 4dpPtvj9S5OlyM73/KA5iw==
X-CSE-MsgGUID: DbED2/rCRkSTnILVrQc1Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161593680"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jul 2025 04:06:18 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufGFk-000LGp-1A;
	Fri, 25 Jul 2025 11:06:16 +0000
Date: Fri, 25 Jul 2025 19:06:04 +0800
From: kernel test robot <lkp@intel.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, l.stach@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
Message-ID: <202507251859.rtsTHw8u-lkp@intel.com>
References: <20250724072248.1517569-6-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724072248.1517569-6-shengjiu.wang@nxp.com>

Hi Shengjiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on robh/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/dt-bindings-display-imx-add-HDMI-PAI-for-i-MX8MP/20250724-152710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20250724072248.1517569-6-shengjiu.wang%40nxp.com
patch subject: [PATCH v2 5/6] drm/bridge: imx: add driver for HDMI TX Parallel Audio Interface
config: nios2-randconfig-002-20250725 (https://download.01.org/0day-ci/archive/20250725/202507251859.rtsTHw8u-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250725/202507251859.rtsTHw8u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507251859.rtsTHw8u-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c: In function 'imx8mp_hdmi_pai_enable':
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c:20:26: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    #define   WTMK_HIGH(n)   FIELD_PREP(WTMK_HIGH_MASK, (n))
                             ^~~~~~~~~~
   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c:53:9: note: in expansion of macro 'WTMK_HIGH'
     val =  WTMK_HIGH(3) | WTMK_LOW(3);
            ^~~~~~~~~
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c:59:9: error: implicit declaration of function 'FIELD_PREP_CONST'; did you mean 'FILE_REF_NOREF'? [-Werror=implicit-function-declaration]
      val = FIELD_PREP_CONST(P_SEL,
            ^~~~~~~~~~~~~~~~
            FILE_REF_NOREF
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c:60:12: error: implicit declaration of function '__bf_shf'; did you mean '__ffs64'? [-Werror=implicit-function-declaration]
               __bf_shf(IEC958_SUBFRAME_PARITY));
               ^~~~~~~~
               __ffs64
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +20 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c

    15	
    16	#define HTX_PAI_CTRL_EXT		0x04
    17	#define   WTMK_HIGH_MASK		GENMASK(31, 24)
    18	#define   WTMK_LOW_MASK			GENMASK(23, 16)
    19	#define   NUM_CH_MASK			GENMASK(10, 8)
  > 20	#define   WTMK_HIGH(n)			FIELD_PREP(WTMK_HIGH_MASK, (n))
    21	#define   WTMK_LOW(n)			FIELD_PREP(WTMK_LOW_MASK, (n))
    22	
    23	#define HTX_PAI_FIELD_CTRL		0x08
    24	#define   B_FILT			BIT(31)
    25	#define   PARITY_EN			BIT(30)
    26	#define   END_SEL			BIT(29)
    27	#define   PRE_SEL			GENMASK(28, 24)
    28	#define   D_SEL				GENMASK(23, 20)
    29	#define   V_SEL				GENMASK(19, 15)
    30	#define   U_SEL				GENMASK(14, 10)
    31	#define   C_SEL				GENMASK(9, 5)
    32	#define   P_SEL				GENMASK(4, 0)
    33	
    34	#define HTX_PAI_STAT			0x0c
    35	#define HTX_PAI_IRQ_NOMASK		0x10
    36	#define HTX_PAI_IRQ_MASKED		0x14
    37	#define HTX_PAI_IRQ_MASK		0x18
    38	
    39	struct imx8mp_hdmi_pai {
    40		struct device	*dev;
    41		struct regmap	*regmap;
    42	};
    43	
    44	static void imx8mp_hdmi_pai_enable(struct dw_hdmi *dw_hdmi, int channel,
    45					   int width, int rate, int non_pcm,
    46					   int iec958)
    47	{
    48		const struct dw_hdmi_plat_data *pdata = dw_hdmi_to_plat_data(dw_hdmi);
    49		struct imx8mp_hdmi_pai *hdmi_pai = (struct imx8mp_hdmi_pai *)pdata->priv_audio;
    50		int val;
    51	
    52		/* PAI set control extended */
    53		val =  WTMK_HIGH(3) | WTMK_LOW(3);
    54		val |= FIELD_PREP(NUM_CH_MASK, channel - 1);
    55		regmap_write(hdmi_pai->regmap, HTX_PAI_CTRL_EXT, val);
    56	
    57		/* IEC60958 format */
    58		if (iec958) {
  > 59			val = FIELD_PREP_CONST(P_SEL,
  > 60					       __bf_shf(IEC958_SUBFRAME_PARITY));
    61			val |= FIELD_PREP_CONST(C_SEL,
    62						__bf_shf(IEC958_SUBFRAME_CHANNEL_STATUS));
    63			val |= FIELD_PREP_CONST(U_SEL,
    64						__bf_shf(IEC958_SUBFRAME_USER_DATA));
    65			val |= FIELD_PREP_CONST(V_SEL,
    66						__bf_shf(IEC958_SUBFRAME_VALIDITY));
    67			val |= FIELD_PREP_CONST(D_SEL,
    68						__bf_shf(IEC958_SUBFRAME_SAMPLE_24_MASK));
    69			val |= FIELD_PREP_CONST(PRE_SEL,
    70						__bf_shf(IEC958_SUBFRAME_PREAMBLE_MASK));
    71		} else {
    72			/* PCM choose 24bit*/
    73			val = FIELD_PREP(D_SEL, width - 24);
    74		}
    75	
    76		regmap_write(hdmi_pai->regmap, HTX_PAI_FIELD_CTRL, val);
    77	
    78		/* PAI start running */
    79		regmap_write(hdmi_pai->regmap, HTX_PAI_CTRL, ENABLE);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

