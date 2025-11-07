Return-Path: <linux-kernel+bounces-889959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28956C3EEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309053AA1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2030F537;
	Fri,  7 Nov 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2hf91/L"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2D3101C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503389; cv=none; b=IpecEyCX1mdjbn7PM2JStHgHTUrJ/3MH2PmouwiwbEVANkwQJJOrSQhzHq9SKIQRUMDhKwHrtVu4RwWaPtj6erZzO5/ZUlrq3XAQKgW/Nde2APxBKoZriT9AaywCWlhRa1kXFQO/0wEPw5GvBML94LAg9saEhSuQgeWiXzDv/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503389; c=relaxed/simple;
	bh=uTmny2khUfJwBOWnPIYMUA8TMxpeqbiVOa8x77OKjl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvr6xr6jDciI3CTTzBjZRrA/50eZ0lEu7niRuLHzLUNVyFejCFSZE1rQifp5HQD0BsLEqfAeH/5IPFc/RKzcFtT2aiA0Dvvl84lAWi6fX2MassPcD/BkfUHsf9fbEEd2ZDoz5qG1OfMLDcAIHQQlgut+K0DYL2KGnPpuBYiKUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2hf91/L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47107a9928cso102345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762503386; x=1763108186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsuVQU0kBLri6hmaJgWdFh8PrREavrj/lIeKnMHCYnk=;
        b=A2hf91/LJh4pWFJbNL1k5fWMBFFguwNl5sUY99IDh2RB4h/u1FHofqCUV0WcqREZrO
         hb3keUAga0ItecFlE2zv4Nek2ppHxhkUJi334CznUBMZQyKjn+NggWfMJBJwchwv4Ffg
         tx2YfrvsUamok7BgKagWd6K4WGze6/WuUTmYXv9/Iq0cPIuuUdRwl9LI6rE8xaCyRJr2
         KDs96H2kyY4mJtiRK7nr0ul3kspWBdE61Dk5g/6UVOSGouJj0Z4XamF2dSkOY5dQSOgB
         uKN5qTMmjY1JuzvE1xkD5AZfGFjpr/pfbB1QNGtbOT6CbQvAq6k/1zbf4v2FiVR8eSRG
         a4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503386; x=1763108186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DsuVQU0kBLri6hmaJgWdFh8PrREavrj/lIeKnMHCYnk=;
        b=ZQ8g52BQluv/Ez1WvJ6QEq8yTMG9VqV52Fs24CwcLXVP6ATRVTmZ8QnaZyav5+OMko
         hBW4TsH/xz6h0MvhSFhj850zwDDVuT8NCXzICytYpDKGDX+1bIIVo+SyZOpAce2ImpLu
         lzlUCKjWMWV5OBleiftwci6AYqYJHqd279Y4JBPPuUCzLfQUgW+S60xydKzR/INNm4Ww
         4mf13usWMcZGe534IFSKWjO5RKdMWsHtczXyFC7zz5C4dJhS2FKFvcrLwN8mleHElzbE
         e2sEd8p9MmtdzEQervkWp9xQaD3a0bjGDLkFcoCXupXtg3Ya0GayClG/KoLSNpbnx2tp
         2afg==
X-Forwarded-Encrypted: i=1; AJvYcCWWrCvIophFyQM0GC1awFWyrCLAF0XrH+5hrftDcICeS93u+Yr4dl278g7bxpXxt5qNxajPNlSfSTdRJTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjh0maFlkJrbNMKTTcG+195KQr4okObc/wfG8t+SG1Y6M5/Yi
	HIJgyBv8cQSgB9B8/ukGZWvvXukfRV+RPev2+LCqcC3Q3kgPocW3NM4PWM/VaP4/xos=
X-Gm-Gg: ASbGnctzgT5fL1QCg86B+UPoiQrjdHbX2XWZZqy72q8H8yLePnclL8Ahwj+5itBVx8I
	Iww5p8vUBGkSYyZ9iywIfGhDQLB8oPpp0iEKUU1NV5tf7i8n3sZI1p04IdzLwS/AixTCOVaX7Fi
	RHVuHLjKDh2XRMBNMypazmgix9TCz4rsalU7Rpf95hPf0fdxFFNM9luNUNhBCjMF82TroiNopI4
	xDg31IJ4WLMl/yKGCt4rqQUsGVJpiwBwZb0iimMmPcyOKIEX01xTuiwajFQdJueunsGwKO9UC9l
	YY/9A/HrB64KVNRwS6Y8zG+lwraaPhRLphL4qpJY7WxEmvCvAG4SKlClDXMHkcHzH/CndGIgNhN
	qIUO7yZGNzO1YbCT8tZOwGF8lRpaS2dzEmDLd/hFYQsGg9oYyUqm4/55wQj6KDy2cSrdUqT6zHs
	Y0krirMaS7ySMTu2iX
