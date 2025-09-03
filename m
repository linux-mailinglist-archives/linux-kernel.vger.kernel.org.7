Return-Path: <linux-kernel+bounces-799439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80997B42BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFFB7A1F87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C82EB5C4;
	Wed,  3 Sep 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GneLnXY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwiNL4tb"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097182EB854
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934604; cv=none; b=NKL0tNJTMwulyXzuw99P4eapFvaQJET+DYj6Pn4ZZxwF+yImrsOL54iYjJP14UHYExUMULSdtyp3zRCfQJfp95HliHFcDAflIUATHmlR5hsynbBeyCTGSxikY/RVMw5Ev7HO8gXiy/2x4iPOJ/QrEtCyGJWc9WkiSn+rucgQPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934604; c=relaxed/simple;
	bh=yw300XmFf561QWYMt8HmXLsVVF3dkiAEVuRdsk4yElM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=GtjRgjGt7zvZ2tr0HkH6VqWIYtPQZUmAYjODTE7ewpYtiQK9gsidAdkWgyIkMP/TkYOQ+BT1hFlEtVWNmLbYKSrDcP9GqOS76a1hJyvGG8vhHRAvisUKB6h/9vkUIYhUMEDNOBOOJyQmXxrtIir90TkWOX7wy3RoYYuTdmPd+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GneLnXY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwiNL4tb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA3DE7A00C5;
	Wed,  3 Sep 2025 17:23:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 17:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1756934600; x=1757021000; bh=Y9
	IdYr7ifwPo37nMqOKFyBDGthrrSK9O17//tYeYLvU=; b=GneLnXY9/+o4MD0IMC
	+WKedw1q9xGX72Zizi9Dsr3Z5Jz/HWGPoloI0m8IHKzAnildtayDa2YZPXhOaI4s
	K8PH0T0M3uS1ib7xj57XeB+ILrqm0kGy8O9T9XOyE8kY8ieO4vLGJJGVVTwLulXz
	BuFt5qMxJt7GtH0u7TbKGKJbawhx2yPQDeOCzvoZlSFD1nbaz3w6BZdgLNPH4uyr
	Y1eazuEAL6gDJyC0ObW9+xkaYWUfPp6pBen0LUWldaT4JgNXpRUOSzWPm7jh0Vlr
	5OBq72WwMnRqCqT0aR8DIaRuG0cGLohk8MVY3E/0a+3MNOcnvQoDMTghfzPYhPBz
	6XIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756934600; x=1757021000; bh=Y9IdYr7ifwPo37nMqOKFyBDGthrr
	SK9O17//tYeYLvU=; b=bwiNL4tbdR3eWc7H6evEIScht00Fu0NUt/SJy6t8+2zu
	BKMlJW69Fj/Hqvwqt+l/qlBdmOVbh6K7DRoKmRrBtJOv+aHO+IhSQI41b5U4u7UQ
	pIeG/ja946jzidVbHBmioGuX7qB0I/mMZuGT6eFekxeUEa9LJ9rKf6v+43JbN0CZ
	vly7PlLHzNoe+yS69IIKfpAceJzBvcNMvbJ0hqPjfNp4QLbxoRcsjhJAwVOvmgnZ
	fT5mtv2wgTegGM0dDwR9SaPrEY7PD+jkZgjAkq5+uXrJ264j1xHxT7egBrPoG4tK
	WhmKw8eYvMpMlp0X/yUjfQ6VpFDFaHPBVgPFXo3Axg==
X-ME-Sender: <xms:yLG4aGE5XdympMWJvQjEbfzr4eKxY6jTdEXb_rdujwuw2q7FzAFCKg>
    <xme:yLG4aHWwoOAPC--eOEP7Q8sel9JX-wsDPewlEeKS4kpnNJPHQ1N2Mt5SRt8VCT3Sy
    Jb5e-2V69Ylglki-5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceuvghr
    ghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhepud
    elieegkeevueegtedtjedttdelgeehhfdvhfeuheethfduleffuddvueelveetnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsh
    hotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yLG4aCGYN4jYoFWWtgfahbc44OwWXeeyArsp1e5g-MI_lcQ2haYvhg>
    <xmx:yLG4aO3-13G8Rr8QNDs3hRzCqG-YrnD57VIg0bpX2vrzozHRdlFOlg>
    <xmx:yLG4aCmjHZZY1Ot0_Ji9_Wb9aAXBVSdpKNEsu_IItRMnnHFPHJFlxw>
    <xmx:yLG4aG8LF7hofKozrmHJTGr69kAaDmfQRNdzkThfs1_oHgzYwVlZJA>
    <xmx:yLG4aNFtmuKIdNHSZ2qH_mvJ1N-F5yUMD_CJGmVLbFc_u2VE9kATHcci>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F01C700065; Wed,  3 Sep 2025 17:23:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Sep 2025 23:21:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <0baf22fa-281e-4f56-a807-917152f0bc79@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.17, part 2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-2

