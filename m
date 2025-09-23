Return-Path: <linux-kernel+bounces-828400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95302B948BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D2EB4E20FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354230F80B;
	Tue, 23 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ZhD3Pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D824BCF5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608599; cv=none; b=azaXhRTHW6ZMO/PeX1SgO4zM98t/XHzlAUPxv6WZVZnCbWprbnUoC3dPgWKU/XDyHVJePV4o/0X0Xw7fm0tBe0oqIFHYjfm/bd5Wg7yoYSy7IElYvA+DD3JftRh8KbeNQPiRTOMNj8ErwqBzC5li/CbuA5D7X1WZVyIouYp7N5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608599; c=relaxed/simple;
	bh=9oATPAFMFbNOY3q+HNbanR09rpolCzA8waFpW+Uyp0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RNpJHdrm9eXrd4cgZlaJ+skDoDokeSk3D4p4HwV4RFdCc8pIfuGd4XUJG9oqBEd4fd36RjOVF0padwk+SwA0+MFJPOP0jDvtCXa0cir6KykZ9pTJkcsbytdSDjy+JvGuFbGx7hyA6XJ8T+4SBpP6nmGm2OTrns7hDDnnxFYZryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+ZhD3Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6D27C4CEF5;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758608598;
	bh=9oATPAFMFbNOY3q+HNbanR09rpolCzA8waFpW+Uyp0g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=I+ZhD3PjIzP0esbDsGIiRFvW5QHgYK/J6WaTeWJZ9QLSvlyHyhUwCPqlZMjMe9WAc
	 5fdyZ836v6F9Dx90jBUJRt6Qz5n6BO/ylaonhwsjOc644fsHpV85SmMx4bL7RV6MJU
	 emr1qMt8z5WTiUN/l4R0SRMhfjS1k8SRSh6lkPM5k+SFttz5FSiw/+QptnMrzjkJCl
	 F+zhBMtAlY12708SxHC5d1txfig57psKT0iITeGX8RmFrXZ5BOFT17C75fM0fv/Rsk
	 AgXk7zLXJ5TmsAYHRxsPQkqBmcN5N3xB0NYxMxOUwR3obJJgTKJ9QAeDxbqPOJlW7j
	 tTBCs2Lg4MswQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21EECAC5AC;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH v4 0/4] drm/bridge: it6505: fix DP link traning and improve
 compatibility
Date: Tue, 23 Sep 2025 14:23:40 +0800
Message-Id: <20250923-fix-link-training-v4-0-7c18f5d3891e@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOw80mgC/23OTQ6CMBAF4KuYri0Z+ge48h7GBdQWJmoxbVM1h
 LtbcGFMWL7JvG9mIsF4NIEcdhPxJmHA0eUg9juih9b1huIlZ8KASShZSS2+6A3dlUbfokPXU6F
 K0UjRCCUlyb2HN3lpNU/nnAcMcfTv9URiy/SrcaY2tMQo0EoqXXNQVgIcMZpCj/ciPsnCJf4jB
 Gw9lPhCWAWWtV3V1fqPmOf5A6rX9Ar2AAAA
X-Change-ID: 20250121-fix-link-training-461495494655
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758608643; l=1902;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=9oATPAFMFbNOY3q+HNbanR09rpolCzA8waFpW+Uyp0g=;
 b=wHIq8EUBuZOvVR4jV7Es/0lJD6k2t6JNy6Vk2Ab7mjFsM1+Jt1PJyn+Hp1LJp+rakpU4QTRpt
 Ff6aNwR3yKBBGow22VDh/zuYWbvdBkY/mVC+JSSZ6qgWSjeAGqFcV8P
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
Changes in v4:
- squash patch 2/5 and 3/5, which do two different error check in same
  palce.
- edit commit message that warp at 70-77 boundary
- Link to v3: https://lore.kernel.org/r/20250401-fix-link-training-v3-0-7f60f2ab7b8c@ite.com.tw

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
Hermes Wu (4):
      drm/bridge: it6505: fix link training state HW register reset
      drm/bridge: it6505: add INT status check  while link auto training
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



