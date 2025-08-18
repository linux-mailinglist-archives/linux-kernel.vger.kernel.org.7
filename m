Return-Path: <linux-kernel+bounces-773908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCDB2AC20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2130B176871
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE3246BAA;
	Mon, 18 Aug 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUiF0n1/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0F246BB7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529235; cv=none; b=rYy8RZ+f2rBXlm71+iig52c5tPLnzCDlZzn2eO2ax8J9xauPMOTjA71ID7LRbJDI4X9D1T2rDg0cRB5zV2UXsNE4ISwLyl0G4w+9wYfbge/uA2ixr8LqgKwjMLbQYbBrV/OLUCuUo6Y+xhW3xhFItz2DYEKIozjFNgnjv926K7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529235; c=relaxed/simple;
	bh=Ms2tm8eSPj+yyHVyy0nMlIqaL/8sChwRGDPzw8xrjQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+7kzwNMLUS9V6jQZjpfHbFeREhLTXCLWQlULakRYjZvkxN6T3EeZUec1bzDDqYuQIBE0trUw7rEMYDYYN6UTOplc2VTmdhwx9kxlmdnXn+gtZe+XlV5Y/6PKCreCZhCzt++wWe8FyemjmI2Ls/bQcOjV88jt67q2zeBnq2vquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KUiF0n1/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78d1695so53390766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755529230; x=1756134030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxeHMaFeRoTnXdz6BB5Z9gunYIPP1fHWmLLmZCX7qm4=;
        b=KUiF0n1/SJOwBe45ykgOeyRnvtaleiw+O/CnsCHOGaj2OUPHAp04YGuj5YTC/NPtBb
         3pYA4G2PbQz6uw5EEEinDxDWyIDKIAJA3JjUbToplXQ2R0Wo7DQxGjEW7g7ZWsOYXkep
         civ8hIwlsZDI6MczuVSEwU8OZkCQPQWgjKiQSP+yL8TgjeT9mJTGzo9FmUzVuT11igCI
         5a19Wnw9jvd6Wk/YE/Moid1nU8uBivDHc6BWXq2m7f5M8pRtaO96eaSsd9JTbTITQPGJ
         HywSsdaqLITelasVOzq/RV6Q9amLq8k19RExlsFl5g9B+61b49Kr4axXltemd89hsGbq
         apYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529230; x=1756134030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxeHMaFeRoTnXdz6BB5Z9gunYIPP1fHWmLLmZCX7qm4=;
        b=P6M+gjKKsxMx4LjlsVCZv32EviKiJrM0EIa6m8cQ0ceJGvQOHWmC5WgI0lVUe+rMW2
         4nV/XkuBbvWSU+9x5G4Aqb5TrrlNso54EjK/a6ZHvwyNK/L3jRqvumBkHXQmoDLCGjet
         zC95s/GxfPGXcMeFM7uQyPVvLtmc6c6Jy07i8mIuV/e9B8OjaJ0k+QNVVLn18eGX5xr2
         8V1lvoFuIMhPxbV9yL/dWTPQqwFHGFihd0bNljfkJ6kdAQzW/GtUN2jCqQP4I0a0WKzg
         xoLlBmfHK2uAWJkFXsmngkvJpjUu1teQ597J1CrV8NQXFtzbM+wte61OLznlliiwfcxK
         aCrA==
X-Forwarded-Encrypted: i=1; AJvYcCXDrtQHSkldcGbZiuesBmA4lzDEJkORAoemkeJwgbJsVuZp1UtYx7cIsveRhP1LoO0Vna07wSmFSIrR5Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MDMcYYbUiP85gUXVVMbW9gHE3lhpml+HrywoYRrUuC6kx46U
	35zbHKQ1R/AGAqkhEERjMF6b5e6ZGCB2gpQFKTEe6aZXfOyG5t5WGzky4xnan6hqXfvQlp00Clt
	UBIlP
X-Gm-Gg: ASbGncsB8YMS6DDsdEyivwYbFGz6KxjHh8c2OeU8k/G4HkloIQ//MC9ormNrQclEZOy
	PJcABvVm0tJJbgD6gi4FepMkMRj/dMi/FsX51cYA03f2xKPuj7I/OxB7LqqJlF8rEIdhgfOlsQo
	WyQm2W2yN4Nvtl6C7+RJ0OQf4i4yYm8wUWJWUgEJ8saajpItuwVUfihb4j46Ak5YbX2rXzxVysX
	N5YELi8v3vYwvl4PcHL68K990/vEn/8KctlXMiAqb47KSMRb4H/NagokE0bMaxRvLsLzMGCrFfK
	ldFFAIPJ8qO/kh/WA/rRWy3dRgeHijfj2+5sXE8SMT42E7yTSZgNn3KFZgDRAgJAzSNy72N8/Uj
	aBOmjSdj6N5CfBqKcBQb+f4Wte8c4+mTyUxEIvPHOrKru
