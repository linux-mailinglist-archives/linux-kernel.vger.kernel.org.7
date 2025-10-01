Return-Path: <linux-kernel+bounces-839584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3ABB1F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D241C01A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433F2868B0;
	Wed,  1 Oct 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WXsD0OBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYApBZuV"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094326F2BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357413; cv=none; b=KI5bjqrHWq4sCtvsVW15UV1FQjoPHLKYzLQaGR6CgKh/cQWrTqOI6DBGATAcP6pPktGOt9bPaWxWvYslY8xFJ7k9lXNMaFZMgddoMiybwyPSTduBOwYrSphyygY5x+5dkp/e15Om56gi4G3PF3j0U6xq8gQ+EtZtZSJ9wqPO0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357413; c=relaxed/simple;
	bh=WVHS8uQL5zz8C7+uj8Y6Xy9RME+eWvIITGFJOC9Z43E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=u+CzAVHccF2BtDd7RtlI9h+lJ2b8iMUAdXQwTCzXuiXow1IjDq0Bmi/z1GuJ5M96l+cyfIREqd+0mv/DHy9+g8qMSd23DbS69fM0NTFLvZjGrxe3DsPAlGDP7nKgs6pT6bJjH+af2Mu5S/DQp2PrDqdQ0Z95rD/LB6uJU+jor0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WXsD0OBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYApBZuV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75DB614000E2;
	Wed,  1 Oct 2025 18:23:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 18:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1759357410; x=1759443810; bh=Zs
	fbxp+KEXrO8+xn7YsbkwYd2udeR00A968c4+JN9Tw=; b=WXsD0OBsPoE6/ZGrcq
	BuY9HxXsn+b6GWYpbnJehUn7qWQUibZaJsVrItci7/WUnYBk6keVrqVA3LylUGI5
	dar8Z1juyMeEQ6Snea8eLmqQ1jUGC6JgmjxfUv4Gr04AlBf9bGpHGvmi9EMJzotz
	NJA5WAj7gWv7CVgFIsonoRJKA9GA7i9JaloeQStdV/BY/YWnGmpT3XZqU0TMNEZe
	a4mqZF6TLbA+0JO3aQt9930c2EPpRhHhumNmR36ipW/BUTdAEu5gR07AUZY01WkD
	T0UQUuqvcViIEQitSnzHFIX5fj7tOHJKX5cH4/GHDf+YbRBw9qpP5vyhX2c7SP7V
	kgnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759357410; x=1759443810; bh=Zsfbxp+KEXrO8+xn7YsbkwYd2ude
	R00A968c4+JN9Tw=; b=lYApBZuVuRfDu0qHcAPIepxZwfkogrD7eWE0V53JE0Y6
	y9dQTbwimqyHV+jH9J0j50qFlweB70FM7a/HUGRhMyD+joFDpZFc8vBNZ2jb7JW6
	rzjIN2eKu+IxDX69Mj0n9VNbhUPuGFw8Vc3Pn4Jzym74b/ZuXRfyDtCACAN2L7bx
	KPHovQ+G9ncvx16wTOWijp6g3yNRYMS33F7W2vJBsd5kd5V7YI73LTF88vlrvumi
	YHMtaZK3+y4jVXDhzwbnBiywmwKmfbThxEiKYkZZNjVOKHfKnqlL3n7LgQCYeRAt
	7A4GpnUITcdMqqqph5H4nUuez0YMyJkaj2B4f4YVCA==
X-ME-Sender: <xms:4qndaFT0-24tG7--hIFleYVpiYywWnTpxyp4hHXtcmQz48vCnzXN0A>
    <xme:4qndaJlTyY_KNcdM4B5wZpm6FZ81Sb2bCIrHLLDzbSjqZyErrcyf45gjORDCjg9tZ
    wYtlib08tJaT86zXxcRxGDkRwy1lber2wIdTTMC2EeI1pV-VqC3FTv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    ffffffheeugfefhfduvefgleeijeektdfffeeijedthfevgfeiieevjeeuteefvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrg
    hrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:4qndaI9JbPrVWotMw4yNZzHewxpQSZWgO1S35f3NxdDu-6CZS6gYOg>
    <xmx:4qndaKA7859CCHRtPoeAGTxaNjNYh09-1Uz4EPZ0Gv7qAwpcFPZWkg>
    <xmx:4qndaFTyF8BS-Fn8NS7XnbpQWyHjCsVkry9a1XLC9hbSn-4ZfEm8fg>
    <xmx:4qndaJvEiRolYvRgriWpb1zmBYmmw4bHJbLF1O02TXWd77FFjGaOyQ>
    <xmx:4qndaBr_0m4-LwYgZRmUSo7FxL-G8grcFY5yRrUmWTT3HbpUGK5M7Kuu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0233A700065; Wed,  1 Oct 2025 18:23:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Oct 2025 00:23:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, soc@lists.linux.dev
