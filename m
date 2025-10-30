Return-Path: <linux-kernel+bounces-878370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F175C206A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4810C4EF148
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5E2676F4;
	Thu, 30 Oct 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XfYaGQuP"
Received: from mx-relay73-hz1.antispameurope.com (mx-relay73-hz1.antispameurope.com [94.100.132.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8A226CF0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832505; cv=pass; b=F0zLaIGeLl05DtYiIG4pxJaP8mMMbwHFxrZof/4OCR3+6M5yiOyGC/xK4SYKSmxjA6kC/uuW0Ms7cc/XtrLS9LOmxisy2uOVNvvvgbGui4jVFgoxnaItCYTQ6fA7VYUMR5N3sfBnUGd5OqsL71OcAP8sqZl6zXjP2FxNIyGvZLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832505; c=relaxed/simple;
	bh=g49/BvHAHefGv2lXoYjQ4KibKwtcnMRmtDWXdeTybdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJMQI82/4YGTd/xiedgj0rdKrVvxvbjHFq06a6JPkugQufN/H4jQHybMtoVqYmAzxMqXehGaue4Iv9jFsdamV3feOBlpGIfH5VexY5+rXmz07dnFKbb7DQvm4YmlWVziFRQwPe9Rh0EBFMzyA+2VmoBJdw5SIybqOFcv/c39xZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XfYaGQuP; arc=pass smtp.client-ip=94.100.132.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate73-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=No66cNLUicbMmk4yWzYnf+xkWOSrPxLslCLwe5XBnm4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832405;
 b=fBs1JEvZFvZeUNGjR+X/HsiHXC64lZJcj+8KfaPnBPzyxnk1QMPG8/uofmVpA4fkkQhCVJae
 5+GcADASy8v0hK//v+uYs2/Ivhtn2JY2lLVvwiIPiPpnqroslBWliBJbRhZR+8fUnIFulQQ0uFJ
 koGTv/zfcTg7rsr3tVWKNlHXJHjaUMnJCVLRpBmpCHiGUud/mUDrZkr/14pkvVagVGGzCtX3gge
 RCEuyd0VKl2+ScbxMHLGj4kHTpyxTwFDtjcwi203Q77uQcDBQVX0XDr+K+qMIQ1dYlRlAeWY/UB
 HhXAn52X1pU/KwqHhCHIozyQeqSNs5rUqYoNzaoKcbC7Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832405;
 b=RViFwIWUzC6XkS8kK2jwDS2iivCaMA4JIW+pabnltDtpF/W+QgsktuZa0Vd8DQt5GxCz/Aym
 cEAGkCwFW+e41cg5eadVpQj5dM4x5c7y6uP4E31TWpSXN0wvFK400qCIOM3fc9R3VomqX69ROfX
 Dief0oCaORbpNBa86mlpQ7ZRJ2Ouf7Idx1oSe/TAQFKaw4yAbbkKLjuYwDSYZF/9X0rxjjlO+zb
 Xcf4TXlCJEwDvEiw7iAZ//3lrObDcH6wKPaz6qAdDtdQXiBorVlOA1V6RTU0g5IaV0vVYyJSIMb
 YMAdL7wIF6QyLCxK+TnBQkgw5damotV+3fo2cfiBqzPdg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay73-hz1.antispameurope.com;
 Thu, 30 Oct 2025 14:53:25 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 8E76A5A04B4;
	Thu, 30 Oct 2025 14:53:11 +0100 (CET)
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
Subject: [PATCH 12/19] arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for usdhci
Date: Thu, 30 Oct 2025 14:52:54 +0100
Message-ID: <20251030135306.1421154-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay73-hz1.antispameurope.com with 4cy5D82Hd3z14Sd1
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4ada1ca96b2637bf43c610ce9808313e
X-cloud-security:scantime:1.655
DKIM-Signature: a=rsa-sha256;
 bh=No66cNLUicbMmk4yWzYnf+xkWOSrPxLslCLwe5XBnm4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832404; v=1;
 b=XfYaGQuPl9+BlC+4W39Hnenbli8s6vl525+sGjkFwBw5rszGBzicsTEIpYCnnnhikDHTRsvb
 TO2k58vLss+sDNCFdlv7SiS+Rzk9x3IykKJadHL40YySU7T/2tOJ5AUiQr3WyvstEQojaEStQ71
 GyzbDxLcA6Zkz4eF3grGg4+TF4EOLXFIvWc60pB/Bw25TTKWomcYEeHoYlIucm1xaT330o1PgSi
 psIAe526URkn08zxEP1HFZbdp6DKkjqwhTIiKg4t81JHBn3Amlw1r0gDrsyo+zBAZHQXuQQXxxJ
 uQWbJW2d+n7Tan9PyYzMiTj/EHmPr5hGfFk0jZ+PtrW5g==

A sleep pin mux is not useful if it is the same as the normal pin mux.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index a6ab94208028a..cc251505f6280 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -493,11 +493,10 @@ &usb3_phy {
 };
 
 &usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	pinctrl-3 = <&pinctrl_usdhc1>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
2.43.0


