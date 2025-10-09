Return-Path: <linux-kernel+bounces-846549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DDFBC850D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77FC3A7A34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F052D738A;
	Thu,  9 Oct 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0z5bjfD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095025A2A7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002292; cv=none; b=k0AkyHnVyajdUBOvHN4jk5/AuE0GpPEdSYZFabrUUDK+fwadi1Zp9dyfIvQ/peywuOpqfpOvDG6ebx7X9JqVP+cN7lr7+dErJMzYrOC8zSOWaAex4RQGRW8PWe02C76yhWmpJPPKvHTFlHeAv/d1Fl5G6CGZEG0657eyuTbCgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002292; c=relaxed/simple;
	bh=hKOEli3CC73LXpkDN7O8qVN57wG2tCN4yTStwZ9/NHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkz6gosQoGS641rlISj17tGxpMpNpEfCZdV1ykDK9/nq65hfjk5U3RWvfkPrrTQHXyYrfOsTZtg7BMMmsBDebjuNgFhyLWCwf3jzVOluPIhr8cgV4mshcWgqbbh3ejfYebmw9gdKqlRYMoK2gtkq+OgPKOa/SU9o7zEbp0Vsdpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0z5bjfD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b463f986f80so160942166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760002289; x=1760607089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnZwMqT5Z3k14agLqjdrnk3P1X+gmQLWShTQkVnycRg=;
        b=D0z5bjfDliu8g4EhGn4bSHYCWp3rVKEfBBSALdlcM0UOx4ExOP7hiIlyxCy0sPZW2P
         dmkUwlYwaClktyuiDJ6SSPhQMA+NYL2pyMl1gpeqtgJq9qLO6l72arR+z3o45PQjrWaa
         sqiAdauwAOeKfFSAvHwyJ71w3N5zqEmzN8szTr73+SNTHc+iJXgQ4r5vsBuJS6ArCI6I
         4Zadfe8kG5V6GouuY1qejaHXwr71LCKBIJnt/eubENdb91eGZqx0dLtI2msFrLbg9HWi
         zddCa7o0czD6DjgGoqllumsV310zxiw8NmTDkOJ+DVlpVfq9ox3UG1QbBaMdYQCXXLrx
         quiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002289; x=1760607089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnZwMqT5Z3k14agLqjdrnk3P1X+gmQLWShTQkVnycRg=;
        b=D0MYPUbS+pq/qfCnyOxDUVgRvBDo+MK14qXMvOs/oarJtE8TXzGfFKqQBMjKvoTCtd
         6u7pPyxPL3wGodSdFiBZosnJfthfGbXiprbEJ37t5riBV8dXZCsMX4K1ipadPYHiCI97
         izfIWjTnLAPPBM8YcKD2g742QcvWAw7i/3+lsXX0uvbNqR+FSisWH1BGbp0ksmx3YK9Z
         FSjEWd1td12pTqJP/Dky/itQ52flOt9BQH0FwYiwcZWrw693exZxedwBvoP7NwGnLKYg
         92N4OLd6hzFHDdzn9HUaYlhBVx9ktkOshpYmvD9rGyo5IqatNXC35Ho3cpUrknwjDfr0
         1lXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk5niJwKh7v0SJ7iIvji5+hf5frqixJ/BXfuK8q8f6wBUTBN1gahPHMBsA5SPLSotpFHBHAnwXeECFE0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8p1ItfjNoEQypW9rigAz3QmMrYNDwCP+0lUR0zMHpu6M3iiQ
	yhivqg7Ea57PI46Lrh7FcWBDPw42MgYMY2IlBi0S2OQ6mYyaM5YkPeH+8rDFbh6zt6Y=
X-Gm-Gg: ASbGncsOsvUkeIm6OvW3egaOnBGtIX1GEj3aWplAGrx3UNqb9yz9yqpwKEN/uZiRD7i
	N3S6pkv+LJkBZitbosC3w03pjNVto8ielKWcduJ3y51IneGJvWvsOV4hrfnj9HVDMsXQD4FlShz
	9wWWfxyxg9dTSJee551vNEEgG4FtwitK560HaQ6q5kGbihDQiSYw7xUwb5XAUX5MKz04AW9EjKI
	w71xddPLBwkWA8C4mlPesSiNSciXIh8KGlEPgWvsx/B+Z8zmcfLXf6NQVx1AfOoKKGvUynx2CFs
	I4ov9RNNWf4IOvew+fFChNI9MNB84c+NO6gvQPEZtUQB38q0oZLu6jsTmUjq4uxKij7VUvBMqCi
	ERM0/+2O8OGpQlQmoGfatMwOVK71Relu7Hi5duF29eIgE+scWqTOD2LgnxwcFaPBBD8od2AZBls
	37Dmw788SoJ7BwFOtgGb6pNitCPsMCIj5PtQeG75JO
