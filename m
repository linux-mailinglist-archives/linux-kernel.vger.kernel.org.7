Return-Path: <linux-kernel+bounces-842478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C836BBCCB2
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB501890909
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C821CAA85;
	Sun,  5 Oct 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xTjpe0gj"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A92A1CF
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759701131; cv=none; b=ksAbq6nzHYsUiBhZtL1Ud996n2pgtnqwxsMaeRdIMdaYg0NruBw+QyntOQVp7p6NtIzS27ee775qbiiF/vrutUpiUf6FUqN6KH7v6cbAKWmWvVUNdY+pqm7z2wKi10ZeynUMS34fDCRGQ+u4yA7yLmPu0BchP+FbRiU8KyD9lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759701131; c=relaxed/simple;
	bh=08W6Kwy3jW8/F90wDEtMrHnRQUE0hr5hEhuG7b0c9aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egFKXGMEt3d7Uqb2cmlMRy83kElZYWaZtXLK3kpYXkHs/GD60qhBJ7D0vwl3R6R0FbuzKXgK/SaqfpkzQeMs4aehfGNTKS+4C81mhKZwNbHWAfBsPljytRshCjgo8odA0BHniwA3ZgHSDmgX2SzpSJdiB0o1OQkWrgDxohALM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xTjpe0gj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 53DAC1A1109;
	Sun,  5 Oct 2025 21:52:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1806E6065F;
	Sun,  5 Oct 2025 21:52:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D71EF102F1CFA;
	Sun,  5 Oct 2025 23:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759701125; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CSMS0CXfRVEbW7/IAycMvjhwOpwfcl8AilW2Tzo8ENw=;
	b=xTjpe0gj2TcjVRSgjDHkX32NBe/s8UUmjSZqoM89yCanjaSMZp4DG3xMU2WmZhUtnwSR8f
	o142dWAQbz5ERd4KUleFMQB86xSjzPwxx5YXGt29yIL/86YRGhs5JNSUBaW5Bz+coIXj+F
	FP21CgZY1iBR+dwCPcE49cU6EPNKjaqBk3rV4L2grasbi5YtK/l8zbfTNxa+JyVBom4QoM
	8871x2WB77IXzl6XPdSjR2ooe4haD1C2zMk8+qHF54Khd9gOl3UEc+V9e6vv6wtvc4HzW3
	ydOPF6z1jxJ8bo8C2VBwn+/+8iag71I/XflX/mrkTc4sf+HqK10HEFyo6ooqKA==
From: alexandre.belloni@bootlin.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-evi: fix rtc compatible
Date: Sun,  5 Oct 2025 23:51:45 +0200
Message-ID: <20251005215146.3804629-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The correct compatible is nxp,pcf2123

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5df..5da9631cb3ec 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -134,7 +134,7 @@ eeprom: m95m02@1 {
 	};
 
 	pb_rtc: rtc@3 {
-		compatible = "nxp,rtc-pcf2123";
+		compatible = "nxp,pcf2123";
 		spi-max-frequency = <2450000>;
 		spi-cs-high;
 		reg = <3>;
-- 
2.51.0


