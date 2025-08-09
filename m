Return-Path: <linux-kernel+bounces-760904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E92B1F1DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D940F1AA839A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B62777F1;
	Sat,  9 Aug 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4Q7dj4e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB14274FD0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702921; cv=none; b=EhT7eIkpXdxV1m57TM4Fl3Z5LoGBq3UoZRwyVVCjTYwZv9GQOzD0l6IkRkrHdZuAXtN9do4CkHHti7G465tG9CftxrrkIoL58z0JDqyuhlG+tXcmItlxqWMchpw7cyQj9RBUZzwFxhjJcEoqIQbuOV3ojZa+hJOK7Uwt+s8VXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702921; c=relaxed/simple;
	bh=nxkSUDR9or4CDNo4EGFcsMcw82X0+O9CzhntZAPlces=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IwV2Rc37Q5CCDY5G73GfygY9RqhT0FSnc2qPNM0JZoGwBbwlwJKGIqZs3GSbxsRq3d1M5aDw+DC/riKAqYwQVM8akx3sQlJO1t8sHHj6AG1Htmx3JzvwvWYaOqOcYQpRkGcnn6OqARY7mjjcXuBfAsOfpSNG4uK0jFiQCCNnUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4Q7dj4e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754702917; x=1786238917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nxkSUDR9or4CDNo4EGFcsMcw82X0+O9CzhntZAPlces=;
  b=e4Q7dj4ehcy5uQb1rAnoEqvPRymsRfrE1v+BRYAHXki0gs1w4hQY1m6w
   uBk9EuG1tjCWaGWQJ/wfXyQplasg0t/YMzCOqIEDPRgRY7ORrEMQLFtzh
   1OP2aC+C4PwDWw54SANc04L/DP7Ef6W2vSjsrd4Eqjwiul3FMczGNPPq0
   /lugDschL7fHm7Y/LmNhDcJZ6YzkqzNlO4qlS5jkC82PAWHQ4dUmbvEhA
   9vXRdPS3aM69Tsn2mq2D0bPBYormERqNcJgYJcrulpjRUHvdv867vMT9b
   7cGlYqTVtpZEhqJ9IiuQq75cHbBgXi6Wb5UCXIOOoXQTI8nKbCQMQ7nA7
   A==;
