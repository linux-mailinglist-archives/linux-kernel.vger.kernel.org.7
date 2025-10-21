Return-Path: <linux-kernel+bounces-862546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85ABF5931
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC6F4FF74F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3EB328624;
	Tue, 21 Oct 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHDWPYdJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609862F744C;
	Tue, 21 Oct 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039853; cv=none; b=USKmPOK+pd9QPjqPIfjAQNxWspQkXVPlm6gnlYcdShUHIQfoOtrH6zOuIPiZ5GJlaflYehuvT9Z8APXgA7XYr+EHWGDADtnJjrSrjmU69exFW6ZZdP59oCuBVuLa5MxCIdZxVWLhrGmH5cNa/81/jpfca0pnJpEu9r8CrVxk8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039853; c=relaxed/simple;
	bh=GmShjL6FtP90Nh6uWEeIlkGwnSP52u115p0hkXvrcdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYG7IHHSSXYFQYAv0aspRVH43LTXyZw4wkG4SBNeGbwB+ZxPezVz43AXlf5ZjrFT07NOQJh6wC2P5/IU03nlijfOqc1r68Gx+xeuQZ+m+jA4KvCDvXYSoxKcXYj4C8EUvCufkFxvWftL+yfBOEthL+2L7e17m15sJOJAJJhmgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHDWPYdJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761039851; x=1792575851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmShjL6FtP90Nh6uWEeIlkGwnSP52u115p0hkXvrcdc=;
  b=SHDWPYdJvFKGTgfh83LlsyRlkCk/nqVY4lwlkBsE8LJRHgZ+PIMGS0rW
   cC3MV8HrcAkC20s01PNMXuK0TaYO2CrcP4xTBhBBDWzfHOCw9H94gqMjV
   XPwURLdOxBy/YS1NouE7AJkZAOXBrS2SnB0p6LFfz10npvResg3Qb42/a
   7x3lShztJBGwP0yQXyqiyFcpx2KA780WqxroN0xhUxo2WO6hZ3dOV/rb9
   ueepX2FAOg1CBWFujxoEy7dDiJgnBoAF2vzkna0mvBl+n8A9qZSv0LMZO
   45RAvTmRpKqZo91ExlrDDjO66s8jzOtR+gBRUzhv9j+w60z68TrPAQwe6
   A==;
X-CSE-ConnectionGUID: xIn0SvrJTqqFQmtXRi1ptg==
X-CSE-MsgGUID: R0hpvMZ5SiiPPUWX4txVjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63259375"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="63259375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:08 -0700
X-CSE-ConnectionGUID: uwOhuCs/QU+PF9xZY6fw8g==
X-CSE-MsgGUID: ZfxkHzxnRked0a4MSEsbRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182753534"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:07 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: introduce BPT section
Date: Tue, 21 Oct 2025 17:43:52 +0800
Message-ID: <20251021094355.132943-2-yung-chuan.liao@linux.intel.com>
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

