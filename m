Return-Path: <linux-kernel+bounces-746689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCEDB12A15
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05721C2493C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926C23D290;
	Sat, 26 Jul 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gYgji40w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W52HFqzq"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766D1519BC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525963; cv=none; b=tBW/7hJCP0OZZuB3scTSAv9lfoIRCpCNVt7DAWm2r9odXxL3LkDXReFUvB0cu4rM6n2zxmeoxFshaL8Q4B5FrLviOf8sEXyQ1cgF7QzgoWDKbnplIrO0r779MVBJ2T90kdyldY/r9IgJeYRbXOR/LEdEA1MUpjHdXWFgmqIdzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525963; c=relaxed/simple;
	bh=zXX9rPfTMFBQsN70ApMVqB1C+1NXADPED4ZCmqtiRo0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IL0RA7cJ2UuvngeTsWbr7crc/pwn3gGWyJmk99WScbjTwp28cqvLHXIEaxjde+dcCikf/27+PlS1fc23vjpLRL06jF5W64NTwHXxzP0e3fatbvmJFBpYkujVFZxhfqRxGamlLr8gzQ19gBjUKNT4N8mLwCFLNe84i4CIF1OUuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gYgji40w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W52HFqzq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8BA3A14000FD;
	Sat, 26 Jul 2025 06:32:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753525960;
	 x=1753612360; bh=SgoPbqqSFDKvdYHjDquYoLaznq4AccR4rO7ESwuJ+WA=; b=
	gYgji40wfaZFfGUVaRCxNWlmLXPiRXNOnoDpVpspLF1Fz0xPlXGE88Fsoh5SpXCL
	2zxENbzD6//FznA2y/sBGrDT5MKm779YMyyW7gI0rP+tLEYZV34Tl1aSYVMekyZh
	jqCDZpEJ1Qpor4J8pheKqMCQFKNX5Y4O8Kxx4uzciVPYE3RXYIPZdUoAduo2HRcv
	n+tTI7A0d67yXqj80IHyA22yHXffqSaFqJwGOWHBP7hTITCJ/aQjujpx2NKnf+rx
	E8aXz/EcaRG7VT7B9A4x6QU3xCiY1wLtpaHh3KGw6/no9cN75ukBRpfbYkJYRoni
	v+mo80Iyoy2Ji2HDJ7xO+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753525960; x=
	1753612360; bh=SgoPbqqSFDKvdYHjDquYoLaznq4AccR4rO7ESwuJ+WA=; b=W
	52HFqzq5Ueqp5o/p0AbtnQ09w6hAMmVSwo0RRc0o9EOWOFmPsH5I2MKUl/X4fgrt
	/+IaEPJlzqll8wWFXP+epSGHcv7hhNVYHsrIYis/4O0Xk4KhsfKZrO1QxaYCIEuJ
	/ORJaUYsruTB2/qmnPiNrZvlSInIT/0MRxtFVoHFD+OydnAe1K0BsFisOn4bsGxU
	SzU4IYlzULtALyqeZC77MNuPnaPK0RPYwt5zYasgnCnaEsU5KfE4NlHOVVAjONQy
	/SXadx3r1l5FsjcXCpK8Tolc7FFHUlQhbp9HRwjMNlEZ2lJU4HIonvYPQMcFp4W6
	fOTNRSt7McWAgDh11tDZg==
X-ME-Sender: <xms:yK6EaPhynAqbB5ZgpeRpTSEUGEH0h3V4m49TAdvT8mre8bwiDwfsZA>
    <xme:yK6EaMDffWjHBUn8HayXGsmOkAfD0VgKHx5zIpfkMp7J6bqF8cKJy4uO7iKrrbOdY
    uz0ypI83IlM50nwN5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefueegkeffveeugeehieehiedukeegfefhffeutdettdffteeluefhheetkeekvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yK6EaDhpXj0tchio9yiv8OxIOCZ_yO_Zus5Iwjvbzi_3uCSKglEgZQ>
    <xmx:yK6EaLivbSaPMmiV7fLFtX4iKWQKUAoOkY9N-VkXavosXYTaJi9YcA>
    <xmx:yK6EaJhL1PsiSbS1WsPURqdHBlv_RLl5T-6T3GvDA-Yavme9NDZ54g>
    <xmx:yK6EaLJ8hKrBYLx1mJzehbTvFQJcVu1L-xs5r9ID54VFrI2M62Z2Pg>
    <xmx:yK6EaAxIkd2cVXbdR20KufLO__1ApPj9YuYjMrU14wy3MlRIOGAnoT7->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5ADAC700065; Sat, 26 Jul 2025 06:32:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Td03a27401e83a0cb
