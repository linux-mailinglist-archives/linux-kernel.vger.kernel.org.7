Return-Path: <linux-kernel+bounces-739694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACEB0C9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3297254092E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF42E1C5B;
	Mon, 21 Jul 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EwKuJTTv"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0C2DECB5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119431; cv=none; b=uSZfK3CIMew4KMA+iR9V2XONhKT6QcKx6gOBchIS2xUCG8Qv8BXoNTAS3YRFqGRkxQ4A/fm6aDEu5gtgHI+2H1LToas+bTdc5qAxLgHMZ6X7tojxRQbvEzfvbytUmSGMse2g6gIxzAkSUHUPDPq482OKUBPqYmXcDILpPbcY0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119431; c=relaxed/simple;
	bh=ojnyY42uXK0qbv77GdAfr80+l1AwHdnMVYTMiInndRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0CGFxZPKgKrGGCNqw6T++TQtz/AaG93C0Pn5watIiPPg6ZAbuQk302ky0Zw3v6DNmsjFOFfCEx8OIDCDjWaBVrwCsoT2ypHFJd0EgiQO4SnXU8ICWbJ+HluoLeh/WyPdkrM+EQGEjmRUZ6GLGAc8z5QUm8rg/pt336u8m6qKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EwKuJTTv; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119429; x=1784655429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ojnyY42uXK0qbv77GdAfr80+l1AwHdnMVYTMiInndRM=;
  b=EwKuJTTv6dKBGC04Wy+NeJB44GD19N6DNnLyu+vddzOoKCkp1k0GY2uN
   7wE6Ncj2M09GZ9vXvB+XPQXQ/2BAxAy9IjYEP5zqraclDHmQ0N9rOUAPu
   Iy/hAXjEDh8hW0QIR3HRIrJdWcUtFGXnwZt25VrxLahEYMsHjPk8Wbohp
   hJkB3eOLR57wO0erI7rDOT0uYGpSg59Y0OTAqb/Ao8FLMIztSpUFWISLk
   sOdmigV9OuRo0Kav8FD+htIwERBZBpe3ozC4NK6lULChqw1v2qisqNiyh
   n6CwhjpR5vnW075S9yxyRxkdTx9Az64n2t8KG9hbZL+n0l8HyigXSlgh1
   g==;
X-CSE-ConnectionGUID: 9Qh/xIVvRcK3aopE2qwUVw==
X-CSE-MsgGUID: LAw+4/Q6RxmqA2V3bDHaQA==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="99464767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:01 +0800
IronPort-SDR: 687e6c13_3fHdLdGFHt9ar/XT2hxSqfSRclTy0PMYXWjf+1tcAb9cHKa
 NWn+Nglse6z/BC3J5AEdhBPVjDV+QmxBct4nk9w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 09:34:28 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2025 10:37:02 -0700
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
Subject: [PATCH v4 1/2] nvme: add capability to connect to an administrative controller
Date: Mon, 21 Jul 2025 10:36:59 -0700
Message-ID: <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add capability to connect to an administrative controller by
preventing ioq creation for admin-controllers.

* Add helper nvme_admin_ctrl() to check if a controller's CNTRLTYPE
  indicates that it is an administrative controller.
* Override ctrl->queue_count to 1, so only one admin queue and no IO
  queues are allocated for an administrative controller.
* This override is done in nvme_init_ctrl_finish() after ctrl->cntrltype
  has been initialized in nvme_init_identify() so nvme_admin_ctrl() will
  work correctly.
* Doing this override in generic code (nvme_init_ctrl_finish) makes it
  transport agnostic and will work properly for nvme/tcp as well as for
  nvme/rdma.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..a6388ed3ddca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3149,6 +3149,11 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 	return ctrl->opts && ctrl->opts->discovery_nqn;
 }
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntrltype == NVME_CTRL_ADMIN;
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -3670,6 +3675,17 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	if (ret)
 		return ret;
 
+	if (nvme_admin_ctrl(ctrl)) {
+		/*
+		 * An admin controller has one admin queue, but no I/O queues.
+		 * Override queue_count so it only creates an admin queue.
+		 */
+		dev_dbg(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			ctrl->subsys->subnqn);
+		ctrl->queue_count = 1;
+	}
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


