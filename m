Return-Path: <linux-kernel+bounces-692304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3358ADEFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5873A66B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743022EE5F5;
	Wed, 18 Jun 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0hno2h9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CE2EE5FC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257219; cv=none; b=USjqU36HN6UGLQVsoZhFl2pKIogWRjV70mvpx97D8vSnqR6q/rLz00MAL5mDgg8IMBqMBLP6kcvx2xMbTqFalyDPiQOVARzwr8uzVXREpE4gz176B4dsfq2zCRABIwyocSXJZ64LG78lyh7WRe23t6omDXe7f7q223GFtNPFfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257219; c=relaxed/simple;
	bh=vGcKp2M1kIvMMMLRUyUZM1bYwOOlWkeA8i3yzwB9pic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8Yyn77tVgvyeX3llgM1EmLVG3YNYzrzgC9u5w6dqtO5O+z6eL0GWDJtlz+/tURGHujagq5aeJiPNvhfHj8Aw9C0UzTV6RkJU+cZMoi3eCIw1amEKJ9EaZLnEKNkiZmLNr2TrbRtl4fNRVCcj2wNYMLG0+gCr91/YNdA8cKeWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c0hno2h9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso1209229a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750257214; x=1750862014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0D24v4O6UkSmy0rykCGZTdteernnCPVR9bB+rSj3dQ=;
        b=c0hno2h93Lz4mAtV4/Xvqaay8WdP+f0nYX1tv5HUtQNwZTXVGbM3oTeTciJa/rfbm7
         6WDH4dyGA20F8+YO2Ay4BeACwSV/NGF3BFM6iaGqkXnyrrKvT8OcVUWSaTIZNztOXesI
         W/xEpoJ4IGAxylaIEcGV0HCEE5ZqryPX9OCNkUDed3hBh1YxzHyIDJcouTKmD7F3YOXr
         +48n+LcHf9a445Y8viy1GNdpAFZXP4mmDFEdFCw7jzUz2tf9qohdO2H9FxFeIrU9PIga
         E9Y1kj63ILnfJOeQ4rqEF+PtKEd8nZr6n8Bvc2Q/O537eRee8YunReGAPUedvxa6Jo87
         Zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257214; x=1750862014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0D24v4O6UkSmy0rykCGZTdteernnCPVR9bB+rSj3dQ=;
        b=LQJK6NEGJLQDHUH71OBQZ7XmlraL3czpI3uZsKKziYEZNnu0IBrXAt7QVDgIlRSR8H
         qKO6KM08FATdegAz38rv6xrxtFXNkrO/2nMka3ybniolmZcB5eCdyx4dfC1RiZHm0Jb/
         FBwTte4eOvmRDyaaoQWZe66asl7Htm/lMuZnoYDRIRDl/6sxdNBfghmhPYXWCkJ+GV+u
         KKQzjsSYvipFUPphzFAM1n26xyQ0gAiF4ibHDQ0yjug4sthjJy/zPUysLbklS9dYI57X
         fKQCekbjvcknrx4Js6RvK6jU7zM3q64gFLhgiIi9PXP0+8wn5LkLrm6IyGuRKjEOAFDy
         e8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXAjqmejMers+2qvseSB+faV4Qw04CleyHPPe3Yl2AvVUNjV0E7fBzyACscy95OIQu6f3rM7guws/G7XSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+icT3TiH0DWtGCMOl8zDYv10k6lAVrGODKUEAUyFj5LPr6s+O
	Ly2qmoyOVcors1cXsGSj5kDhwKsRAS9l1co9Td4cqwTMum41SnUREI9RwOCwPBYYzs0=
X-Gm-Gg: ASbGncuqpflA/PYmSnA8QORTzuG4vxVpaWFCAHRSpXe1pV/EbKgPU+ph40Dhxmlu8ES
	MMyIENeAdhuOH+T0T9VKkJoKxkKTWQsrzqx7+OobZA6MXyFJWcqUxdqnGZ2CeqeU+d1NfN0wLFk
	/O9zsCrLXuu5HJWH6SrhH6e3gwJkI0RHBSRuKSVzW7q01W4HgX8zgpnvMdt/iefBXLJWIm/bD4K
	0uV0kaQYkUJ4mdGXJILUotzHpyKGfE5OXaUMnQxBgBG+qTCMJDmO1wHs1GpIDtROlTDzN/B8SKQ
	WaEhUyo6NaR6bWoBmmy9IeUX13F4dZT4Pw7d5DEZfbeZeXVFfxAPAjHs6T9dni0mgiLrLqs5KH2
	iCioOilY=
