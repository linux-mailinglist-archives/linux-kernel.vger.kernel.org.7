Return-Path: <linux-kernel+bounces-809983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF69B5143E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD86541B92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11AB31984C;
	Wed, 10 Sep 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/M2mrch"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25330DEB0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501064; cv=none; b=UdxEtqTT3oYvMtASaIwG3GbaRNJhgJXsZxLyrT6qUSn4gBk5IICAKSovW7zgh3EgiSDY+qKhw3Y16S0sKO7prAAj2p4drOUPynDleCkYbTver/L7pnkqk9X7XMwRL5UoCgRe4IgIvzYN5VdoOxyFeuZmfT/HZiRWRHXNmIrMV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501064; c=relaxed/simple;
	bh=M1UcDlfXbj/5vPqirllwe6Mt+pNopstDQ9HKCl8tOeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFSRKdYIvfz6mOhPoohtIepCfe/0NPOM+eJCaMrNK3BqzZaw+DKw3x5+4ORLCMkS3TbV61gk+mVVB0/6L0wzjHCo6ilu8gQBzY5LQKb38cI6qTKBkfTsW1Bmu53xLjOjDy/3WabzA6AnuuYtuPI2T6s11Z1sEx0sErCg7/ko1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g/M2mrch; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6285612382aso472842a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501061; x=1758105861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnBsMIetOHLgxvRafB9XZsD33miPY9fW8C/xMa98MG0=;
        b=g/M2mrchhOJWWaLk51lksJeDaFxJBaDowFb//By3kF7GJtlNlFe8k4CBd+GBPq72YM
         Ugw2IjQw8ZmGphzV4r0yo3ToLqzikF5X23LLU7TvPrp3VIkwxPMsqqDyDAQztYmq2p9C
         G5LI0GXx1G3YuXeQS4jj6FZhk8pie4JaGkvlNKxJJow3Ivt5wvw0XBI52CgzMDB8fxn2
         pncn1SkAcUdpdaYVwXVq/OL0kdDVpTOWhXuDWsAU3PH2my+LK+WUWkX0cGX3hxZzuP/1
         aTcvzBKoYNoWrTAt83eLSmWRbgTvXMjZiZzhBw66uaF88seIJbv4HofRJB5ueHcCxovR
         klug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501061; x=1758105861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnBsMIetOHLgxvRafB9XZsD33miPY9fW8C/xMa98MG0=;
        b=ueGJoI10jbWMiPW9AWiyIic4F12rh86mF6zCYyrdbyKUu/2MhdBKntXIzFTYlgNuOe
         k1rZZ0tLqUxH0znEIcl/WA9Tmsdu1FGtdlTDi4GMWAGqBJjDKtL7DBVkuee8DiGhBMyU
         3juwZ0HCC/URNQYKiMNhAY8FKxVqTfqpMRb4efci/7KMnnhtK0dc0MC8MR6ZsQlO+Dx8
         EGh5k5Z/VE95IN7EF760ILpuLHwiilEQAmsvgv8vNP8L/zuPbtj8wN9UNODRgb4H1H3g
         4TtAlFSD4f+Skv0phOQyp3b0pFUp/WZjwonAb316bg4H/5ARsXkTItSk1Z8urrHM6RuC
         Q0RQ==
X-Gm-Message-State: AOJu0Yyx27dINklScPiGpE87qi8+0b3Dtl8WrSnxKhVtiJBFRTJ13uDD
	nY5H/5NaCc6qU795RHHc8VNA7OfhtC8MDCXIaKaOlvsoaIOHWqWYmmC17Z/WWYfMmlc=
X-Gm-Gg: ASbGncvPNHX507ajBxxWXh0yoP3nzCQxZ00kg5sJtTuociYhNpstqZwT+a65kAitYOX
	OuuRRlAJV8U6z9d0Sq5CvnfroKu/XWYZZorkaLrGP0OQvqu9qzi0q30Wly7/Gbz6fkcThcYWEmq
	jwLCq+gUPlIRhIlIKfXaHNHHcB/FmOJhwQaJ2akcNs3WRYQeYygwYFiq04+CbyuiqcBwMeTXBlJ
	FCHR+qihDP+ZH6iIefbZX0ILFGivK3vbCaGYtnfnVRRUQHKXfcGYcedQwkxjNfGB4BYr/pCnd/c
	EYhPgzltNtK3k64I3eOz+NRJ8yLDgz5i9wsMydut1wmvf8iCP4jAAVnOTA//ZxRrEsYK6DB70J5
	Ebeppfhq/bgSYbbDbvHYUgSzYwpRHltTkrCII+O4=