Message-Id: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
Subject: [GIT PULL 0/5] soc: updates for 6.18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

These are the SoC updates for the 6.18 release on Arm and RISC-V
platforms. With about 1150 non-merge changesets and 70000 lines
added,  this is one of the larger sets recently, and a lot of
that comes from updates for the Qualcomm, NXP/Freescale and Apple
platforms, which have both a significant number of new machines
and other updates.

There is one new RISC-V chip family in a separate branch, plus
new SoCs in five existing families.

We had 291 contributers in total, the ones with the most
changesets are:

     76 Krzysztof Kozlowski
     35 Frank Li
     35 Beleswar Padhi
     29 Stephan Gerhold
     29 Janne Grunau
     27 Lad Prabhakar
     21 Dmitry Baryshkov
     21 AngeloGioacchino Del Regno
     20 Nick Chan
     18 Chen-Yu Tsai
     18 Alexander Stein
     17 Peng Fan
     15 Rob Herring (Arm)
     15 Neil Armstrong
     13 Tao Ren
     11 Mohammad Rafi Shaik
     11 E Shattow
     11 Anand Moon
     11 Amirreza Zarrabi

Overall dirstat:

   0.6% Documentation/devicetree/bindings/arm/
   0.1% Documentation/devicetree/bindings/clock/
   0.2% Documentation/devicetree/bindings/pinctrl/
   0.1% Documentation/devicetree/bindings/soc/xilinx/
   0.5% Documentation/devicetree/bindings/
   0.2% Documentation/tee/
   0.5% arch/arm/boot/dts/allwinner/
   4.1% arch/arm/boot/dts/aspeed/
   0.1% arch/arm/boot/dts/broadcom/
   0.3% arch/arm/boot/dts/intel/ixp/
   0.1% arch/arm/boot/dts/microchip/
   2.7% arch/arm/boot/dts/nvidia/
   0.7% arch/arm/boot/dts/nxp/imx/
   0.2% arch/arm/boot/dts/nxp/
   0.6% arch/arm/boot/dts/qcom/
   0.7% arch/arm/boot/dts/st/
   0.1% arch/arm/boot/dts/ti/omap/
   0.1% arch/arm/boot/dts/
   0.1% arch/arm/mach-omap2/
   0.7% arch/arm/
   0.3% arch/arm64/boot/dts/allwinner/
   0.4% arch/arm64/boot/dts/amlogic/
   0.1% arch/arm64/boot/dts/apm/
   6.5% arch/arm64/boot/dts/apple/
   0.2% arch/arm64/boot/dts/broadcom/
   0.1% arch/arm64/boot/dts/cix/
   0.4% arch/arm64/boot/dts/exynos/axis/
   2.2% arch/arm64/boot/dts/exynos/
  15.4% arch/arm64/boot/dts/freescale/
   0.3% arch/arm64/boot/dts/intel/
   0.1% arch/arm64/boot/dts/marvell/
   1.2% arch/arm64/boot/dts/mediatek/
   0.5% arch/arm64/boot/dts/nuvoton/
   0.3% arch/arm64/boot/dts/nvidia/
  24.0% arch/arm64/boot/dts/qcom/
   3.1% arch/arm64/boot/dts/renesas/
   4.6% arch/arm64/boot/dts/rockchip/
   0.5% arch/arm64/boot/dts/st/
   8.5% arch/arm64/boot/dts/ti/
   2.0% arch/arm64/boot/dts/xilinx/
   0.4% arch/riscv/boot/dts/eswin/
   0.6% arch/riscv/boot/dts/microchip/
   0.1% arch/riscv/boot/dts/starfive/
   0.2% arch/riscv/boot/dts/
   1.1% drivers/clk/
   0.1% drivers/firmware/arm_scmi/vendors/imx/
   0.2% drivers/firmware/qcom/
   0.2% drivers/firmware/
   0.1% drivers/memory/tegra/
   0.3% drivers/nvme/host/
   0.5% drivers/reset/
   0.1% drivers/soc/apple/
   0.1% drivers/soc/fsl/qe/
   0.8% drivers/soc/qcom/
   0.3% drivers/soc/samsung/
   0.1% drivers/soc/tegra/fuse/
   0.1% drivers/soc/
   1.0% drivers/tee/optee/
   5.1% drivers/tee/qcomtee/
   1.1% drivers/tee/
   0.1% drivers/
   0.1% include/dt-bindings/memory/
   0.2% include/dt-bindings/
   0.3% include/linux/
   0.1% include/uapi/linux/
 1074 files changed, 70723 insertions(+), 17334 deletions(-)

