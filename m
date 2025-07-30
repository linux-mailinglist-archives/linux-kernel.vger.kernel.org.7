Return-Path: <linux-kernel+bounces-751272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F2B16724
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4AE5A7BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA796218AC1;
	Wed, 30 Jul 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv3hkDvR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62637201034
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905186; cv=none; b=HlqHsdVjWS0/OD0Nkz7cROsS3Zcqwxn9okpRNZ+700kpQqM4uApPiiTP9ZEXnW1cok9fc0bkEjAnUDq2zJfbR3etwn4qcxQ4qfHdsLNlmGqd5vx8G0A20+4Ai9ubGysYGm+B9IbDevRyTh3FK8DqnHhUNqs4rGJNgKbVOy4aSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905186; c=relaxed/simple;
	bh=7T9IvGmnAZ+njhExWBgbmnGfV74VG31YPxFr5ceIVAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jumgrvPdGZeajvReyEBUXByDNJrbE5F/yc+Kom6wt1FoRaIvsvUThq7vmXthHFATGKrdiuYwkBDxAmJPeAqAl5kywLuQuPdQK23masH3LQPiGT0FRfsxbEGraNBX65597OKI1dxnWtT/pXjWmdBVarwvR+XvGS5IFeHflGKyJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lv3hkDvR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso124641f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905183; x=1754509983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJueEuqTtjiM6Dim8VP7OcBzmxZWJQ/hM96x+rO92Gw=;
        b=lv3hkDvRRdmOjpMI8VQx7zg0TOGxExWvKkc+nBcUIoFvPPIlJY8dorj4mpuviCtNNo
         HCY1+sG3qVrqSkX4WLNyGJqJnm4myIktaPVRUVqAkMBSn/pfhXGqacBco6v4S+xIKUDg
         evOFIRiBay2nX5NjtnWqpSA+LDkP4PRIyRu6S2DAtpIWRIxn8/ZUKndAPbgOsGVwVw3w
         36zfr+vyM+H4cGdiL8BChODtjROXIEholcpqBXpr7pWpCsar4izp87/crGSLW6oHOh+d
         igvB/OCr+beTerRSDulZTujvLCDucDM49hD+RzDqQjpcUbIoB3iS22CxbxcJmClGIzZA
         ytIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905183; x=1754509983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJueEuqTtjiM6Dim8VP7OcBzmxZWJQ/hM96x+rO92Gw=;
        b=Nu3kDCgACuO3NDnCfZMi2qpRCh/szEOW0nYUhbG+o6ZQETeivhnrncJm1JUHmPyEEd
         7bAMAMqsKDz1g1x8UPPswSqk2QM/iIK6cO+llAD+1/aMrZWku/C8wwCMW7ZbXLV/h3yk
         U2AM2m9aO/QYSNk1TqUzYiXAEJebiS2/XFChAdi9EJfLw/opkCV3MrqamkK6XCt226oF
         O7BRLebV9Zdzo6LN2Vr7k41dYzIxLAKTOXj2eag0VUQg3JhlC1LE9MdJ/wvsT6+2raN8
         jeM9tyJe4lBjhn+pmb1VD2EugIStcdsPsjitHF4v//P0OhUBftifzg29sxMFHtVq+yKS
         Jq0g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8IT3/HwVYJKs0Y7ynna9ycHmE/sHD1sloClf56m7/KHZPwME6G0y48rzMmSDGuC/bS+pDgW7wcCzOqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkPQJ0nO5uk8sWo0SEOEfCLA8U/NinUlkgMsnE7/csmfQZNaL
	m5+ISn8XkJZFrsFJtAL0DYROXjwon4B7FZxj3aBLGx3veCIsxkXPDhJsxH/qlseK5MQ=
X-Gm-Gg: ASbGnctakn4C3H78l/vKRWC2GnO8wtBKA6Pa+e5zbVSqFji0IDwy3DjeuTV7vrlIBNU
	haV0R50nBJRdyvzMviX8UHcGRtRVI8FfhLqZuvjwiVcuQnc2YBB/CsBSqLOx01nbG1681uv6IoU
	fReGpiIiLZBK4UXUGbbpRONfbPoJRQIsrRlu3ZtMj4thLl5Hi71jc6H9OpHT1UHAVd27Or0lxXH
	p/oKY/6099TP3SVX/WMJi8Ac4wrNkwvg9mqmH3AtbIEu1egcmcFeMmvfAMCkQM4lkNFVB8ARolY
	WfbHrJ1kVCmUI7ICJiMNxQPI5Yaey6Z8S/cX7Ddq3w5/CWYMiNcAfG0NuS15L3HeiXBCQzWr+z4
	Gnb3YL6YEdZKwstbM8LGQ0mKzOGQ9l1eAdBlFzb71Fr+NMa5f
X-Google-Smtp-Source: AGHT+IF7rvI/lJ/fkpm1P7rRxksLVW4UNZm0omkhDcU4fWbM+p01RshTyd0V7avWFg7SQdZZGsyTzw==
X-Received: by 2002:a05:6000:401e:b0:3b7:9173:6948 with SMTP id ffacd0b85a97d-3b794ffa8admr3769630f8f.49.1753905182660;
        Wed, 30 Jul 2025 12:53:02 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:02 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH 1/8] arm64: dts: s32g2: Add the STM description
Date: Wed, 30 Jul 2025 21:50:14 +0200
Message-ID: <20250730195022.449894-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730195022.449894-1-daniel.lezcano@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 has a STM module containing 8 timers. Each timer has a
dedicated interrupt and share the same clock.

Add the timers STM0->STM6 description for the s32g2 SoC. The STM7 is
not added because it is slightly different and needs an extra property
which will be added later when supported by the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 63 ++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index ea1456d361a3..3e775d030e37 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -503,5 +503,68 @@ gic: interrupt-controller@50800000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 		};
+
+		stm0: timer@4011c000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x4011c000 0x3000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm1: timer@40120000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40120000 0x3000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm2: timer@40124000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40124000 0x3000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm3: timer@40128000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40128000 0x3000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm4: timer@4021c000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x4021c000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm5: timer@40220000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40220000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm6: timer@40224000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40224000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.43.0


