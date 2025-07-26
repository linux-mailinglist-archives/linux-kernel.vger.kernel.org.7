Return-Path: <linux-kernel+bounces-746680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8DB12A04
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDEC189EC04
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C723C4F1;
	Sat, 26 Jul 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hRMxDKfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWsQVayh"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31905202F9F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525583; cv=none; b=rQXKGOqjkPFx5fu7WKlkZv1hgGnxK3P4AT4jyTXL/GmxfTBBpFmuKoQOTj+rDEtwf5x1PyMY5gauvmcoLDl8aJf7SSs185ec+cE08YnbrBsUJeK0mq3G/xorHwgnf8qI+z8szlt9rHKytW5rQ5/TjJo9I7dQsaM7UZNvsuqmIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525583; c=relaxed/simple;
	bh=gBvqmP3Bdk/cSk30/5QnvVybi4EvkQFoEABBZXx/qN4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=neyNQNb2Sn/hOVrgStkuJwl1JjfpoMhQQolHfaihmrWgimpx+/drxaQzbxBmIC58z2BLJmjMKBaU3c2Mq6ZJmT6MOBdQGemvnxr+d4HKoaxvTC1I3ZheMgsG9G+A5BIEAEI8WIPHrew0ejE2K5fRJPJHaJuvrMwfmRTQ+f03Yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hRMxDKfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWsQVayh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EB8D140023A;
	Sat, 26 Jul 2025 06:26:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1753525580; x=1753611980; bh=8y
	g3QvomJv1gMtGn9ahf58zrykZU2YPfuu6iYkEHyPU=; b=hRMxDKfgmXdTBBXXVn
	5oOKx+qV5kptvoBmgbcQQklcVGFwzRM83M77XO7B12TA4FroySZHHtziF0y37jKA
	xwLVkmvedUZSWRuRwHALEKKV00d1VwiBG9alBuTRR+YfDMcfHe8RxEIUouYXX036
	d70JQPyLtul1KM4pqwFjoBFDbIA99dk4TuOOa9fYqwQSgN0G+TDUrhICmcd3a1jF
	1Yi1yF37cL69eayYPz1WTAbgFuAQREm9SgDSRwSPHuVGocYHLOZ+XjBMhBI999Ji
	Tie7uaNwISZj02Xkc7q3JCQO6LdggRjq3elseC+jOdeY4eORTzQQHTUUXsREtvGF
	I3jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753525580; x=1753611980; bh=8yg3QvomJv1gMtGn9ahf58zrykZU
	2YPfuu6iYkEHyPU=; b=aWsQVayh73rj7OgZcokPEmGlfM94xu4ssID5K5UCaU1a
	Ais7Jlj8gRJ5wbaQuC5N8SGEy4rIpMpGQtNpnhOvGUZkoJbjOZ+OcRujqKuS4Lcz
	SDXjgVCuOR4Ny05cVqP5ObwN/NGRgcD64KTJQiWljHzxS6lCfnsIF24RuFAQbku/
	LynsUqf5vQveTTIeEJwvql7aBnvDZopMi+LORBz4xwts77CaChcx7Gw3iig4gjYx
	BAd1nDTEHBnhe/i7uPnKoniHlfKHXpqJX4wE3qe2xEUD+8a1PC03qWvZBiookM+Y
	OWspqmMcag6EzMIllRM1xHE2Esvgm91AsTrbDnQe3g==
X-ME-Sender: <xms:S62EaAuUtcsYgBN0Hc3VX4FoZE9aW-TCqSdM5mOcG46GnF010LqUdg>
    <xme:S62EaNcGbCvMF35CupxxP-peNlwiRexkYigkpHwNhnulHUAcV67aEDGFPbiB5D0Nf
    aXO-Ms4fOMGYKByDLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    ffffffheeugfefhfduvefgleeijeektdfffeeijedthfevgfeiieevjeeuteefvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrg
    hrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:S62EaMuPNB7b4W1qEffNW8bD47C-dApUvk9F7bLvh49SrXs6Ktp0UA>
    <xmx:S62EaE8uyFHoGbReGJWDSDrMMYvlfM7riUmI7paRQZBcID9m7XtvlA>
    <xmx:S62EaOPbS2T01biTkyCHkSPrYtZuRBZPVUiRY61-C2zjVJPn6qNvcg>
    <xmx:S62EaKFONKDqFg_aMDqjekoKzidS0Y7lU8iYqcnHor-JhD6iWCLtuQ>
    <xmx:TK2EaNOnr-llFy8Niy1OQoaBY61k_9lUdsKGcoErLnIXuGdqQpW02MKS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C02C5700065; Sat, 26 Jul 2025 06:26:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 12:25:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Message-Id: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
