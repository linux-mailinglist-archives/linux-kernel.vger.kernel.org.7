Return-Path: <linux-kernel+bounces-753953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B413B18A99
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03BE1AA1B48
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77719F42D;
	Sat,  2 Aug 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+Ebml+6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8C5A79B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754106412; cv=none; b=aF4hIV626uYF7nYqtHJExD8ENwIiMZrZ3WfzsnIttq5wo+DN2PZDnfHgrAgS8vnP+VPHeMPhs0eyatyg0or8e7lpH9UAi/QhuaBx/UsY/m3ErvK/UlGaQJuQ96Q7DfHLs1jtV79akuPr8iNWFSxq3dNtJYuVbzPe1a7VAk8jt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754106412; c=relaxed/simple;
	bh=Xz08RJl+nGeIpCmRX/DmUxn/i02ZnkqaePl5egtU4Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=enBDaEdZvrQfzmnaQv9l8aIHp6tVYIbhWGIBNJbuObhdrTYDhlp/2oFrEz9uOxU+4gA3LJd5kSAEz2wMU0GFxOWZZuA2FOw4akto85bZ/p5BCLWHslN4b9bVSCd+VH2TGhmxgpdXdeg8ouui+16nJOIKBru2Fp4NiuJ13SfIU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+Ebml+6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754106410; x=1785642410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xz08RJl+nGeIpCmRX/DmUxn/i02ZnkqaePl5egtU4Lg=;
  b=S+Ebml+63cUuGlw4FDdwyyfk2oZONB4Lo+NW4H5N6ZYqrrDe4X0yF6eb
   dBmAdiO6oSxWi5iC87NA/mq4qSrcmRc/lNtcGTgByVbojz3p3wMnGDvSk
   RCHiNHZkvpxOX5/+r1nhERqrBOt9qGIU6ln5svKgrUaq71FU7NgtYAORf
   aZXiEBzc8TlxdXFzTR9t+S0+9PR4e48fGB3vw/Lw3xjnAb6Pvzu2apy6F
   OunCuD76ZgSxV8u9v+/0vxvwVsM+5Mjp7LgNVuSQLZhy2yDnt6D64qSvL
   hD0lMVhyQtwxqWjOuJjdXtRrjSUEJ4Foabu9DrKBs1wWOo4UtHNX9I/1b
   w==;
X-CSE-ConnectionGUID: qpCdYv5DTBW27gZh17xpUg==
X-CSE-MsgGUID: FV7b1QBSTkqnNgom/iWCMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56412267"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56412267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 20:46:49 -0700
X-CSE-ConnectionGUID: AaBIy9WEQr6BBLbXONf57A==
X-CSE-MsgGUID: 6iihsDG+SRadZMgkmDa64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163409149"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa009.jf.intel.com with ESMTP; 01 Aug 2025 20:46:48 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ui3Cm-0001LV-3B;
	Sat, 02 Aug 2025 03:46:44 +0000
Date: Sat, 2 Aug 2025 05:46:16 +0200
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Stefan Agner <stefan@agner.ch>
Subject: arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: dcu@2ce0000
 (fsl,ls1021a-dcu): 'display', 'display@0' do not match any of the regexes:
 '^pinctrl-[0-9]+$'
Message-ID: <202508020554.a0GeZ77L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d6f38c12396397e48092ad9e8a4d7be4de51b942
commit: 83e6769f80a1b8e1a97f8d1cecd8631b976fc009 dt-bindings: display: imx: convert fsl,dcu.txt to yaml format
date:   10 days ago
config: arm-randconfig-2051-20250730 (https://download.01.org/0day-ci/archive/20250802/202508020554.a0GeZ77L-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508020554.a0GeZ77L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508020554.a0GeZ77L-lkp@intel.com/

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

