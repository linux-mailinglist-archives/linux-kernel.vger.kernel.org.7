Return-Path: <linux-kernel+bounces-880212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E748C25200
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690FD4F69E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1832346FCC;
	Fri, 31 Oct 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrhUviks"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423E306D47
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915333; cv=none; b=J5/ji5YpZXqLV2x0Ys4niA0QbBQS9akdjAE1Nx7zeV524jv/DlnSj8KFyUV2jQziGYj0Mxl7yzzd2Zec95nPyJLt/9x8x+YLqAc5exWTSsiM/WWA0GJg/S4nLHoFWfOYqcbQnPPTLjH1yTsZe0HLPMYQ3zAzvagjFWVb59HzsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915333; c=relaxed/simple;
	bh=maxNummCODk3xOKN9REfqVWBI6syLE7tsnIUSjVMlfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDgvhzv5xSMeBBnzMcF0t3YWT5KHWCwn6MrLDstLua0PrzjaIblfC2xMqjM82O1VPn/qLu75ZUIeZESFi/7zr2JqmHL2ebZNe0AhLUmVYyQ8+jJUYmTs8e/JCDTRkmCZmRno+PfwCzuQwIqp4fqfIAiEhw3x2SpbHX7bEtwOE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrhUviks; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710683a644so19546495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915330; x=1762520130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur2nzdK93Gujnnrr7/bhg1o+Yu3Nd/Uvn3Pjsb5/zzU=;
        b=BrhUviks04ASNyscWvpdQa4fgI7a1O+Zed/X9+Ue8fZrAVB0HTnUC1tco+vpsijy5Q
         5JKHfiBmIWB6QHh9ccihqbC86KDvb/RnRqT8RkBFxROcN6RTLbloUfcr5BFTwKKO0Zic
         DEDSKzUjcZxJDv8mOo0dhWijx9YVVeEdOVMp3qb7R+zYyvuDXt5Kd2Yl9c1NDqt0z6hH
         JKMaQF9DcQRS5P5hkqC5peHJLQnx6WVLm/IMnkqK8A7Bdxk8meU3eHu3mExX81wmiCnm
         FNsmpnb2bIEblzXQnZbzyDcyN2qhvLqu5oMkrwrVBmxvuLn/pABKo521vxR/s7Th1+Ee
         Er0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915330; x=1762520130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur2nzdK93Gujnnrr7/bhg1o+Yu3Nd/Uvn3Pjsb5/zzU=;
        b=kIqIUQneBuPySgflk97TCtkLN0KnLuFPovirPA0fOzYvbQSUfwtpMcunHof7Idstz8
         kdzRXQ+kzxKhOsv+KxQJeJY85ai2QCUoShHkWc6VR+HAjhly7hJOF10H/9ECPo71K6cu
         +yfQhfaQ2DVhLWP7c8/CAay3rul0zMb0d9sORcUNF0PDXTV0ZD+Y+uU+blHxgrhE2v8V
         1aJuTz4rakWbffAeJ1es3LYU/lMPo4J8HO1j4lfXcGCWfFMKekcfgUUdYrK0kRIymi6v
         xGqGi8DvXDK77ykp8A8+RR82UEf0tBiqEZ3hRO2wWdtnb88pjkynKre5wlFT1BHTpKOB
         c0WA==
X-Forwarded-Encrypted: i=1; AJvYcCXL8X7M6wrPGAw9aQtqg2Ci9d6V3Vs4z+L65aLmXdrYJeroSOMzXLBEg7+qRL2c6NhDiHtknANwHF2rmIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybB10E3qdqrqRLEBJMeB4UEeyNsgpd/xvXJik8FYK/mSdkfHuw
	1lQj38SZEAghd+AWPb9OzoOY4ZNeJcU3HYzlXfiYVI1yI2zK9SUQSZvT
X-Gm-Gg: ASbGncvvkwS28iQUMFVK3DBUCFut6xoBvmAQHyuYR/U5JTCPtSY9fx/GEqkpvGPSK+9
	4L5NbPDJNb2pR327TXX8sYnVWfk74YTxJladvgwaJGaVvveePi2PrljKdlb7GMBJQHD5Xnafy4M
	EhTTS0vIYUo5npFa+0AlNEZGOqTSGbhxJgIZjKudAwf5Q0cCzO2ApjeZVS8lfEWb6G+83xk532D
	dz4/gODjZ7vsyPnKGW++fcXgYjHQds5JIoWZhUd6gIaLNIwZWN+5FMX0jBpOu0YN+Gigs0OUhcl
	DPH1RQecHjwOzGi7qnQBl3TNiDFvze8B8P3eQ0oMeH0jZsElIZFkjK5nKOomFsjdGZYCca8lLBa
	O4T++i51voRqdQfzrMdoDrvQh7HZHrtq+xE+znJGp5UTl19F/HWEQhptAVR5++rbMu+zCk/wJUR
	K/6lPSDfnNLAy7567xkLoLCp6+fo3/d7RZ7NLtYNydjIJZ5dzN0I0XdQb0cokeAL1yqCsbYdtdu
	C90Rdq2aTo2SOZ4
X-Google-Smtp-Source: AGHT+IHKkMjFYDq3sA/7iAVV6Ds+dv03BvTAXq+xvomUp5eBrJogf0XF/TD11Cyme54hAMfPd6Wl0w==
X-Received: by 2002:a05:600c:c4a5:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-4773010641fmr38615415e9.13.1761915329775;
        Fri, 31 Oct 2025 05:55:29 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcadsm99111f8f.5.2025.10.31.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:55:29 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8qm-apalis: add pwm used by the backlight
Date: Fri, 31 Oct 2025 13:55:07 +0100
Message-ID: <20251031125510.433175-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Add pwm node used by the backlight output pin BKL1_PWM and
reference it from the pwm-backlight node.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi       | 5 ++++-
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 5 ++++-
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 5 ++++-
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi       | 7 +++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 311d4950793c..06790255a764 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -109,7 +109,10 @@ &pciea {
 	status = "okay";
 };
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	status = "okay";
+};
 
 /* Apalis DAP1 */
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index 3d8731504ce1..7022de46b8bf 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -196,7 +196,10 @@ &pciea {
 	status = "okay";
 };
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	status = "okay";
+};
 
 /* Apalis DAP1 */
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 106e802a68ba..12732ed7f811 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -245,7 +245,10 @@ &pciea {
 	status = "okay";
 };
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	status = "okay";
+};
 
 /* Apalis DAP1 */
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 86d018f470c1..66261c0286d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -18,7 +18,7 @@ backlight: backlight {
 		brightness-levels = <0 45 63 88 119 158 203 255>;
 		default-brightness-level = <4>;
 		enable-gpios = <&lsio_gpio1 4 GPIO_ACTIVE_HIGH>; /* Apalis BKL1_ON */
-		/* TODO: hook-up to Apalis BKL1_PWM */
+		pwms = <&pwm_lvds1 0 6666667 PWM_POLARITY_INVERTED>;
 		status = "disabled";
 	};
 
@@ -799,7 +799,10 @@ &phyx2_lpcg {
 		 <&hsio_refa_clk>, <&hsio_per_clk>;
 };
 
-/* TODO: Apalis BKL1_PWM */
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_bkl>;
+};
 
 /* Apalis DAP1 */
 &sai1 {
-- 
2.42.0


