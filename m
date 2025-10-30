Return-Path: <linux-kernel+bounces-878238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E6C20182
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB484422DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BF354AC6;
	Thu, 30 Oct 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kiK+HynR"
Received: from mx-relay24-hz1.antispameurope.com (mx-relay24-hz1.antispameurope.com [94.100.132.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF733F360
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828666; cv=pass; b=n7vgtdsea175og9opg9q7KgBTG34wMNN5tbGoR5aqJ5KoFcTxMpDEDkeM+rbTFN7W84a9lqUsq2gJBw8rRzv2QzEwx/+uTPF6g9m8ehMffVZaRM6pxyLHrj9K6AIWtUrhQa1L8oYogGK6U0aDgxI+ahWI+am31iNVmdsJaKeqdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828666; c=relaxed/simple;
	bh=WEGW24WPzjWc2KNh4+viKAoZJgq3f6jFWXB1Ds1Y+bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4UPAOSmGkp6a/D7DO1APjvRV2d3EX+JUFgzbj7qczpFj8rOiE9wkFQYeixhNDhJBgAFVG37AzFqhJuGACFnlZY92pU7+qoZnD68/3nqN3ZZFaXnEEwjEYcFAGK8/YUH/jHpt9+lYOH+wvyHNM6dx2EV1dEyCKvlWpUFK4RHxhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kiK+HynR; arc=pass smtp.client-ip=94.100.132.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate24-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=MLLHlgU1kgOKOY9uazP3g/sgaaBJysCOurDX7bu2Hg8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828613;
 b=QdYKwP3q4cb6DNUk2A7ieO4PztaKx5PtYb6IZMsQ01XLVi9QldO+TiYX/tIOiAPqYWNwl+sj
 NrBqjSQDSdcojNjk2pvHoIjemOIePKYFi0sESaQX1aHXvMHn5wsyqsEjRu974b8ZWeo6EHNM2HS
 tqRSrxIA5k59H+/ij9MDNF2u6ETDvOi4r33t2bg5EzszJMl2qB0n4+Y8VISe0wIWGer8eA6AeWq
 Od+E7vJ1/wHZPUCxGCSvjwj3DLDGD4zaiHNDG3nv/LxHEmxRE18Hb7WFphWMY3X5BhpOKEPZbIC
 tW72+aAcPyAStDwfAOkRI1CwXnhIfqTwEgLVqR8PJBKjw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828613;
 b=tXqKejjgEy5Y4uP8aDbgMVFdGmM9MV1MY9LSJiYnY69oITq+XLzTiCuUwk1fcLhX1H4bLdA9
 3j0nFPpFoe5KkZfnv4Iv/xML4gPmX0s9xZK7vP+rg2g1eczI2TC5Esa3OpDe0IW+haeCRbr4g65
 isfhiNzebBBsVKB06EjpRtaRQqd4hWDKX3wOGJzj8/3klqxkP67syyU1/NdQh3dRW/1F1hjrxsz
 OvM15SdmB/zG+9W53Tf/g8l04P7qEbFK3XZzDpvfABVrHepoi0pEaJfj/D9AWniFhPg83fidAo4
 GOqgv9+g8cqbHyLTYSFtsEMIntlhDyAR3GAgTZS3RbA/Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay24-hz1.antispameurope.com;
 Thu, 30 Oct 2025 13:50:13 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 62C05220D34;
	Thu, 30 Oct 2025 13:49:56 +0100 (CET)
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
Subject: [PATCH 05/19] arm64: dts: imx95-tqma9596sa: move lpspi3 pinctrl to SOM
Date: Thu, 30 Oct 2025 13:49:12 +0100
Message-ID: <20251030124936.1408152-6-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay24-hz1.antispameurope.com with 4cy3q90T5vz2fdgJ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:6a48f4ba851c95ecc7e4057f5ee77018
X-cloud-security:scantime:1.826
DKIM-Signature: a=rsa-sha256;
 bh=MLLHlgU1kgOKOY9uazP3g/sgaaBJysCOurDX7bu2Hg8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828613; v=1;
 b=kiK+HynR3IHrrI5qBWrEWQIRNR2lN6xhceWanWFZG2NFenHnWhdiJeerOBbWQ6S5To9fZW+2
 oPZn4Q19X9LU2L12iTwgf+66+NhLmQ36EOjF5vZiMBaP/zbKzWTw6GCzPc2Iv6XrDFztjBAH+kx
 iR+xpyNMTHEV4I1tFYkdkGj9ljdlwEon+U/xOC6EKtDDkPJZbMd4Cjs5hpGeUJpTqUHsYc9Ltgh
 f8pgtxVvyLM6doApOIv9YuLMCFurgld3GymNxWz9wD5lrQJY7hL7Cie1BwNZR61isNhdGfEAj14
 5M2o5+ktR/kWx+q3pFDaErqA443zcyPxAtFL+vfaw26/g==

The muxing is determined by SOM, so add it at this level.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts      | 3 ---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi         | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index e3c7554b7f709..43ed55e57d2a3 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -200,9 +200,6 @@ eeprom2: eeprom@57 {
 };
 
 &lpspi3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi3>;
-	cs-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>, <&gpio2 7 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 759a09a912be1..8da9e368c1f4d 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -317,6 +317,12 @@ &lpi2c6 {
 	status = "okay";
 };
 
+&lpspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi3>;
+	cs-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>, <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 /* SER0 */
 &lpuart1 {
 	pinctrl-names = "default";
-- 
2.43.0


