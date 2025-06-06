Return-Path: <linux-kernel+bounces-675911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB83AD04AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880D417AFA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40928C021;
	Fri,  6 Jun 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1yAVPmC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474C28A414
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222207; cv=none; b=EgPiCWQsRfqzzCm9bJwzrX0WjJ3xA3HVEeVVikKsKFp14KVDQIt/+1UUNi2gK6MappmNY6ts8I9aVVqOWKhc2CqED2Lf2c4UThQCrgFVg1CGfd3HfdjOsy19n4UVg8ylYGeGeqSZHUvID6c0BoBLgB8kKhBsqgm2RzaGGh1X48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222207; c=relaxed/simple;
	bh=DtlBkmeFf9pjAxGCgmCN5Tg4/h2onm9CJStRVS1CP9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVSkaHCDPGECoMh9asZRB4YhqXK30MTmL7zRiD3FeYGG5f79nn1NSpsuRQP56mzUxk7ZK7VceavklDUL//AoNwRnOmbGYnLUN+6EvR4WUSXSt1pocGkibTVKoD6KzZTnOEDvSYS/EKWKBZGcPb4EZNTDWDRUcFYDRysNATCLh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B1yAVPmC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad1b94382b8so367705766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749222201; x=1749827001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7btE5VBq3UbP0k1jf4CzhHOohoUdya+2IgQP8EiGSvc=;
        b=B1yAVPmCn7q80Q46pfamFbOoJ/Hh3nPHnt3sW6UK+hbaCn70FYvVqGxYPoIcq+Cv/C
         FofI2H87hL+DOeqtIOhYILkDcYNu9icRb09QWVkFjlgeeGHfSbnMBhFBGMsN8D+Qgdmx
         porGVnj66Ijd/CFoFCjag2xQjx8J6s14mcWmXV8X7PzWPdzhzyrK+/jNizM31gpmnDAw
         2ppdkyJbG0rNGnzOh+YRp92rR21n4C6z+/xapj50CPj9CyvaW78DbkEB6C62tgPMJHX6
         KUMAEspgBxTlwCq6e2FlzHtYfk6Njhwt8UrR1uJ4yUzZgcJBwfcZ/KZ7Jbn96nfsNRP9
         Y68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222201; x=1749827001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7btE5VBq3UbP0k1jf4CzhHOohoUdya+2IgQP8EiGSvc=;
        b=mVoy1e/HoWLBVExubA53IMHg2JBb2RBJwux8QG4KsSpAnn++YyK69JF65j+pRNSF5r
         szzTP00eAYIUy4vtbyKDdAmrlGiE205EHx1rw7HAIfFasy2QwTP+skR6t1h2fSPjf2g/
         mBzxLCvJSotzYDVo2GG8/B5JjgNZMkhgHTrcKWf/rOs9h3SRJhSq/YRb3sjqDc/p1Nqn
         ofD3GrUKgBQHKm+Wfq68jaE3Dvi5b/5vyNRm1McxtMHKwX//jQqWVYcRJtXgnntNX3XQ
         Uyi6Q8Apklm+em/XNHts43kvxYRymkokRRzxK03kRwB3nBE9EkB6moy5AGGkJvCqWlZd
         a0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ENgpM3jiR5icu9Cx8zZ/38WvSok2IKcXUDXFQmnsANeGC2zMDWpret92Ys97IxFkh/2EaEbF98QuoEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLc2rBpt4FX3Wt6eYFqlqTQJV+3yLVKnIIwGoCUokNPJilXhc
	1C/wsRGd7o5dFm7FPalojTsCTg6ehVANYh7+ElP18AUNm0xkdlGElPyCA8pLMhzy5kY=
X-Gm-Gg: ASbGncuFAHpqSncAHK0zzuW0mktvsWX2YZen3k1fHaOu3gN7jc2B0rEUsOGvZ7g+sAL
	xUK26Hbdivf5ktTAlZJMHjLOowg7JfJ3+T8e3vuaGcfH0haXpP0gf15A+Nb0dcaB34GjObozf79
	J55KpFG095UJPfc8ht0uiYaWmG2n2veqLh8N9RVbvK67ynV8h1thseBD2cphiFscgdRqs6u9f3z
	PaKSod50NdCtcQJYKmWHR0/W5dWzkh02X8P5gp32Wcmz1HOFvw+CPyvN87Hfh4sCXO6/zlNpYGC
	hxmWId0D3z+t1VxEZmTD1YyRj9lPjGXMsF6uYEknbyDvXFJMftIsYm73lTTjcknz4yBUBPnaPjd
	T5Cp2TIPCBa8nhiXPbompaMbFtjoCHF9mvS2qzFywthVc+A==
