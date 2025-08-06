Return-Path: <linux-kernel+bounces-758217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF799B1CC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD4A7AC832
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E129B783;
	Wed,  6 Aug 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCphF2pP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D64273D94;
	Wed,  6 Aug 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509921; cv=none; b=NjBnioXS5DJbG5psMRQIckx1hGyfVpUj1hXplWyTS7/4OUruUSzcHc57mLr8nVwNzEWElTeNoVZrZX9epjo/noh4ps95sAJ1npSBswhrKSlouUHvibhQMXgYsBMdVzAtnP5iM3yIXAiYAsdxhy34dOpPIGkBApmPC1oJ5hWlc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509921; c=relaxed/simple;
	bh=+ow9HSlu8lyz0gxQMpcmr/8DfGMGyygEDZL6LsfYEtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rCfUOwygNG43VF3TNLLFcVzeuq1UT40NyU8Zv84T00FKZ2YkAhzHWK03hIKwX/FZewe3HKevm7eqoyFeZ9bJtnZjlM7ATTNwJAOBQ4nYmHDB0tDd5cm5aJxDPJ+4a3JGeCCR3TvZ/GYqdjSJLKLGmohO0J59njsrsm23WEaJZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCphF2pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDBC4CEE7;
	Wed,  6 Aug 2025 19:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754509920;
	bh=+ow9HSlu8lyz0gxQMpcmr/8DfGMGyygEDZL6LsfYEtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nCphF2pPonuDBS5AGHJQ5L++hkYBVM9CiQfoEN8tyUnnLI7TgGDmH+ib2JmKexCOf
	 csffpw/r6i3tGN0MWkDHyKaMsEBdOw0ibIrjLuCl1Xe4utkd0k2CAWYtpu7MfcacG2
	 xcpczwWhUA++bxAPG0AChP9av6gaQeHGDzfQNa1n/XMDvgURZjhm/Enmel2jBRVgjR
	 tRAQ9eyz8mKux3rQahmtibSDCpmg6WqXCKf70OJot8f5qilUUGDSFFp/7SXDpn7Hfp
	 CJMuI7O9M1+QnONyQrdFDB0vnbd98z3eoGsSjV3Ltjyw8b67JfOOlAT80JbUxkeKkF
	 UqgqAQcPJikyw==
Date: Wed, 6 Aug 2025 14:51:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000
 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
Message-ID: <20250806195159.GA11906@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508060850.8u61bAqj-lkp@intel.com>

[+cc Tengfei, author of qcs9100-ride.dts and qcs9100-ride-r3.dts,
Mrinmay, author of bf3ee3db23ed ("arm64: dts: qcom: sa8775p-ride: enable pcie nodes"),
Bart, author of sa8775p-ride-r3.dts]

On Wed, Aug 06, 2025 at 08:27:12AM +0200, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7881cd6886a89eda848192d3f5759ce08672e084
> commit: fbcbd66fddd2e9ad295d6e3707e2421f062727d5 dt-bindings: PCI: qcom,pcie-sa8775p: Document 'link_down' reset

fbcbd66fddd2 ("dt-bindings: PCI: qcom,pcie-sa8775p: Document 'link_down' reset")
is now upstream.

> date:   5 days ago
> config: arm64-randconfig-2051-20250801 (https://download.01.org/0day-ci/archive/20250806/202508060850.8u61bAqj-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project faa4c4c2dc804c31845d8f036345fac00e016f2d)
> dtschema version: 2025.6.2.dev4+g8f79ddd
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060850.8u61bAqj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508060850.8u61bAqj-lkp@intel.com/
> 
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
> --
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
>    arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
> --
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
> --
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): clock-names:0: 'nrt_bus' was expected
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: display-controller@ae01000 (qcom,sa8775p-dpu): Unevaluated properties are not allowed ('clock-names' was unexpected)
>    	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: ethernet@23000000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: ethernet@23040000 (qcom,sa8775p-ethqos): Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
>    	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c00000 (qcom,pcie-sa8775p): resets: [[51, 7]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): reset-names: ['pci'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
> >> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: pcie@1c10000 (qcom,pcie-sa8775p): resets: [[51, 12]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmumx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
>    arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: wcn6855-pmu (qcom,wcn6855-pmu): 'vddpmucx-supply' is a required property
>    	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

