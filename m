Return-Path: <linux-kernel+bounces-761426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E9B1F9F4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A344E4E1954
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67901256C70;
	Sun, 10 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WscgfMpB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19724418E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829218; cv=none; b=bqRXxTFpoPxPlHFrQxSjsF0pQfu7434vc2+D2c1MudnQbNcz6Ur9+kbpU/5BOKU0kc5yUniCJKaYiIh2+AOB/yca+eFTaxPgHHqyxrx3yEKbBbnqI365Y4mi/KuJ1Bj+n1RAIRay4S0MDYRgZA7ljdyxDIWRhs6l9DdBcb8Aoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829218; c=relaxed/simple;
	bh=eF2pCPqvIUVXfjGi4cGSqxfiyyApZC+w6aPru5Fej4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDqIj66X3AhMugb3pq342G/cExYxzH60vrcDlNNr5qWe32oybWCiYlKXZoTJc6Y1QNqthgxU7+l/4giixYCvg+xPf4ebbkFd6lZ5bYRdhF0UwL+UL4aKxV8+Tf6Ng+1vOci8NvzZqVywWpG5Zb1WWFDFOgY8qnuDaQqKQGE2H6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WscgfMpB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso4135500a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754829214; x=1755434014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc86r8Ps8ejxXw7sAHzmDol9rV1c5jkZbSRqlXrLKSY=;
        b=WscgfMpBWVU6LqLlFb6IG9eGnE1XN0Tg+8goAZ05dcD+mSLWywELoCF+JOtU0rBtIk
         lGxBipA9pMm0mgxPj5Spb1lzx7JbJQoePmLPrCN5n4d7P0iZ5tBQWVJpof/kXC5YvLzU
         H8AV6eavKAXT3EHVmSayHWCQSOX0CQh6s1e1QCrrzA4zLFiE8gHH0ibFtj5iAZOHTLuq
         y4Eox/lIDuJRhl9we8wD49+vPRF5WBgmkF9LLnGtgSrUofAAwq/baepbC440Bwtd7DMv
         4Cow9wrhUzofMZIfOD7awuA/3GRmB4ZYsPqczjS4RM/SCwEy8cJZt2hLqMKzBSJEOX+Y
         hSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829214; x=1755434014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qc86r8Ps8ejxXw7sAHzmDol9rV1c5jkZbSRqlXrLKSY=;
        b=j9sMseLc8lcE48gd2I4dimeJ2P9jtzgo6cz7ADjY5KPaOdZ65B7DzrMx8CMPZ/p2Rj
         cKhvjaEzM+8wJYvclELmQ99QeCUsB/y3xWiVzWmuhXqzB3lcSqeeQfTJdB6RDX8U2T6W
         PDpddi7bGNqx0tj4ofSIt+T/3CgxxR7Egz+hENbuSvEovexMgBfGdGO2gwmU/skohjVC
         iQmhcj3yf+Ot/YJ6w0tIQvUPN/V/+4pFLdO6LsuCOS3peJDDOS4/6wGafPj88Ym8vs75
         72J+si6z3gvjv+G/VG66GIAb3mwSKbwK/LAOETDeSv2QjAxVZJC7pgu9QuHjsh2s0RAo
         LgPA==
X-Forwarded-Encrypted: i=1; AJvYcCXyzW6kRKf5qJTVOgK4ljS9wEz4pPpz3SORv/3Ct+ojlM0UFbeQu6K+NxIT/V6EM9jSZMDh9UaI4vVaa1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pheCezNkOb9DOCO52fLS8i/rwZt1vK5/vR+d72rEvQYqG2VV
	i8+MB0xF5a5E95osEI3y+OzNd/1aAUIQwRrzZ6IA0rGLbUlez2MDaufURxojTAoUItA=
X-Gm-Gg: ASbGnct6nJ0BG6yzZb43B9Rk3y75PEipFAM1/dn7MAbajVFh7rtbh4P7HFYBNz1fQpU
	99QDdx12zhadFCxua0A7SX5N2TT/aiCvnAMjyx5+0Hu9RC/Q5KDNNppEKygqkn/GfyWXPfbTJZy
	jGcvqjsr6Vt2/05Du1k7PCzUteSr63NKDxuG+XkPYgms94XJ6IsEBOb5YVcVmUzye4ym8PWVkvc
	gbuVeEGRmDCijxH0PCbZHK22O763jAw7Pm50+qVEp6+JoJPUH1xtAon6wGXkYoLIlH7u6hfjqjO
	vgbNtKSuLR8QWgcvVXDEkzAeWM8jIr0WAuL/JvCnk8zVHOpVdmNxm6XnJNI5M+pP8pIr5H/eeKz
	1Ep3lLI3aP0sW3rxzSHsswYY0mDWu/8bJcaIFrUOCoRELpfOi5XwG
X-Google-Smtp-Source: AGHT+IHVjXOsWcnGsxT8XIw2bCiWGkL8lvf80Pf8oGV4bpr5+LSOIDkUOObcDd4bAxjpxpGX1McC7w==
X-Received: by 2002:a17:907:78c:b0:af9:140e:b262 with SMTP id a640c23a62f3a-af9c6544481mr899962566b.57.1754829214263;
        Sun, 10 Aug 2025 05:33:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437desm1852203366b.127.2025.08.10.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:33:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5 1/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Sun, 10 Aug 2025 15:33:27 +0300
Message-ID: <20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to manually track the runtime PM status in the driver.
The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
already call pm_runtime_status_suspended() to check the runtime PM state.

Additionally, avoid calling pm_runtime_put_autosuspend() during the
suspend/resume path, as this would decrease the usage counter of a
potential user that had the ADC open before the suspend/resume cycle.

Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- collected tags

Changes in v3:
- collected tags

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 9674d48074c9..0cb5a67fd497 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -541,14 +540,9 @@ static int rzg2l_adc_suspend(struct device *dev)
 	};
 	int ret;
 
-	if (pm_runtime_suspended(dev)) {
-		adc->was_rpm_active = false;
-	} else {
-		ret = pm_runtime_force_suspend(dev);
-		if (ret)
-			return ret;
-		adc->was_rpm_active = true;
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
 	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
@@ -557,9 +551,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -577,11 +569,9 @@ static int rzg2l_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (adc->was_rpm_active) {
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			goto resets_restore;
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		goto resets_restore;
 
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
@@ -590,10 +580,7 @@ static int rzg2l_adc_resume(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
+	pm_runtime_force_suspend(dev);
 resets_restore:
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
-- 
2.43.0


