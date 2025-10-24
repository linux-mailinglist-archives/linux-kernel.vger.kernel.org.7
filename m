Return-Path: <linux-kernel+bounces-869439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93AC07E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6921C443EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9E288C3D;
	Fri, 24 Oct 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mbJ0Rthd"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529C285074
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333454; cv=none; b=aYf6fpz2hBkTRezep1/7qZb6fOYIU2lU6UOM8ewvQWNI+aIO4m32qkgsaEGJYzeR7xruVDVT8EAZ3VrlyFBo23u+ssYQF5boTDhgjjqj9rNddkm2cfM2eN4Kg0jcj8FPQRoiS4kubdtk2ifBAnQxuZ5bu9qyR03WvqrhcBKWeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333454; c=relaxed/simple;
	bh=NngWJU4duABCrydaCPPWXNizqoNmLXMX6D4Rl4d8kp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quTuijmusWlr/I84CszKZvIARNHgoz0SDg9efIImcYP+oa7cSAuORpJFuy+1Lpxa7kHCdfpmTMlJ9k2LMxzwtW3I5xqFNFvnoLDNe2prD5yxozbUVlEqWLRqbgmZdEE8wUMd9qxAHkr0bQiVBK7wDDHVdy43r92G1qxPVxNBmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mbJ0Rthd; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761333450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WrJTDCbjNqXN4i/GaEE8YS8TrIdiKbp038ohCvnOc=;
	b=mbJ0Rthd8AZmKwRv4lef9+aiFolHMxkakI/npPVUBOcdu5mv3ZdxWpri4dgUt8bypW4ZmE
	/3Mf/6SQexFCGTYD14HR6yvlhqn346ZxnpBUN2yvc0B69L2ZLiJietvjeVu8kd+VHSyHNO
	xT/I56yWliOPzOhsz48RpLTziZGHHJQ=
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
Subject: [PATCH 2/3] drm: zynqmp_dp: Use smp_load/store for status
Date: Fri, 24 Oct 2025 15:17:06 -0400
Message-Id: <20251024191707.2310589-3-sean.anderson@linux.dev>
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

dp->status is read asynchronously by the AUX bus. Therefore, all reads
outside of dp->lock must be atomic. Similarly, writes must be atomic as
well. Reads with dp->lock held do not need to be atomic.

Fixes: a7d5eeaa57d7 ("drm: zynqmp_dp: Add locking")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index f39c78b08e6a..caf2e0ce3644 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1111,7 +1111,7 @@ zynqmp_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 			return msg->size;
 		}
 
-		if (dp->status == connector_status_disconnected) {
+		if (READ_ONCE(dp->status) == connector_status_disconnected) {
 			dev_dbg(dp->dev, "no connected aux device\n");
 			if (dp->ignore_aux_errors)
 				goto fake_response;
@@ -1697,7 +1697,7 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 	}
 
 	if (state & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_HPD) {
-		dp->status = connector_status_connected;
+		WRITE_ONCE(dp->status, connector_status_connected);
 		ret = drm_dp_dpcd_read(&dp->aux, 0x0, dp->dpcd,
 				       sizeof(dp->dpcd));
 		if (ret < 0) {
@@ -1716,7 +1716,7 @@ static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 	}
 
 disconnected:
-	dp->status = connector_status_disconnected;
+	WRITE_ONCE(dp->status, connector_status_disconnected);
 	return connector_status_disconnected;
 }
 
-- 
2.35.1.1320.gc452695387.dirty


