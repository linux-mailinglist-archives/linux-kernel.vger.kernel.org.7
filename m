Return-Path: <linux-kernel+bounces-739031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5BB0C0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619CA4E1009
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF028C87B;
	Mon, 21 Jul 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="rGiSV8bS"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2C28C84B;
	Mon, 21 Jul 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092517; cv=none; b=eYkPT6pPTl90yRs9VHQeeoEZsmmnpqf91FoDWqpMkMeyPLRZhceYGgORY5Ek9pYz0n8MNTzkYcXc78Hs9RRIotyFuNhLVGrcPU2zkGhb6eYYn5zadUUiDCKOmOjRWB1thJnot7MAkgS7qYrqvcYuiZvIDnQELTm6odx9AT/AZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092517; c=relaxed/simple;
	bh=YlMqV9K0VO+qrL5y6ZXQy+k0bzHkUIsVHeFAWRt+jUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOAmC+ckEy4lmkFk10Ps7XGizdFxtQT3xz+vHMP7G1UBbFr21pttkNyMC/SBfzUmHmvSUcJnsdMR+XGGkIrUh3mStcIajeVDG3w/H18tCbE4g1m1g5Bw8Hl8iEr6+oFUlvnnev6dT0fIaD8hejNvOVEYO9UP8yYvm03wcrLHBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=rGiSV8bS; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F3BEC75FD;
	Mon, 21 Jul 2025 12:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092512; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=G6t649V1EzrZ/HP6mEg0Xb/fiQdeIFETtkrsh9N4wsQ=;
	b=rGiSV8bSE//KClQUGVH00FIpD29OIIppuf94nldIor2qJQf6POkkVsT/+Ud2t92fpdLvVh
	4hifYR24p/EzCkMj3/eI/h8E3yvbMWGGWQJmQL/f2d/LxBM8W62vBva0fTtYZjwmPu6Eh2
	m8LUD5h0W9Y5AFYdF+iNdigARckHT73lGd0bQmsOO2ZkiioUiTF9rXsR7qfDootIu+NgJG
	DdgabyI/Wfr+gKBXkx1qzkaVJ12sKbihQULF1qr55MA3NKqqJaDi94WT8rP3K248JX0+vq
	JatLmETUU6ErU5a4VFgpuu4Tyj3bNBAEXDFt0rMvsORNQsK3P7fkqIn2SDNBjA==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 02/12] arm64: dts: imx8mm-kontron: Remove unused regulator
Date: Mon, 21 Jul 2025 12:05:36 +0200
Message-ID: <20250721100701.115548-3-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721100701.115548-1-frieder@fris.de>
References: <20250721100701.115548-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This regulator is not used anywhere and is not available in hardware.
Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 33f8d7d1970e0..3a166cf0afcb7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -48,14 +48,6 @@ pwm-beeper {
 		pwms = <&pwm2 0 5000 0>;
 	};
 
-	reg_rst_eth2: regulator-rst-eth2 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-name = "rst-usb-eth2";
-	};
-
 	reg_vdd_5v: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-always-on;
-- 
2.50.1


