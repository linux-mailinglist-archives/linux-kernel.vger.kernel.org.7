Return-Path: <linux-kernel+bounces-793065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E78B3CDA5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 588194E2035
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC428505C;
	Sat, 30 Aug 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFUOades"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC219CC02
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573280; cv=none; b=KzGTwv+pEpJLqvuoSwet9Io6ZZbVszvlL9P86jkZQ6EZqvITqPRa7WqM4vi4G9JRD4EGo7NTNLiC25iA+/oJ5UpuLZh1FBTdfgkbTuaMQqJTdFkOtPb2jXf/ktImf2q5Kn4Mcil3454Oi+NTtMQjsqhKaI5WTiSkcbzQ3E5Ljm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573280; c=relaxed/simple;
	bh=jRpxpUf4uEqnnfvpWME5IzFTj6kezYWwWNy6sI9Jnlc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CVTWxmmSFfGm4tFelAq4mPMVMrit1kPW57GFBc7FINP4LHJlMwSBufIiIplpjsAzmAnhnSz6r5gnus/hTlUu5ymLSfkVSqyW2lEYI0m3YRFN7KHyyyDo772f/xEYDw1TfJIGrg0kcNAvQjLiMx6eRWAg5S8SIYjZfCQvZSlJgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFUOades; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afe8493a5b7so49603166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756573276; x=1757178076; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJLZ5CKo5DabaRRE0JZ2IWfxRuXGLF8UirDus01xVko=;
        b=bFUOadesqJvrfT9rN4mCvst4MGEcoRN2vIb9oo8BKXQwODoVkizsnF3zM5WBsDkWvJ
         hCKvqMk+Gt3JaznM1YIRv4zXdgvpDBGwY2NKGpN0N4lG3TTCrWRggO1OE0wGhRy8b0P6
         pB+abtveatuVQcfbZ37TwX9uzdyfFbhF13ZWwTJlLAQHoOmhUOPGKFsv5izkObFu3SMn
         zKvWXB3CK6jxnnI5xsqTpN6Lt9pSGHeP/pQkeL9vXAasqv/BJDyceSaZM4TM3tPROer0
         6lWeoBbGBSPOcf2JKtx1MUie9wIEnJgLuKnfeQSVdzpGGW4HwSKggLpAszVxpjk9iVSK
         FIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756573276; x=1757178076;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJLZ5CKo5DabaRRE0JZ2IWfxRuXGLF8UirDus01xVko=;
        b=a3Ok5FNOGvOou0ub27v+L8jfVJo0j5cl1SyXBNRASlbbUHMSmAIRMDAeO15AVrOCSN
         /lzuu5pc7IfpjMaUpNN05BzQwFt7b+Vzqf2NS51iihSEXiQQup1vJdg47rShOQZ5Qpxq
         bMkdC6BgfMjfFtCbEWYLRwafmVnXh3V+sYRT7PjvvuFF3YWpWwBwp0eZqKXmB/bUezco
         45j3D6duTaDdLuQsYcc6igqX+fO3beOEX0V1bffzdNo3tXEt2K0T8wbHNhBpjuQ31FEy
         9gu7Gxngh3yxouabMUANc2SqMSFah4bj4yeok8NgZuCBED3r0ZJzo/us06JKsZAe/CbV
         CdTg==
X-Forwarded-Encrypted: i=1; AJvYcCVWX3guoSpd4JBkYkKB/neaaCjNIxPrcE3N7espxjB+iKfw9dTyAR9t6Ukx3DBBVg6xhMn6KuTlfuYyL2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZLI9KtdTAenR/JcIC5b2BGTKsiZDsRQzQ/0OU1RV+nBcivt6
	uJueU6ej4S3WLGO7VI1N0unXs546spNSg6/IdzZXWLrdJqKAX4dcGLF831qtPKQI08k=
X-Gm-Gg: ASbGncvjVwoNQ8eOhxeeVUZWQyP98pkn/fN0cD7d4Uc0d/oabjPvmjDpek0skqa7h+B
	86ED7grl9HwVs4kDJVVhcVCWBQ+8o4fszNTvX1wJqx85MYgCUBvS+t0AguDtgMLJgyg991y8+Id
	ddJppXajMoWdpYh2GKgeJoGwEMzGJ+H37YyuxCaS3Ahp03/h9CrOR960S9aDo/V/W9HGSw+8j88
	S451Xt1WLvFBTSyYzLI3rEv3kh3suwlDiHk2YSyjzmnlmj5Pvp42/MBHCwz+BPbNmHUO1m9GxeS
	SF4rgCSpwAhfguqy/nsjM+6KyCdAuNUc28iko+1iZvzw3idm9Nf2UNIfnwnIVplb/xTRYmkmcBg
	EMjb+3MnG37iVIVixlGPd1TuxN9dEfB+fOZGxJETFexLtihxknw==
