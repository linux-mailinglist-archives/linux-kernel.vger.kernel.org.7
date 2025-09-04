Return-Path: <linux-kernel+bounces-801160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CEBB440B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49483BFCC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735372641FB;
	Thu,  4 Sep 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvVqsOFs"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC424677A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999961; cv=none; b=sBjpU1SN1CIL8K3WDUa252SbDPnXhBMGolT3qpOaB/oZ64J3EF2VUj7zQci1wpQyCRdz1aCkXwXfOSZb6end3dPQXpwGbGMU7osaue0Fni0st8hokK912wgjFOjV8MCNERPCEKPMTLFOf4T+nExUezcKTbvfk7CnRBfvZySiK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999961; c=relaxed/simple;
	bh=ZovBSTg3+nS4gEH8MquKWObavniQvrJ/CjBnS51s8KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RGxgnMouT09GklX/+aw4zRvxTzHzbc0IKxIa0eCUx/X3jFyQA6x/N6GCTDoWWwFuC4eIf0GEOYikhoLBFDkzyFi2zPCDK7ZNSF1/lI4bE+UsYjHv3TLjcP4oi1chUVZaZAAh6V8WFMfeNIQVKpLuEx1/Yyi21H7D7sUQWJ3IKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VvVqsOFs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cf991e8bb8so853131f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756999958; x=1757604758; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcywffTAPMM3Aelnx79fSslBG214GVPApnPBoT9pItY=;
        b=VvVqsOFsw4FhfJfUTUhrpMFZwyUD3VALHXx/evw4+b0s3PyjsnNwdLexWrIsF55abi
         eYaBi1/R4gvs+4tXLGW9m2gw6Tpcnbx0TLW5s9Fh+z0050jwj9Xwup8YfpL0y3nlhIdM
         71EovvnS7OZbduE0HWOieftFGnyzG8Zrg83IUbNd+ME0C9CiOlKQtLqeYhnub3uWe9vK
         th3D+yYvWheYaKcsMI+2rGYW9eWK4bAvfMsMMMBbDpfx8Zq3Cq9htoYmYH9oOUBFaxof
         LFKdrg5kpF6jvXiooY/JpdBIDhSsDdv4Rn0q1VtLlA1N1weAr3RPkTa32MXc4EdkQ0G8
         Q7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756999958; x=1757604758;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcywffTAPMM3Aelnx79fSslBG214GVPApnPBoT9pItY=;
        b=LCF+F0skQyAS/jiU/gKmEpwdsYxmVswM8AKfWnrWkBY8/SEMP5qABPsMwjWdS7gsZW
         unLXrRv1TGsZmglFcQJe6NIjDTR1p1kQldZKMJrmWlXUAnCQ2ZMFqmvv9JpSsllQVR8U
         nCSQZnJAA1Ld9Sv9erzmW9dqbu8oWOGIAS0PPUB+e1o+QAEX2iQHEJFDTSKKzICPa9iS
         QTkgmZ3FvoZzEUEG27Bdd2oxhIb/lJDUe1eW+E/hph2juIU+pUfyoTX9K9qXFn9Y5pbk
         RJf2e2fBgDrxBW0JcvomPjyXN8PoAfIXHlayO3PVFU+xvcQ2S7elJ75UbjJ8/BlMltRH
         9tow==
X-Gm-Message-State: AOJu0YzMpCid4a3DAKfersoy8e3PYXoNTeLYkqEocV3WA4SJFvSootvh
	LtMr4ymm78lcNaSOh3RGNajYTS54qoq7V/xwFqv4TfojgMdtt3Dq+O4lWgnOJzTtmf4=
X-Gm-Gg: ASbGncvM+Vr2KJwlzTknzzTWuVZFxIMnBwFI3nPgPCdLdtSpGI2vc//VJjDik7d9SQH
	qZQdBej8n5mefjSaJZ+QjanXabFqex/B0SvLlCeWWkwnUrbiuxy0gzLhcmdnpIn9tINbjDUOsB1
	aMhzC5JJKjceGg6KKvCzyKonmswv93/hTfr7Bz8V1z1mUs3R64LVPILf8knCPLxJkRtF6zM/eEm
	PNsSLjvDORA928yKpBZnx3YXihlH2AXVya7ngJ4OSWz0pwMbS4ILAvei3crWhwECYrH1lowSiaU
	7PFtDo66hl8mCplUNipqsMb43LOUz0Y8MgXGhV/w8+77q07AvACU4W91SWiwJf4KgcgjrUhSTZt
	4Jzu8RNZOncx6O8KfQy00+j7afKWvfWcdtVd9DOOt7KtlRxosKFc=
