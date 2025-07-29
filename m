Return-Path: <linux-kernel+bounces-750029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33225B15616
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B490547D92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A06287518;
	Tue, 29 Jul 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUJn1kRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81E19D8BC;
	Tue, 29 Jul 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832435; cv=none; b=BdNgwD/YckM8A54xdkE33Ep6t59hRABRXRNnCJ9fNbufY+koJHbK1mWxcGNA6A92RNtcJrag2cR/SSsYy39GduVf765OthHkXljH1+C1pOj/aQDUtE4X051u9T8mgS143PZNf77SeTj1tOY41CBCMuRE1qVwCd5uGyGnor0dNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832435; c=relaxed/simple;
	bh=wyEt2fkgpUhHTrACpazhdhQaWVGoe9NGCw65Llk9rNA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HU7amomMRotS4G9dnt6BXPlf7BdK23Egr/1xgeda4cdXizcYjITj6/qn6jtOCM780FA7ofyBmJa+kaggE229N25FgVXZMa3GM/GNJYvY//PySnuYs2Pj2rCSmvCqtg69eL6/oxH68K4E0WykM2Qmn8iz6DVc+81NhHsKFXhBH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUJn1kRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC0C4CEF6;
	Tue, 29 Jul 2025 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832434;
	bh=wyEt2fkgpUhHTrACpazhdhQaWVGoe9NGCw65Llk9rNA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pUJn1kRfSR10kP/BkVHd3TvO+QCQMODJt9U6F5ONDV+SNQ7RSSrJwHhdFE0fT2p5g
	 BpcXDnJkXvLsX/+U9KuUqjKurQzqqrs4x81WaZxxB9ogLEphNaylOuXA1mFdjJZpSR
	 VIpO0HkHSDuA8FYdU9/ol0OVtXTSJXbRcY587YqkyS1Wcu+5Lh0PE6nOxcSjx/eCVA
	 l1jAVEwNocNnVdCdxW0mIBENV/JYWJV2sEi9Sn++FyZ9Yn6DFlXNm0i5m6uK/kBLjs
	 C+0fuj3tpbLFzVhDTBb8BH+EHS3/ocK9GujUpV8ae8L1wh2+li3p5prShi618b/ted
	 YxAQB4i+7n2LA==
Date: Tue, 29 Jul 2025 18:40:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
Message-Id: <175383135828.1119152.922768974777985804.robh@kernel.org>
Subject: Re: [PATCH v1 0/3] Revise Meta Santabarbara devicetree


On Tue, 29 Jul 2025 17:13:42 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> - add sensor nodes for extension board
> - add mctp node for NIC
> - adjust LED configuration
> Base on branch for-next
> 
> Fred Chen (3):
>   ARM: dts: aspeed: santabarbara: add sensor support for extension
>     boards
>   ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
>   ARM: dts: aspeed: santabarbara: Adjust LED configuration
> 
>  .../aspeed-bmc-facebook-santabarbara.dts      | 840 +++++++++++++++++-
>  1 file changed, 839 insertions(+), 1 deletion(-)
> 
> --
> 2.49.0
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
 Base: attempting to guess base-commit...
 Base: tags/next-20250729 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250729091351.3964939-1-fredchen.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (mctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/mctp-i2c-controller.yaml#






