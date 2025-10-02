Return-Path: <linux-kernel+bounces-840129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2FBB3A28
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EB9192595F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEFD30B516;
	Thu,  2 Oct 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1XwFXll"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC952FC894
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401184; cv=none; b=iAdrV6zqOGrfZctAUljXQRcLAx19V2vFBdKWhvCaI8QaRW8jBPkn7ZiCc1P+1YIz/ju0FOlF7YYwG6FFoxcGryV48vIGNN19ZdzMawEvcxis3765ce/fcBEaA2aw/y5qU8VFVJI4RotW4I6A8XPP+Vn8i0i07ipn+n62PNozJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401184; c=relaxed/simple;
	bh=xEpx8/54dwpVe22rhqA4AJ561NK5g8oeHotTXzwy+7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cB0i/JvlD6KIXRxwskLIa0uU3F0dIgWkj9pVjCYecJjrHvmLRwBUajTtITJOTmEsQ6d4VyiE4JUOB6oMY+o7KAremRRvcc59qOJEb6Afbcn5/x9PNrVIsGI0mJBKb/jTUZWQT3TzOdLVMCIEG4KQZvMWHl0qtdCGsnYmXXToZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1XwFXll; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b48d8deaef9so75525166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759401180; x=1760005980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63qg0d8m1ZxWOzlA/0Gwqg93V/NGeUpYpl/r93eUFdc=;
        b=i1XwFXllV4vAn8UOLCe/p2XjGn2M8soSMN1aySBYFKYxeM1EQluBXFlkIkPapuuRHw
         T1vlcl3uuUTBQP/3uCkKqIWjDDZZjgLg7AZy1dGQ67dAc4XQ1nKXekpC8wGDmS6q22S8
         Df5T0Z+r7hk1TsajZCv2Y5SA4iV4CVdx4sjn+37GMVvt4mVB09IKtpbIV3F3REwHDCQj
         zldNfy2VQ/x+3h4JbFP1OSsbyAzZmk5PU+IHBYuRut2r3yiOywgzNtymRaydNnpfQ91O
         p71n7R38lmWY6A2/6Cr7oTTiNE6cREVmbn4EwdTYOCK9EeZVxrICuHT/J8cktcMC032j
         wM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759401180; x=1760005980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63qg0d8m1ZxWOzlA/0Gwqg93V/NGeUpYpl/r93eUFdc=;
        b=pE+jOPMc0nnmLfODezs52OlfDuPz9LUNJr44c0iQU7TiEbbUu0aJJUsrxhlZeR2hN+
         OEXOBFzCvtajwFzF4Bxcm6le5k76k/luGxdzWKJLhzJMheZL8NaLGQzFtLvMoEr8VL+L
         uQ11muGZIV+p+oY6h2P0vLGVuDCMVdGqoyAv3jcRXH2X/tDKFceH4+0dUHrv09DeChYb
         8pQZtmVl5L2ojc3UjJL5X2Ml51oDv6ptC2OW1UkTNx/qZ/oN+5O7n3qAM6jxwK1cSfN9
         ppSpMP0YZWjS2NEjp7z+FJ/MpL/NOtXCh5SK2oJiuVGqGfP1OshE2yIo2oTgLJreXVjh
         xh+A==
X-Forwarded-Encrypted: i=1; AJvYcCWNZlh7SL84ANX+wi2I9dVzjRzQvaYBrrRPe7gSaYkXcWTRIgooL+nc3vv14xJF7rcbPJfytfOaV96iNgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeAfo1ikA+6rT//+dKUwJ3WqKZac16ZSSTL7ubLmcqOLj5urz
	34IzN5QClFuUNtoKgXLRoQisZUqhIEHra5cEOghfWArqrvwyacAGEwjJSTzB3cMk+9U=
X-Gm-Gg: ASbGncsRaMJmn0WKSiIRvMb5iJKoHzDcyFyn50zNbfReUs6xzYImu3Dti6xsBgOAVoe
	2t3JX+n4u+ukNxwKhyfDhHIYUx72ZJIkmHtUJl31P7x9eCWh3t2z8a+JPtWaRie5Im09mL5ZxHX
	cIUWzdRwcNeQBjal50arIkh7yBTYVqwIjsSuzNJt0cfCz+gzH23JdQ8S05fDuLTUmh0WZL6ME0w
	aczTqNmgGfcSKUDwY9s86r4e2wsfjmqPD5SgfUrgHOrIiq2FJJxDX6PLqc4mQlyDXTPczAX/W3e
	kqwNWk3WPaKAl7mDbC7MazUEH3FgtPyYy9fzdPwEJBBLNcyzP5pSYz2d02ocnKIWtyz6QSgPM70
	kCc5uKUaswMOM6sEWblKS2SNIsy7DVsbQpAIzT2pqAo2/4TlCev9+wx2Ohs22hGGdnA/4Pt5sZL
	4Oc61SOSdXwobbNOn37oTTGaPTjLDPrNvgqbbcYp2R
X-Google-Smtp-Source: AGHT+IGxZCBahQVltdFOGvGloTZFkP3rum3vuta/+ZCokqpuSClzu28tF6ot9TrYBaOgogmM+n5Dvw==
X-Received: by 2002:a17:907:9446:b0:b04:3e43:eccc with SMTP id a640c23a62f3a-b46e632d6a2mr846196166b.40.1759401180048;
        Thu, 02 Oct 2025 03:33:00 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4871167172sm170262566b.65.2025.10.02.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:32:59 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 02 Oct 2025 11:32:57 +0100
Subject: [PATCH 1/3] soc: samsung: exynos-pmu: allow specifying read &
 write access tables for secure regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-gs101-pmu-regmap-tables-v1-1-1f96f0920eb3@linaro.org>
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
In-Reply-To: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Accessing non-existent PMU registers causes an SError, halting the
system.

regmap can help us with that by allowing to pass the list of valid
registers as part of the config during creation. When this driver
creates a new regmap itself rather than relying on
syscon_node_to_regmap(), it's therefore easily possible to hook in
custom access tables for valid read and write registers.

Specifying access tables avoids SErrors for invalid registers and
instead the regmap core can just return an error. Outside drivers, this
is also helpful when using debugfs to access the regmap.

Make it possible for drivers to specify read and write tables to be
used on creation of the secure regmap.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 3 +++
 drivers/soc/samsung/exynos-pmu.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 22c50ca2aa79bf1945255ee6cc7443d7309b2573..9f416de03610b1727d8cc77616e5c87e2525cc69 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -635,6 +635,9 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		pmu_regmcfg = regmap_smccfg;
 		pmu_regmcfg.max_register = resource_size(res) -
 					   pmu_regmcfg.reg_stride;
+		pmu_regmcfg.wr_table = pmu_context->pmu_data->wr_table;
+		pmu_regmcfg.rd_table = pmu_context->pmu_data->rd_table;
+
 		/* Need physical address for SMC call */
 		regmap = devm_regmap_init(dev, NULL,
 					  (void *)(uintptr_t)res->start,
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 0938bb4fe15f439e2d8bddeec51b6077e79a7e84..113149ed32c88a09b075be82050c26970e4c0620 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -27,6 +27,10 @@ struct exynos_pmu_data {
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
 	void (*powerdown_conf_extra)(enum sys_powerdown);
+
+	/* for the pmu_secure case */
+	const struct regmap_access_table *rd_table;
+	const struct regmap_access_table *wr_table;
 };
 
 extern void __iomem *pmu_base_addr;

-- 
2.51.0.618.g983fd99d29-goog


