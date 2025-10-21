Return-Path: <linux-kernel+bounces-862548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBABF5937
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28A404FF67A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AC332ABF9;
	Tue, 21 Oct 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJl3JGZf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E92F7477;
	Tue, 21 Oct 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039854; cv=none; b=uC4nMcpzLiAYSDSmmfaHS9CrKALN9Tf4/x7Y7xnLjHyYGAAvfRPFVtO7CZxBH0spF8z5aWEaequE5w+z4+LFr49LIGupe70B+DYHKV+fRo9vgvTWlxEibPfJ70Nq7IvRNKxZvakjk7yITTKs5lsb8NlDhB3qA4+6PkzOBf/b8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039854; c=relaxed/simple;
	bh=OWlyyNOYBGSGibczZQ13ngOi8rR10xLww/Jd9naPUoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7i+/zvJ7S6RtjmcwTZGQzjIT0NIf4oBL2cKyb/baCD7BxnAMdXR7MnSo7NDIU8cGEThbGjuIdi0rsD4a+cSumQBD1kDwj5chNW4/g40dBwqvp0jLx3lm4wf/H+JQYNjGxClC4dEQjixjNjjjKvYBK2b+3gQa84EocxHTHjmDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJl3JGZf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761039853; x=1792575853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OWlyyNOYBGSGibczZQ13ngOi8rR10xLww/Jd9naPUoo=;
  b=WJl3JGZfHMKvcUBDA8cS4xhkjyltRUQyAYXdQD0Py64ahn7K4OjbwbDW
   Zv4mju3A7kC7twQftPursTRyDaxWFmrm7eYT/3nORpBQs3/c/MePr1+Oh
   trch2f8d66rKWKN6UrxqBDasZTPVg3iCj/SVBUpyAOlNYVYYpZMCaOQv9
   sURWLC33FZ7NRi3FiYLjPtR54DdpRZVLzuumpxF2kmqq0DW9AT4oJylYT
   RIHIPXXLDOZL4HitTRu0BW78H5gtKpTqUSoUeMFULv4ztTUWoGv/eeIoD
   BhrEIXv6wUq/Qx2ua1YUqJ5fjnLPZ3qN6ObRpYAPvKIxWxwNoCD0vHZTX
   A==;
X-CSE-ConnectionGUID: t79QAjKNRR+ifY2H6cvTjA==
X-CSE-MsgGUID: cL4Q2sMbSXirH2oDz91/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63259380"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="63259380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:12 -0700
X-CSE-ConnectionGUID: DG1ESi1VTtmCMxjPK2oflg==
X-CSE-MsgGUID: mFiaFOHDTSaxVYzMzphcew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182753545"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:11 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: intel_ace2x: handle multi BPT sections
Date: Tue, 21 Oct 2025 17:43:54 +0800
Message-ID: <20251021094355.132943-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
References: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate required PDI buffer and pass the section number to the cdns
BPT helpers.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Tested-by: Shuming Fan <shumingf@realtek.com>
---
 drivers/soundwire/intel_ace2x.c | 46 ++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 300ede6bc7f1..1ed0251d2592 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -57,6 +57,8 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	struct sdw_port_config *pconfig;
 	unsigned int pdi0_buf_size_pre_frame;
 	unsigned int pdi1_buf_size_pre_frame;
+	unsigned int pdi0_buffer_size_;
+	unsigned int pdi1_buffer_size_;
 	unsigned int pdi0_buffer_size;
 	unsigned int tx_dma_bandwidth;
 	unsigned int pdi1_buffer_size;
@@ -68,6 +70,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	struct sdw_cdns_pdi *pdi1;
 	unsigned int rx_alignment;
 	unsigned int tx_alignment;
+	unsigned int num_frames_;
 	unsigned int num_frames;
 	unsigned int fake_size;
 	unsigned int tx_pad;
@@ -76,6 +79,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	int ret1;
 	int ret;
 	int dir;
+	int len;
 	int i;
 
 	stream = sdw_alloc_stream("BPT", SDW_STREAM_BPT);
