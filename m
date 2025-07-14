Return-Path: <linux-kernel+bounces-730206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D301B04158
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA7C3BE5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1EF257426;
	Mon, 14 Jul 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="omupmzee"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7501EEE6;
	Mon, 14 Jul 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502820; cv=none; b=I9EDBm4oDBrBWZhW8uf6YkhVaTMhX1uEcmELLt7lmPESIV3ei41Iz7W+mE/JwSTHkoywzucA/QxhgNUK80sNkKFU4CZ6ilXYuH8Ir21e5hXYGCWMZWumYI060hM4gB7Y3zFtYljFjszvDsgTAoy0KnIm7yoDftPdYXWT7P8AtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502820; c=relaxed/simple;
	bh=cdKakjEiEJ+Vw1ngqXkD0STuu/299jUMI/GApRSc0HI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD4dNGeclT4C3Rj1iXOemgSzLqM2TdyVQ8bc2bo5ckC0gkrEvklbfiqVNdNrBSrEa0AAQZFzsE0ngqigdZWYD02PsNhFksoocAY2aTLP4ZrRiJwmCx5xAR0T1NFSpRT72MCaDQhl+TFDg2yMxZ66dbjzZqhdomrqTOz1CCqxSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=omupmzee; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ABF5C753B;
	Mon, 14 Jul 2025 16:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502808; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=kLUPCcyt1YHVLaj1oyuZREp8SkO7pHfluW3ya2N7oqs=;
	b=omupmzeewGiCKSZQ+SLZiwGrcNW/clFo9k3qdaKIHWdmjVtECzjJ2n4oYaEIvVa5jecypj
	tJFVNJeaHuG3fEv/avGhqQvrCtqdnWnyg/xOSnsaV6QtWWZUSNqRvPLYZHbbV+GaAtgeHe
	pLLRaTTDm6CeEQMxIv3/9T51eX6/xklCuW2PzsANFd+pjn/drzOj8gfpFaHww0yJP8DCK7
	fW/rmYDDcJ8UPSUpjjUFnzZq37r7SW1kjzIhJQXZ/1HV1UpwlsfGnF0BY8xuGOuq6Hyqyq
	7tzcg9kGwriKnXCw4GT0xWmhOGoNe1EmXhf3/iB1OaRxsS3Rj5o2kL6inzBvdw==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrej Picej <andrej.picej@norik.com>,
	Annette Kobou <annette.kobou@kontron.de>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Oualid Derouiche <oualid.derouiche@kontron.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Teresa Remmet <t.remmet@phytec.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 00/12] Misc fixups and changes for Kontron i.MX8M and i.MX93 DTs
Date: Mon, 14 Jul 2025 16:17:26 +0200
Message-ID: <20250714141852.116455-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is a collection of changes for several Kontron ARM64
board devicetrees. Some are related to hardware changes,
some are bugfixes and some are cleanups, some are improvements.

Annette Kobou (3):
  arm64: dts: imx8mm-kontron: Add overlay for LTE extension board
  arm64: dts: imx8mp-kontron: Fix CAN_ADDR0 and CAN_ADDR1 GPIOs
  arm64: dts: imx93-kontron: Fix GPIO for panel regulator

Eberhard Stoll (1):
  arm64: dts: imx8mm-kontron: Use GPIO for RS485 transceiver control

Frieder Schrempf (7):
  arm64: dts: imx8mm-kontron: Remove unused regulator
  arm64: dts: imx8mm-kontron: Sort reg nodes alphabetically
  arm64: dts: imx8mm-kontron: Name USB regulators according to OSM
    scheme
  arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
  arm64: dts: imx8mp-kontron: Fix USB hub reset
  arm64: dts: imx93-kontron: Add RTC interrupt signal
  arm64: dts: imx93-kontron: Fix USB port assignment

Oualid Derouiche (1):
  arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL
    devicetree

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-kontron-bl-lte.dtso  | 186 ++++++++++++++++++
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |   8 -
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |  12 +-
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso |  11 ++
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  50 ++---
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts |  59 +++---
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  |  32 +--
 .../dts/freescale/imx93-kontron-osm-s.dtsi    |   9 +
 9 files changed, 300 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.dtso

-- 
2.50.1

