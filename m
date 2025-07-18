Return-Path: <linux-kernel+bounces-736099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B3B098D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D987A8590
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689491DDE9;
	Fri, 18 Jul 2025 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j66dPMUV"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37C3C38
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797660; cv=none; b=PJrvTBibRkJ3A0fAsBMvm46lAWEvUyTqj/1pIDVxz959aLhjlikHccD0bc3t+tGXtOEhuZgkQW6QO5uz8XxFzyXBT2oSSAkRLvV45129LYF+CryoaTG7kzkif2vlaKsfjRM719TKyV3HtovVQeAlx9D1EH3i7sDMboawcLRh85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797660; c=relaxed/simple;
	bh=1rtA0Hmyf2kHNVoELQi6f5hdbv4vXGv2LArfBKEp5Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDc72KwlVvjsMMDp5ORBiU341mIhpMNy3laRRIkXXTfOqYeIf0Wg6+k2bzBsHtJ5DkClf2CUaCIOp67yFHTxzTSYLCalBOE/gkOCa0DTcrErpbZD39LA83FLGdf3L9BHUmk1g62G8rudNmEshJ6rAsO1SUE3YFx+rDRSt1LqQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j66dPMUV; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797659; x=1784333659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rtA0Hmyf2kHNVoELQi6f5hdbv4vXGv2LArfBKEp5Qo=;
  b=j66dPMUVuZby9ErMezzxVx6CesoCMHX42pd31BlITVjXhpimLJljm+DJ
   inLo86jVP7cUM+qnfd2qvpi3fOGfA7mK4FBQkkSL68jaMNavE7WVY2FmL
   Rsa1p3tivpOn5/5Y0nbL6gNgpXZ2BTqco+t9rhTv7I6eUQr9QkCj1YdHQ
   NrXpHI7ZaBUUSbickYsRq3BUtocGR/tOfZmJEwhHzbE7K0rNVkrtxhMnW
   vuALgF6NXHqunmj8byvED/1xFwvlCSoYBVg1zqg6cf4RbmHEl/CEo9ody
   +DQ3fsPnPM5RxRsGWcf3M/kVVApz7mMweGWwHDymrHjV7qVxaWiJWRED4
   Q==;
X-CSE-ConnectionGUID: 9PJ9k9bnSjWQWJEGXMiZyw==
X-CSE-MsgGUID: rG1XG3rkRPWxdYy+GxGOTA==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="94801297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:16 +0800
IronPort-SDR: 68798334_jB5EAXGDlVnmJLjHMKCEoMJaIWCvE7WMiMPWW/pWOOibGl/
 KlQDtN6txKsH9gVyYziCM2hqeAbRed12ijA9OZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:49 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:15 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v3 1/2] nvme: add capability to connect to an administrative controller
Date: Thu, 17 Jul 2025 17:14:14 -0700
Message-ID: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suggested-by: Niklas Cassel <cassel@kernel.org>

Add capability to connect to an administrative controller by
preventing ioq creation for admin-controllers.

* Add helper nvme_admin_ctrl() to check for an administrative controller
* Add helper nvme_override_prohibited_io_queues() to override queue_count
* Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()
  so it applies to nvme/tcp and nvme/rdma

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..105127638c31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 	return ctrl->opts && ctrl->opts->discovery_nqn;
 }
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntrltype == NVME_CTRL_ADMIN;
+}
+
+/*
+ * An admin controller has one admin queue, but no I/O queues.
+ * Override queue_count so it only creates an admin queue.
+ */
+static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
+{
+	if (nvme_admin_ctrl(ctrl))
+		ctrl->queue_count = 1;
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	if (ret)
 		return ret;
 
+	if (nvme_admin_ctrl(ctrl))
+		dev_dbg(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			ctrl->subsys->subnqn);
+	nvme_override_prohibited_io_queues(ctrl);
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


