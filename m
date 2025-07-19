Return-Path: <linux-kernel+bounces-737618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7AB0AE74
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE28AA638C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED802230264;
	Sat, 19 Jul 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA6I82EQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75722F764;
	Sat, 19 Jul 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911036; cv=none; b=sGlCBp/jiJvAufOX/CaewBGEXUmTYEHR204UrmjL8GC4k8ESpzJoGRLF3Cn9KSBZ1r3XI/N9+nvBx1jDoBJiJJTKiItlEGARTEcBQquFHkw5H6NkKv9SjnRx4nYj45Ak6SF+trZw9ASM9y4/cuKuc8DtxAJ6FiH0aKL1Vq3MFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911036; c=relaxed/simple;
	bh=ExeIcKQFSS1qmlfLTGq6NdRwBIsy7m51VTTE43vJJ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXrWHM+C7wYAxsqgyzyZnTyq0F02y2wPibv4PROiWl5ijddKe7wQxK2POZ2x8TIe57QOTRmCfbkTwu6QY5tmXoGmVYMz9IjfJHsphSled8XlBNxKR0zzHZLFjDm852so1sCowcS8R0egw89R++VqKXbXO5WzAqOsliD7MKOJbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA6I82EQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752911035; x=1784447035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExeIcKQFSS1qmlfLTGq6NdRwBIsy7m51VTTE43vJJ1A=;
  b=XA6I82EQk+ozlm26IKz38NoubQ1Zl/W1ZWH9mJmm+p4FAUjL20XGjLOw
   f6a2O65Ontp3hwgyOUE8bnfG/HfjlFkuv7ZXiJXcNudVl6CpfN5CtpicD
   +WzhJdJ06cccndeHSv6GhxpJixQi82w/nZTsBnEYFnoIH3rL6tQ5v8kQ5
   GPwYVj1E2sytIwIc0Lhm8C0HIK/GeJGvP+dpzVtYkWQupclUHU5fFkh63
   N8fi99OocH6v4TzmAT+7DKVulTn7I0R9KbWemX0SZtH1cEEXpZO90THVA
   96Oc1fRIUv5yjL3mr79BNcQpQRb+pZEekRg0tG6bmdky8vKP9oqpNQhj9
   Q==;
X-CSE-ConnectionGUID: iLhdj7c4Toqf9O5k5Ubz0Q==
X-CSE-MsgGUID: x1QqG2ymQdi/tjMByobVcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72651128"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="72651128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 00:43:54 -0700
X-CSE-ConnectionGUID: iaIxP5gRQweAL56B3D2Alw==
X-CSE-MsgGUID: X3Qv0Y49S/O0oDqks2wQNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="158517427"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Jul 2025 00:43:46 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud2ER-000FJj-1P;
	Sat, 19 Jul 2025 07:43:43 +0000
Date: Sat, 19 Jul 2025 15:42:49 +0800
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
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] phy: rockchip: phy-rockchip-typec: Add
 typec_mux/typec_switch support
Message-ID: <202507191526.Ts6qTQJj-lkp@intel.com>
References: <20250718062619.99-3-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718062619.99-3-kernel@airkyi.com>

Hi Chaoyi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250717]
[also build test ERROR on linus/master v6.16-rc6]
[cannot apply to robh/for-next rockchip/for-next krzk/for-next krzk-dt/for-next v6.16-rc6 v6.16-rc5 v6.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaoyi-Chen/dt-bindings-phy-rockchip-rk3399-typec-phy-Support-mode-switch/20250718-142814
base:   next-20250717
patch link:    https://lore.kernel.org/r/20250718062619.99-3-kernel%40airkyi.com
patch subject: [PATCH v2 2/5] phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
config: arm64-randconfig-004-20250719 (https://download.01.org/0day-ci/archive/20250719/202507191526.Ts6qTQJj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507191526.Ts6qTQJj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507191526.Ts6qTQJj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: typec_mux_register
   >>> referenced by phy-rockchip-typec.c
   >>>               drivers/phy/rockchip/phy-rockchip-typec.o:(rockchip_typec_phy_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: typec_mux_unregister
   >>> referenced by phy-rockchip-typec.c
   >>>               drivers/phy/rockchip/phy-rockchip-typec.o:(rockchip_typec_phy_probe) in archive vmlinux.a
   >>> referenced by phy-rockchip-typec.c
   >>>               drivers/phy/rockchip/phy-rockchip-typec.o:(tcphy_typec_mux_unregister) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: typec_mux_get_drvdata
   >>> referenced by phy-rockchip-typec.c
   >>>               drivers/phy/rockchip/phy-rockchip-typec.o:(tcphy_typec_mux_set) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

