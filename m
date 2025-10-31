Return-Path: <linux-kernel+bounces-879995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144BC249A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EC4F4EE73E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3890341ADD;
	Fri, 31 Oct 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bSuqlJx+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1E30AACA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907736; cv=none; b=he3nPBq/alxpkxk8pe8lw+WYQpbHB6AiJIFu/npaZGnZm0GFi8R2fyt8FLQ+Om1SNAfK8qg8QoWFkb1MSOfyR6tMeHEJ0Kr0PRGwsIKiJAbnHsJZzbKbCyaWNYF9EQ9ic0SQvGPYKzqgMzrkaqaz1cAnoNDbtaNRpqzbtBgzyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907736; c=relaxed/simple;
	bh=R8+B0M8fgEybgKayD/mROBr1emOVwRW00BDXcY3kWjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUSzmyLJQjYg69f7ZaCWuBKoxafc+Bdut4dOOihJQZXf6JfOx5p1fw2KERlsLhTrjCQiR6qqeRooejDlQ5iHzha0Mb6SMyR9gn7JY4kL4+Rpg7+aUEsVsUWYJDN0ND9MyNhZBOMzZEobp7nJRtCbuiKdRlZtYFE5VEkmMXMPKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bSuqlJx+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429bccca1e8so645182f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761907732; x=1762512532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zo2jj2MOuswONrFhs1A8zruhpNCnAbrPgnW3srwcDM=;
        b=bSuqlJx+9/fYgRheiDeern7teQbQlP6SBQRgbtYB8P4+NhX89tz596itiwSeHvYWYc
         Vcz0VRd0sOY6+u0QkwQHF68zPdZrwro8Q6SKSO49YTYcIQKiiVw/v5usXoW+P2ygmrgq
         vnj9NTkr8WSrLdB1Tqb0qgzz4FFSPkBDtFsnGV74Ait4KoQSEOQmkcn95TGIQxtjRIh7
         INEjPW4I88Sq9ZRwstu5O6zRuhgBS0eSenSak70ffXL2eG31ubpJLJ6grBjTag/Q4YnI
         +wNbC/tSFrLCwoeZ8fB5vTeyLCxU6suDfNIZ/f6o7ifhlQ4xxMgVLcHETtKvK3LZ42ym
         eAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907732; x=1762512532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Zo2jj2MOuswONrFhs1A8zruhpNCnAbrPgnW3srwcDM=;
        b=tMetYbjOK+Hx30fRfXolYkOB8Flzf/GPmiO1i0qIZlxbEK3sGgSlihVkeZqLhRFDU+
         0yxRVjoNIRa8ih3EhmnxzVWNTCpTHcMiPVSSQnoA2WMd3XyFaTKkOxG2bHXct8NSVmD4
         WGL8bDHjpcOv1i4KIx5cwxLMaWTQHNISLmpH8zwnNHIJGr4WdJaHBHY1N/2TvfJO52cn
         C1qZnoqciXrQ46ehW1P/OUbCA85lrdSVErIyBhLxFByicndWx2/ppe9wWfo6cm8nlelT
         YNiOFiiVdCaI8aXOpPFSlHzj8vl2RAPus/UC7sF5libBg2qoZoCd+bNuDgATJGbZ/VxD
         b7fA==
X-Gm-Message-State: AOJu0YzFxYT1Zvj7yamzi+ofXe9TRAP3bRKjfcQVqCG79wCVoJqPFL07
	F3PhLPCpvDJrUKQlupFL1orvtuvUPnj7MFOXsQN/WNMY73Woc7QR6CPTVkiXph5DCSB63+guh4l
	NomQW
X-Gm-Gg: ASbGncvwImtPyaOlx8cb7ah/FYF7lqasBJWnXB2YHqR8ONpNQxY6fl25s9SW5NUNTpZ
	K5dC5jMnfLqnwyOKSKsiY6gYyzcFlCskqMEqvnSbCr1ssX+K9aQ+SsbksWYkZiMa9Oi1dMNoKY+
	t4UUfreVhkNpwyUsEFGCewubFlAykeXeemTKbUgmqSrXoZY5mbb51n5nkBOhWOJJ/k4uT/G26E0
	7o/bbgcb9fLpptKHDv6Sag47Ba8WekNuw5hAtrvqR3Ek0JbGQTIu9HmEeKqvMEfFLpZEZGywhYI
	FRInkCjBmmjw0it171Ph4pPvP3XHs6UVhLfY3qv5bP64APtZEGkdRhjdi9a/RxYroKF1c1U+7rJ
	RnvYDn8bEZLz+K49OXk7SI6GqrLTfOxY9+/+0ipFRr8MkCjFPWJ8HJfUjyXG6Y9dVToTLoua0L+
	ZlMgchLd4Xi9IytYFlCsFXSba8QXS76+r3TSI=
X-Google-Smtp-Source: AGHT+IGobibt4LNxx3fw5hmxTlHoYafBePMtzQoeq6djNMJvhNOcnjqVzzpJ8k598YLOu8WNRveGDw==
X-Received: by 2002:a5d:5d02:0:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-429bd6a8f88mr2587154f8f.47.1761907732011;
        Fri, 31 Oct 2025 03:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm2961635f8f.0.2025.10.31.03.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:48:51 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/2] drm/rockchip: replace use of system_wq with system_percpu_wq
Date: Fri, 31 Oct 2025 11:48:46 +0100
Message-ID: <20251031104846.119503-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031104846.119503-1-marco.crivellari@suse.com>
References: <20251031104846.119503-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index ed6e8f036f4b..deeeface0b63 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -276,7 +276,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 
 	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
-	mod_delayed_work(system_wq, &hdmi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
@@ -319,7 +319,7 @@ static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
 		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_CLR, 1);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 
-	mod_delayed_work(system_wq, &hdmi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	if (hdmi->port_id)
-- 
2.51.0


