Return-Path: <linux-kernel+bounces-761200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CA5B1F5B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5744A189D1EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167618DB24;
	Sat,  9 Aug 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ketlY8YA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903D12E5B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761543; cv=none; b=FBqF+4kRrpl1Pvua+Epz5ZD4j3gMyf4Ig8N8VzpHwP8+hIj4yjkhrpKipJIV9xbRwsEEsxBLxgYOsOyH20yG+UCbKrMuIMWjxhESuywrArOBvBWnpVFZzRdeX5z80p1JVQtB/wfyrd/idLVQf6u4j617DNmkjqwQIGf0wwKguOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761543; c=relaxed/simple;
	bh=MnScHLFAB0qTKchnHKfYlInQC6GE+Qe7WYudhJAOg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jPBL3X1CugXUgFAn4wb+o3J21HD8iNQ9mgIpbe57tA2UcIcAZq4mSbQA2oAGhvRe/oiuW2ioeJ+ueEUBnR3rsi5+QUH4r0vXaAGEl+CUJJulv8gTXY/hr7wgv3CbRY6iF1n6ZIjbDVVbvJXTd1JwERp2QMeCYQh54Lbs21E3wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ketlY8YA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754761542; x=1786297542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MnScHLFAB0qTKchnHKfYlInQC6GE+Qe7WYudhJAOg6E=;
  b=ketlY8YAiluPpvACOCwDtPtC78yO+R1PPG1uB6unBGI3X00csHT9Dt9f
   RCll5MtOebAs9xtyQ2ruLMBAryr0vQ+mpM2LCnToSJ8VJiN+s6M1aBacm
   AnASCUUxeZWPefgsiTdTWS+BOAoM5fdEnCds9KwrQEuIktJSkKKtSkmP9
   HwPDK8/zC9UOKyfr9AW7WXAYpBT34YuHd0HRwyfsG1lBCAOH1LVXYQa8J
   D1FP1d+uDH8jOANU+8/Z7zvLUwi698Hgt0bKxjjSIkAfmPvTMaHglPf2y
   Xf2aQKsHMMm20M7O7uZZCQxW4cUT8CAqQ+Dxe4qLy2hiuL1iwPbh98jdN
   w==;
X-CSE-ConnectionGUID: 2iY992a3Q5O2Vof4n9Vabg==
X-CSE-MsgGUID: 2uHVGlagRvGjhw10uiVTfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="56111952"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56111952"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 10:45:41 -0700
X-CSE-ConnectionGUID: 2c2gWQFSTy2KIvGLR29LaQ==
X-CSE-MsgGUID: FitKN/jDRlWb8PhMjh+40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166360259"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 09 Aug 2025 10:45:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukndR-0004yY-0G;
	Sat, 09 Aug 2025 17:45:37 +0000
Date: Sun, 10 Aug 2025 01:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Simek <monstr@monstr.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000
 (xlnx,xps-gpio-1.00.a): 'clocks' is a required property
Message-ID: <202508100133.koF3RLp4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   561c80369df0733ba0574882a1635287b20f9de2
commit: d03b53c9139352b744ed007bf562bd35517bacff dt-bindings: gpio: gpio-xilinx: Mark clocks as required property
date:   8 weeks ago
config: mips-randconfig-052-20250810 (https://download.01.org/0day-ci/archive/20250810/202508100133.koF3RLp4-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508100133.koF3RLp4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508100133.koF3RLp4-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   xlnx,rx-ping-pong: size (4) error for type flag
   xlnx,tx-ping-pong: size (4) error for type flag
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: /: failed to match any schema with compatible: ['digilent,nexys4ddr']
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: / (digilent,nexys4ddr): memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 134217728]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: / (digilent,nexys4ddr): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: /interrupt-controller@10200000: failed to match any schema with compatible: ['xlnx,xps-intc-1.00.a']
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000 (xlnx,xps-gpio-1.00.a): #gpio-cells: 2 was expected
   	from schema $id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
>> arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000 (xlnx,xps-gpio-1.00.a): 'clocks' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000 (xlnx,xps-gpio-1.00.a): Unevaluated properties are not allowed ('#gpio-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000 (xlnx,xps-ethernetlite-3.00.a): 'device_type', 'mdio', 'xlnx,duplex', 'xlnx,include-global-buffers', 'xlnx,include-internal-loopback', 'xlnx,include-mdio', 'xlnx,instance', 'xlnx,s-axi-id-width', 'xlnx,use-internal' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000 (xlnx,xps-ethernetlite-3.00.a): xlnx,rx-ping-pong: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000 (xlnx,xps-ethernetlite-3.00.a): xlnx,tx-ping-pong: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000 (xlnx,xps-ethernetlite-3.00.a): 'clocks' is a required property

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

