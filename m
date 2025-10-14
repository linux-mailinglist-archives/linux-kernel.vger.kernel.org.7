Return-Path: <linux-kernel+bounces-852507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19842BD9264
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531044FF6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2D310640;
	Tue, 14 Oct 2025 11:55:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B83101D9;
	Tue, 14 Oct 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442932; cv=none; b=W3o1+gfJPzhNaacIKQ/ITv3EZX+72vHX4o5ZuPlgxA2LD8tPYhCdSUZT1nFZLlPnT6QcdXW/aL+qu5oDmm5gyCFgza0YNraJNnGOqInbHLuWIT28iDSVnhrOmmX//gyv+apBlQaLD9vpj9d9VXbN6nvM5ntgAyQxTsVM8gzd0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442932; c=relaxed/simple;
	bh=q3NqpzikVNmbAHWIru9MJHk2JZi9+Un7M/JnF31BJYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCIjKGJe2niH5xg6LeDDTP7pKdE1rqY3dW9rLniw3V2dYzT5lwkjZ1aZJ0dyphthfwRbJL6PGSUMmzY6s2paTkx37zG6b1vglEp/LqmxrwAvV4mjjEdl8qRFyleRhza7RKzGFwzEaUqnD6K0dJTEnbFhrROvcMXks3LyrNKOsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E531BB2;
	Tue, 14 Oct 2025 04:55:21 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC733F6A8;
	Tue, 14 Oct 2025 04:55:28 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/3] include: trace: Fix inflight count helper on failed initialization
Date: Tue, 14 Oct 2025 12:53:45 +0100
Message-ID: <20251014115346.2391418-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014115346.2391418-1-cristian.marussi@arm.com>
References: <20251014115346.2391418-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check to the scmi_inflight_count() helper to catch the condition
when the SCMI debug subsystem as a whole failed initialization.

Fixes: f8e656382b4a ("include: trace:  Add tracepoint support for inflight xfer count")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 8 +++++---
 drivers/firmware/arm_scmi/driver.c | 7 +++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 21c0b95027c6..7c35c95fddba 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -333,10 +333,12 @@ static inline void scmi_inc_count(struct scmi_debug_info *dbg, int stat)
 	}
 }
 
-static inline void scmi_dec_count(atomic_t *arr, int stat)
+static inline void scmi_dec_count(struct scmi_debug_info *dbg, int stat)
 {
-	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
-		atomic_dec(&arr[stat]);
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
+		if (dbg)
+			atomic_dec(&dbg->counters[stat]);
+	}
 }
 
 enum scmi_bad_msg {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 56419285c0bf..1cd15412024c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -594,7 +594,7 @@ scmi_xfer_inflight_register_unlocked(struct scmi_xfer *xfer,
 	/* Set in-flight */
 	set_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
 	hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
-	scmi_inc_count(info->dbg->counters, XFERS_INFLIGHT);
+	scmi_inc_count(info->dbg, XFERS_INFLIGHT);
 
 	xfer->pending = true;
 }
@@ -803,7 +803,7 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 			hash_del(&xfer->node);
 			xfer->pending = false;
 
-			scmi_dec_count(info->dbg->counters, XFERS_INFLIGHT);
+			scmi_dec_count(info->dbg, XFERS_INFLIGHT);
 		}
 		hlist_add_head(&xfer->node, &minfo->free_xfers);
 	}
@@ -3407,6 +3407,9 @@ int scmi_inflight_count(const struct scmi_handle *handle)
 	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
 		struct scmi_info *info = handle_to_scmi_info(handle);
 
+		if (!info->dbg)
+			return 0;
+
 		return atomic_read(&info->dbg->counters[XFERS_INFLIGHT]);
 	} else {
 		return 0;
-- 
2.51.0


