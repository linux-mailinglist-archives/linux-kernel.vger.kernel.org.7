Return-Path: <linux-kernel+bounces-864815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8EBFB9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB1C3BBD69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8533508D;
	Wed, 22 Oct 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WujvrG1h"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371F331A7C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131983; cv=none; b=FDRd4x26KLJEzFkERR/Z8pEjC9vZ9uBAgUJitZjJb8ooBsn4hnQqjYo1Wjxrog7juMWfgQNBdcGUUfaRkN6drV8xmIBEx678iqIy/8yeYUKWMsZIBs5gT1Lb1M3O2vQ3Kr8Or4YvhZUDPUN8eHuKqkXGIMRKDLhd4Yf/jAt3paY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131983; c=relaxed/simple;
	bh=1mrG/yol1/JtpGKNAwtm5R1RG+GDRE/X9WA1wtY9TFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swifioaztxBUydsjQ7Hx/ppL1w/De/NzR/mxoyGe4bRH4rs4iAvr18EvuRdmp4rG6w20V3JOaDL2vbsyWr6Ljmj9NbfSDaVaV15/nn49jQRQkrKu80dOx84EKMBFzLBYuTpCO6njpF7nhweMnCeoTQZtXkerWhzvriyqSG2NvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WujvrG1h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6161224f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131980; x=1761736780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUARhHfbTngybzaWH5xMNt4+HQhGBHN+eDo+AihXMvI=;
        b=WujvrG1hcHgP29j9/I8E0gdlqc8glzhqA2TPs11VcjqGvWX+kOT/PKzGbMnFuDeaxj
         JttUpcEvS0ENS++sDY2JMFmuJHvszXaKMM3e9spRFWxX5weNsGAaUe1hsOMHBzVae26I
         f2AbePcRhjipIolQFFWxeNNO6c27MJ619Jwsgnuh3hWVMsvGJ/4aCsGlOoz2ytN+wB3K
         Kqg2sUZ/dofOxgA8Va+XlV7qPGlWu9oZ1QhsH5tbPGyWcwFk85aM5zJul1fMXtlYrnTQ
         uXgo1FXQ4vrjco7rU0epox4E8i2GTxucMjrvNCtOzS/cwYdoTAnBwzjCZ2py8me6kmeF
         GZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131980; x=1761736780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUARhHfbTngybzaWH5xMNt4+HQhGBHN+eDo+AihXMvI=;
        b=VzzhxvQhtPwjCTSUHXaswUnLlgPnudBroKluD66xQSdpxNp5oSvrM/StdZ3jj54pPy
         HwEsRolU6+1PoQwK712lTBOdIjHOJXnChQ4fFWFcu5pwi5d6rIB9k0LOFavu9q8Z78rP
         0M28lmGjkikjCRxHS2o6CN8r5rH1Oi4FarT/ANIRS0tvq+Ff/xV86QWj/h/UMToUharY
         ZnC0yCKcFa6ATpLLXFbhPDr4n0hgpZYNUYUh9vzezVC+5bLxJURZoZJfWXGOc2CUS8bW
         H50QM+O4Yqgvy4jmbcWrGti6JFn8qQm+kh70mImvFzwjVIyfjgleBV+6Fz/9GyaQKtVK
         DPAA==
X-Forwarded-Encrypted: i=1; AJvYcCUckqLS630vCII8UbAFYV4QkWAuhZe+sxFZOaHGB36mCd/geJHxxs+1AgjmLzGyM+ZslHwNkGx+YQXOTns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbR8/K2JrV+rNbvzqq81ds/z1yRhdHKBWflhhfoHNeY/Wouvn5
	Ipq98mi9XM/0j89agLeSGp70iw1Tn3Gn7BscYhEOBi9iGaIPj1mcBZ6srG8AFwXZ1cQ=
X-Gm-Gg: ASbGncucbGY9U/WSuJTIttn/jJV31UPCkVsPKH30ZXCooqzuA0o6V4jgBWtyXPRkNC0
	TQxuGlGeMJ+XpjBq291D4+Tji5YbxCb0++WoVoOFj7Tf3qa7ipM+qItx8fvUbXirIfxAMG8pS4l
	fQwkRyS989mSSb9VEulbx/6Qg99YsRWWYAOpPtdvuczbvHfB/Ds8E2UN5HYFnhKqw9CocCwBeyX
	ngcsHoqoEm6cVzEEqLF/6mjrbH19LpMD6tLyVR92gUtq8qQC2ty5cE70ZvNPm5yDaWv/0Jb0I76
	iLuiKspONXv9U7IzBurzLKIv7JNd8Q4EdxB+XzMDXf7kLVAMIYL4XWHdeOUrtC5o6r51pu/b7mA
	XqSsw4SYU6dlVY2863maegVllIdZTVVJnrQPhTuf6ljxY6LYuFIoTVrHtUYH9qD0kzu5JG+R+Fb
	FrP49Jx4w6NoZvEakEcvccA3Sh8mJMKvkn/Y2eGC4WATX/IvYIeD6ng81Qs5FCRTM=
X-Google-Smtp-Source: AGHT+IGVU7PNSg91ufp9cPjVd4Gpkg96hHzSv4SIyKY7C0GpIrtxcWnGzFIXHyAzs+v1iGiF52UTjw==
X-Received: by 2002:a5d:59af:0:b0:427:60d:c4fb with SMTP id ffacd0b85a97d-427060dc744mr14141519f8f.60.1761131980105;
        Wed, 22 Oct 2025 04:19:40 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a78csm24820692f8f.26.2025.10.22.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:19:39 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 22 Oct 2025 11:19:36 +0000
Subject: [PATCH 2/2] arm64: dts: exynos: gs101: add TRNG node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gs101-trng-v1-2-8817e2d7a6fc@linaro.org>
References: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
In-Reply-To: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
To: =?utf-8?q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761131977; l=1126;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=1mrG/yol1/JtpGKNAwtm5R1RG+GDRE/X9WA1wtY9TFw=;
 b=N48x9p6uzGpyNoZtQ8hAMytjHe8+vJa5kkVV3y1m06z+AB9vHk0dNsc9uu/baMA5o2430cy1j
 F397zeVUFBlCxW6+4mUwrPVIDH0nAoJpuD4Xo1txP/TALKLTxBnAyBu
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define the TRNG node. GS101 TRNG works well with the current
Exynos850 TRNG support. Specify the Google specific compatible
in front of the Exynos one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..380f7e70910ab8bcc28690782532fff87ca7e30b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -630,6 +630,15 @@ watchdog_cl1: watchdog@10070000 {
 			status = "disabled";
 		};
 
+		trng: rng@10141400 {
+			compatible = "google,gs101-trng",
+				     "samsung,exynos850-trng";
+			reg = <0x10141400 0x100>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_SSS_I_ACLK>,
+				 <&cmu_misc CLK_GOUT_MISC_SSS_I_PCLK>;
+			clock-names = "secss", "pclk";
+		};
+
 		gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <0>;

-- 
2.51.0.915.g61a8936c21-goog


