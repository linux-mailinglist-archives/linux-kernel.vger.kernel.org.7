Return-Path: <linux-kernel+bounces-711177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AACAEF73E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008E21C02751
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74968279335;
	Tue,  1 Jul 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnALUKAe"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F2278170
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370496; cv=none; b=JEWrhi2MrSRDwArmPKKzNHRzWArc0w1Zx+WB35w7cnNCUKFfkcChnFkA6vN9NcGYxXF/Sn606Y4TXnqto6cIlVMxkM16TPwf3S0Wer97Io34aBmXlQnR6f6Sh1ImGVJs+XlMOPyIaDnOOPvVhHMrM45xmlh/O4cz0l5UbEO9kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370496; c=relaxed/simple;
	bh=NEXU2VLrvcoTgnasw+T34g0Ny2Yk3h7wyLcdVlrWlKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tenIIG8a5I4x4j4jULeS2SUSjdFmp7rYLTNqXFtzlRTfMCo7gKlbRBwPprDv3Jmwc8pmWTXLT13PzaMNsrlw4VwtbIdsjgcY16raYAZ9BvPQLhFBvZc7dhCub+DePuoFhZ8pKLee+4pCnMlAsEWgAM8ASJJIIpSH62YK4hwpazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnALUKAe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b60de463so3701374e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370493; x=1751975293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdMf8ETlbb68upZAkXYue9saY3OH8vhTng5lSfTP1Lw=;
        b=BnALUKAeu+5HgsxdUR/NvkHr9eXtFuLH9G3iOcFCfJgE9ySA7LpuAljC8UO8g4YyDD
         LLYm5Yn97auuY4m7PHw/6G2DCL4wfXwv3dXgsLy1QPyBAQnjKzG2TH+VBKx3M6xRSHbk
         0Am8Y2K7AgjAWsopaL/r23fK/6dDQKaQU7/nJ8kLmlWd51h6J47HWoluqkDEMNkn3LAf
         4+1VQtr+OW+txx2M6EnkXJpHakhugwwROjtb9R4kdCCFRu5PlbS6sV2i5rVCOBubyQ1L
         C/8DfnstQ/QmrHOrLgGWXzqa0lyk3w2eCDWy92qd46SSw73dxs6kN61a5WsjcxjuuicC
         vfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370493; x=1751975293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdMf8ETlbb68upZAkXYue9saY3OH8vhTng5lSfTP1Lw=;
        b=HWoc+EX54sBMV5Kyamu2xZGkdDvhfVNOAGubDz65IGJmlvIlNARYX43iLQeEdLCKJ3
         FApzwBQNJVvVyk5NdJUdr3/DBm7rFzOIqYoi4MHyrk3sFpiyVej+pi06GLAgIXQnMji7
         LipPteg5vwS+laiyA9tRdzs5l41n57y73UqOYl0b1EpvXtP/xHr3d6CmZHLufa8XeAVo
         f7kU2OecfNIkgZE0VmLsDsrUORFHxT5njWCn+Qbhrv/B6PCoLHebBmdlMkumg0uVjbhZ
         2ejhbB4xQAgEmg7RkAxbFo5psET5LqgeSHWWVCao+eEfYcODAZJ2EGicYPYDvvGiMeEf
         ye+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLEp9TkaR9TndFay2iNmxaQYdisSBfu2EoyjVXuGmmnWLbhBgdsQ9GVsSdPILyUhUJJHcrn1hEPGOs14U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxoE4aUVNEGUitgHLASK+Gbo+jBXbQHRrqddM3T2/tJQBogpP
	4nYGDzU6cKhVODsKgVOndvWsMCb2ZbeyOYsG7hwYfh6RwX0U9L/1hhsoHL6ukM8a9H8=
X-Gm-Gg: ASbGncu5Z5p4uWWZH56Sr2+fWuAu39fRbtqOSKA5XUild5Ma5H4vjQPpInrCEzdIg5a
	HA1PT/0yMW20AjWlww3r+4adUyW7tpzkHLKw+NoprPNNhyD1lC0GZzdAoxjtAbQOwF4r+XwooE2
	mymYT3m0GY7aA/lqc4Cdrvr06OkFW+9XdPX40GAAEBWj/fi5P9kgGG6HwjJrGYZ1sHV4fX+VlHG
	MGM4ssyIpmk9AIcOXyz1RrugyM4Rs1h1ur2SgYaToqc/WmAZcWcrJ2Rw9uMZxHOSIG0CZF+lwW5
	P7J1dX5yaDTliyNs2DJE8AFU0WdEdWVoj6JGHH6vbmj2u7KHwlYJg3waTSIhtVwqty56lKSlmjo
	xpp71hpibf8U5S4bRhkih1U7LJMpdlI51l1kW
X-Google-Smtp-Source: AGHT+IE/SHIuzQ7rWKOlDC+9ofv3pJngxyUh6TGDzTwptTEze5aqXXTe7AIraV6bJA9jSM2HwMhMpw==
X-Received: by 2002:a05:6512:3d10:b0:553:d884:7922 with SMTP id 2adb3069b0e04-5550ba1191bmr4622940e87.48.1751370493072;
        Tue, 01 Jul 2025 04:48:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:12 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on until late_initcall_sync
Date: Tue,  1 Jul 2025 13:47:23 +0200
Message-ID: <20250701114733.636510-22-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Powering-off a genpd that was on during boot, before all of its consumer
devices have been probed, is certainly prone to problems.

As a step to improve this situation, let's prevent these genpds from being
powered-off until genpd_power_off_unused() gets called, which is a
late_initcall_sync().

Note that, this still doesn't guarantee that all the consumer devices has
been probed before we allow to power-off the genpds. Yet, this should be a
step in the right direction.

Suggested-by: Saravana Kannan <saravanak@google.com>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 10 ++++++++--
 include/linux/pm_domain.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5cef6de60c72..18951ed6295d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -931,11 +931,12 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	 * The domain is already in the "power off" state.
 	 * System suspend is in progress.
 	 * The domain is configured as always on.
+	 * The domain was on at boot and still need to stay on.
 	 * The domain has a subdomain being powered on.
 	 */
 	if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
 	    genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
-	    atomic_read(&genpd->sd_count) > 0)
+	    genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
 		return;
 
 	/*
@@ -1346,8 +1347,12 @@ static int __init genpd_power_off_unused(void)
 	pr_info("genpd: Disabling unused power domains\n");
 	mutex_lock(&gpd_list_lock);
 
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		genpd_lock(genpd);
+		genpd->stay_on = false;
+		genpd_unlock(genpd);
 		genpd_queue_power_off_work(genpd);
+	}
 
 	mutex_unlock(&gpd_list_lock);
 
@@ -2352,6 +2357,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
+	genpd->stay_on = !is_off;
 	genpd->sync_state = GENPD_SYNC_STATE_OFF;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d68e07dadc99..99556589f45e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -199,6 +199,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
+	bool stay_on;			/* Stay powered-on during boot. */
 	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
2.43.0


