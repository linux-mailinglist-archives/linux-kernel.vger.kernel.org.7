Return-Path: <linux-kernel+bounces-795835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52594B3F884
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0B71A83503
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126642E718D;
	Tue,  2 Sep 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acf/IRqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA22E7167
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801995; cv=none; b=WLDzf9CylcpvpXW60JyKZ3HscypkR3nJK/5DQFyu1F+odYTdq84OxxyzZM0+rh8LWMFwmvH+W5s/tKEjothITms+seoiQALcdFZw3LMoc/vDUa8P0mYfv+XNXlF6eZx1JWYSWiyb/LHkftSusQ9rEqXE5p/lqnjGFrPfIOgQ/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801995; c=relaxed/simple;
	bh=kj637CfnoTBAP2JHnQ7FgGsKAbZI6lr9iDOVp8nZO54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSeGg+x+6B9Gn6+rccEGKBOiugYVMIkOuOQipd9sAl1c8YaGcDhGnCpk8SCsAHkajNhhYMW+6Ns146TXeKM38GMoYHVV7A8avBRA3wX9krdDcZBrY7m3vK2QI1KfJwQy418P2weelBeVzzPJy/7qW+T9lrBVOdsyBdYoyf+eOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acf/IRqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB278C4CEF8;
	Tue,  2 Sep 2025 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801995;
	bh=kj637CfnoTBAP2JHnQ7FgGsKAbZI6lr9iDOVp8nZO54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=acf/IRqRy1dKrnhfcpuPZZu44SXxfHaD14eBvgxd4JmMIxSlQ87quAx8LQubSh255
	 GW1XQW7Zxil7fd5WdQnYdnzWn99MBI0mi4UYjS3wmmNvuM7S88IWe8P5hBknorwid8
	 rc50C7zdWWy3mKnO9m4ZzwErsy6+xeJXJJmlVvBNNL/sF1eTQEFz9yYfPxZ3ivyMMh
	 ARMNJLDp3SshojoG8Rx/xgCOuoa7cigmtaLmXDpa8RiH1SMuqlZG0DdAIjJpyYz+XI
	 ZfSm/HjAd3JfCtuy57PAmXPAOtmrkbwWGdXSS8PCECrH2Yrtk6rxWToI6CG5JSLmWz
	 6o1qq/79PfnVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:30 +0200
Subject: [PATCH 02/29] drm/atomic: Fix unused but set warning in
 for_each_old_plane_in_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-2-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kj637CfnoTBAP2JHnQ7FgGsKAbZI6lr9iDOVp8nZO54=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGi2q7Wjc6mfQDqijIooGWom/m600NFGVJUGNt33Gto+wV8sg
 IiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmi2q7UACgkQJ1/OGaI9vnYnbQF/YvG2
 Mr1FKSJx5wr1GHBZJIDiihazgl00jO7Xszl0BjZNfpnxCVP6m2FEDiBw2jwBAX44O5ak4Zsn4aM
 gII9+PMoeUuQ6Dv892qnsDEffFrD+UnaaPoijyzSW5OF2wjpHG0E=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The for_each_old_plane_in_state() macro triggers a compiler warning if
the plane parameter passed to it isn't used in the code block.

Add a similar workaround than in most other macros.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 38636a593c9d98cadda85ccd67326cb152f0dd27..689a29bdeb4a06672ab6fffecb513d58ff6e07f9 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1053,11 +1053,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0;							\
 	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
 			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
+
 /**
  * for_each_new_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_state pointer
  * @plane: &struct drm_plane iteration cursor
  * @new_plane_state: &struct drm_plane_state iteration cursor for the new state

-- 
2.50.1


