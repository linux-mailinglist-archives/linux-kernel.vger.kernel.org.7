Return-Path: <linux-kernel+bounces-795856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14652B3F8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A552E1A86967
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5542EB5D4;
	Tue,  2 Sep 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+wgCC51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508902EBDFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802043; cv=none; b=kHSMW/btaT6eEdpOU6ZwPDBiCEMPzKJPg2hD4sG93AwaR6X8+xpwv2uOWr+QBJxEmsBwi5NNNJhKJC2h7+v92FuAs2CMjL9+xcWWHotn8HSnA+kMQMKkES8UBrCw62432menCBDC5JsRooKvgFlFLqSgwmlqAYh5OcFxDXAiw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802043; c=relaxed/simple;
	bh=7htVe8qzOBLCTGcYaqAkeRIfioQ4YdQGYbL+cD4yqKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZMip9Ry6dNoPmiy0MKhP+dDnD1koQjC+gNgPzMm/HRGw91FEr7QHh9zNYJeKaKS0/tyGXAjKC+T9nl+LU9JIm7RqRInPPGPcAfieQqTyHqExGAi3EeKvkRIHH7P1JufOzg2etdvm2ffRpAJLleOyK0d5ULH09QOx6DIGrzYhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+wgCC51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71DCC4CEF7;
	Tue,  2 Sep 2025 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802043;
	bh=7htVe8qzOBLCTGcYaqAkeRIfioQ4YdQGYbL+cD4yqKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i+wgCC51chdcj4XnR5i7iqsDbI9+aIZWhAp9XHWAJ8WoRQsqz4UjS1F/FJXZP1KzZ
	 dbYnaXpSYJoYWIB+cggDbM+NvKW3RCIAOMTufO+uvdtn+teYeGhZUs7Qj3IjWmkLjq
	 2uei/udkcwi6c/dOJiK9d4n0POtKwm/l5VBh8AYujqyv3e96cvQ63G9yP0IXDBSpo3
	 9wn1R5tMNrKkPxg1/sATxdki2Tl6QeWm3YwgTsk9f/89t/KQ8om8g/fKLzfkvgL5Tb
	 6TchgWKUBZaFKn46adtqort+67vP5nMMO+uOREsZkCwQ72HR9LfEN6Z4JdexduG38e
	 cw2Ou7b2bEAxQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:48 +0200
Subject: [PATCH 20/29] drm/tidss: crtc: Change variable name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-20-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7htVe8qzOBLCTGcYaqAkeRIfioQ4YdQGYbL+cD4yqKg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu99vm2SV1RxoPFSBRth//zassx67hUrU7vrC7MVy
 +pNbJw7prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwERm8DLWCq9p6fb4lTrpxi8W
 3h+d1+dOlBDbG9R9RD+Mv0Zly6ybm6Vu1s553d7m3esuL6t1NK+bsWGnUXdKWMuyMgnJ015fLy7
 8toVboNbeKqPpWozEXw/LKy4/k51MKuaYPij6+uypN39NPgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tidss_crtc_reset() function stores a pointer to struct
tidss_crtc_state in a variable called tcrtc, while it uses tcrtc as a
pointer to struct tidss_crtc in the rest of the driver.

This is confusing, so let's change the variable name.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 091f82c86f53bc76c572de4723746af2e35ce1c1..db7c5e4225e6247047087a35a2e6422950fc0111 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -343,24 +343,24 @@ static void tidss_crtc_disable_vblank(struct drm_crtc *crtc)
 	tidss_runtime_put(tidss);
 }
 
 static void tidss_crtc_reset(struct drm_crtc *crtc)
 {
-	struct tidss_crtc_state *tcrtc;
+	struct tidss_crtc_state *tstate;
 
 	if (crtc->state)
 		__drm_atomic_helper_crtc_destroy_state(crtc->state);
 
 	kfree(crtc->state);
 
-	tcrtc = kzalloc(sizeof(*tcrtc), GFP_KERNEL);
-	if (!tcrtc) {
+	tstate = kzalloc(sizeof(*tstate), GFP_KERNEL);
+	if (!tstate) {
 		crtc->state = NULL;
 		return;
 	}
 
-	__drm_atomic_helper_crtc_reset(crtc, &tcrtc->base);
+	__drm_atomic_helper_crtc_reset(crtc, &tstate->base);
 }
 
 static struct drm_crtc_state *tidss_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct tidss_crtc_state *state, *current_state;

-- 
2.50.1


