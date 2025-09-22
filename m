Return-Path: <linux-kernel+bounces-827692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A84B926C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8664B1905FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED4314B95;
	Mon, 22 Sep 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMz2p8UH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB1314B72;
	Mon, 22 Sep 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562073; cv=none; b=uROLOr53XzE8pghbL7YffPUzh6/w7A1wTSNdmkr5jVyNHKpnAdaEm2si89RGDtWtmcDN1gRVAE6mTaM1Z7VimnnaO8PjmWHtdwd7q3tPgYt/qdnMbdUwxgcSvuwqCqzScWXIh4etQrT3kSdy+Ff/mzoBwrF4xAmcqtftR+OGATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562073; c=relaxed/simple;
	bh=5lJB8tk6gm0Z5L41/sm06dw0UVyCuVO3QM5zofxo82Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tCZRP19q2kBs/4Kuz3lL3YxNFrVlMQSxZgcl2Wfj3NWIKiGGVMWCoJl6djbho08XBtxYBlAhe+6SkWxyi6aFJ+5NiN0gNiXf5JbEbu1TGRwfjzbVxItPRzKKP3r8A2DBer2moZyRkP/JNrLuasiyJVjQpplL726Vtlv8M36s/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMz2p8UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E57EC113D0;
	Mon, 22 Sep 2025 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562073;
	bh=5lJB8tk6gm0Z5L41/sm06dw0UVyCuVO3QM5zofxo82Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tMz2p8UHjG++4yoSSDmd8BLseobavRr/kuYv1CdkCrzwNw2hGkZUbIk9VvAiT4vwM
	 bKDVbnaZyblQDAhZd/CCFRNpi9zXH+9mzv+Yw7sTRa+sQz9qvDLSMLqwwL00fZw26s
	 PFENvo/IrpZ0B0lZmC3p9m/pzJAfjAbocdtu6xeDEGhvIqIDLT/nfrGRYxOG5r1XFc
	 8teifN/vSdEC+ElO9DDwRCvY/G9a8FHcV3TnAhB8c5Q+I6Ko1DW5cQ2IXyBUSc571x
	 q7iVqu7jafE2GqqiLp/9BW1OlB+BCtwKalm5oSUiOCA7r3FNE1KnESXSia7SlOPQmZ
	 fGYz/HmfDX5Pg==
Date: Mon, 22 Sep 2025 12:27:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 Stephen Boyd <sboyd@kernel.org>
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
References: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
Message-Id: <175856184058.499994.8575309202132748563.robh@kernel.org>
Subject: Re: [PATCH v7 0/3] Register the STM32MP25 RCC driver as an access
 controller.


On Mon, 22 Sep 2025 10:12:17 +0200, Clément Le Goffic wrote:
> The STM32MP25 RCC peripheral as an access controller is allowed to know
> whether the clocks are secured or not.
> The STM32MP25 RCC peripheral knows about the clock secure configuration
> of all non RIF-aware peripheral.
> In parallel all the RIF-aware peripheral configuration information
> are known by the RIFSC peripheral which is already an access
> controller.
> 
> This v7 is a subset of the v6 and other prior versions, split to simplify
> the review and merging process.
> 
> Changes in v7:
> - None
> - Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-2-ce082cc801b5@gmail.com/
> 
> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
> ---
> Clément Le Goffic (3):
>       dt-bindings: stm32: stm32mp25: add `#access-controller-cells` property
>       clk: stm32mp25: add firewall grant_access ops
>       arm64: dts: st: set rcc as an access-controller
> 
>  .../bindings/clock/st,stm32mp25-rcc.yaml           |  7 ++++
>  arch/arm64/boot/dts/st/stm32mp251.dtsi             |  1 +
>  drivers/clk/stm32/clk-stm32mp25.c                  | 40 +++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
> ---
> base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
> change-id: 20250916-b4-rcc-upstream-8a8ea3af6a0d
> prerequisite-change-id: 20250916-b4-firewall-upstream-dfe8588a21f8:v7
> prerequisite-patch-id: 1ead960f405c7a2dcc9111acd0bb4c95ed33954f
> 
> Best regards,
> --
> Clément Le Goffic <legoffic.clement@gmail.com>
> 
> 
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
 Base: using specified base-commit 07e27ad16399afcd693be20211b0dfae63e0615f
 Deps: looking for dependencies matching 1 patch-ids
 Deps: Applying prerequisite patch: [PATCH v7] bus: firewall: move stm32_firewall header file in include folder

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/st/' for 20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com:

arch/arm64/boot/dts/st/stm32mp235f-dk.dtb: clock-controller@44200000 (st,stm32mp25-rcc): '#access-controller-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/st,stm32mp25-rcc.yaml#






