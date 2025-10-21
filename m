Return-Path: <linux-kernel+bounces-862547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C418BF5934
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E1B4610A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101B32AAD2;
	Tue, 21 Oct 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNFVuax3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609082EA158;
	Tue, 21 Oct 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039854; cv=none; b=Ka5khgegsXQ28iVImu4Gy+tkhOg9wdfVVPBOgqZ9gXz98qZbspr1yr4P44NNGV32W0P6aOgxn/eQlM5PGCMC525c0Hb3Q4s4o3opzkdMR0QzznIIAbtI2kP6ZA/PD+yJjdtj3bq5N/DxbE5aLOn7eoIGI1fFmQgV7q7rE15Mbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039854; c=relaxed/simple;
	bh=HOhZsmTA3KldyGXWyx6woouKm3LnLGFrLzfFcBS04eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPTMFcdehK8D98FEwVX/AOR7S1PhuDV1jXl2y+S1cHZW/U/SHqQtAc6CWG1793zaW/kaDqcllJqznE76wS1ZYsJQV8p4aqKRG1PDxezRv7YkhXGPXNe4DZfl8ykYE3fQxF2R99zNh3jUdgAaWmrr1Lwmu7fuT/0odZqD7LMcuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNFVuax3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761039851; x=1792575851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOhZsmTA3KldyGXWyx6woouKm3LnLGFrLzfFcBS04eQ=;
  b=KNFVuax35i1WHQrlRfK2f/MrdDB5/F/S/RTowQcAnAbyE2pFsrf0JLsZ
   Zoy0j7/XEiSqgpC6PzHcir+2av4f35i8vdH693Txcy6MmDo/w49xRdITd
   NUBAiykU8+wUzszHLv/Jc5zr7DdjJr+7jfWBItH4+hWad1FL/Pn6MHVyk
   S48JriH/iWn+8EJIJCSRDI5sztobBi3q2+/hg4knJNxFo7to5ROwg/afL
   8jwusgCUmwrL4gFl920Zc7Z4LNyPeWIvxdtcf8njAkWGRJc5MxjognkWT
   Lu/PCvNMU2PWNxpsI0mQ43dPmtcefJn83cuSVM9zmx2LqCgbi/5GrzrM+
   w==;
X-CSE-ConnectionGUID: 3Tw2HyhCRhOVkgDbtpHmEw==
X-CSE-MsgGUID: IVhapV7ORNiYjrtuT+xF1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63259377"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="63259377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:10 -0700
X-CSE-ConnectionGUID: bGHNiItSSxmGtfkZZCaK5w==
X-CSE-MsgGUID: pigsSyg5RGy5YPmspykbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182753541"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: pass sdw_bpt_section to cdns BPT helpers
Date: Tue, 21 Oct 2025 17:43:53 +0800
Message-ID: <20251021094355.132943-3-yung-chuan.liao@linux.intel.com>
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

