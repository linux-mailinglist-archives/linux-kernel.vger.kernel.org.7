Return-Path: <linux-kernel+bounces-819833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB7B7ED5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 334DD4E272D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8A29BDBC;
	Wed, 17 Sep 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="D1tyqq7v"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7829B77C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071478; cv=none; b=EAvv/FB8ry5PYWn680yD1nGMPv+T5JDM+qlxw9+QNrOTL+vY9jS8XgeloMudKcpdS3s89tPOpJSAgUuwXCt6OGl9UxhGa/dXulky5+5l8h4MZ9mcHaSUFJNluHGBYLcTqFUwfxPKshQpSaLJa85vk49TULIgZI0lVFbg7Ax2PM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071478; c=relaxed/simple;
	bh=/XO+myhfZ6i4ovv5vDveiJ6wMPrRyxKCj9sPd36s1bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNtmxvp60VZ0IB+GS13Ei/26druAjw22ymnXXbelfZ+onvEi/BXn6C/Z4aNEY+33SP1N+cUGDIwfg7vpk74sDy1QRH7daqXAak22wORoaZj6vC0AptB2799hNoe8WlIWdw60Adbg8zMdZp5mcwQ9tE0DmZW4TtPDkkK/6m0ofR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=D1tyqq7v; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1758071475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeuvMcItduu09jxdrT1ov7aTrATj6QXoxlSqysC7Kb4=;
	b=D1tyqq7v7wZQSm29DlNTzDnJwOZe+0WDClhXJMZdriEQW0mUbv0oJdCKQ0w8E42axCBoMJ
	bSt55Ruc8HENEy+OLtbKoMe/24ZGSfAduUkFTLGP5O6kCoZBXS2WiWaSgrLduecVMyc5nf
	lW3l3Mo+r7igxOILleeXTW1YWzB0iJujHzQpNLyEFaZarrMg0B7Ksfq+3TtoL1BThnNuu2
	ady7y5y11YvVhNLubUkzioOctgbhRKua+l9mtpFAS4bnVhQpBI3/8qE4FS4pA++OayuOU8
	DJBunpp1MyB2TI7NI5oY21GZgfRstZVwB42x/Z1Ez+JKqxGtDQLwgKACIzbTuw==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Tue, 16 Sep 2025 18:09:57 -0700
Subject: [PATCH v2 11/13] arm64: dts: qcom: sdm845-lg-common: Add
 bootloader-compatible board and MSM IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-judyln-dts-v2-11-5e16e60263af@postmarketos.org>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
In-Reply-To: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Christopher Brown <crispybrown@gmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758071415; l=1653;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=/XO+myhfZ6i4ovv5vDveiJ6wMPrRyxKCj9sPd36s1bs=;
 b=rskm/K2d3o5Rq7CdpVsZvZ5DJl9A60hsqhhLJBcxPt/Nrjg2EJyRd+m67AzU+nXoEx68gkFCI
 7wEGeOv4FppBweV4Ny8zrVGHS2LV60v/jVHx45gs/3qZT7IRlkD/EnV
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

The original bootloader (fastboot) requires board and MSM IDs in order
to boot the kernel, so these have been added. When re-using the same
files to chainload U-Boot, these compatibles are also needed to ensure
proper booting.

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 1baec758c7d881026bf6001a0a305687d7a14b40..a513cd931b3a984443183ee4e8df7b0e45732630 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2022, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
@@ -29,6 +30,7 @@
 
 / {
 	chassis-type = "handset";
+	qcom,msm-id = <QCOM_ID_SDM845 0x20001>;
 
 	aliases {
 		serial0 = &uart9;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index 8c1692f86e6ceea7b718361965e78f95d39373bb..beb1372dc6c17f5f06c2044412ee1c8165858cd1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -12,6 +12,7 @@
 / {
 	model = "LG G7 ThinQ";
 	compatible = "lg,judyln", "qcom,sdm845";
+	qcom,board-id = <0x020C0008 0>;
 
 	chosen {
 		framebuffer@9d400000 {

-- 
2.51.0


