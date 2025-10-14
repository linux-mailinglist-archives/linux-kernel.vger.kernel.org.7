Return-Path: <linux-kernel+bounces-851746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED7DBD72B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C874D188391E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90C30BB86;
	Tue, 14 Oct 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb4bPGxX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C730AD00;
	Tue, 14 Oct 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411718; cv=none; b=FCnf+VN79YBRyg/rhPSmlO1oupPltLPX1aSR6WgMED5J5PspINicWdSu86RrHMN/0T4sBO54kQ7AM4lRXHmpzAovGI2JL36MktmakhAm50fdwOipwGu92seO+mOus+5JG6kfgpcdIcdAI4wA/OzJ99H+PpnhSWjdtha2sB5wF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411718; c=relaxed/simple;
	bh=v+WcglJ6UXH86GdyEUHRefAusu8oSl3s/X5EonJZUY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QslQ2j/UFt9WsYn6TpSPatbR9FTHL9tJvuTQAU1KBl90m1nM+39EWFJa1SO+Rgrp9+AJYuZYFqjIVRZ06Zaf1TbiE9QDfCM3XPeXqgBUdDafxZapiEhvDIIz1HG4w4rkHg9THlITIHf4mlTaYQBRcQLy2DxLnEjgC/Q8pK8ytzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb4bPGxX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411716; x=1791947716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+WcglJ6UXH86GdyEUHRefAusu8oSl3s/X5EonJZUY0=;
  b=Xb4bPGxXvyNe3bLGhrF26noiOsDO5S5vQX9C6vNqMfTX30W4Zo6Ir5io
   TILi5B3z8AMnTM0erstWchV1B6tPyOyyokUtHfZ2dAvcxm2k6rGNbDRCT
   Ecweq0KEEwXtpRo/Nd3MYem8fvCeNEBNXUyWMw1bO9klPGCdD9mUc62vN
   l6QiNYWls8iAMHzVlqnCI6iPT2ekFYLI7x3zBdau7zjE/m5oiZXHzNpB9
   jWd/arqsEdNCiPJfzRmJdp0yKRMMY2AL1M5PdihrsLB220JBjcCYLtz6M
   NiRLh1NHWjYzbMiMHInakoIbP0AoNGoVP0alehxO0xBejky2RNoVBtjZH
   w==;
X-CSE-ConnectionGUID: JvwPL/Z8T/CIq3+QngZodg==
X-CSE-MsgGUID: 5AaEe/q1T0y/BjFdnoYo8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662099"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:15 -0700
X-CSE-ConnectionGUID: fQdOqS2xS62qsJmh5X6wVQ==
X-CSE-MsgGUID: bBs0A5wRTA+rxS7p/IJXUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198601"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:14 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 7/7] soundwire: intel_ace2x: add fake frame to BRA read command
Date: Tue, 14 Oct 2025 11:14:50 +0800
Message-ID: <20251014031450.3781789-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014031450.3781789-1-yung-chuan.liao@linux.intel.com>
References: <20251014031450.3781789-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel DMA buffer size need to be a multiple of data block size.
Find the minimal fake data size and extra buffer size to meet the
requirement.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 61 ++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 22118b053d56..e11a0cf77193 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -44,6 +44,8 @@ static int sdw_slave_bpt_stream_add(struct sdw_slave *slave, struct sdw_stream_r
 	return ret;
 }
 
