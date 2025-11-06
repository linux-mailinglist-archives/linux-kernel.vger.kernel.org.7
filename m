Return-Path: <linux-kernel+bounces-889018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE41C3C836
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF0C18924F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D534FF6A;
	Thu,  6 Nov 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQQhQ5Lm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DA34F47E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446733; cv=none; b=u15IuDs++6sPfi9WaM8/1Sog8uzDHjStaLc4ZIsNJ1ua/u3BliBfsDvO+tck5SWZB8WE0OjpX5HOAmLcPVkVldeeP4zPYX5sRV75zjlyqm5XfCewunZTP0gHCTzVCH7g4d8CypFT2iYH5mXrfKGBzb58ILsEpH8M3uUiotgTF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446733; c=relaxed/simple;
	bh=qaBcxm2OdLxs0cbfnFvZZbYz3chr7m9FXFGr3KSadGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiJo2AcYNcrIadFUFgHP9LMC6EgxYLN7LPTFTw4pRnB6hqPYc4zN1FnycLNeTirmosvHkjuoMexDwr+2u0uJXvlUff2fwpKYBBJHlp+uH6tI+PWPzQqx9ivaCXo3dymH2C4yAOg4QJyFBRkSqGWgV0ITGgz1Ur2i2VWLdoXNE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQQhQ5Lm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640fb887e26so226727a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762446728; x=1763051528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SV8B/K9NFLtBTFXPw5h6HrR1/mkLN9jhMeuZKyIEzc=;
        b=FQQhQ5LmcAEZu1A7kjkyRTt85T5wkBf93KErlyfPqf9kQgkx+q73zH1NEbxQKzzGbJ
         gb6RQT/v59B65idkHJL4psWpLof6Sk0rxLtI4nxXJdz7SJAxj6+USvX0gEeVionMvKaN
         tMI3ukBsBXah/6TI0z0SSCeR0vTfCxjMYvtDRM6NLDYsi5G+VtBbGV61BnSmVr0qGAZE
         uaG7Ejim+D+4x1POuQJwIdIYZzJQvKzXD3G/lni432pw/InnDIoCL4xMC7gMpdi+SlJY
         SngM9mRtNI6srUo9KIfhyS+X0d6tQZig48Lhb5tFaqNVBAyMaNdP2ArsVwFRL0KQzVVd
         JoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446728; x=1763051528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SV8B/K9NFLtBTFXPw5h6HrR1/mkLN9jhMeuZKyIEzc=;
        b=EfG1mMlI5ON8UmqUH4lxrnw2x/HKqtYUXNcqgb9UwPKXV5Rdgl5ypICvCE0THlkAmB
         Vkok+0tvy9X0xAI7lXld84XCDnFCwefGSMH3UfEX+3Jh61N4HiRsWI+WV3bbBSy2C7aI
         c+1x5PxviXGW0gn2UPcFQqX0UqmcrHuYS3Y68IjYsegncV91dkiTHsrwdagsXZ4SOKl+
         DZygZlSzLAn9TiIc+pHcwFrPHzEH5YR99v58UlHaXEDXh3Yvm6/V0SUjmlAR21fmO4cQ
         0sWFXHasCU9u6DAI7i6vGC1SUHpoJMd+SXuBk8Q1GSEu7dWBWwinogVfmR9zGFyCUOBF
         QZxw==
X-Forwarded-Encrypted: i=1; AJvYcCXA5T9E6oQ4rPkI6skMZTVslgREEALmWE9si0/+0NvKVP8oxeRsEfy8y3s/sp7RotgzYRSeEP908BXp/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVew+pt75MIZUaQvlwWyH1gFlp0QztEUfJ0QQXEBbIyjTOiq3l
	LWzrmh1HjrSmqVr5/YuQgtia87784uKRMKWj2xm2iiDG2shvY4G84h2BCI0sP3uo4Ov0Oiv+4UM
	HbYZH