X-Google-Smtp-Source: AGHT+IGwW7z6ZZeWMRWTPz9Z3XwH2Y3BmJLkP+pAxyiHYWItazh7A81qCVLqms2areFztK92EQUEqg==
X-Received: by 2002:a17:907:3c95:b0:afe:ee31:4b93 with SMTP id a640c23a62f3a-aff0e28a1demr277259966b.0.1756573276279;
        Sat, 30 Aug 2025 10:01:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm309038766b.88.2025.08.30.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:01:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] mtd: rawnand: s3c2410: Drop S3C2410 driver
Date: Sat, 30 Aug 2025 19:01:08 +0200
Message-Id: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQus2gC/x3MQQqAIBBA0avErBuwLJSuEi1MpxqIKZQiCO+et
 HyL/19IFJkSDNULkW5OfEhBU1fgNycrIYdiaFXbK6sVJu3R7+TkOlGcBAzWzL3tjAuNgpKdkRZ
 +/uU45fwBRz7XeWIAAAA=
X-Change-ID: 20250830-s3c-cleanup-nand-d87b5847ad10
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jRpxpUf4uEqnnfvpWME5IzFTj6kezYWwWNy6sI9Jnlc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosy5W+DzfByrBp7P1cypFBMFE0CLR2K5gNj6mx
 kR0wWKWBmKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMuVgAKCRDBN2bmhouD
 1+eVEACVF2Mpcy6HzBCklOTJZflAQhOnWjfatgC59+l3hDngiFdxrTn7vIaugnHzXzVlGfvQf/7
 YoKm5zM7h2AVnRUNma4I+mDGmOFCQBmEpvk3YU9YFUOfkmM+CoWu0/PsKsvyUVqKZytmEuwvple
 5GDHSCkUsQC1Xf1S/KkE/V9wdPBGRXIki5T6JOcJkDksc/dgq6DTHOxnwFV9p9i9Nj1ITA+2hDN
 O3TVyJsWAU3jHlmovAXZr9yNq9ilT+05by7sIJC3OpyAKJfED03j3E3m9kKV+A8ebjLS65C10mW
 W7+HYdMHQCIg1qkDMo4GSzcEEVo3y1DmPzCEuT4fy98aQH8ECV3znQbn1yah9NReptaFDbhCSDm
 nYzLQdCDeg4EZ6+LqUXhw9B/IYiVrxcSrDT3MtOkdwiAYsVPARpdHfbZLi3pahLHeGTG3maIG/d
 za1pf+vxR7Ar5Ik+5jBVDjg1izKKz3mglIBmkf17Np2ZAaQH19UuBSL58Tu2kfzTAaCT1RuH8aU
 FhRnF9FTDeVRibJHEFnfpbWP5DHd+Aymtfai6eFstznmLlqUnn/f/fr2uE/zMXUueJCOoUGoEQc
 8SLDl8E8GNekwLgKnVG/rmCBRbx4b5XbSyZVPQ9Zam7oAx1M7Xcd0wrdBrN3+YsxkrTDRm+tuRb
 kBY0supEFn1RWxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Drop S3C2410 NAND driver because its only two users were:
1. S3C2410 SoC: removed from kernel,
2. S3C64xx SoC: does not reference this driver.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      mtd: rawnand: s3c2410: Drop S3C2410 support
      dt-bindings: mtd samsung-s3c2410: Drop S3C2410 support
      mtd: rawnand: s3c2410: Drop driver (no actual S3C64xx user)
      ARM: s3c6400_defconfig: Drop MTD_NAND_S3C2410

 .../devicetree/bindings/mtd/samsung-s3c2410.txt    |   56 -
 arch/arm/configs/s3c6400_defconfig                 |    1 -
 drivers/mtd/nand/raw/Kconfig                       |   26 -
 drivers/mtd/nand/raw/Makefile                      |    1 -
 drivers/mtd/nand/raw/s3c2410.c                     | 1230 --------------------
 include/linux/platform_data/mtd-nand-s3c2410.h     |   70 --
 6 files changed, 1384 deletions(-)
---
base-commit: 4e9ae4ca11b35e6a3e9a1175201d8c55406d9301
change-id: 20250830-s3c-cleanup-nand-d87b5847ad10

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


