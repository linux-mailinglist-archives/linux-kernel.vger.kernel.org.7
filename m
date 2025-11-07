Return-Path: <linux-kernel+bounces-889958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F392C3EEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C2B1885A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC4310650;
	Fri,  7 Nov 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K63IoFjk"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544D30FC2C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503387; cv=none; b=FPnsw4FrKxfctGPMqmTeeVJ5V0cNlQWJwxyMM1xquvihkySGlhU0hr6IoBB4pfQ0SjSuZDFAVPZ2c3AlsO0nzMGBAnkYrJaNerxjenuezWDx01kCYAoeA80OSHFT0fl2W+ocEki9l/6GSenbsSh/f62v0nQw+GMOA1Lp+myOgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503387; c=relaxed/simple;
	bh=DQmjxDQk3FjHige1OE8Ou8+bJv85dK/Lal/Y6klcg5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bM1VFetYMTlRmmL8rYJUlnaapEAEJfZKwgaZNOYujftTxH3a90XPfWicSqQ55p5vfM2TyjZSpwXvyPgo0UhZvA6lkME5Kc5ZGZeK8N1qvlTXSwb4SfNdAeWEFztN0WEve13iouBAFCw1ESl+cCIKYfUxq40ryPaDD3LmPFeu9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K63IoFjk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42844985499so24459f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762503384; x=1763108184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU3ckHK9dgiwiJ1SDtj2Q9mmUFDa+cikTDpXLmxraq0=;
        b=K63IoFjkE26DOlE1ZZ9Fl8CV0LPB8CfcBwJOsGPjXbczI7AtzftR4d+l77aQ+cFdHc
         3QdWXlqjddmZaTB5Z0xjFtCw4ZLIVTrOx5DtuaCeV1gqBsuwkCmwvyt7iq5AB1R9D85Z
         kw6/44HAsK7b7eibQEbrhgkOpGRFYv24liHSrCKnPaSo90gRzs7X0yBk3XZYZGsyrHhm
         UKSrJmuUml9+oj5/u5VA3ojWn7LAulegbqLK4GZOrJIAkU9ngVLE0/nuzVrOCZgqNghs
         tl37qLkwpeoUuBo+NkIcnG9Y5iE4xAQnIRk7zCTwa6IA8dFuY7qUlLGt0zvbRzN+xn4H
         IzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503384; x=1763108184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aU3ckHK9dgiwiJ1SDtj2Q9mmUFDa+cikTDpXLmxraq0=;
        b=Nx5dMNXf827pPnYXGMEKWR9sl5SyMCVKTjBcDeuZBnFxLPbhd4+YJUElilWom8orcR
         9oCY40X0GygkDQF0MA7om1sFdYN/Qne+hUu5JeEgPG7zHcUf+KROhPo2/IZg7ZsVKi4m
         nS+k6A1yI+gYIvN4R4DZoOagdJorP5SsvuH+fZU4U9LIOMB+dJfM4j8Nlq19Lq2u1Llu
         pBBAlUIwjOEBJzb9brMzh0TEruKh5iAF9g0G92e3A/e4/SgjHTpVqTCXWjTnAKfnY/uT
         JBW8HGDp2S0Fmg82nyXNaFjhmzjbK84tLFg/tBkwi092FJlV6nHBGNONjrTe36YgM3d/
         5VDA==
X-Forwarded-Encrypted: i=1; AJvYcCXdNkoyW3+Nh1VPAFCBUPyMjaX5JZ8o/RGE2H0vjy9OSb4v6WoY83tipru1B3MiHYoE3r9cgEY/mQyzeXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKHckwnCtaJtZtJLA+V5yPq2D60y8Xw8v2GrId56ICZo+g35u
	y7jBvVWVY30WjoeqbcN2A5IaQNYGYsJ7weqZbuZGk2G949QVxe9gj//zwWKf25WSqjg=
