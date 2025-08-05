Return-Path: <linux-kernel+bounces-756619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FFB1B6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87DB17C10A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F9279783;
	Tue,  5 Aug 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLVJi5ke"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC242264A0;
	Tue,  5 Aug 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405474; cv=none; b=LMGeNDiIOZDV5om+x1mtVLnaGO4yitQE1r7escy+44qBT4I7BxSNCaVjIIpbG+oCNe/8FdDfsJ2JCo5nSlZAXCXiS9STTpiB8WWbhgPLHJTDBFVJATOTTbejmExkjFsq6Gxe+o1u60QuiDfiMGRRkvbq2fEE4Qr0t4/bvzYkfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405474; c=relaxed/simple;
	bh=6JJJUKSGwNvzbye1CXhMaN2YPY31Ne0NqIPIES62I2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji2f1dkh3GfOn6RKkOqq0TkZp+u/YU3egprrmLslJfw5dspCrTfmeQjW1NlhYHGmfjcZV7xAdHjTBRhj1zjmhQA3Js5jCPRQ6HLApP9uNyWB0rD8YKIUpWZcV3fRnwfTiRRaR0Fu63vPQc5wAX8zKdRM5IuaLFAp5vlPScPx81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLVJi5ke; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754405473; x=1785941473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6JJJUKSGwNvzbye1CXhMaN2YPY31Ne0NqIPIES62I2I=;
  b=OLVJi5kessqO2IwWmkmbAgGKWQoCMSPRy+jgQKWtaycxiOHX77dNQ/27
   0yR8WfpeHRec7znvl7LHSkvitQlUYgCsDaK7w0V7gTLEHOd2P3om1P94l
   HNB41yL7apPDDT7Uvh/DhduWq1g5oxFj0MMdnFyyJCja237jmIqLt1xNr
   pK1D/Wgo4wD+f5EagoBLn1b+n535NiiBvcoyPycglEU4fAUv2Hrgbq7iP
   pKV3wsNUJzjoK38TfRdC7OU9u5YAmbe8S4PRwVvhWXR27/91MK9eCl88S
   k5PaS1j9c0JXKvR3kRx3ky+J80PsTdIWcKn0IEMP8LNZqi3531ijmpB/T
   g==;
X-CSE-ConnectionGUID: mTgge7pmRe6kl/2r/8MNVQ==
X-CSE-MsgGUID: HCisg9p3RCiKZUFJZPmrcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56780801"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56780801"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 07:51:12 -0700
X-CSE-ConnectionGUID: dg9Yxn2AQQmm7J+UhiEFxg==
X-CSE-MsgGUID: WnuoX+2FRrmneZllg/7wMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="195476429"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Aug 2025 07:51:05 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujJ0E-0000d8-1a;
	Tue, 05 Aug 2025 14:51:00 +0000
Date: Tue, 5 Aug 2025 22:50:50 +0800
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
Subject: Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
Message-ID: <202508052225.u407ulE0-lkp@intel.com>
References: <20250804104722.601440-6-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804104722.601440-6-shengjiu.wang@nxp.com>

Hi Shengjiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on robh/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.16 next-20250805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/dt-bindings-display-imx-add-HDMI-PAI-for-i-MX8MP/20250804-185254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20250804104722.601440-6-shengjiu.wang%40nxp.com
patch subject: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel Audio Interface
config: xtensa-randconfig-001-20250805 (https://download.01.org/0day-ci/archive/20250805/202508052225.u407ulE0-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250805/202508052225.u407ulE0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508052225.u407ulE0-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of lib/test_dynamic_debug.o: defined in discarded section `.exit.text' of lib/test_dynamic_debug.o
   `.exit.text' referenced in section `__jump_table' of lib/test_dynamic_debug.o: defined in discarded section `.exit.text' of lib/test_dynamic_debug.o
   xtensa-linux-ld: drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.o: in function `imx8mp_hdmi_pai_remove':
>> imx8mp-hdmi-pai.c:(.text+0x8c): undefined reference to `dw_hdmi_to_plat_data'
   xtensa-linux-ld: drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.o: in function `imx8mp_hdmi_pai_disable':
   imx8mp-hdmi-pai.c:(.text+0x9a): undefined reference to `dw_hdmi_to_plat_data'
>> xtensa-linux-ld: imx8mp-hdmi-pai.c:(.text+0xbc): undefined reference to `dw_hdmi_to_plat_data'
   xtensa-linux-ld: drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.o: in function `imx8mp_hdmi_pai_enable':
   imx8mp-hdmi-pai.c:(.text+0xd2): undefined reference to `dw_hdmi_to_plat_data'
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

