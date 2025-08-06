Return-Path: <linux-kernel+bounces-757926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D7B1C865
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD811686EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60E291C16;
	Wed,  6 Aug 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2PXialas"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14525290BAB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493028; cv=none; b=ZYb1S1jXLCpgwLP9xq2kR9TchZ4UvNdLdZyaYHGwv7WFEmR0Svzkthk3iPYv+BrmaDiY9bzM3AJUlVwL+zBMyYfB345Fs6OjGQJ5D8rwc8i2dbX34qrlPi5p4seGU/mU3Nmac47iOLtNu+TlMIDaMccsOAeCeo1fFqmxN/DyjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493028; c=relaxed/simple;
	bh=mkMKBwz5BKx3M5ukHVq0U7xYjHmmJcHQfBYE9D9pbLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cmccqmw0He1Qr8dN1AZKnO92hmifnpPQ2YLbO+4lSy12Tjlv/qa8TkU5uzsIKOisJusjbOERol3f0SRGh2Fo/tmsxm6zjmHnR9UsKMTgGpZ9ULIEYmyl4SPky6eABbY47lR8ULZ5W8HQi9TqTK36zDwHI0+yW/yHpNBYhInw4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2PXialas; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af967835d0aso581479166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754493023; x=1755097823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKHJowmVjOKhweg/31XcJuN1dKyemiZUjq/gTTEI0D4=;
        b=2PXialasG8bkbX+e6ZXi6/K+FfbcqiYwOlqmKxEAuXZu8Z4oRyhTOfAg5r3+/qbsRE
         krBoAFDROQG6rgi3n3tHn9I+SsItHpX9iyxw4cDh8s+e690tzdapc2oOM7pXoqXPnVVY
         pGEJdIdFLBO47THcJuGqF/u1ZcwcXVnldhQBavIM7RIdfGhMlm1U99yZeiXpobagr5SM
         zy/5yf7MxU1o4GZ606EfzUCXxxp6Rqtyd7qHqMmNGxpjVDy7SsJ1diUQqmivJtmdsNxr
         D8wsBcJPTxpwFQKLhgaWg0flcMHGASl0EgA5+SjhCgRG5Hbi6fg6G8ItVNivFsy9kc16
         f1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493023; x=1755097823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKHJowmVjOKhweg/31XcJuN1dKyemiZUjq/gTTEI0D4=;
        b=ew4GhLAJJey9HLBtXOS1CEwt/Pi6yqzi6U0dnlWSGjTAlNPQUQcewkJMBE/oivmgOu
         BZShgr0ZaajWdZcbTeeO4sAeRY5C3ujawJYIM7avXqd6SEvpDOXJORl0YEJJUSA1Eryg
         XhABft9rwre+9udhG/wt5q+DqoSZFJWz4RFVWm8lyIQHsyiQsIz937RDtjwiIUQPh1bt
         F0GHPMFguivzOPwIXrQfv2Dm1bbMPEJBP3KmQESFsxlBolPvYVbOVSg2ZF0q35J3gzvl
         O1NzMhEEyK3Y9xygImGtnf93MPDTEX2QPRYzepJ31w5Pdrvrmp95z1RhocLPD1DhEei+
         I5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgjE+wWxiV2I+qyAbyW3XBDw2J3D4PdNvA6S/7vQ3cjPwBrDMHz1TQVpVWjF4TFjTo9AXZSnEso++Z150=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkPOeVsGM7SH9meNu7qpOgMxwLBDp0bvvNVQbt1aVP9nRpupP
	Cs5k4t9J8LYlh3/1t+1zNJFX4Ha60hcehG65HFUktEYMGtzZ8nHdn2X4bVfrNnDG+hh3riIrK/9
	rMjv5
X-Gm-Gg: ASbGncut7iuQSgj4jNy1547+Z0y51nS522r0/Cqk3UMYU5vZtY9Hl/5IMWITY+NQVsq
	IWXJV6WkwP3dCCpHOQp5Wgzv6axGIJ+gzKz1OWHiaT+NS62ehWqOi52TGbr+wUgKImWAAERu4lT
	fIXjbL6J4q7sQxXT57JBbRaSgImCMOr5THPo1T71e254aq8H/B/zxsIgePpyhrFDqXeGlupUISh
	wdPM1gX9ZrmmktwVVxDRdzqOu6ofCDKtITImUZQyqCyhDyXRNwd+Pdm/5rzfUJsbXMkTEiPBlvT
	aaK31JEUQEFnmtx9EIkqn3AmJqjkigoMCzRRTf+bFXaO8UvfEy96DnrkwgXlsVku2b28S4nx+nn
	fjb0zkCHfCgDmqskWu4GOHemYb6lXXv5FpLt3KIsragec9oXtrKiSon9ZT61J7GKtJEANn5rxHk
	HDpp0=
X-Google-Smtp-Source: AGHT+IH8DW2Kp/036um5fo54X/6vueOzgFt3fBIYDww6nDeVymURksuNRfJrnIRDzmfw+vtApSseXg==
X-Received: by 2002:a17:907:3e8f:b0:af9:8c1f:c2b9 with SMTP id a640c23a62f3a-af99005c7fcmr299707266b.8.1754493023342;
        Wed, 06 Aug 2025 08:10:23 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm1120100666b.51.2025.08.06.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:10:23 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Wed, 06 Aug 2025 17:10:10 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add vibrator
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-aw86927-v1-3-23d8a6d0f2b2@fairphone.com>
References: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
In-Reply-To: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754493019; l=1231;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=mkMKBwz5BKx3M5ukHVq0U7xYjHmmJcHQfBYE9D9pbLY=;
 b=9xF1MNdjywzjYsOry9BBTU5wVDy08shUSv+1t+tc7ZOPISwDvFFGeWrjsLPziUTQaGleWWHxj
 eKbNhajwzcvBH3spUvKXYq7qI+fSiQrEEGSljDAwdNNMJPjI2rtiqCV
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the required node for haptic playback (Awinic AW86927).

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 4c6cb4a644e2..9576efdf1e8d 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -866,7 +866,16 @@ ocp96011_sbu_mux: endpoint {
 		};
 	};
 
-	/* AW86927FCR haptics @ 5a */
+	vibrator@5a {
+		compatible = "awinic,aw86927";
+		reg = <0x5a>;
+
+		interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 100 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86927_int_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c2 {
@@ -1415,6 +1424,13 @@ usb_redrive_1v8_en_default: usb-redrive-1v8-en-default-state {
 		bias-disable;
 		output-high;
 	};
+
+	aw86927_int_default: aw86927-int-default-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart5 {

-- 
2.43.0