+#define READ_PDI1_MIN_SIZE	12
+
 static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *slave,
 				       struct sdw_bpt_msg *msg)
 {
@@ -53,15 +55,23 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	struct sdw_stream_runtime *stream;
 	struct sdw_stream_config sconfig;
 	struct sdw_port_config *pconfig;
+	unsigned int pdi0_buf_size_pre_frame;
+	unsigned int pdi1_buf_size_pre_frame;
 	unsigned int pdi0_buffer_size;
 	unsigned int tx_dma_bandwidth;
 	unsigned int pdi1_buffer_size;
 	unsigned int rx_dma_bandwidth;
+	unsigned int fake_num_frames;
 	unsigned int data_per_frame;
 	unsigned int tx_total_bytes;
 	struct sdw_cdns_pdi *pdi0;
 	struct sdw_cdns_pdi *pdi1;
+	unsigned int rx_alignment;
+	unsigned int tx_alignment;
 	unsigned int num_frames;
+	unsigned int fake_size;
+	unsigned int tx_pad;
+	unsigned int rx_pad;
 	int command;
 	int ret1;
 	int ret;
@@ -138,6 +148,13 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 
 	command = (msg->flags & SDW_MSG_FLAG_WRITE) ? 0 : 1;
 
+	ret = sdw_cdns_bpt_find_bandwidth(command, cdns->bus.params.row,
+					  cdns->bus.params.col,
+					  prop->default_frame_rate,
+					  &tx_dma_bandwidth, &rx_dma_bandwidth);
+	if (ret < 0)
+		goto deprepare_stream;
+
 	ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row, cdns->bus.params.col,
 					     msg->len, SDW_BPT_MSG_MAX_BYTES, &data_per_frame,
 					     &pdi0_buffer_size, &pdi1_buffer_size, &num_frames);
@@ -148,10 +165,43 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	sdw->bpt_ctx.pdi1_buffer_size = pdi1_buffer_size;
 	sdw->bpt_ctx.num_frames = num_frames;
 	sdw->bpt_ctx.data_per_frame = data_per_frame;
-	tx_dma_bandwidth = div_u64((u64)pdi0_buffer_size * 8 * (u64)prop->default_frame_rate,
-				   num_frames);
-	rx_dma_bandwidth = div_u64((u64)pdi1_buffer_size * 8 * (u64)prop->default_frame_rate,
-				   num_frames);
+
+	rx_alignment = hda_sdw_bpt_get_buf_size_alignment(rx_dma_bandwidth);
+	tx_alignment = hda_sdw_bpt_get_buf_size_alignment(tx_dma_bandwidth);
+
+	if (command) { /* read */
+		/* Get buffer size of a full frame */
+		ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row,
+						     cdns->bus.params.col,
+						     data_per_frame, SDW_BPT_MSG_MAX_BYTES,
+						     &data_per_frame, &pdi0_buf_size_pre_frame,
+						     &pdi1_buf_size_pre_frame, &fake_num_frames);
+		if (ret < 0)
+			goto deprepare_stream;
+
+		/* find fake pdi1 buffer size */
+		rx_pad = rx_alignment - (pdi1_buffer_size % rx_alignment);
+		while (rx_pad <= READ_PDI1_MIN_SIZE)
+			rx_pad += rx_alignment;
+
+		pdi1_buffer_size += rx_pad;
+		/* It is fine if we request more than enough byte to read */
+		fake_num_frames = DIV_ROUND_UP(rx_pad, pdi1_buf_size_pre_frame);
+		fake_size = fake_num_frames * data_per_frame;
+
+		/* find fake pdi0 buffer size */
+		pdi0_buffer_size += (fake_num_frames * pdi0_buf_size_pre_frame);
+		tx_pad = tx_alignment - (pdi0_buffer_size % tx_alignment);
+		pdi0_buffer_size += tx_pad;
+	} else { /* write */
+		/*
+		 * For the write command, the rx data block is 4, and the rx buffer size of a frame
+		 * is 8. So the rx buffer size (pdi0_buffer_size) is always a multiple of rx
+		 * alignment.
+		 */
+		tx_pad = tx_alignment - (pdi0_buffer_size % tx_alignment);
+		pdi0_buffer_size += tx_pad;
+	}
 
 	dev_dbg(cdns->dev, "Message len %d transferred in %d frames (%d per frame)\n",
 		msg->len, num_frames, data_per_frame);
@@ -177,7 +227,8 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->addr,	msg->len,
 						       data_per_frame,
 						       sdw->bpt_ctx.dmab_tx_bdl.area,
-						       pdi0_buffer_size, &tx_total_bytes, 0);
+						       pdi0_buffer_size, &tx_total_bytes,
+						       fake_size);
 	}
 
 	if (!ret)
-- 
2.43.0