X-CSE-ConnectionGUID: mizbzaxtSLSVTBza9zvMag==
X-CSE-MsgGUID: cWBZ0iU5TQ6B6VGuTRy4jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67643847"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67643847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 18:28:36 -0700
X-CSE-ConnectionGUID: othbSNp3SXqNAGwWb2CdpA==
X-CSE-MsgGUID: MbZC5irxSTeeZdIoWPEVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166250518"
Received: from unknown (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2025 18:28:34 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukYNr-0002i9-3D;
	Sat, 09 Aug 2025 01:28:32 +0000
Date: Sat, 9 Aug 2025 03:27:37 +0200
From: kernel test robot <lkp@intel.com>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Subject: arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: pmic@2d
 (ti,tps65911): 'wakeup-source' does not match any of the regexes:
 '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
Message-ID: <202508090302.gVlOiKrE-lkp@intel.com>
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
date:   10 days ago
config: arm-randconfig-2052-20250731 (https://download.01.org/0day-ci/archive/20250809/202508090302.gVlOiKrE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090302.gVlOiKrE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090302.gVlOiKrE-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1154.15-1166.4: Warning (unique_unit_address_if_enabled): /usb@7d004000: duplicate unit-address (also used in node /usb-phy@7d004000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: pmic@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: touchscreen@41 (st,stmpe811): 'blocks', 'id', 'irq-gpio', 'irq-trigger', 'stmpe_adc', 'stmpe_touchscreen' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: touchscreen@41 (st,stmpe811): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: /i2c@7000d000/temp-sensor@4c: failed to match any schema with compatible: ['national,lm95245']
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi:49.22-55.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
>> arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: pmic@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: audio-codec@1c (realtek,rt5640): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5640.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: audio-codec@1c (realtek,rt5640): Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5640.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi:53.22-59.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi:53.22-59.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi:53.22-59.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi:53.22-59.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf300tl.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi:53.22-59.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1154.15-1166.4: Warning (unique_unit_address_if_enabled): /usb@7d004000: duplicate unit-address (also used in node /usb-phy@7d004000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: rt5640@1c (realtek,rt5640): Unevaluated properties are not allowed ('realtek,ldo1-en-gpios' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5640.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: tps65911@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: tps65911@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: tps62361@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-beaver.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: tps65911@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: tps65911@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: tps62361@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: tps65911@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: tps65911@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: tps62361@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1154.15-1166.4: Warning (unique_unit_address_if_enabled): /usb@7d004000: duplicate unit-address (also used in node /usb-phy@7d004000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: pmic@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: touchscreen@41 (st,stmpe811): 'blocks', 'id', 'irq-gpio', 'irq-trigger', 'stmpe_adc', 'stmpe_touchscreen' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: touchscreen@41 (st,stmpe811): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: /i2c@7000d000/temp-sensor@4c: failed to match any schema with compatible: ['national,lm95245']
   arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dtb: regulator@60 (ti,tps62362): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
--
   arch/arm/boot/dts/nvidia/tegra30-ouya.dts:46.22-52.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1154.15-1166.4: Warning (unique_unit_address_if_enabled): /usb@7d004000: duplicate unit-address (also used in node /usb-phy@7d004000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: pmic@2d (ti,tps65911): 'wakeup-source' does not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: tps62361@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-ouya.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts:57.22-63.5: Warning (unit_address_vs_reg): /reserved-memory/linux,cma@80000000: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1110.15-1123.4: Warning (unique_unit_address_if_enabled): /usb@7d000000: duplicate unit-address (also used in node /usb-phy@7d000000)
   arch/arm/boot/dts/nvidia/tegra30.dtsi:1196.15-1208.4: Warning (unique_unit_address_if_enabled): /usb@7d008000: duplicate unit-address (also used in node /usb-phy@7d008000)
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: /pcie@3000: failed to match any schema with compatible: ['nvidia,tegra30-pcie']
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: /gmi@70009000: failed to match any schema with compatible: ['nvidia,tegra30-gmi']
>> arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: pmic@2d (ti,tps65911): 'pmic-sleep-hog', 'wakeup-source' do not match any of the regexes: '^(vcc(io|[1-7])-supply)$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: pmic@2d (ti,tps65911): regulators:vddctrl: Unevaluated properties are not allowed ('nvidia,tegra-cpu-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: core-regulator@60 (ti,tps62361): Unevaluated properties are not allowed ('nvidia,tegra-core-regulator' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: /kbc@7000e200: failed to match any schema with compatible: ['nvidia,tegra30-kbc', 'nvidia,tegra20-kbc']
   arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dtb: /ahub@70080000: failed to match any schema with compatible: ['nvidia,tegra30-ahub']
--
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:100.18-108.5: Warning (graph_child_address): /vop@1010c000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:126.18-134.5: Warning (graph_child_address): /vop@1010e000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
--
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:100.18-108.5: Warning (graph_child_address): /vop@1010c000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:126.18-134.5: Warning (graph_child_address): /vop@1010e000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm/boot/dts/rockchip/rk3066a-marsboard.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-marsboard.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-marsboard.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-marsboard.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-marsboard.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
--
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:100.18-108.5: Warning (graph_child_address): /vop@1010c000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm/boot/dts/rockchip/rk3066a.dtsi:126.18-134.5: Warning (graph_child_address): /vop@1010e000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm/boot/dts/rockchip/rk3066a-rayeager.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-rayeager.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-rayeager.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-rayeager.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/rockchip/rk3066a-rayeager.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
--
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/dpll5_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/sgx_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/cm@48004000/clockdomains/usbhost_clkdm: failed to match any schema with compatible: ['ti,clockdomain']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48320000/counter@0: failed to match any schema with compatible: ['ti,omap-counter32k']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48056000/dma-controller@0: failed to match any schema with compatible: ['ti,omap3630-sdma', 'ti,omap-sdma']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/target-module@48056000/dma-controller@0: failed to match any schema with compatible: ['ti,omap3630-sdma', 'ti,omap-sdma']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/1w@480b2000: failed to match any schema with compatible: ['ti,omap3-1w']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@4809c000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480b4000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480ad000: failed to match any schema with compatible: ['ti,omap3-hsmmc']
   arch/arm/boot/dts/ti/omap/omap3-echo.dtb: /ocp@68000000/mmc@480ad000/atheros@0: failed to match any schema with compatible: ['atheros,ath6kl']
--
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
--
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-base0033.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: lis331dlh@18 (st,lis331dlh): 'Vdd-supply', 'Vdd_IO-supply', 'st,click-single-x', 'st,click-single-y', 'st,click-single-z', 'st,click-thresh-x', 'st,click-thresh-y', 'st,click-thresh-z', 'st,irq1-click', 'st,irq2-click', 'st,max-limit-x', 'st,max-limit-y', 'st,max-limit-z', 'st,min-limit-x', 'st,min-limit-y', 'st,min-limit-z', 'st,wakeup-x-hi', 'st,wakeup-x-lo', 'st,wakeup-y-hi', 'st,wakeup-y-lo', 'st,wakeup-z-hi', 'st,wakeup-z-lo' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#
   arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb: lis331dlh@18 (st,lis331dlh): compatible: 'oneOf' conditional failed, one must be fixed:
   	['st,lis331dlh', 'st,lis3lv02d'] is too long
   	'st,lis331dlh' is not one of ['st,h3lis331dl-accel', 'st,lis2de12', 'st,lis2dw12', 'st,lis2hh12', 'st,lis2dh12-accel', 'st,lis2ds12', 'st,lis302dl', 'st,lis331dl-accel', 'st,lis331dlh-accel', 'st,lis3de', 'st,lis3dh-accel', 'st,lis3dhh', 'st,lis3l02dq', 'st,lis3lv02dl-accel', 'st,lng2dm-accel', 'st,lsm303agr-accel', 'st,lsm303c-accel', 'st,lsm303dl-accel', 'st,lsm303dlh-accel', 'st,lsm303dlhc-accel', 'st,lsm303dlm-accel', 'st,lsm330-accel', 'st,lsm330d-accel', 'st,lsm330dl-accel', 'st,lsm330dlc-accel']
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: power-controller@2d (ti,tps65910): '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm/boot/dts/ti/omap/am335x-icev2.dtb: tsc (ti,am3359-tsc): 'ti,wires' is a required property
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm_conf@0 (syscon): phy-gmii-sel: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-lxm.dtb: scm_conf@0 (syscon): clocks: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: regulator@12 (regulator-fixed): Unevaluated properties are not allowed ('reg', 'regulator-compatible' were unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
   arch/arm/boot/dts/ti/omap/am335x-moxa-uc-8100-me-t.dtb: rtc_wdt@68 (dallas,ds1374): $nodename:0: 'rtc_wdt@68' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
--
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: serial@0 (ti,am3352-uart): compatible: 'oneOf' conditional failed, one must be fixed:
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): ti,en-ck32k-xtal: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: /ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0: failed to match any schema with compatible: ['ti,am335-sdhci']
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: segment@100000 (simple-pm-bus): 'anyOf' conditional failed, one must be fixed:
   	'clocks' is a required property
   	'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dtb: segment@100000 (simple-pm-bus): $nodename:0: 'segment@100000' does not match '^bus(@[0-9a-f]+)?$'
   	from schema $id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: serial@0 (ti,am3352-uart): Unevaluated properties are not allowed ('rts-gpio' was unexpected)
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: tps@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-pdu001.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-phycore-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']
--
   	['ti,am3352-uart', 'ti,omap3-uart'] is too long
   	'ti,am3352-uart' is not one of ['ti,am64-uart', 'ti,j721e-uart']
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-regor-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
--
   	'ti,am654-uart' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): regulators: '#address-cells', '#size-cells', 'regulator@0', 'regulator@1', 'regulator@10', 'regulator@11', 'regulator@12', 'regulator@13', 'regulator@2', 'regulator@3', 'regulator@4', 'regulator@5', 'regulator@6', 'regulator@7', 'regulator@8', 'regulator@9' do not match any of the regexes: '^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$', '^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$', '^ldo[1-8]$', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): 'gpio-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: pmic@2d (ti,tps65910): '#gpio-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: scm@0 (ti,am3-scm): clockdomains: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: scm@0 (ti,am3-scm): $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/ti/omap/am335x-wega-rdk.dtb: /ocp/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am3-scm', 'simple-bus']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