We can get start_register, data_size, and buffer data from the new
sdw_bpt_section parameter. Also, handle all register sections in the
cdns BRA helpers. No function changes as section number is 1.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Tested-by: Shuming Fan <shumingf@realtek.com>
---
 drivers/soundwire/cadence_master.c | 218 +++++++++++++++++------------
 drivers/soundwire/cadence_master.h |  12 +-
 drivers/soundwire/intel_ace2x.c    |  11 +-
 3 files changed, 139 insertions(+), 102 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4e94da28d8ad..a106e5e482c8 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -2324,17 +2324,20 @@ static int sdw_cdns_prepare_read_pd0_buffer(u8 *header, unsigned int header_size
 
 #define CDNS_BPT_ROLLING_COUNTER_START 1
 
-int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data, int data_size,
-				      int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
-				      int *dma_buffer_total_bytes)
+int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, struct sdw_bpt_section *sec, int num_sec,
+				      int data_per_frame, u8 *dma_buffer,
+				      int dma_buffer_size, int *dma_buffer_total_bytes)
 {
 	int total_dma_data_written = 0;
 	u8 *p_dma_buffer = dma_buffer;
 	u8 header[SDW_CDNS_BRA_HDR];
+	unsigned int start_register;
+	unsigned int section_size;
 	int dma_data_written;
-	u8 *p_data = data;
+	u8 *p_data;
 	u8 counter;
 	int ret;
+	int i;
 
 	counter = CDNS_BPT_ROLLING_COUNTER_START;
 
@@ -2342,47 +2345,57 @@ int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data,
 	header[0] |= GENMASK(7, 6);	/* header is active */
 	header[0] |= (dev_num << 2);
 
-	while (data_size >= data_per_frame) {
-		header[1] = data_per_frame;
-		header[2] = start_register >> 24 & 0xFF;
-		header[3] = start_register >> 16 & 0xFF;
-		header[4] = start_register >> 8 & 0xFF;
-		header[5] = start_register >> 0 & 0xFF;
-
-		ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
-							p_data, data_per_frame,
-							p_dma_buffer, dma_buffer_size,
-							&dma_data_written, counter);
-		if (ret < 0)
-			return ret;
-
-		counter++;
-
-		p_data += data_per_frame;
-		data_size -= data_per_frame;
-
-		p_dma_buffer += dma_data_written;
-		dma_buffer_size -= dma_data_written;
-		total_dma_data_written += dma_data_written;
-
-		start_register += data_per_frame;
-	}
-
-	if (data_size) {
-		header[1] = data_size;
-		header[2] = start_register >> 24 & 0xFF;
-		header[3] = start_register >> 16 & 0xFF;
-		header[4] = start_register >> 8 & 0xFF;
-		header[5] = start_register >> 0 & 0xFF;
-
-		ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
-							p_data, data_size,
-							p_dma_buffer, dma_buffer_size,
-							&dma_data_written, counter);
-		if (ret < 0)
-			return ret;
-
-		total_dma_data_written += dma_data_written;
+	for (i = 0; i < num_sec; i++) {
+		start_register = sec[i].addr;
+		section_size = sec[i].len;
+		p_data = sec[i].buf;
+
+		while (section_size >= data_per_frame) {
+			header[1] = data_per_frame;
+			header[2] = start_register >> 24 & 0xFF;
+			header[3] = start_register >> 16 & 0xFF;
+			header[4] = start_register >> 8 & 0xFF;
+			header[5] = start_register >> 0 & 0xFF;
+
+			ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+								p_data, data_per_frame,
+								p_dma_buffer, dma_buffer_size,
+								&dma_data_written, counter);
+			if (ret < 0)
+				return ret;
+
+			counter++;
+
+			p_data += data_per_frame;
+			section_size -= data_per_frame;
+
+			p_dma_buffer += dma_data_written;
+			dma_buffer_size -= dma_data_written;
+			total_dma_data_written += dma_data_written;
+
+			start_register += data_per_frame;
+		}
+
+		if (section_size) {
+			header[1] = section_size;
+			header[2] = start_register >> 24 & 0xFF;
+			header[3] = start_register >> 16 & 0xFF;
+			header[4] = start_register >> 8 & 0xFF;
+			header[5] = start_register >> 0 & 0xFF;
+
+			ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+								p_data, section_size,
+								p_dma_buffer, dma_buffer_size,
+								&dma_data_written, counter);
+			if (ret < 0)
+				return ret;
+
+			counter++;
+
+			p_dma_buffer += dma_data_written;
+			dma_buffer_size -= dma_data_written;
+			total_dma_data_written += dma_data_written;
+		}
 	}
 
 	*dma_buffer_total_bytes = total_dma_data_written;
@@ -2391,16 +2404,19 @@ int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data,
 }
 EXPORT_SYMBOL(sdw_cdns_prepare_write_dma_buffer);
 
