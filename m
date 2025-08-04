Return-Path: <linux-kernel+bounces-755102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B07B1A150
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18773A3D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DD2580F0;
	Mon,  4 Aug 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y53dx1oM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43F24E4C3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310134; cv=none; b=ZUlKSgrzQF0Yc9Q4TACTmejrJVU+jJpye3dmyOmEc8tpz0OGVGx5GGk4XpVU5VjY0H4DiufVEuLiRmt9kE8eGTdCbzkk3EFAsRONIMj1Ov3veKq01ZajSx61KmcnWJbqfyP8QfwNqic2k4swHX6N5WEeYTf/F8YHIAIBaXiaTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310134; c=relaxed/simple;
	bh=4xJ1uiqAz2FIvepEkXv152t8mp5Me0NKRXLBXYQH9iA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UlNBx7/CkgD47bseBel/9KosanTHuwQQjrhkhZop4DLQv4puDOJNLhu3N7cIcYPKH3WuX3WQ8doM48Hfi4p+z1IDWsQanJdVV2FCpIPB/Z5dEnpf/NgTVu5QuqMsd/ZbU+4nlKrk3cLs/UVgbwf+nm6KiLNCZm4z4SHjqLgIwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y53dx1oM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754310129; x=1785846129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4xJ1uiqAz2FIvepEkXv152t8mp5Me0NKRXLBXYQH9iA=;
  b=Y53dx1oM3TLtaq5rYSaAhT3JGvg9Mm8ttECqLsyMKM79BwyoCMIAc86W
   8VgOOTYEicytN628cpIUuylHn3USjWC5INLFzNbgBNmy2uMcAqlan6rv7
   G7rlnLKS9Nwq5DlULanwBjt6YpvJRCYV2OkdDmrWZ1VCP3pq3Lh8MhlfS
   slCuhO+0JGrWPf1agpgq+IU4nsnX9Rr1CUevH+aarGPHXQpbGL20DBzdd
   B9O7DBA6XoejEw8oxixepPlc1I1Qs29Hwh9OOrA6B9flMgj2Rb2YykQdF
   QuvdKfxG17szSCSmi8LtGr3eSff5jUGo0hZVtCYeDC5uHcV3gyRmtGnTl
   A==;
X-CSE-ConnectionGUID: UAQpYLw4TnKg74/hDRJTDg==
X-CSE-MsgGUID: BUlPSyUoQQmONOnargA8Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56496067"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56496067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 05:22:09 -0700
X-CSE-ConnectionGUID: Q1mn+5ruQNmNcoiO1xju4A==
X-CSE-MsgGUID: yBUQ2g+7T6+lp/E1bxkggQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="187850589"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa002.fm.intel.com with ESMTP; 04 Aug 2025 05:22:07 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiuCa-0001n1-2W;
	Mon, 04 Aug 2025 12:22:04 +0000
Date: Mon, 4 Aug 2025 14:21:17 +0200
From: kernel test robot <lkp@intel.com>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Subject: arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910):
 'interrupt-controller' is a required property
