Return-Path: <linux-kernel+bounces-731884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDAB05AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C294561153
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A82E1C69;
	Tue, 15 Jul 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YWJCkD9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKDo87+O"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D62E2EF8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585236; cv=none; b=qsYGEQd5D43SrHYiv6nS8G90BrU7wOmRb/oOUsHXBOy4VqxE/6QGUe4l1ROFs7VVHW+CBfUYFXx384z9sGNtLhLqPYA5Qn8XiE93g7KIQOhwD6ocDi9/4PAiLmazn9Aow4GNNoTTKB7iwYcbU4nWCX7+9i+VEAmBj7/qKLZon3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585236; c=relaxed/simple;
	bh=mNnsSuLBbG4Lej1hhvgedugGK2ZQl0xADRRD++s98uQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=r8/00HfgIzGWVUzwryk/45huEz6PE/9xdTWTHCvMjj1ZIQen1fzpZifptDk+RMeVRSV6qNuilcCYvB7je+2kuTXAjCmkBVYhLUC8AbbxRB53umUERp45AsCqiOf1oQYGN4FSV61FcrHIAIcfHz7ANovPN6GGnSL5KbEv/OfyGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YWJCkD9+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TKDo87+O; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A05E7EC0E90;
	Tue, 15 Jul 2025 09:13:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 09:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1752585232; x=1752671632; bh=Jl
	2/Bme3dggXyQm6j2e6aTPj1gIVCZq+ikrQ9R6HsWo=; b=YWJCkD9+jFiUq8njuW
	Xil6uP+eA+UhZgKWH1Ae0cSVGSUOB4/VIeU0zxKRAmcZ7HxR9FPU4Zz9Bdnub+gc
	qfNcJaIj1Zy55qS0WiwY/o7RDwrVG1GS+sI2bifziqQbLotNPwdN+Iu3/gFoYg9C
	Cnvi5QsGKFfoUhUKHGjC6L/dkDstw27V8Ptc3a6i6vmd881wAzFfFJ0+EeNISEWx
	qSMRCOHeEd5EqTaey5ggevPOX+Yl/AiNzJpU0eW7iBhsfWBQTodGf9akTqmSMuIY
	MPAUbTdthVT96Cb/oclY4rLourF7pqgHxiNZnJMmazkMvIsuQCxZTxSKUOM6I9rs
	FB2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752585232; x=1752671632; bh=Jl2/Bme3dggXyQm6j2e6aTPj1gIV
	CZq+ikrQ9R6HsWo=; b=TKDo87+OdmGx4e81bbWK1skBP2sM9vFfNX/eV0JNEfYJ
	9ixUmxx4P+04R/eYeGztZXCZyheIzJUoedwcRtfOSeRSVlTVNaEs0DB+2Gn13azu
	TgB8/AESROjLwIeX2F78bNRiWbVkGuKMFcR83LPeSrHuys7RVTdNO9zqMxTEA1Ot
	gmHUt8Q7nx0mJqs9ZLVboojAU3TpD+ercHA6pp0bjlwsBGTfq7ujFUolaOjRy/SA
	nOkYDYkQdaZpgCRhpDb7qFj7/MD22Jul1odQBlK7SGDl2hVzonq4d5Gspcbof7ll
	RL4vEN9TEKfzDXr6Z7uiqG37Pv/iqWCQkkUm2TLe6Q==
X-ME-Sender: <xms:EFR2aMQ5F-LQjDcnHHfBbtu4-qBZwkwdvzDp8lmnYFofWWiDLv8_jw>
    <xme:EFR2aJzMb6IwIdlYPYe9-YozNEcLmbHgNUkJ-rZEKRFGBiMJN_LtoNQfhmwltXy6J
    3pI7bz6zREY6oRgv5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    duleeigeekveeugeettdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EFR2aASGoGyY7XXes0xjcPeoQBPokPJRfpswH4YpHKrL4E5wTxiVuQ>
    <xmx:EFR2aJQ6gx9OGwUiDeJqufoA-Urt6HIqnn3ILLArJMedxzdzKWu_Fg>
    <xmx:EFR2aEQTki8U0Xfe-BDIiMN1hJ7fzUPbU3h5YHMAHc4Jj6ACR0BO4A>
    <xmx:EFR2aO4IR266-QluDydF5lz0iNolTbTiFocyv-RaNcQC4vMqJtmMYA>
    <xmx:EFR2aKh_chE7ibYhv7IQQckOU9OUYCuTm68ZtKFnSDvcP7wmdeEoXbWG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 26369700065; Tue, 15 Jul 2025 09:13:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 15:13:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@lists.linux.dev
