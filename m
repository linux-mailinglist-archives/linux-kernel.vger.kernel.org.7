Return-Path: <linux-kernel+bounces-752230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436BB172C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B31567538
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81B2D5A16;
	Thu, 31 Jul 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJknp74r"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC32D3EFA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970529; cv=none; b=Wg5vDG1D/WZI74vadDcIiQJY1+G1ss3f8Rs+0ZBJeFOyQWtalyuhl0WCKvtIjx3bz+NilYErxulFXBY1x32/Dv96bZt4IhDSwZYEYw9h4X59yNrGFmC92EM2U6YSI3eRTdTx2Ro+2v+/ieDkTCYj2yIj7viFrOetKPkeWpxugVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970529; c=relaxed/simple;
	bh=b/zd24rk+o9OlSLaMVLq9Pw8EaD6LUwOrTp1/I6fhs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyfFbQFHDiTrZMP6zk6YbQ1wNS9WUgtWA61NTv16Zx3QxV6xogZAhLYDCdK4x6i/LUeUTzWwRAdJHFmdvO6VLzEmRafVtyI3KHr737qXMhebHQXVDcWYTOoiB0Da1NhUYfjgHMAngMrql6i1Hd6V8qEKrA87KfZjvcj99dDPfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJknp74r; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45619d70c72so15755155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970525; x=1754575325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z64nEAaTCVKG57zoeUfRDIzBYeQhTygoaGUdQv/8uC4=;
        b=uJknp74rs/X1QihoWCiZnwMJDkH8pC44ehKDi4oP3WbIky72QVPdibeydMMxWOdheh
         wWctli8nGgzqR2XSnn7hz+S9wkv5PBlBtNU7IKxYQ3gqG03znn/xRGMkZ54qPlZ6/qeh
         i9d6Ts57iTObidoMEvHFZFRKGSy74ACtklUWRf/+MOdsXHlXZx9Ju/iU+1lRaKdi2bjl
         VNnarGLhj4BKYD6VUrlPDZZ+suAa8t/K9fKDSnWMuLRqFAqcdADVYinljzl59BT/sFq7
         /W5j93Pu+saeGUGKBWz0kWhr4T5qJSPCNIbYYBLTFovj5yWuF/THixtu2PBAM3ZAqPxv
         a9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970525; x=1754575325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z64nEAaTCVKG57zoeUfRDIzBYeQhTygoaGUdQv/8uC4=;
        b=Sy1JkY/FD3FgFa0DSGd2ipau3tRjM3rYGU7dbV8IXOK4Gw440LDMXLMXFFb8dEUWfy
         rnaydxSpKjFSUCYlogNhTHBzW4TaLzykwvj7RLi3EDic9DalF8ibUgibWqAzsnDkzQkb
         f0TFDouDy74uLXGt7oLKJsOHFDdKP2yVnMlrk/9agRAiJz20jY5oI/l2QwCgePLF+A4/
         o/sMx7Axyu2BKVwdbyOQTZL9y4mz1KOiSAiDoEVWa3CXPCIMOHFBe5XgVG5kTd98hFt4
         J3dlx7OY8pAelhxcvK0LTwGbNjHZFDAfdjFB1l76KhEGDGVJv32kC4QMSUlq4FT9joyP
         +hJw==
X-Forwarded-Encrypted: i=1; AJvYcCVbJScK4MWihL7/+pbZVObKaOpF1EHfN9/HLvF8D3mNMkvVIcUj5xSlXl1t0WRYwQZrUKBk2pczz7a/j0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibGsiKbKHF9cIdZOzcnakMg85laPs23vEN5JpjhvO78xoeDii
	vKv9K0jrOAfAwbl8JhoYwxd2wUZ39TFY6h/fqiyxkCRBzGfdrtMrEr2QmvvCZBrSnNA=
X-Gm-Gg: ASbGncubvJ/loKN7pRx7SMs9cENLydi6Aswz7pGfLhTsZeqtWaKhts9pzB6TCoiw212
	XYDuNTlmhQ62dje9FKLZE4K3WfqVyxbbpCYvE+9BItOork2NrLWmWgqB4lbs8zW3FGH5S8guP3c
	Gjz4R0Q4bF5PzHjHtMU48Y8APEXdW2KjiVl9vmDcjE9vhn/Lb4L8gt79hLbGoi2oIYhK/SoU0/g
	K0xezY/5fiEtkbIgDiCCWhUXhgQzEM2mCuWfZAW0eGk2ha/oVLruYHwfEavYsbSuha2LaTaARbJ
	ievLbLc0hNnQOvfX/C3BhehBp5JTrxrnvGFm0Td3mMe5+Lim/SWwFAiTMw144HzJ7b8cgKplV4/
	4vHkRIrAGPbm092EdRyF9dz3lAmONVHrQrm+Qx39kIw7+o73w
X-Google-Smtp-Source: AGHT+IG0Fg0obv6QNkBb8H8gLrRktxs7boJ84AHt095fewSVZFjevx0sKm5v6FUBwWIQGMfsDR/Uww==
X-Received: by 2002:a5d:64ec:0:b0:3b7:8cf0:4b2a with SMTP id ffacd0b85a97d-3b79d4e3623mr1743875f8f.16.1753970524846;
        Thu, 31 Jul 2025 07:02:04 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:02:04 -0700 (PDT)
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
Subject: [PATCH v2 7/8] arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes
Date: Thu, 31 Jul 2025 16:01:40 +0200
Message-ID: <20250731140146.62960-8-daniel.lezcano@linaro.org>
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
the s32g3 has 12 watchdogs. The number of watchdogs is designed to
allow dedicating one watchdog per Cortex-M7/A53 present on the SoC.

Add the SWT nodes in the device tree.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index c2c986f03986..0ceb0807537a 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -374,6 +374,38 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		swt0: watchdog@40100000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40100000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt1: watchdog@40104000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40104000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt2: watchdog@40108000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40108000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt3: watchdog@4010c000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x4010c000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		stm0: timer@4011c000 {
 			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
 			reg = <0x4011c000 0x3000>;
@@ -507,6 +539,38 @@ i2c2: i2c@401ec000 {
 			status = "disabled";
 		};
 
+		swt4: watchdog@40200000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40200000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt5: watchdog@40204000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40204000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt6: watchdog@40208000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40208000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt7: watchdog@4020C000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x4020C000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		stm4: timer@4021c000 {
 			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
 			reg = <0x4021c000 0x3000>;
@@ -623,6 +687,38 @@ usdhc0: mmc@402f0000 {
 			status = "disabled";
 		};
 
+		swt8: watchdog@40500000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <40500000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt9: watchdog@40504000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40504000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt10: watchdog@40508000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x40508000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		swt11: watchdog@4050c000 {
+			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
+			reg = <0x4050c000 0x1000>;
+			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		stm8: timer@40520000 {
 			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
 			reg = <0x40520000 0x3000>;
-- 
2.43.0