Message-ID: <202508041359.s7M3c4wt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   821c9e515db512904250e1d460109a1dc4c7ef6b
commit: 006aa8f57f55dd5bf68c4ada1e0d3f4e59027d71 mfd: dt-bindings: Convert TPS65910 to DT schema
date:   5 days ago
config: arm-randconfig-2053-20250731 (https://download.01.org/0day-ci/archive/20250804/202508041359.s7M3c4wt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250804/202508041359.s7M3c4wt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508041359.s7M3c4wt-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/dpll2_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/d2d_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/dpll5_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/sgx_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/usbhost_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48320000/counter@0: failed to match any schema with compatible: ['ti,omap-counter32k']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48056000/dma-controller@0: failed to match any schema with compatible: ['ti,omap3630-sdma', 'ti,omap-sdma']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48056000/dma-controller@0: failed to match any schema with compatible: ['ti,omap3630-sdma', 'ti,omap-sdma']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/1w@480b2000: failed to match any schema with compatible: ['ti,omap3-1w']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@4809c000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480b4000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480ad000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480ad000/atheros@0: failed to match any schema with compatible: ['atheros,ath6kl']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmu@480bd400: failed to match any schema with compatible: ['ti,omap2-iommu']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmu@5d000000: failed to match any schema with compatible: ['ti,omap2-iommu']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/wdt@48314000: failed to match any schema with compatible: ['ti,omap3-wdt']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mcbsp@48074000: failed to match any schema with compatible: ['ti,omap3-mcbsp']
--
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
--
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1000: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm_conf@0 (syscon): clocks: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm_conf@0 (syscon): phy-gmii-sel: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
--
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1000: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: lis331dlh@18 (st,lis331dlh): 'Vdd-supply', 'Vdd_IO-supply', 'st,click-single-x', 'st,click-single-y', 'st,click-single-z', 'st,click-thresh-x', 'st,click-thresh-y', 'st,click-thresh-z', 'st,irq1-click', 'st,irq2-click', 'st,max-limit-x', 'st,max-limit-y', 'st,max-limit-z', 'st,min-limit-x', 'st,min-limit-y', 'st,min-limit-z', 'st,wakeup-x-hi', 'st,wakeup-x-lo', 'st,wakeup-y-hi', 'st,wakeup-y-lo', 'st,wakeup-z-hi', 'st,wakeup-z-lo' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: lis331dlh@18 (st,lis331dlh): compatible: 'oneOf' conditional failed, one must be fixed:
   	['st,lis331dlh', 'st,lis3lv02d'] is too long
   	'st,lis331dlh' is not one of ['st,h3lis331dl-accel', 'st,lis2de12', 'st,lis2dw12', 'st,lis2hh12', 'st,lis2dh12-accel', 'st,lis2ds12', 'st,lis302dl', 'st,lis331dl-accel', 'st,lis331dlh-accel', 'st,lis3de', 'st,lis3dh-accel', 'st,lis3dhh', 'st,lis3l02dq', 'st,lis3lv02dl-accel', 'st,lng2dm-accel', 'st,lsm303agr-accel', 'st,lsm303c-accel', 'st,lsm303dl-accel', 'st,lsm303dlh-accel', 'st,lsm303dlhc-accel', 'st,lsm303dlm-accel', 'st,lsm330-accel', 'st,lsm330d-accel', 'st,lsm330dl-accel', 'st,lsm330dlc-accel']
   	'st,iis328dq' was expected
   	'st,lis331dlh' is not one of ['silan,sc7a20']
--
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: tsc (ti,am3359-tsc): 'ti,wires' is a required property
   	from schema $id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: tsc (ti,am3359-tsc): 'ti,x-plate-resistance' is a required property
   	from schema $id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: tsc (ti,am3359-tsc): 'ti,coordinate-readouts' is a required property
   	from schema $id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: tsc (ti,am3359-tsc): 'ti,wire-config' is a required property
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
--
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1000: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: regulator@12 (regulator-fixed): Unevaluated properties are not allowed ('reg', 'regulator-compatible' were unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: rtc_wdt@68 (dallas,ds1374): $nodename:0: 'rtc_wdt@68' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/rtc/trivial-rtc.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
--
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
--
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: serial@0 (ti,am3352-uart): Unevaluated properties are not allowed ('rts-gpio' was unexpected)
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: scm_conf@0 (syscon): phy-gmii-sel: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm_conf@0 (syscon): phy-gmii-sel: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm_conf@0 (syscon): clocks: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
--
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1000: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1100: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@0/prcm@0/prm@1200: failed to match any schema with compatible: ['ti,am3-prm-inst', 'ti,omap-prm-inst']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm_conf@0 (syscon): clocks: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm_conf@0 (syscon): phy-gmii-sel: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

