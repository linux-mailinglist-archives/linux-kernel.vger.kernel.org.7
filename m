Return-Path: <linux-kernel+bounces-851742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DDBD72A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093E93AC0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C030ACFC;
	Tue, 14 Oct 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyrFdxMF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AA126C02;
	Tue, 14 Oct 2025 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411714; cv=none; b=kfqN7DdLp3drp1xnsaf7pVfqpLfNg4hgvCraK0ihOHb9AYJiKHekMR9RlKYPY47RxdWiT+q9Vmhulv3Ghx2CZpbVgJPQ2uJWpQ+hRClpx1E6Ph4fanLxEUT6ouw1rXGyQmixX4sO+Fk7AmrV8C/lXkPgGz/AyF6de1VkmeMbjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411714; c=relaxed/simple;
	bh=+9NmTuQ2Dj3WIbfFxJHgYytJ4NdDwy3IaKM1zDQNvDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6oQSKUu1pf5fCVXIZlIyW14Az6YUEDcojXXq9jva8D/4rV6n/9RDu9DZ2AvIX7BKiL9ZsKtetkQ05T168R9N90a+TgGuXsDmxMsAiWm6xMLMRSr7qplL1hKOLcgd8oxh7PUqtonm/P9tcnLdAfk/TyQUDGaxmd/NMsi4MQTVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyrFdxMF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411712; x=1791947712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9NmTuQ2Dj3WIbfFxJHgYytJ4NdDwy3IaKM1zDQNvDI=;
  b=QyrFdxMFDQkEtSKBEkWAiEd16EajkNJXnI0LIGt2TElCiZxwC2cvnJlr
   WOwFzvHNUF4s5BanQ86Ez5/EtRQTmIcN8nPmRboqDfPESJjfgPy9fHN3O
   H6zKzYk0qFmzx16lJdGf344pURW3pBJ+XA4SgI1mb2ckRvlvD4iGyAtJT
   3aJiDc7JR7v2uKHaROy2DqGOaRJGvUf42nWn9Abh4HtuiV0nbMaFT1Jzd
   kBXkES4/IpIf8OGstjfF1Mils367QXllLV/i1rHGKMVTVnov5kyPtF47d
   EWnaRh9PXGsVKpFdwBfQZgcpMQq38Z8ebzrBQi3Sg4p+TM3ujXA4KX5XQ
   w==;
X-CSE-ConnectionGUID: RzF4hcZFTPOTQjpBdue/Qg==
X-CSE-MsgGUID: 2galyq2qTHSUA6RDlQ6F6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662087"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662087"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:12 -0700
X-CSE-ConnectionGUID: p3rrwpYpQICeHRR/oyUCHQ==
X-CSE-MsgGUID: YU14E1dRSVGgmO4ucQExag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198583"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:10 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 5/7] ASoC: SOF: Intel: export hda_sdw_bpt_get_buf_size_aligment
Date: Tue, 14 Oct 2025 11:14:48 +0800
Message-ID: <20251014031450.3781789-6-yung-chuan.liao@linux.intel.com>
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

The dma buffer need to be a multiple of data block size and
the fifo size. Export a function to return the LCM of data
block size and the fifo size.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/hda-sdw-bpt.h       |  7 +++++++
 sound/soc/sof/intel/hda-sdw-bpt.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/hda-sdw-bpt.h b/include/sound/hda-sdw-bpt.h
index f649549b75d5..9b654c31829a 100644
--- a/include/sound/hda-sdw-bpt.h
+++ b/include/sound/hda-sdw-bpt.h
@@ -30,6 +30,8 @@ int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
 int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
 		      struct snd_dma_buffer *dmab_tx_bdl, struct hdac_ext_stream *bpt_rx_stream,
 		      struct snd_dma_buffer *dmab_rx_bdl);
+
+unsigned int hda_sdw_bpt_get_buf_size_alignment(unsigned int dma_bandwidth);
 #else
 static inline int hda_sdw_bpt_open(struct device *dev, int link_id,
 				   struct hdac_ext_stream **bpt_tx_stream,
@@ -64,6 +66,11 @@ static inline int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *
 	WARN_ONCE(1, "SoundWire BPT is disabled");
 	return -EOPNOTSUPP;
 }
+
+static inline unsigned int hda_sdw_bpt_get_buf_size_alignment(unsigned int dma_bandwidth)
+{
+	return 0;
+}
 #endif
 
 #endif /* __HDA_SDW_BPT_H */
diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
index 1327f1cad0bc..11df4cf1e33e 100644
--- a/sound/soc/sof/intel/hda-sdw-bpt.c
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -10,6 +10,7 @@
  * Hardware interface for SoundWire BPT support with HDA DMA
  */
 
+#include <linux/lcm.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda-mlink.h>
 #include <sound/hda-sdw-bpt.h>
@@ -236,6 +237,18 @@ static int hda_sdw_bpt_dma_disable(struct device *dev, struct hdac_ext_stream *s
 	return ret;
 }
 
+#define FIFO_ALIGNMENT	64
+
+unsigned int hda_sdw_bpt_get_buf_size_alignment(unsigned int dma_bandwidth)
+{
+	unsigned int num_channels = DIV_ROUND_UP(dma_bandwidth, BPT_FREQUENCY * 32);
+	unsigned int data_block = num_channels * 4;
+	unsigned int alignment = lcm(data_block, FIFO_ALIGNMENT);
+
+	return alignment;
+}
+EXPORT_SYMBOL_NS(hda_sdw_bpt_get_buf_size_alignment, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
+
 int hda_sdw_bpt_open(struct device *dev, int link_id, struct hdac_ext_stream **bpt_tx_stream,
 		     struct snd_dma_buffer *dmab_tx_bdl, u32 bpt_tx_num_bytes,
 		     u32 tx_dma_bandwidth, struct hdac_ext_stream **bpt_rx_stream,
-- 
2.43.0


