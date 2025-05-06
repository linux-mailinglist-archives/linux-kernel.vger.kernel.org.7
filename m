Return-Path: <linux-kernel+bounces-634974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765CAAB5EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88F11883217
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93504B13F3;
	Tue,  6 May 2025 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxf6jSbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C72857FF;
	Mon,  5 May 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487449; cv=none; b=XPC/r9BuWF5MvI5xF1NbWfARwR+MfT0Ky2usAULrvIjEn6px7sdF8Qk2QPMje/mwhNqZlqFs/ZBkqO+w0JqtJmnCRhbGBmnuJPIypP//pRB0obLjd8LSHEtVH4Df0AJ8L/z1TxRnH61DHC8RXljIGT6pktjSl2Xw01ByRvN6bKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487449; c=relaxed/simple;
	bh=jFzjI0qQiIPko2HExKolk6Id54lKfQ1zZvtX8oXdN4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPa59vXpksxjQhNQp5Myt/hXI2DNjtRTp+sJvd6RFORcCZ8ZSNZygwlGxN8St0qXi/pzpE/QhcpLVEcEOmIUSR8N8iZdfWJvDK3GRvygLiFHhg0eiSlfp2vQ/akn4PshaLzitsyt7nA5LifjEY0k3C3W1N7MrbqaW0nL1Lxhjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxf6jSbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584EAC4CEE4;
	Mon,  5 May 2025 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487448;
	bh=jFzjI0qQiIPko2HExKolk6Id54lKfQ1zZvtX8oXdN4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fxf6jSbqjLZlof+omE/gphn9mhz9Kd7VYoSuwBMk34/UdR9hoigBFMzikcSOvxfOf
	 7Gxg1L78dDuNEbAJxTOLgeSPlu+NMybPDA6J8DHSFkmW1XFrJVHLO0R+MzwR9yvsd5
	 H5vPgjYyorlTqJIVfD/M4Y++pWnqkYSqugyZs+zJimtCAbf97AzgwyfLZNSDuCIEUP
	 7BuYEjt/MS+zOdoNHZP03S04xxR3gYPl/1c7PBt3k4j0sGY8wEUg6TH6Av9QNd060O
	 hxV9c6LdqeeZw0LjmU5G6vxqvuiUF3N5bgtryQcKJbyMAcvMTPaOFOuInP1A4SvBeN
	 0ZxvXBPQ5k5Rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Simon Ser <contact@emersion.fr>,
	Manasi Navare <navaremanasi@google.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Simona Vetter <simona.vetter@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 78/79] drm/atomic: clarify the rules around drm_atomic_state->allow_modeset
Date: Mon,  5 May 2025 19:21:50 -0400
Message-Id: <20250505232151.2698893-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Simona Vetter <simona.vetter@ffwll.ch>

[ Upstream commit c5e3306a424b52e38ad2c28c7f3399fcd03e383d ]

msm is automagically upgrading normal commits to full modesets, and
that's a big no-no:

- for one this results in full on->off->on transitions on all these
  crtc, at least if you're using the usual helpers. Which seems to be
  the case, and is breaking uapi

- further even if the ctm change itself would not result in flicker,
  this can hide modesets for other reasons. Which again breaks the
  uapi

v2: I forgot the case of adding unrelated crtc state. Add that case
and link to the existing kerneldoc explainers. This has come up in an
irc discussion with Manasi and Ville about intel's bigjoiner mode.
Also cc everyone involved in the msm irc discussion, more people
joined after I sent out v1.

v3: Wording polish from Pekka and Thomas

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Manasi Navare <navaremanasi@google.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108172417.160831-1-simona.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_atomic.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 927e1205d7aa4..202975db784c6 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -323,8 +323,27 @@ struct drm_atomic_state {
 	 *
 	 * Allow full modeset. This is used by the ATOMIC IOCTL handler to
 	 * implement the DRM_MODE_ATOMIC_ALLOW_MODESET flag. Drivers should
-	 * never consult this flag, instead looking at the output of
-	 * drm_atomic_crtc_needs_modeset().
+	 * generally not consult this flag, but instead look at the output of
+	 * drm_atomic_crtc_needs_modeset(). The detailed rules are:
+	 *
+	 * - Drivers must not consult @allow_modeset in the atomic commit path.
+	 *   Use drm_atomic_crtc_needs_modeset() instead.
+	 *
+	 * - Drivers must consult @allow_modeset before adding unrelated struct
+	 *   drm_crtc_state to this commit by calling
+	 *   drm_atomic_get_crtc_state(). See also the warning in the
+	 *   documentation for that function.
+	 *
+	 * - Drivers must never change this flag, it is under the exclusive
+	 *   control of userspace.
+	 *
+	 * - Drivers may consult @allow_modeset in the atomic check path, if
+	 *   they have the choice between an optimal hardware configuration
+	 *   which requires a modeset, and a less optimal configuration which
+	 *   can be committed without a modeset. An example would be suboptimal
+	 *   scanout FIFO allocation resulting in increased idle power
+	 *   consumption. This allows userspace to avoid flickering and delays
+	 *   for the normal composition loop at reasonable cost.
 	 */
 	bool allow_modeset : 1;
 	bool legacy_cursor_update : 1;
-- 
2.39.5


