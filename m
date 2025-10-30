Return-Path: <linux-kernel+bounces-878245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE2C201BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FA246164B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0D3570B5;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f+VB2gwl"
Received: from mx-relay164-hz1.antispameurope.com (mx-relay164-hz1.antispameurope.com [94.100.133.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C7340281
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828668; cv=pass; b=p2Qp8jhZd34O+kR5g+j5aGVDZVop9svLW11voyqpCoPxlUuC5oHiDe/ZBeM5Q6vvAev2p0VjY11s8WquqTFstBncWM5UCtQruXCSBznL9d3F5prY8VIa9xCNOl1qqUKR2ZqcVQBdiwmbWxqYSGAwhLzTdtnSBEpw9aicw+WpzEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828668; c=relaxed/simple;
	bh=nuhZ3TcRNxc8iA4zNw99CDtFaforLONChmZfXktBvWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk3Eh+SEvEmKYwvLVVsRAW9PIISRxT97EMMd+94dBkT2F2JUb5gu3/rRa9cZA2PBcOTCQ8JHV6COkePlT+rLUfKdRDovHZFWn83OaJr+QJtC/rMdOWSsfo60vZZK5cX82UHt6g/l+7NVpqfft8rP1LWQyh1MfiZ9AailpjbO3gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f+VB2gwl; arc=pass smtp.client-ip=94.100.133.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate164-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=LH+QGYOc/zlk9kynHB57i4Jfr2TpVc6CuOpzeWP/q+M=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828618;
 b=o1kqeI0qo88h4Miq0HGN8EU5FeSNFcBCMn5LII7OpZ5i0dTpiYW/54A1ofkMm4y2UTY5K41R
 /GToDNAXlwIXcQzyfa4YwMpTVbA20MTnNbvidT8HyRrKILsKWmobiALOB77lEhlsVBpkG4QBAPA
 fx1AwEyAmd+TdmcvfJNHpPrFghYBH1UdAwJaOX6rRvUZPIDO9R2pJZkP63ML6OeQ2yiC9NPlrmj
 UFIIZCw3L3JH4t0nUryRVGwPaJ43sOXJ0teRuFEY5X6S/1jXmSN7ajos4LlLwys/6A0unThbOg5
 pI5Vabm8jrV8nqTcvFi+G9ONo2uia5KMaAcrrrw9LbOpw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828618;
 b=AeGUaXesCFCORE4pyTIPJ3eedsrK5noJWGnKU1QjSKZwlu4b3ajXLVtLCZDye4MPshxcZAD+
 xqZc9yU7IG7sOLCKUawAcPP8pSGj+a93kXXDSJOtqMpwfhKHAYZmGAXNEElO3Zdsg6ce/ykAcJX
 32QUwcqDxL4lUZsJckj6IZMb5LgsDgTUNtPhE9sWLggL/1R98uq8tg1I18xJp5nEQpIaI04my0I
 aRAlYOEXQnuHdknAZFA/ac3DBQcIIiVWZ7aaD0q5RsCLyliwXmNgKafq6IImS5tHS4QiAL8aSYn
 XqIVxGufEArNyg/iBh2Xb+4fZRtZrMttiKqKajUg77v4g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay164-hz1.antispameurope.com;
 Thu, 30 Oct 2025 13:50:18 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 35CF1220D35;
	Thu, 30 Oct 2025 13:49:59 +0100 (CET)
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
Subject: [PATCH 07/19] arm64: dts: imx95-tqma9596sa: move sai config to SOM
Date: Thu, 30 Oct 2025 13:49:14 +0100
Message-ID: <20251030124936.1408152-8-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay164-hz1.antispameurope.com with 4cy3qC6KJsz3xpSY
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:9ebcda3407cd901d1ba1b6606188f8b0
X-cloud-security:scantime:2.896
DKIM-Signature: a=rsa-sha256;
 bh=LH+QGYOc/zlk9kynHB57i4Jfr2TpVc6CuOpzeWP/q+M=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828617; v=1;
 b=f+VB2gwlap4e1S6XZ+oT00pynApdUStgm5SHvSJRqf2G2FB5hEPQeyqvAaP+ewgjOqccM54t
 iClv6kCmBmhtETppTOtMTDLJeapW9bSwFRL9bpPCnic2PAWDqfcOQoG++oDaajw2IUzR45EXsuo
 bYubZ385CNLBjkAL43ZFfNar+nc+mIvHR9TWLPYd6uyTUxBzGXQdzQAxR5frN/Fi04ey2cYj8j5
 PGu3tTl7LjQWOkBZ0edTooIk7upifOOpMQ/H7ETBL0t4we7bl0f9ho5UbiEAwVwdAFdY7WV2X2X
 FOq4QSXgteRCHmiE43rclZuItZCbsz157iuYVkXC27cfQ==

The muxing and other features are mostly determined by SOM, so add it
at this level.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx95-tqma9596sa-mb-smarc-2.dts | 30 -----------------
 .../boot/dts/freescale/imx95-tqma9596sa.dtsi  | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 02bbaaf298930..5c94d8cf28c4c 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -254,39 +254,9 @@ &reg_sdvmmc {
 };
 
 &sai3 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
-			  <&scmi_clk IMX95_CLK_SAI3>;
-	assigned-clock-parents = <0>, <0>, <0>, <0>,
-				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
-	assigned-clock-rates = <3932160000>,
-			       <3612672000>, <393216000>,
-			       <361267200>, <12288000>;
-	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
 
-&sai5 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai5>;
-	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
-			  <&scmi_clk IMX95_CLK_SAI5>;
-	assigned-clock-parents = <0>, <0>, <0>, <0>,
-				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
-	assigned-clock-rates = <3932160000>,
-			       <3612672000>, <393216000>,
-			       <361267200>, <12288000>;
-};
-
 /* X4 */
 &usb2 {
 	srp-disable;
diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 166439e251c53..e7edeec712dcb 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -391,6 +391,39 @@ ethphy3: ethernet-phy@3 {
 	};
 };
 
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+};
+
+&sai5 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai5>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI5>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+};
+
 &scmi_bbm {
 	linux,code = <KEY_POWER>;
 };
-- 
2.43.0


