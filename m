Return-Path: <linux-kernel+bounces-752228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E18B172BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE64623E86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A82D46C6;
	Thu, 31 Jul 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7ObG5WP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A72D373A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970527; cv=none; b=miIMcmVQpcNt9q2uwOMzcAW9igDS3bKk1bEvYRLa7jIRsiKMZ9TaVJAzcYBGbqgMA061TNjPQx+c2hLKS+zdTysl3lBa16mRuBd8YRnm3XKDun/+My+w5RjoQeGpgYTaiH+ZnjMdhW9xiwnPCgy36ZXgGeOPfsMIfqDLdiRQ/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970527; c=relaxed/simple;
	bh=yQHSXj9X+9M9Y9py8Z7kopx308qQsUk3NFruZ6iZnh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqBKXpWCZiS/uzpAh+SjpLCw4wGTEeHuG6auPjYbRG5DPO3T00vj2IPD4Gg7VaqQY54efFIDlU6WkKPruBd/BUffnk0N/vv9UttYEFocJa6nVZcc6X9hPagWe+XLM8lZwZZZyU/XcmTHrNcvL4rsMIzSNl1b64I74DzJysEYV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7ObG5WP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so410068f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970522; x=1754575322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLgS03msUmp+vuGwcZngE+sO5Zm7YcN21p+x25WXrLM=;
        b=f7ObG5WPZJNKroot9Ugjyl4i7N4J+WoqBg7XnfSawN+UxAQf+Q1KKa8cdPPEbztozS
         CNoa1L3kAVhDstMD/Nh8riFV/mr6XVUrwVExkDwITktVAhY927aUM01wTF8mDyCQk8NE
         en3g68xBcv3lrISXBiNenAm9VReJ0wVk4Ot0OrBZkK3v3013cM+23IVA3SSd7LknSGFM
         +5A6hVGO4FuDxczY5hsGE7upU6R6BAYSDTK5THQDP3FvBd9mgpQGhvitYJ0fA5ocUzAt
         10jOnSMW46aeBNDS71iDxEsG0hNhJjfpgYVukbte5a0Ye5HjLHbqSf69GtS7W6MQld//
         URyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970523; x=1754575323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLgS03msUmp+vuGwcZngE+sO5Zm7YcN21p+x25WXrLM=;
        b=OreDiZAU64vwGVs9A3RhaYoZrG2wHf6RfcR6oTVN4kN+UAPIFGpmR9TFbyzZFdu5Ek
         LqFageB8RORXhydCmGquiC1DV2E1JLe7P+TAOjrPVXyul6jFnFxOy0eeRXU6ZD5O3O9w
         XAiSkHKbTasFk8pvv5RTXj56e2IDeCSyUcMWZmLnvXx4y72jCJB2y1BgVhtTDNHQJ94r
         Ac1qsayZCw+p+1SGvzzZlnjS4Zh/sgYirNpnuZmOeUexRPqVCGhsvSfeXPZMDs+bbdJo
         80P6pOUwkVPeLTbBpaU5qP1Gh87rrtf4co6Is37gK6/uj5ZQINrnXdTjUL6I493/RXS1
         OSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIKOtH3nXwB8dJ0Eziwr00kq0go/G8ManJnzQ4oHtShiB/lXJJ9glbPgMvu08FD5JXFSSxUos4lXayS5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sl1x0NKN1PPi23FyCZx5S1CppdDkeP4+H+RHrt02eSyRAW0l
	Z/YllXcoePXcnEWIXv8gegF0O+6lc86GCHjbIEh7Pyau7J7dOvgkqhRXGL8zPRCU1/0=
X-Gm-Gg: ASbGncvRsRfNjULbEnSgTEr8JPrjj5SLc66cE+hL2x3QStWSxrq4Bcdq6srk6nuR8XL
	5KyFrN0tzQQMrCu4aElrnWOiAhldCDzKhwyIFcqSIluAx3hYr2R9hsmYtQFobeXrkLFlTKKqg/F
	KxT38iK5WCKLbV2bZ7yC7oEe5ceIGoN3zwdqflNF9YfUzE0sixwC2jFJuo6jaNC6C4o3a5QvmL8
	+BFXbbpYwis+sKlTKElIqtcW043HpjBz6XjHcbh9vCbgxIOSObZypWDIi5vvlCR/os0/GWeeOQp
	hgyCEfRLwezN0O/Hpxq6plfKJzxxgm9kbAjg4SMWaT4db9qkM47Je/9YBjXzLl7mkDq918YIcjC
	TWN37lCOiyCbLAVK1u8Mv9o19ITJ7hOPjw7xtYKKgVS3xUmIm
X-Google-Smtp-Source: AGHT+IHKeZczvelpwGjx/EOADUEZKpoKSKEfhOoz3VFDbeZbEjT91pFxldnpybLu9UgLDOG6DAcA7w==
X-Received: by 2002:a05:6000:401f:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b794fe50b7mr6057814f8f.2.1753970522308;
        Thu, 31 Jul 2025 07:02:02 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:02:01 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) nodes
Date: Thu, 31 Jul 2025 16:01:38 +0200
Message-ID: <20250731140146.62960-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referred in the documentation as the Software Timer Watchdog (SWT),
the s32g2 has 7 watchdogs. The number of watchdogs is designed to
allow dedicating one watchdog per Cortex-M7/A53 present on the SoC.

Add the SWT nodes in the device tree.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 1783edb81350..478899d4dd06 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -317,6 +317,38 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		swt0: watchdog@40100000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40100000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt1: watchdog@40104000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40104000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt2: watchdog@40108000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40108000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt3: watchdog@4010c000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x4010c000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		stm0: timer@4011c000 {
 			compatible = "nxp,s32g2-stm";
 			reg = <0x4011c000 0x3000>;
@@ -445,6 +477,30 @@ i2c2: i2c@401ec000 {
 			status = "disabled";
 		};
 
+		swt4: watchdog@40200000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40200000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt5: watchdog@40204000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40204000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt6: watchdog@40208000 {
+			compatible = "nxp,s32g2-swt";
+			reg = <0x40208000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		stm4: timer@4021c000 {
 			compatible = "nxp,s32g2-stm";
 			reg = <0x4021c000 0x3000>;
-- 
2.43.0


