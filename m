Return-Path: <linux-kernel+bounces-807962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0074B4AB72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06774E0D07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442D3277BA;
	Tue,  9 Sep 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zgu3nzuG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659D320CAF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416301; cv=none; b=QZpKfSQVdkn/QzwOBGagirbG7KsDtwsPqDN0+STc9yG8L3K3lmUWOrBbOJI7qK0rLg0eyPAPQoCczwaKDQupeYZibkneloT5jH6X21z7VwbgULqH/4jQclzn18KeDoTe5zUKb1GyGYi6piLdP4dwk4/XdQvotWi6IjRFImQrapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416301; c=relaxed/simple;
	bh=hk3zLwcEJKFdhvO6fbF4mETMi1Wbntn3yOBrNMw+h10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izN1D0V88ehriFzZ0Me/snaF1h68Ry0xlXurfdgzlzpFzdqQKC84BP75xr5bMWCKl4EWWl/9Qg9VeNe5qEO7XNRN+vTedHymvwRtwO2oNrGspgGxKploT+0Msczkglucih9ulPhwtX/9N5A+Fg2o1Y1mjjaocVSfDMhYHM9/CLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zgu3nzuG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso626773e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416298; x=1758021098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYd82RFH6eK4wGWLoS9WCtFcsYKgozGDQMKLc16TQyQ=;
        b=Zgu3nzuGB123lSE87IXojwFVMX5+8TiabEOuS0glbhpwAV+oWPNObGzenm8UkEfiyJ
         XRIENXcxDWahii9aisNy1rkuBaZotUcdCQvYB3d2XkRKN7VAIgUVHglf5k9ofh1Uluza
         7YwzlQ6q58JZLCNtQY3O3o4YPKAyPwbLHvuQodJ0ahdP5ilN7C+kHAmwK8kmr3PAworQ
         3U3hH+cQCIEIZUWvXKp5ohBamS8m1u5bzy+dlOyuO9rUYmaHgTA5sksM5czjbVffz2qi
         TCK1RQMxnKd3SilGbitiZ3delYFpefzRVjGOEI6D44yu7ULQYYNXZj9R+bVl7L8ztNQB
         zyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416298; x=1758021098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYd82RFH6eK4wGWLoS9WCtFcsYKgozGDQMKLc16TQyQ=;
        b=wHHYSe70DwN5HjvIZnBhKmheZF+1m3fas/43BHZIYPMntADdJ20uVe8tHxla7Mgdup
         kWlxR0gC30Y+fZMA4kHEjLJYd7o08/EaGznLkxvkdiSzEkCV6XZNNqPIjV+AH67CRdr7
         LxBFBczPsqKUQx3SN8AtKM+ER/QR/ZcxvQdr0d/mwScDKPElMrQTjYN3jNDyIWPrPUeG
         Y5JuOwJ3iAWMrBrnjh2friPPGdAPVj6ie3QWEPn7x3NOcotR8H1OUE1LdvOQB7XGFgli
         eAAN0WdKWTHeufCiDHOlwO2wJDX8Y0/pv8L3AFhnqLChL+5dl128YBbsqn6DuxA7FfYF
         xmIA==
X-Forwarded-Encrypted: i=1; AJvYcCXDuhQlHBEBGbXEAR7wjxgbRraPk189ZqS5Cvvqj7UjkEzj3sOL5xj21EWb0gh770nZuLf8XhBf5ZbOFMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDhNvXPgCALuhQAs6dR8f7GIejNDawafOn1ikChdmrLtbj1Z8
	sHzjZb3eDd7T/SqfZUZQHEJcQ5s2yUu/GMN586+naEfK4aOINgQ+jr5lDR9Hza/xRTw=
X-Gm-Gg: ASbGnctQgJdreUK4B86rU5SOqztpV7hUkaCMWPsToAiNQzDfn4QTVpTRymylmetER11
	CnCUSjnGUjtWGbEnohv8og3x0up2/0+fxu4w9sHgtSSf1JaMyUg0Bewlr/T1yegAnfHe71chltO
	AKt9Izxl/qBOr6cc7hILKjnftJQO0lq01otnzGCR+qz0I4xsOgVdKntuRV/6P3PXr2j+rEOcC8z
	VT2A/FtNvaJDsOCv7CkkX0vuqJ/JhIe6mfwRGzzxe3E4eGsGnKU/ufUoMjrFKjnU75qP6l3Bipz
	78mkXg6G/IMky1ITVhyOFp2A1g9nBvlTZn5S+KEyWr34GKK7sFLLHQSQ6UO9HYu58BBihEokEWL
	Ax5Ppvq+T4WZknR5AgID4Js4/cU0K6wYKN7SxuJGvRI+9CQoJaaIuA5W90d4eCZOF9Og8M0md60
	RS37h48/o=
X-Google-Smtp-Source: AGHT+IEDEezqBzu6WD5cRb0Yhvc1WCJvGMbiCnMcquxNLiuAz9Ox4q5bWS49Ks338WKrFgMjtbd8NQ==
X-Received: by 2002:a05:6512:220c:b0:55f:6bae:50c5 with SMTP id 2adb3069b0e04-5625ffc80ebmr3407675e87.19.1757416297700;
        Tue, 09 Sep 2025 04:11:37 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:37 -0700 (PDT)
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
Subject: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
Date: Tue,  9 Sep 2025 13:11:22 +0200
Message-ID: <20250909111130.132976-4-ulf.hansson@linaro.org>
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
none of them in its current form are a good fit for rcar-sysc PM domains.

Let's therefore opt-out from this behaviour of genpd for now, by using the
GENPD_FLAG_NO_STAY_ON.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 2d4161170c63..d8a8ffcde38d 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		}
 	}
 
+	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
-- 
2.43.0


