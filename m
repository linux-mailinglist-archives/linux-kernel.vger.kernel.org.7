Return-Path: <linux-kernel+bounces-833773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C37BA307B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3260626035
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39029B204;
	Fri, 26 Sep 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ub4wnbxz"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5629B8C7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876948; cv=none; b=jbQZ36p+PcWbq8tsRmHTG56ux7pkEwuKTl5Rj1krsDIQMqPVkO3WyQN7W3NS2AFDzLQIIWCn25rgOC8S0Z1OvC+GHolfFukP6I0WxUXLkxp0Suvzufjog6qZ12r0+8TFFZ2pXkWszhuZcSgHmVPhZAcFRcB00anolZby96IsEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876948; c=relaxed/simple;
	bh=IpVXztm7W6EPtCpetp4LnWs1N6zEfbtm9ulYpLL8B3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peKH7eTMpbKSDJb80OG8h/Y+/nDXQIil5NFvM5RA3gEYO9EicxIqTwdFmKE8QXUab11Vlo0aN8qgW/yLRTYC+yXSmtSD94mIO2XEqSC8vvayAFVS7qWBIUdOxq0ApeJSKqOgJc0jGXf4TPVmanrQYB1Ajnz2YMcLVG4+Kw0xcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ub4wnbxz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5915F3FD00
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758876939;
	bh=QPvssfoU/In85UShRKppyAS4KS/HDcgMvFxB88IBvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Ub4wnbxzWfUp7a89G4Q7TIIgv824m03bQDQfWF8VK0AHkOc54xI9bGIj0ja8lo6BE
	 LkLPxU2oTDYGzsfG9xm9OG7KIu7vmfzeGztRXCNyvNophUbVWDudnBPg6Cszo7jsop
	 KxbebMaCQqebyfAGaUnjoScfnh6wY2SBm241EiJBkvAnvzah9vdI408CDNCPx0ek4H
	 gXaMebQqUyA1kiNiQ0Y2bTfSmT76Q8qWgyq8A58GLRnHTJAVI3IuaSZlUmFrLZ/7EZ
	 nShrncKDjyuRmMtTJ33thWdbxSuAxDoNDxIQbBkmkOHSKXf8cujmclzC6FtfjhtzZt
	 Pan03yClI2zQA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b07cc3f115aso162878866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876939; x=1759481739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPvssfoU/In85UShRKppyAS4KS/HDcgMvFxB88IBvIA=;
        b=dgtdMGK6V7eJlcJm0dihGna/M99Rnjt9YZp8s8Ol8MBmJHBqzCDSaMxy2rRF3CjFwG
         c/pro6noPv/LyBAHVc5efr2ObdAwg64eg/3NMVg3XpTHjoFN0eFYZBc5yQ8PX4RweCaB
         BWil8DBAO0KRqNvGczTT9SVL8hRR7/1AG5BySD948UHzvyKgOT38GrYo7+36sfWxT4OJ
         jRLt8Ok8INVIYITbDlf24omTx/Cg1aWNsx1wNGsRv8Ad90q0sD8hWNxc0brl4xbf6Jo/
         MIHsh4slrRUz6PxP0wSrgtg3jr0ZJ+X61pTt10WMgIJiS6SzvY+5fAdUe1Q/vHd5zWQx
         MLTA==
X-Forwarded-Encrypted: i=1; AJvYcCXaNl4fHJqV9yjqVyz19jyqVCJdVEPuLze/bZfE+oB3U600AgrrsS299fy65vxGLwjnx5MOGQWs3HDgGQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0/tvw60UweXBpeqhWoGGMBskQp2HvIU3LEWdBQ1L7IiiC8Px
	IDFnjtdqeCwXzcQ4wFokVb3k7zjSLCbDYFwvJiMaZhhUpdDrtcHyG/UY6VoM9XeORYs/eVH9moH
	cVnUl47IEZw3yilq2NI6yW1hgEsXslzEPbPyj7A5+l/LcHd2NsUO1Ajf9wDtRxecWrp2XZXE+qF
	g7SG0NYg==
X-Gm-Gg: ASbGncuuZQIlMqH3d7iA4mP3Ca5miHGpT1MvTvVwtmIqPH71ISucOLbNWsUw2sUiuH3
	bL/J/UbDSF2EJofPl8gHQuerf/xYfiBM1YWDw9nvP4p+J1ianzb/BWHj/vQCzK3qlz8qtxzXSO7
	McekpJDYmipGz6ibENo/XeFlfS08ftbo8susxr6b/WoCDEyV8+Bi731nqZqF1o420gCxh3VI2Of
	N/ewlGNEg+7Rh25eeflTTrF9HEC+zw6gji5dCGR5cVwmdEc40yKwyS+IrIPQXWO+L4YG4Twqi6m
	XAZdQCsxkaRyZH6hD8RTCo+q63b8VeY3MeVmpMrjC/7qtWAuNynzUH/q
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id a640c23a62f3a-b34b7209d39mr684711766b.1.1758876937751;
        Fri, 26 Sep 2025 01:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKOuBVYc49IRA7cnoojgLB1GU9kfFCS1Pkn55N8wl2zqripG2XOg0L/N0FVk2bCqkw2RK7OA==
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id a640c23a62f3a-b34b7209d39mr684709066b.1.1758876937337;
        Fri, 26 Sep 2025 01:55:37 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7746sm328087966b.59.2025.09.26.01.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:55:36 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	suraj.kandpal@intel.com,
	imre.deak@intel.com,
	joonas.lahtinen@linux.intel.com,
	aaron.ma@canonical.com
Subject: [PATCH 2/2] drm/i915/backlight: Add get brightness support of DPCD via AUX
Date: Fri, 26 Sep 2025 16:54:01 +0800
Message-ID: <20250926085401.2808634-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926085401.2808634-1-aaron.ma@canonical.com>
References: <20250926085401.2808634-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use drm common helper to read brightness from
both luminance and AUX mode to support get_brightness from
DPCD via AUX.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 0a3a3f6a5f9d8..0ee6fd0f41ef0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -454,24 +454,16 @@ static u32 intel_dp_aux_vesa_get_backlight(struct intel_connector *connector, en
 {
 	struct intel_dp *intel_dp = enc_to_intel_dp(connector->encoder);
 	struct intel_panel *panel = &connector->panel;
-	u8 buf[3];
-	u32 val = 0;
-	int ret;
 
-	if (panel->backlight.edp.vesa.luminance_control_support) {
-		ret = drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_PANEL_TARGET_LUMINANCE_VALUE, buf,
-				       sizeof(buf));
-		if (ret < 0) {
-			drm_err(intel_dp->aux.drm_dev,
-				"[CONNECTOR:%d:%s] Failed to read Luminance from DPCD\n",
-				connector->base.base.id, connector->base.name);
-			return 0;
-		}
+	if (!panel->backlight.edp.vesa.info.aux_set) {
+		u32 pwm_level = panel->backlight.pwm_funcs->get(connector, unused);
 
-		val |= buf[0] | buf[1] << 8 | buf[2] << 16;
-		return val / 1000;
+		return intel_backlight_level_from_pwm(connector, pwm_level);
 	}
 
+	connector->panel.backlight.level =
+		drm_edp_backlight_get_level(&intel_dp->aux, &panel->backlight.edp.vesa.info);
+
 	return connector->panel.backlight.level;
 }
 
-- 
2.43.0