Date: Sat, 26 Jul 2025 12:32:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Message-Id: <b64f7af2-f61d-4ebb-9815-73efd8a1a682@app.fastmail.com>
In-Reply-To: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
Subject: [GIT PULL 4/5] soc: defconfig updates for 6.16
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456=
841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.17

for you to fetch changes up to 5cfe03e1ca42fa97341fde7a8ad53be86a51d789:

  Merge tag 'v6.17-rockchip-defconfig64-1' of https://git.kernel.org/pub=
/scm/linux/kernel/git/mmind/linux-rockchip into soc/defconfig (2025-07-2=
2 22:58:01 +0200)

----------------------------------------------------------------
soc: defconfig updates for 6.16

As usual, more drivers get enabled in the defconfigs, to support newly
added hardware drivers.

There is one change for Tegra that modifies the Kconfig file at the same
time, and the NXP arm32 defconfigs get a refresh.

----------------------------------------------------------------
Andrea della Porta (2):
      arm64: defconfig: Enable RP1 misc/clock/gpio drivers
      arm64: defconfig: Enable OF_OVERLAY option

Andr=C3=A9 Draszik (2):
      arm64: defconfig: enable Maxim max77759 driver
      arm64: defconfig: enable Samsung PMIC over ACPM

Arnd Bergmann (9):
      Merge tag 'renesas-arm-defconfig-for-v6.17-tag1' of https://git.ke=
rnel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'arm-soc/for-6.17/defconfig-arm64' of https://github.com=
/Broadcom/stblinux into soc/defconfig
      Merge tag 'samsung-defconfig-6.17' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/krzk/linux into soc/defconfig
      Merge tag 'tegra-for-6.17-arm64-defconfig' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/tegra/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.17' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'riscv-config-for-v6.17' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/conor/linux into soc/defconfig
      Merge tag 'at91-defconfig-6.17' of https://git.kernel.org/pub/scm/=
linux/kernel/git/at91/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.17' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'v6.17-rockchip-defconfig64-1' of https://git.kernel.org=
/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/defconfig

Ciprian Marian Costea (1):
      arm64: defconfig: add S32G RTC module support

Dario Binacchi (5):
      ARM: mxs_defconfig: Cleanup mxs_defconfig
      ARM: mxs_defconfig: select new drivers used by imx28-amarula-rmm
      ARM: imx_v6_v7_defconfig: cleanup with savedefconfig
      ARM: imx_v6_v7_defconfig: select CONFIG_INPUT_PWM_BEEPER
      ARM: imx_v6_v7_defconfig: select CONFIG_USB_HSIC_USB3503

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select BT_HCIUART_BCM
      ARM: configs: sama5_defconfig: Select CONFIG_WILC1000_SDIO

Geert Uytterhoeven (2):
      ARM: shmobile: defconfig: Refresh for v6.16-rc2
      riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=3Dm

Guodong Xu (1):
      riscv: defconfig: Enable PWM support for SpacemiT K1 SoC

Kory Maincent (2):
      arm: omap2plus_defconfig: Enable TPS65219 regulator
      arm: multi_v7_defconfig: Enable TPS65219 regulator

Krzysztof Kozlowski (3):
      arm64: defconfig: Enable camcc and videocc on Qualcomm SM8450+
      arm64: defconfig: Switch SOUND to module
      arm64: defconfig: Drop unneeded unselectable sound drivers

Lad Prabhakar (1):
      arm64: defconfig: Enable RZ/V2H(P) USB2 PHY controller reset driver

Nicolas Frattaroli (1):
      arm64: defconfig: enable further Rockchip platform drivers

Thierry Reding (2):
      arm64: defconfig: Enable Tegra HSP and BPMP
      arm64: defconfig: Enable Tegra241 and Tegra264

Yixun Lan (1):
      riscv: defconfig: spacemit: enable sdhci driver for K1 SoC

 arch/arm/configs/imx_v6_v7_defconfig | 28 +++++++---------------------
 arch/arm/configs/multi_v7_defconfig  |  3 +++
 arch/arm/configs/mxs_defconfig       | 14 +++-----------
 arch/arm/configs/omap2plus_defconfig |  3 +++
 arch/arm/configs/sama5_defconfig     |  1 +
 arch/arm/configs/shmobile_defconfig  |  1 +
 arch/arm64/configs/defconfig         | 30 +++++++++++++++++++++++-------
 arch/riscv/configs/defconfig         |  4 +++-
 drivers/soc/tegra/Kconfig            |  9 ---------
 9 files changed, 44 insertions(+), 49 deletions(-)

