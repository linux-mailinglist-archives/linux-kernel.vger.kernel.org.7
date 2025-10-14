Return-Path: <linux-kernel+bounces-852264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C853BD88D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820B41923D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF82EB5B7;
	Tue, 14 Oct 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a+8SDUCQ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E22F49E4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435224; cv=none; b=czljbvQ6HaJBRCg/XzUEXfYAaG2pxy4PhOq4ZGRnKTqzEBWVOit1bRk+NGbXh3XT0yf9G/1vKsc37ny6u7G+ow5K8fka6yh1/bcf1IWDApSL/dnLbbvnCtzZfDfCKKvyVzU8+EDZROVB0R1J9ehbvcY/AMf1RIaomQwkEkw1ES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435224; c=relaxed/simple;
	bh=Q/EwNmJrqKRytUbxXSXQ4BbFzz+9P0jzmJ2FM9kdtTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWnASqEGs06aX0KugTuOTw8p4c3wRqBkWYMUka/UGmCXaF6Hzs+B6IEPUQy5AHUQimvmKeBfD1l5zklf8J3t2yQMKEcZrcYcVvGg7WgxqLwMtGFmepvIAXms771HxN5hD1kZaxqOMZJSEbPsfcgwLE27ArdVmFmZdC4gWJGI0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a+8SDUCQ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9kBxo1562834;
	Tue, 14 Oct 2025 04:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760435171;
	bh=5KAvQrV9PYUXZ+05NgzPPqjv+gxB7wjjkKy2Tu4HNjM=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=a+8SDUCQSXf/ErHFtzETVeSh4xkM2ATneE7z2oP7/hoPetKJlZJIPG4FPOurgXJ6X
	 X7wOona7PlnroVVKHJ6ed2iSk97566BfXGpATgc9VuIbaxpwccGFmbQAVWki/u8kba
	 coD/OpzyWoqTPuzwYYbtW27nW2LEJPunRdpRmkvM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9kBm7968164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 04:46:11 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 04:46:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:46:10 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9jSjX3359281;
	Tue, 14 Oct 2025 04:46:03 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
        <andrzej.hajda@intel.com>, <andy.yan@rock-chips.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <javierm@redhat.com>,
        <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
        <linux-kernel@vger.kernel.org>, <linux@treblig.org>,
        <luca.ceresoli@bootlin.com>, <lumag@kernel.org>, <lyude@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <mordan@ispras.ru>,
        <mripard@kernel.org>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <s-jain1@ti.com>, <simona@ffwll.ch>, <tomi.valkeinen@ideasonboard.com>,
        <tzimmermann@suse.de>, <u-kumar1@ti.com>
Subject: [PATCH v8 5/6] drm/bridge: cadence: cdns-mhdp8546-core: Reduce log level for DPCD read/write
Date: Tue, 14 Oct 2025 15:15:26 +0530
Message-ID: <20251014094527.3916421-6-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014094527.3916421-1-h-shenoy@ti.com>
References: <20251014094527.3916421-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Jayesh Choudhary <j-choudhary@ti.com>

Reduce the log level for cdns_mhdp_dpcd_read and cdns_mhdp_dpcd_write
errors in cdns_mhdp_transfer function as in case of failure, there is
flooding of these prints along with other indicators like EDID failure
logs which are fairly intuitive in themselves rendering these error logs
useless.
Also, the caller functions for the cdns_mhdp_transfer in drm_dp_helper.c
(which calls it 32 times), has debug log level in case transfer fails.
So having a superseding log level in cdns_mhdp_transfer seems bad.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index fe2da567ec66..06ac5c2ee78f 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -778,7 +778,7 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 			if (!ret)
 				continue;
 
-			dev_err(mhdp->dev,
+			dev_dbg(mhdp->dev,
 				"Failed to write DPCD addr %u\n",
 				msg->address + i);
 
@@ -788,7 +788,7 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
 					  msg->buffer, msg->size);
 		if (ret) {
-			dev_err(mhdp->dev,
+			dev_dbg(mhdp->dev,
 				"Failed to read DPCD addr %u\n",
 				msg->address);
 
-- 
2.34.1


