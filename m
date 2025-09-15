Return-Path: <linux-kernel+bounces-816013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD28B56E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A430189B907
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740C220F5C;
	Mon, 15 Sep 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RET7wyI+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A921E098
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902410; cv=none; b=fvdVISwAbeesPsEXsVzaiIo8+slQqo8WdsjiWODY+CFKazf2ECeL73gkjlU0NEh97rBoaEBFQYyAufRs2SJiDuIDS8SyIcZH2s7SOzhEI2VJ90HbtaJ1Ow99zlUHWaYkDi+gC2gIkT5XJTWDlJDWCU9QpGwlxD/Ng5HgVy6pk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902410; c=relaxed/simple;
	bh=SMqAydrRlAWaSLUNJ6U8LSRxn7jkqUpS4uBIprB2vRI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FykzJiYOGfzU7P9SO3RWmCL86LiyTxwahqkAkDx/zLr7v5ghoS3qcUERbvqwkp75ayBwnH1oRiRGADTfQXChDKx0frVIKFaj9wEnvlLShcLKFr/tduRdWld+w+fTNI8TJjpRi0Orqa2wYx/DWrE+t+THYP6V5W0LE75INWXeIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RET7wyI+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757902400;
	bh=6J20VH7voOyYroc7sd9mKpuRhnqygSA4dyoSLLqxRHc=;
	h=Subject:From:To:Cc:Date;
	b=RET7wyI+uYL1ZDx+gaIsj+SAAaoN8t4X90mneLv15rom0Fm29zZHh/Ed1WbOlZYV7
	 gTYGB8UmEQanMKNvTArQ9OfsQ9CxCSzfrOrmHdbI/bX4hENeu/j9/LqyURN1FoqdII
	 NLw2wYuZ3G8RLQ3k89clt8E2Jxsc4TXhGimVYrwMaxuHZPuKfS1cxgNS411rXFzheA
	 pkoAZbpn43mt1lnFVDmizzX0YuNBGwD+ASCbyBxvHuLDgcuGOYO76J5R4xRCNfQN70
	 LY6CgBtsj1zH0p5K+tfGR5wQvNVfJMZhMbOp2c8dI7jb1MAdmMDa6WrzYwASL9Gt2N
	 eoRxqVgCotlog==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 25AD7640BB;
	Mon, 15 Sep 2025 10:13:18 +0800 (AWST)
Message-ID: <5793039afcedeb28179a3c9909631d8251abc73e.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: further devicetree changes for v6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 15 Sep 2025 11:43:18 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

This is a second 6.18 PR for the ASPEED devicetrees, following the
first at [1].

Cheers,

Andrew

[1]: https://lore.kernel.org/soc/cb634cffaf0db9d25fb3062f0eee41e03955321f.c=
amel@codeconstruct.com.au/

---

The following changes since commit b785b5d88cc27a521ea22b3afd85804c4c321d4a=
:

  ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax (2025-0=
8-11 09:37:48 +0930)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-devicetree-1

for you to fetch changes up to 3708a165a98c23cc83216deda88bc7d64ba85527:

  ARM: dts: aspeed: Drop syscon "reg-io-width" properties (2025-09-10 16:20=
:40 +0930)

----------------------------------------------------------------
Further ASPEED devicetree updates for v6.18

New platforms:

- Meta Clemente

  Clemente is a compute-tray platform using an AST2600 SoC

Updated platforms:

- Harma (Meta): Hot-swap controller, power monitoring, GPIO names

There are also some devicetree cleanups from Rob and Krzysztof that touch a
variety of platforms and the DTSIs. These lead to fewer warnings emitted fo=
r the
ASPEED devicetrees.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: aspeed: Minor whitespace cleanup

Leo Wang (3):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: Add NCSI3 and NCSI4 pinctrl nodes
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

Peter Yin (3):
      ARM: dts: aspeed: harma: add power monitor support
      ARM: dts: aspeed: harma: revise gpio name
      ARM: dts: aspeed: harma: add mp5990

Rob Herring (Arm) (3):
      ARM: dts: aspeed: Fix/add I2C device vendor prefixes
      ARM: dts: aspeed: Drop "sdhci" compatibles
      ARM: dts: aspeed: Drop syscon "reg-io-width" properties

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        |    1 +
 arch/arm/boot/dts/aspeed/Makefile                               |    1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts      |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts       |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts       | 1283 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts          |   43 +--
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts        |   36 +--
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts      |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts      |   12 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts             |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts                |    8 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts         |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts     |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts            |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts               |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts              |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi                 |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi                         |    1 -
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi                         |    2 -
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi                 |   10 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                         |    6 +-
 23 files changed, 1360 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.d=
ts


