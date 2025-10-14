Return-Path: <linux-kernel+bounces-851745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF67BD72AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D28D189EAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438130ACF4;
	Tue, 14 Oct 2025 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNNofO7L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72097309F09;
	Tue, 14 Oct 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411717; cv=none; b=mZdOQRvvMiL3+Th14uA0fGICpoavI054ShwmOMZi9QgovqyrSDbjFpjORdMCAEnDNhUv/tDag66s/d5vXqARYedSN37HNoM9H9q4yre6tY+IRpCaVQU4NTLsm0/6AFgi9hxXcAmrI4YubLK7eQAJjOZA9n7mgSjDOAHm4I1taB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411717; c=relaxed/simple;
	bh=bST5A1RZ2UDNZ/IHVgdVziruZsuAPXLZmxs9N0Kmacw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEikJLjOmu/aIM8TCJw2HnoFlprOL83TvgPhnA7BNHpvuORTQpBBn0k5XATaQY9DDMNF2v7+CGT6Jpa2SV/mTVweISBD4tQA+Mqfv7ML/+yRJnwl5OvKQpKpy2+KP9sS2NAPogsQ59+0EJH9KKV4TxtahHVghUCJEGJs4Y9FOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNNofO7L; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411714; x=1791947714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bST5A1RZ2UDNZ/IHVgdVziruZsuAPXLZmxs9N0Kmacw=;
  b=hNNofO7LwdO027j8ksmeNMWZ1pztIx63ZWj6DAvUQYwDwfk40VXvcNil
   n5+DZA8rLo7IWludEt0WEzc2JoClymD56lS/hEILIeo2oLNg7k9iVssY5
   lNA4wAwXhU88pt2ysE6YhOlP7RguKVNw+Dfcdja04INRrURQu+luSvP5S
   rd/vW9LcKy+PoGNqKt7vF3zBXuDJAhyxXLJXK3bQuA0w8tqCDHDFLR0wf
   +3BEjQLo/7Cxcqn+P/T1YfbsIIMNhFvJ75AYuQrbcwTATiZX182nwAq8q
   6Wv/mWQISx302egu93nwL2sLMChL3M+OYN6BSVVl1JqiUNW+YevTIdx77
   A==;
X-CSE-ConnectionGUID: fLqyf95uQt6iFlo7tJiXWg==
X-CSE-MsgGUID: S7yXRpEtQwScQckT3I24ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662092"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:13 -0700
X-CSE-ConnectionGUID: aur5r7AjTiG9gc9Elt48tQ==
X-CSE-MsgGUID: 3QzdLynVST2fMJ+qBvflyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198591"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:12 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: cadence_master: add fake_size parameter to sdw_cdns_prepare_read_dma_buffer
Date: Tue, 14 Oct 2025 11:14:49 +0800
Message-ID: <20251014031450.3781789-7-yung-chuan.liao@linux.intel.com>
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

We may need to add few fake frames to fit the aligned read dma buffer
size. Add a fake_size parameter to allow the caller to set the fake data
size.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 39 +++++++++++++++++++++++++++++-
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel_ace2x.c    |  2 +-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 57671f9b3e9c..4e94da28d8ad 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -2393,7 +2393,7 @@ EXPORT_SYMBOL(sdw_cdns_prepare_write_dma_buffer);
 
 int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
 				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
-				     int *dma_buffer_total_bytes)
+				     int *dma_buffer_total_bytes, unsigned int fake_size)
 {
 	int total_dma_data_written = 0;
 	u8 *p_dma_buffer = dma_buffer;
@@ -2445,6 +2445,43 @@ int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_si
 		if (ret < 0)
 			return ret;
 
+		counter++;
+
+		p_dma_buffer += dma_data_written;
+		dma_buffer_size -= dma_data_written;
+		total_dma_data_written += dma_data_written;
+	}
+
+	/* Add fake frame */
+	header[0] &= ~GENMASK(7, 6);	/* Set inactive flag in BPT/BRA frame heade */
+	while (fake_size >= data_per_frame) {
+		header[1] = data_per_frame;
+		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
+						       dma_buffer_size, &dma_data_written,
+						       counter);
+		if (ret < 0)
+			return ret;
+
+		counter++;
+
+		fake_size -= data_per_frame;
+		p_dma_buffer += dma_data_written;
+		dma_buffer_size -= dma_data_written;
+		total_dma_data_written += dma_data_written;
+	}
+
+	if (fake_size) {
+		header[1] = fake_size;
+		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
+						       dma_buffer_size, &dma_data_written,
+						       counter);
+		if (ret < 0)
+			return ret;
+
+		counter++;
+
+		p_dma_buffer += dma_data_written;
+		dma_buffer_size -= dma_data_written;
 		total_dma_data_written += dma_data_written;
 	}
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 6830d7f2d772..a269a87486fc 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -226,7 +226,7 @@ int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data,
 
 int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
 				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
-				     int *dma_buffer_total_bytes);
+				     int *dma_buffer_total_bytes, unsigned int fake_size);
 
 int sdw_cdns_check_write_response(struct device *dev, u8 *dma_buffer,
 				  int dma_buffer_size, int num_frames);
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 5d08364ad6d1..22118b053d56 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -177,7 +177,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->addr,	msg->len,
 						       data_per_frame,
 						       sdw->bpt_ctx.dmab_tx_bdl.area,
-						       pdi0_buffer_size, &tx_total_bytes);
+						       pdi0_buffer_size, &tx_total_bytes, 0);
 	}
 
 	if (!ret)
-- 
2.43.0