-int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
+int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, struct sdw_bpt_section *sec, int num_sec,
 				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
 				     int *dma_buffer_total_bytes, unsigned int fake_size)
 {
 	int total_dma_data_written = 0;
 	u8 *p_dma_buffer = dma_buffer;
 	u8 header[SDW_CDNS_BRA_HDR];
+	unsigned int start_register;
+	unsigned int data_size;
 	int dma_data_written;
 	u8 counter;
 	int ret;
+	int i;
 
 	counter = CDNS_BPT_ROLLING_COUNTER_START;
 
@@ -2408,48 +2424,52 @@ int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_si
 	header[0] |= GENMASK(7, 6);	/* header is active */
 	header[0] |= (dev_num << 2);
 
-	while (data_size >= data_per_frame) {
-		header[1] = data_per_frame;
-		header[2] = start_register >> 24 & 0xFF;
-		header[3] = start_register >> 16 & 0xFF;
-		header[4] = start_register >> 8 & 0xFF;
-		header[5] = start_register >> 0 & 0xFF;
-
-		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
-						       dma_buffer_size, &dma_data_written,
-						       counter);
-		if (ret < 0)
-			return ret;
-
-		counter++;
-
-		data_size -= data_per_frame;
-
-		p_dma_buffer += dma_data_written;
-		dma_buffer_size -= dma_data_written;
-		total_dma_data_written += dma_data_written;
-
-		start_register += data_per_frame;
-	}
-
-	if (data_size) {
-		header[1] = data_size;
-		header[2] = start_register >> 24 & 0xFF;
-		header[3] = start_register >> 16 & 0xFF;
-		header[4] = start_register >> 8 & 0xFF;
-		header[5] = start_register >> 0 & 0xFF;
-
-		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
-						       dma_buffer_size, &dma_data_written,
-						       counter);
-		if (ret < 0)
-			return ret;
-
-		counter++;
-
-		p_dma_buffer += dma_data_written;
-		dma_buffer_size -= dma_data_written;
-		total_dma_data_written += dma_data_written;
+	for (i = 0; i < num_sec; i++) {
+		start_register = sec[i].addr;
+		data_size = sec[i].len;
+		while (data_size >= data_per_frame) {
+			header[1] = data_per_frame;
+			header[2] = start_register >> 24 & 0xFF;
+			header[3] = start_register >> 16 & 0xFF;
+			header[4] = start_register >> 8 & 0xFF;
+			header[5] = start_register >> 0 & 0xFF;
+
+			ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+							       p_dma_buffer, dma_buffer_size,
+							       &dma_data_written, counter);
+			if (ret < 0)
+				return ret;
+
+			counter++;
+
+			data_size -= data_per_frame;
+
+			p_dma_buffer += dma_data_written;
+			dma_buffer_size -= dma_data_written;
+			total_dma_data_written += dma_data_written;
+
+			start_register += data_per_frame;
+		}
+
+		if (data_size) {
+			header[1] = data_size;
+			header[2] = start_register >> 24 & 0xFF;
+			header[3] = start_register >> 16 & 0xFF;
+			header[4] = start_register >> 8 & 0xFF;
+			header[5] = start_register >> 0 & 0xFF;
+
+			ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+							       p_dma_buffer, dma_buffer_size,
+							       &dma_data_written, counter);
+			if (ret < 0)
+				return ret;
+
+			counter++;
+
+			p_dma_buffer += dma_data_written;
+			dma_buffer_size -= dma_data_written;
+			total_dma_data_written += dma_data_written;
+		}
 	}
 
 	/* Add fake frame */
@@ -2616,9 +2636,12 @@ static u8 extract_read_data(u32 *data, int num_bytes, u8 *buffer)
 }
 
 int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buffer_size,