X-Google-Smtp-Source: AGHT+IEOK+thU4lBF9QkvDsW3QAK6jUHRnRYoVFlARXInUUOYeTnV9kbJl8HLIspvAB0lbR2Tb1UIQ==
X-Received: by 2002:a05:6000:2886:b0:3e0:b982:ca5a with SMTP id ffacd0b85a97d-3e0b982cf37mr3073696f8f.5.1756999958082;
        Thu, 04 Sep 2025 08:32:38 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([150.228.9.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm27889919f8f.61.2025.09.04.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:32:37 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 04 Sep 2025 16:32:29 +0100
Subject: [PATCH] clocksource/drivers/exynos_mct: only use IRQF_PERCPU flag
 on ARM64 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-exynos-mct-arm32-cpuhp-regression-v1-1-5d9e4dd356ab@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAyxuWgC/x2NwQ6CMBAFf4Xs2U3aUg74K8ZDUx+wB0qzqwZD+
 HerxznMzEEGFRhdu4MUbzHZSgN/6SgvqcxgeTSm4MLgRhcZ+6dsxmt+ctK1D5zra6msmBX2s9n
 HqQ8eMQ2jp9apikn2/+N2P88vx6ou3XMAAAA=
X-Change-ID: 20250904-exynos-mct-arm32-cpuhp-regression-14f321e4a591
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Ingo Molnar <mingo@kernel.org>, 
 Hosung Kim <hosung0.kim@samsung.com>, 
 Will McVicker <willmcvicker@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 John Stultz <jstultz@google.com>, kernel-team@android.com, 
 youngmin.nam@samsung.com, hoony.yu@samsung.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=ZovBSTg3+nS4gEH8MquKWObavniQvrJ/CjBnS51s8KU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBoubEU/E74sQgeTf+abf8JCGdjferSkVZiIA4BB
 SPYJAGILouJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaLmxFAAKCRDO6LjWAjRy
 uhFYEACRe7uggDyXQmWDb08QOlfPW3pieYUctnlx1bnlUd8qsbJmBmdwTnLUvDmX7bUGx08DvCm
 UOxqkOZD/FTTCfIXx9DVZKsUYEWQnlevCSJDINtIFSLakExB+yNXfTz7BQ2g7aEOlFVv96CpDg3
 7BNqnTNsy3K6awhvLIkow2aNwNAgBoX5HnQig4WTbchmFO7SGPkqIOLo7oWqhRidAY7S38TqeBS
 t1jL8vFaZpl+TovAbn0tkMzdSM9ynUFKHfPXQpG6pW78cjfLvSPSJNrZK6FWAfhcfEkdUP565FF
 UZKi1k9ZHrAqAkgMdTnPCIdXJc2RbbkCGzZf0I8+4EBS1zzO6+DeJArO4lJjDqpHkbeMoTDfxj5
 3gitcgPJ4M8XOLLegJdppIPn2VysPWxxqMeNSHfZfpAZZ2Mu0wXx58jTA/fFRf728CJcV8Op3Xh
 PWXwrdtN58YsmVBiZNY9VQn/ryGRcHyEklwMtdSjx+xNPtUO/hG0BeNxZHjaW49OD2f1lyQOFbu
 bw71aQ1JoA3GJZuKXZuvG6TPGk2NZU9nzBNIEhPugDhqsHGsDA0IdqD6VlZe5CDsjNh0LD/kr0r
 nLY/g3nGIphqaXwDoJc9GcsEkg2qDlp9nryDfIVUYt8NUdpwBiUegQZVM6uOX+sfme/Iykiey8w
 vtuTK3l+nGVzpzw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

This patch addresses a regression reported in [1] whereby CPU hotplug now
fails on little CPUs (for reasons that aren't fully understood) for Arm
32bit platforms such as Exynos 5422 used in OdroidXU3/XU4 boards.

Note: This patch makes an assumption that the exynos_mct driver is only
used on Arm 32/64 bit SoCs.

Fixes: f3cec54ee3bf ("clocksource/drivers/exynos_mct: Set local timer interrupts as percpu")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/lkml/8c861182-7e90-4bbf-ac04-173d59f5af69@samsung.com/
Link: https://lore.kernel.org/lkml/8c861182-7e90-4bbf-ac04-173d59f5af69@samsung.com/ [1]
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Hi Marek & Krzysztof,
    
Can you test this patch on your Exynos5422 based boards and see if it
resolves the issue Marek reported of CPU hot plug failing on the little
cores of Exynos 5422 based boards?

Unfortunately I only have gs101 based Exynos hardware (which is Arm 64 bit
SoC) to test on. I can confirm CPU hotplug is functional on the little
cluster CPUs with IRQF_PERCPU flag on Pixel6/gs101 though.

Thanks,

Peter
---
---
 drivers/clocksource/exynos_mct.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 62febeb4e1decec7f5db104db395884824563915..91d79b73a96a7e8a354d803c2b497bcde92af8d8 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -532,6 +532,16 @@ static int __init exynos4_timer_resources(struct device_node *np)
 	return 0;
 }
 
+/*
+ * For reasons that aren't fully understood IRQF_PERCPU breaks CPU hotplug on
+ * little cores of ARM 32 bit SoCs like Exynos5422 used in OdroidXU3/4 boards.
+ */
+#if defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#define MCT_IRQ_FLAGS (IRQF_TIMER | IRQF_NOBALANCING | IRQF_PERCPU)
+#elif defined(CONFIG_ARM)
+#define MCT_IRQ_FLAGS (IRQF_TIMER | IRQF_NOBALANCING)
+#endif
+
 /**
  * exynos4_timer_interrupts - initialize MCT interrupts
  * @np: device node for MCT
@@ -602,8 +612,7 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
 					exynos4_mct_tick_isr,
-					IRQF_TIMER | IRQF_NOBALANCING |
-					IRQF_PERCPU,
+					MCT_IRQ_FLAGS,
 					pcpu_mevt->name, pcpu_mevt)) {
 				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
 									cpu);

---
base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
change-id: 20250904-exynos-mct-arm32-cpuhp-regression-14f321e4a591

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


