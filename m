Return-Path: <linux-kernel+bounces-773895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45FB2AC11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACBE68708B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABC2367CD;
	Mon, 18 Aug 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGVRRJJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076C2264B0;
	Mon, 18 Aug 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528874; cv=none; b=k7IiHWwrrtIIfxumhsrbqjvTWxW1/CVRQtU9sqO+4ndFTOFEoFWld6NqD2bSbqtNhiJiqZPAOzYdeoxv/LWBoGdaRtCthjCm4RqqngIkPNArPghETa1FAXa3MGTiVOZud8ssogtvs/4gm7Pb+ZhIVTp5CCgIJxAR6zKFGIKDSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528874; c=relaxed/simple;
	bh=LFc1YiNOV2HvPL/yXZhgHCq5LYNPLTl74ZTaym00VFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIW4Q9QQ7Hc60koMrLedxSuFs9nryRDIMEhJGXdHTDm+7JqoOMnMobtN6SRHlt/7m8kPxzkH4ZIRAQ2blts6feicv6EU42f2ScYHPg7yQfzZnZeOnQxkPRDdqNkFdx90d1QK6qTOvwWlPygKoLkFMrYdJGrgDgMeRkijNNq/F7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGVRRJJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205BC4CEEB;
	Mon, 18 Aug 2025 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755528872;
	bh=LFc1YiNOV2HvPL/yXZhgHCq5LYNPLTl74ZTaym00VFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGVRRJJO/ik7ARGyhYK3IpIVfwQ/pSsQdElGOufMPEoUkcM/5tYKBkyixosRu5oj0
	 hKwADwthaldFnM4oqCy4ZqzCGjaY4tsfHy3KkPa6lo9YS5uT7ZQk4fa1Mg7M9ziCLT
	 XUQmAK0nz+tFK3oEM3ku78ALJHNgxZSQXlXJJLfjOTpxoGxd2bDph6BRqPYLjFe0b/
	 cH70GzAowq4qqGfIh0zdu5nCQSB5RcSQpxd788hIuFS/2GtBvvEFgsKzK1nGgqEdxG
	 SM4+f+wu4xKiNiH0tQlf9ouklCaAAiAjtBDgRaoaic/8fu7TDxSW0vJW6mAvq8BxRb
	 5HSrpPFxYEviQ==
Date: Mon, 18 Aug 2025 09:54:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: quic_vbadigan@quicinc.com, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, quic_mrana@quicinc.com,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the SM8750 QMP PCIe PHY Gen3 x2
Message-ID: <175552887070.1211494.12034577229167513641.robh@kernel.org>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-1-abf1c416dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809-pakala-v1-1-abf1c416dbaa@oss.qualcomm.com>


On Sat, 09 Aug 2025 15:29:16 +0530, Krishna Chaitanya Chundru wrote:
> Document the QMP PCIe PHY on the SM8750 platform.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


