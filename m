Return-Path: <linux-kernel+bounces-811755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C4B52D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0531CA0760F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484832EB5C9;
	Thu, 11 Sep 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXOB0Zoj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6222126D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583811; cv=none; b=DdHEgfZbS4Zlt2uVhRWSC2obRICXnDhBnJJL/jF4/hKFtnnD/fICnYg++IsdTMy3sMG8RgUuLPP/ySasrt8yjLbvf9ieJvmqF97/97Lkhf5nvB5J4MK92SMbE0o2G+y9eBE22E1ofeOD+MHsiyPxSWJ1uNrbDKt3ihsLAF/QPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583811; c=relaxed/simple;
	bh=LQehtAx2kmaY57h5u012j/ttcRk/Yy2y8c0kuDacy/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfGQeHWTLybHD1wsiSYFbVviGRFGrzwsOYuHggdA+OsaFiPzX7f8NUvI610bkLV9whBXorPDotHeRHdLjor72JAgAZ1HnzOEM10otaVqwGGSJZ9XVXtK002AMwoFt2M9pD/RVHaHAaNJUmyH3zWUvezJpEN81/xZFmK2DSfce4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXOB0Zoj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cea1388486so21615f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583808; x=1758188608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlYrA2HvnrAW5ag27Ypg8qPNoGajHDP94gxoPy/A6E=;
        b=cXOB0ZojmqUw30QW4No26lk8/jA9q+r+E90cCj7IYs49jMK+Pu7K38t9DNpfDhUtOD
         XIO0k4OpW0xIxlSoZ3Iakjyh2Xtfgsa4Faa2wOja5vZTgO/P0FCx8oCzBWtD1Fm5asgm
         tbhMuV1ok/uq2kGUM4Haf2qCSsL1jaTYssJg9QwIQrQu5Tawr8vdoYd2TKYkQdjeFMOT
         FvTdRcOz3Ue49No26BFtlxYtKFJpmR5WFQQ8YOAMAahKDdYP689Hz56dEuI3AyAkdX5Y
         Y35F6SWd4QxK6xk5/KQksCwIvCjO2WNHEEWOty5e54ts0OJ9/7kMxZVRo6i4W0Bd8B7H
         76Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583808; x=1758188608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJlYrA2HvnrAW5ag27Ypg8qPNoGajHDP94gxoPy/A6E=;
        b=ljlTRFprcPr1CKasbnY1+mWDb5QsO0wLLPDQLUOhe+VINU0ttMrOhgtTH/AkL305D1
         AhFyUNHyAubq8tYs9KjvedA5CFVae1HIN2suUavimA/p7DXOiqnTzs0GklYJ5K3+Dcd2
         2yRfgI0qihcnyvi0RtK1SPCjkqM+Ihf1Qdb7gvcDkQSJFuibzv/77vcRgBBdprnoR3wP
         97TYDbTUS5Obu4E/2DwI5Bv8eqwHQaIonpHhgwCxVKxyJ1W2DrCfhYIFRpHoXoC2KgHl
         46oprcoTNFiSmAlTjBH9xhsfaNuac8MmHi9LPa9I8PCR56/jgG4Do5hSS+OlytixDKJ7
         l8Iw==
X-Gm-Message-State: AOJu0YwG0ypGYhTFycj2xT+r6mAf85PxTHjcJA6pbLchSz4bC5rZy13k
	edXUV2SDNNCB6yM1zRSRTS905kBD4iafcBmtp5d2hggWII4sy1HbYnEUZf3h3pGRRMw=
X-Gm-Gg: ASbGncuMAd4xgM2W+qAKM4/Wd5q7gIsGuLKCXn8yOwg4Jj4s1d+bm8r7u8/EgepqPs0
	IOCuByZcR27BmLw4maoocAQ4Gjm4IZIP/4BwXeDeWAVNVajNChSSBWxnWM7B55sUoLZ436lmXyd
	wVbLDYkbagnpWOZNB/XhPN8Xj7a5xxiLu3UlRzISOaX+xla9Em8L1dbtbQjk1Y6YTjWlzQmLO0N
	/yyU3ZzZ8uMukbVrsS304RoW1rGw6eSJ987kUYYPH4bT7ELw3iq9JiYjIZqGxxmj1YcyuGfyVwI
	JMAfW0fi7jssRoTZ+v5Umn5rsLXczfdzNFM1ljNFuP9RJ2KU0Z54y0V3+z7QRRDs56fM90yrmgH
	y4HTefHeJatZCCrj7h/QuR8OK64Qrsj+HxDNQvFOGTqB/cDVMfOOPTFp4hK2c