for you to fetch changes up to 875691ceb8bd619de7791243b1cf6184ab534865:

  Merge tag 'at91-fixes-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes (2025-09-03 23:02:54 +0200)

----------------------------------------------------------------
soc: fixes for 6.17, part 2

These are mainly devicetree fixes for the rockchip and nxp platforms on
arm64, addressing mistakes in the board and soc specific descriptions.
In particular the newly added Rock 5T board required multiple bugfixes for
PCIe and USB, while on the i.MX platform there are a number of regulator
related fixes. The only other platforms with devicetree fixes are at91
with a fixup for SD/MMC and a change to enable all the available UARTS
on the Axiado reference board.

Also on the at91 platform, a Kconfig change addresses a regression that
stopped the DMA engine from working in 6.17-rc.

Three drivers each have a simple bugfix, stopping incorrect behavior in
op-tee firmware, the tee subsystem and the qualcomm mdt_loader.

Two trivial MAINTAINERS file changes are needed to make sure that
patches reach the correct maintainer, but don't change the actual
responsibilities.

----------------------------------------------------------------
Arnd Bergmann (6):
      Merge tag 'qcom-drivers-fixes-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'tee-fixes-for-v6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee into arm/fixes
      Merge tag 'optee-typo-fix-for-v6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee into arm/fixes
      Merge tag 'imx-fixes-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'v6.17-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'at91-fixes-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Chen-Yu Tsai (1):
      arm64: dts: rockchip: Add supplies for eMMC on rk3588-orangepi-5

Chukun Pan (1):
      arm64: dts: rockchip: mark eeprom as read-only for Radxa E52C

Haibo Chen (1):
      arm64: dts: imx95-19x19-evk: correct the phy setting for flexcan1/2

Harshit Shah (1):
      arm64: dts: axiado: Add missing UART aliases

Kaison Deng (1):
      arm64: dts: rockchip: fix es8388 address on rk3588s-roc-pc

Krzysztof Kozlowski (3):
      ARM: dts: rockchip: Minor whitespace cleanup
      arm64: dts: rockchip: Minor whitespace cleanup
      arm64: dts: rockchip: Fix Bluetooth interrupts flag on Neardi LBA3368

Marek Vasut (3):
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on DH electronics i.MX8M Plus DHCOM
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC
      arm64: dts: imx95: Fix JPEG encoder node assigned clock

Markus Niebel (2):
      arm64: dts: imx8mp-tqma8mpql: fix LDO5 power off
      arm64: dts: imx8mp-tqma8mpql: remove virtual 3.3V regulator

Maud Spierings (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 plus

Nicolas Frattaroli (2):
      arm64: dts: rockchip: fix USB on RADXA ROCK 5T
      arm64: dts: rockchip: fix second M.2 slot on ROCK 5T

Nobuhiro Iwamatsu (1):
      MAINTAINERS: Update Nobuhiro Iwamatsu's email address

Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

Peter Robinson (2):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-pro
      arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinephone Pro

Robert Marko (1):
      ARM: at91: select ARCH_MICROCHIP

Ryan Wanner (1):
      ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode

Sebastian Reichel (2):
      arm64: dts: rockchip: correct network description on Sige5
      MAINTAINERS: exclude defconfig from ARM64 PORT

Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

 .mailmap                                           |  1 +
 MAINTAINERS                                        |  3 +-
 .../boot/dts/microchip/at91-sama7d65_curiosity.dts |  2 ++
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts     |  2 +-
 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts  |  6 ++--
 arch/arm/mach-at91/Kconfig                         |  4 +++
 arch/arm64/boot/dts/axiado/ax3000-evk.dts          |  3 ++
 .../dts/freescale/imx8mp-data-modul-edm-sbc.dts    |  1 +
 .../arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi |  1 +
 .../freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts   | 13 ++++----
 .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    | 13 ++++----
 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi | 31 +++++++++++++------
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  | 10 +++----
 arch/arm64/boot/dts/freescale/imx95.dtsi           |  2 +-
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi      |  8 ++---
 .../rockchip/px30-ringneck-haikou-video-demo.dtso  |  6 ++--
 .../boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts  |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts    |  2 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  1 +
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |  1 +
 .../rockchip/rk3399-puma-haikou-video-demo.dtso    |  6 ++--
 .../boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi  |  4 +--
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |  5 +---
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts |  1 +
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |  2 +-
 .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi |  2 ++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    | 35 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi          |  4 +--
 arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts    |  4 +--
 drivers/soc/qcom/mdt_loader.c                      | 12 ++++----
 drivers/tee/optee/ffa_abi.c                        |  4 +--
 drivers/tee/tee_shm.c                              | 14 ++++++---
 32 files changed, 139 insertions(+), 66 deletions(-)

