Return-Path: <linux-kernel+bounces-830778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29870B9A7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA71B24187
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E130C34B;
	Wed, 24 Sep 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzbxCt3M"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684F30C340
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726531; cv=none; b=r0NiDY6lfMu+h3A6t3kkuo6nMZiV/o5BJuMWUL8hgZDhvVB9FwCWEW09H9kK3czkSO/0XpnX1Cv6d65GE5YN/l5fi5esk7/mEmTdn4hn1xeADsoXWiT9Er4X3l+/FyGTCB49Lc+YfJieGhK3hZtoofKfTlnejIbTX+t31CpG5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726531; c=relaxed/simple;
	bh=uv//tTQkdWUOMylUjOz31Zc7MGTY0kN4NR2rEqP2pKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twAx+9UylW2TwyUz77plV0YmxCbI+vTbmwfQSeEpCA/mVqbtAI5bPvzqCc3BYHIroS7EZRVCIkRXDQXZucDgcbGf1Zsex1Vhx1wz1Hpbm4EEiCMjgUXErY7L8/ufD/ZjwsNhR23k4gQaTZv07ffbPL6oertplK5hWY3flLC34PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzbxCt3M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26c209802c0so53103295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726529; x=1759331329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mtm7YfP7BSI3RTZ9+FG8XqmZhlh22m357qfVk/qkxE8=;
        b=GzbxCt3MpAgMygR+L5VBtXpBYr1sfYesrkNK7CMT7+ATGm9uPpekoJRgI2bc2aXECK
         iEF49JonXfM4Z6mp9bsR1uXg7hEZpq3Z6mwtzViuugoApm5IzK1qKoDup3ihfAlaUipV
         Xazt44X0DzgCHG4YwRV7Fd7euOj4c+FFqArtw8DETvX0a+3d7VEOOFisNO4hNdO3lJKT
         l3OwELr/ytLsP56IDuh7TvDfywg+F3WO3ex2Pbk17HtqHWRE9zAfUCMm0hPAojHIRAaU
         NVSdw+KD67K2o5V1k1rBV+aXnNuhhHUkWK0N3QkAYQsI6ftsmLtSzVrs66IdQImkD0Pn
         /vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726529; x=1759331329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtm7YfP7BSI3RTZ9+FG8XqmZhlh22m357qfVk/qkxE8=;
        b=pRxe/Oyp+2PsDyg7Rmr81ZqeNqfhUI/0nyFNUEO381VieK2v8kKnOAIYewqwzJZr7V
         Sa0Ayk8PmZv8t3NbC5hz8Q+6udYoFpMdKACIaXJhmPGFDvDur2g3OrkROIZzByq9l0JM
         HtaUeXLzTgt4ItYSn/qMVGOX8m93hzKk+2Q27W4qHYELNgEurqKCZwNQlen2c4bBj9sL
         PgQHhFL2gQFV81t9ureIdZly5ncJ2nGRDQC9+uorhM72UwBL7mH9jLn8r5wy7E9jAVjl
         L0KYpF8QzoeQlC3vgpGhiFY1+KwWMT4f6E5v63dZIWdpwls8WYGAxsb0v2S7UaXKzm9A
         hpLg==
X-Forwarded-Encrypted: i=1; AJvYcCWrWUx5FxdpirB+rqTAxd1rk7FOjwDGC0bC0yw3OBgdeHoV81Zxg2jN4ZRYmTIvW0YkPN/u3I17oArhMIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwXX8yqnMWzCD0WK4IiEyxubEQKblpVF/howvZQWywnNI+wZP
	sQ3F2C2V4hMgP3U3nBYag68rQxg5TIT51ZsmxLt2u1TA/svpVyXOjlHi2nON4YaB+cc=
X-Gm-Gg: ASbGncvIw2ftpqjTtk8+AGf11oT8CmHz1w7i4ehY8GFBBSYfaKSCScjDKMiQhYB8S4h
	1QyjjcAiQDEw+VWDQYQ/zKNxxvkIVkkgnZzp8s0q5J/m/nunVQxXacMNRjog2tgHCazQXGOSd6l
	U4uywRuQNetlU79AdNZMRss5GpCJ2wfaKSY8sLoXNjYSBbLUMeAGRVODlyku+O12PAXPTIDiDmj
	v8TJEvj4itg7XxqprKXgKLp+bzkn/F5psBd+9ez4FXOauSPmWVk5X9sQ4Yy+P7y1gkyY4htSk0a
	PhMlwkUOK4QuUgSS52JTOBmDViJpIx4+Yd/RpHtIEctRICu3c5Qdo/eyn409wntp+QiqcT9U3AD
	LpquqjH4bMaNTnUP5
