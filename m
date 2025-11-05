Return-Path: <linux-kernel+bounces-885911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC5C343B9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CB218974C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13EF265CDD;
	Wed,  5 Nov 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbwQJck8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3520E005
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327968; cv=none; b=hRQxQlnCziJ9BND3poqyG1Ild04SFQQGvIXQtlzfZc6oB2ltMhN4cvNOqzLaMAhDVXEkqaGUmmkfVuZqtDn9Htfra6+YeZuEgo4BcO7BROziJylbpDBwiV071IoPExe5+bMgdxMFeACVFHsFejp+DAu4adCrDcgOtXskHDfce7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327968; c=relaxed/simple;
	bh=DmjVjaWiMY8UpTL9hVPonUUHOiMkNbCHM5Gk66euzD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JI5GbqD92ZZIXMxmkK8DTik3CvLGLkJMykBPCwQHnazanZTiEHF9+dmcxgTe7itFsmteCk9tT033HWpU4JVmxavibmw/Zh4f1+64zQSN4rQHeXfImDls0IrjCKn9Wt/ib8YxTRCej15ZgMcA3u6UI6XePNqooL0KLTX4XC8Cwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbwQJck8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762327964; x=1793863964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DmjVjaWiMY8UpTL9hVPonUUHOiMkNbCHM5Gk66euzD0=;
  b=EbwQJck85m7VmvRosQO2UAcTCzXNROvyPxqPcA0PYVNN8lAjdSx+vPGJ
   iIlu0/hooX/99MoHX2T4hV19F7RTA1S7UijsaVV4oddjFvWBUjNyOrZZ9
   jlg9Ge7aDA2B2qRPjUT9HOvbPjHmn/aSzlcoubJRCq6erSknpTrODmhx2
   JzzzBUfDH4p1r2rjekRB4Tw0gss9JtrChK114KIYQtR9lVW4grA1nw9Gv
   Y63BhZx9c/KfhL5unH54tNf4qsBz2jnmxgKRn1Y5016DYRc7h9XeO8yKr
   Cs2p7escXO4QVkntQ2K6Y4PBTBz7eTN3Vhw6M+Qk4JBW3Io4lJSZ1VSiW
   g==;
X-CSE-ConnectionGUID: Ku6sD3Y1QuiWnsGjBtFg6A==
X-CSE-MsgGUID: XNDVbowTSGWHOAwJpqWPzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75114860"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75114860"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:32:43 -0800
X-CSE-ConnectionGUID: ogA1tFEvToGeTv9J/+ZXtA==
X-CSE-MsgGUID: Scejnz2vS3i2axp8k4DHfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187830309"
Received: from igk-lkp-server01.igk.intel.com (HELO c2fcd27ee2f4) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2025 23:32:41 -0800
Received: from kbuild by c2fcd27ee2f4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vGY0V-000000002U4-1TJL;
	Wed, 05 Nov 2025 07:32:39 +0000
Date: Wed, 5 Nov 2025 08:32:26 +0100
From: kernel test robot <lkp@intel.com>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: failed
 to match any schema with compatible: ['loongson,loongson64-2core-2k1000']
