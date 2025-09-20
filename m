Return-Path: <linux-kernel+bounces-825444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05148B8BD06
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4AC1C05949
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C021883E;
	Sat, 20 Sep 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0lqCVxt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7F214A6A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332835; cv=none; b=pBcxPw1vxwUUeErHhpuvzOlLGeWEZ8Px737w7Pw17ka+efNs2rPFyyw9crXCvozFeXNrBsK/HuxHFcoNggYNhBjYnsRuBZHz3u922ccua16R25BKk/Jn0ebT4K33rbI3gvCdU5a51LvY19upi4U0E0JEoFwkD08f6hxQOWLnFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332835; c=relaxed/simple;
	bh=J3OQ/gbZXClh+gnMC9yVomxVT5i16d4sRMT1zK1pgf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkEKmCkat6/bGX+jyAs5xk/yoZZtpuROLOKKW6NGNM70dv8rCd0quzFFgeibxHB2JRGPkTS0i71j62LU/hKlrv3xSZzhGxS5EtFCKuQTJ4nC1072azlKrqdpdqednplhtsT8j4eyodA16j+WBvrWNtx4tsF0HcxSuaB2MoGmWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0lqCVxt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26983b5411aso18943945ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332833; x=1758937633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeUIHWsKLh6gjLn9Z3+FbhnYjwlNLiSz3aZCwDtFUKY=;
        b=R0lqCVxtloWyypEeavKNztwcl+prrAy2NFsIkEV4oWTQtDjJ9y4pCid+szugR6TNjw
         cwu2y90eVqjOkhZqeE0tA5Eojnn1UfsgPNKQ/cd1Vwe5MOQtjBYspD+1BJ07WjXXmPCH
         rRHRTwnjrucG3GbbOOwkA6toVs1DKT4K2B5e7iVg3j9GbeHGdtczTljfdpXwjJcLqocc
         0KEgcSMNyBvljPSPTYIA/ZpCuv7puNxYMKI1kgu/Cr9hm0pdyKJ5g6t6/NZ2GDHh5Xne
         bQX1VbAvo86lBikv//knGSiUsxAiDILFdZiV+amLUSOeUaYLU6vLScLJyVw67Y+OSaAy
         RJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332833; x=1758937633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeUIHWsKLh6gjLn9Z3+FbhnYjwlNLiSz3aZCwDtFUKY=;
        b=uQ151pF4yE4gEkwueEMO3dXpaTWvplJ6cvc4PbdiLHM4ehmbyrZRs+eOAIlvpHg/0k
         pdG+5bwsZ9PYeVLZ++Znmn0GxT/p799W8GXdAt4ByBMpAk79Jzb0D2EaYP0c6aGan5eT
         GaAs+czNb9fokzTuQ8L1h0Drnd6ijWNoVhdAhFHIJwOdQbEJqtI0htwSXu0he5mXyWO7
         KCbe4o1JANeSD/cgC2jLIL5xfb99ZxkiD9xMwxebZy3/z8DHUJ6quhAYZqkXh8EcL8Z8
         2otQq5d7RI1AZ8nN9AZhOalG8vCndFduQ5ivRB8mZUlMiQJyvDdm1r87IEsVe/PpBQ3i
         yv+A==
X-Forwarded-Encrypted: i=1; AJvYcCVUoHM/0gcpzluGSUh4Xj3qmvVQaFTT69ww82whVQBjKP2BHUAI7scOFZp8ii0SDLfQmxgjL9c4vqk19kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sNtgx/P5qrOYD2VHitBq0Ad/jLIn5ZGeWlMk9+L8Mj3vEXFt
	lA1iMQUC9IF50X/wS5bVmuUNbc4fZWuDE1KiCqeBOE7FV+ENwcDMVtI44c12+a/h
X-Gm-Gg: ASbGncv1fBr/qgoWgDdqDqV4IbE8LyvX2t1Vt/hK9gRZbFb/5/2CGwFVke9KJHmIoZL
	Cq+QtIbF+eLLa3gOeMHw0yMXfK0rzlFNe8eBTxL7d1yz8f6LwUeqL79JDZ+mMMDePzvy+UMj7/w
	b47OskwtOkjHQbcyUUjooAr4JcrnnJr/wmqgJhcr8iQQi34q+h1+20js8gC6gJRj6Dp8KDGqVxk
	Zkihu+re+MMQaOLCcccy4AHFdrCGnFPGQa1opYiiBpdXj3IhHS/yIkuPjSDjcNThM401LQLdUhz
	QIpGQjF65fr6Q3t12zGg0B4lY0JEwE0ohCAU5ctz2htFMunqOGoV3CX4eEp4Sl7Az0/NF+8RTd6
	AZlVpEIocKTDkQEP2/aHT
X-Google-Smtp-Source: AGHT+IHAb8q347For76gqV7j8lIEycMW9TAsw2JxhvCS3NbiNhH4DBGbKJw3OQ7FwHz61bSv6avlkA==
X-Received: by 2002:a17:902:ef12:b0:248:a4e2:e6d6 with SMTP id d9443c01a7336-269ba5042eemr66295115ad.39.1758332833618;
        Fri, 19 Sep 2025 18:47:13 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm65709455ad.131.2025.09.19.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:47:13 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: qcom: r0q: enable max77705 PMIC
Date: Sat, 20 Sep 2025 01:46:35 +0000
Message-ID: <20250920014637.38175-4-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014637.38175-1-ghatto404@gmail.com>
References: <20250920014637.38175-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung Galaxy S22 uses max77705 as its charger, fuelgauge and haptic
PMIC, enable the fuelgauge and charger for now.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index 7bf56564dfc6..c1b0b21c0ec5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -14,6 +14,16 @@ / {
 	compatible = "samsung,r0q", "qcom,sm8450";
 	chassis-type = "handset";
 
+	battery: battery {
+		compatible = "simple-battery";
+
+		constant-charge-current-max-microamp = <2150000>;
+		charge-full-design-microamp-hours = <3700000>;
+		over-voltage-threshold-microvolt = <4500000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4350000>;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -186,6 +196,26 @@ vreg_l11c_3p0: ldo11 {
 	};
 };
 
+&i2c5 {
+	status = "okay";
+
+	max77705_charger: charger@69 {
+	    compatible = "maxim,max77705-charger";
+	    reg = <0x69>;
+	    monitored-battery = <&battery>;
+	    interrupt-parent = <&tlmm>;
+	    interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	fuel-gauge@36 {
+		reg = <0x36>;
+		compatible = "maxim,max77705-battery";
+		power-supplies = <&max77705_charger>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &pm8350_gpios {
 	vol_up_n: vol-up-n-state {
 		pins = "gpio6";
@@ -345,3 +375,7 @@ &usb_1_hsphy {
 
 	status = "okay";
 };
+
+&qupv3_id_0 {
+	status = "okay";
+};
-- 
2.51.0


