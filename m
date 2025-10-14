Return-Path: <linux-kernel+bounces-851740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DACBD729D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187D819A0DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A2307AC0;
	Tue, 14 Oct 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpwJbPRc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5761307AD4;
	Tue, 14 Oct 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411710; cv=none; b=ApGbFr4Q5q6qXU0LuGt4rcrBLtZsHl38/VxXbHloNtybYv2j56RW/HtHWtibIOWzGaPK6ZqzAK24x0/pFetdi3TtnmFk3y90kQ2BdhO1rCnUKNdQVn4FsMPi1VUrqtB1mtOVEou8aPrt7bsfjvSNXxxvIA41Zkg4Zww3RRz2dus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411710; c=relaxed/simple;
	bh=fPrn5rSywxhgIBMOoYkamAw00lrPDv+ETPbiLdOq2eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6coeQyhs7U/C1r0uP821sehNZE0LigfwY3k2E2hr+gkb0L4DMy6lgT9frOq5/xAsQBr1CUs1Mb1OvO/2VXn7bQa+3IIFdA5aWsIg4UD7weNaQCLE8NbtenifX0xjpNgUSGsfo/u/1+wGF6SzMRJfgJ81XmrzTvo8iUk2Wb9tgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpwJbPRc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411708; x=1791947708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPrn5rSywxhgIBMOoYkamAw00lrPDv+ETPbiLdOq2eU=;
  b=DpwJbPRcOSe96y+jCHle5XWHiCx3bt14k4BV46jrpEoPvwQTYkRIkM8h
   JH99+436DqBPHxQ4Bl0zZnsmH/n8gwoQQSLRsRMq1GCAdcOYlZdYfwJyp
   3qs1cSliX2PB35oKegbNCPkFrkH5TXbRhHw6lyG+GZ3xK7N5rspd9oVI9
   HlIdSmWgUmnoTNJYGVlzQGkyICj3LBMttsBbzgjk+ksfJFd4wjpRCl3FI
   BJTzZdGMacwzfIgZrHxp/2jpCXzqk28ok68GTNjOF62k93E303EDD7GYc
   YiZwe3A6ZX8Jk1m8t+Fi651vOxci4EghhlCdknhEDXdmIwbyIxZCbdYN+
   w==;
X-CSE-ConnectionGUID: T0O9xYdAQY+83D7RrqqTGQ==
X-CSE-MsgGUID: T8T7uF7aT+GnYrQGUqsc/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662065"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:05 -0700
X-CSE-ConnectionGUID: d7OU7aiLTCeCT1Zlq8JZJA==
X-CSE-MsgGUID: SHOwYc1OSESFwglFAFNG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198542"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:03 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 1/7] soundwire: cadence_master: make frame index trace more readable
Date: Tue, 14 Oct 2025 11:14:44 +0800
Message-ID: <20251014031450.3781789-2-yung-chuan.liao@linux.intel.com>
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


