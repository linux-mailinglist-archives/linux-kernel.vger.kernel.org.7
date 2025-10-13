Return-Path: <linux-kernel+bounces-850998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07EBD5518
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D86F56677F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7A27467D;
	Mon, 13 Oct 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDoq9TU9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A825D546;
	Mon, 13 Oct 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371729; cv=none; b=r2HIXCms2UVaxac0Tn9Ua1ZthtaOQGEjIyuSAYy8NEgmjDsN2xn8/R9IrjUSjXkdnt1u0LXvOtUAGVWaV8IKQOxOhJ1t/dVNb7Fwm596bKjlbtdEh/s1nqiFc5MIqfc8J9dShh6iHxXeN8CK3aE4F9YB9X2ET/g0CYw9OxmFv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371729; c=relaxed/simple;
	bh=Cx2ySqwhiSWfKIHSd5QaOPvH3hIGJdxoGvQgZVmjeec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4kKQSzRgaj6yAc95mGRXzChRDaq4HiELFQyhIvGoGF+xH+FW6/n+qZxRNa6TvkE54IfqMGXpv4nz9SudkqWgvYvMMlocVmvMDjo0XY+2+5BjiUjlQhQaQPlOXP4PWxOIMlxNEB3auhhjhjAwRPwULbjhDbgczLSD1i4m5Z3+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDoq9TU9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760371728; x=1791907728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cx2ySqwhiSWfKIHSd5QaOPvH3hIGJdxoGvQgZVmjeec=;
  b=RDoq9TU9/NXIHupMu934BdArYrd0unvxElOhN3FekHKHm44BXPWnUvEg
   2Ptt/z/zX6Psb4rHchbn7DkJPhe2iGIhaNKml/J24Nd07FXEEpTukAnLe
   0OVcuoyug5smWV8MAYsCs1Gf+AgfA7sCSLSO6yq0R3Mm0uRKPk7nASeku
   A/mb4cht4KGcpEGj1AHS5yetIQv8EbECOc7mHCVTD3qmDk0/UOMozgWDj
   I31ZQUDuLPN7DREtnG2+SM0iPAXKXjDeE1qBTPIFaAosiptHb90/29tIN
   R3OvQ2MY8OEt0PBrxPKFGeO6Vor1EiXDOmAXXTgGSIIbt6ylXWkQ3RMPu
   A==;
X-CSE-ConnectionGUID: z04BLzTzSomegvg3p9cfTQ==
X-CSE-MsgGUID: g8Okb3CTShSG4xv29rzYFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73859888"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="73859888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:08:47 -0700
X-CSE-ConnectionGUID: CQePt4twSyu0zXP/jxJ66A==
X-CSE-MsgGUID: bixiefRXQ1G8y6nrbKNFjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="182396858"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Oct 2025 09:08:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8L3S-0001b8-2e;
	Mon, 13 Oct 2025 16:07:07 +0000
Date: Tue, 14 Oct 2025 00:00:56 +0800
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
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 4/8] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
Message-ID: <202510132306.TKsFxaNn-lkp@intel.com>
References: <20251011033233.97-5-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011033233.97-5-kernel@airkyi.com>

Hi Chaoyi,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.18-rc1 next-20251013]
[cannot apply to rockchip/for-next robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaoyi-Chen/usb-typec-Add-default-HPD-device-when-register-DisplayPort-altmode/20251011-113608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20251011033233.97-5-kernel%40airkyi.com
patch subject: [PATCH v5 4/8] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
config: i386-buildonly-randconfig-003-20251011 (https://download.01.org/0day-ci/archive/20251013/202510132306.TKsFxaNn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251013/202510132306.TKsFxaNn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510132306.TKsFxaNn-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `udphy_orien_switch_unregister':
   phy-rockchip-typec.c:(.text+0x89a): undefined reference to `typec_switch_unregister'
   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `tcphy_orien_sw_set':
   phy-rockchip-typec.c:(.text+0x8b9): undefined reference to `typec_switch_get_drvdata'
   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `tcphy_typec_mux_unregister':
   phy-rockchip-typec.c:(.text+0x93a): undefined reference to `typec_mux_unregister'
   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `tcphy_typec_mux_set':
   phy-rockchip-typec.c:(.text+0x959): undefined reference to `typec_mux_get_drvdata'
   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `tcphy_setup_typec_mux':
>> phy-rockchip-typec.c:(.text+0xac3): undefined reference to `drm_aux_bridge_register'
   ld: phy-rockchip-typec.c:(.text+0xae6): undefined reference to `typec_mux_register'
   ld: drivers/phy/rockchip/phy-rockchip-typec.o: in function `rockchip_typec_phy_probe':
   phy-rockchip-typec.c:(.text+0xf3f): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

