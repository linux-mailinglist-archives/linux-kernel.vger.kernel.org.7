Return-Path: <linux-kernel+bounces-843238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E104BBEB83
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4784EFB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3E2E0B55;
	Mon,  6 Oct 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYfm8Zk0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565B2DF122
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=lphLEPyC6Q/2ajfdtugRwa/8kfmEk6hJti6kePtyfQNdM9N0Z4gKrrWuRYf5ourLa001vIZvpQ55h15ZqlQDR/AXY0zttClK49rxURvV2IZXiO3Dond8eP+PG4k8fmmbwiQnWiNQ1Gsr756zqMK4mwnPFqO43oyvcj4K30LoZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=dNOLUQevSwifZ6dPtrx27CYPt5ZcaJvQ++oKkFXtwgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGoGRsoeFsKhJYwDrs4nv7ICI2t9igOMxTHJVQUNqYQn6kwwMK1idu1V7tcA4Nd3YMF1awYqJ5dqo8Ae1R7Ibqfw7cHGgAB+Sti0mQY/0u4tNzyBrWN3XFpV2gVTQOnuh/0+tG/xiRmlwbvrDFzY1Y0Zvn7WYg1l6TG7NXEmiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYfm8Zk0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so929869066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769013; x=1760373813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVFnz052bxUssLjPn/irFYLe8FvTO4x2oRG7kChOyXg=;
        b=mYfm8Zk0HBfFZ6+50Vg/Q77S3tdE2BDbSixWHnwLK3nvtF9zTo4+DfA1uDtSMvsCJe
         sd4Yajywpx4dAvdETu4vxIJV7rHBoJMYbJlqJuToVCeb9uFCIRrQQVGfH1K6ylgU9SCq
         9UhwPTLVEjCV3WP46hbWa5PTQseCbn1tnFtbfoaEjQhBxY6EStx59k9zNoGXjgxf3eh7
         iS0VLUdAt1uzHc0wNP7qgG/rVZBJqIg1uBu5HmXzOHXR+4TiXTzYhvUT6BuC7i+5Wx2y
         ZUXazbEO3YbfVtfcq/jwdrvfy357294hu4aYPrLTIjlfspiVgNQ/kXKGw8ZU13rzeg8A
         1nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769013; x=1760373813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVFnz052bxUssLjPn/irFYLe8FvTO4x2oRG7kChOyXg=;
        b=ZpsROQR2tuLEN502X+R4CHStZ6C16Pudg13npe2WMdHicn9JNEI9wozwyE40eWz0tY
         RX0U5eBa8C/WnsHEm7I7duwJl9QzIKwHXlRo3cXeyLQholoHJ+MRlo/99KZW24b9WKK8
         5+sSS+wtwWZwl0Zilep9d1vd9Apn+1uUimwHeUrCXoWSAiMtRsPOh96tSINiBULQ2QuM
         IoJaVzf8t2sQQVHWt+Z0JRFRee2wd/eDZHMoi9wAXkOrDpGgHqMbdcwas73GAy7Wo2dg
         8D9KRmK7G0YDeq2cx+HJ6VGxKRZZW8D/LAlNqhn9VZpFFYS/kx9lRQwwqbUfAqHtoJTx
         xbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo1YLpb8/ngx+uExKZ2bD8cINOz2cl5JdooC4rAmX9baWAkscfIybILSWyv6yVZMAFQnl7RhEpVWXeoMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hr2a2LrzOWBsEB2JcubD7Gfm2vGv/gFUsUlldpgk0FEPPXac
	t+lgzfnYaZ31/BQJ5QTyoLdTTeP/FTnHpNKFhjzKsQq2TR10pn+ajrwY9gjY5O2dXQ8=
X-Gm-Gg: ASbGncvWbYCYlTWkzwzXQW5NeM7bBSlH1yjx4czVOD4yGKUx8c0ytEbmnnwNi8YKDLC
	w/IXWJJ4WnMoZBhcsSCRUrOVFXW0uBxGh+QU1XdZNnq5GMzSu3u6Vthp9aav63ovgUKuQS0kuke
	eYZcMyg5E6vib6xt6yBqtkR1OKjYrxjEQxgOb4b8ch6H2sruobbn/AhW1ev95cGHtXRxERI4iPs
	to0DL9Ysxdb7ww9YqWWpbnE7sNyxutBzrT/t+ggioHXlG/TipwkhkL6+ELcN4+f+pX/YCH2sjMi
	LGv+58njBHT/8LAJW7xBzBzQmalwLy81hTmYY7vhBxOULpse9yHN86FnptNFKAJNRQkFSPfpym3
	lMVBSNcUaaRsDUO2uUThF5SJABD0xbpjwHZX5gNaULvmtf3A9v9FepabWB/EfG7+n0xKN796gVf
	llnBGfwaHlVse26aW2npfG5OauO/jKMw7PURY+epy8g4jR/A24tZQ=
X-Google-Smtp-Source: AGHT+IFsGub9LAc6/mBjGGGSdlVFrrBBzCQQUOCqnEH/i741mIaqZ3IINkZ5oqZ8jsa69BC1Q2QS0Q==
X-Received: by 2002:a17:907:3d9f:b0:b3e:b226:5bba with SMTP id a640c23a62f3a-b49c23431famr1629117766b.15.1759769012661;
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:35 +0100
Subject: [PATCH 09/10] pmdomain: samsung: use dev_err() instead of pr_err()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-9-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index c1b5830b2ad3e8b272dcc8ebc364be49aa7fda7c..06e1b0eaca18205a549c8e8136ee15279eb3089d 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,7 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	struct regmap *regmap;
+	struct device *dev;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 	u32 configuration_reg;
@@ -53,8 +54,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
-		pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
-		       domain->name, power_on ? "en" : "dis", err, val);
+		dev_err(pd->dev,
+			"Power domain %s %sable failed: %d (%#.2x)\n",
+			domain->name, power_on ? "en" : "dis", err, val);
 
 	return err;
 }
@@ -116,6 +118,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.51.0.618.g983fd99d29-goog


