Return-Path: <linux-kernel+bounces-739695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDCB0C9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C634540C30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BBB2E1C7B;
	Mon, 21 Jul 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e33xAW/3"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9F2E093F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119431; cv=none; b=NN1/OBB42E6qUapzo2QGPNDJ/PudOH9pdTx7Mwcx3Ncl2A10GrAlPHqvX8YR6dT3esmp5rUNKivfzIN8ujxUQxa1TqxGWM0hiYXzk5pLQQKeo3m29Yjte4ioiojplJv1JnBOMUwSfzjRAQg7WJUxMAcbPniOXRzOK7Vf7/TPXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119431; c=relaxed/simple;
	bh=CJds0Lr+8Es9u+yAumJM5EvNWV0O6fqnJESH/YqrpHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GziwjfbG1JFDalrUsi2NoZxkeC1f3YclZVJC+uZWjNBcSc4TLl9Oi6imYDPixWjt/xvDmJKVu/ssuxHJ/evZB+mKFudAaApUQWCTuGCTv729F9hFR0nTVUBauC+Y/ijMrD9YUJwr1SI8Qt6n/bhkgLKtE+ZbzWU+vfwRYqlvIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e33xAW/3; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119430; x=1784655430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJds0Lr+8Es9u+yAumJM5EvNWV0O6fqnJESH/YqrpHk=;
  b=e33xAW/3xQNS7GDwAFMunuqENuGa+sjBwC3Rb5UWtX1gP/y1iVgYCFvy
   W1Kw30dqHOonML0h4gWybbb4gHiso34zO/EJjFMcUmNnGXLqB1ARu5BJD
   kQGqzAQh/pjvaxxbR6XsgWW/8sEsUsz3djNRM8QVX3xP1sBk4cUBlaoI0
   KOoNd4cA0To/HRpeiRXaqFC457cpyNO3es0ifVQRiA37agRiZbxmifmOq
   aFkq6EVG1382VrjVBsrjdX/pdnFluQooI/zhyZYz2dX96CFTQ+YXUfVDZ
   uIl0Gys+mcITZIdRVBnPVMiAez5xsoiONOphUOulS4R99wnqAH1hZwoqf
   g==;
X-CSE-ConnectionGUID: dy7EzayyRRmaxJY2hBjVfw==
X-CSE-MsgGUID: olwUQZD6QdWFvlofD7cZGw==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="99464769"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:02 +0800
IronPort-SDR: 687e6c13_Gk8lDWxtxrweRw51NQAPXhR7hR/vRsHJCdiP4Ljan7zaIU7
 e5YEDF3bb54gflMn05fYPfWa0V8jTINHmlTiGxg==
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
Subject: [PATCH v4 2/2] nvme: prevent admin controller from smart log fetch (LID 2)
Date: Mon, 21 Jul 2025 10:37:00 -0700
Message-ID: <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
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

Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
log. LID 2 is optional for admin controllers to support.

In the future when support for the newly added LID=0 (supported log
pages) is added, GLP accesses can be made smarter by basing such calls
on response from LID=0 reads.

Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6388ed3ddca..0cec1e58e845 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3700,7 +3700,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
-- 
2.43.0


