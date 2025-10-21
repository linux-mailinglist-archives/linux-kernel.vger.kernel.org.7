Return-Path: <linux-kernel+bounces-862990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C43BF6BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20038463ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576E33711A;
	Tue, 21 Oct 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SEc0ncK/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923643370F5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053019; cv=none; b=HM01EuA6MEof7z8LhzgMmcF9/IblVH+1o3sLtXLY70yw2Yg9g9F0h99Y9+W4OowBAJrQqgPp4GeQv1zatNUZFHS20x/Z9wPWC4YYMtHykUZrs8T2iFmSSkQxnGvs1KblkXmDdVqmI0XY8qVDWcE51BfcLTFOzpHgeGZs66oAW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053019; c=relaxed/simple;
	bh=nWvFAvD5AGlGEC9yWkEHzmj/BzvIaks9Klnp2gFRims=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deRiBPoT+ZuYbHvvbGqioaTyvJ+XoxEdJQDKIGcH2kKo3+Dk9vgpDTR/SDq9I2cFZ0RstYENkG+rOBEkSr6HxgK9xSNgR+IVtAiz1OI3avh8XduK7FOLh7EWZbEdnOBnAQkvcjqZfBZcYcko03vsjOdwuIo/2TkGt+LK0DgvpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SEc0ncK/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6202E01;
	Tue, 21 Oct 2025 15:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052907;
	bh=nWvFAvD5AGlGEC9yWkEHzmj/BzvIaks9Klnp2gFRims=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SEc0ncK/Px7LHKPRC5HjahiOZMnp2UOUsW1WNPFmHW1eOin2P5o28QPCwJsRAaHqr
	 B5aCJ7cjBUSvuE+mtNxrmIc6L7YAS526nAz+PTtdVO4W1Xn8WNK5gycqOrv+4lRz/c
	 uReVOVDZuMGzuYczMpkh8G0DCs7VADVlLpHNX4Dw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:22:57 +0300
Subject: [PATCH 1/7] drm/bridge: tc358768: Fix typo in
 TC358768_DSI_CONTROL_DIS_MODE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-1-d590dc6a1a0c@ideasonboard.com>
References: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
In-Reply-To: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=nWvFAvD5AGlGEC9yWkEHzmj/BzvIaks9Klnp2gFRims=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lOIXJCeonjgsKVvaBnTwx2Cc0C7I40fThUk
 XMNkOKzkhiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJTgAKCRD6PaqMvJYe
 9dHzD/97oSLT/UXJrVYdPSI3Hoaoe61ujacfWK8E3/xKu5I2sKN0Ib6VhaqUZU6h30ci5UqsVEl
 9aULxfmlH3zWv0pHfW41M5TNL70/gpmUw4NS/Oh9cfrs5JiKwZbiFdtLcuUD1gCKSPwhmBEDKsm
 ps95iHNUtcsvqp5G0srxD3zEZD0Qg28h187PDiO0AjHCL1kRKlm5Pu/t4cDmuBf5GMVln2DB71V
 /Jof5V5YouGa7WyFCtUqHYq3tDAduljJMzio5Zd+IYFE0jR3wXf40lO/Lp1mMAbly4aKfDvmY4C
 2ji43XpGvmYTzYI3OlA3+wj7eULBEGH9uuQaOCVGLOA1mbj967ZNJ0pJa5bNMf2WQuCGhItxH8j
 xD4SDAUor5ALJay+xuLuu02XWyeAdPQW2SiQB9qqwk8B2Om22WmcYlOsFNTZGyU9ZqVCNd6SegB
 SeiZxwVeQLP58+Ar+au4H6gKUPG6307oJ++/yukmlxNNq9VGTtyaouX5Ngz24/rO1mJgAR9crpR
 H6hkBjkZBPrvUOjYwpFq3Mc5XKpOAHBjnVczYYSV3XC2fMHOOIXQcvubXmhMKc28oFJERtUFQcz
 rICQY6btAQMUZdXf03jHvUQLmlqU+DCgukv7P7yNX2GdwRXNxR+ZbookwZbHmUX5aExuwGdE+Od
 tZErzWCg7TCbrjA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

It's "DSI_MODE", not "DIS_MODE".

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index fbdc44e16229..c95d164bd3a0 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -115,7 +115,7 @@
 #define TC358768_DSI_HACT		0x062C
 
 /* TC358768_DSI_CONTROL (0x040C) register */
-#define TC358768_DSI_CONTROL_DIS_MODE	BIT(15)
+#define TC358768_DSI_CONTROL_DSI_MODE	BIT(15)
 #define TC358768_DSI_CONTROL_TXMD	BIT(7)
 #define TC358768_DSI_CONTROL_HSCKMD	BIT(5)
 #define TC358768_DSI_CONTROL_EOTDIS	BIT(0)
@@ -1082,7 +1082,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	tc358768_write(priv, TC358768_DSI_CONFW, val);
 
 	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
-	val |= TC358768_DSI_CONTROL_DIS_MODE; /* DSI mode */
+	val |= TC358768_DSI_CONTROL_DSI_MODE;
 	tc358768_write(priv, TC358768_DSI_CONFW, val);
 
 	ret = tc358768_clear_error(priv);

-- 
2.43.0


