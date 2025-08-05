Return-Path: <linux-kernel+bounces-757006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A83B1BC32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D130C185B37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AAC291C12;
	Tue,  5 Aug 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUzG/4VM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9925A65A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430811; cv=none; b=bYtiJjQmLOTkfbt3iKQC7zqE6lR+CLECF4DQndw0viU8Hk82ucKhhzihiIHtsWv4G00oxD1efjZQRUfGb/8rfvH4WAd7cyARU1ZhsNQEDFuWrXW7u3YxiY/pLJV1AgjfxdBzEhkdeS1PgHupE4WJl2vfJY3jmrHiMuwNjTeTtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430811; c=relaxed/simple;
	bh=4JkCc9EI0vtFKOLONtdukfQ3yooWg+K+OYMrEy3D2Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TegICQRzTOM0a9viTXJW1mXQSlL9ZjSZHMgdux8uyp64NNZqgtY3sjv2J14xIDyeMTuC0ve+y8Z5hGyFfJz2y2LSU2+xq7dSqqstJR+WTY391t1Kf+SQdB3BT7/d2ukhZ4ypHhlnBIo4ZKgVptxPvRV4bfeBgqTveMRJc1SN+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUzG/4VM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754430809; x=1785966809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4JkCc9EI0vtFKOLONtdukfQ3yooWg+K+OYMrEy3D2Y0=;
  b=fUzG/4VM6/LJkFxwxwfHea+fZjzC1Crnp2zm0JvXDyp3cGlkDIVX/xzA
   k21lOUQgRDVC5wRZ26EfpP6CHlyeSDypb6ZRj1+XjHwF5Z2wtgQLP06r7
   mxfaX6vbTaz5Re68/ySWvtvMAJLYfASsnlzTQStbU9KFCvbD3LcUbQYTI
   uSfrFKQBZlBSj99j3NRmqezWbBwWpju/6YdtSXlE1mjawWVn0Re4G/wGX
   cbYpcux4RT6iIpmqOPkgufPv62BhZZRM6sx5rWLB1Ssp253LFl9piZQCr
   DMdDaV7YIdNAk8Q/ypNoiHOPm/mv/UzAgmiLn+FgNbBhkjOiS/jxWnQ4V
   A==;
X-CSE-ConnectionGUID: PV+0AHsJQPikkU08Frp5Hg==
X-CSE-MsgGUID: 7hM7fA2+QSKVXd6worECMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60571068"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60571068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:53:29 -0700
X-CSE-ConnectionGUID: LDt6RKIWRAeD+2u7NknNig==
X-CSE-MsgGUID: m9mbKHfHR7OnSvslWTQrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="201784853"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Aug 2025 14:53:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujPb3-0000oE-14;
	Tue, 05 Aug 2025 21:53:25 +0000
Date: Wed, 6 Aug 2025 05:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: arch/mips/boot/dts/img/pistachio_marduk.dtb: timer@18102000
 (img,pistachio-gptimer): clock-names:1: 'slow' was expected
Message-ID: <202508060557.AmMGUVkU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
commit: e7ddb13fa6203cad3546104c4f5edbbc70cc59cf dt-bindings: timer: Convert img,pistachio-gptimer to DT schema
date:   3 months ago
config: mips-randconfig-052-20250806 (https://download.01.org/0day-ci/archive/20250806/202508060557.AmMGUVkU-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 8.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060557.AmMGUVkU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060557.AmMGUVkU-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: flash@0 (spansion,s25fl016k): Unevaluated properties are not allowed ('compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: /spi@18101000/flash@0: failed to match any schema with compatible: ['spansion,s25fl016k', 'jedec,spi-nor']
   arch/mips/boot/dts/img/pistachio_marduk.dtb: /pwm@18101300: failed to match any schema with compatible: ['img,pistachio-pwm']
   arch/mips/boot/dts/img/pistachio_marduk.dtb: uart@18101400 (snps,dw-apb-uart): $nodename:0: 'uart@18101400' does not match '^serial(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/serial/snps-dw-apb-uart.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: uart@18101500 (snps,dw-apb-uart): $nodename:0: 'uart@18101500' does not match '^serial(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/serial/snps-dw-apb-uart.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: /pinctrl@18101c00: failed to match any schema with compatible: ['img,pistachio-system-pinctrl']
>> arch/mips/boot/dts/img/pistachio_marduk.dtb: timer@18102000 (img,pistachio-gptimer): clock-names:1: 'slow' was expected
   	from schema $id: http://devicetree.org/schemas/img,pistachio-gptimer.yaml#
>> arch/mips/boot/dts/img/pistachio_marduk.dtb: timer@18102000 (img,pistachio-gptimer): clock-names: ['fast', 'sys'] is too short
   	from schema $id: http://devicetree.org/schemas/img,pistachio-gptimer.yaml#
>> arch/mips/boot/dts/img/pistachio_marduk.dtb: timer@18102000 (img,pistachio-gptimer): clocks: [[3, 4], [4, 18]] is too short
   	from schema $id: http://devicetree.org/schemas/img,pistachio-gptimer.yaml#
>> arch/mips/boot/dts/img/pistachio_marduk.dtb: timer@18102000 (img,pistachio-gptimer): interrupts: [[0, 60, 4]] is too short
   	from schema $id: http://devicetree.org/schemas/img,pistachio-gptimer.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: /ir@18102200: failed to match any schema with compatible: ['img,ir-rev1']
   arch/mips/boot/dts/img/pistachio_marduk.dtb: usb@18120000 (snps,dwc2): 'clocks' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/dwc2.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: usb@18120000 (snps,dwc2): 'clock-names' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/dwc2.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: mmc@18142000 (img,pistachio-dw-mshc): clock-names:0: 'biu' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#
   arch/mips/boot/dts/img/pistachio_marduk.dtb: mmc@18142000 (img,pistachio-dw-mshc): clock-names:1: 'ciu' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