X-Google-Smtp-Source: AGHT+IEEfbkQbo6VyHZL6DNe6uKS5V8miS4VoGJIvm14SbYPZxktKLOnaj7fLoQ1xnJPrs48EB5euw==
X-Received: by 2002:a17:902:c409:b0:269:96db:939 with SMTP id d9443c01a7336-27ed4af3882mr21675ad.58.1758726529408;
        Wed, 24 Sep 2025 08:08:49 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26b59d6538bsm158717445ad.82.2025.09.24.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:08:49 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 24 Sep 2025 23:08:12 +0800
Subject: [PATCH v3 3/3] drm/msm/dsi: Support dual panel use case with
 single CRTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dsi-dual-panel-upstream-v3-3-6927284f1098@linaro.org>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
In-Reply-To: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726499; l=3407;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=uv//tTQkdWUOMylUjOz31Zc7MGTY0kN4NR2rEqP2pKI=;
 b=cbwhi38kXfeCUrP4iZc3vGzSS+7SXsK87SMxbLuZ9SDfEikysPiAQH8mgdl2o1BXHWxilRTI6
 p1c+UJbkOexAxVBPSqmtKoMbjP0ZBRrXe9yAPnK5V74UKYdfcPyy0MI
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Support a hardware configuration where two independent DSI panels are
driven by a single, synchronous CRTC. This configuration uses a bonded
DSI link to provide a unified vblank for both displays.

This allows application software to treat the two displays as a single,
wide framebuffer with a synchronized refresh cycle, simplifying rendering
logic for side-by-side panel arrangements.

At the DSI host level, the frame width for each link must be that of an
individual panel. The driver therefore halves the CRTC's horizontal
resolution before configuring the DSI host and any DSC encoders, ensuring
each panel receives the correct half of the framebuffer.

While the DSI panel driver should manage two panels togehter.
1. During probe, the driver finds the sibling dsi host via device tree
phandle and register the 2nd panel to get another mipi_dsi_device.
2. Set dual_panel flag on both mipi_dsi_device.
3. Prepare DSC data per requirement from single panel.
4. All DSI commands should be send on every DSI link.
5. Handle power supply for 2 panels in one shot, the same is true to
   brightness.
6. From the CRTC's perspective, the two panels appear as one wide display.
   The driver exposes a DRM mode where the horizontal timings (hdisplay,
   hsync_start, etc.) are doubled, while the vertical timings remain those
   of a single panel. Because 2 panels are expected to be mounted in
   left/right position.

To maintain synchronization, both DSI links are configured to share a
single clock source, with the DSI1 controller using the clock provided
to DSI0 as below.

&mdss_dsi1 {
   assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
		     <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
   assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
}

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index de51cb02f267205320c5a94fc4188413e05907e6..1fddcea7f86547258be18a51a0a3e3f96f6c3838 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -177,6 +177,7 @@ struct msm_dsi_host {
 	bool registered;
 	bool power_on;
 	bool enabled;
+	bool is_dual_panel;
 	int irq;
 };
 
@@ -935,7 +936,10 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			return;
 		}
 
-		dsc->pic_width = mode->hdisplay;
+		if (msm_host->is_dual_panel)
+			dsc->pic_width = hdisplay;
+		else
+			dsc->pic_width = mode->hdisplay;
 		dsc->pic_height = mode->vdisplay;
 		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
 
@@ -1609,6 +1613,7 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
 	if (dsi->lanes > msm_host->num_data_lanes)
 		return -EINVAL;
 
+	msm_host->is_dual_panel = dsi->dual_panel;
 	msm_host->channel = dsi->channel;
 	msm_host->lanes = dsi->lanes;
 	msm_host->format = dsi->format;
@@ -2492,6 +2497,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
 	if (!msm_host->dsc)
 		return MODE_OK;
 
+	if (msm_host->is_dual_panel)
+		pic_width = mode->hdisplay / 2;
+
 	if (pic_width % dsc->slice_width) {
 		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
 		       pic_width, dsc->slice_width);

-- 
2.34.1