X-Gm-Gg: ASbGncsDvYxN5MsWtM4ulW3vLaVX0rQqif6mfx5F2nBkBR51YmiDqY9U8F/DOLAusJZ
	0fIyV/O/Bd+DQJo9JGIGDnzJF5r9oJrOe/KQgFitsAtAqCz1N0o5n8u7z+CfsEjGpV1td6dpZUb
	DNetpbBuyhT0AJLRxzVjA2Ed+F1yIvUpPi6bXlfkoBHYieUIwIO3IkxeiQynz+dhQAvMRGr/n7a
	oguboAyINfGkRaBZbdIwP8ZrfkhNTBKdQXnQNK4lTc+4F3MtellyxjH8GLGpB1kf9fJ24xWw/PR
	7LXKYQ+NWlI1GGAKAafTeWgqHLNBuGQLmmaWi09MFnU0d0QgPJbvGIOIhRY+TDp7A3xjSL69aA1
	0OvP1ZofQub2p+wFMf443reHm/WpRUaZfjzSxM93DUbSTV8eKTT3c6lxz+UsfLTyyGGHNCBd2gB
	becfrVsBiUnYGyUWat
X-Google-Smtp-Source: AGHT+IH/RG0uxXiS/Bad3Qza1ZSpzCt5mxPh4pMV3zd/0zfxxfO/oX4SzRHF7EYOxVilfXSfENyJNA==
X-Received: by 2002:a05:6000:1848:b0:429:b751:7922 with SMTP id ffacd0b85a97d-42ae5aeaef9mr862850f8f.8.1762503384161;
        Fri, 07 Nov 2025 00:16:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm4058381f8f.46.2025.11.07.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:16:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Nov 2025 09:15:50 +0100
Subject: [PATCH v2 3/6] crypto: artpec6 - Simplify with
 of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-crypto-of-match-v2-3-a0ea93e24d2a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DQmjxDQk3FjHige1OE8Ou8+bJv85dK/Lal/Y6klcg5k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDarNuKezPIUCrc4hA8Jc267ky7kEGrYSaIA8q
 xzBceHykJGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQ2qzQAKCRDBN2bmhouD
 1yXbEACApfTnmc9QitQZ7XSNkCS4VPyfKF/yLOgWiI3obDxmie7No/brRdIf5LMnNazuIyPCZF3
 cFWq/lMz/XGuXHwd6JfKiB/7CaeiEGhSVesqCG6xiLwn9swYpTXCRAkfkSfvLUJ1zw6Dqh79+nm
 RcWi4MkYDvpv05EKstpdQAc0p93wcuPKRkneKXx+eaPyUE/Lh37ne4zR3Ct8U+21S0sLADr6CoN
 cEwOiG5d3LIphAp78Y3xCT7+UqZKyQfKVrF04V5E3jF4bAbL9KiZhgHxfr6u1Ymtoigbvr75tHF
 rrjHned89Lt/e4LJnp716ojV8vi8qBD0fziwotfbBGbZc9WCPWIddPJKbtcD6JEGZSBGptebElN
 q5XqPkiqkSa4aWdQrwmi/H/uZ7aefqryw156F+Bj5DQwnJTuw+6tA4vFnB0N2caGA1hNIAoqvJQ
 QS1fmrXafW0XOKw2lvkL5EJSix7d5URiz8RrEq6geM1aajgUHhypvhCFmUw3Pg1Zs0rp01uWCRd
 CHkS0/IfDTayW/vN1mHLSqv81WjvP1xoesX5Vico0Y4V07eB8RwSIC8cGNs+0A2EgDPy6mJyacY
 bQ/pElgAalP6edLqPZQS5dRVAwQA6cVRgw2JqSebY+zuOKUJwlNxGqWvYZbjVPpq/nQp8yVweXr
 9i4P/m1X/ZKL/bg==
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
index 75ee065da1ec..b04d6379244a 100644
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
+	variant = (enum artpec6_crypto_variant)of_device_get_match_data(dev);
+	if (!variant)
 		return -EINVAL;
 
-	variant = (enum artpec6_crypto_variant)match->data;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.48.1