X-Gm-Gg: ASbGncvMdLC3PPwlApUYNv9lNMjdVgU0Lx/2Fyknt2Ar8mCsUeRpXt7E8750AGLI6Em
	XmBrubovs5xVR5ejCbOamer00ckxUaDv+p+tNX3rOUPpnxyY0ZGE9Anp4n5BgUZa4PxFtLmQJet
	5uy/cjyYSXOFObtj9TuDU66JW0SYnZzb8byjrcIYjDAAl6yuVaPCVDPRhajWymJI3X5cvm0hscp
	g3mBv8klTomqNmYcYu+9jq0a+ju3XiRkKCS+v7oJXehnrfozTAAzJ+YrrdsI3JkwBXOF3pEjuxw
	rL9usFiui3pq4B/Jmap+pdxP24GpBWk7c8Zs6IoMGDHOjgucskSVPPwXHSl0cjx2BfDadulAo6O
	VE/bTP/TYREvrOR0V+eso7/5vOUke8Lf+c8cAQbgI2VZva4gxOqWvx+J1toAalnSBLH3tu56nJ2
	P5oF7tEOG4n48B2Zam
X-Google-Smtp-Source: AGHT+IGhxLSDzqFDqIdMNDKH4DTk1EKeSot+LXYTt6aZhf6l98vZ6t5WCJen8f3ZR0l7jgIr+lzJcw==
X-Received: by 2002:a17:907:c10:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b726515d4a8mr420650466b.1.1762446728255;
        Thu, 06 Nov 2025 08:32:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289682544sm249625566b.53.2025.11.06.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:32:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:31:55 +0100
Subject: [PATCH 3/6] crypto: artpec6 - Simplify with
 of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-crypto-of-match-v1-3-36b26cd35cff@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qaBcxm2OdLxs0cbfnFvZZbYz3chr7m9FXFGr3KSadGE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDM19Zv267ptOjwUqI8uxjH8Nnwd/rDNI9wyrc
 WIueB+DbWaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzNfQAKCRDBN2bmhouD
 149CD/sG6/KMDXmvV2vb0OxQfgnGFVG0l4bRcysp74kh+NtHFFCHdMve+71r+c9ZlnDkDhjtQAO
 LVlTRiZz8eSYuTx9kiHXLZRFFm7NAJhleLzU9kN1tX6Eotq1fU6A6/V5J4raRma45KqsOajkzsI
 DoyqgWD0gS0j/DYtYYYskMpzi3LAtutLaqaYSZXDgGBGiIvZggh2zYqmk2nytjh/N80QHc26o0g
 3xrdxg1DRK1SOBp8o1XzhFG/kETzhg0oO/IRz002V3RvZmutjBMe6DBbwU6Gkc3AIBUOGqKEQY5
 tveA98a4EAGf/W7+l5nhR3sfBJ7KJosfa6hwXEq/GiuGh8GYedTqQ0Ep6aioMcKacrcfRAZXnfa
 YE6skmficAnkdPHOfuoH9IN07ikeMpMlAmAES9CcYLU6P1Zv5m9PrRUrXSGMiTeuYwUtSJpY4He
 vcAhowTJinhA7ngBjntyuT/EL+naNKRqgJdm3xSNMjcgIPC760vl7n38XGA6k2+ZTVMrmiWH7UH
 U7AeZyI4xsgRxoKqQLlWHuA9qITgsCx55Qu3NA3sHWGi9PPCjgxYqlgij1LXj4oyYLmLs3XzcAG
 2CYc76oTX45O4T+z4RW0zlSOGzvCgJimsKHcnHsgSzSJ0LTwLyMLF3GRptV53kgEOA/D3NvjzZl
 OqS2XJirPWNR0rw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table, so
of_match_node() can be simplified with of_device_get_match_data().

This requires changing the enum used in the driver match data entries to
non-zero, to be able to recognize error case of
of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 75ee065da1ec..b0d45f5333ac 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -252,7 +252,7 @@ struct artpec6_crypto_dma_descriptors {
 };
 
 enum artpec6_crypto_variant {
-	ARTPEC6_CRYPTO,
+	ARTPEC6_CRYPTO = 1,
 	ARTPEC7_CRYPTO,
 };
 
@@ -2842,7 +2842,6 @@ MODULE_DEVICE_TABLE(of, artpec6_crypto_of_match);
 
 static int artpec6_crypto_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	enum artpec6_crypto_variant variant;
 	struct artpec6_crypto *ac;
 	struct device *dev = &pdev->dev;
@@ -2853,12 +2852,10 @@ static int artpec6_crypto_probe(struct platform_device *pdev)
 	if (artpec6_crypto_dev)
 		return -ENODEV;
 
-	match = of_match_node(artpec6_crypto_of_match, dev->of_node);
-	if (!match)
+	variant = of_device_get_match_data(dev);
+	if (!variant)
 		return -EINVAL;
 
-	variant = (enum artpec6_crypto_variant)match->data;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.48.1


