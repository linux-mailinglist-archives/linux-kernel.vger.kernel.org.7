Return-Path: <linux-kernel+bounces-666023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D4AC71AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 21:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1A4A27EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261D220F39;
	Wed, 28 May 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGXmlB+L"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9621FF5B
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461489; cv=none; b=fdfsbdvEyLYswRUUaMCA6bh98g52YgK6KUkJMWFV9HOG80XY37HQEdRgv1QwZKCJoEWDmfVrH/+ut8IjSwCwqZNiW2QEwc9NLDykE7ZK+dRbJp0jW2G2Zodwj2ijXXBV+NuWNPTbE/YX/GJ0ohwIXjDwfFJnGL1Mpuvz74vpW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461489; c=relaxed/simple;
	bh=guCDaDwTAp4TXvy9+7jlbNrAYwY+fXtO0BITgGPtVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1eXNsV7Osv6xDISHlarQuW3p+22HwsE+Fepd0xQ51lmte7Hdba09VFCIPTh3uXIRIxYW2A3QD8eL2ffeJ0PpJbklIEWPaqF8cgCouZIJ0mkxbmusydrqjcuVdqddiLLqYiAXu4nu3rDhkM19cs+hEyReGDPzHYSwQv0Oiv5A3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGXmlB+L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e6a0c274so24115f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748461485; x=1749066285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wb4t5KvlRTeDQRXTmMQslstrXgIdlyfTjd5qJWgFhow=;
        b=cGXmlB+LUeR+4icJcxUEr+Pf22yDa6cSZhBAHDzTnBAroVisduQjCN6M9sqcLZi5H0
         SS+JWMR6Eg+rrRvVldPGb0R6zMtvf2i2VGZhNCq6fMcFZzyelzGyAWG2rai3aCnsKI4/
         N/Z7gnsllEAI2IGNSxLH2QpgJbf0qsqUt88tGPCxnX+NQVMq2VKMg2qkJwvIVf9vgM1X
         Cgfz138W4dD7eFKUZ1/lzrw+LjzrF5ZgadRZRD+vgefKgchQ4hByrt2MCWO9ozXNSMpW
         UUA9+K7T9BXshoFhts7Rc8rMo6WErTHb9ejBY5O0mwPzOgmxNz7QRUa51yAjZYNQcAG2
         R5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461485; x=1749066285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wb4t5KvlRTeDQRXTmMQslstrXgIdlyfTjd5qJWgFhow=;
        b=fGTbtBGBq65YR4pZPJCcrYLbPQ+Qmw9OrvPFWP9UjJGLiDcC2BQ+BIYjDbE/ep0ABB
         KZw4l5EpL9cne9Jk0K+LEQL4bu4CL+j/PYRNh8q++JntlQH/GOYlQGkn62tdchKbwzpY
         vzaVtrPKqc4N48ssy5iacdaunY4nDaNZtr/+vLSsAOcw5ObOfHc4eBTtP8DWaMw9veBM
         dKGcWWSxLW9mmOtBb1nUtl/v8GTm+v/XpaI70OejMru738pEIR5njUXH0JvvI9eIVF6k
         4NZP5canSSeo4n0o+EMgsbeugb8KWRhS8XD/IcdLqbXKOkiciS0BK8pgE3t7oTLrAjd9
         JUQw==
X-Forwarded-Encrypted: i=1; AJvYcCXwPdxjXaoNzCzm1kvvlp8Onp1vz+UyRH9wNR+SmGOx7q2+eU52mID0r1i/QwCdbdok0mTfK4SC7A2jBkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5L6BQikHIl+hrwitC3sbPJ0n6vOxfMynx9VSSt+bBw3qoE/g
	W64tHVcVGArOOLBR9z75avratXstA580a7UhdtHY+rglfP81EDdhQxaPBQvFtBbBVts=
