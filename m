Return-Path: <linux-kernel+bounces-848235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BDBCCFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE88424F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543E2F49E0;
	Fri, 10 Oct 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyX41Wqy"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA662F1FEA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100413; cv=none; b=X9hDKuQFlZ6gbjoeoOjzBDig92SkuRFpMMCOpeDFEWYYnCnyc0qY2j8ROSctJ+3BZFJvI2DRxjgNYG/Ie8dSDBSNUvTdPYTZ1Zc1zsqGqBqh1eBK3hUiY9DGMXhOqWorsorffoU9RG4OJXFofktY94B0F31eDJbZE/EEoPXG7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100413; c=relaxed/simple;
	bh=g3mKjgBA5eOmM+lFx4cmUAPX+2oV/GnRecyAQho2Lnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPfpbN7BNna6FXIjLKx+qq3imu6XHyx/53n5pnWGsuy/3D/2X5GBy0bWSVmI4liSfEzylHjpa1rXmDsF0Ye3ZKyM3El2hYNy42g/NzWSOwBv/U430ywycykBNk/WLJGVzboYvIoAHgJ5VZZMN+ddzP89lDfJYHuS8PsvtNoqunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XyX41Wqy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso18887965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760100408; x=1760705208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI91YBUn0ODEJ37uAPOBfrBDVY8tx0luGRG7kO6Mtbk=;
        b=XyX41WqyW6BugaY898VZBmSIZQl4cJakg7dvkTLYDBdufG9ltARL6bwvI4VkI3VwAP
         IAJK+8olzsfwJF61pLKJ88kL/mLFzsjxWxSSWvaYMCr/5qEZ/fqvuO7wzqnh+8SUc1q0
         vDKDbbL5ZeswYGt856bA6J66S/Qu5qEJnhbixUHvjnUXmE7gf/7j/muj5BI4qdE/F67Y
         8iXS5hH7/H2tcDya966bbQ230ilJmqq9+uoLJ7ydVhIC5SqStNJi5iboEkwlcGWQBUjB
         th18Qpm+Q4qKg/SLS26KSeM2fGGCoET0zlwS8SE2z6oQh48kkdun9UGzGDNr3mxbTqmw
         j/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100408; x=1760705208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI91YBUn0ODEJ37uAPOBfrBDVY8tx0luGRG7kO6Mtbk=;
        b=B8wZxV7Pd6KOV+Wet85HfNzCrANE0XILKJwKQogVL3XucZ/x4QfSX+U3KZB7frTDlR
         9FLexlwFh5cwcZ64N81T4Z9wszw+2R2EUOgH+OF+w1MCBItn8J17cM/+RsHjRjiv75wk
         RlH1davqFL/RhWkpR/0yckpzk5Nn7nxJYhadnZZpDYIpupQ+uKFgzl+R8TYYNtkj7hS5
         +3QYUz63wIo7ZBJnDy8MEyL/aU8YlXOBqs+kxzbFZyYuuuP/1Am5bM6UCCc1uDGkZRgb
         efuE8joII7M2rT9nDK5iQopT91aVn5q4/t+JYkNQr+p5KOMsUzeJ9v4AIiTJnhIPEb7/
         nbXg==
X-Gm-Message-State: AOJu0Yzi2EbYWi6dVUlkxj0bDtORi9NpbvScKD6pB90btgC0eENmVED+
	qECqAs7+QFSQ0lme/5SUGQsTWjKM3r7Ve5n8GVbMS4CPgCjZscgzw74+hggelr0fT+8=
X-Gm-Gg: ASbGnculMnoVhT3t/NWz1l1509rkrzeTAB6BUHfTZeFoD/+udGT2Y3xxd6nsBFg/H2T
	0mUBkG/MBWbX1YfNLkjAVDGsbY67K8sI2xncpEnEpIis2OClBImsd+RQRKKLDhDN/v3d0wwTBaI
	Em4IcAbkVXJJQy9Wx20ZPfNwueKioHeG8iUtOLYGGx79J8hIEz9iECrUrA2kjEVvZBFkfj5cpFy
	PNFCrQrEQPtxRdtG/Ogu0lqvqs4HVGZP8rIVoGx760/o9/DEUfTDGczdbKt02nmwBL5qNY1tLui
	dkmLHH7Y1jsRvQzVvZuojQjk7X+b2tYIy/q4h3EI2mYBlsfRFb1CO1mPufBXIIC1uc08/v5mZpf
	bsg1Iy2fDXPXSISilp+g6lXCMAzD1Olfelh4ATEfkJ1ZnQ9qxlsQPo/FYPHfhI8p9cCCdRUJtS6
	ag7sTpMpcQfS7YtftAxjoGeg==
X-Google-Smtp-Source: AGHT+IF4DKpiRzWSCX0rNDuTrRqKdF56LpWr4xVHOhNz6eYaEJ8Bb9XyBCJmGVJ2NHkQ9GmAaWccdA==
X-Received: by 2002:a05:600c:548d:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-46fa9a8f4e3mr83469915e9.6.1760100408062;
        Fri, 10 Oct 2025 05:46:48 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb484d056sm46376895e9.9.2025.10.10.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:46:47 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 10 Oct 2025 12:46:35 +0000
Subject: [PATCH v6 5/6] arm64: defconfig: enable Exynos ACPM clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-acpm-clk-v6-5-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
In-Reply-To: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760100402; l=946;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=g3mKjgBA5eOmM+lFx4cmUAPX+2oV/GnRecyAQho2Lnc=;
 b=NTVzlJxWw7xyeoGeBBqzM/8gvY/1az1ZXvATM9Z29dX7t5LcuktT1BATpk+ooyP6VGq7mm4+T
 lssKF7XBzBZC5cew2mcDdiAvlteaBf9sTDx/nJY7jNJXG2Iu7gwaeJ9
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM clocks driver. Samsung Exynos platforms
implement ACPM to provide support for clock configuration, PMIC
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..646097e94efe7f1a18fb59d5b6dfc6268be91383 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1458,6 +1458,7 @@ CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_SM_VIDEOCC_8450=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
 CONFIG_CLK_RENESAS_VBATTB=m
+CONFIG_EXYNOS_ACPM_CLK=m
 CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_OMAP=m

-- 
2.51.0.740.g6adb054d12-goog