-				 u8 *buffer, int buffer_size, int num_frames, int data_per_frame)
+				 struct sdw_bpt_section *sec, int num_sec, int num_frames,
+				 int data_per_frame)
 {
 	int total_num_bytes = 0;
+	int buffer_size = 0;
+	int sec_index;
 	u32 *p_data;
 	u8 *p_buf;
 	int counter;
@@ -2632,7 +2655,10 @@ int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buf
 
 	counter = CDNS_BPT_ROLLING_COUNTER_START;
 	p_data = (u32 *)dma_buffer;
-	p_buf = buffer;
+
+	sec_index = 0;
+	p_buf = sec[sec_index].buf;
+	buffer_size = sec[sec_index].len;
 
 	for (i = 0; i < num_frames; i++) {
 		header = *p_data++;
@@ -2672,6 +2698,18 @@ int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buf
 
 		counter++;
 		counter &= GENMASK(3, 0);
+
+		if (buffer_size == total_num_bytes && (i + 1) < num_frames) {
+			sec_index++;
+			if (sec_index >= num_sec) {
+				dev_err(dev, "%s: incorrect section index %d i %d\n",
+					__func__, sec_index, i);
+				return -EINVAL;
+			}
+			p_buf = sec[sec_index].buf;
+			buffer_size = sec[sec_index].len;
+			total_num_bytes = 0;
+		}
 	}
 	return 0;
 }
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index a269a87486fc..668f807cff4b 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 #include <sound/soc.h>
+#include "bus.h"
 
 #ifndef __SDW_CADENCE_H
 #define __SDW_CADENCE_H
@@ -220,11 +221,11 @@ int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
 				   unsigned int *data_per_frame, unsigned int *pdi0_buffer_size,
 				   unsigned int *pdi1_buffer_size, unsigned int *num_frames);
 
-int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data, int data_size,
-				      int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
-				      int *dma_buffer_total_bytes);
+int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, struct sdw_bpt_section *sec, int num_sec,
+				      int data_per_frame, u8 *dma_buffer,
+				      int dma_buffer_size, int *dma_buffer_total_bytes);
 
-int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
+int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, struct sdw_bpt_section *sec, int num_sec,
 				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
 				     int *dma_buffer_total_bytes, unsigned int fake_size);
 
@@ -232,5 +233,6 @@ int sdw_cdns_check_write_response(struct device *dev, u8 *dma_buffer,
 				  int dma_buffer_size, int num_frames);
 
 int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buffer_size,
-				 u8 *buffer, int buffer_size, int num_frames, int data_per_frame);
+				 struct sdw_bpt_section *sec, int num_sec, int num_frames,
+				 int data_per_frame);
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index a0f708a7cdff..300ede6bc7f1 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -220,14 +220,12 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	}
 
 	if (!command) {
-		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->sec[0].addr,
-							msg->sec[0].buf,
-							msg->sec[0].len, data_per_frame,
+		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->sec, 1,
+							data_per_frame,
 							sdw->bpt_ctx.dmab_tx_bdl.area,
 							pdi0_buffer_size, &tx_total_bytes);
 	} else {
-		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->sec[0].addr,
-						       msg->sec[0].len,
+		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->sec, 1,
 						       data_per_frame,
 						       sdw->bpt_ctx.dmab_tx_bdl.area,
 						       pdi0_buffer_size, &tx_total_bytes,
@@ -370,8 +368,7 @@ static int intel_ace2x_bpt_wait(struct sdw_intel *sdw, struct sdw_slave *slave,
 	} else {
 		ret = sdw_cdns_check_read_response(cdns->dev, sdw->bpt_ctx.dmab_rx_bdl.area,
 						   sdw->bpt_ctx.pdi1_buffer_size,
-						   msg->sec[0].buf, msg->sec[0].len,
-						   sdw->bpt_ctx.num_frames,
+						   msg->sec, 1, sdw->bpt_ctx.num_frames,
 						   sdw->bpt_ctx.data_per_frame);
 		if (ret < 0)
 			dev_err(cdns->dev, "%s: BPT Read failed %d\n", __func__, ret);
-- 
2.43.0