X-Google-Smtp-Source: AGHT+IEvVJCpB1MRFgEyQoHhDJU3qcuvnYQYpEAAmmKNlgqJfObCwFZIxiKKPOjmlp65QpOlOzuVxw==
X-Received: by 2002:a05:6000:b88:b0:3e7:5f26:f1d4 with SMTP id ffacd0b85a97d-3e75f26f5a4mr763480f8f.4.1757583808018;
        Thu, 11 Sep 2025 02:43:28 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:12 +0200
Subject: [PATCH v2 01/13] memory: tegra124-emc: Simplify return of
 emc_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-memory-tegra-cleanup-v2-1-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LQehtAx2kmaY57h5u012j/ttcRk/Yy2y8c0kuDacy/Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpmyBpG/amnIUnmiIQAQJ6yjT1bf6cHeegd+F
 MVQof7FXTSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZsgAKCRDBN2bmhouD
 150lD/9bg+z24kDozvRzCdyxq7TeVnHoBKzlv01ObNT7OaKniUoT4DnrpBmddv0Tjs7vf9HZF7p
 f2t//1VsXSVzVEZ/1Dsfe1ug/9/fZSWI4qq88yqxDIfN3hOqj+vLQFSfs1lMJqFL1lmQOzglY8Z
 UmDobTyKBwP5JZJKPblbeLzJ5RKm+n9a3drhgNJUo2Pc/JI02K6eUubyNDp24Bz5JeOA79LAVfy
 A1IZcrlSoc/ZBIV3cwNpaeHp9MRY4qCW3If7RXU4niLN5vZNYX4GJoFfhLHPxy2I9RKMPvdMhg/
 dPUJkHQttAStUYwAXCm139BgJQ73QGhe7PBTUkEfFxK1TpK5IK3rIpO+j5UgPbZ5iK6lxnw8GMU
 +Y5tVnrlZ9D1nAkwVmdvDvEvk47YUP0bQcFHXW6T//iJdUKyty3g860stoA9RnSEML6a2nhhg2e
 /m2H139QbqjsIEspk2yFbTg3mKQp/zC3DqqDtziYzYv5SLb0qg1oQFeap+DZaYdcIWtlBZ2XWmJ
 63gp3A6+UFtXqxXhPDxpedQgXZu1528pYo05FO0Jah/iqHOgrkUvMZwrNxRFtlA3YyPmS1GjLE8
 /QnC9lYaPY/47onxbmti5SfeWOAE+CzRm7Hs9ljoiZyXaVyfe0uTGizcb1kmTg24Rb14ladzqXQ
 Ncfe9OlXrdraCfg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

emc_init() returns always success, so just drop return valye to simplify
it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra124-emc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 03f1daa2d132a81d28705ec7c62d640d7d25a894..9aad02901613f1b2ed855c11bcd76fef153034af 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -896,7 +896,7 @@ static void emc_read_current_timing(struct tegra_emc *emc,
 	timing->emc_mode_reset = 0;
 }
 
-static int emc_init(struct tegra_emc *emc)
+static void emc_init(struct tegra_emc *emc)
 {
 	emc->dram_type = readl(emc->regs + EMC_FBIO_CFG5);
 
@@ -913,8 +913,6 @@ static int emc_init(struct tegra_emc *emc)
 	emc->dram_num = tegra_mc_get_emem_device_count(emc->mc);
 
 	emc_read_current_timing(emc, &emc->last_timing);
-
-	return 0;
 }
 
 static int load_one_timing_from_dt(struct tegra_emc *emc,
@@ -1472,11 +1470,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 			      ram_code);
 	}
 
-	err = emc_init(emc);
-	if (err) {
-		dev_err(&pdev->dev, "EMC initialization failed: %d\n", err);
-		return err;
-	}
+	emc_init(emc);
 
 	platform_set_drvdata(pdev, emc);
 

-- 
2.48.1


