Return-Path: <linux-kernel+bounces-818123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF145B58CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E731BC4E97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591723D7DA;
	Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU+GA/Pl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB4146585
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998064; cv=none; b=b3ej0uGuIqInfN6QGgQuyxYZHWvGx0SCgOB+uojlrubwol6CKfRodzy/CQzPJbr9oHNxoI4Zh7Ww2HSPSZ7N5Q/l91Gc3v8uv02K+/Z113osVmOBphPYoJjk4NgAUX57uEZbjzKHxtgLQAfwc1Ip38+PKl9dxm9M6jN9KnYqscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998064; c=relaxed/simple;
	bh=LP3b15IRlpCPLwb6oO8pnHVW44JCkcP1KqMqvoLVt8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YfKH/F1dGP21Ad+QaJYLEg6qKZEI0U8WP/hwIVrslcZmmh9sId+9bktEgPgxo/ay+0skhwycInvNKBMZYhVsbW18KdHjGJonoeW+eQ+2nr5mJBoENORG588CDBvb6bv8yFKF3/TUr3CFWLcC9d22cKBsHsCNgIyzKDf2XBWBBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU+GA/Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F74C4CEEB;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998063;
	bh=LP3b15IRlpCPLwb6oO8pnHVW44JCkcP1KqMqvoLVt8A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QU+GA/PlQHoG9D65VhVX9TlDhqmVA96dbRbOAzW6SSeieRGMwI9b7WVfkCaGoFrwp
	 T7kzeznVQts0FL0aL69c99fYcE+V0dey5/9N05lOXzMm3HurWfUIHvkjrL9w2P+6zS
	 gDH7HmPXUs6D3o8KOo/iJfwWoG/5ZyisiKQs3c+rhxZFdPHVe2ffdARDBzvUgaJVLY
	 pvQwe3agTaL55WqyAG9EaMkb6zWdLOO9ehfgjojRU/15kZHPxX1+XNPAayEObmyVTU
	 4YGyci/w40rsJvLOQ0aTNmE66LQKUBGifzxlMFqCCugo3Jle9JkNHkuRq4NrrGsD6q
	 PEbnxSCopOZvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E2DCAC599;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH RESEND v3 0/5] drm/bridge: it6505: fix DP link traning and
 improve compatibility
Date: Tue, 16 Sep 2025 12:47:40 +0800
Message-Id: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998107; l=1714;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=LP3b15IRlpCPLwb6oO8pnHVW44JCkcP1KqMqvoLVt8A=;
 b=AP9xBVy4Grz/aaWoIY78wzRPgq9P8kI4GFBwrGRiPE2p0gfeigdEO+ikv7Do8ljHH5NenMOtY
 1Wgznl48EzJDl30wRvMgrNOZ5OkHExxKhu/XSARggoFHBcn/Y8tzEEN
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

IT6505 supports HW auto link training which will write DPCD and check
training status automatically. Some DP device can not pass
HW auto link training and must set link training step by step.

when HW auto link training fail, it may trigger video FIFO error,
and link training process will reset to beginning, and never try
step training method.

Modify training method improve compatibility to these DP devices.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
Changes in v3:
- Patch 1/5 : add commit message for detial about changes
- Patch 2/5 : fix lost variable struct device *dev;
- Patch 3/5 : keep changes and remove refactoring
- Patch 5/5 : merge condition "it6505->step_train_only" check form if condiction into for loop.
- Link to v2: https://lore.kernel.org/r/20250326-fix-link-training-v2-0-756c8306f500@ite.com.tw

Changes in v2:
- 1. Split [PATCH 1/3] into 3 commits
- 2. Drop non necessary variable auto_ttrain_retry
- Link to v1: https://lore.kernel.org/all/20250318-fix-link-training-v1-0-19266711142c@ite.com.tw/

---
Hermes Wu (5):
      drm/bridge: it6505: fix link training state HW register reset
      drm/bridge: it6505: check INT_LINK_TRAIN_FAIL while link auto training
      drm/bridge: it6505: modify DP link auto training
      drm/bridge: it6505: modify DP link training work
      drm/bridge: it6505: skip auto training when previous try fail

 drivers/gpu/drm/bridge/ite-it6505.c | 88 +++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 38 deletions(-)
---
base-commit: 938fbb16aba8f7b88e0fdcf56f315a5bbad41aad
change-id: 20250121-fix-link-training-461495494655

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>



