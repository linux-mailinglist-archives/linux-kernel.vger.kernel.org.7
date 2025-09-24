Return-Path: <linux-kernel+bounces-831271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41347B9C3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E8F7A39C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758E285C89;
	Wed, 24 Sep 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cczReymv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9CJ17iZ"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529623B62B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748225; cv=none; b=Yd1bUtTzC+8utzWgwx6zo7MZqTlPHKD4Aq4JLtnQ8pl3IkHnysw5irwtM/wkpBSrZbBRNDbCPc3PyQvtPn8eaBUXPHlE2pzADY4m3RHsUsFTerl4tHF2YU66TEZRE3BsxXG+1Fsqhh+Z1Xc2JvkdchP+s2txXS2AIYOUjcVO2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748225; c=relaxed/simple;
	bh=RO0tKW3sL8F2joy6i6xwtQhE7IsCttedNvIzrzTpHl0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=fEk5CETNKeFwCDPLZPlB3f/XHFqTYxxA90iZ2Qo4C4eV1EhknBHtDoNw3cNJmCGI6lnTxyWgUmmvUBeV01yCMfQnbnTC5Eb19RKY6jQjT3PxWJL5+RUM1kSfrU7CT9tUet7KuBHOEk6va++8VI3xwpg54JkVfVrZ/XMh1O9oFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cczReymv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9CJ17iZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 85B44EC0177;
	Wed, 24 Sep 2025 17:10:22 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 17:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1758748222; x=1758834622; bh=s9
	+E7CcmL2AGPTpCUHFVgVtr+tUxO40W8zKKqRop2qI=; b=cczReymveyjXCZMdrt
	lU1QwRSFnbkIkKVN7i11AdGuU6ilXmCoswgGYUlplW671tG6ZZNjje+pSoUER4I8
	9tsuWTSqziW3DcfMzqhMYyKWQYw38aKZCthg9TZu+IJW8Bh2u3yPcOeKq9bgl4gH
	lBl/HszTkDrkCXqZN7+INEJRPxLLsbjnunp/yt1DwDihkGfKkXea5+hlzYlgDGz6
	eSHNprUbOGES7BrikCBM75eAx3XwVG9a30lqF21yxaKwU9MxSwrXvtYDyE/lASPW
	wVDHXeMUdj0BgmzFN3x6hrvIxmZCxrY/kLEwa2eslSQgeKFbLbGoJYa+eaFQ1FtM
	kEgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758748222; x=1758834622; bh=s9+E7CcmL2AGPTpCUHFVgVtr+tUx
	O40W8zKKqRop2qI=; b=c9CJ17iZCiLZfGonu96fi2VA8XlPuBZe9sXKSDWtxJVa
	zzmSSH3bAxPc3Cg4RlLQasmLAa4URT7m0yh7hZbAkTPjqPPJl1TiKzQbDVCERRJW
	O8sx7moJDVeEK9vc7pxvbvH55VYv8EiJlmyrjPNhB+e+JRyPyVcdj+R3GQfsriq/
	y4wRZxON+PEgnnLFVCYrJiLy+jTUS5nt10WE7tc/O3lnlQwsynPxEmsR5cDyA5r0
	fzCRka8gt3ab6Kh8KeC1gywOl6PBCNNloQnm7xrWJhz/Jd9jP9IS/i0T/V86+ig3
	GBN4POJNsjvf3hVCedXPTQu15EHUr1zcnXyNW3tisQ==
X-ME-Sender: <xms:Pl7UaA1raZNvRpMUQO-BzXY9VQuLsEv3J-xI6pcCxnUg-n0-REnjsQ>
    <xme:Pl7UaF4Wm0v4j4U-DfoHzxqbWMy4bqK6xf-eyKptMsPtv2iniql3lnaG5cFVq7o2-
    EcRrLNIeXjsn3zI3ytcdAEruGkeO8M0h0g-wjUFVLzqMHSYuoiv6oFF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    eggfeggfeiheeiudffkeeifeehveetffeuhefgheeutefgveetjeekheefvddtheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpvghnghhuthhrohhnihigrdguvgenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:Pl7UaOjeIud6WItB6tT9SsabL2OluFtbH2f_knyRz4FuCPapjiYC2Q>
    <xmx:Pl7UaIXI6k-f_tqt98T2vZ_dwN0vZd3se_kirZOD0BFI63cjLP-7eQ>
    <xmx:Pl7UaNWtMI7IFfT2Bd1SIHHOb2zN6j-kiwFoDcmbZFuFnK1GzXPDCw>
    <xmx:Pl7UaIiAc8xzXYowpK6ydFENZrumS6S6zNpuLX05mDPAuNxRCX7g5w>
    <xmx:Pl7UaOvQ8QKO-gvVOr0Wwl_0wTAgj2Uq5hu3vm51m9yAzndPdaJt0sBd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 26D8170006A; Wed, 24 Sep 2025 17:10:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 23:08:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, soc@lists.linux.dev
