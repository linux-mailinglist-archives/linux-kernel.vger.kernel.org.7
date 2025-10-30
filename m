Return-Path: <linux-kernel+bounces-877652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA0C1EAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E983AAAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EC335090;
	Thu, 30 Oct 2025 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL9LNJTu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C5293C4E;
	Thu, 30 Oct 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807824; cv=none; b=Uoqn2jXs4c1+pcXCN8G1rSgBvZqcmjIHnhv3hQ8xunBAnWBddFJEteoHCeIsn8rMrERsC7baXFH/cBXquZ1dPIraeHiRxrXQqBxiKJwPstVWcFcEBs2AcumW0B74Pk0pKi5WycRh1+dQM7p88ubyG21rmuQ+KwR2WXM/jJl4N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807824; c=relaxed/simple;
	bh=fPrn5rSywxhgIBMOoYkamAw00lrPDv+ETPbiLdOq2eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS59+8U8s7oLK20KC+82SeaH/AqbS8vD2sKmwbUqYJNPOBByvR3q2Q4YCj5QB5Amh2Wa7rnoy4IBA3RXsc99clJEEPokpHVjo245Qb9V3fhZQzK5LmRWs96pghO8qEqV3ZVHYrcr2R9dskriySodKB+YVV114CAF82LzaZdjqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL9LNJTu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807824; x=1793343824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPrn5rSywxhgIBMOoYkamAw00lrPDv+ETPbiLdOq2eU=;
  b=jL9LNJTuU5SKoCfjrYF2QN6SkHYPGKKjkHppa8RCLwS5DCEAwTTLGJut
   PZcywToci8dGKzeFqfA9YJ4zd/nnqDj49cSdWnJ0bDx8gLPKHn9masuVp
   ScPKPPYuIDtZJMFeI+86bEYXD09OIErTl7mCv6JoW6MbTiMUV8QhZE6Db
   RrYf09lNXCIbQjQ9/OpIb6hMOfpnHiIzr+tDPKqMLyrfL0l/ZaOPSBNTY
   eCSo7vXMVzTNMcPhF/0ZHUIvoc/ieOt8UjyEaSORx8zUA4MXVojJQaXy/
   9XJlrVnOSynf1fYYR+Rgs7JeVOwBUUYb0sqbRv4Z0yRSqKLsTc2Y59iR1
   w==;
X-CSE-ConnectionGUID: bm8Ob5hqSm2TmO3idaseJA==
X-CSE-MsgGUID: Fz8JBHPiT3afTQf4Xrjgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359518"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359518"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:43 -0700
X-CSE-ConnectionGUID: kX2G1+xhTSOoWT30jVIGEw==
X-CSE-MsgGUID: /N11j5TKR6iWFzdwzo8GOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621363"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 1/7] soundwire: cadence_master: make frame index trace more readable
Date: Thu, 30 Oct 2025 15:02:47 +0800
Message-ID: <20251030070253.1216871-2-yung-chuan.liao@linux.intel.com>
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

The existing code uses i as the frame index which is 0 based. And
"bad frame %d/%d", i, num_frames where num_frames is 1 based. Change the
frame index to i + 1 to align with num_frames and more readable.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 21bb491d026b..c59a98b408b3 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -2495,14 +2495,14 @@ int sdw_cdns_check_write_response(struct device *dev, u8 *dma_buffer,
 		ret = check_frame_start(header, counter);
 		if (ret < 0) {
 			dev_err(dev, "%s: bad frame %d/%d start header %x\n",
-				__func__, i, num_frames, header);
+				__func__, i + 1, num_frames, header);
 			return ret;
 		}
 
 		ret = check_frame_end(footer);
 		if (ret < 0) {
 			dev_err(dev, "%s: bad frame %d/%d end footer %x\n",
-				__func__, i, num_frames, footer);
+				__func__, i + 1, num_frames, footer);
 			return ret;
 		}
 
@@ -2573,7 +2573,7 @@ int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buf
 		ret = check_frame_start(header, counter);
 		if (ret < 0) {
 			dev_err(dev, "%s: bad frame %d/%d start header %x\n",
-				__func__, i, num_frames, header);
+				__func__, i + 1, num_frames, header);
 			return ret;
 		}
 
@@ -2588,7 +2588,7 @@ int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buf
 
 		if (crc != expected_crc) {
 			dev_err(dev, "%s: bad frame %d/%d crc %#x expected %#x\n",
-				__func__, i, num_frames, crc, expected_crc);
+				__func__, i + 1, num_frames, crc, expected_crc);
 			return -EIO;
 		}
 
@@ -2599,7 +2599,7 @@ int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buf
 		ret = check_frame_end(footer);
 		if (ret < 0) {
 			dev_err(dev, "%s: bad frame %d/%d end footer %x\n",
-				__func__, i, num_frames, footer);
+				__func__, i + 1, num_frames, footer);
 			return ret;
 		}
 
-- 
2.43.0