X-Google-Smtp-Source: AGHT+IHgkE2gCR+Ei5NwFzycl9y1lzZWZhUYpRX9nSN6vqpHblczGcqHJFMnk3t0A6ezBgPP6h0riA==
X-Received: by 2002:a17:907:3ea7:b0:ad8:8e05:e5e9 with SMTP id a640c23a62f3a-adfad334a92mr669979666b.2.1750257214181;
        Wed, 18 Jun 2025 07:33:34 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c0135sm1052257566b.47.2025.06.18.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:33:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 18 Jun 2025 16:32:38 +0200
Subject: [PATCH v7 09/13] drm/msm/dpu: Consistently use u32 instead of
 uint32_t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-b4-sm8750-display-v7-9-a591c609743d@linaro.org>
References: <20250618-b4-sm8750-display-v7-0-a591c609743d@linaro.org>
In-Reply-To: <20250618-b4-sm8750-display-v7-0-a591c609743d@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vGcKp2M1kIvMMMLRUyUZM1bYwOOlWkeA8i3yzwB9pic=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoUs4h/bvBMDnugxk/SVMrhiTiM0BknFv1O1LbQ
 RDNHLoDJZaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFLOIQAKCRDBN2bmhouD
 102bD/9i8m4leeD6m/31EDYGZK93kQ1HUDdKDpzO3Gkl0CIoovW7mjwvc285U//45J6YfJxIhhX
 kp4DTekcKGmzmM+Tjf2CS38quCErmYBIwg8+m6lNjhZ7F950la1N3IY8Iu783D0O1iOm2SbAas+
 EpJjrHbRL5BD8r6xYoTWckwaS+XenPansOeqjEyFdSaDGRzJk25+w5Dr/n/ens59/LpyAoo93em
 P3YAM019UU6+Q9cqPjrX9m7aiFTwyfS6UXHWaNS5Ki9DXp6qFjQekiySIlFdmCfSWj21HkI9Lud
 uBtO0hDUq7vNTUrtbydsi27/zOoiDhiUPY+JccNmlOTU/P1ulkCYQzdNCfL2zJANw0cGzPus9al
 1DhksiVKGjKo1M4TCaU+raLUBdtDpBGuX2cLyQHeKyQcMV+u+idkh6TH9aN5Z/b9Oi3KdCeYNYK
 7240SDWIO+6e+WpEsgGAOGfVP1DThZbvz3rglVKQN+xGOuODQGJEb94Jjg6kq3SPowJY76KeaXc
 cSpwAE9FuMGdAGAYAnrFGgTuhM3o5VcQBWdR4nHoXc6rFIpCyJ++nbuNQDPQwsg+HM3SRpQsIkY
 k7dfSi+i/GXYwIs0CUfYeu54narF17Sc7jspJAkUIsQwhhg2L2l23Bf5xt7cWtrdoXXagfHVBnS
 Jncyo2xxfHElLEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Linux coding style asks to use kernel types like u32 instead of uint32_t
and code already has it in other places, so unify the remaining pieces.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v6:
1. New patch
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index a4b0fe0d9899b32141928f0b6a16503a49b3c27a..92f6c39eee3dc090bd957239e58793e5b0437548 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -323,8 +323,8 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 		struct dpu_plane_state *pstate, const struct msm_format *format)
 {
 	struct dpu_hw_mixer *lm = mixer->hw_lm;
-	uint32_t blend_op;
-	uint32_t fg_alpha, bg_alpha;
+	u32 blend_op;
+	u32 fg_alpha, bg_alpha;
 
 	fg_alpha = pstate->base.alpha >> 8;
 	bg_alpha = 0xff - fg_alpha;
@@ -402,7 +402,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 				       struct dpu_hw_stage_cfg *stage_cfg
 				      )
 {
-	uint32_t lm_idx;
+	u32 lm_idx;
 	enum dpu_sspp sspp_idx;
 	struct drm_plane_state *state;
 
@@ -442,8 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	struct dpu_plane_state *pstate = NULL;
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
-
-	uint32_t lm_idx;
+	u32 lm_idx;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(active_fetch, SSPP_MAX);
 

-- 
2.45.2


