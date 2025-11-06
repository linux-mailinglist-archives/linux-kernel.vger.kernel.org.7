Return-Path: <linux-kernel+bounces-889021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2271C3C842
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619BB3AB8AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452234F48F;
	Thu,  6 Nov 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4hfIJLj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DB35028B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446737; cv=none; b=Zvb1q/oxxfxxQcd2P5BhW5kS8xPKwF6BsLQd64/lFTiQUM8GBTDJ3O7vcyMj5S4zHwwQpakkMTISD87XAQgS42IxxZrNf8ouq59F8Wkr9EShXGKmSrgHtzJWS/9kV7MUTgyq6+Q4s56goKzaNVdbdoKD6JkReSkd+Y5v7k2Xc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446737; c=relaxed/simple;
	bh=m3Rw4RghvlJpNqwmX5RdKGrpt4N2kWtJe21s2ySaS+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ef5XQKCHotYArWwJ88Xq+KVyRA3Bzx3JX83YQ89GFFC3Dc5eSIGu41fGEaAl1UAguxZ0Q5gx7DAgqZj76MkybwMgP/AdwqVD+xDbrB2DMYwNWpn5DZ6hNagGs7wkm25KG/RN6vDgYp/OQsx5SCvkeArJBAD49db+VtYYoDwYkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4hfIJLj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so234866a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762446734; x=1763051534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwLm9ZOqkxP5nRd61gUy/JOG5+aVOeMLvrzzIiEulOE=;
        b=P4hfIJLj0RBhjGi06fP9eyoUt0dXzlWV/N/hnPR5wStOq3XC/mFAvBHJ9Bf0Mlk2FL
         NZX+p6Gb5oHbYRA115INCFW20P9OS8XImjBtY0zweCLgovWGM3fHe4UoMxMxL/3q02bZ
         LJJc/V5uGqIxyIB63zZktUe9RkfXIEpYiDjrMBGHs6mu4uvyJqlYlXGrNwCqCwAfk4Rq
         TpOK8iAgNKBAbmr2Nza9SQyuRLbnCpvtuSJhidjQq2UIaz7Raq3izCxCTysH/VFJ/mJ1
         EyKgbUEzGnFe+5hhcr6oXQolMyNU+LtqEkKiJeWU/wwyVE33fIhldwHdScZD2qBdx5M1
         odOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446734; x=1763051534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwLm9ZOqkxP5nRd61gUy/JOG5+aVOeMLvrzzIiEulOE=;
        b=FmvTxaMOBQx/isjZs/mfQvOOQ+BX7IkvlZiJjT1ghlDZmGUiXwN733j7NWwFrHNafR
         aUvNSE06fwaROmdF1E06JXTeMTCjQNEbaGT07l7Ue3/Oke+fEIgCqrA+XGYnWK44L72n
         dedT3kNl6BBVS0iOzLFc+4KQ0RFUHE1gDxEJYiLYdUwmZod9U5H3ZKWTWsiMwmvlJD4o
         EvSmRdz0g1N+DYt6MoFC2S5xrAM6yvzx26h+w/sjOwang5X/7C/uJ8dkY3fL39pXT+dC
         q/DKSuaOKYNdWHk/TZ+5XkG5tUYcOYWr8/xmGDgWVAkQ1VuP9HRcRnzgHsy/uIByaJfk
         bjBA==
X-Forwarded-Encrypted: i=1; AJvYcCXm3HQWF69TNtFDKWNvGMG4hg14nXBzu8R0z+ynbVyBeVx1mAWQPEi0ttIrh8BXC1n1TUsZ8XEWDDPqsXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QDHnQDvn1BMq+cchbDBUBmHrIRneK7W1FRWIwVbhVsyWvhFy
	4WF1tVBXnGgm2Pxs0fvLrqm+xhUA+dunpF2ntvKWuLDoTtltzvyYxseJ238as952dJba1/AteEb
	08rb6
