Return-Path: <linux-kernel+bounces-731816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B9B059E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EF54E06D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0A2DE6E7;
	Tue, 15 Jul 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YR/YZDrC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9312CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582174; cv=none; b=O55JgtUZB/TLDLO02rNvL/+WRNgNH14OWOxaRap1ZKm3gmAsqMKQ0e28esxOAtvmIqpiKSgUbgvJQoYTkD9BJ+QSXmI1E2vOy04RYx6ypJ3eq/EWNedZDl5/y0PwNhBMj+IhWn/9G0xk/gRf6alGt5zbDvMXy1b+dwNcBukw6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582174; c=relaxed/simple;
	bh=00RUuzCKLbIW7xtJn4iVj55UNl8kTPANyqdSPOKAAY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eogtTYYNAogL0U9YXgFHcYVHEndfybVD0gBaTn/tD6RfxJ/t+61PJSDcWPtq9R6jRsdc+RFFl/l9WZbFCtZfHb4xV7AgkfCBSV7+J4Aqe09qy9vdK8uTAdorbaluViQo1rDbnFadv34C6USkiSK5JcWSBLse3TfQWYrqX0G6bpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YR/YZDrC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-456108bf94bso17321935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752582170; x=1753186970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmd/8SBDrA1Gb0C+zRAmJUhYPy6kVSRJonEW9B5eq80=;
        b=YR/YZDrCfcd7Quykeb0WJ/8zbaNm6Lp9CLxANb9ywOP/QHzw9Pq/yY+7wWWCMr7oVj
         OCPFnIJoAYb+aMQoCFoYWQKa2rcEJhwaDU2KVk5WIXkAu58cwtr1p/x+Hu1xTqrZoA7D
         7EZ1yyEJ+8SHbIn63wDgyMYZVWUcRQHm0LnX4MDFjgDirwhqvV2FwQa0JChbbGyKmO3h
         5n83JTCrJ653kAHV5S30jAzaimxizFYtFm1kSsiiAS4TnuyE8QdfT+/8Jy9GRAFSq6cO
         zQWjR/N3qP7XCpETYaEfVWH5tMVJPfy3kjn3rtHELPB1KRJoxH/uXpUDoHO8N7LJW4eH
         DwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582170; x=1753186970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmd/8SBDrA1Gb0C+zRAmJUhYPy6kVSRJonEW9B5eq80=;
        b=rWLQ0gc+kq7ZVfD8AyYqKLdXmAvc3pHuWSB381hZVpSqF01eGxeCAoBaSvKU+1KwUw
         CvMEOB/ft04rlVtKU9I0WV6bCe2EwSKtq/zSNAOqzvZj/kqRmovPXWg+eOd+Psgq7bM6
         67A5jlNyFmE7if3hmQ73i97l6+n5yCz5GfST8LNZsUQzMI3wJLvtnuvOfijFtuYh/lJN
         wiNtlyRy8gmhi6LYF/hLzOlANVirXyAkYiho8XsKk4kU9j9tj4UON6yY9egdN8/hmI68
         tw6rOZXQjgdZg3TmNxiJEov3Oo6wxw6Z1V7jzxOS/o5bCf3e6gno+dLVrOh/PCUdPss7
         85Ww==
X-Gm-Message-State: AOJu0YyNkXjJgdrcYdctPMcRvfGx8FbbYZ7lcIG0ZH8lChBJOKAv6sCc
	pCBzL9je0w5nNowx9czIwAPewmpDhmvhNCE4XVxTkLGe8+xNg1aAUfLJD7AJSlgFpSkpDfBdxM+
	1KnUW
X-Gm-Gg: ASbGnct/Y8tkWWWXFu4Dw62epWyoEe6VeLX+Jp6bPMMlVeFUj9P9eqal9xzOhCD67cl
	JnJdxjHb+FZwixI4Ic303qc6fjanXdCRXwebQmNyGDVPmrq5LN72lsipiyMmmqCRu87vWZ7PU/h
	gM/aBCKQtcgy3TibYbWVmRsKdBa+/i1yTKK1ypAKguhNEMenrxHQjMUZSpCv568BurGR17hIk9D
	hXdIXQ8H+wFrsrNjtb8NcXzAuQ5ZWAf67LbLX3IlUNOwwJOMyxZB4bP71iHnbftyRaeP/B44WBU
	P4RKW6U7zqwcMXPuJC6zSNHE+DYu3kS1RjadEXGAI3hIJLUkKvebB+MRk6LHT5COwzqL2p3qik+
	BNLdkZf96wupu6xhT1ZjyHOaoPad9Lb3YdalWrKsSybKZXiIaT9y+/eKjCuw=
X-Google-Smtp-Source: AGHT+IGMRtiWeYVCYMElfz61z1ti+Ou58MocKqgLTppI7XTuQyjsyQV8LFvTq6sg4P0VQ4QxNtmmjw==
X-Received: by 2002:a05:600c:4f52:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-454ec14677bmr165238895e9.9.1752582170249;
        Tue, 15 Jul 2025 05:22:50 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537785sm162850685e9.23.2025.07.15.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:22:49 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	willmcvicker@google.com
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH] clocksource/drivers/exynos_mct: Fix section mismatch from the module conversion
Date: Tue, 15 Jul 2025 14:18:33 +0200
Message-ID: <20250715121834.2059191-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620181719.1399856-6-willmcvicker@google.com>
References: <20250620181719.1399856-6-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function register_current_timer_delay() when compiling on ARM32
fails with a section mismatch. That is resulting from the module
conversion where the function exynos4_clocksource_init() is called
from mct_init_dt(). This one had its __init annotation removed to for
the module loading.

Fix this by adding the __init_or_module annotation for the functions:
 - mct_init_dt()
 - mct_init_spi()
 - mct_init_dt()

Compiled on ARM32 + MODULES=no, ARM64 + MODULES=yes, ARM64 +
MODULES=no

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5075ebe052a7..80d263ee046d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -657,7 +657,7 @@ static int exynos4_timer_interrupts(struct device_node *np,
 	return err;
 }
 
-static int mct_init_dt(struct device_node *np, unsigned int int_type)
+static __init_or_module int mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] = {0};
@@ -705,12 +705,12 @@ static int mct_init_dt(struct device_node *np, unsigned int int_type)
 	return exynos4_clockevent_init();
 }
 
-static int mct_init_spi(struct device_node *np)
+static __init_or_module int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
 
-static int mct_init_ppi(struct device_node *np)
+static __init_or_module int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-- 
2.43.0


