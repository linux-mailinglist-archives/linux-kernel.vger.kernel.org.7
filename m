Return-Path: <linux-kernel+bounces-831552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E2B9CFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4AC7B12C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFF2DEA80;
	Thu, 25 Sep 2025 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5e0RFMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA92DE702;
	Thu, 25 Sep 2025 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763095; cv=none; b=qBF3jc1eBPM+DLFWKRW/KjarEDO+eJ6rF/iKrL1io9qcWrl1bUUKT6oaVgNNcKfsamJJspWN3nCg6V/cP3LRD0PIE4IQUSeeqH1EMTRCj0juowHDGLaxgX/X2Apkk0RCOcW3dDic96wGBAOaGQ9ZvhzHvg77GeGuxPVxX+AHm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763095; c=relaxed/simple;
	bh=+Rq7hiUDbbMid1ZpoqEKumtl/xgLrffLe02IvsOC8CM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=q4u1Jz73oicR3aq1UpbTS8bYg1GVXgxcwRWqi3tPFZHgs7+OtWxXOmiOqsJDlWHyVjMHOrpdgzPjxMQiuDiHmrI2AeB9Mc/OVBYVS3NgXbrsswgcSsDbr8AUpek8JOEOLvd3GxYhRZj1+TRg29A+pUPZVrW/hMO/VKSgJFF5oTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5e0RFMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC3DC4CEE7;
	Thu, 25 Sep 2025 01:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763095;
	bh=+Rq7hiUDbbMid1ZpoqEKumtl/xgLrffLe02IvsOC8CM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P5e0RFMBUDkFAF0bn9qLxqA8XVllUHPlgPJYT5cWvu/lTZEmC/wwC+3kWbFSDFO4l
	 vjMsUV0DylmtvJiM+uPTpLKGsF7my1iaI+o43VXf1tQYHyy1Y2HfOddcR2bLKRCfVL
	 ZiFPG51reUSpv9a561Rpx2MXnOVhAn6K8VW/HCBnAVtULdBqctRWSPhCH5hIGtoYgY
	 sDHgnyKr5MM1opo6E1zBeXMgLbtOIGPso0TQlWgh/ghOElLxSTpONWrK2dmFjprF+y
	 J1joLBxJ8OG1SE83hJMoAqsXQKxKskcnnQZFjiXgDMWW/nKIA8IYjeetF/m4LDCRlv
	 ISmSkDAQdi37Q==
Date: Wed, 24 Sep 2025 20:18:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, kristo@kernel.org, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, upstream@lists.phytec.de, conor+dt@kernel.org, 
 aradhya.bhatia@linux.dev, vigneshr@ti.com, nm@ti.com, 
 linux-arm-kernel@lists.infradead.org
To: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250924143916.2023919-1-w.egorov@phytec.de>
References: <20250924143916.2023919-1-w.egorov@phytec.de>
Message-Id: <175876282860.3268733.8113461594217309147.robh@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62: Add support for AM625
 OLDI IO Control


On Wed, 24 Sep 2025 16:39:14 +0200, Wadim Egorov wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Add TI DSS OLDI-IO control registers for AM625 DSS. This is a region of
> 12 32bit registers found in the TI AM625 CTRL_MMR0 register space[0].
> They are used to control the characteristics of the OLDI DATA/CLK IO as
> needed by the DSS display controller node.
> 
> [0]: https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-58-g7c1d13a14e61 (best guess, 1/2 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250924143916.2023919-1-w.egorov@phytec.de:

arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-sk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@0:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dtb: dss@30200000 (ti,am625-dss): oldi-transmitters:oldi@1:ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#