Message-Id: <6565e739-19d5-465a-9fb5-d918bcb24b56@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.17, part 3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 875691ceb8bd619de7791243b1cf6184ab534865:

  Merge tag 'at91-fixes-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes (2025-09-03 23:02:54 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-3

for you to fetch changes up to 13923775d5b0b47656e800bec7baf50a20474aaf:

  Merge tag 'tegra-for-6.17-firmware-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes (2025-09-23 22:34:35 +0200)

----------------------------------------------------------------
soc: fixes for 6.17, part 3

There are a few minor code fixes for tegra firmware, i.MX firmware and the
eyeq reset controller, and a MAINTAINERS update as Alyssa Rosenzweig moves
on to non-kernel projects. The other changes are all for devicetree files:

 - Multiple Marvell Armada SoCs need changes to fix PCIe, audio and SATA
 - A socfpga board fails to probe the ethernet phy
 - The two temperature sensors on i.MX8MP are swapped
 - Allwinner devicetree files cause build-time warnings
 - Two Rockchip based boards need corrections for headphone detection
   and SPI flash

----------------------------------------------------------------
Alyssa Rosenzweig (1):
      MAINTAINERS: remove Alyssa Rosenzweig

Arnd Bergmann (8):
      Merge tag 'mvebu-fixes-6.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into arm/fixes
      Merge tag 'reset-fixes-for-v6.17' of https://git.pengutronix.de/git/pza/linux into arm/fixes
      Merge tag 'socfpga_dts_fix_for_v6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes
      Merge tag 'imx-fixes-6.17-2' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'apple-soc-fixes-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux into arm/fixes
      Merge tag 'v6.17-rockchip-dtsfixes2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'tegra-for-6.17-firmware-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes

Conor Dooley (1):
      riscv: dts: allwinner: rename devterm i2c-gpio node to comply with binding

Jihed Chaibi (2):
      ARM: dts: armada-370-db: Fix stereo audio input routing on Armada 370
      ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients

Jimmy Hon (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5

Johan Hovold (1):
      reset: eyeq: fix OF node leak

Josua Mayer (3):
      arm64: dts: marvell: cn913x-solidrun: fix sata ports status
      arm64: dts: marvell: cn9132-clearfog: disable eMMC high-speed modes
      arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 ports

Krzysztof Kozlowski (1):
      ARM: dts: allwinner: Minor whitespace cleanup

Lukas Bulwahn (1):
      ARM: imx: Kconfig: Adjust select after renamed config option

Marcin Juszkiewicz (1):
      arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address

Peng Fan (4):
      firmware: imx: Add stub functions for SCMI MISC API
      firmware: imx: Add stub functions for SCMI LMM API
      firmware: imx: Add stub functions for SCMI CPU API
      arm64: dts: imx8mp: Correct thermal sensor index

Russell King (Oracle) (1):
      ARM64: dts: mcbin: fix SATA ports on Macchiatobin

Thierry Reding (1):
      firmware: tegra: Do not warn on missing memory-region property

 .get_maintainer.ignore                             |  1 +
 MAINTAINERS                                        |  2 -
 .../dts/allwinner/sun4i-a10-olinuxino-lime.dts     |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi   |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-r40.dtsi         |  2 +-
 .../dts/allwinner/sun8i-v3s-netcube-kumquat.dts    |  2 +-
 .../dts/intel/socfpga/socfpga_cyclone5_sodia.dts   |  6 ++-
 arch/arm/boot/dts/marvell/armada-370-db.dts        |  2 +-
 .../boot/dts/marvell/kirkwood-openrd-client.dts    |  2 +-
 arch/arm/mach-imx/Kconfig                          |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  4 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  2 +
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         |  7 ++--
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts |  6 ++-
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 22 +++++++---
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    |  8 ++++
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi |  1 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi      |  3 +-
 .../boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts |  2 +-
 drivers/firmware/tegra/bpmp-tegra186.c             |  5 ++-
 drivers/reset/reset-eyeq.c                         | 11 +++++
 include/linux/firmware/imx/sm.h                    | 47 ++++++++++++++++++++++
 22 files changed, 113 insertions(+), 28 deletions(-)

