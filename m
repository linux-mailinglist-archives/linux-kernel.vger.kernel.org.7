Return-Path: <linux-kernel+bounces-889961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0BC3EEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD649188E22C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC3311C1F;
	Fri,  7 Nov 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDjhlYum"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF1311C06
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503392; cv=none; b=WnYNYVqr1nQxTSWHYSlPyQHti27+5z1+LM63IdiC1aKr9R+MzmoQ5xhF247F0gfAOlQZ0LeVxLcBc8AikJHHJK5N7hzPhDaVkXgu4Ls10aSYORirpyatsS8P6FtR/WD57uQXcEFUwg0W7Z2yB12cUq0U2R4ihEZDUDRYY+0SzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503392; c=relaxed/simple;
	bh=m3Rw4RghvlJpNqwmX5RdKGrpt4N2kWtJe21s2ySaS+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gxel91GcMxHkF2ZX1CHZRe3zltHJ8aQURJDx8BrYwr4J4MRGri2jC+adJ+MHAZvVbN3s7JXTixrd0EtvVGaiglTPnb3SM/uszgc9Ce0MDTvoB8KBliUsHbvt3vihqrCU44uGdtZGCS5Gd3p7CR21ll8Pj2ewVsAjxj/KiuWo8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDjhlYum; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429ebf2eb83so55880f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762503389; x=1763108189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwLm9ZOqkxP5nRd61gUy/JOG5+aVOeMLvrzzIiEulOE=;
        b=uDjhlYumG2HKqyKZq4ail7nY6nayqHb91XgWcJfpkM8EzBS+fjY1aCpDYxU1dFrA6L
         gXfWbCNtccho3ECozvtZ5g1uTKbzsoqt7lR8IaxDzeAx3QRdqhIzroPSDrDGuUMSEnnk
         jZTPigMkDKELZQh4nERKVmm6pc34hRHsrsxCQNe9CtmOLsLAGnBH4rR544JNwM0VN337
         NoEiQ5eP2Pwys9Li7m72YFJMmj+OssCl+acOJNxTc0f43JgKC/AkYVQ7g8wSADeQSdHD
         Dx3KJFmFXWnpN+GjbkW36Lo/PgtearM/7xJcCy2sMqRD8jr6Ts5SgLPUtbagT42GwTtW
         fTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503389; x=1763108189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XwLm9ZOqkxP5nRd61gUy/JOG5+aVOeMLvrzzIiEulOE=;
        b=aMwtlGlwXFoXFNeWDxDU6M9o1Tc5xiJEp9rlLiMBNOy0FXd1B7LtWygzuZU3oiASxu
         YeLrJuvbXzu6/GkmUlAtaqYVGBI/9EXtYNOCse8Y+eZGAuaWUZBOMPZb1pPECIRMg2ui
         WtbPXD3aFnIg530G9b/Xj6NoM0Fa433vWQji5r5PGxRBa2fM22x3HG+bZPUgxQOVR0nu
         Vj89XWc3BeRGqlUoDR0qCfWad8cHSDnwEUvljMuDX92d29tstWYEvlYvq8cApC9W1kbG
         vbLxqcykOnPuEH1uahf0LLvNK0hT3RvfQBobaAI5O4JPIlq2ttTnwWRM/3QHafisxrsa
         fWHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/FXQqEzcVTtDAO/YitCoIIbOFExz0986HfM7PNiX1a1Lza3bvVYPowRG8UDOSuZQbTDSX9Q7tWy2AXrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG5d7TZcGzYEzaR/noy+lPXCK3aaxNgxWzZP5IT59inJ2J5VG
	slZj44gTZlf+fF0Z7FupCNxu1BtK8vPZL3gxXleSy+34fnX3FXn11o/oWnvI+hJ2v70=
X-Gm-Gg: ASbGnctLRRzYoIDDKxeSxaorLygR22GUI8qWL9ElF5fl/HOuAV6WVTwMmAj6Q3SH9dj
	7AP0j2L5eaVbwpo98BigKscqmnb6sKjEOCpsiHGJJPSG8mWaRF7q34/X20gJHL3xjUtY3GzyMYk
	5/bC6R/p/N+oFDDz+1iiAyd655gdnhUBd/gLfspjdnAKhjsuGAi911x7a2dSD4ShbVas1d12F3n
	aEirTgr/woQECD0L3zjNL9qaZPyPUSVNsG62k6FB1hire+tmNvFpXz+uNbf2/rLF4jd2xitFVx+
	0TyUBnp7ot3JhxnqfPlPyvcJuxdF+qcKZ1onDKq0C+5ypR09xtdVtPAWE1VyD7xy1/TQHAHN0na
	zQgH/ed2aGfSR7yX7tlFvYVALo9aeXu4nuJ4W9k6bW5kQsVr7ju6Yzb4Zf2dB2SSZa8WkmTU0uI
	2MU/th3ZYubNb78cVr6KQscPCLJcE=
X-Google-Smtp-Source: AGHT+IEW7931OZiZRGfsN4XwbENTbfXf5yTkeG5zUHKOhA4eCYE8JeVUBwhn/sIFVaN+bw8gO6m78g==
X-Received: by 2002:adf:ec41:0:b0:42b:13cb:41bf with SMTP id ffacd0b85a97d-42b13cb4268mr623938f8f.9.1762503388885;
        Fri, 07 Nov 2025 00:16:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm4058381f8f.46.2025.11.07.00.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:16:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Nov 2025 09:15:53 +0100
Subject: [PATCH v2 6/6] crypto: cesa - Simplify with
 of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-crypto-of-match-v2-6-a0ea93e24d2a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=m3Rw4RghvlJpNqwmX5RdKGrpt4N2kWtJe21s2ySaS+U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDarQIPQj/uwSRGyYOhxeW+nG59uNrfsSEqYi2
 oMqO3cMHzOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQ2q0AAKCRDBN2bmhouD
 117lD/44tUDFYEjT0xJr9FfxIcOknzx85sePA1ZDeP3Oavbz5mSDgFRWG3DUqcS8jQOge532MGD
 bQjMZh6FAAXgJGYB+EHXJDe/SQrp4/DIppftDO9LMqt6wzkDR4caV24D59K7WrHRh+Ew4B4eX7H
 Tj0FOrTLAwACR0QCh3NIKEKODka/+oldeK71aizC4jVy+pODsfHA7ItLXF/FXjwrhykAoKx0RfQ
 7ApCmu6gmBUHmOn+BwYj9NFnOpf0yI8MXnRvH0UbvXeJwJK94FXrA3GItVtAfNyY4L4sPIoT4Ej
 Xwk2j55yDLd01zbRWPoxgiw5feUeibT3g9P2T8tzZ0xP9IFFfRKYCufYydLHBkoX2izid4uZG7g
 97WX+Cb3Jr8MH6pqpy9mf7T6qOTXCpGWCbrMWzAWVLTWeHsR9/MIc4uT4HvaHQnjS7j67p1rs7h
 lxsVtbgKHLUwIiuzQf5b93POHRRWwIjjzmagPIZyydUZt5hhIPxsBzfej51KDb8nqbycE8HBBL9
 kLEMB+5pQ5OisidwDx7ofZmxsKG3gL5uT7s4cifHxrkcK9jHQ9Y2NGtY5fkPCKzXbGr4c0mJQ1p
 jkSV2wodegqW3xwn+ba+mQxCItmBQXjlMqdASt7kbtMKHZGScO35Sdv8rl/aJd3U93rd3sMMdvm
 B9F8iTOyyri2UmA==
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