X-Gm-Gg: ASbGncugCBhQ0hJLpgAjE6BoPmlPBvi2tqD/cxQLXv+Qm1QSiPjW5nXj4FlaLu9QHOu
	Qd/Q6UvSPGH10rZA24+BTzmEs7fQCSMGShGdB1aXRLBhLu6/c8vCradB4LhLXDn/1oJekV8zI+t
	3U0fcTc/w3kyXqE4lLeVyCdc4ntunF2Y4WKgRFq6YJsK4yNHTKUtHRmVyHac26aQUoo734IItyG
	UVttOjxdM9AGvxlCXixSahAnRP3Fs1/1yOnIiyyfhx8rz0EtNzaIesDMVZmIUuWt5G+aUw86pcX
	UXCze2m5BiUevDh40tCK+0geS4/3b+aeWs7FhUpHy37r+qdNlF80WGWB5/uv6A==
X-Google-Smtp-Source: AGHT+IGGyQ+6VoVABu/JgeAidWofJb6abV8qb3IPBudU9m+KRT04wz0+r5MgwYctRkx3xTDJI6M54Q==
X-Received: by 2002:a05:6000:1a8f:b0:3a3:7ba5:a225 with SMTP id ffacd0b85a97d-3a4e85d3136mr1236688f8f.0.1748461485201;
        Wed, 28 May 2025 12:44:45 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc15b6csm382385e9.20.2025.05.28.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:44:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] power: supply: bq256xx_charger: Constify reg_default array
Date: Wed, 28 May 2025 21:44:40 +0200
Message-ID: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=guCDaDwTAp4TXvy9+7jlbNrAYwY+fXtO0BITgGPtVMo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN2enhClD2OVj5IBfWD5bxolqLlH8r1bnMziAF
 o3pQF3MDduJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDdnpwAKCRDBN2bmhouD
 1wpuD/4uLzs7ngmmWApjO8tMzYwJpGwcwr6aThW0ELvD47Ocu7snGrFe466Y0vLjo9stRQIUpcZ
 SZfJLv2smNDZ2zfcdf1CQntivRA8bdpUnWoLmf8FnlaXnjlMT8Kk3pFKBPNrhShQSQWAUv+PxzD
 r7rHp62LgGjKFthtygXlsLgTFXRLHxm7R6FxXmzuqEDKvjAH9kIy8/+4YfuATHUjYqEQz3ykqqX
 eqOccE1oBEz01FK8huiqV8EJDBR5p/hnmF0i6KtKBwWLhs2YpdxkpFbJdGlcSPyT7cS2N1EKlmF
 QlbKMG8g4UL/e4z7gyXcs7rNPIuwwETn9s6jwhLWCg6uVUyWjM3h/e3K8scPkT0f9z6Tekx8kPw
 o4vX7S8UMsVzjRaCp8Jl5hIG3gskmUX6xPBbh9QsWpdIRuGQKaIqjvfvnrMOL8WLCPjdGlAoHyQ
 31jp/9P8ogsooFYGRunqiAXlxWlXp0PA159NEqD3I3jBeaYWMEDNFChjtWZYm/2u3qrwcEtDCBp
 7H6lE/yBBllwoF1NggdR7Idul21b3Ps3hyTd/TlhaOeTzMg+fOoiRMWNgswfRWQReLz0iP33Z17
 CEaD2oMTEgnOFA9DPxHWuD39xZh8RujGmCTf9qXM9AspCz7iUSv/RB3q5S/5iiWBfPuDoTyycgI c9akbGPi5Ko2Ceg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Static 'struct reg_default' array is not modified so can be changed to
const for more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/bq256xx_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 9f9b6019f8e1..ae14162f017a 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -387,7 +387,7 @@ static void bq256xx_usb_work(struct work_struct *data)
 	}
 }
 
-static struct reg_default bq2560x_reg_defs[] = {
+static const struct reg_default bq2560x_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0xa2},
@@ -398,7 +398,7 @@ static struct reg_default bq2560x_reg_defs[] = {
 	{BQ256XX_CHARGER_CONTROL_3, 0x4c},
 };
 
-static struct reg_default bq25611d_reg_defs[] = {
+static const struct reg_default bq25611d_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0x91},
@@ -411,7 +411,7 @@ static struct reg_default bq25611d_reg_defs[] = {
 	{BQ256XX_CHARGER_CONTROL_4, 0x75},
 };
 
-static struct reg_default bq25618_619_reg_defs[] = {
+static const struct reg_default bq25618_619_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0x91},
-- 
2.45.2


