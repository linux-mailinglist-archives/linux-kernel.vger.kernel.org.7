Return-Path: <linux-kernel+bounces-895945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48716C4F566
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283FC189FF21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C293A5E62;
	Tue, 11 Nov 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WTn94Svt"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12961324715;
	Tue, 11 Nov 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883726; cv=none; b=havFaFHnxeOlEiPbhs8x8pCSVHLvLJvlx/xBrr8EKZC1PQKP2pSat+cwRZgFiP9KtMgTIvXC4rlfMqvqrPTaTIE/eQQQ9FL1G+M2IaISsXfHoDF2YnmB1ZG06CdmJ2z1dBxyTjUgke53xgMQctAV2Mm5e5rmet3zhFPIvEkiuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883726; c=relaxed/simple;
	bh=Y6J0Hd5gaL73HcZS89JD0EhfuCPAjjDOoIjZ5JJxNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5oyXZpB2f/vhaf6trloURwR4ijR1zPkIPuNBHhJdSOPvMnOUMK24tUlfv0LnyS0FqROXdgQzhkegrb1vliTPhbHULYQJlJJeLg+2NXWq9iqkrKm2dX3On5bqdadp2bQODO0UFX8ypEDXUmzeowGhkLaKX5Sfx29C1hM3KsNQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WTn94Svt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from localhost.localdomain (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 39AFA1FBD9;
	Tue, 11 Nov 2025 18:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762883720;
	bh=fdNDyOX4NAmg5jJPp/BSNYVyFEaiphE74uzwC/EVG8Y=; h=From:To:Subject;
	b=WTn94SvtsCWamAxJn76sKb5PVF8wUtAu3vxP8QvKN2VHmuVyJelm7XaBPifHaxlaN
	 MaR5OND/QLf38IiyZgM5Q72xEq6gwfw9oCX/9AwgrF3k2Tp4ceWd5UwkTxx9iMXgRC
	 b9sEMhYZeF0C7vCwv7v0T9qfhA3oRu6+h9DTEnpB9yJdbLu3Np5nAW6kJvt9Fikv53
	 pEtBmRHn7MQ78Bx5G0eSr+GQZw0083GzaJTzU+Bg/AQ8LqZr2k4URjPV3ScE2ERO4I
	 ax04uklnhcPRkG0zMYLchzscreSYAebssCfcvervNjIWYC4K3Kmq0ZB0fls6ZoStfP
	 CzxLfmxDwdirg==
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
Subject: [PATCH v2 0/3] arm64: dts: ti: Add Aquila AM69 Support
Date: Tue, 11 Nov 2025 18:54:56 +0100
Message-ID: <20251111175502.8847-1-francesco@dolcini.it>
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


