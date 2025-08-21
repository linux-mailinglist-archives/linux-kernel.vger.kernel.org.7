Return-Path: <linux-kernel+bounces-779728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF4B2F7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E538917BF05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB02EE60A;
	Thu, 21 Aug 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfbDKG4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4362E0916
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779031; cv=none; b=MiS6RLE7vHg7d8Qdts0HVxcPaQV/jlJamF6+GjJJ+tjdYSNRgVgtV9pljCffvbWs3NAxDkEBzjwfnU9VP4S/hPYoOhizkjY5zDxXpblOVwK0bcKmeeIx1LqzLcLIaLinYMeC4dJFK+UZ3+PgCty4O3bu90rRpvwZHL/uuHyoG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779031; c=relaxed/simple;
	bh=fu4IgbUI1aWnDqu2U8QHmg6JXGWx/FGi7D/ezNpYCbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NACQh8AZ6+g63AK0VNHcIq2wK2cFVSvwccR6dr90d1Z57OUhOhkvGYsGuQp5VvRrA3Qr1okGAtuOpO7kgMWHHleBNRnDiKAAhivWtNqXVPVN0TrX0EvdmvVbxI+t3bGtldMzQdmzyRseKIpho31075qMYcajz7OIRHIop+Ue5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfbDKG4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B8CC4CEEB;
	Thu, 21 Aug 2025 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755779031;
	bh=fu4IgbUI1aWnDqu2U8QHmg6JXGWx/FGi7D/ezNpYCbE=;
	h=From:To:Cc:Subject:Date:From;
	b=MfbDKG4F0pApMw5RvgN6EpZ2msOsGTlMN5BOb8A3xLi4TWpBJbBI09IlK2y/2wCqJ
	 +XkDgXz3rDwoNmWDTrJCmbpKU9SFvyc/LqtZKn8xQ+MPq+yJqTdHLiPZR4wcVtcm4M
	 s59kszYyOHy7fEgKIX5ysTx2JEjM8wnMtzvkyhD5cXBqu9dEhRFM1iHynUe24wfUw1
	 mNB+zI7b/kTRzqvWoM2h1hIdDkhU2kIrqgL0t/jq1E5EDmUMbeoBQehxaacktpT++h
	 Y+Tl1FznVaxYOUjlPLgJXmgBgRlfm0RszIP8ZHJTkAzGf0mOCwcOeWMQe7s9tgbqgZ
	 CEuUnoZnGZSWg==
From: Michael Walle <mwalle@kernel.org>
To: Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] drm/bridge: ti-sn65dsi86: fix REFCLK setting
Date: Thu, 21 Aug 2025 14:23:41 +0200
Message-Id: <20250821122341.1257286-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge has three bootstrap pins which are sampled to determine the
frequency of the external reference clock. The driver will also
(over)write that setting. But it seems this is racy after the bridge is
enabled. It was observed that although the driver write the correct
value (by sniffing on the I2C bus), the register has the wrong value.
The datasheet states that the GPIO lines have to be stable for at least
5us after asserting the EN signal. Thus, there seems to be some logic
which samples the GPIO lines and this logic appears to overwrite the
register value which was set by the driver. Waiting 20us after
asserting the EN line resolves this issue.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 464390372b34..ae0d08e5e960 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -392,6 +392,17 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 
 	gpiod_set_value_cansleep(pdata->enable_gpio, 1);
 
+	/*
+	 * After EN is deasserted and an external clock is detected, the bridge
+	 * will sample GPIO3:1 to determine its frequency. The driver will
+	 * overwrite this setting in ti_sn_bridge_set_refclk_freq(). But this is
+	 * racy. Thus we have to wait a couple of us. According to the datasheet
+	 * the GPIO lines has to be stable at least 5 us (td5) but it seems that
+	 * is not enough and the refclk frequency value is still lost or
+	 * overwritten by the bridge itself. Waiting for 20us seems to work.
+	 */
+	usleep_range(20, 30);
+
 	/*
 	 * If we have a reference clock we can enable communication w/ the
 	 * panel (including the aux channel) w/out any need for an input clock
-- 
2.39.5


