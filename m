Return-Path: <linux-kernel+bounces-792985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B2BB3CB33
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B84A03B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA836124;
	Sat, 30 Aug 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUblsaSL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE648223DD6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560374; cv=none; b=Nf0lGX/PL0qwVdMUNBuDivl6ur9Y2B+Qj/qX1Z5h+B1ppEaQlUNnw0teT9R9qHFV63nNlxf28yD061YOXxuKbxi+qsPy5FWHONHaeq9OQq/vCRQn8iHHwY8peUeCdbeG1u2v4nJ+Q1QO2VEgkpK6cAPZtb5fK++gX8GZJwDEGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560374; c=relaxed/simple;
	bh=Jne1QJWkeU+oLym35AseBFFlEqx8sHlGVdUYoe5lJTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJDLYWW5R4dWqvMw9PAn2aeaOGV/SqKnaS65fmfXjtLJcs7tSuQOnHwxnIxA5fdoysHltrkmjnvXYj28UnDG1YVDlLsgM7Vbkw7kOlymP7S0hSxyUbcmg4kKgD/A0Gxua9Ed67qMaVdjLvxhMWaoevtmOeImMvkw86AJP77TuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JUblsaSL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cbf01e472so523352a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756560371; x=1757165171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLIWEM2t+8glT4/c6dR+SAAi6xj6yMZpKE6lDz4PBBg=;
        b=JUblsaSLl7gCBZwegCspJXxpMjTbZeM25b7OvO/mZClkMaemMvItarmKu5pNAV61Wd
         AHj2hDUsbHLaX7vgCIYjM4l39BKuyJtwqAHULHtnFopbuXfK9RdfGUT+8E2S/rn2MnsL
         GwonRTzGCvvBa2XX06v4iePrEfmeLl0p6PpHupKX618KXKGr3zlfSuqhzMeyedBzs/Gv
         2PdTGu1zfI8L7LVzH7Mut0Sw5+IjYZs32WL/9zC6d8643EIyawiH6boUN7CCkqiDgats
         /6y6Ye7dJ6haKfnS4OkopEcF1MfqH7MHrytYF8lsMi2QccxKrZ3BpTwO02jIRZEPIv3j
         gEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560371; x=1757165171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLIWEM2t+8glT4/c6dR+SAAi6xj6yMZpKE6lDz4PBBg=;
        b=cVJi6HZ16k9Fh3BWLXKcRS3UrmSspLx/hvuToZXwTWCDxB2QLeZeiTlCj3ZK5jeakd
         +B92zksUGfNoEQfENS8pkUMwu80HhKSrWMnxU2DEr9jM28MsSMBFTAddHhd+GFI8NdVn
         24IRpIvczB8M/Cq4CPvTL2mxbs7RJmAl5ReTP07mxplSmbVrfwTnftPJ+xXy9IOBI2eo
         3mlMgw2USk19RatBDmvZTpTvf3REVSLzZA2STQWRkSKT3BRiQz52UGNc973XbZ8McNGO
         iVLwzPs6BbwqYh40eegz1OebNkMJdlDT00Jl1iDNVwZdL7a8jgb7kI8zPVTe1a11pORJ
         9tng==
X-Forwarded-Encrypted: i=1; AJvYcCWpb3uDTljFD0of4h/5qHqYyvvEEyfdsVfUYy0OgSNxkdQsPSYWLA1bydXfhn8wtTyaE5Pg4NCxlH2Wh/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXzAfx+4ZdPpd2enwEvoJfkrZX9rtGuTE23aBRHYPjboqwbhc
	jl2XD2vEaOhjoRvQpq3E0Fpgt6rcn4hAJWX8WWXq7wvL04pXdY4JmGV64uYFlU7ni+g=
X-Gm-Gg: ASbGncv8ERV86p2FX1q7XlWxLAUvyJGwZmXLpVJlS5XJp3jX+1q0kTUHGPfaW5CqIpb
	74e9BsHfGgDJnhE/vhTarGRPMAuH+vII7/x8W7G+HcmVDgdip8FgEfgh1pvWTJd201PeHVFX2vb
	/FDpkguebqN9ouhuHXvaQFBhREOpHlMeAGjrArk4y4r+uQAGqq+KG+9aQ0SWzmji+aqxVOb7lv1
	AZwH3Zv2ymxMzMNrGtZadxgxuJHwpjc26yyOqKcg56NOJasVYs+m06bWjEfDVb95pFuYOBr0fxH
	bhN/8aeRC5BlugdaN33PmY8AQGeRecm+XWcursIhqQYvtxM2NVE3nSISb5Kk+xG+icXDayqoXmM
	Fe+Y27F4zlpBjzwbf2BD8PvN4BvAaXfn8jgUPQdxUrbCB