Message-Id: <5f8e6b26-01ee-4941-9609-ed761a23f4d1@app.fastmail.com>
Subject: soc: fixes for 6.16, part 2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 3f3fb97374308993dbe8884f44c2579a81b90bfa:

  Merge tag 'apple-soc-fixes-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux into arm/fixes (2025-07-03 16:27:31 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.16-2

for you to fetch changes up to 8f0837fdc5d832f0cd953f66db0cbfb2fa8909d2:

  Merge tag 'qcom-arm64-defconfig-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes (2025-07-11 13:41:10 +0200)

----------------------------------------------------------------
soc: fixes for 6.16, part 2

There are 18 devicetree fixes for three arm64 plaforms: Qualcomm Snapdragon,
Rockchips and NXP i.MX. These get updated to more correctly describe the
hardware, fixing issues with:

 - real-time clock on Snapdragon based laptops
 - SD card detection, PCI probing and HDMI/DDC communication on
   Rockchips
 - Ethernet and SPI probing on certain i.MX based boards
 - A regression with the i.MX watchdog

Aside from the devicetree fixes, there are two additional fixes for the
merged ASPEED LPC snoop driver that saw some changes in 6.16, and one
additional driver enabled in arm64 defconfig to fix CPU frequency scaling.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Alexey Charkov (1):
      arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5

Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

Andy Yan (3):
      arm64: dts: rockchip: Adjust the HDMI DDC IO driver strength for rk3588
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi CM5
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi 4B

Arnd Bergmann (5):
      Merge tag 'imx-fixes-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'v6.16-rockchip-dtsfixes1' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'aspeed-6.16-fixes-0' of https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-defconfig-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes

Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm CPUCP mailbox driver

Diederik de Haas (1):
      arm64: dts: rockchip: Add missing fan-supply to rk3566-quartz64-a

Francesco Dolcini (1):
      arm64: dts: freescale: imx8mm-verdin: Keep LDO5 always on

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: use cs-gpios for spi1 on ringneck

Johan Hovold (2):
      arm64: dts: qcom: sc8280xp-x13s: describe uefi rtc offset
      arm64: dts: qcom: x1e80100: describe uefi rtc offset

Meng Li (1):
      arm64: dts: add big-endian property back into watchdog node

Richard Zhu (1):
      arm64: dts: imx95: Correct the DMA interrupter number of pcie0_ep

Shawn Lin (1):
      arm64: dts: rockchip: fix rk3576 pcie1 linux,pci-domain

Tim Harvey (4):
      arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw72xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw73xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw74xx: fix TPM SPI frequency

Wei Fang (2):
      arm64: dts: imx95-19x19-evk: fix the overshoot issue of NETC
      arm64: dts: imx95-15x15-evk: fix the overshoot issue of NETC

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   |  1 +
 .../boot/dts/freescale/imx8mp-venice-gw71xx.dtsi   |  2 +-
 .../boot/dts/freescale/imx8mp-venice-gw72xx.dtsi   |  2 +-
 .../boot/dts/freescale/imx8mp-venice-gw73xx.dtsi   |  2 +-
 .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    |  2 +-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  | 20 ++++++-------
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  | 12 ++++----
 arch/arm64/boot/dts/freescale/imx95.dtsi           |  2 +-
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  2 ++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi       |  1 +
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    | 23 ++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |  1 +
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      | 28 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  2 +-
 .../boot/dts/rockchip/rk3588-base-pinctrl.dtsi     | 20 ++++++-------
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi |  1 +
 .../boot/dts/rockchip/rk3588-extra-pinctrl.dtsi    |  5 ++--
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |  1 +
 arch/arm64/boot/dts/rockchip/rockchip-pinconf.dtsi | 35 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c              | 13 +++++++-
 22 files changed, 143 insertions(+), 36 deletions(-)

