Return-Path: <linux-kernel+bounces-795858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711FB3F8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA7D1A86F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCA2EC0B4;
	Tue,  2 Sep 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR+P5tMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882442EC553
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802048; cv=none; b=D29ls8uKqbNZwWH6I2uX42sf9xr+cQo2Wl41ziFgGa5UCGoPEpejfGbb6HAlqyXD71v8cIiz/EBPAwTA4nlo1PLsUub/ijSfDHwWTNUkuFomaLDfGo1l5D4j3gSbl3CVHr5ZSmHcvBovCR9UkYeKY3UKtEjRgimqLM3rFjN7C1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802048; c=relaxed/simple;
	bh=CJPCj8VWwLfpomy9Zok5G16ISXjah6HfvSiZNbxLUwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBna6oF4iGh3U1zGAC3Ej5tXTT+cYjqemoZ4KsC5OhgpBs2rQUXDZcZS6ee8fTsphZfNr3axctm84zCSRc6/wYbG6lGW4+jN3Ymoq1FdNLHGhGyuJZqobpGjgKQWkGr9bVgsOMm9OYAJ8YPMRhjVNJkyk6qmF6HPfS7NoU8Zcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR+P5tMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CFDC4CEED;
	Tue,  2 Sep 2025 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802048;
	bh=CJPCj8VWwLfpomy9Zok5G16ISXjah6HfvSiZNbxLUwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZR+P5tMY49rlPeoRiqsLU64936WnRpKITzZdZVJL8FcfjK5Nu6cykFbn/PbAHNm/Z
	 +cuIk4djsGxLuYOZnO4qujCTC149UOgHCTXfeFZtSX9x+HtCHuMyG8crUTNQV0L+0c
	 shjPKFai7snEiizUOWGjCSR2+D3WjTKDCe4mR6gXbWbX8liL9t4wc4gPE8XielDaz4
	 QLWEKDsFl6HuPbeNZf+dNrSYNTxReVPpR6T75+CvUF230b7ayDT89TehVcieRB8frJ
	 gt2uqO+TPekQhjjF7DeANlcp/9yJfv/qyolBgJbZzMQRacLNEgbu3JvL2M/QLg4LGa
	 NofaaLQIo6gUw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:50 +0200
Subject: [PATCH 22/29] drm/tidss: crtc: Cleanup reset implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-22-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CJPCj8VWwLfpomy9Zok5G16ISXjah6HfvSiZNbxLUwg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu/bOmdNXX9s+sodna/7Pwh8OVp9JnNPat4542ZLZ
 VGB99tOd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJHFjF2LDt+3u39Pk/Yous
 7sj8t4w/xvX3aBtnzKOTIadYP6+PZvJwOlz52rzs1fwdfvfUuNNEJzE2XJA1UXLt+fR69sTTeVW
 SZhcNLbwEXu1e5neFf9nDE5Mn/nkd9lFx9wZ+y5tdBT6+hW9aAQ==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tidss_crtc_reset() function will (rightfully) destroy any
pre-existing state.

However, the tidss CRTC driver has its own CRTC state structure that
subclasses drm_crtc_state, and yet will destroy the previous state
by calling __drm_atomic_helper_crtc_destroy_state() and kfree() on its
drm_crtc_state pointer.

It works only because the drm_crtc_state is the first field in the
structure, and thus its offset is 0. It's incredibly fragile however, so
let's call our destroy implementation in such a case to deal with it
properly.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index eb431a238b11d22349d61f0e17f05994f50d5f2f..8fcc6a2f94770ae825eeb2a3b09856a2bf2d6a1e 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -355,13 +355,11 @@ static void tidss_crtc_destroy_state(struct drm_crtc *crtc,
 static void tidss_crtc_reset(struct drm_crtc *crtc)
 {
 	struct tidss_crtc_state *tstate;
 
 	if (crtc->state)
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(crtc->state);
+		tidss_crtc_destroy_state(crtc, crtc->state);
 
 	tstate = kzalloc(sizeof(*tstate), GFP_KERNEL);
 	if (!tstate) {
 		crtc->state = NULL;
 		return;

-- 
2.50.1