X-Google-Smtp-Source: AGHT+IGKl3kqYaSwQPUyHhXqMbxZUrLqH93jZVeI0k79WyXt2qIL7Rke4+gSMVRK+QckLh09LkMgFA==
X-Received: by 2002:a17:907:1c9f:b0:afe:d028:ebf5 with SMTP id a640c23a62f3a-aff0f0207fbmr198830966b.5.1756560371113;
        Sat, 30 Aug 2025 06:26:11 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff3dd9574fsm225212366b.84.2025.08.30.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:26:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] spi: s3c64xx: Drop S3C2443
Date: Sat, 30 Aug 2025 15:26:06 +0200
Message-ID: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Jne1QJWkeU+oLym35AseBFFlEqx8sHlGVdUYoe5lJTQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosvvtHBDqzIYGJh932/9vhOHyjdU23V6AcUQ5t
 Pt97iK+3PKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLL77QAKCRDBN2bmhouD
 1582D/4018tDCkEZ7Uj52wpb+bjyEhAWEFbJB2Zz+Inn/BXhJevzJn16OcMptyUw+hmj9v+HF+k
 3HYxAi1SfV0+KY9YYMPKYanM7eTMYJfY0jglX0Oc7hD/gPbezMWu5ORVrEF28UtpNhCZA0kS8As
 6Cv/tacdw1hOmeyJUcBSLnCLSMLAZZSShlwUVTlp/UFQ7gkPHhRj1iXlLsKd/f/NvC220Adp/y4
 l2dHKNrK3ubpbHGZ3LAOoutKYB15d9kK3Ow4asxeyAtDDNsXNaPwz9w3wWEsDLLqfpXTb8TTvvg
 aDDhwIeulfzSXK8DayTW1am8pEFoAxxNfXJINPirEEIGF9NbwXZ/i+u94VW9OYDD/F6ESVNFqFP
 +T6KIZODOcLdcM9LVzYoppJFoicskYF9Xa6q1Qnm/OwqhfoanlOuqYjntasTeRrTk6p7iIQVrk8
 0msVDtGW4O63pzGHRTBhcU/XtSqWrFTIx+uXvDd8hqW1rfanqOuKAv+vQg1AOPtnFvdPv7jv6xa
 nlqRsDvT1ZivvAkI8BS+2UQpE0vJhLKm9LVqbYPtiipaT8Q45l4TYqVa9IVxQiIBzdIznwDBqMf
 NUbn9OydpQOG1fqRlc2+p8J9Ssu5rjZ6HQog9Oswfx/hsl/EYuwH35264vSh27TaPhvjM2uIGYj XmFdZA71pqkM9Sg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles or
platform data ID.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3a00f9e480c5..aab36c779c06 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1506,16 +1506,6 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 			   s3c64xx_spi_runtime_resume, NULL)
 };
 
-static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
-	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
-	.fifo_lvl_mask	= { 0x7f },
-	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
-	.rx_lvl_offset	= 13,
-	.tx_st_done	= 21,
-	.clk_div	= 2,
-	.high_speed	= true,
-};
-
 static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
@@ -1627,9 +1617,6 @@ static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
 
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
-		.name		= "s3c2443-spi",
-		.driver_data	= (kernel_ulong_t)&s3c2443_spi_port_config,
-	}, {
 		.name		= "s3c6410-spi",
 		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
 	},
@@ -1641,9 +1628,6 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "google,gs101-spi",
 			.data = &gs101_spi_port_config,
 	},
-	{ .compatible = "samsung,s3c2443-spi",
-			.data = &s3c2443_spi_port_config,
-	},
 	{ .compatible = "samsung,s3c6410-spi",
 			.data = &s3c6410_spi_port_config,
 	},
-- 
2.48.1


