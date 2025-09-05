Return-Path: <linux-kernel+bounces-803852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9FB4662C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9ADAC39FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D622877D2;
	Fri,  5 Sep 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsKC2u7b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50604286891
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109081; cv=none; b=CJWvU0uHwgLda2oR/zPBoAyf11ktsEarcrMJp4m169lP7Kc6Zes9fKllQQtVrnwAQVDyz7GriCpiTNK1Pft8DpVbwz8Cqq260ndA9oNBAAsINwQ5XxfuXUwG7OEUGdhS4aIoNk8UJFqrlOdUh5ghYmiXzokkT1ucruILxmB9PFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109081; c=relaxed/simple;
	bh=GvcxKewerZ0+efFLVvzsfq2leKXqx+I9KwmE1dj78WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACyCZnUE+EAnH7KLjUh/F7y0MxbwXn4N2R0RKRTXmdLKJ2L+RlRGazvfVQdLkZ6gW9wlFyuUAjsjnGIRnG7A14rvhBPdqfDyDw+7PwHoMI9EFa0FaMO9B8I1dXiyQBYlsEUiNkzdkE8ZEypb5WrqF9AqDLITe/CLC5pgVEsFOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsKC2u7b; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757109079; x=1788645079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvcxKewerZ0+efFLVvzsfq2leKXqx+I9KwmE1dj78WA=;
  b=GsKC2u7b5Y7ZBnPtitN3oeDPJie+yq7bs8f9Jp5g4cw+O8tNXqu3yEt8
   dbuIunyKg8+Y4WLSNpMEcBswQFifmkr4z5u5mj9CPpMGypKRh88GmhjZA
   YCqOfrrMTP5EyCh3tAFgH5zGaFNIALn34pXvmxGWyUOUZ37wjYOb1y/70
   s8cvhATtF0mCFbfdTq88joiaqQCVU4koJpyQcQ30laTtW32V5MT3gytN7
   AwEbp56rEY+eJy0JNJ2ekHmZuMrV7qshmPa597CuVUYAb24w+Zh9Z0kCp
   CutyxQSg/WSYDtzBi/5B5/cHj3ZfUxZ2iY/+mexQpIFLCid9dVuS4a+mP
   Q==;
X-CSE-ConnectionGUID: 3SikoGAwScmuSEbQfyaehw==
X-CSE-MsgGUID: OUDMUPWPS4+zwhq3IVvcQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59402233"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="59402233"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 14:51:18 -0700
X-CSE-ConnectionGUID: DBHBytIBTNiuRhjYQp8c7g==
X-CSE-MsgGUID: ClmLue1+TsibjFz0ZWWC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="172376665"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Sep 2025 14:51:14 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uueKt-0000tL-34;
	Fri, 05 Sep 2025 21:51:11 +0000
Date: Sat, 6 Sep 2025 05:50:28 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] drm/bridge: ite-it6263: Support HDMI vendor specific
 infoframe
Message-ID: <202509060506.8qlqQKQi-lkp@intel.com>
References: <20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com>

Hi Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4ac65880ebca1b68495bd8704263b26c050ac010]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Ying/drm-bridge-ite-it6263-Support-HDMI-vendor-specific-infoframe/20250904-171143
base:   4ac65880ebca1b68495bd8704263b26c050ac010
patch link:    https://lore.kernel.org/r/20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634%40nxp.com
patch subject: [PATCH] drm/bridge: ite-it6263: Support HDMI vendor specific infoframe
config: xtensa-randconfig-002-20250906 (https://download.01.org/0day-ci/archive/20250906/202509060506.8qlqQKQi-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509060506.8qlqQKQi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509060506.8qlqQKQi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/ite-it6263.c: In function 'it6263_hdmi_write_infoframe':
>> drivers/gpu/drm/bridge/ite-it6263.c:810:3: error: a label can only be part of a statement and a declaration is not a statement
     810 |   const char zero_bulk[HDMI_PKT_HB_PB_CHUNK_SIZE] = { };
         |   ^~~~~


vim +810 drivers/gpu/drm/bridge/ite-it6263.c

   782	
   783	static int it6263_hdmi_write_infoframe(struct drm_bridge *bridge,
   784					       enum hdmi_infoframe_type type,
   785					       const u8 *buffer, size_t len)
   786	{
   787		struct it6263 *it = bridge_to_it6263(bridge);
   788		struct regmap *regmap = it->hdmi_regmap;
   789	
   790		switch (type) {
   791		case HDMI_INFOFRAME_TYPE_AVI:
   792			/* write the first AVI infoframe data byte chunk(DB1-DB5) */
   793			regmap_bulk_write(regmap, HDMI_REG_AVI_DB1,
   794					  &buffer[HDMI_INFOFRAME_HEADER_SIZE],
   795					  HDMI_AVI_DB_CHUNK1_SIZE);
   796	
   797			/* write the second AVI infoframe data byte chunk(DB6-DB13) */
   798			regmap_bulk_write(regmap, HDMI_REG_AVI_DB6,
   799					  &buffer[HDMI_INFOFRAME_HEADER_SIZE +
   800						  HDMI_AVI_DB_CHUNK1_SIZE],
   801					  HDMI_AVI_DB_CHUNK2_SIZE);
   802	
   803			/* write checksum */
   804			regmap_write(regmap, HDMI_REG_AVI_CSUM, buffer[3]);
   805	
   806			regmap_write(regmap, HDMI_REG_AVI_INFOFRM_CTRL,
   807				     ENABLE_PKT | REPEAT_PKT);
   808			break;
   809		case HDMI_INFOFRAME_TYPE_VENDOR:
 > 810			const char zero_bulk[HDMI_PKT_HB_PB_CHUNK_SIZE] = { };
   811	
   812			/* clear NULL packet registers due to undefined default value */
   813			regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0),
   814					  zero_bulk, sizeof(zero_bulk));
   815	
   816			/* write header and payload */
   817			regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0), buffer, len);
   818	
   819			regmap_write(regmap, HDMI_REG_PKT_NULL_CTRL,
   820				     ENABLE_PKT | REPEAT_PKT);
   821			break;
   822		default:
   823			dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
   824		}
   825	
   826		return 0;
   827	}
   828	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

