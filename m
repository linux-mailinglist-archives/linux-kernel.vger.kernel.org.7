Return-Path: <linux-kernel+bounces-869438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29EC07E23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C82403759
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26789286887;
	Fri, 24 Oct 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/jCUmPp"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05B1E98EF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333452; cv=none; b=NabE2paQaOsKk0gme3Nib94AU9yl1VQWolCkIp4UyRecDDodaYf6NyUVmdhKxGHQT/MnGEHPJoa/5XYmh0wa8Ixv+S9HQqrUkXjangoSNh6f4Df51+EKXaNLM/7I+B5LT9OGhvxBlUvo4DHxAHfW1AmaBDrSLQ7WpyN+sM+KSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333452; c=relaxed/simple;
	bh=M35FZF9FZHHqFhXklunZHjP2+vMtckyHYPaoKSrmPUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoBhanYBCjYfw2xHLo7RY0JmzDmqhAE+LejpIohbpGlUUFCPqTdr+aXwiPiIM94ApgClpfea5arXbBgefuK5PK8x1pM5vALGYgiE+iIadZd4G5X8q/r8DonLBWB6jl8PODgCFJlMekg4pLt8LvxPJfjQTS/1nZ+xhBRa6vI7H+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/jCUmPp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761333448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Hv9cQ6qRRi2vVHLXfvCFJ0ztNKP7yXxJBYCkVumGr0=;
	b=s/jCUmPp0JFWxmvc6dD3Mv6HLCLd0hsNa8sA/9O/qtRJTalPT8D0Itf6d0vwStc+JdTvnz
	qBETiCc1v4TKQZI7qjE/mSHbkZOPxZrzfWOiZS/TS4U0RpaCxYbx8wRyzRHNjrVRUQ9+Mh
	zQBWT7LkOD8hAy/5PQM2bNTYA18BYGo=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] drm: zynqmp_dp: Update connector state before AUX transfers
Date: Fri, 24 Oct 2025 15:17:05 -0400
Message-Id: <20251024191707.2310589-2-sean.anderson@linux.dev>
In-Reply-To: <20251024191707.2310589-1-sean.anderson@linux.dev>
References: <20251024191707.2310589-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We still want to retry AUX transfers even when the connector is first
plugged in. Update the connector state before reading the DPDC to ensure
the AUX bus sees the most-recent state.

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 34ddbf98e81d..f39c78b08e6a 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1697,6 +1697,7 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 	}
 
 	if (state & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_HPD) {
+		dp->status = connector_status_connected;
 		ret = drm_dp_dpcd_read(&dp->aux, 0x0, dp->dpcd,
 				       sizeof(dp->dpcd));
 		if (ret < 0) {
@@ -1711,7 +1712,6 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 					       drm_dp_max_lane_count(dp->dpcd),
 					       dp->num_lanes);
 
-		dp->status = connector_status_connected;
 		return connector_status_connected;
 	}
 
-- 
2.35.1.1320.gc452695387.dirty


