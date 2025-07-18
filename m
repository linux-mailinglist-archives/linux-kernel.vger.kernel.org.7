Return-Path: <linux-kernel+bounces-736098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C7B098CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3A6A41AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549D18E20;
	Fri, 18 Jul 2025 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EtMvMObL"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E6137E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797660; cv=none; b=omqHOh8EHqPDZfKihB8Wb2y/HK4yWmSnIEfSQYW1DlJogrFKKJz2S6I7Z3edkB8a/+qzzOrloDpJG9Q48hr1NImtxpD2D8i7KrC1GR+PfYLglfJR7ozA3JJ6YStGU1u45V/RI55OIJFiNjQEQ6cCrtNPVnqQARaE3l2BqFfazwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797660; c=relaxed/simple;
	bh=hzcnrP68AUYH3vlmULE6dDlehfFbFKnSRglouYGv1LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KarQB7AHvT2GvJhEZQ7vft8YiInH5XSOwIk9W3RZBm4lIWkHTz6TEvHlE0rnWdjJqq6AiDVVwrwUzZ4Oais0+Ee7qbRmvjTrfhen+4y2bgeW0RuQWE6NkNmWnAySdsrz5TnhGWEMrbzYAsyK1rnSfUBYcugQS5Y3FeVWmkZjteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EtMvMObL; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797658; x=1784333658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzcnrP68AUYH3vlmULE6dDlehfFbFKnSRglouYGv1LQ=;
  b=EtMvMObLRmmQzthqnUg6fWje8WZi2J2E7ZxF+Vl9Ed68+wYgmz7QG5bS
   QvVwwWm9FfiF2SPdeM3FhGfMpse03i4HTH1snxLWcHxSkCfLbZV3vCQYk
   jmTEaccXfFngVkICuZOIazatwmlnCwjT+qO9GduGr583VgA8iZLGothI0
   QK2IP/6N4M0nXI9Yl8HfQpSAcb1Y7/NIrQPCIwyhuX/qi/tEBUhxGh7Ek
   v7Y13P6frGIDOoB4rZFIwyum3nmVlFIm/1UGUlW30KtUNk8/FlMiGD4M8
   QMPJ9Aif1/l3lEHh5PhEO3Rdi4jEIq0w8YUTYWetetQWkSVV+l6bOeC6W
   w==;
X-CSE-ConnectionGUID: //n/ttL8QqKLn+N5OEHNWg==
X-CSE-MsgGUID: beQb75a3Tg6+bwu2/WwFZw==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="94801298"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:17 +0800
IronPort-SDR: 68798335_OpyPjjsktPIeuWWiDH40erjuyuxXtqogA6sHo24iGGgHKnL
 BUoL0Y8EjwZazQg3OJNY5LLoFdhYtGHZMH8+b8Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:49 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:16 -0700
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
Subject: [PATCH v3 2/2] nvme: prevent admin controller from smart log fetch (LID 2)
Date: Thu, 17 Jul 2025 17:14:15 -0700
Message-ID: <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
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

Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
log. LID 2 is optional for admin controllers to support.

In the future when support for LID=0 (supported log pages) is added,
GLP accesses can be made smarter by basing such calls on response
from LID=0 reads.

Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 105127638c31..6e5c9871b76d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
-- 
2.43.0


