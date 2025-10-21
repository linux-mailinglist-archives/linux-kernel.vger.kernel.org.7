Return-Path: <linux-kernel+bounces-863702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CDBF8DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03656463CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED6288C20;
	Tue, 21 Oct 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NZkWMIH9"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170B2877FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080494; cv=none; b=Cym00M56fdF49sl8YNJCrW1viuXCG2H5iS2VVQRHnzFJH7vQ2JdZhxh0ZZwelEN2/ixSRRvLWQ0/3y/8i8sXbKfUW369BOZborNkdBg00CGqwy7aSZETau2CGio/JFyyNptXq4OZwosG1QU6GcqAlFsHuGaeRr9Tb2/byMpTuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080494; c=relaxed/simple;
	bh=HNNcUjBlE2ezDrpCkSt1TAM29s3v4NT9WLUuWNfS/KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDPbzY0oNTVh7W+soXxyS6NYe/aq5oDrtVxQ6E0Nr0bfT6gA4ck18vy4zObv9AKlQ+RitBs/dNMhFqR5QzTO3naMgh/ZGHuRI5d7LPqEeMZrwrbyYS0rodbBRlKjeCiFcFOaMMbkM6JwIX1TfHrZgCmsMsch3Qr9QCclJc1DZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NZkWMIH9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 43692C0B8A3;
	Tue, 21 Oct 2025 21:01:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED5AE60680;
	Tue, 21 Oct 2025 21:01:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13D6102F2421;
	Tue, 21 Oct 2025 23:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vdYNl+jUov2A+6UN1VU5gxICmAEu5JVGl0RzN3EysYI=;
	b=NZkWMIH9WokjHWo6HtkBTaGYYhccTDAOhtx452H2om0J9x7UoSGu6t6YLJdfUFvn+9zPko
	NNrXwF+f0Bm9EyPzJCwbDDfmiV0dvryD/tdRmNfSGChRv32oEg9YHrwaa/cigmgjoCfece
	B0JXyM11qY6bQOMG8xEVjmlZhWUlORNEUifmnfxZMoeKp6/zQLyMpYagYOIWg63cRojBBW
	4UNfzGeZmDvi3+w58ZsDSrr+cAsm7MMAWxaapfHB93SY6T104iqUSSp9IsVdYnqZmi84Dw
	8Cf1+B4oKt7Op/03punHVioymNle3P6U71oQAhKXefwQwSqzbrwr7k58fR1cVg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 21 Oct 2025 23:00:48 +0200
Subject: [PATCH v2 5/5] drm/bridge: add warning for bridges using neither
 devm_drm_bridge_alloc() nor drm_bridge_add()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-5-c17cc1bbff72@bootlin.com>
References: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
In-Reply-To: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The correct sequence for bridge initialization is:

 1. devm_drm_bridge_alloc()
 2. drm_bridge_add()
 3. drm_bridge_attach()

For bridges missing either 1 or 2 there are warnings in place already,
presenting an explanatory error message.

Bridges missing both 1 and 2 would still face a poorly understandable
message, as reported in a recent regression report [0]:

  WARNING: [...] at [...]/lib/refcount.c:25 drm_bridge_attach+0x2c/0x1dc
  ...
  Call trace:
  ...
   drm_bridge_attach
  ...

Add a new warning to ensure an understandable message is logged in such
cases. Use the same message and warning message already in place in
drm_bridge_add().

[0] https://lore.kernel.org/all/hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v2 after having received regression report [0].
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6dba601a056bb3cff8b8dd5b1ec46299235b2d85..8f355df883d8ac8de9d361ec302f4ccbf3bca0d6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -441,6 +441,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (!bridge->container)
+		DRM_WARN("DRM bridge corrupted or not allocated by devm_drm_bridge_alloc()\n");
+
 	if (list_empty(&bridge->list))
 		DRM_WARN("Missing drm_bridge_add() before attach\n");
 

-- 
2.51.0


