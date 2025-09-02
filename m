Return-Path: <linux-kernel+bounces-795857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E9B3F8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3811B1A86DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E532EBDFA;
	Tue,  2 Sep 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTK+aPB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56382EC0BA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802046; cv=none; b=b9E+SjIle3DI6sYKIcLxgDcczbdQK0Uw9hVQ5drdY1NWD6piwEcO4fwkxq2vioYpwufLwcK/6qhDqAzPYjqQzBtOdCq2XaA484F/zOnuIgIoz4onA5D+roOLSG9y86QgfuTEihXd9i37qxpJedmfY0HhdeExcrBuGOrs1owGUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802046; c=relaxed/simple;
	bh=Sx1SiWBtyvx9TDs81K147uwwCFZefbSRe2g1f7tHAGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqRcKk26+vXxYp0yOJUWqUeR1kB9UnIcRMe70TJIRs7DiWBKwuyoel5IokLaSBFNUChYdyTy+eNvHCSxGUkpjXSVgnBoOr2NH2BKd5xYQapeQxUVOc2aTkx0uZCZDSERCLEplTxwtVlwQF3LNAV+kc1+2EuYA+vaf8hONStkG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTK+aPB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BAC4CEF5;
	Tue,  2 Sep 2025 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802045;
	bh=Sx1SiWBtyvx9TDs81K147uwwCFZefbSRe2g1f7tHAGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTK+aPB3SO4+njn53esBnhzyx+sUJW1leLBrRvhXiWfmA6QjHepkh7etr+zIYvpZP
	 QQOS2Mh2fLnOUS8j6N1VhhkQL7B3SlzC8XlvGYLRJqW6+nvxPXz+vsM1v2A7dFOBy2
	 TPYgZS1rb5LQmrKYhO3x3MaflW2nDcbH7KfjqE4OgudAqQ9VC9lGZNRJph9HBdb9ND
	 7UijJshHlF5eO96T0ZQA69eAlxvoZPDkyjy4i8JnaRf/SxFBtSwzYAG5rzIp4gfZFl
	 SNcENSp+uEfDemz+dudotg9y1lyabhpK+nUSEEKs9QQFpRwCYWSlU33LU+6xIQ1MpC
	 f0YNtT4DEYPzg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:49 +0200
Subject: [PATCH 21/29] drm/tidss: crtc: Implement destroy_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-21-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Sx1SiWBtyvx9TDs81K147uwwCFZefbSRe2g1f7tHAGI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu896ua9wGxF4r+3d5+YP12poCC8evsiC6NHrKvPh
 HHONsvn6JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATqStjbFi3/mDxjoupC3+J
 Cv0K3Ddrp19Z52a1hnLm8lXVQubd1Tcn3WFesyvipvryJTMLjq6J4mGsdyj8uenf2m1rnSz2buR
 br9zQL2r0+v0rW/5pl8TUXPLsb3b8cP4xr700b9XGxNbvK4x9AQ==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tidss crtc driver implements its own state, with its own
implementation of reset and duplicate_state, but uses the default
destroy_state helper.

This somewhat works for now because the drm_crtc_state field in
tidss_crtc_state is the first field so the offset is 0, but it's pretty
fragile and it should really have its own destroy_state implementation.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index db7c5e4225e6247047087a35a2e6422950fc0111..eb431a238b11d22349d61f0e17f05994f50d5f2f 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -341,10 +341,19 @@ static void tidss_crtc_disable_vblank(struct drm_crtc *crtc)
 	tidss_irq_disable_vblank(crtc);
 
 	tidss_runtime_put(tidss);
 }
 
+static void tidss_crtc_destroy_state(struct drm_crtc *crtc,
+				     struct drm_crtc_state *state)
+{
+	struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
+
+	__drm_atomic_helper_crtc_destroy_state(&tstate->base);
+	kfree(tstate);
+}
+
 static void tidss_crtc_reset(struct drm_crtc *crtc)
 {
 	struct tidss_crtc_state *tstate;
 
 	if (crtc->state)
@@ -396,11 +405,11 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.reset = tidss_crtc_reset,
 	.destroy = tidss_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_destroy_state = tidss_crtc_destroy_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,
 };
 
 struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,

-- 
2.50.1


