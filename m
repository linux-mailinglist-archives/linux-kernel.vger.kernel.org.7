Return-Path: <linux-kernel+bounces-757295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1C3B1C06A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66802189EC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4419211491;
	Wed,  6 Aug 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSJ8l+VJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0F203710
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461659; cv=none; b=GHGfCDGq+2qkkDPrT2Kt/XtdX8YYuWj5jQW25q4QO10e7KrQLFfkmCUJ3U2ka0b9B0oW6Hb5Iwu+seRBjjZJK0ODLr8Uk/F/LW6FRzeKh68v+taPLaMpuBF8ZpuXKch3Rdr9BzTRTQOhWaV7vDnim6+4Br0lFn3XMXDhakDn3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461659; c=relaxed/simple;
	bh=UBnOuuOHOX2RliooY9PseUZTarA3eiPj7/y6gH+ALs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lERRt/cx62J4o4W2MrIdk+Tm1qGS5BWRZBW49t5vsN+Z1FUzQZLWq+MYwIdZ4ibpImsz1QoYBrTx9Wu0wvckYLeEJg83GbOPNbDr3p77DchHfGIv8fvuFgpIFlIUMAvfN0wixg9TkzqPVV4vgpUQs9GvRVS05+Yh4SRTdi8tguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSJ8l+VJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754461658; x=1785997658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UBnOuuOHOX2RliooY9PseUZTarA3eiPj7/y6gH+ALs8=;
  b=dSJ8l+VJUPbFw5QJol+grH/JV1ZmcFOgWbSwPIFXXjXXDTvIWZtmKXHr
   bG5XAjLq/mcyePWdxB3a+PR+xqcsJIHy1yqcMLFblw6TDNjVpFWLHCaJS
   XQAg+hjesfcGk1yrjDyywh3RFiAKa70dG9cl2VdAqDglsz6lWxARx4yoE
   4h7427K6uwK/Yb2D6UcRCiD2xIjFbcV3+PhZimkIGFT9hZQO1FIyWLcf2
   BUbE/188oXzbHC5zAgG0ZpJKUOQapZ3WQEP25AIUXZcWonClK0IUYU3vN
   bmWPzXp51dAjbm+RvLFsRDDtjip4NLGbaKeIdF8I4n460JCFwcjJDXnt6
   A==;
X-CSE-ConnectionGUID: gK0UKVBQT4iB4AyKidudfA==
X-CSE-MsgGUID: Ma5HIO6OSSGgytV30NTn2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="79317341"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79317341"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 23:27:38 -0700
X-CSE-ConnectionGUID: Rjt8xqdvTnaX/Z+DPYHaSQ==
X-CSE-MsgGUID: F4IuNS92SaSH89nWxXXwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169142023"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2025 23:27:35 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujXca-00029L-2O;
	Wed, 06 Aug 2025 06:27:32 +0000
Date: Wed, 6 Aug 2025 08:27:12 +0200
From: kernel test robot <lkp@intel.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000
 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
Message-ID: <202508060850.8u61bAqj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7881cd6886a89eda848192d3f5759ce08672e084
commit: fbcbd66fddd2e9ad295d6e3707e2421f062727d5 dt-bindings: PCI: qcom,pcie-sa8775p: Document 'link_down' reset
date:   5 days ago
config: arm64-randconfig-2051-20250801 (https://download.01.org/0day-ci/archive/20250806/202508060850.8u61bAqj-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project faa4c4c2dc804c31845d8f036345fac00e016f2d)
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060850.8u61bAqj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060850.8u61bAqj-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
--
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
   arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
--
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
--
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
   	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

