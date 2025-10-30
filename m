Return-Path: <linux-kernel+bounces-877656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D5DC1EACD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B39F4E719D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC27337101;
	Thu, 30 Oct 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wy1AmEHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AF33506D;
	Thu, 30 Oct 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807833; cv=none; b=HLMMTa3LElVsCsAnXqMxXbsrKpfxp0NIcXDbYkGGiXc6mjpIWo+S9D4jOZUTb11Sw3gSlQeqz3GEkXjvo807XaWpoe2fvnFSEix4zlBNYrdBZicAVYE2ufTHWIxkF8NIJXNbldF+pN6ac1dtmIMU2hJXPno9oOVRH6y52ROpF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807833; c=relaxed/simple;
	bh=NKISwiKLowTCj5FE4+obKXi2pLfUB24Cz31GCbDWA3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKnvvW+kiGKGKTx8N4u8W5V31gwjHYqWBNzkCC2hQX3gm7byyPybpe8vqmAXIbEcbs138SHZDW9tEQhNBQxDaG3awC/UG+8+WM2t5icBDHpYjgCochmDhLGKYMArnFVh8o50feBLFnoiY1XTlat+Ikk42e5d9cOfwL1YGuH0iBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wy1AmEHg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807832; x=1793343832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NKISwiKLowTCj5FE4+obKXi2pLfUB24Cz31GCbDWA3s=;
  b=Wy1AmEHgYXsv4iPVsC6CgaB9QqV7uGWraz/Hf5RNBjdk+Rnxh0AAa2KL
   TFtcfzmFXPuxz+hHK5wT6JyKNF8eJogQ9Xd36bnBnQP8WR0cTJo/c/k7Q
   ZhO3KzHNCcLYFTLdyn/8er1UaEAi7PdyB2HKZHZsfkUAxhzL8pn7yj7hQ
   oO0AzSB43I9QvUgCGMLVz15YQ6oycFKrt7wgixyKsAgELh3aabKAYqoF/
   RoGn2d6UtEU0k0LfrfHDtDLgipc3YPtyI0V7MwB0gt5RCsetk0R5gL9gG
   5REiPIvRx9aziXPLHNrOLtWftXCMTAufcTHU1oglOvEOvCeUnHNJDgfok
   w==;
X-CSE-ConnectionGUID: FBs+k0G5SQq+OKW6ediYvQ==
X-CSE-MsgGUID: LpYUBL/OQe+ANBRnflJwXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359541"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:52 -0700
X-CSE-ConnectionGUID: 9iO1glVpS261SlEpEKQ2ww==
X-CSE-MsgGUID: n2ijog74QTWRmeyfQCTbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621408"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:50 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 5/7] ASoC: SOF: Intel: export hda_sdw_bpt_get_buf_size_aligment
Date: Thu, 30 Oct 2025 15:02:51 +0800
Message-ID: <20251030070253.1216871-6-yung-chuan.liao@linux.intel.com>
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
index ff5abccf0d88..e45dd051ab8c 100644
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


