Return-Path: <linux-kernel+bounces-807961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F15B4AB63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AE61C6288A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3AE326D64;
	Tue,  9 Sep 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGNoBs4X"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CD322543
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416300; cv=none; b=GRw4N8LG6tmdO58PUg93DaMTVTO6p41OBjU1YgRq3kACuCpzdXiCJk0BAQ1/zTtVvBERaiFvl91JepRyCaqs8t0Ec9y5IUkbS/ilUjF8VsT+NiYtt2ngx2iZ2szc5l//nTAl0xrQMfOxRdYMbU0IdtLQ74lamlpQRwGnTGdLDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416300; c=relaxed/simple;
	bh=FT2wsbDyCZRzD2r+SnftPJClb+shQXg//V9P9Jil0eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd3cvLRiJKLdk1tFultZiEBDHecM7l+/yH4dj8C/wm4WdacQ0NCzsJl1ErZ62bRbBENs+ZDCAYZpNeFcuWt687SHwHy12wCX78u2cwUkt+2WyFYWdK3rHbiyOKu/K3jWEeIjfjg/PFIhsfEn3ZKo54EMZa8/Lvu+kXBHgSt7sLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGNoBs4X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so6695903e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416296; x=1758021096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRRJzAp5T/AY0upYHHrWwdi9zh66HciwKxd1T/ME7rY=;
        b=yGNoBs4XjZ0kr82NOQ6fdutdX09iGIZuWcEw5FA3qVZ0BYpb1I13GrahPRwn7zrPqv
         DpRKsTwROhnigCx5P9jXgK17kfQneMIm9q9LVYEGoIaW09R5haFPM66THrxCJytbxeDp
         O5DK3H3ZzC64pOWED9GUIOlYnOS8VqClrW2HgjM12VRQcvyEATrBatjPRaJmr5TVo/NK
         WB3eDnIS0hUFyuz9v3WgZdKviaq0oqWQfEiC7SacT2M7qEIwDA7OgSFUgJUBY0mQN8y1
         A+MPIXX7olMWtIN0BuV+RbFlj0qeF/4m9KOzFrdWpPx1KhA5p5qwfWjL8KRBbsf1ndBO
         terg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416296; x=1758021096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRRJzAp5T/AY0upYHHrWwdi9zh66HciwKxd1T/ME7rY=;
        b=UHfRa0rtjP01Dd97QK+vay6jgfBxrR39IV4eDOqGkWuc9TKwnaKrbQzTeZWkBliITN
         sXDw5QnuEZ9ld0fFMw9Dk+mTneyBBLFppjcGgCm2U7JXT8IhHk5uizNwi7XlBOvVAcTG
         H1JBtkpoOCdWCXb0K8TnQYuUbtWdy64IpiasnNOish7L6zD8zrrWb9ea6Rr1uPOMAIRs
         rvedvN0/rJvG8UOXFWYoUtG72mfRAdK33qtuYiyFIV2mG3dzTkKOLDYglnJQr0d/oYkd
         qlcmqQaX5LAy2E3xsVfZpG+26eqakwB9cM9PGh2kwwFAa8WCfDVYNJePM/o5jTx58ri5
         KJJA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdfheKrOhM9cadIsnpe5HEdi8jgrJrbZpmVYxqR4gQfdA2UxX5kW0nCDXA9LWHoYEY1I9UW2jhl+a4ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qdNUlnT+tTsY55izM5fL4PT7JSoWw/qrDY8TvZjGFneZ+1MM
	Gz4SYqf6x5lZsRXAr31RB/+KaHTKdXU6lTemGb+M7ol3e0zd2MFsdfzxKizAyjDwYCk=
X-Gm-Gg: ASbGnctQQ21P7xG3hZPZechGmQFG9koj7ufGkqoYTT7Q36OKy7dV19F4FiBq/cC7I3z
	adD8JFNEz5Add8S0hCi82b1Yl/te5yBsCDjAOFZnmfjz3CfCYrOTkfa+o58hX0wkgl3iwTwFbCZ
	c8jl7AlfqR9E8T1+Q2S/4BQBoX2vEIKPcQdehQ3SGqOGdiaZ7nzJomc8MevvC/damZ6R1qEppNN
	gczF0Nk7vmHeqkWGf+EU9pv1hj0tGPsMPvIeFxqJpwqKek7MC/8soRzryFrLpDekWOp6ZA1Y/8X
	/z0gKgKBHIoiXipmiZjwN67U/Pg2ZyM17KksaVK3eCr1hmeLZYkh5aHpZoJJ5rzYIQUAMFCJM34
	YOPzKocwZe5vEpWXTJJFUa/Dk3NOyk8m69GxUJUBQgpq4I927Fg5m2qiQcYWms2ye1JlOLxOXnR
	lu/e30oPI=
X-Google-Smtp-Source: AGHT+IE+Q6v2KTcckCRiOxW67dRfnlJxOytiBrBROHCosdo74CbcYnNRw9OtyMUXGt/Lx7pml2UICg==
X-Received: by 2002:a05:6512:b12:b0:560:8b56:5dc5 with SMTP id 2adb3069b0e04-56261cbe1f7mr4363060e87.18.1757416296383;
        Tue, 09 Sep 2025 04:11:36 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:35 -0700 (PDT)
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
Subject: [PATCH 2/5] pmdomain: rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON
Date: Tue,  9 Sep 2025 13:11:21 +0200
Message-ID: <20250909111130.132976-3-ulf.hansson@linaro.org>
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

The deferred regulator retrieval for Rockchip PM domains are causing some
weird dependencies. More precisely, if the power-domain is powered-on from
the HW perspective, its corresponding regulator must not be powered-off via
regulator_init_complete(), which is a late_initcall_sync.

Even on platforms that don't have the domain-supply regulator specified for
the power-domain provider, may suffer from these problems.

More precisely, things just happen to work before, because
genpd_power_off_unused() (also a late_initcall_sync) managed to power-off
the PM domain before regulator_init_complete() powered-off the regulator.

Ideally this fragile dependency must be fixed properly for the Rockchip PM
domains, but until then, let's fallback to the previous behaviour by using
the GENPD_FLAG_NO_STAY_ON flag.

Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/
Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 242570c505fb..1955c6d453e4 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -865,7 +865,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;
 	pd->genpd.detach_dev = rockchip_pd_detach_dev;
-	pd->genpd.flags = GENPD_FLAG_PM_CLK;
+	pd->genpd.flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_NO_STAY_ON;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	pm_genpd_init(&pd->genpd, NULL,
-- 
2.43.0


