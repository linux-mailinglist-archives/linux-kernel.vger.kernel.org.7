Return-Path: <linux-kernel+bounces-877657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A12C1EAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BFF3AAD64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B233506D;
	Thu, 30 Oct 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQJZFthu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D528336EEC;
	Thu, 30 Oct 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807835; cv=none; b=q4V+5Cu8hhS/9fcK/Ly3o48bspHKf5M8LA6Vb3+zv3ThLfs8AkVQK5rZTf2aPI5PNzStr20KqZdfXN9J8/WchN4yRIzb5hBE+4JziACcyjQKgrNJqkOQhVtGW/IGjYiIsuocD/WBF4SDKS7ECjUpL16/R1Oune5cNxyz2LTJBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807835; c=relaxed/simple;
	bh=bST5A1RZ2UDNZ/IHVgdVziruZsuAPXLZmxs9N0Kmacw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD025DnWyt04/NyqrjYXx6yG6qPEg+7mJdW7wPNMhIsMoZRS051IEuiaKhlLnEzaDvZF8ePduusYoRk/Ix8JqbWo9GlnanU8Wp36EP7DTO1T/+jMg0yHf+P2KFFMh51sdB/HY764N4CQfOjWum1R49NkXac+L50WtNu1Fm6OrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQJZFthu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807835; x=1793343835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bST5A1RZ2UDNZ/IHVgdVziruZsuAPXLZmxs9N0Kmacw=;
  b=EQJZFthuZmplBOgFcw0rVmR0jhY7BIn7XEfsc11pT2ioJyeiAzimoyrK
   hUt1PLm8klyk7hAcjArLwJuM8TrUqbMB5jz9JTk+h1wx6ltuWdXd4X2bi
   CE6wclyskZgMr/z3UJPna5ho9ryKfX6GcLglJ6fjmKjZyeNGqHAb3DTaw
   b/iO2Ic0rPfHsaMg+m/urOIaet5VR1JExrDecMf8WK8JPC82+TOPHigOg
   5enkpZnnDJtaoWQyG0ZcDpF/x4iHL+rICD9gk2UJo8/P9ivS+RFX5Crcm
   5fxHGhp29wcqLLmDnZkGEeEoTkeT6NetvvwLNEhlqGHjtMyjGXXL3Xp3d
   A==;
X-CSE-ConnectionGUID: l7FKqHVzSxelnilNxvrYAg==
X-CSE-MsgGUID: sByx1oIkTK6Mw5vsb0CKHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359546"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359546"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:54 -0700
X-CSE-ConnectionGUID: CEJ/rbLlQ/izTKvnAAUSDg==
X-CSE-MsgGUID: Lk/DruQ4SLaiEIlbL+HGwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621416"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:52 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 6/7] soundwire: cadence_master: add fake_size parameter to sdw_cdns_prepare_read_dma_buffer
Date: Thu, 30 Oct 2025 15:02:52 +0800
Message-ID: <20251030070253.1216871-7-yung-chuan.liao@linux.intel.com>
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