Subject: [GIT PULL 0/5] soc: updates for 6.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This release is smaller than most of the recent ones, at 777 non-merge
changesets, but it does include three newly SoC families, in the soc/newsoc
branch: pxa1908 and sg200 are ported over from arm32 and riscv into arm64,
AX3000 and P1 and new arm64 chip families, and QiLai is a new riscv chip.

Raspberry Pi 5 support gets a boost with support for the RP1 I/O chip,
and there is still a good chunk of new boards and added features for
the usual chip families, mainly nxp, qualcomm, rockchips and renesas.

There were 209 contributors this time, with the most patches coming
from these developers:

     31 Lad Prabhakar
     23 Inochi Amaoto
     21 Krzysztof Kozlowski
     19 Thierry Reding
     17 Chen-Yu Tsai
     15 Frank Li
     15 Dario Binacchi
     15 Andrea della Porta
     15 Alexander Stein
     13 Manivannan Sadhasivam
     13 Diederik de Haas
     12 Potin Lai
     12 Luca Weiss
     12 Linus Walleij
     11 Nicolas Frattaroli
     10 Max Shevchenko
     10 Harshit Shah
     10 Bartosz Golaszewski

The overall diffstat is

   0.3% Documentation/devicetree/bindings/arm/
   0.8% Documentation/devicetree/bindings/memory-controllers/
   0.3% Documentation/devicetree/bindings/pinctrl/
   0.4% Documentation/devicetree/bindings/reset/
   1.8% Documentation/devicetree/bindings/
   4.6% arch/arm/boot/dts/aspeed/
   0.7% arch/arm/boot/dts/broadcom/
   0.6% arch/arm/boot/dts/microchip/
   8.4% arch/arm/boot/dts/nvidia/
   7.8% arch/arm/boot/dts/nxp/imx/
   0.4% arch/arm/boot/dts/nxp/mxs/
   1.3% arch/arm/boot/dts/nxp/vf/
   0.5% arch/arm/boot/dts/st/
   0.4% arch/arm/boot/dts/ti/omap/
   0.7% arch/arm/boot/dts/
   0.7% arch/arm64/boot/dts/allwinner/
   0.5% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/apple/
   0.9% arch/arm64/boot/dts/axiado/
   0.7% arch/arm64/boot/dts/broadcom/bcmbca/
   0.4% arch/arm64/boot/dts/broadcom/
   0.5% arch/arm64/boot/dts/cix/
   4.9% arch/arm64/boot/dts/exynos/
   8.9% arch/arm64/boot/dts/freescale/
   1.5% arch/arm64/boot/dts/lg/
   0.9% arch/arm64/boot/dts/marvell/mmp/
   0.5% arch/arm64/boot/dts/mediatek/
   0.8% arch/arm64/boot/dts/nvidia/
   8.0% arch/arm64/boot/dts/qcom/
   5.5% arch/arm64/boot/dts/renesas/
   8.4% arch/arm64/boot/dts/rockchip/
   0.9% arch/arm64/boot/dts/st/
   1.9% arch/arm64/boot/dts/ti/
   0.3% arch/arm64/boot/dts/
   0.3% arch/riscv/boot/dts/andes/
   3.6% arch/riscv/boot/dts/sophgo/
   0.8% arch/riscv/boot/dts/spacemit/
   0.3% arch/
   2.8% drivers/clk/
   0.5% drivers/firmware/
   1.1% drivers/mailbox/
   0.7% drivers/memory/tegra/
   0.5% drivers/misc/rp1/
   3.2% drivers/pinctrl/
   0.9% drivers/reset/
   0.4% drivers/soc/aspeed/
   0.5% drivers/soc/qcom/
   0.3% drivers/soc/renesas/
   1.7% drivers/soc/tegra/cbb/
   0.5% drivers/soc/
   0.4% drivers/
   2.5% include/dt-bindings/clock/
   0.3% include/dt-bindings/memory/
   0.3% include/dt-bindings/reset/

