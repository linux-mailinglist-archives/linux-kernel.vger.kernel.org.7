Return-Path: <linux-kernel+bounces-878367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84DC2067F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 166D34ED4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1760B264A92;
	Thu, 30 Oct 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="B5LfjrYA"
Received: from mx-relay144-hz1.antispameurope.com (mx-relay144-hz1.antispameurope.com [94.100.132.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5822A7E0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.198
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832447; cv=pass; b=iMdrNZaD89PofnZBASQ/hcfZqFrSCw+sec8A/WFWL3UkQeZusbcBTzA75VvhyO3qrO1tigJlVxaPtkU2JIKo7Rwg6wVZ8h7W3mszBIqi2VnVVQEGYTT1ENpuu6Txt8Oybg2TLz+DJr5iX2aNWTIPR/XiyIqAZIZfkVDdY9FOudA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832447; c=relaxed/simple;
	bh=sIZggCHnGSlO45HiHftHmYcFFF8Ni5TxagNbhsJfx0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hajogJ/6gUMNNtkJzqZO+Snz5PDdDkljgy9sUm20AIrCYLXhIPkp9Iz2FjhqMbBelazifZRTNJExkM8rvekJpJyl9XDkSYWiWxTTQNLSHceZofJ5tXZfpR+KgcbPrYMvDsD9qE7HMSGVqFF9XRlV83tXS4ndJkEBR1wEZCxXNtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=B5LfjrYA; arc=pass smtp.client-ip=94.100.132.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate144-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=tD+ajNxptu2k73Oepl6KZlA3PKs0QXwWaX/tcX3eJ2g=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832409;
 b=YEGFgKdOv+NuqeJgx01AzUPYKgSJ0xY0PMQOZL8vvHXOCNedl4+ww6Y1aRrNL1qSbRt8/xTS
 PqiTzWhSxVaD7xyr8CAj+WKbOrE1sDNYpDJRKuvtoPoCzAZ7ItpITo/h/2Eb4W32tX8uvfEprBZ
 GLJsyXcd5wRlpEWfplywKXxkr4ZDiIcNiMaPJ/NW6nK9PXNaqxFalaNqr0CJRW26m9HSRmclHNg
 dTkMEY41fQwG+etjbXhkZjfrYRlJzwt1/s/jpZ1siE3wmoIBxTVO6yBhEGqC6/kKlDRKEVK3Cgj
 EK6GKToK8S5/KqDCjjuVHC9OokB9q+KFs5wtCZeLU64Qg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832409;
 b=Re36E0lhxxWcdEBpz55bWR7IUDXRsZvGXq0OBBzwl8Rir9hPdGWUlfydyPCW4VC5J9QqT/Hc
 S4iMSWHSZji0mVBX869jy+DbgzMbrzxTrHaIB3EpyO7KJWLaqGoXhZMUjT62rmot2Rn1VmqajW5
 9+xXK/ZOC7TSRlm3Bf0cz/wYAeNOvEbEI8hAKTlo+wVVZPe/gDaP38JBXdkR2g4hCoCzSSiNukv
 4dNpmYLJJ/qBpux3G1qaNOu1VHk1J16O6L4NfBI1CM/GumeY5RKj8s9OgFxxgAalScBIjb+qN1b
 yAosiYq7TUIMa+L7+/TT0ejS7R+oyIfgRb4lxkNrCE/1g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay144-hz1.antispameurope.com;
 Thu, 30 Oct 2025 14:53:29 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 3E3895A048B;
	Thu, 30 Oct 2025 14:53:10 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for i2c
Date: Thu, 30 Oct 2025 14:52:53 +0100
Message-ID: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay144-hz1.antispameurope.com with 4cy5D70PDbz40bjJ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:1f356f726ad2319c426137b927962cc3
X-cloud-security:scantime:2.049
DKIM-Signature: a=rsa-sha256;
 bh=tD+ajNxptu2k73Oepl6KZlA3PKs0QXwWaX/tcX3eJ2g=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832408; v=1;
 b=B5LfjrYAxAUFC6gsZqcqdDLD3RTVbThYiNFJ6uQq5pvuZqD5zUykeE42/pczoQmRHOujdCPz
 yRtpXrfNNRmhnwOdj+kbA6kXCI7/V9w4pgSy993/wRu2TbK8cVhFvnmMOIAUEK8X3CjVhtgpKwl
 Q8PEa+EIRky6P40mkGL57zcLLmLUK2rZE/TdgBpjWCMoaGAlpIo0yJgxtVkHviMJYnu6YaGp4K8
 ZyqcXQX/396lDjP3c/9D0iJMQOguXevTvpxod3/FWZ7LcvT5w/XHB3uP5UKUnCEsPgpry1O82A+
 gvZz1fdUPYz2Y/rSg9EPyGmsZBjsBi+CAECNBQyLPNHZw==

A sleep pin mux is not useful if it is the same as the normal pin mux.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index b7136982700a9..a6ab94208028a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -165,9 +165,8 @@ &gpio2 {
 
 &lpi2c1 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c1>;
-	pinctrl-1 = <&pinctrl_lpi2c1>;
 	status = "okay";
 
 	tmp1075: temperature-sensor@4a {
@@ -264,9 +263,8 @@ expander1: gpio@75 {
 /* I2C_CAM0 */
 &lpi2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-1 = <&pinctrl_lpi2c3>;
 	status = "okay";
 
 	dp_bridge: dp-bridge@f {
@@ -301,18 +299,16 @@ dp_dsi_in: endpoint {
 /* I2C_CAM1 */
 &lpi2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c4>;
-	pinctrl-1 = <&pinctrl_lpi2c4>;
 	status = "okay";
 };
 
 /* I2C_LCD */
 &lpi2c6 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c6>;
-	pinctrl-1 = <&pinctrl_lpi2c6>;
 	status = "okay";
 };
 
-- 
2.43.0


