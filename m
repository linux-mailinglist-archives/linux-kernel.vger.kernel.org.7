Return-Path: <linux-kernel+bounces-753045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB57B17E16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CC01AA2269
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4E1CEAD6;
	Fri,  1 Aug 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zml6/eah"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7C5B21A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036250; cv=none; b=XKmjcfQ1v5lyAhaYK75xwu3X7vtwRw6g+IH9oRmVbdjzNg0R0rMx5lkoOclerkyGHduqHwV9GOsggekmiAFZutaikv7MoFqfsMKCoBQVkkfltgKqaA5GRWcviXDDtOinIi+ogR5R5BcS0aG7YXzsJB9XIQ0vEiUywzaEQ7BOdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036250; c=relaxed/simple;
	bh=9e5iYs2mtroQCYu2N6AsFFm9UXU9EBua5F+CU24L634=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pIvHxahhLSkD05BD7nk09uOU/cBKAZIZIJpC1nT0R3W+3zzw/s7ei0TfjEsd/sBAmv1N3nC57g6r5iO4QRVwM94gSqN8XYOMDJWo1AJXINhnXyJG8T1H6tGGEwmW8B68OWecmY22y3EslBSoydWAUlRJJCFg0s6I0ZRFuyb8XoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zml6/eah; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754036249; x=1785572249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9e5iYs2mtroQCYu2N6AsFFm9UXU9EBua5F+CU24L634=;
  b=Zml6/eahT4rsLKM37AGixBpFC7jXu2ISa0wC4sJ8bHyG8LGMKe7Z1Ypp
   xDKEgiRRfpY+fw5OY/CvBXwgx52jvHgoQWj96Dg/FU5OtqlkbIs4XzxIQ
   FnoJVWneqSvHxLIWfq1L4qvjvxx0aWMAQqxOH3b99AiGujWB6FYuHGMMi
   vwwbxOHql7S/p/wLptYLaQ/oYXJLizSW/BKGe8u+y2etPiVLEcZg5qTmZ
   ngXnenFrqqTktJdueca4lMUunvZn3os/PeEqDXnm3etZnvZcV1fEpTxCR
   v7WLEDyhx9Zr+iyYs8lMrDueTcAo/mLfx+8MtcN3qlWygev4sbFKyySIw
   Q==;
X-CSE-ConnectionGUID: piQAesqFQg2pu5E7af3VpA==
X-CSE-MsgGUID: DOYWXqgOQuilm6jeb4aScw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="60203828"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="60203828"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 00:59:38 -0700
X-CSE-ConnectionGUID: UY5YKdtsS528HwOyb0PRGA==
X-CSE-MsgGUID: JC/XWvz4T/CzdpllmIzaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163066860"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa007.fm.intel.com with ESMTP; 01 Aug 2025 00:59:36 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhkfu-0001At-17;
	Fri, 01 Aug 2025 07:59:34 +0000
Date: Fri, 1 Aug 2025 09:59:15 +0200
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Stefan Agner <stefan@agner.ch>
Subject: arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: dcu@2ce0000
 (fsl,ls1021a-dcu): 'display', 'display@0' do not match any of the regexes:
 '^pinctrl-[0-9]+$'
Message-ID: <202508010949.JIDIe4WV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2d282e1dfb3d8cb95b5ccdea43f2411f27201db
commit: 83e6769f80a1b8e1a97f8d1cecd8631b976fc009 dt-bindings: display: imx: convert fsl,dcu.txt to yaml format
date:   9 days ago
config: arm-randconfig-2051-20250730 (https://download.01.org/0day-ci/archive/20250801/202508010949.JIDIe4WV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010949.JIDIe4WV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010949.JIDIe4WV-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: watchdog@2ad0000 (fsl,imx21-wdt): big-endian: False schema does not allow True
   	from schema $id: http://devicetree.org/schemas/watchdog/fsl-imx-wdt.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: watchdog@2ad0000 (fsl,imx21-wdt): Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/fsl-imx-wdt.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: sai@2b50000 (fsl,vf610-sai): dma-names:1: 'tx' was expected
   	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: sai@2b60000 (fsl,vf610-sai): dma-names:1: 'tx' was expected
   	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: sai@2b60000 (fsl,vf610-sai): Unevaluated properties are not allowed ('dma-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
>> arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: dcu@2ce0000 (fsl,ls1021a-dcu): 'display', 'display@0' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/display/fsl,ls1021a-dcu.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: display-timings: 'mode0' does not match any of the regexes: '^pinctrl-[0-9]+$', '^timing'
   	from schema $id: http://devicetree.org/schemas/display/panel/display-timings.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: ethernet@2d10000 (fsl,etsec2): queue-group@2d10000: '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: ethernet@2d10000 (fsl,etsec2): queue-group@2d14000: '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: ethernet@2d10000 (fsl,etsec2): Unevaluated properties are not allowed ('queue-group@2d10000', 'queue-group@2d14000' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: ethernet@2d50000 (fsl,etsec2): queue-group@2d50000: '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

