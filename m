Return-Path: <linux-kernel+bounces-845196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF7BC3D79
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECD82352B67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87652F5324;
	Wed,  8 Oct 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8x7cF3D"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D92F39A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912127; cv=none; b=skmEeYFlGTZGI8O+8dAKoYiCAze5gdgHAHou+sX5DKlpRgCxDKDy9gMA2tl2ZLWV/SYgA4c381yebGJp4iK9OsuUacZe+9FZPOq2J9HpuVViMCw3p/bjC4E1huK8DTkuxEwX+6aYHEo2GKTCmKNHVAK0/q7sQvku/nwrKzJhjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912127; c=relaxed/simple;
	bh=0Ne+TrGBDrX3c10etUDnWFPIq6tGiw8KBjG6kT7gL3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os1k+mdR4sPE4ftb4QI8iWx8OfB9msp0/T4e3aViYiB2/va6crGhgWv0B8JT4VOREwB3E1ujPIiUQPJSIOtoB5YujetmtlREcIh7MHl+H0hDGxD0Sf3jVVSx3ZqUR0we1y/72Wjp8NX6yhGebr+aPmYDF5utcS6qhJ4w9+ef6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8x7cF3D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5797c8612b4so9490471e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912124; x=1760516924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV9bEo+jpzFCLNbrvyE91xLWTJAB/c8fcrn62g9WVnM=;
        b=O8x7cF3DphlQtsulEAM5U/b6e810sgh4xgJ4hAaOXoQ7cu2nc6F+wN1zRWSx/btMnl
         kWXoGUZHeMHFgWYX58Ra/5w25fM+ZX2OiorbuFR0+TfJq6jpSRPnH9CM/2JKFyCngFAd
         kWciwkmOX/6luJVBpqJqLJUh4LlKV957+9siybmivx9GZ3juF6HOM8GIP6jL9W089G/P
         x4rjoyciPm6MC2E2TUF7f+wnACY3vhgygXFPKRQ2/gQ5iPdpUlW1z0S6clgDPprz6rUi
         QCZvVqJQv9N33cehCkLW6ZQhsYzKYxpM0b3+3Z9NfS4DtWCfvbOy/xSI6EZhVndX9UV9
         Z7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912124; x=1760516924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV9bEo+jpzFCLNbrvyE91xLWTJAB/c8fcrn62g9WVnM=;
        b=v9QwgrGIeb3UZQD3a/BF5+h5PvcQPcZIcLj3gCGP9rppEozguZp4iPM37z/6bqOA6W
         9wNwkjh/VAJaSMH44WfZOLDIeeueO0izuIowFhF24gF0QWYZho6JxAeCEkREI9gpJ2zF
         Rq+nDHGL0fAeYV8cxfER7dfFHaB3yKWIqD4wwtcvhuPQ38MBPGRibYmnH20iOx+IVQwW
         kOtjhXIkD7edn3KV+BwWwhDGfyjRnRWBacMSpgOhmDzy/i/Sqo1NH9GCrBJ3t+XoceDR
         wLNkdSCYTIVqmA2UVIULZBDCLF3LTZu52AwZHvvjACRhmWkY57mVwHxBeexZCe+nKDuP
         xM0A==
X-Forwarded-Encrypted: i=1; AJvYcCUv3D7Qx4JRxWuYdGkmoCyELIzaT5VZhKdxDBMxy4g420zzdxGS8+TDHrkGQuBCfDiySENN3BcTbDmFpKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSx7By4y2Yw0PjycwQ1/iyvtnZVxbpveaUXhKgQaQLHMyzzXo
	rqBk2HJdBtHymyipSpfYS9JuEF6ymNG/bUc2IW9XncDjZuqZ8EUiUUAw
X-Gm-Gg: ASbGncuPlpfVW1BNpV7zY6QgrMAXJglv2NUznA+0bBvurIQ6cVrcyUuZAbOocZYN35f
	X9ZLOTpimRQ9ZNbIvSCmajqAooxLE/AO3sZZ8ZlHX9r4asWXl1ZTx2oZWuCT1ac5AY5I8hIZRVl
	fGl74nulau//cqXZ7lzzJZYScaG8gAiUgl23ui9WfkfyoVVOa1wRksdvOWUJjRoPLcpMnTfsQcr
	uyw7PoGdJVg2Psy6uiqQMwwPLxyue1r+jQwAtrI/8ik1dgwVB/NuP8bjUOAL7h8V3x0zCgTSshi
	8jBxeeHmE4Sby8abStDi2cL3vwCdgyFdG1k29ZFwuryYUXVB318HF14J6dWD3t7fVD5DPjQSFpm
	yaugeLsOpV4QWhG7TfIDxIRNZfm0wov+gLy91oQ==
X-Google-Smtp-Source: AGHT+IFIW595D9hFhReYazPCYD5IL0kfVrXBukuOyPqDZomqnbAGHxukrmHmJaTHzusxTCMjXJg+5A==
X-Received: by 2002:a05:6512:3e29:b0:57b:cebe:ce04 with SMTP id 2adb3069b0e04-5906d896bb8mr627734e87.1.1759912123399;
        Wed, 08 Oct 2025 01:28:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124649sm6968733e87.15.2025.10.08.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:28:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 5/7] gpu/drm: panel: simple-panel: add Samsung LTL106AL01 LVDS panel support
Date: Wed,  8 Oct 2025 11:27:57 +0300
Message-ID: <20251008082800.67718-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008082800.67718-1-clamor95@gmail.com>
References: <20251008082800.67718-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samsung LTL106AL01 is a 10.6" FWXGA (1366x768) simple LVDS panel found in
Microsoft Surface RT tablet.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 81350ef50295..753149a9ac3f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4191,6 +4191,37 @@ static const struct panel_desc samsung_ltl101al01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing samsung_ltl106al01_timing = {
+	.pixelclock = { 71980000, 71980000, 71980000 },
+	.hactive = { 1366, 1366, 1366 },
+	.hfront_porch = { 56, 56, 56 },
+	.hback_porch = { 106, 106, 106 },
+	.hsync_len = { 14, 14, 14 },
+	.vactive = { 768, 768, 768 },
+	.vfront_porch = { 3, 3, 3 },
+	.vback_porch = { 6, 6, 6 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc samsung_ltl106al01 = {
+	.timings = &samsung_ltl106al01_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 235,
+		.height = 132,
+	},
+	.delay = {
+		.prepare = 5,
+		.enable = 10,
+		.disable = 10,
+		.unprepare = 5,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode samsung_ltn101nt05_mode = {
 	.clock = 54030,
 	.hdisplay = 1024,
@@ -5355,6 +5386,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "samsung,ltl101al01",
 		.data = &samsung_ltl101al01,
+	}, {
+		.compatible = "samsung,ltl106al01",
+		.data = &samsung_ltl106al01,
 	}, {
 		.compatible = "samsung,ltn101nt05",
 		.data = &samsung_ltn101nt05,
-- 
2.48.1


