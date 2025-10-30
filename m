Return-Path: <linux-kernel+bounces-878247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A6AC2018E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0275C346B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E233570B7;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="n2F1lHC+"
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62483343D67
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828669; cv=pass; b=XPC8c103IDHH395s4g8R5mufw/NdpUthZ3Eyit9UwXTkGASOi7B/9HWskwkZt2fCeTLTBehzGJXC+RVDKwgs7Fug9JrQ0Gp45wEEr7ARXgPk1vyxhS/9TmuNPX4OXob2JsxzpNZpa7sY2dr6Yv35VVGoRvVMdYzVYOPgA9WBZuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828669; c=relaxed/simple;
	bh=RXYjUkTJGEzey6bj9duMrj1tLyzMQrd7xG/D9di9Oss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1vSI2KW0h/fT+VAO0gJStip6Vwdl9vbST3hiZzER58y0MovpX4Xz9+DJhDy5RwwthLrThHkOw1Nnrfy0uIIta8hr+5Y8dvzeA3XkYSHIKNq6vBaxNPGyVYm+oRrsh4aJcAEEpGXGFAq8WxYiObb0ZQnKKFkvpdD57ha8dBXYlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=n2F1lHC+; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=fa0W+DLjU6OOWbYOutYrRj99tl16LW0xzYOEJzrNODs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828616;
 b=Ih2l+zuk12CYBbargzytkO0FWJNGkBwkPkRJngVY/3tM3CZpjYYzksog/9MfEhSi91xVgZ+p
 /l7kDRIqdz5m6zvxAVFm6it5efgCfSkpdJ43SfDZyFmHjrsCVaOZ1BxCQJMOwz5jAq3KdWw5LX5
 uSLAySoZRs8X+gIdKNLVf3wxE2NXHsxbdRqmu6r3MqoEVF8HZsPhuyzMbPh52AuF8OvTV5aO59l
 /iVilFhCHXyoIzDZGa+ePqx9QiJ3+gPRz1IDg0h1QBQlnpAVuzhYJJyignqtRvK4rS7ieERxdnI
 8P4Nyz0J/1FA0MTPWXapRnMsYd6WHStZDOAziMWga/Kxw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828616;
 b=X1YdAbvNiwTZjrI7Bth+iIZITlBJKMZYgcmj/G4Ysb4SxFYl55+voEskXC1ha5r+dPR5jZxa
 Pq3NZ3O3Jgm+6HCYprg8wudVnNGUqI0cxmMC3rb5GhxFWtxovbMEuko8ItA8R0prnVrUpSgeMjd
 c2Lzeby+LL7MgMR/ypORAl43Fq8URjt743zTSrYRrazBr9l2h3Mw3CfKVnnEV47C8BUo975pGYI
 HOoLIA25dgwE/HfYzlJSGc6IKCn4kT6oUzfes9R5KQ3izWhGGCg0qQF6ZC0SzzIyhqalCynBLa0
 VN9CrdIM5WiWiUFM4jc5fGxYnXYFUFqkGJYst1cbn+Oew==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Thu, 30 Oct 2025 13:50:16 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 00EF9220D32;
	Thu, 30 Oct 2025 13:49:54 +0100 (CET)
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
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 04/19] arm64: dts: imx95-tqma9596sa: move flexcan pinctrl to SOM
Date: Thu, 30 Oct 2025 13:49:11 +0100
Message-ID: <20251030124936.1408152-5-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4cy3q7583Vz4Mb31
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:690fe049c6c3fd8ba19a2c0a294a5505
X-cloud-security:scantime:2.329
DKIM-Signature: a=rsa-sha256;
 bh=fa0W+DLjU6OOWbYOutYrRj99tl16LW0xzYOEJzrNODs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828615; v=1;
 b=n2F1lHC+l3FJ+8ml4qw4JVgp/K9QStY3hlqGs6llmrwSq41jQwnZfVmC5ybmr0tSFSoqODhP
 /XqviWogQPG3q+jiF5tipN497EkPeCY1UmiUJ/qvqQktTENAL8cF2gMrjLDbgUFczwFS8UBgZEl
 Fl9xaU8g3q+nYiEmcmw2I5CLmaOEF/wSgewVpjqeZGxuwq5BiWVWJPQr8WPdcZVNFE9pHVxJE5j
 ll2FcVmuICgdTT4mIahmz5UKb0q/cPlLklBGzVU8bE5p59o5Qk5uFD00+qIVowoxXYa0DrKQ4nt
 P5fgVrkXImc/QNo7MqBSHm8vGOg2HxQBa1GJFCAy/QaTQ==

The muxing for flexcan is determined by SOM, so add it at this level.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts |  4 ----
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi    | 10 ++++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 5b6b2bb80b288..e3c7554b7f709 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -172,15 +172,11 @@ pcie2-clk-en-hog {
 };
 
 &flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
 	xceiver-supply = <&reg_3v3>;
 	status = "okay";
 };
 
 &flexcan3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan3>;
 	xceiver-supply = <&reg_3v3>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 52355a65a62da..759a09a912be1 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -106,6 +106,16 @@ &netc_timer {
 	status = "okay";
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+};
+
 &flexspi1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_flexspi1>;
-- 
2.43.0


