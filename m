Return-Path: <linux-kernel+bounces-877655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA076C1EACA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02EC94E74BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F1336EEE;
	Thu, 30 Oct 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDZI71M4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370B335BAF;
	Thu, 30 Oct 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807831; cv=none; b=KDdfwsIvx7d3/Yi8jPmxQwfWPXgLHlPSm6qe3VIVD3JjmVvAaRGytbbUctssr71LUmK0oPN23sXss5/5sOfYrpXHyzUz8wYYeMsKl6RpInbPsGH0IHxaohXrfeIH/4vzcXQtrYkWxDbeBBOYFsH3UX4THJOADeiAGZHFSYgalko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807831; c=relaxed/simple;
	bh=UbR/bMPXxaB/zDQV3v8s7FcdG+sxaTfUHnva5xYqVNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYUFGBYcXGO/13sAl41WP/K8jkAuIGPQt7IyllhQjhIQqMGbcjXOLp8Jud3F5l2JvZvL1M0v/kpAU+wyd4pix3Jt30o2yAmoLUjD77uCZzN2ZDaCdHzhun5GICtu6aDM9tT68U2t0uZpGl3RxhErTqUjtziKbQAxGk+pZFmAnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDZI71M4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807830; x=1793343830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbR/bMPXxaB/zDQV3v8s7FcdG+sxaTfUHnva5xYqVNc=;
  b=LDZI71M4rpFfGX0USgnVKYdD8yReVeMEi2m9SnjUdIfAY8l/m5Ebs5hU
   2cKX49hqgYwF0o9R8mxpHX9w82MCwLTBX5tPrUCALNQXeMlve47Rrobd5
   9Qhg34arc2r9dgjTllYB95TYKrEc+uzLMz8/QIP6vVIG96iPpcgG7iBgD
   JS5O3C7vHbLOYbziDNCNFwrz9uvZbGKGyrfgH+zeUX5dptiQI8RMC/MrF
   7ascp7thQQSf1+z3QDUchXQ6GQIB6kE+9OFtqLzej5MYHu1e2YqfFoBjW
   IzL0b2H/DjfJZB2McbNHMj3y410n0kqYWFNcVjxpx3PMzh+L4ljMQuRZB
   w==;
X-CSE-ConnectionGUID: y7tTLHlST3e666If/uCKjg==
X-CSE-MsgGUID: UOqZV3ZNTtGBYSWLBs3gjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359530"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:50 -0700
X-CSE-ConnectionGUID: eouuUOc4Rdi1JeFpnsvpLg==
X-CSE-MsgGUID: UsNEoUIVQr+J5uDUeZ353Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621397"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:47 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 4/7] soundwire: cadence: export sdw_cdns_bpt_find_bandwidth
Date: Thu, 30 Oct 2025 15:02:50 +0800
Message-ID: <20251030070253.1216871-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
References: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
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


