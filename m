Return-Path: <linux-kernel+bounces-881176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0483C27A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662A91A264E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EF2C11E5;
	Sat,  1 Nov 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="st74lANo"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CD2C0F7D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987252; cv=none; b=jgcF2I3M+mlXGaFqgOCO7h7OkqKKGKbjib6M/xlGe3mKCZ8BIRHM5bxk9x3tXZEKBLt+JDG8JeGvruqVwZDn9IZ8RyeSk9DTm6TdOoq3zofGXVdKlqaPfYYDA0AXeOTEHmg3s89BAvB4/3QNAiulebYuuRU6zczDVS+wwK4OMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987252; c=relaxed/simple;
	bh=nBWa0ag7woJY2vPCiQSnDe7vW7z+266sYVbZE0b/SD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScdYTXQDpSvJDBeSjcEZcIvvYNsL7KV7USXiEL6Hgi5kK7bFzMIbzfUDf/ojtYKN8h+LPewoIsTXNZZKPhNnuRjQOKKWjih65Ve2t9xOmniZoCh1XBYaToUKrEs2Q1K2Cp90GRXbjorjeBGGbIhmAGEK5FK60JJA+R7drGFZmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=st74lANo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D7F244E4145E;
	Sat,  1 Nov 2025 08:54:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A74576070B;
	Sat,  1 Nov 2025 08:54:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 462651181ABE8;
	Sat,  1 Nov 2025 09:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761987247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iTiW6J9ezHzkr5T/PBNfpX9M9qHogdCahO4t6SNr+IY=;
	b=st74lANo4OlJ/tptXaUC8c9aNVt7911cx5wVdtmRVe4lXOoONU4kYKOcMYktLWPc1FK8+9
	v6pbAIFwfzzXvu0LqyHv6IY9Keyr9oioqKgKo8dcswjdx9tPBnlYx1tm2TvJ/JnJuXgeLo
	bnFwVUHhyZh2zdH99yRj3XgYAQPs5gj/U0XytcTUXATlLIyxcPL0zznH/Tmn2ChwncqrU8
	PQIQVCMi1PzRiuydixHRZFdXde++eqQU3zAxXcchIVlCHTBCxZHx2TP6IwZmz8FsSVKjah
	IAY+XT+wbQHUoWwaQoHhZI87jb/ia6QgrtWL/bYWoaSN2X026ljm9SxdyAmOKA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Sat, 01 Nov 2025 09:53:35 +0100
Subject: [PATCH v2 7/7] MIPS: mobileye: eyeq5-epm: add two Cadence GEM
 Ethernet PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251101-macb-phy-v2-7-c1519eef16d3@bootlin.com>
References: <20251101-macb-phy-v2-0-c1519eef16d3@bootlin.com>
In-Reply-To: <20251101-macb-phy-v2-0-c1519eef16d3@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The Mobileye EyeQ5 eval board (EPM) embeds two MDIO PHYs.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
index 9fc1a1b0a81b..babf52731ea6 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
+++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
@@ -29,3 +29,29 @@ temperature-sensor@48 {
 		label = "U60";
 	};
 };
+
+&macb0 {
+	phy-mode = "sgmii";
+	phy-handle = <&macb0_phy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		macb0_phy: ethernet-phy@e {
+			reg = <0xe>;
+		};
+	};
+};
+
+&macb1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&macb1_phy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		macb1_phy: ethernet-phy@e {
+			reg = <0xe>;
+		};
+	};
+};

-- 
2.51.1


