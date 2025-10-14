Return-Path: <linux-kernel+bounces-851743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE38BD72A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9BF19A11B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BE30AD08;
	Tue, 14 Oct 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWaXOlo8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7230AAA6;
	Tue, 14 Oct 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411715; cv=none; b=D7tEuyEWq9nwZonzRPsj4OWevLa56lkpp0LqUt2FORGuBnFsEboY+J5ErA6FNpsglAAaAIopfAPDW7K91YfMRQeQixuYPf0cddzUAQqHrm+ZsHRo+dYG9Yd8iG/Qf6pJ3Rxc/MvarMBzetYYby9zndBzR1Qx0w79PH0digxV5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411715; c=relaxed/simple;
	bh=UbR/bMPXxaB/zDQV3v8s7FcdG+sxaTfUHnva5xYqVNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox4ya94Vj1LaaRH0HB/n+A/q8m9o3W8ZZKzzhUqyiC26pY7lFDF4riZJuG2SGcEPHI073JiiTRb3J52RFQRkfK1gI52Cs+0EHKaHe1anmtAgFYcV6OhlN5VCT1aksR/Mt49v6Lu/ruWH0P+e+4dFjjg7EnFyzaQdT3AXIoYTwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWaXOlo8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411712; x=1791947712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbR/bMPXxaB/zDQV3v8s7FcdG+sxaTfUHnva5xYqVNc=;
  b=CWaXOlo8lNGFtg+TenB2ElAj9gQMrGl3MsZ/8y6Idxc4eULyZS+W/wOn
   BL2zL94dvJZA9a1UQJ5/XtVeyKLLIcDU+NA6NjJ2ij2vsH0PMRbKXjRfz
   5Gbx62UGtbzLkWKm0izLqSnb+EO0+/9ECpmcOrtCH3vp4s8lVrBtlv4eE
   cOrEkKJxxO5Niel/+sXuryGIYDdmsW5IKsxQY49yYdVUezJFEhiEb+aqz
   wE5o8K51d4mrf8zUXrsMw8rPQ7VSOuzXgWUDkuMHqdr3xEoRX4zRml3qN
   7Q7RT6+EpvZjeW1c/Yh2HO8aYIBBFYxooX+gWZU7ThYHkiUIDqKgek6V2
   A==;
X-CSE-ConnectionGUID: wyd901gsS/6nnJP335+8Dw==
X-CSE-MsgGUID: HiQq1K1QQ8ea+0eG76YThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662083"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:10 -0700
X-CSE-ConnectionGUID: IvQirI/MRiuns8MxPpTAAA==
X-CSE-MsgGUID: buJ3+V1ZRGSO4XX5aVHlMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198568"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 4/7] soundwire: cadence: export sdw_cdns_bpt_find_bandwidth
Date: Tue, 14 Oct 2025 11:14:47 +0800
Message-ID: <20251014031450.3781789-5-yung-chuan.liao@linux.intel.com>
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

Currently, we calculate the required bandwidth after the PDI buffer size
is calculated. However as we need to add some fake frame to align the
data block size, the final PDI size and the frame number will change.
Besides, we need the required bandwidth to decide the DMA channel number
and the channel number will be used to calculate the data block size.
Therefore, we calculate the required bandwidth and export a helper for
the caller to get the required bandwidth.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 30 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 178341410909..57671f9b3e9c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -2094,6 +2094,36 @@ static unsigned int sdw_cdns_read_pdi1_buffer_size(unsigned int actual_data_size
 	return total * 2;
 }
 
+int sdw_cdns_bpt_find_bandwidth(int command, /* 0: write, 1: read */
+				int row, int col, int frame_rate,
+				unsigned int *tx_dma_bandwidth,
+				unsigned int *rx_dma_bandwidth)
+{
+	unsigned int bpt_bits = row * (col - 1);
+	unsigned int bpt_bytes = bpt_bits >> 3;
+	unsigned int pdi0_buffer_size;
+	unsigned int pdi1_buffer_size;
+	unsigned int data_per_frame;
+
+	data_per_frame = sdw_cdns_bra_actual_data_size(bpt_bytes);
+	if (!data_per_frame)
+		return -EINVAL;
+
+	if (command == 0) {
+		pdi0_buffer_size = sdw_cdns_write_pdi0_buffer_size(data_per_frame);
+		pdi1_buffer_size = SDW_CDNS_WRITE_PDI1_BUFFER_SIZE;
+	} else {
+		pdi0_buffer_size = SDW_CDNS_READ_PDI0_BUFFER_SIZE;
+		pdi1_buffer_size = sdw_cdns_read_pdi1_buffer_size(data_per_frame);
+	}
+
+	*tx_dma_bandwidth = pdi0_buffer_size * 8 * frame_rate;
+	*rx_dma_bandwidth = pdi1_buffer_size * 8 * frame_rate;
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_bpt_find_bandwidth);
+
 int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
 				   int row, int col, unsigned int data_bytes,
 				   unsigned int requested_bytes_per_frame,
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 9373426c7f63..6830d7f2d772 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -209,6 +209,11 @@ void sdw_cdns_config_update(struct sdw_cdns *cdns);
 int sdw_cdns_config_update_set_wait(struct sdw_cdns *cdns);
 
 /* SoundWire BPT/BRA helpers to format data */
+int sdw_cdns_bpt_find_bandwidth(int command, /* 0: write, 1: read */
+				int row, int col, int frame_rate,
+				unsigned int *tx_dma_bandwidth,
+				unsigned int *rx_dma_bandwidth);
+
 int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
 				   int row, int col, unsigned int data_bytes,
 				   unsigned int requested_bytes_per_frame,
-- 
2.43.0