X-Google-Smtp-Source: AGHT+IHwC1nONOxe4B1Apce8RAMU+taw2uF1ulOiUiKYst5+SrxfAMVJDZG84JEqu3yM0sNCvGdUbA==
X-Received: by 2002:a17:907:1c12:b0:ae3:c5b3:37fa with SMTP id a640c23a62f3a-afcdbe7ae89mr546376466b.1.1755529230161;
        Mon, 18 Aug 2025 08:00:30 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53c46sm819358266b.18.2025.08.18.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:00:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Leon Luo <leonl@leopardimaging.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] media: i2c: imx: Add note to prevent buggy code re-use
Date: Mon, 18 Aug 2025 17:00:26 +0200
Message-ID: <20250818150025.247209-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Ms2tm8eSPj+yyHVyy0nMlIqaL/8sChwRGDPzw8xrjQI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoo0AJ4YKBmDS36w6tjNwLC5Ycrt6V1uEODHWVx
 07yX0JI9A2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKNACQAKCRDBN2bmhouD
 16iGD/9aIu0JQfW1DzczENn0SO/onxhzMQTa401Lqze7xtFdkWZ/r+DzzuXDRoiDgvALEoFLYGX
 61FE/mUpefnL0v1Ddt19RYEIWJGX2E/Ic0P4Brx+HNCHSHc7gytCHXQci86Djw6Y5Ma3tPfEWSe
 JBhvdOKeFpemn+YS3K8n64xIs09fC3NuKoVwkjwQVDY0sMeAOr7JQ9mpZI6N+XT0BACwq4j1xt3
 PzNWkjuxw05oBuMCFMSt/ijsKcOlxhoNMaXvZ4wChMCYdfADBv/KPeGl5uAe0iIk58VuLqkSiA1
 XfnA7QT9tg/FgtbImKWXXjwCXdQJS+bCaxO/pxCy/kt4pHcvwc2IzXlYz9E8osE04FBhDWmSpbW
 t7ChtycbI3SDkQcA/PG9cyRRQWJ68rxhyHfN1lfBqnkjG1dYkIGbCLWT001Tkso86zCWpOdmIc6
 meX4FLG5HRcgDphRFFcRacusjwC1laf/PH1nXru5exGR20pDDxDb43MEho9ePUYA6UlmJuyxTYX
 pTAnso1fSpRrxK8lmZMaqdYIXjLT1wchGCQKXebDQ9FNMSEYaF5oFBh4h9IiWRt6dDBIoYYR6Hh
 b8AOdpKuv5vDjt+Tf1NyVLaiMBDpYthGA6UeuTVrHyA1b1mAfYIO4LaFMcqzkyYZn6S1dw8JGve f60YyFQIPx3B0FA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Multiple Sony IMX sensor drivers have mixed up logical and line level
for XCLR signal.  They call it a reset signal (it indeed behaves like
that), but drivers assert the reset to operate which is clearly
incorrect and relies on incorrect DTS.

People in discussions copy existing poor code and claim they can repeat
same mistake, so add a note to prevent that.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix language typo
---
 drivers/media/i2c/imx219.c | 4 ++++
 drivers/media/i2c/imx274.c | 2 ++
 drivers/media/i2c/imx334.c | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 3b4f68543342..2dcea9517cd6 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1034,6 +1034,10 @@ static int imx219_power_on(struct device *dev)
 		goto reg_off;
 	}
 
+	/*
+	 * Note: Misinterpretation of reset assertion - do not re-use this code.
+	 * XCLR pin is using incorrect (for reset signal) logical level.
+	 */
 	gpiod_set_value_cansleep(imx219->reset_gpio, 1);
 	usleep_range(IMX219_XCLR_MIN_DELAY_US,
 		     IMX219_XCLR_MIN_DELAY_US + IMX219_XCLR_DELAY_RANGE_US);
diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index a2b824986027..d86d08c29174 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -826,6 +826,8 @@ static int imx274_start_stream(struct stimx274 *priv)
  * if rst = 0, keep it in reset;
  * if rst = 1, bring it out of reset.
  *
+ * Note: Misinterpretation of reset assertion - do not re-use this code.
+ * XCLR pin is using incorrect (for reset signal) logical level.
  */
 static void imx274_reset(struct stimx274 *priv, int rst)
 {
diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 846b9928d4e8..53158babf3ea 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -1070,6 +1070,10 @@ static int imx334_power_on(struct device *dev)
 	struct imx334 *imx334 = to_imx334(sd);
 	int ret;
 
+	/*
+	 * Note: Misinterpretation of reset assertion - do not re-use this code.
+	 * XCLR pin is using incorrect (for reset signal) logical level.
+	 */
 	gpiod_set_value_cansleep(imx334->reset_gpio, 1);
 
 	ret = clk_prepare_enable(imx334->inclk);
-- 
2.48.1


