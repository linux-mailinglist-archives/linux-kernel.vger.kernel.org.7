Return-Path: <linux-kernel+bounces-752676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905FB17948
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F121884907
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3F27EFEE;
	Thu, 31 Jul 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1gbCsJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A49153598;
	Thu, 31 Jul 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003359; cv=none; b=NeB3WNP9lKGoW/23ZpEpvZoms/B3ZJU+DCOEdvGMoo5op7NB0DU74RqCrGrOx/GahDrOADou9Q2s0HzbimF6ozMnhPuGCI/CZSPv2jIq39fqxyZxSDgYDzwiJIEguxaC87Nk239aWVbDRY9hwF4kzroHMAlYRHH+NuiW86K+U+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003359; c=relaxed/simple;
	bh=YqRSlAt7WN/xNNWKo7aGLNNxJ4KOaokDg2AQCgMVt7w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hqQfNMaCAVRD9YQCIim4Tj2xyJ25Fi1Y7Ssgha9DUyWrP4uij5udhB2Wb2XbODtdE4e+lBSqtMOYhe++qU2kNqrceLwBABfArJ39NamtkrNcFLlG0F87kFKnwvSGCY6OkGUNnvcKxw3tMhAkIG7RiLIQllj4V09tNcclQ24ZXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1gbCsJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A3C4CEF4;
	Thu, 31 Jul 2025 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003359;
	bh=YqRSlAt7WN/xNNWKo7aGLNNxJ4KOaokDg2AQCgMVt7w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=j1gbCsJSpCt44tL3bNNgXlu94UG9AyBvz9GyWFRDcyS2xS3cNFAs/qyp6c09sEZN1
	 keN7YSiboakqUIZwk7vaAworQPl/VoOr8lr4UsMFUJ80l3LA8DIReIV50cQqGvPWXp
	 E1cqwB4LRH/hRFamALu26o64MUfkndNsbMnQquGypxPPEsEbpAEZlIzV2bs6r9GY0m
	 uX26CLOKlEEvahI/O4jBDdE2aNvQFjxvHOxZdBn2qBjiZYZ0budDYJg0p0ShhSk86c
	 C9eMOTUWQLaHHE2lwvhwo6zeMRqwdenThbi4x831iBby+wjqDynHyvLA3dRw9mmGRz
	 pPqVswV1DGQOw==
Date: Thu, 31 Jul 2025 18:09:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
 Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Darren Etheridge <detheridge@ti.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Tero Kristo <kristo@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>
To: Brandon Brnich <b-brnich@ti.com>
In-Reply-To: <20250731221622.2187892-1-b-brnich@ti.com>
References: <20250731221622.2187892-1-b-brnich@ti.com>
Message-Id: <175400322420.2681610.16971695466089884745.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder


On Thu, 31 Jul 2025 17:16:22 -0500, Brandon Brnich wrote:
> This adds the node for E5010 JPEG Encoder. E5010 is a stateful JPEG Encoder
> present in J722s SoC, supporting baseline encoding of semiplanar based
> YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
> supported from 64x64 to 8kx8k.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
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
 Base: tags/next-20250729 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250731221622.2187892-1-b-brnich@ti.com:

arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: e5010@fd20000 (img,e5010-jpeg-enc): 'clock-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: e5010@fd20000 (img,e5010-jpeg-enc): 'clock-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#