X-Gm-Gg: ASbGncurW8zCUlcd+Um7+ZHdMqwWAlS2LNAfEZRFEOoi/JBKfXEO39rbSun8AiZl7/1
	AH2CjajCHbuhD987HoA0cXDj7XROpV+UnNggnFRdKrfdMN+Z3nCQjzytoOhsvb9F90km5xczTF0
	J1pryNMPomCA6bBoYfQtKRbQm+Y5SQqc6fOBCEuzM3sHoykvcaZcKnEpW1uh59qOHJaFZL6aKBk
	zWOco7PBSA1zq1hIMwzI8tCZhRl9q9/jywqLFc8NRR8aEmSgytZvdpaRX9NW4tzLlG5CnYLHvM1
	ILmAjYaGzUcrtjORyGI8nl+xyVDPGK5v18bYJLIXMgJRDjPUA1M7PA0L7iPjr0PGlMRG4KEM27y
	jug1kzl51zgRguLsbfygzuNFX95TrJahl2b8TZPRG3Z4xSIj42cTAxPoVk9Vz6/Yq5QiAWY9g9D
	Dg2+sWZvfTi7f2JI308O5pnMcI3xQ=
X-Google-Smtp-Source: AGHT+IHc3F+M/TvLrDrcLFQ9tW2dJiHfP7LuAF+5PCUj3SWO8aHpQIglRCyahcghJNa2WJYjzSTxpA==
X-Received: by 2002:a17:907:7ea4:b0:b70:be84:5ddf with SMTP id a640c23a62f3a-b728c18cf8amr200241166b.7.1762446733526;
        Thu, 06 Nov 2025 08:32:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289682544sm249625566b.53.2025.11.06.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:32:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:31:58 +0100
Subject: [PATCH 6/6] crypto: cesa - Simplify with
 of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-crypto-of-match-v1-6-36b26cd35cff@linaro.org>
References: <20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org>
In-Reply-To: <20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org>
To: Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
 Srujana Challa <schalla@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@axis.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=m3Rw4RghvlJpNqwmX5RdKGrpt4N2kWtJe21s2ySaS+U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDM2AgBnenLurgSZhuu/V1NPBQsW01qTALo954
 zHx6Qd6Ku6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzNgAAKCRDBN2bmhouD
 1yjFD/0SXBjr3o5nVCXeb9CBDYjItP5g7f0LzGkhPBdzKq1eqM1T7O1jSX3hrX794tgPKdroXYo
 QrRDyQh7k+tp2d611N2Q6HZXoHQyybNtsimpOHvf5ptsmVPyynyhzfPUUr3Kpy8VqUahiO5fKE4
 EFriMSYfyNmnJDEZdsIQ+6ZwBjMu/JK3nj2yODqdq8x2Rbm16GcCZ9chcd6AevJZc74OUpPerFK
 itTLja9B+uHdYAml+qdB0bbglDPbJVY22DXqT6w7TC58Pxjt0En3ov3jdHdR0wVmKtlsL78VBUs
 7Q17yerdZ6SuEv0WkJNsL8L0Gfgi/X+MgRl7R2wmONVWRpeZtw7FahAaqukUBFUBq7jUdcyDudF
 lkvPbw+un3kjL9WYagYeYgT4g2eyVDIMjhDwZdbwQCic9UeUIzbRB3tELLUXOvMCvzYfgdhuAJ2
 aVS62BP7hHEtOHb/5/SZpS/8h9YPNH7nddQDjn+u7wQRokB2Ji9Nzi4TE/ApO48rZ+sjTaqGm6u
 xXEF31vkzrXOo9PbyJcztNZDtuQOXHkvCMwpKYFCrchH3QlDauE2E/6ZsGZuuaYPyuy11LcvjPU
 DhZQey10BF7vpWHGqAt1n3XNk03n2Cintxe2zQLgv8JZxE7DkdxCFws0I1ZW1LGy2zm4KA3NyPL
 nFMld+t4RPp23Dw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/crypto/marvell/cesa/cesa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index 9c21f5d835d2..301bdf239e7d 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -420,7 +420,6 @@ static int mv_cesa_probe(struct platform_device *pdev)
 {
 	const struct mv_cesa_caps *caps = &orion_caps;
 	const struct mbus_dram_target_info *dram;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct mv_cesa_dev *cesa;
 	struct mv_cesa_engine *engines;
@@ -433,11 +432,9 @@ static int mv_cesa_probe(struct platform_device *pdev)
 	}
 
 	if (dev->of_node) {
-		match = of_match_node(mv_cesa_of_match_table, dev->of_node);
-		if (!match || !match->data)
+		caps = of_device_get_match_data(dev);
+		if (!caps)
 			return -ENOTSUPP;
-
-		caps = match->data;
 	}
 
 	cesa = devm_kzalloc(dev, sizeof(*cesa), GFP_KERNEL);

-- 
2.48.1


