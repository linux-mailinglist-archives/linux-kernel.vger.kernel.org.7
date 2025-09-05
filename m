Return-Path: <linux-kernel+bounces-803050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB47B459EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78783BEFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD535E4F4;
	Fri,  5 Sep 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P+auLbKc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58335E4CB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080745; cv=none; b=nSyIa5uv5IR6rkehXt+wGNaBC1AYWDnJff9VVG0nHkpu/tyoRiaKAftu9rQSL+U0OEds2q7q/RVyRCTB7JBc1Icx8p2U48XWPkZlWESVs6C8LCKETP8WLsx4KuVfKR1XAdC/s2eXxk9hUbySUu1Shlfx1Rc2j4sQiJjURo7ik+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080745; c=relaxed/simple;
	bh=Q6Wf1vTZSaIlKJqbaA1DqzvL+IqhH2Z176IYQMLiPD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRurejXyq4X+7qgjFK1M0yLOqu+eBE6YUx+hrNLZtmaSjud1G9hBWesrZ0Ih8062JfmoSrBMKXeQSHT5GdmgwVFK5FgygNpUUCmRKCFBjFa3LAAS+FxHfem4I6HIO+ToxZHYJH0C35WyeqITrf7n187cSMAUx5LoWyCh4pm+R3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=P+auLbKc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 551BF1121;
	Fri,  5 Sep 2025 15:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757080669;
	bh=Q6Wf1vTZSaIlKJqbaA1DqzvL+IqhH2Z176IYQMLiPD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P+auLbKcOvvDHIT23THo9Tnpfag9ob2f5r+RzND93z+9MB3O1i01vbSWPF1DRvyhl
	 wt9JhRgFZddytSYPUAO4D9l/49dcH/6h6QVpWtR88TIX68TZFohRzFUsSdVtfvG+RU
	 bd2gplQ/032RheRQI0T0TcFj1Fwn+VnTTNMNqZcg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Sep 2025 16:58:06 +0300
Subject: [PATCH 1/2] drm/tidss: Restructure dispc_vp_prepare() and
 dispc_vp_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-tidss-fix-timestamp-v1-1-c2aedf31e2c9@ideasonboard.com>
References: <20250905-tidss-fix-timestamp-v1-0-c2aedf31e2c9@ideasonboard.com>
In-Reply-To: <20250905-tidss-fix-timestamp-v1-0-c2aedf31e2c9@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4459;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Q6Wf1vTZSaIlKJqbaA1DqzvL+IqhH2Z176IYQMLiPD4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBouuyhQcJxaaJ7DbOUzaH2W8v0RIwP4qbKrh0dO
 RkDCB+xNjWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaLrsoQAKCRD6PaqMvJYe
 9SRLEACwnIDQboTmlgeQ0zMAOvHmlaz2nZ3kQ6K9Hw8mhAwUfMI2tw4cQLrOTjAOcYwUrzd4Rhb
 pKAuY9qtUhO8aqLhOqxBPB379m2IIaO0a/sYSkqAeSVX5Zf0hNkRZAXf6JYZ6Hz63JNByLO6j42
 SleOae15J/rv0B9Cgu8BbE5+4P7NMCqU5IvUG7JsPbSnnnjE4bvTkavwRD+MhvLN16tLw6sRQKY
 cRmjmeyZLWJEgkb2JI6JStv3uRwQxOi9aiFYOyIFc3KVY3XjRllCqPtEVrOaozBk04ikKCdssFL
 msRJsHnG563dx+lx5CQpykjIvqhULy/3WYxcEG5IJUjE1nRVdEznDFvYL9EBrwkXRB4pI3+Rthw
 ZQfFpqrVG6OEKyV4RPkabhS0WgPJ8Rv8NVM33IlvVUMQvFC3FaTnAyP8BHyg8CFrAl7I/etTQ37
 giH4rTPX5jTsYBUuTQo5pPxQ+ZXeqnXA8VbblF9+pU3CX7lOSvKdw/AjSTpJDrlQvLNn8v/l9/V
 OxpRxJCR+X5sLeht9i8p/0jGiXWkMW79W9txAAFviNLdhy8WLBj6KipS6oLAgYlhjK2FN4Kdu1T
 2o5F+6jCUr1oPCmcR95QIQb1wRKtBRl/7apw4A4ygtC5A4+gnsyVo8ELovRz/nNQ/vlTCdhjiLi
 N+5wxF6IJlNYxiw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

tidss_crtc.c calls dispc_vp_prepare() and dispc_vp_enable() in that
order, next to each other. dispc_vp_prepare() does preparations for
enabling the crtc, by writing some registers, and dispc_vp_enable() does
more preparations. As the last thing, dispc_vp_enable() enables the CRTC
by writing the enable bit.

There might have been a reason at some point in the history for this
split, but I can't find any point to it. They also do a bit of
overlapping work: both call dispc_vp_find_bus_fmt(). They could as well
be a single function.

But instead of combining them, this patch moves everything from
dispc_vp_enable() to dispc_vp_prepare(), except the actual CRTC enable
bit write. The reason for this is that unlike all the preparatory
register writes, CRTC enable has an immediate effect, starting the
timing generator and the CRTC as a whole. Thus it may be important to
time the enable just right (as we do in the next patch).

No functional changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  |  2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c | 22 ++++++----------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  3 +--
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index da89fd01c337..1b767af8e1f6 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -244,7 +244,7 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	dispc_vp_prepare(tidss->dispc, tcrtc->hw_videoport, crtc->state);
 
-	dispc_vp_enable(tidss->dispc, tcrtc->hw_videoport, crtc->state);
+	dispc_vp_enable(tidss->dispc, tcrtc->hw_videoport);
 
 	spin_lock_irqsave(&ddev->event_lock, flags);
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 7c8c15a5c39b..d4762410d262 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1161,6 +1161,9 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 {
 	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
 	const struct dispc_bus_format *fmt;
+	const struct drm_display_mode *mode = &state->adjusted_mode;
+	bool align, onoff, rf, ieo, ipc, ihs, ivs;
+	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 
 	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
 				    tstate->bus_flags);
@@ -1173,22 +1176,6 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 
 		dispc_enable_am65x_oldi(dispc, hw_videoport, fmt);
 	}
-}
-
-void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
-		     const struct drm_crtc_state *state)
-{
-	const struct drm_display_mode *mode = &state->adjusted_mode;
-	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
-	bool align, onoff, rf, ieo, ipc, ihs, ivs;
-	const struct dispc_bus_format *fmt;
-	u32 hsw, hfp, hbp, vsw, vfp, vbp;
-
-	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
-				    tstate->bus_flags);
-
-	if (WARN_ON(!fmt))
-		return;
 
 	dispc_set_num_datalines(dispc, hw_videoport, fmt->data_width);
 
@@ -1244,7 +1231,10 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+}
 
+void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
+{
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
 		       DISPC_VP_CONTROL_ENABLE_MASK);
 }
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 60c1b400eb89..f38493a70122 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -119,8 +119,7 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 
 void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 		      const struct drm_crtc_state *state);
-void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
-		     const struct drm_crtc_state *state);
+void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport);
 bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport);

-- 
2.43.0