X-Google-Smtp-Source: AGHT+IFxgOKWXdA9hWEwZIFjaH0GhucMIF9IisWZHUQzXCyuXWttToL3uxyrxQ7VCO2D5ii7OFEQqQ==
X-Received: by 2002:a05:600c:1e8b:b0:477:10c4:b52 with SMTP id 5b1f17b1804b1-4776bcc83e6mr9398415e9.8.1762503385654;
        Fri, 07 Nov 2025 00:16:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm4058381f8f.46.2025.11.07.00.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:16:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Nov 2025 09:15:51 +0100
Subject: [PATCH v2 4/6] crypto: ccp - Constify 'dev_vdata' member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-crypto-of-match-v2-4-a0ea93e24d2a@linaro.org>
References: <20251107-crypto-of-match-v2-0-a0ea93e24d2a@linaro.org>
In-Reply-To: <20251107-crypto-of-match-v2-0-a0ea93e24d2a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uTmny2khUfJwBOWnPIYMUA8TMxpeqbiVOa8x77OKjl0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDarO58OSSjeZ/MbkGRG/cmhslRbHT8xse2e+1
 3RK3Y6qelmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQ2qzgAKCRDBN2bmhouD
 19qxD/4xxZP3XPx4HmiGMoIT074VwmZlKVGWBPALUzJR00KUN6qkjf6aQiGyi0BJz003r9FHokB
 P0LFjUFRrWfWAJU1zXKVFaSOpjH8bUHhgrbmhvEnApKXXUJ8uz3c881SYC+Pj4yAOFJyzQNvh2a
 oNkXjeha5SsBI4tPj5Rg/+KnO5YOZbeZZBwICbXJP6Mp6IpukkOIC4TRJ12D5e8oJdd01JmIs14
 TOQRnkSfFYuswcyIKYpx71MfgG519BRUl9mz6M9OzvCL5Eko0+y75Cia8br2hxcaGFTmLpJgYFq
 DTjvd7uY9iL6xyexLutvlVVXirAUtfdV8oXljVl9u97k6ze4EmyH/OCDq35yVBoq5rfF9b6F6YZ
 pnrum7tp+9BqGkUgPz2WBavP9wWLq9XMbvHm//4hVtxm9UrNyiKZXOds9VKQbV2liGu85jFuHcn
 63PDdsOQeR1l0p1CzTwc2rEWweOtct3GnKtZuQh7QYgM558EW6bUhB5RKotm73G+G3WG7iJe562
 xSE67xCo3+xfbFfGVCAwI4fqnyFNKD8HTtBNmhLiecv3+fMLJcv08C7aieloXxXG15HhnG9uYry
 uqKL4SWxJA40IEQjKxB9U7zSfNprRvNFNuykzVhhAfJ1hg7RWDkX3Z4w4Gvd6qNhvIBIcidALKi
 ubXzajJ21fyB7+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

sp_device->dev_vdata points to only const data (see 'static const struct
sp_dev_vdata dev_vdata'), so can be made pointer to const for code
safety.

Update also sp_get_acpi_version() function which returns this pointer to
'pointer to const' for code readability, even though it is not needed.

On the other hand, do not touch similar function sp_get_of_version()
because it will be immediately removed in next patches.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/crypto/ccp/sp-dev.h      | 2 +-
 drivers/crypto/ccp/sp-platform.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 6f9d7063257d..1335a83fe052 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -95,7 +95,7 @@ struct sp_device {
 
 	struct device *dev;
 
-	struct sp_dev_vdata *dev_vdata;
+	const struct sp_dev_vdata *dev_vdata;
 	unsigned int ord;
 	char name[SP_MAX_NAME_LEN];
 
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 3933cac1694d..de8a8183efdb 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -63,13 +63,13 @@ static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 	return NULL;
 }
 
-static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
+static const struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 {
 	const struct acpi_device_id *match;
 
 	match = acpi_match_device(sp_acpi_match, &pdev->dev);
 	if (match && match->driver_data)
-		return (struct sp_dev_vdata *)match->driver_data;
+		return (const struct sp_dev_vdata *)match->driver_data;
 
 	return NULL;
 }

-- 
2.48.1