X-Google-Smtp-Source: AGHT+IHA+lPS2DUQCATgDgIURdRFlX3C6OKochIcH8ifOEzHHA6ifhQXJjqURM+gkgnfCzyEiDrXWQ==
X-Received: by 2002:a17:907:94d0:b0:b04:7232:3e97 with SMTP id a640c23a62f3a-b50aa3921edmr743792266b.21.1760002289304;
        Thu, 09 Oct 2025 02:31:29 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173a41sm1855670766b.87.2025.10.09.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:31:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 10:31:25 +0100
Subject: [PATCH v2 1/3] soc: samsung: exynos-pmu: allow specifying read &
 write access tables for secure regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pmu-regmap-tables-v2-1-2d64f5261952@linaro.org>
References: <20251009-gs101-pmu-regmap-tables-v2-0-2d64f5261952@linaro.org>
In-Reply-To: <20251009-gs101-pmu-regmap-tables-v2-0-2d64f5261952@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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
used on creation of the secure regmap by adding respective fields to
struct exynos_pmu_data. Also add kerneldoc to same struct while
updating it.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* add regmap_access_table forward declaration (Sam)
* add kerneldoc for struct exynos_pmu_data (Sam)

The regmap_access_table forward declaration declaration triggers a
checkpatch warning: 'struct regmap_access_table should normally be
const'. In this case, it's just a forware declaration and the warning
can be ignored.
---
 drivers/soc/samsung/exynos-pmu.c |  3 +++
 drivers/soc/samsung/exynos-pmu.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 0938bb4fe15f439e2d8bddeec51b6077e79a7e84..1658a55fe61c6fe70cc4cb0fcdcea2756096a268 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -13,11 +13,38 @@
 
 #define PMU_TABLE_END	(-1U)
 
+struct regmap_access_table;
+
 struct exynos_pmu_conf {
 	unsigned int offset;
 	u8 val[NUM_SYS_POWERDOWN];
 };
 
+/**
+ * struct exynos_pmu_data - of_device_id (match) data
+ *
+ * @pmu_config: Optional table detailing register writes for target system
+ *              states: SYS_AFTR, SYS_LPA, SYS_SLEEP.
+ * @pmu_config_extra: Optional secondary table detailing additional register
+ *                    writes for target system states: SYS_AFTR, SYS_LPA,
+ *                    SYS_SLEEP.
+ * @pmu_secure: Whether or not PMU register writes need to be done via SMC call.
+ * @pmu_cpuhp: Whether or not extra handling is required for CPU hotplug and
+ *             CPUidle outside of standard PSCI calls, due to non-compliant
+ *             firmware.
+ * @pmu_init: Optional init function.
+ * @powerdown_conf: Optional callback before entering target system states:
+ *                  SYS_AFTR, SYS_LPA, SYS_SLEEP. This will be invoked before
+ *                  the registers from @pmu_config are written.
+ * @powerdown_conf_extra: Optional secondary callback before entering
+ *                        target system states: SYS_AFTR, SYS_LPA, SYS_SLEEP.
+ *                        This will be invoked after @pmu_config registers have
+ *                        been written.
+ * @rd_table: A table of readable register ranges in case a custom regmap is
+ *            used (i.e. when @pmu_secure is @true).
+ * @wr_table: A table of writable register ranges in case a custom regmap is
+ *            used (i.e. when @pmu_secure is @true).
+ */
 struct exynos_pmu_data {
 	const struct exynos_pmu_conf *pmu_config;
 	const struct exynos_pmu_conf *pmu_config_extra;
@@ -27,6 +54,9 @@ struct exynos_pmu_data {
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
 	void (*powerdown_conf_extra)(enum sys_powerdown);
+
+	const struct regmap_access_table *rd_table;
+	const struct regmap_access_table *wr_table;
 };
 
 extern void __iomem *pmu_base_addr;

-- 
2.51.0.710.ga91ca5db03-goog