@@ -155,12 +159,25 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	if (ret < 0)
 		goto deprepare_stream;
 
-	ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row, cdns->bus.params.col,
-					     msg->sec[0].len, SDW_BPT_MSG_MAX_BYTES,
-					     &data_per_frame, &pdi0_buffer_size, &pdi1_buffer_size,
-					     &num_frames);
-	if (ret < 0)
-		goto deprepare_stream;
+	len = 0;
+	pdi0_buffer_size = 0;
+	pdi1_buffer_size = 0;
+	num_frames = 0;
+	/* Add up pdi buffer size and frame numbers of each BPT sections */
+	for (i = 0; i < msg->sections; i++) {
+		ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row,
+						     cdns->bus.params.col,
+						     msg->sec[i].len, SDW_BPT_MSG_MAX_BYTES,
+						     &data_per_frame, &pdi0_buffer_size_,
+						     &pdi1_buffer_size_, &num_frames_);
+		if (ret < 0)
+			goto deprepare_stream;
+
+		len += msg->sec[i].len;
+		pdi0_buffer_size += pdi0_buffer_size_;
+		pdi1_buffer_size += pdi1_buffer_size_;
+		num_frames += num_frames_;
+	}
 
 	sdw->bpt_ctx.pdi0_buffer_size = pdi0_buffer_size;
 	sdw->bpt_ctx.pdi1_buffer_size = pdi1_buffer_size;
@@ -205,7 +222,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	}
 
 	dev_dbg(cdns->dev, "Message len %d transferred in %d frames (%d per frame)\n",
-		msg->sec[0].len, num_frames, data_per_frame);
+		len, num_frames, data_per_frame);
 	dev_dbg(cdns->dev, "sizes pdi0 %d pdi1 %d tx_bandwidth %d rx_bandwidth %d\n",
 		pdi0_buffer_size, pdi1_buffer_size, tx_dma_bandwidth, rx_dma_bandwidth);
 
@@ -220,12 +237,12 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	}
 
 	if (!command) {
-		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->sec, 1,
+		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->sec, msg->sections,
 							data_per_frame,
 							sdw->bpt_ctx.dmab_tx_bdl.area,
 							pdi0_buffer_size, &tx_total_bytes);
 	} else {
-		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->sec, 1,
+		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->sec, msg->sections,
 						       data_per_frame,
 						       sdw->bpt_ctx.dmab_tx_bdl.area,
 						       pdi0_buffer_size, &tx_total_bytes,
@@ -304,11 +321,16 @@ static int intel_ace2x_bpt_send_async(struct sdw_intel *sdw, struct sdw_slave *s
 				      struct sdw_bpt_msg *msg)
 {
 	struct sdw_cdns *cdns = &sdw->cdns;
+	int len = 0;
 	int ret;
+	int i;
 
-	if (msg->sec[0].len < INTEL_BPT_MSG_BYTE_MIN) {
+	for (i = 0; i < msg->sections; i++)
+		len += msg->sec[i].len;
+
+	if (len < INTEL_BPT_MSG_BYTE_MIN) {
 		dev_err(cdns->dev, "BPT message length %d is less than the minimum bytes %d\n",
-			msg->sec[0].len, INTEL_BPT_MSG_BYTE_MIN);
+			len, INTEL_BPT_MSG_BYTE_MIN);
 		return -EINVAL;
 	}
 
@@ -368,7 +390,7 @@ static int intel_ace2x_bpt_wait(struct sdw_intel *sdw, struct sdw_slave *slave,
 	} else {
 		ret = sdw_cdns_check_read_response(cdns->dev, sdw->bpt_ctx.dmab_rx_bdl.area,
 						   sdw->bpt_ctx.pdi1_buffer_size,
-						   msg->sec, 1, sdw->bpt_ctx.num_frames,
+						   msg->sec, msg->sections, sdw->bpt_ctx.num_frames,
 						   sdw->bpt_ctx.data_per_frame);
 		if (ret < 0)
 			dev_err(cdns->dev, "%s: BPT Read failed %d\n", __func__, ret);
-- 
2.43.0


