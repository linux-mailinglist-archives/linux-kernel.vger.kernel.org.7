Return-Path: <linux-kernel+bounces-884972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A97C319C9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1277346F03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EEB325482;
	Tue,  4 Nov 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="d5Opm/36"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA42F691B;
	Tue,  4 Nov 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267784; cv=none; b=FNsz1/CzaxH10O+sxV28pwKA/UCgF2coU64WPHzspG3nbLXF3ZnEAjyhFMBtV5g2bTdj4OUCXixRfXMxoz2PNj6BHg1jntQ0824C+lY5VnfOLmPkLfXTxeWd7mGReZ2Aig9BKZz2SaMxzWGpQCf7puTt64DTQKzZOjydRcMADDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267784; c=relaxed/simple;
	bh=Y6J0Hd5gaL73HcZS89JD0EhfuCPAjjDOoIjZ5JJxNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eD/5LBPR1uSCPXFVhGxj4Xe3sZAdEBqY8J4WcOYuTzWiG3sjZWF8jK3qOsm3oocnJZa8QI2YOIYpSs0EEuCO8m//06+GCIRMlCNtmKwsks7pxEUTNR+sFMgjUfJkVoq3we1ESoSPO91f5UXfO3oIFIJZGlgNkzEVqML6Ky3iy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=d5Opm/36; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 7F3761F8C1;
	Tue,  4 Nov 2025 15:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762267771;
	bh=fdNDyOX4NAmg5jJPp/BSNYVyFEaiphE74uzwC/EVG8Y=; h=From:To:Subject;
	b=d5Opm/36Lqni0IV5t3VtljEiTBIc1zBAT/56ZepB/aCPiJtkzot2RtEU4RKpAeFKC
	 XddB/mkvKvpgFrWLmumzpOhgRiZr/2Ow2/R8KfX7su4Et6N+BUxgv/iOf91NOh4Rtm
	 THst4LYgwlr/GUn3oiocudX1KGRVSgtMuT6utnSLH2w2X0TviEEjzqjIyN0jCs+O2P
	 bgsi8vzl2W7392y31J8cSXNaYezvZo1J4IMJoEPhZ/B402pTcbEY8EO/Knbja/qpdE
	 3iYBa8HHxpt3K3rXcw5KKxTL3nbhBtH/6vLVD/c6M9Xf4rGgnRupFgrCTwVTqBrUni
	 oNvgLAdr8iKLg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: dts: ti: Add Aquila AM69 Support
Date: Tue,  4 Nov 2025 15:49:10 +0100
Message-ID: <20251104144915.60445-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This patch series adds support for the Toradex Aquila AM69 SoM and its
currently available carrier boards: the Aquila Development Board and Clover.

The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7 family and
is designed for high-end embedded computing. The SoM features up to 32GB of
LPDDR4 RAM and 256GB eMMC storage, extensive multimedia support (3x Quad CSI,
2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet interfaces (1x 1G, 4x
2.5G SGMII, 1x 10G), USB 3.2 Host and DRD support and a Wi-Fi 7/BT 5.3 module.
Additionally, it includes an RX8130 RTC, I2C EEPROM and Temperature Sensor and
an optional TPM 2.0.

Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
Link: https://www.toradex.com/products/carrier-board/clover

João Paulo Gonçalves (2):
  dt-bindings: arm: ti: add Toradex Aquila AM69
  arm64: dts: ti: am69-aquila: Add Clover

Parth Pancholi (1):
  arm64: dts: ti: Add Aquila AM69 Support

 .../devicetree/bindings/arm/ti/k3.yaml        |    8 +
 arch/arm64/boot/dts/ti/Makefile               |    2 +
 .../boot/dts/ti/k3-am69-aquila-clover.dts     |  451 ++++
 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts |  576 ++++++
 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi    | 1840 +++++++++++++++++
 5 files changed, 2877 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi

-- 
2.47.3


