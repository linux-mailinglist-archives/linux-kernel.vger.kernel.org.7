Return-Path: <linux-kernel+bounces-896747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66232C511E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630314EC024
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFA2F6585;
	Wed, 12 Nov 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IW47H+uc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5F2F5467
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936160; cv=none; b=AyKXY+g0DAenxMf1FOGm60faS6/LnLLmMHXrlKerjHpTBqpxEd3Fu4VBcu1SiBukR0ARAh2gsKCQuFU9PZPVfOYu59pLhE3zB1AnS3Q9++M6EmPvce5regJ+TxtawGDqBt0cstj7EqwUluAjUad6JrDstgPmL13bC48Ve861sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936160; c=relaxed/simple;
	bh=Y9wJNseX6YvW31AdnsD3g0WQa/woWSS4h+36pzpwGoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwrZlpuB5Ha+wVzWMfQ+0gFDukBrdJg43wZCyD6MMyz2NozHKOMBnJ65EOupCGrs/C0VGxpCYlwHEzTZu092DZh47dAGaRBhFWN2Q4/x5rYu52WV+v92nsV+4bq2Xr6iLg9QL7pZF2FTHE29duqgS4ywZpT1anUtseB0z4fyk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IW47H+uc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so5562975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762936157; x=1763540957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OFp+IPnKRa3v3OPLVGWcy+GrbtTT1voW5UO4BoVK5w=;
        b=IW47H+ucpDb3lheQPUYZmLeHQQI27P41LBIURZeI2+YJWkpjPtslCPmUcfV8nfIvON
         /AI1rohhZcIvR81FMrYSHqF+j1FIJ6/dlT8lIzHlT3qtSYiY+cKF6VoI/5p38q99BdR7
         Bc84utXZsaO5LSJMgc+Nmy9sma0bS7qUoz39xTzRtSA4pSZ7wIOM0CNhFxRzCGwXh4ac
         hN26lz+atEDjR50nPf9HEFiZPrZww6Yph2g9PVuQgqRAssJtPVaSIOtdy46IFeYKhsit
         yXu2UFdo5PEnRb/7xiAE1KxJryrkiy7wzazFo4RhB+wLfmCQ4BChIxkaA/0qzMyoS8XF
         bamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936157; x=1763540957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OFp+IPnKRa3v3OPLVGWcy+GrbtTT1voW5UO4BoVK5w=;
        b=PS7q2lHP282LJdTgTSxAVq/nffliHv+5pLpzkgOxDHT5k7YID2g4K0z+lA130KeBUV
         tfQ2Ini6FKbY9n2C0BnkzNwC265PwtPn3M2dLPtCRzzGRJhRncfIDKhwrJV/jX87gkC7
         n1ztMYh+UKxgmWV+AzPu+weXEf8vyB0ZdnJ08QqJ4tkwA5ZXH2RzwiBCIZEhfYWJHvV2
         x4Sfd9mI+FARIx8KcUulwcLsJmTRvoK12DTQVD5hboBjOUr25rROt7fnIw/lEdg1iH2/
         QbUoXC+qJaGyKWkdVxMrfKc2qCD4lBRd9z/Yx894ob2CwPdj9r1b0BlOw41cbbvEaw9Z
         h9uw==
X-Forwarded-Encrypted: i=1; AJvYcCUq3iddlbPJu/4EmvP/wwFk6ANAzHJrMdi97qn+lg8i85iU1Hv7FNrsPpUijRxxYQE9tJy3MDcsXEQpzYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMdmUILiny3z8iKQr3afaQgINT2tHHz4uP/2TqZub/D8tK8WJ
	cxfhrLQeCsyJsZWraUUIwXtUCvLnhE2bTkt+pSp699JmuMOHUBC84lNEawlyJRIxjEI=
X-Gm-Gg: ASbGncukDPG3Qdl7mKYwahLvfVYXqebj0ZCQJedDPuMGaqDSpHNgYTqfvFHsYvR80/R
	QPZMC+NJ4RfpjouIo3qozNk6tgneowoaSiay9qe8f+geKiRfkKAqldAENpqOJVwAkXGx0yHbvck
	qOM/m/CihlHFtwaFe1Y4KLYTbMxiG9x78P6OXPxgfNSE+fMszEVCkROvX4lY6I/JkS5hCCu6tay
	TTqmGTJOpMumBJKTh1CosJop3c42x/lBbVU8qQ3ieavecwneg4QHvWTlFugfxGWXnxbBSrcYm1a
	t5zpY69UBc+CleVL3afWzAFtZWaidoH4LzKb6hDPbxBHCHfVrYc/FT1303gH+Gqnaogf2Oq5osd
	CuzreNWyyif25/NhSPQ6UrdQV5ySS1o0R/YZeE1S+/tynUJBZy6ov7nR6liyrS08z26cepLd32y
	f2q/yhevDFPa+62ao2i3YnNsqVrLssdwCOXmDUx45+l4B0pF+UlUJQ0/+X
X-Google-Smtp-Source: AGHT+IHlpapEj7ymskzF3Fjgqueu2gUV8vx50CAtQ/YTQGVKieu5QIoV5IAB8BvhUU3H0SWPp7ULVA==
X-Received: by 2002:a05:600c:1d0a:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-47787045055mr20227885e9.8.1762936156868;
        Wed, 12 Nov 2025 00:29:16 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm31571428f8f.35.2025.11.12.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:29:16 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:29:08 +0000
Subject: [PATCH v2 4/5] arm64: defconfig: enable Samsung Exynos OTP
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gs101-otp-v2-4-bff2eb020c95@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936153; l=1050;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Y9wJNseX6YvW31AdnsD3g0WQa/woWSS4h+36pzpwGoo=;
 b=Z6fGWT6SoRfFw0zQdHsVBlO/Qbu1DkGHl4MU1QSzryZwNo9dsZbeiZgmfpnXbo2SEuMtYgsTG
 gs+W0LRj75xBnRKyv7cv0ou/7oI7kGsxjbMNCoT1WLvkuXJfdVlP/85
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the exynos-otp nvmem driver. The driver reads the product and
chip IDs from the OTP register space and register the SoC info to the
SoC interface.

The driver can be extended to empower the controller become nvmem
provider. The fuse block stores various system information (TMU, ASV,
etc.) which can be accessed by client drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 646097e94efe7f1a18fb59d5b6dfc6268be91383..6433e3c0f88b892ce6f2ee190f866a6ab4889771 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1682,6 +1682,7 @@ CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_MESON_DDR_PMU=m
 CONFIG_NVMEM_LAYOUT_SL28_VPD=m
+CONFIG_NVMEM_EXYNOS_OTP=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_IMX_OCOTP_ELE=m
 CONFIG_NVMEM_IMX_OCOTP_SCU=y

-- 
2.51.2.1041.gc1ab5b90ca-goog


