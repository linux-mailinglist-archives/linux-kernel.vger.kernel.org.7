Return-Path: <linux-kernel+bounces-834467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6FDBA4C18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D460D7B3176
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFB30CDA6;
	Fri, 26 Sep 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0miWAJG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DC307ACC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906818; cv=none; b=Oz5v7M5ehpmE3AAd81NQoN+IhQqKkdYHTtgffCD7YilChT/5PFocvoQtIuO/FfiHyV+2hewfsymcbwbFkqgSnSMx4AdC/kuhBaFA0spXDkL3l37B7k9ULLKXjtakvrBztebRn06/ZA7UkM0jGRlL9SAKhEiqxpnNhy94ewipxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906818; c=relaxed/simple;
	bh=91ey4D4RscHiUop7uDzAjLKjyDW5NbuR+aCcWKWDgO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+2fy+R9cri7qDMT0wBCS1DzhuXOJpNcBSy9L2lPndhRnmLpdJmb2IIFfIOIWcj7ffpf2EggmqW0AYzlhgTEEZ4uyykkSRrNPRSBKV4MAhDPmgj0eJanRxJtOqABegt/l19uDMIjKlbkPvOUcXxTMuXaGGPiuZhTFN8latO1TQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0miWAJG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634cdb5ed4bso282888a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758906815; x=1759511615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRWrg4uLTX0GBtHqvOnBTTd6fOpgFs97cg5Sl1bCRLc=;
        b=S0miWAJGQ546MOn6P0ofsHkw5D0i56eKwwdFeN+A0CMWxftdJTlThL1XeeOU0K7dm/
         JenUNqNij8KCfCxFHLxmSPrf4t9AFtfjcbgKtaiWoegk0H0To+Ge/tfL8h9ON8LekvfJ
         fP22yHWtIoXxjHAS2SX7Vlo4EqjxRf8dru/LH+VCNLKaYFsT5YyTsXAEMxJhb53NytYd
         E1Hu1yCy06dOyf+Pm2inkbX0kOSJqtqD+P0wCfeTJaqWkmrbs/Dx+S0xQMuAykrKeoP5
         t9fSWmtgbkTvInTcFVuUrYRvkjgdZon35HGDg5Z08g6hczu94+gEGWflW13WobmfvX4b
         YRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758906815; x=1759511615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRWrg4uLTX0GBtHqvOnBTTd6fOpgFs97cg5Sl1bCRLc=;
        b=iV3QzR80PM4duzRFQ7wwRgNQbqG9+QuNkajYVRNz1asnwBWWs55rj8M/Glt+6VwYFz
         ktAZOWiBxIKm75MlzONUE/cZg8RQsKwBHeOnEXvipdXGnw0wSA5NlL3WyAsHOkd8Fftr
         v7UIz0V0nOgpsXM9P3Sr/OEeUaXNc5dxyalM6sSNsKib+3933ShTjz3iUGzlmJObedUi
         MG27bIzfC3s3D3PsmpR7psFQwqk3Tu95ORbUugpVLAvuYedStTwg1i7D2l29S28tknjC
         AQpEAklmxfB7LviwHP84LwLP/9hcIlH8WNuLtp5ID9p5mVdqamPRRZ6jrB1im6bBtLLc
         9usQ==
X-Gm-Message-State: AOJu0YzUCvappGU9qeUP2UGrKQ6b1g0sB1zsUHOHGlz9Et1X/a9PoDZI
	U5A88MrMGSRPiLNHdWdkygu7/kHOH3kd+yfGyCCMggjYmOisv5kNXnN7
X-Gm-Gg: ASbGnctnO8iw7e8lodSI1aUTvhSC2Qk1upH2Xairk3yBaD9djItl5LvsiXRRYITGoEQ
	ykcEYgonlLJSMUch4+d4Zcsj5/sh6Y1wPtFfzmIwNWJETeNitjdoQ96QoY29kjsxP5Kg62bJ18m
	aQG6Sk3UndfltjGnakL4f3jdhjRHx2V6XLLINyvjaRrjkcqISf+WZJgyF/EARZuxSe1mRaZX+Bm
	8Wky5/3fHtHtLIGspnqJ/lVw4/0il9aaIEDWTwwTXHsD7C+/uGHLy/3Bl2ztpdxDNCaFrB5s4OM
	FD+1qhEC4V9jP21/nNVyT7D+cR9ezkemqCw1YW0eCWX28Cva3UkoeOg4Z/MbCK6Soa2Gl9YT5YS
	GsIka1PRnv7hoVk8mbhUN
X-Google-Smtp-Source: AGHT+IF2fQ5BiZMnQgigSk9bQwDFvXDilYuLTRYlFcSL85YTbz8PJY3/svIikRxIAKdIw43rzklQbg==
X-Received: by 2002:a17:907:7296:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-b34bad2854emr1008213766b.40.1758906814999;
        Fri, 26 Sep 2025 10:13:34 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353fa65be9sm397211166b.48.2025.09.26.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:13:34 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 26 Sep 2025 20:13:27 +0300
Subject: [PATCH v5 2/3] arch: arm64: dts: qcom: sdm845-starqltechn: fix
 max77705 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-starqltechn-correct_max77705_nodes-v5-2-c6ab35165534@gmail.com>
References: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
In-Reply-To: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758906810; l=2258;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=91ey4D4RscHiUop7uDzAjLKjyDW5NbuR+aCcWKWDgO4=;
 b=2U/nuqSlPTKe8L1FhhwHJLSB8akD3pymeUuvoK/el6+mN0UWF2b5cjlMxT654CudZIg0YRAMQ
 cY/qtM60JRWABqJk/gokkOi+ZoXlrBZeHkBKtppWOdskxb5LDPZDnP7
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Since max77705 has a register, which indicates interrupt source, it acts
as an interrupt controller.

Direct MAX77705's subdevices to use the IC's internal interrupt
controller, instead of listening to every interrupt fired by the
chip towards the host device.

Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v5:
- group interrupt properties together, including #interrupt-cells

Changes for v2:
- fix commit message to be more clear

Changes for v2:
- fix commit msg header prefix to 'arm64: dts: qcom: sdm845-starqltechn:'
- remove binding header for interrupt numbers
- make interrupt-cells 1, because irq trigger type is not used
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 45c7aa0f602d..215e1491f3e9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -599,11 +599,13 @@ &uart9 {
 &i2c14 {
 	status = "okay";
 
-	pmic@66 {
+	max77705: pmic@66 {
 		compatible = "maxim,max77705";
 		reg = <0x66>;
+		#interrupt-cells = <1>;
 		interrupt-parent = <&pm8998_gpios>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
 		pinctrl-0 = <&pmic_int_default>;
 		pinctrl-names = "default";
 
@@ -644,8 +646,8 @@ max77705_charger: charger@69 {
 		reg = <0x69>;
 		compatible = "maxim,max77705-charger";
 		monitored-battery = <&battery>;
-		interrupt-parent = <&pm8998_gpios>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&max77705>;
+		interrupts = <0>;
 	};
 
 	fuel-gauge@36 {
@@ -653,8 +655,8 @@ fuel-gauge@36 {
 		compatible = "maxim,max77705-battery";
 		power-supplies = <&max77705_charger>;
 		maxim,rsns-microohm = <5000>;
-		interrupt-parent = <&pm8998_gpios>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&max77705>;
+		interrupts = <2>;
 	};
 };
 

-- 
2.39.5