X-Google-Smtp-Source: AGHT+IHndwPgiFalUI0Osr1mhVatUVBRlt9rqFbB1yf+l748O6YjoHNTTNyX3DiefIzkA9XLIxL87g==
X-Received: by 2002:a05:6402:2345:b0:628:3c12:8732 with SMTP id 4fb4d7f45d1cf-6283c1294c9mr5449146a12.8.1757501061401;
        Wed, 10 Sep 2025 03:44:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:44:03 +0200
Subject: [PATCH 07/13] memory: tegra20-emc: Simplify and handle deferred
 probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-memory-tegra-cleanup-v1-7-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=M1UcDlfXbj/5vPqirllwe6Mt+pNopstDQ9HKCl8tOeY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZ0vbHbIrfCHEW8zwOekb7DVpj0wPZ/QUTL8
 BZn64ePhuqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWdAAKCRDBN2bmhouD
 113ED/49eVcXsqTjBbSJYlPack6vuHMauo2QQxobnfuEmbtlDWntO+UJ23Hw6/HX5diGaMdpJh0
 DRjQo+Joy/uwKhWKZQspD5kVHzV/JRuO0MPAvz+pCGYi+CYakhOUAlABQgMrGHrSLMSDncw16p1
 wnMOytfiqr0Z9hML8JYbSRWbaKqRCv9WyJ+jiz1o67hv7ROWkAYUV8YG8TFCkhK//TbmDUdPy/7
 gwvE4Q8D27+qKxMOZi3Nq2oTTPA6t78zXStaDHWdxYRNFV4wAj7x7pnj9jRNhsLPo0Mszg2aUeO
 OBQtCfmpqv6RKdWBGGqRq13Q/OQhUbiN1AKCLKf9SxqTGcptBU8dcRkT++a4XkaFkfHachbx00w
 IVcQGbAGOe3HCAQ7r+MKgatZgeZX739NcvuPzdVPAXgYIiB/Amotv8hFymIyRENCFVR1PsnNdPK
 XpkVfKU1CvN508lZpOe0vYb19peu+f1EkBypIPgfB2o8ONdsVuwbl8ue9xf7PpWz2s5ZdOoUYuX
 tsHbc3msA/7P2CvaUspPs/7BFJxGuoyGJ/Sh6VnpxqoVh9E7yYb+L2If0cIeHrVVH0dDqx5vxbD
 fwJuei1bCGc2+KpTKO8TsXoWIeYG/AvUedwXfQRWs/ZvM2Zb2eB92LH/t6lgY4gGLyAWktgKTFm
 9AZAZKQ32Kx4n+Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Certain calls, like clk_get, can cause probe deferral and driver should
handle it.  Use dev_err_probe() to fix that and also change other
non-deferred errors cases to make the code simpler.

Also fix missing new line in error message of devm_devfreq_add_device().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra20-emc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index a34636a1c4c55419c323eabfe96c5f27375df344..18e266dde5d2a0fb962fadc04161b03fb79f76cb 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -1051,9 +1051,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-	return err;
+	return dev_err_probe(emc->dev, err, "failed to initialize ICC\n");
 }
 
 static void devm_tegra_emc_unset_callback(void *data)
@@ -1080,16 +1079,13 @@ static int tegra_emc_init_clk(struct tegra_emc *emc)
 		return err;
 
 	emc->clk = devm_clk_get(emc->dev, NULL);
-	if (IS_ERR(emc->clk)) {
-		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
-		return PTR_ERR(emc->clk);
-	}
+	if (IS_ERR(emc->clk))
+		return dev_err_probe(emc->dev, PTR_ERR(emc->clk),
+				     "failed to get EMC clock\n");
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
-	if (err) {
-		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(emc->dev, err, "failed to register clk notifier\n");
 
 	err = devm_add_action_or_reset(emc->dev,
 				       devm_tegra_emc_unreg_clk_notifier, emc);
@@ -1172,10 +1168,9 @@ static int tegra_emc_devfreq_init(struct tegra_emc *emc)
 	devfreq = devm_devfreq_add_device(emc->dev, &tegra_emc_devfreq_profile,
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					  &emc->ondemand_data);
-	if (IS_ERR(devfreq)) {
-		dev_err(emc->dev, "failed to initialize devfreq: %pe", devfreq);
-		return PTR_ERR(devfreq);
-	}
+	if (IS_ERR(devfreq))
+		return dev_err_probe(emc->dev, PTR_ERR(devfreq),
+				     "failed to initialize devfreq\n");
 
 	return 0;
 }

-- 
2.48.1


