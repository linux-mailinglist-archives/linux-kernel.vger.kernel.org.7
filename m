Return-Path: <linux-kernel+bounces-733632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B7B07729
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A14B4E2BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C871D5CFE;
	Wed, 16 Jul 2025 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoUOG/U1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE1A239A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673282; cv=none; b=BO4pImn7sdGCebM3vlXdJWrIG9bNoZjlIEZPYidIJqtkMJ1rS2OWEOe0BkKHAWxls5UF+ox0S+uTLavn81NY0JgKZWhY0bPWhXK2W1yn1EOo1nxiE+Ud1ZdeOQ7AEkOO0LrF5a1rjFGnq1rBrPGCVmaSuJAobF9PgmQJLGwmvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673282; c=relaxed/simple;
	bh=RHI4u2LloKbvszBt3srx70NKJhd2p7vtukt+L4CqdjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFHeZTwhY8tpd3RZun5RIOVyv84/INSepW0nbeZfmUCpsXef8/R12Sggma7YBwG09exeGExM1K4CK0BHC8oo+TEDOq2TtfWCYNs4ykArDZJvKQl3GTAsyk+JG2cBpB2QTSeN0AE4NHN7tTBQ+CNspNHNiupzu1XF6HPmC0sxlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoUOG/U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8DEC4CEF0;
	Wed, 16 Jul 2025 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673282;
	bh=RHI4u2LloKbvszBt3srx70NKJhd2p7vtukt+L4CqdjM=;
	h=From:To:Cc:Subject:Date:From;
	b=qoUOG/U1qkTJqbKVCTWTfWgbghtCdaRjlDFhlgr5PdCJZLqxeKx3KJ/PNY78ZzfzQ
	 LTzDuSBI/+kUIzviMnBg5a6I7ZRo1Tq5XGBa+WM4q9GrJqVC93zBCauopIhCwwpfQz
	 bnMvUuxvAs1wwMnAEKkBBnkDEqO21e+DaqQuGBdgHK/IMIknJUQQcj6gW/txOnyM8m
	 B/IZlZ2BPRIm8Rs+SLsQvFviN4BNo4YpRnfzLbanuZR2/c/WesSYrPgAVDg2ugSWv2
	 CjhsKKGBa175t2ViC5pTqPHVb5GjMibfFsgQZIEYxxDu0j2QqzW43Qss2zISQX5jPv
	 Z7jDUgRz1JSLA==
From: Michael Walle <mwalle@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] drm/tidss: encoder: convert to devm_drm_bridge_alloc()
Date: Wed, 16 Jul 2025 15:41:07 +0200
Message-Id: <20250716134107.4084945-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the tidss encoder to use devm_drm_bridge_alloc(). Instead of
allocating the memory by drmm_simple_encoder_alloc() use
devm_drm_bridge_alloc() and initialize the encoder afterwards.

Fixes: a7748dd127ea ("drm/bridge: get/put the bridge reference in drm_bridge_add/remove()")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 95b4aeff2775..81a04f767770 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -90,14 +90,18 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	struct drm_connector *connector;
 	int ret;
 
-	t_enc = drmm_simple_encoder_alloc(&tidss->ddev, struct tidss_encoder,
-					  encoder, encoder_type);
+	t_enc = devm_drm_bridge_alloc(tidss->dev, struct tidss_encoder,
+				      bridge, &tidss_bridge_funcs);
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
+	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
+				      encoder_type);
+	if (ret)
+		return ret;
+
 	t_enc->tidss = tidss;
 	t_enc->next_bridge = next_bridge;
-	t_enc->bridge.funcs = &tidss_bridge_funcs;
 
 	enc = &t_enc->encoder;
 	enc->possible_crtcs = possible_crtcs;
-- 
2.39.5


