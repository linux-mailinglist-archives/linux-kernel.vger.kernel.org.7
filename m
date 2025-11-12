Return-Path: <linux-kernel+bounces-896746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E415C511CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586E63AFB22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9A2F6186;
	Wed, 12 Nov 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/e9vXeZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFC2F3C32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936159; cv=none; b=KuGn4IiqSgIhLv4413DmYYAIc83HiVeGWP2zJVVxEdzu5fs91co9fkZ25Ocfq9JO2Kr/bQ8G2XyGKZolnHvMiiOOe8Zaunh5jdFZnP3O5tH3MkUqnBbEWU+xaABqW1gmK0IqavWGBsYD1nebyr2EK1ls/EcdeQlAq0+/pcMXidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936159; c=relaxed/simple;
	bh=/pSl/oshIgGZZ5UojmE7NZi7LX3/HS9nWv/b7bm1yIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkY6GNubckO2USQLK5oA2X0DmkFQlFnyjoCmqJ86KJ+FZFALNMYr7bpz1OHqlScxgSrUEBCszJxWv8SWGmnEi5Ts2/65sBHh8xMCWX03lC0vQ2/pDZD9dPeOofmd+/I0cdAi21I8hB5x8Z8Jnt31d6ZFnKYGJmaVFrIeS+OxTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J/e9vXeZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so2808215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762936156; x=1763540956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHjf7jIZnxtsxZp2emdUV+gnCb68DhjnRQYjjOEpq+E=;
        b=J/e9vXeZU694C7QeQSr0T427StWNm174XH9SeeS/noRWZeYwE5kN3r78yfmLfCxvmA
         vFHkZBMl6t+3rTS6OTvkm4TQKGHXCX1nkRfV37QBhsimS/lVgmn2n2zAsROOHq+2keQ8
         XuiqzoCJe63mcDQVeiOpAmqlKlOMCF8oIfuA5Iddm2KbHFjFseHKn1q/sKpPkzeri/3d
         1rlPszF4frNwTsBlkLzn+2KWkyYKvCpUIz0tOJ9ycjWN5Srh2BF3l6GRTNAe8qIYzZnr
         xU/3kyAw5zF+8nd0OfVHR+lNzc8zmdVeJb4xOLyUIjrYOWYntcyLTt9IPUDhwGtfOQ33
         gXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936156; x=1763540956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZHjf7jIZnxtsxZp2emdUV+gnCb68DhjnRQYjjOEpq+E=;
        b=Ekgwd9G7m+3+tWCK2Tl1PkAy317CDCELlX/s7J04LBusC3WudHBLdkvSzYAHC/chTy
         ypjXFxMq1ozPgrpX+3u8nTUzvJpJrrQyd9cKND6VSllETrRwbKkvY2dsi/v1eoFhLe2o
         FCg4kqoX6OSi0OcccWgTlzhRe5JMqqjMLvpS3D1o1QsxluqOSMIj9U+fN48TISsoLRQQ
         av1aPRpFRwCeuHX159+vraLuYyoLf1v6zge8nsICP0d3p2vbTlVSSaYzekz3HbtQDlSq
         /ERw0j9tkWD+/+vLORA+LvjCfLNjwDENH4H5CvyaPn2o/5NUkjge9GYyf4Vvn7ARBKkL
         NduQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq6NVQ6hszdFAHw+1LiiiyoOyPBm1NMJeKqGg5JtkFdUIIz41LXzKxFKfw5tjEBsL98d6GAWG/wkIgoX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtLCBiQ2cg4R0IrVpGwsjcKRWnjgf+stdop919tMtwyHmCPwW
	Jx7TZu30vmGcczotbudjaRY30c3vgszHVcDoaafxYEURiTUvEtL7dZ1i2Ji9ZOiWl20=
X-Gm-Gg: ASbGnct9UAB0qur1vWR0vO5KeUJJM4iPbQbT80o5hPKbsvJiR3Dm1uXOPqsWylMrvL5
	gqDOMNHXJ8QDgJomU9VvHYCKs5SvIJonM+J8n/LukGUePok+owiZiF2clcqbbfQgM/o12wvEYlD
	WV4QC7N3ec2RZz+CTtWPSw6Z2+62c4MCMz6kXMEjsdB0QwUTzEAGFzAdo6voF3ZrjrfFKsLVp7X
	oCyw3xCJ9oR3Kv7E2FHn1L7NlN8eFiJ3mvTm9plyRnV3Vb/SraaIR3c7+uKgNliYUNwmAK8AyN4
	aO0UhmPH+UYEHAd2hPlEPZ4KSX9k2/Dui6PL5oij1UUhsRLn0Od3wEMaFSevNytgDEZ9VTPF9F5
	pp7BS8Ko3VGfMe176cX2cJN4DXRSXQgV7Ic9xYVP74o4VDUsqDw5MQWse3KwQG3V44+Okxmvx3/
	4cmVGCKwRNH3RNO39KHSv1fySoF9AtwFqnGsWRams4AxkjNBGfmNZr3KXcOJ+wqxAfbJ4=
X-Google-Smtp-Source: AGHT+IHMFuV13oHLomlsN36IUFndxfrhBYzdbMd7xr9GK3XGTbsPAlzk7x/twn8UPGjcB0CfYJpACQ==
X-Received: by 2002:a05:600c:c493:b0:475:dd9a:f786 with SMTP id 5b1f17b1804b1-477870be153mr16131355e9.40.1762936156234;
        Wed, 12 Nov 2025 00:29:16 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm31571428f8f.35.2025.11.12.00.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:29:15 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:29:07 +0000
Subject: [PATCH v2 3/5] arm64: dts: exynos: gs101: add OTP node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gs101-otp-v2-3-bff2eb020c95@linaro.org>
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
In-Reply-To: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936153; l=965;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=/pSl/oshIgGZZ5UojmE7NZi7LX3/HS9nWv/b7bm1yIQ=;
 b=R1Z+JLiXPWLMgVafAqh+YxTkJcvlF+ccSnLeqflAeZ3Ttx/LZtnpqjWgaPkjDW7swQcPDVzoX
 +LgNAN/4E3WDOaOJv39p6v/i5tN2Ua4VMj7GcXteu9NW5JKmTxD3K2f
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the OTP controller node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..4be983d4e291b3afe3530fbea0163f70c1a74671 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -571,6 +571,13 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		efuse@10000000 {
+			compatible = "google,gs101-otp";
+			reg = <0x10000000 0xf084>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
+			interrupts = <GIC_SPI 752 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
 		cmu_misc: clock-controller@10010000 {
 			compatible = "google,gs101-cmu-misc";
 			reg = <0x10010000 0x10000>;

-- 
2.51.2.1041.gc1ab5b90ca-goog