Message-ID: <202511050803.aw2cBm3y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   284922f4c563aa3a8558a00f2a05722133237fe8
commit: 6428fcf27f0248b076b381408c98102f88564926 MIPS: dts: loongson: Add LS1B-DEMO board
date:   10 weeks ago
config: mips-randconfig-2052-20251031 (https://download.01.org/0day-ci/archive/20251105/202511050803.aw2cBm3y-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 20c323aa0e5dea6f3d340c721c5cee30801db850)
dtschema version: 2025.9.dev13+gc72762e0c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050803.aw2cBm3y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511050803.aw2cBm3y-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: failed to match any schema with compatible: ['loongson,loongson64-2core-2k1000']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: / (loongson,loongson64-2core-2k1000): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: cpu@0 (loongson,gs264): Unevaluated properties are not allowed ('#clock-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mips/cpus.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ehci@4,1:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ehci@4,1:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ohci@4,2:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ohci@4,2:interrupts:0: [19, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): sata@8,0:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): sata@8,0:interrupts:0: [19, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@9,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@9,0:interrupts:0: [0, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@a,0:interrupts:0: [1, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@b,0:interrupts:0: [2, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@c,0:interrupts:0: [3, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@d,0:interrupts:0: [4, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@e,0:interrupts:0:0: 5 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@e,0:interrupts:0: [5, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'device_type', 'ehci@4,1', 'gmac@3,0', 'gmac@3,1', 'ohci@4,2', 'pcie@9,0', 'pcie@a,0', 'pcie@b,0', 'pcie@c,0', 'pcie@d,0', 'pcie@e,0', 'sata@8,0' were unexpected)
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ehci@4,1:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ehci@4,1:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ohci@4,2:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): ohci@4,2:interrupts:0: [19, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): sata@8,0:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): sata@8,0:interrupts:0: [19, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@9,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@9,0:interrupts:0: [0, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@a,0:interrupts:0: [1, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@b,0:interrupts:0: [2, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@c,0:interrupts:0: [3, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@d,0:interrupts:0: [4, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@e,0:interrupts:0:0: 5 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000 (loongson,ls2k-pci): pcie@e,0:interrupts:0: [5, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: gmac@3,1 (pci0014,7a03.0): compatible:4: 'loongson, pci-gmac' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
--
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: / (loongson,loongson64c-4core-ls7a): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0:0: 49 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0: [49, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0:0: 48 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0: [48, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0:0: 51 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0: [51, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0:0: 50 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0: [50, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0: [16, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0:0: 17 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0: [17, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0:0: 29 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0: [29, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0:0: 28 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0: [28, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0:0: 58 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0: [58, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0:0: 32 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0: [32, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0:0: 33 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0: [33, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0:0: 34 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0: [34, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0:0: 35 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0: [35, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0:0: 36 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0: [36, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0:0: 37 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0: [37, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0:0: 40 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0: [40, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0:0: 41 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0: [41, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0:0: 42 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0: [42, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0:0: 43 is not one of [1, 2, 3, 4]
--
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0: [43, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0:0: 38 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0: [38, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0:0: 39 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0: [39, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dc@6,1', 'device_type', 'ehci@4,1', 'ehci@5,1', 'gmac@3,0', 'gmac@3,1', 'gpu@6,0', 'hda@7,0', 'msi-parent', 'ohci@4,0', 'ohci@5,0', 'pcie@10,0', 'pcie@11,0', 'pcie@12,0', 'pcie@13,0', 'pcie@14,0', 'pcie@9,0', 'pcie@a,0', 'pcie@b,0', 'pcie@c,0', 'pcie@d,0', 'pcie@e,0', 'pcie@f,0', 'sata@8,0', 'sata@8,1', 'sata@8,2' were unexpected)
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0:0: 49 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0: [49, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0:0: 48 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0: [48, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0:0: 51 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0: [51, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0:0: 50 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0: [50, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0: [16, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0:0: 17 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0: [17, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0:0: 29 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0: [29, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0:0: 28 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0: [28, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0:0: 58 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0: [58, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0:0: 32 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0: [32, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0:0: 33 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0: [33, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0:0: 34 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0: [34, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0:0: 35 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0: [35, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0:0: 36 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0: [36, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0:0: 37 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0: [37, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0:0: 40 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0: [40, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0:0: 41 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0: [41, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0:0: 42 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0: [42, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0:0: 43 is not one of [1, 2, 3, 4]
--
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0: [43, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0:0: 38 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0: [38, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0:0: 39 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0: [39, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: gmac@3,1 (pci0014,7a03.0): compatible:4: 'loongson, pci-gmac' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
--
>> arch/mips/boot/dts/loongson/loongson64c_4core_rs780e.dtb: / (loongson,loongson64c-4core-rs780e): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64c_4core_rs780e.dtb: /bus@10000000/isa@18000000/rtc@70: failed to match any schema with compatible: ['motorola,mc146818']
--
>> arch/mips/boot/dts/loongson/loongson64c_8core_rs780e.dtb: / (loongson,loongson64c-8core-rs780e): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64c_8core_rs780e.dtb: /bus@10000000/isa@18000000/rtc@70: failed to match any schema with compatible: ['motorola,mc146818']
--
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: / (loongson,loongson64g-4core-ls7a): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0:0: 49 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0: [49, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0:0: 48 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0: [48, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0:0: 51 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0: [51, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0:0: 50 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0: [50, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0: [16, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0:0: 17 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0: [17, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0:0: 29 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0: [29, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0:0: 28 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0: [28, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0:0: 58 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0: [58, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0:0: 32 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0: [32, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0:0: 33 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0: [33, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0:0: 34 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0: [34, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0:0: 35 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0: [35, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0:0: 36 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0: [36, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0:0: 37 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0: [37, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0:0: 40 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0: [40, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0:0: 41 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0: [41, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0:0: 42 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0: [42, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0:0: 43 is not one of [1, 2, 3, 4]
--
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0: [43, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0:0: 38 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0: [38, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0:0: 39 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0: [39, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dc@6,1', 'device_type', 'ehci@4,1', 'ehci@5,1', 'gmac@3,0', 'gmac@3,1', 'gpu@6,0', 'hda@7,0', 'msi-parent', 'ohci@4,0', 'ohci@5,0', 'pcie@10,0', 'pcie@11,0', 'pcie@12,0', 'pcie@13,0', 'pcie@14,0', 'pcie@9,0', 'pcie@a,0', 'pcie@b,0', 'pcie@c,0', 'pcie@d,0', 'pcie@e,0', 'pcie@f,0', 'sata@8,0', 'sata@8,1', 'sata@8,2' were unexpected)
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0:0: 49 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@4,0:interrupts:0: [49, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0:0: 48 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@4,1:interrupts:0: [48, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0:0: 51 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ohci@5,0:interrupts:0: [51, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0:0: 50 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): ehci@5,1:interrupts:0: [50, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,0:interrupts:0: [16, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0:0: 17 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,1:interrupts:0: [17, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): sata@8,2:interrupts:0: [18, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0:0: 29 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gpu@6,0:interrupts:0: [29, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0:0: 28 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): dc@6,1:interrupts:0: [28, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0:0: 58 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): hda@7,0:interrupts:0: [58, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts:0: [12, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,0:interrupts: [[12, 4], [13, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts:0: [14, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): gmac@3,1:interrupts: [[14, 4], [15, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0:0: 32 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@9,0:interrupts:0: [32, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0:0: 33 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@a,0:interrupts:0: [33, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0:0: 34 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@b,0:interrupts:0: [34, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0:0: 35 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@c,0:interrupts:0: [35, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0:0: 36 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@d,0:interrupts:0: [36, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0:0: 37 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@e,0:interrupts:0: [37, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0:0: 40 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@f,0:interrupts:0: [40, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0:0: 41 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@10,0:interrupts:0: [41, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0:0: 42 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@11,0:interrupts:0: [42, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0:0: 43 is not one of [1, 2, 3, 4]
--
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@12,0:interrupts:0: [43, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0:0: 38 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@13,0:interrupts:0: [38, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0:0: 39 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: pci@1a000000 (loongson,ls7a-pci): pcie@14,0:interrupts:0: [39, 4] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@4,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ohci@5,0: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/ehci@5,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,1: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/sata@8,2: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gpu@6,0: failed to match any schema with compatible: ['pci0014,7a15.0', 'pci0014,7a15', 'pciclass030200', 'pciclass0302']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/dc@6,1: failed to match any schema with compatible: ['pci0014,7a06.0', 'pci0014,7a06', 'pciclass030000', 'pciclass0300']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/hda@7,0: failed to match any schema with compatible: ['pci0014,7a07.0', 'pci0014,7a07', 'pciclass040300', 'pciclass0403']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass020000', 'pciclass0200', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: gmac@3,1 (pci0014,7a03.0): compatible:4: 'loongson, pci-gmac' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.1', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@f,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@10,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@11,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@12,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@13,0: failed to match any schema with compatible: ['pci0014,7a29.1', 'pci0014,7a29', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
   arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: /bus@10000000/pci@1a000000/pcie@14,0: failed to match any schema with compatible: ['pci0014,7a19.1', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
--
>> arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dtb: / (loongson,loongson64v-4core-virtio): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dtb: /hypervisor: failed to match any schema with compatible: ['linux,kvm']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

