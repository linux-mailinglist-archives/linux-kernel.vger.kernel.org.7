Return-Path: <linux-kernel+bounces-755104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCDCB1A15D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42F41886F61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A825A2B2;
	Mon,  4 Aug 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpjtVP8g"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3A258CF7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310269; cv=none; b=IybNEAZq2EG7QmbgM7gA0yOWos89MttrPxg+NC+nmjlsQqAUQYNBZaNryQ/1FFgPYF/LjIyuXs7egxoR7qvnrFhimd2YVtHPWMe55iM/ELCBAFwJhVGFDvnmuIJQgiIguSHD0HrIv43FBIzwtQcmcs61W5i8owMPiWysDW4nFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310269; c=relaxed/simple;
	bh=MMLwLWlUBkpNKpCHrz5KF4JVbyhd4pq1vLlCS8HQWvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htdeeYE5kpOYCtYRLh7GviEntU92VIatN3G63SS9SLPSumz4gxmzXS9auD3jwFkkwkVS9XzAIA3P/dHZQ7zd+BeWdThc00YBybr0fkwH60ZFZ9m3o25w7SAqJWranOXrtdM0CrOKHmNaAX0yPdn8UFnfN1JQe2cn2Mp9M48N7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpjtVP8g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-240418cbb8bso27895675ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754310267; x=1754915067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDKvifJZltIzJedU/1ZLJadeuH9/nZztGosgIc2AVTU=;
        b=XpjtVP8gShia2XvnuotxEomcQa/HuiVtU/Ihn5V3VI9MhWpCmPHB54VVJ/vdRLVEgv
         lhBryvWBbV7RhvW8dPQhzZJJrvFjvR+o9REt2lBQPvqZNifg9KqcznQENuaev3QcrPgh
         gQsxVZ9cYPUIbFOHVT4baEG+kjvfftaN9WHL6XPmARZmssoQ7gpb05UobI/It9PzeovL
         v/+c9KGanbDj/OrPZ98k10UeBLlxyeynOneExLxEUBAeNqLSD3ePA3uqnXSLJwssrTTJ
         OOCl2odBZppJzPVEHV8Fc4TZMTCS5jXfyd3nlI92Y9oiKEwj96nV81gl5byHx6kX7F70
         YWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310267; x=1754915067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDKvifJZltIzJedU/1ZLJadeuH9/nZztGosgIc2AVTU=;
        b=pz6SIYScWcdv30eqb4l9ggl/tYj3yTg5ORoRl6mSdhR7henoOCuEX7VM5QjQ1t7bIj
         Rd1ePwcdh2sRJzEYROvu9h1s3j3/dEQlVivmhTvyd0fHSVBKsAZ9ID/J1k0MCGyzeH34
         K2ggRSux4YNRPIoOSizRu6ytKkpx1apmV5FA6vGuhPWLoS3uRno+iRsqbzht7WN7UaL5
         d5zeh1g6QGIW4B7iDjm34b706mnYOlYDHZLOydHQiPkmIph3hQRTXBQTSRFwkGWBJ9Ms
         A3hSUrAwjivpWgCfjG4rWUufeNH5+wX7NijjSyM+8a6/5JmiV+HyJmLFIIHVP9Oglam7
         WUvg==
X-Forwarded-Encrypted: i=1; AJvYcCVwTf8GIAKp5Nmtf9rDp5JmT/nUxAG5umbGNyQFLvzNE84v4s9muggobLaAHtuGTU+fPlxS0OHue02dXis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uRsNNkiiXS9tzeWOTVM5V0cXjK/vepj/YjAsZ5D5TB80DHGe
	WU56i8OmirBdMUbpp/eodMhbXK44B9dfWJJ4eM2TkpkruFG0T6yXqTkUypvyxVWDDDat1g==
X-Gm-Gg: ASbGncuKBi0q7H6D7E1xc664cHKdxzS+L9CDZYehFodY+/ayFyraOMgqO/8FtX6Qpia
	Mhdqfq8cllkh3XFx72max84D64tTsUMDuydHOSFQRWtwGaVw7XBHcYrwafBMykspEQ5765Ajttx
	47YHoIvOMOM51RV9jRWP/3G8uxkZ0EOFUkJRc6NDq+QA8xPUJLwPygM20QPtWJUjV0aFf6ekNZk
	Xig6oikda913OhfJ7wzMMfejE7TvVNYvB+xbj8aWLsBMewlREWESWcz7eM9Km4XnGlF8lB7iCxT
	thNcsMPTRNNxbNVgrBFK+LM7IpBwIMrh6pvxuYu1ABfNyHiFmXOW1wPKsaZzEUIrhsE90GTIFsg
	8InMF5HdL9GESZpogXdebjwRliB2RPwsMkTLJEyr+2hjZoaTH/TIF16lMB+iv6wjI+PAxwzzGc3
	nZtbAURQbVaGQn
X-Google-Smtp-Source: AGHT+IFnCTK1oXgj2ujfGigzx4XT2C9KSw1IWXLB+pVsd6lKj052U+XAWh0fv5sgdiH2H59+2vCX1w==
X-Received: by 2002:a17:902:f684:b0:220:ea90:191e with SMTP id d9443c01a7336-24246f2cc2dmr151331365ad.4.1754310266936;
        Mon, 04 Aug 2025 05:24:26 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.161])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899b6a9sm108650335ad.134.2025.08.04.05.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:24:26 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] drm/bridge: samsung-dsim: Fix potential double-free in TE GPIO handling
Date: Mon,  4 Aug 2025 20:24:18 +0800
Message-Id: <20250804122418.104360-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_gpiod_get_optional() function uses device-managed resources that
are automatically cleaned up. The
gpiod_put() calls in both the error path of samsung_dsim_register_te_irq()
and in samsung_dsim_unregister_te_irq() are redundant and may lead to
double-free when the device is removed.

Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index bccc88d25948..6ffaee6b7738 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1691,7 +1691,6 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
 				   IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
 	if (ret) {
 		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
-		gpiod_put(dsi->te_gpio);
 		return ret;
 	}
 
@@ -1790,10 +1789,8 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 
 static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
 {
-	if (dsi->te_gpio) {
+	if (dsi->te_gpio)
 		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
-		gpiod_put(dsi->te_gpio);
-	}
 }
 
 static int samsung_dsim_host_detach(struct mipi_dsi_host *host,
-- 
2.35.1


