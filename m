Return-Path: <linux-kernel+bounces-807964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B8B4AB75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A961618BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3BC32BF5B;
	Tue,  9 Sep 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuAI8+kr"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611632A3C2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416304; cv=none; b=MY8EFfkkZfHFSx0V0fGgsEOpv5NbuMpPvO67xD82HN7MldSnROMhOhBYrg3dEHJnL2DRP0rMo854s3M1+E+R/8Ee6ZvwL4kklvOXjR9Hr5NX1Y364NX4dPVZpfj5eGNVQrVcAxIGgj6llPCnukmAo/yZO+l2+d+ZA7+MXCJI0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416304; c=relaxed/simple;
	bh=qX2XQlnL77P0KB6EClM0+xTAM+le4yDduPWYxg1F5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPGcfDiTbAyF1mIGbNV0GGuYJ4yWPV3sgOisH5nWL/+KI+PMREA8gtS3og0/6txnTW0cRItae1TppxxRjvz0pjKMpO5H7GMLj55JWLVmJHq28FTbRMmkneIKTqddE8T71WvdZ3mmioLWlKH5Rlkygv5PZIYdpaALBmq+SU9L7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuAI8+kr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso6235594e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416300; x=1758021100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s4ue+vxLshDaVNog/qaeHRfYjor1s3xeCpGVICPA0U=;
        b=uuAI8+kr6UZrPmjAi2JGqIXdQhh8kzvyBETXnFVd/rchL+995Q8kDzBZfYdR0m6oQ5
         IysC6wrN9/l6r7cHhbfbTiAycr3ojx493iByx6XlgS50dzcv9O288iSamqMuuEvHQUXy
         KC8sVTWScjQgGU0vYIUcmodQdoYDUsGfnRS93Sr6xFtjQvw9VEp3Vvca9KJBAcarsr5W
         V3wMjAaDNHR/m6YSHHwUsJYtI2uSV/OkbLAPJAurqynpJwM5ZRbDK8KZOkTylUP15Guk
         y8833WK5DN2PVhSteql9nSnHbZjKhWR+Qta4P6YJgVaLRXFYhy7iprbgswtjjA3/N2i6
         2V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416300; x=1758021100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s4ue+vxLshDaVNog/qaeHRfYjor1s3xeCpGVICPA0U=;
        b=CcqlV4KaBeXZwJlcjEgWpwkVvG0H8zk2m3QDRh7aEKmZgqCOSYK08riFCZk44A1LhQ
         0MqRsqk5RplXeA9tElgLdnj+03yWVt09SD2nnr3ASsRfn4JUog4KbkGnEw5xFMfvp2bt
         unprX/Cje2HCYK/xOlaUw9LboLazAB8vuWSKgXKARzsZTEmFeq1D2BseMi5/m56wc9Pg
         BvPYBGhxUV1I/HLDy8QK3X01AVuWSdpRBcxXs2NlcCkT/HfRPW24FUVQpgFOVOeUWjuc
         8JuPYQ3CSUOSkD+HfK2w1eH1GxHB7pj2t5gu5CzD7RGY3pOWJto4v91TtGGTFtq9e3wt
         eFAg==
X-Forwarded-Encrypted: i=1; AJvYcCWmSIpdLNHA6ueOV1d4WBz2dB6gqPaD0JO16pcg0A3e2UbM+hWjPOn8UmDE0Ua/Zw2Xwh2oHfTGB5b9ir4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8YKUgfwBP187J8Z4MOJt0qW/AoD1E5QIkdRCP0Yi+ZBNCt18k
	YCcyDrnycuWuUeFfE9Vpz4RTkBrpjVygLNrh/G3fbsAR/y4BVPapWhmUKOfUFRHIGEHlBZdWYMD
	tayEi
X-Gm-Gg: ASbGncsMKROniZeiRF55ZAKpMXacZ6+YUFGNMRf7qJDX3LMOL15LzerV8jWYqMbi975
	Ylb4riW/5vS2NVloDX/HVNJS7HAswGz2yFxIUf4io46UcBehsShoWWmWZc+ebIE7yQwFJCerZZ4
	qmnFtrAsCuDfyunF+0C6LvLSSBUdcWtrE4lHvsflcsvfC3471M2WdPrrDuKljSXpm+qMGhqTmhI
	cB+xzGmSO+/G64wrSB8VNDazueEbtwTaAHfMyI38MI+w9AL7716/HIXytVqUlj85jWlyweAK6Y5
	gIS8GJkRLBbbtb+wrwe5HUG7WabCfbDToVl0x6zN0jomrPRH7tv8RnViWd5wC4TUMoKgoZkgUZr
	tngaKRB3qbyG7vjKX9SXKBxaUse7lNv66sOTFdeo40RqHjP8hxYMVy4Vk9wW2F8r2GhOQY1RUx1
	CAo+oa2h0=
X-Google-Smtp-Source: AGHT+IH3If1E1wmdYnnMVHOIWDwlC5uh1BOrgxWYASzxhPPmZmGZqHrDzK8CUhRE0KdKbGrCF4Hbhg==
X-Received: by 2002:a05:6512:10ca:b0:55f:5942:43ca with SMTP id 2adb3069b0e04-56260f37a43mr3913159e87.20.1757416300440;
        Tue, 09 Sep 2025 04:11:40 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:40 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on
Date: Tue,  9 Sep 2025 13:11:24 +0200
Message-ID: <20250909111130.132976-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent changes to genpd makes a genpd OF provider that is powered-on at
initialization to stay powered-on, until the ->sync_state() callback is
invoked for it.

This may not happen at all, if we wait for a consumer device to be probed,
leading to wasting energy. There are ways to enforce the ->sync_state()
callback to be invoked, through sysfs or via the probe-defer-timeout, but
none of them in its current form are a good fit for rmobile-sysc PM
domains.

Let's therefore opt-out from this behaviour of genpd for now, by using the
GENPD_FLAG_NO_STAY_ON.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 8eedc9a1d825..a6bf7295e909 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -100,7 +100,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP |
+		GENPD_FLAG_NO_STAY_ON;
 	genpd->attach_dev = cpg_mstp_attach_dev;
 	genpd->detach_dev = cpg_mstp_detach_dev;
 
-- 
2.43.0


