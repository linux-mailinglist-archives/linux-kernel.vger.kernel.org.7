Return-Path: <linux-kernel+bounces-689557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32204ADC384
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93997A21FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F4273D7B;
	Tue, 17 Jun 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZiHCHOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF7143C61;
	Tue, 17 Jun 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145891; cv=none; b=HP4UTad1DFh8I4VJt4OdTKWmfM6E+eUEKMpeGpTVIABzKcU3aP2AsONYr6F23llMq7reZqM1Ue47uaFsgbmZGlxIDH9bLuDqJpkSdAdd9RK6Q6lFls7Uz2CNJFoP/uzSvU1n8/p5SgwSyTJ9gHsb6PZlvgPyikI6MZE/+JZBtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145891; c=relaxed/simple;
	bh=tyaDThqvTan4SFqZmuFuvgF7eC24WC/L2WkQ2brenYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwU8Jsv47QMV10lbskmTCktKkJM+7yT0XvRTkI3gD5sKfQq4/IPBDOS0SfqEDx0xol2pRs6U2v51XQGvTOUllZHAAURLDWfh4A12+5tezigPIButORDk3Fwiy3kYaY/Ruy6Uo1axaqJhRejNk8QW6CcWbfgV72Fq0x6ZkA10rRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZiHCHOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFFCC4CEE3;
	Tue, 17 Jun 2025 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750145890;
	bh=tyaDThqvTan4SFqZmuFuvgF7eC24WC/L2WkQ2brenYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZiHCHOxxfxaNdZR8gjpqWDQUGY2g3pW0iRrFiaNfKnj08kUpu9MS6Eki/fUZL8/B
	 UcdOHOkT6H2y+VdThwdsiAWBeQtf0BXMBCAgI1KDjxbcqUe4ALwXFv9FfjHq0CLJw3
	 cFObrxaFgCqXy9of6CxIcmDTFfHw83UuzIfTXt6W4nRL5G5RMyNjl2+L9jTX6hVJFK
	 lz+vJFnvnYWjCt230vl5NEDXuBsG0txXZYTbcZY7ppejmrLPB2sSnaZnpt2VyvQA9N
	 +4ycAa/ZCoNNKgt0t7E7nA1lMt+uZZwhEU63h6SWagtIBPdPKMf/gq1J701KiSFcsp
	 +4Wo1jzrOxVTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRQtR-000000000ke-0O49;
	Tue, 17 Jun 2025 09:38:05 +0200
Date: Tue, 17 Jun 2025 09:38:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for sa8775p
Message-ID: <aFEbXfl2GMGMBk_R@hovoldconsulting.com>
References: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
 <20250617021617.2793902-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617021617.2793902-2-quic_ziyuzhan@quicinc.com>

On Tue, Jun 17, 2025 at 10:16:14AM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.

> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -176,6 +176,8 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs615-qmp-gen3x1-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -197,8 +199,6 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs8300-qmp-gen4x2-pcie-phy

What about qcs8300, isn't this equally wrong for that platform?

> -              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>      then:
>        properties:
>          clocks:

Johan

