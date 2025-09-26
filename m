Return-Path: <linux-kernel+bounces-833845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB9BA332F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DED1C026F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510721ADA7;
	Fri, 26 Sep 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L4fGquG7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151729B8D9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879626; cv=none; b=C+NAfIfjBB9L9n4ye26SetXQqfKI1NHu8MVOXkdvdD7dtsfKZX/T7+Ic0J+hjE/809daygQtNpYq53A7wa3Fjx/T5Cx8Opd8EAM8jEXotPrESFO7JpHDfZt5x82IOcvTrww86qWqJF5vS0RXQGV7BBOVNo2uguFOkxNibtwmjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879626; c=relaxed/simple;
	bh=0qfGR8Wjs1uQmtjCOjHSs+6im+FY973DfkMzxVb/y3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocXZ1KHZ8Kx+bNXamHgdL8MjHKDr6Xl+FLWV7C73Ti+zxN+D/Wvg6UKA0T5XjaSl6j7Ul58Ecl60dgQDSJMRyli0M2+Dfmblws8mYUtKoeeuVJ6HKIUfJBHD3JiSDNmuTkOq9NDhO0WMtg6xRJxPl/Av3ninI7YmMDa/9R7kKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L4fGquG7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D5CCF3FCFD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758879622;
	bh=iBhi1FHDh4LBnl6LQ1TVC38qnLfe1cV9s8WGnxsTQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=L4fGquG7CaMBDblEtmt6DYl836wYRAiHh/ETTEcMHIcEhbLhDsC+z56KU85BJEXyx
	 C8c3g5xzs/i+gtN2aiPsJOVrOseRAmSZs2h6j98MhpUn9DSsaHMqQr9YcZLnS6PFD7
	 F9Iv2dTgaj+PcLAYZ/D9psQiArNuvlz3voCywmWYOR4v1Tfk0dQgdqtqe/QZsKbGlV
	 JdBCOL2x55FDELVG59FcqTnRWa3D9iqApFqJrVdsNEUC+7Y9qKK8DLa4TMJH1OF/ib
	 nP8iZeh54JPoqkOFK3V/bMzfNZ06aCQ9iTNL4XAtSgYYzhODMzWmbhnEgIfBWIanPL
	 V1BI67n2NYIAw==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso32026816d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879622; x=1759484422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBhi1FHDh4LBnl6LQ1TVC38qnLfe1cV9s8WGnxsTQXk=;
        b=ruhfh5nDOAGE1ZALTE3293LDhWtT17G2fBd8vzl3c6pEW6LLu5J6TczrflfDPLaLrz
         bnzzK80SfZi1OGgtadS+YWeFNoFrNAJO6cFiR9dfQXeXJz3R9lorZzGx6x9aygQTGYcX
         sXERqW6HpN8bUjRU5ChhM5nk/t2I4pxfoM7mDPSyapor9eaHj2Syr3/05l3SuaqtpTIK
         ja2+igQeARw6n0QHjMp1RV66RuzHCROzuLhepwMQoftM1Z3sZbfcQyLAXVmxYvMs5ndr
         F/PUzGdFP6moEkpiGmkN9R9qK5IcLlgdLkktrNJEtKotfVFHoh/+032ICExy3xjYHN24
         p4RA==
X-Forwarded-Encrypted: i=1; AJvYcCVXUm9WiXLuRb17w5DHQnJ2blHUVY0HJ3nq4m8cScWDkfLphIfFIweLdCMo+q7kJOTXRGpbuixzRFCGGhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6sedPWb4hDPzurTq966MgApk0CuUz6Sn6v6AVSPCtPq3N8Jl
	bsIHavyoyXtAFF9Cag63YaP+lgRNj/kfDW2fgS4MhUwOknmEZNUPbo3SbxufCTqlRp2xRJHFIuF
	RWOQQbFw8DTJ+p1itJn+9qWTFXHns/20eqYEsqtu1MdLB+Sz1LFna/FNtxxMxSDgjnMRyfTZZMj
	9t3ySZQZPJj+aeouRT
X-Gm-Gg: ASbGncvh9eivL7DAW9FdbZSkH6+6/BCNWO2G6hsjx+aBUbq/eEThrjYYjsDa4a+mx3c
	gv4iQfdIlkCGSYVzEACd5/R6ezVdiZpYB0h3JNHzuEWftyHAiXvTo9MyEVKtZ3uv7PvwxFPXKoh
	uQPca1Q2ErkHuxEOgJbVcCu8iQAR0jKKuWUdZwWA7J4vNfcNnCvM0V1KrsGmvvceaX1UswA/vjc
	Wvb4A5lHzTh7SrUdcZ/3CFktO4nIHF1sT4sB4iVYEevMVm+TZvN6OETibK6AtkB7SOKwuKPjf8y
	LlHchj0zyyj96Dm4iMI+28G/Ra28YJCgQlRezgvPy/15zmB01NZNrBPc
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id 6a1803df08f44-7fc43a4e9e0mr75976426d6.61.1758879621855;
        Fri, 26 Sep 2025 02:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBlRiSrsDaRBQl+0u+Wy+05VWxe+n3WtRVYWHsQ8i4pZioZPIg42a7BPl3hZY7By2C8+lggw==
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id 6a1803df08f44-7fc43a4e9e0mr75976286d6.61.1758879621509;
        Fri, 26 Sep 2025 02:40:21 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b563b2sm23419766d6.14.2025.09.26.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:40:20 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm/i915/backlight: Add get brightness support of DPCD via AUX
Date: Fri, 26 Sep 2025 17:38:32 +0800
Message-ID: <20250926093832.2811200-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926093832.2811200-1-aaron.ma@canonical.com>
References: <20250926093832.2811200-1-aaron.ma@canonical.com>
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
v1 -> v2: no changes.

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