X-Google-Smtp-Source: AGHT+IGxnm6pBbHVIYIIe9hkMQ8JxTW7peP3cR4UL9qPSHSxqgc6/znfqj1QohdocTUC3/x18Pe/gQ==
X-Received: by 2002:a17:907:8694:b0:ad8:8529:4f73 with SMTP id a640c23a62f3a-ade1aa0e3e8mr353586166b.49.1749222199472;
        Fri, 06 Jun 2025 08:03:19 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc38cf2sm127735066b.121.2025.06.06.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:03:19 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Jun 2025 16:03:10 +0100
Subject: [PATCH v2 14/17] regulator: s2mps11: refactor S2MPG10
 ::set_voltage_time() for S2MPG11 reuse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-s2mpg1x-regulators-v2-14-b03feffd2621@linaro.org>
References: <20250606-s2mpg1x-regulators-v2-0-b03feffd2621@linaro.org>
In-Reply-To: <20250606-s2mpg1x-regulators-v2-0-b03feffd2621@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The upcoming S2MPG11 support needs a similar, but different version of
::set_voltage_time(). For S2MPG10, the downwards and upwards ramps for
a rail are at different offsets at the same bit positions, while for
S2MPG11 the ramps are at the same offset at different bit positions.

Refactor the existing version slightly to allow reuse.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 3f2993b96c3e54427f5c0af7bb045e2278daa671..76be81c75c898fddc9570a62a64da787bacad7d7 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -562,26 +562,23 @@ static int s2mpg10_regulator_buck_enable_time(struct regulator_dev *rdev)
 		+ DIV_ROUND_UP(curr_uV, s2mpg10_desc->enable_ramp_rate));
 }
 
-static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
-						   int old_uV, int new_uV)
+static int s2mpg1x_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
+						   int old_uV, int new_uV,
+						   unsigned int ramp_reg,
+						   unsigned int ramp_mask)
 {
-	unsigned int ramp_reg, ramp_sel, ramp_rate;
+	unsigned int ramp_sel, ramp_rate;
 	int ret;
 
 	if (old_uV == new_uV)
 		return 0;
 
-	ramp_reg = rdev->desc->ramp_reg;
-	if (old_uV > new_uV)
-		/* The downwards ramp is at a different offset. */
-		ramp_reg += S2MPG10_PMIC_DVS_RAMP4 - S2MPG10_PMIC_DVS_RAMP1;
-
 	ret = regmap_read(rdev->regmap, ramp_reg, &ramp_sel);
 	if (ret)
 		return ret;
 
-	ramp_sel &= rdev->desc->ramp_mask;
-	ramp_sel >>= ffs(rdev->desc->ramp_mask) - 1;
+	ramp_sel &= ramp_mask;
+	ramp_sel >>= ffs(ramp_mask) - 1;
 	if (ramp_sel >= rdev->desc->n_ramp_values ||
 	    !rdev->desc->ramp_delay_table)
 		return -EINVAL;
@@ -591,6 +588,21 @@ static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
 	return DIV_ROUND_UP(abs(new_uV - old_uV), ramp_rate);
 }
 
+static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
+						   int old_uV, int new_uV)
+{
+	unsigned int ramp_reg;
+
+	ramp_reg = rdev->desc->ramp_reg;
+	if (old_uV > new_uV)
+		/* The downwards ramp is at a different offset. */
+		ramp_reg += S2MPG10_PMIC_DVS_RAMP4 - S2MPG10_PMIC_DVS_RAMP1;
+
+	return s2mpg1x_regulator_buck_set_voltage_time(rdev, old_uV, new_uV,
+						       ramp_reg,
+						       rdev->desc->ramp_mask);
+}
+
 /*
  * We assign both, ::set_voltage_time() and ::set_voltage_time_sel(), because
  * only if the latter is != NULL, the regulator core will call neither during

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


