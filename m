Return-Path: <linux-kernel+bounces-849988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD3BD18DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8DB3B7689
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D02E371D;
	Mon, 13 Oct 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvN3zhYa"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354162E2296
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334982; cv=none; b=AOHjGuSNU8bM2iqKupz7VVxqD2MFhSLttBFGPNMQLd19QlO4bJ4aSUbQHWcxtN4mH8KRldDjcVfHiclEDbuOvaSYktcWQIWK0c4VeCOuiY5oyV7njBnzLwCjeqDPRVg3Og3jWUP6OoNAEQFkQYhtzww6Ckg9XC7vsf4zg7PPTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334982; c=relaxed/simple;
	bh=kEk5LNotciAZWjxbpPSAlsjwVvH/hQCIwHrwOOjX+Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxP/HXiGV7pIVE0LlbqCxH9iIUTgryBe5++MlAqFE/aFW0a8fIU/DDvdjyCaUuOULS3roYv4kDPUgwtnbu0MHmsPAizNoVsZbJ8bKi/G+3542mzMx5Z7wM7YIUrCcyi/fiMmL4YXDjmW1lFlWGOxQbt59t+RcdD0UGYVR8s0ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvN3zhYa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3b27b50090so702795966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334978; x=1760939778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAf6EGQeqIJGv2EMJ3digEJ7PV9lZXWnKBDi4CC+hkM=;
        b=kvN3zhYaUhR8MSSgMoW8yI8N4HLs9XON78ES8QfYCKx9waClEVQt2SIqeaCxzLyTfr
         yysHTpYklkQRGXes2PcnvSNBXw4iUKFRc1SatzDD16rUIyR14y7df0U+2fYLS5qA2iKN
         kwfAxyf0njaBQIw4DByNRQAZuTzNlIfSjDZMX54FTG2EEA22INhAgPxAJRfdjoYNKCHG
         weG0CZeUULH0J5L7fzZqhb8VZfhWkI9s/Zf8j1cfXARjk3NaeslgRTQKIVZvHB0tKH01
         3bIa7AjPVrPQV6I74J1M+U3jRb7LqSo77o/nZ92YoRTD82s4Dgfh35ibunA54h7q5GSz
         9g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334978; x=1760939778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAf6EGQeqIJGv2EMJ3digEJ7PV9lZXWnKBDi4CC+hkM=;
        b=mZi/mW86eenDg3sj5vAYtWBdr3rZ5wbvHHvA+d586yD8BzPoMFd03DGqd1qvgp6KZ1
         9h+m/tEhTBjzjowyC1zN78Ayj3uyMyLya4/F1IhKDoKoX5VZGy5Uwnsf1VDXrqBASXDl
         80BNMDXq92+g5lQStSeAM1A+DCVHdFcmxgQNuTErBZgSL4k2foNclngx9brs68Zc2hY4
         qPWvjIyp63dSoYk74ej8GN5hzzoN7J6hjQytAju1RedsctwD9iyiP1DYZyIvEFHgUagh
         pVN829rnmhdwACicuXz4ixXE7kVbvL8Q3V/qiHFDBRL1+TyvpkVKjUtI7FuzH9Nn3fRO
         fyVA==
X-Forwarded-Encrypted: i=1; AJvYcCVtJvFXihChvveDYHR9Bb2j17Vx+3TsUSIyT/BS5tVR2g5xgF4DtGvEJBt77HXVPb7gKkoORGEkkkUzrok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQO8gbtfc2AOTzWbrCojr74mpamI16JEyN1jWQQrbJMD6SJ25/
	5a4dhppazO193vFi3LcWPkHqqev9i1C1uTlk0sCzxNzByB7ECnicE2aF
X-Gm-Gg: ASbGncvXXQunL0nOXt79rowtEAzYAoZS5wLsf88ybBgeAkAaTfK7wE2l9Eq76cfQDB6
	YJtDF/KJ+gJcMAivzVfDG3CAuZ95BxbAlcP5cESfzgaRcXyCEJ9BvjHjYHbp9DAd1+cUTVXVr2U
	4y+9K2iD4QCHWQFi1U//uFFV1JrQspcWHVJLnhV+9gY0bSPeqWbOSj+9VWmqnS6AFLJ5KAVhmU2
	A9/iWFRoI9Z26dqwxy9fodqlBokQQrybjVejIoiNerWwLGIcE8cM+VezJP8+aGho3PKSb78TAvb
	DKCUw2ISFyZqt266ZCgKLh/Awkq/y7dtTPLZyWNulFKoxyFk6nlmL2KyfNg/E08HLbQ2tMihswB
	HA/6VS2YjPbBhvwdFnBvYvvfzn/ucsuC5T/C6F4ytbDU=
X-Google-Smtp-Source: AGHT+IE90eJykgwlLq6LrJzKnujY8LCDyZPy1SZa7XTZkQZFTXfuHu5TUiO7YqD4A1awp1OsNprVEA==
X-Received: by 2002:a17:906:ef04:b0:b44:cfe1:ac93 with SMTP id a640c23a62f3a-b50aaa9c403mr2034340066b.26.1760334978370;
        Sun, 12 Oct 2025 22:56:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: [PATCH v3 5/7] gpu/drm: panel: simple-panel: add Samsung LTL106AL01 LVDS panel support
Date: Mon, 13 Oct 2025 08:55:40 +0300
Message-ID: <20251013055543.43185-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
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
index 6369e5828189..bdb53824e3ed 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4223,6 +4223,37 @@ static const struct panel_desc samsung_ltl101al01 = {
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
@@ -5390,6 +5421,9 @@ static const struct of_device_id platform_of_match[] = {
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


