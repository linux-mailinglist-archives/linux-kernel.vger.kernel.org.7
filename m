Return-Path: <linux-kernel+bounces-732924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F80B06DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33D2566A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2485245010;
	Wed, 16 Jul 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGgFZ80n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CC126F0A;
	Wed, 16 Jul 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646602; cv=none; b=MzHuuMbjs4aGtaBH6a+u0Ym7mTdhWeax8PMzfbRIfpn2ViORBdocWVoELWSWf9aC3qYuS+buIohE57OG2ypE2TBxjWdeeXoaObj88IAszLvUXM8UwW2Y9z2PZCiXh/+A4llRbl/qbpEavnjnMg7sd5IsTKFlZqfu63xetRnDebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646602; c=relaxed/simple;
	bh=s5h2aOonMUy25QFmLEMp//o9oNn9ckWWreXS2dSrzoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkGAVH3t1a07V+dfDYoPO8DRUojUEp7asOPPwfZUJPblWWvqyFxwDUe5ma+mnEzSngHW4T1yq8wGnulRb/M0EmuknEE7rA1x2tXW80mMqXbK1QF+UoCmjgYLaE+dOQJ8WNZuAsRxu3dfmPtbRFZllQhn3eh0a7vcZDr69osV63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGgFZ80n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752646601; x=1784182601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s5h2aOonMUy25QFmLEMp//o9oNn9ckWWreXS2dSrzoU=;
  b=BGgFZ80nUVXuJ1zyGa++zNn/sh17vWTEXGRiCkEG22vJHS+O/0BHLk8O
   aQunR22DgODwFlJ9AHn+91ZWcSfU2UF7RYGNZpw2shNJmTAic6W0MSH1B
   V0Bf9tGw1b3Jb9iO43St+meDPCciauH6z7RnrUeXB4CfHeDK0tzI6MK7j
   Kb2p6j4SBMXV79GKzyX1MA2VYn63xtaCqw/UJv55ZDE/mTQlSa0+T/8jQ
   bxW/P411hgi9eYOf1mr8roZfh1eMuBFJ4C4tC4dVxySxElpEojf2Gn2R/
   BbSKWub7Huj78riPLDGeHEQ1GwKTJKq/R7eu8RnBWifjMpEbVRHCqMoAt
   A==;
X-CSE-ConnectionGUID: bM49w8zPRxiz2BrVtMGK/A==
X-CSE-MsgGUID: YeZ8RIjiRMe22jIPCz/t8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55030098"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="55030098"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:16:40 -0700
X-CSE-ConnectionGUID: +nsgvEutRfqUlUtiZui4ng==
X-CSE-MsgGUID: Njm01TfuQPya5kUqf5hyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157767216"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2025 23:16:33 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubvRP-000Bzf-2t;
	Wed, 16 Jul 2025 06:16:31 +0000
Date: Wed, 16 Jul 2025 14:15:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add support for
 Type-C TCPM
Message-ID: <202507161301.ZhlTOik9-lkp@intel.com>
References: <20250715112456.101-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715112456.101-4-kernel@airkyi.com>

Hi Chaoyi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250714]
[also build test ERROR on linus/master v6.16-rc6]
[cannot apply to robh/for-next rockchip/for-next krzk/for-next krzk-dt/for-next v6.16-rc6 v6.16-rc5 v6.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaoyi-Chen/dt-bindings-connector-Add-displayport-connector-for-hotplug-notify/20250715-192802
base:   next-20250714
patch link:    https://lore.kernel.org/r/20250715112456.101-4-kernel%40airkyi.com
patch subject: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add support for Type-C TCPM
config: arm-randconfig-004-20250716 (https://download.01.org/0day-ci/archive/20250716/202507161301.ZhlTOik9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507161301.ZhlTOik9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507161301.ZhlTOik9-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `udphy_orien_switch_unregister':
>> phy-rockchip-typec.c:(.text.udphy_orien_switch_unregister+0x2): undefined reference to `typec_switch_unregister'
   arm-linux-gnueabi-ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `tcphy_orien_sw_set':
>> phy-rockchip-typec.c:(.text.tcphy_orien_sw_set+0x4): undefined reference to `typec_switch_get_drvdata'
   arm-linux-gnueabi-ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `rockchip_typec_phy_probe':
>> phy-rockchip-typec.c:(.text.rockchip_typec_phy_probe+0x15c): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