Currently we send a BRA message with a start address with continuous
registers in a BPT stream. However, a codec may need to write different
register sections shortly. Introduce a register section in struct
sdw_btp_msg which contain register start address, length, and buffer.
This commit uses only 1 section for each BPT message. And we need to add
up all BPT section length and check if it reach maximum BPT bytes.
No function changes.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Tested-by: Shuming Fan <shumingf@realtek.com>
---
 drivers/soundwire/bus.c         | 10 ++++++++--
 drivers/soundwire/bus.h         | 22 ++++++++++++++++------
 drivers/soundwire/debugfs.c     | 14 +++++++++++---
 drivers/soundwire/intel_ace2x.c | 22 +++++++++++++---------
 4 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 55c1db816534..fb68738dfb9b 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -2052,8 +2052,14 @@ EXPORT_SYMBOL(sdw_clear_slave_status);
 
 int sdw_bpt_send_async(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg)
 {
-	if (msg->len > SDW_BPT_MSG_MAX_BYTES) {
-		dev_err(bus->dev, "Invalid BPT message length %d\n", msg->len);
+	int len = 0;
+	int i;
+
+	for (i = 0; i < msg->sections; i++)
+		len += msg->sec[i].len;
+
+	if (len > SDW_BPT_MSG_MAX_BYTES) {
+		dev_err(bus->dev, "Invalid BPT message length %d\n", len);
 		return -EINVAL;
 	}
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 02651fbb683a..8115c64dd48e 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -73,21 +73,31 @@ struct sdw_msg {
 };
 
 /**
- * struct sdw_btp_msg - Message structure
+ * struct sdw_btp_section - Message section structure
  * @addr: Start Register address accessed in the Slave
  * @len: number of bytes to transfer. More than 64Kb can be transferred
  * but a practical limit of SDW_BPT_MSG_MAX_BYTES is enforced.
- * @dev_num: Slave device number
- * @flags: transfer flags, indicate if xfer is read or write
- * @buf: message data buffer (filled by host for write, filled
+ * @buf: section data buffer (filled by host for write, filled
  * by Peripheral hardware for reads)
  */
-struct sdw_bpt_msg {
+struct sdw_bpt_section {
 	u32 addr;
 	u32 len;
+	u8 *buf;
+};
+
+/**
+ * struct sdw_btp_msg - Message structure
+ * @sec: Pointer to array of sections
+ * @sections: Number of sections in the array
+ * @dev_num: Slave device number
+ * @flags: transfer flags, indicate if xfer is read or write
+ */
+struct sdw_bpt_msg {
+	struct sdw_bpt_section *sec;
+	int sections;
 	u8 dev_num;
 	u8 flags;
-	u8 *buf;
 };
 
 #define SDW_DOUBLE_RATE_FACTOR		2
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 1e0f9318b616..6068011dd0d9 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -222,15 +222,23 @@ DEFINE_DEBUGFS_ATTRIBUTE(set_num_bytes_fops, NULL,
 static int do_bpt_sequence(struct sdw_slave *slave, bool write, u8 *buffer)
 {
 	struct sdw_bpt_msg msg = {0};
+	struct sdw_bpt_section *sec;
 
-	msg.addr = start_addr;
-	msg.len = num_bytes;
+	sec = kcalloc(1, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+	msg.sections = 1;
+
+	sec[0].addr = start_addr;
+	sec[0].len = num_bytes;
+
+	msg.sec = sec;
 	msg.dev_num = slave->dev_num;
 	if (write)
 		msg.flags = SDW_MSG_FLAG_WRITE;
 	else
 		msg.flags = SDW_MSG_FLAG_READ;
-	msg.buf = buffer;
+	sec[0].buf = buffer;
 
 	return sdw_bpt_send_sync(slave->bus, slave, &msg);
 }
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index e11a0cf77193..a0f708a7cdff 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -156,8 +156,9 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 		goto deprepare_stream;
 
 	ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row, cdns->bus.params.col,
-					     msg->len, SDW_BPT_MSG_MAX_BYTES, &data_per_frame,
-					     &pdi0_buffer_size, &pdi1_buffer_size, &num_frames);
+					     msg->sec[0].len, SDW_BPT_MSG_MAX_BYTES,
+					     &data_per_frame, &pdi0_buffer_size, &pdi1_buffer_size,
+					     &num_frames);
 	if (ret < 0)
 		goto deprepare_stream;
 
@@ -204,7 +205,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	}
 
 	dev_dbg(cdns->dev, "Message len %d transferred in %d frames (%d per frame)\n",
-		msg->len, num_frames, data_per_frame);
+		msg->sec[0].len, num_frames, data_per_frame);
 	dev_dbg(cdns->dev, "sizes pdi0 %d pdi1 %d tx_bandwidth %d rx_bandwidth %d\n",
 		pdi0_buffer_size, pdi1_buffer_size, tx_dma_bandwidth, rx_dma_bandwidth);
 
@@ -219,12 +220,14 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	}
 
 	if (!command) {
-		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->addr, msg->buf,
-							msg->len, data_per_frame,
+		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->sec[0].addr,
+							msg->sec[0].buf,
+							msg->sec[0].len, data_per_frame,
 							sdw->bpt_ctx.dmab_tx_bdl.area,
 							pdi0_buffer_size, &tx_total_bytes);
 	} else {
-		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->addr,	msg->len,
+		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->sec[0].addr,
+						       msg->sec[0].len,
 						       data_per_frame,
 						       sdw->bpt_ctx.dmab_tx_bdl.area,
 						       pdi0_buffer_size, &tx_total_bytes,
@@ -305,9 +308,9 @@ static int intel_ace2x_bpt_send_async(struct sdw_intel *sdw, struct sdw_slave *s
 	struct sdw_cdns *cdns = &sdw->cdns;
 	int ret;
 
-	if (msg->len < INTEL_BPT_MSG_BYTE_MIN) {
+	if (msg->sec[0].len < INTEL_BPT_MSG_BYTE_MIN) {
 		dev_err(cdns->dev, "BPT message length %d is less than the minimum bytes %d\n",
-			msg->len, INTEL_BPT_MSG_BYTE_MIN);
+			msg->sec[0].len, INTEL_BPT_MSG_BYTE_MIN);
 		return -EINVAL;
 	}
 
@@ -367,7 +370,8 @@ static int intel_ace2x_bpt_wait(struct sdw_intel *sdw, struct sdw_slave *slave,
 	} else {
 		ret = sdw_cdns_check_read_response(cdns->dev, sdw->bpt_ctx.dmab_rx_bdl.area,
 						   sdw->bpt_ctx.pdi1_buffer_size,
-						   msg->buf, msg->len, sdw->bpt_ctx.num_frames,
+						   msg->sec[0].buf, msg->sec[0].len,
+						   sdw->bpt_ctx.num_frames,
 						   sdw->bpt_ctx.data_per_frame);
 		if (ret < 0)
 			dev_err(cdns->dev, "%s: BPT Read failed %d\n", __func__, ret);
-- 
2.43.0


