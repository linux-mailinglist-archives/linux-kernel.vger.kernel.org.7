Return-Path: <linux-kernel+bounces-879126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD272C22568
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668F3565E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740C346FA0;
	Thu, 30 Oct 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ra39n0bk"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C533BBA6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856635; cv=none; b=XzCpzaqZvoGMTyFWXnJgdZanzZDF+QfVh4rl0yiy7xAE+Uw+pmyVmOJ0hj9zp3iwMowmfMjs9+wJ/mXBXBeAIgIODkSjIh3dioiKN3JlUODn5PRyF8l6oZ/IpxJXFeIe9H/cjJcr+ymXFV6TPldvzmMBmOauvR/7tVkONeXSvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856635; c=relaxed/simple;
	bh=fzSAIUaTYjf8ShocXZfywyaajREUuPoA984VLil+nC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVeIPxZYzVBzMYsXmEhb0tZpPkN0TU1VdmI7xdP7D3dl59fWtpx9VewusfXnBybRqeTiMBuatSPZ9Is1k/egviOr6qTjRnqr8Or4p1kaiTx1OIvL97NEmkPJrgGA2+uwAMQh+iUSZfOkLp8l1CZb45g+m14TkPT/xI8JKYxn7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ra39n0bk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761856630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StFKrxbxfYIJoJBUUN3mU8RLnkw52PoELYYr9mlAnjo=;
	b=Ra39n0bkxPyoUmWB9kvA4rMKKA9GZXerdageuO5tse47RanAy8oS3/HETTj3LHZ6he2UpZ
	cnRq0BQC/dWbXiElShOq6FjeQlbLk5vzzARVsQd45DtlGrwiS9yAYAOOP4kKYyfbwlk3jN
	fq5c2n0IN545pwa4tjhvZrz1Bo7MKNM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 3/3] drm: zynqmp_dp: Retrain link after HPD if necessary
Date: Thu, 30 Oct 2025 16:36:42 -0400
Message-Id: <20251030203642.3076656-4-sean.anderson@linux.dev>
In-Reply-To: <20251030203642.3076656-1-sean.anderson@linux.dev>
References: <20251030203642.3076656-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The section 5.1.4 of the v1.2 DisplayPort standard says

> The Source device shall respond to Hot Plug event/Hot Re-plug event by
> first reading DPCD Link/Sink Device Status registers at DPCD 00200h
> through 00205h.... If the link is unstable or lost, the Source device
> then reads the DPCD Receiver Capabilities registers at DPCD 00000h
> through 0000Fh to determine the appropriate information needed to
> train the link. The Source device shall then initiate link training.

However, zynqmp_dp_hpd_work_func does not check the link status. This
may prevent the sink from detecting the source if, for example, the user
disconnects the cable and then reconnects it. I encountered this problem
when testing a mini DP connector (although I had no problem when using a
full-size connector with the existing driver).

Follow the spec by checking the link status after a HPD event and
retraining if necessary.

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- needs_retain -> needs_retrain
- Actually retrain the loop (accidentally removed while rebasing)

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 38 ++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index caf2e0ce3644..1619aa61f7e1 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1677,6 +1677,24 @@ static int zynqmp_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static bool zynqmp_hpd_needs_retrain(struct zynqmp_dp *dp)
+{
+	u8 status[DP_LINK_STATUS_SIZE + 2];
+	int err;
+
+	err = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
+			       DP_LINK_STATUS_SIZE + 2);
+	if (err < 0) {
+		dev_dbg_ratelimited(dp->dev,
+				    "could not read sink status: %d\n", err);
+		return false;
+	}
+
+	return status[4] & DP_LINK_STATUS_UPDATED ||
+	       !drm_dp_clock_recovery_ok(&status[2], dp->mode.lane_cnt) ||
+	       !drm_dp_channel_eq_ok(&status[2], dp->mode.lane_cnt);
+}
+
 static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 {
 	struct zynqmp_dp_link_config *link_config = &dp->link_config;
@@ -1698,6 +1716,9 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 
 	if (state & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_HPD) {
 		WRITE_ONCE(dp->status, connector_status_connected);
+		if (!zynqmp_hpd_needs_retrain(dp))
+			return connector_status_connected;
+
 		ret = drm_dp_dpcd_read(&dp->aux, 0x0, dp->dpcd,
 				       sizeof(dp->dpcd));
 		if (ret < 0) {
@@ -1712,6 +1733,7 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 					       drm_dp_max_lane_count(dp->dpcd),
 					       dp->num_lanes);
 
+		zynqmp_dp_train_loop(dp);
 		return connector_status_connected;
 	}
 
@@ -2335,25 +2357,13 @@ static void zynqmp_dp_hpd_irq_work_func(struct work_struct *work)
 {
 	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp,
 					    hpd_irq_work);
-	u8 status[DP_LINK_STATUS_SIZE + 2];
-	int err;
 
 	guard(mutex)(&dp->lock);
 	if (dp->ignore_hpd)
 		return;
 
-	err = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
-			       DP_LINK_STATUS_SIZE + 2);
-	if (err < 0) {
-		dev_dbg_ratelimited(dp->dev,
-				    "could not read sink status: %d\n", err);
-	} else {
-		if (status[4] & DP_LINK_STATUS_UPDATED ||
-		    !drm_dp_clock_recovery_ok(&status[2], dp->mode.lane_cnt) ||
-		    !drm_dp_channel_eq_ok(&status[2], dp->mode.lane_cnt)) {
-			zynqmp_dp_train_loop(dp);
-		}
-	}
+	if (zynqmp_hpd_needs_retrain(dp))
+		zynqmp_dp_train_loop(dp);
 }
 
 static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
-- 
2.35.1.1320.gc452695387.dirty


