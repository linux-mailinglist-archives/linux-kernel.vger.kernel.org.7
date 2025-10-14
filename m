Return-Path: <linux-kernel+bounces-851741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0BBD72A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC71219A0C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15730AACB;
	Tue, 14 Oct 2025 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GE7lunKF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC23093D2;
	Tue, 14 Oct 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411712; cv=none; b=K+2dWsza4C3LL8LPqRWlPphJyPEassUJf4YFyG69BDizLv160laCIVOlae5puIY+VeNX9RM+aYaxO0ZmZ2W40PrW1JrAgMXMIFZGSwnTqRpiPBIPBbGn8exYFVqnMH7MNOA+SKf2+IqjxNLV7TK2oNSdNgj+sR0bDpHvTpf1yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411712; c=relaxed/simple;
	bh=QMApVb7vwwvBCryw7oaYh9kuIeLOvRukrcN3SkjHiCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY8G+as3cU5K0ujKnLnuA2gnUmFSvPEo7Un5zb0N9M7XCH795tOvfCk/7ZHA+KHDSrbzElbsJByInUfFXG6zq7Iaryh+unFVjitn5a34/q7SkBK/RPY8uSPDXyo38NgRrET7EbAcdsShVdOCdwyTwZ317ZzEfFqBOQg2480oG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GE7lunKF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411710; x=1791947710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMApVb7vwwvBCryw7oaYh9kuIeLOvRukrcN3SkjHiCw=;
  b=GE7lunKFTamYMml7xm7uO1Pz0/JpNPqJLZZLpr/SctxBquScMamSFM+S
   zFLR9TWfGkSqeSwoVuoWLtdeqGdYUfiPiNgmuySTlpLYYmHVB/BGTdCf6
   jpxVyJ2v5cdkuhFd+X84W3cT958LytadYrAporfTig1fP5+pzUfyOtqS2
   dOE5ZD6F98B3LJFv8rQiCEii1vHEU+k/yWbfosg0jMUHoUUSaLVeX+OiE
   uXDugENwhXD+8zVZi0fwB+zc77VArQm6P3LxXNLIKQRaPGFMDTR5YRrGJ
   +fWlZPMRy+WNmg0/4XfUuerjWmsnQNKGb4RnCu3+W/uL1ozEx/lNu7qL5
   Q==;
X-CSE-ConnectionGUID: FCzyZQT+TCO+K96hgNspGA==
X-CSE-MsgGUID: NMuLKMiQQiG8ogtuPaDq9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662076"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662076"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:08 -0700
X-CSE-ConnectionGUID: FyBSfeamQjeLbSHrL5UZww==
X-CSE-MsgGUID: qly7j5GuQa+BEipwpHV4aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198556"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:07 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: cadence_master: set data_per_frame as frame capability
Date: Tue, 14 Oct 2025 11:14:46 +0800
Message-ID: <20251014031450.3781789-4-yung-chuan.liao@linux.intel.com>
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

data_per_frame will be used for preparing the TX buffer and we may add
some fake frames to ensure the data in the buffer will be flushed.
So that it should indicate the frame capability even if the required
data bytes are less than the frame capability.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index c59a98b408b3..178341410909 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -2114,9 +2114,6 @@ int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
 	if (!actual_bpt_bytes)
 		return -EINVAL;
 
-	if (data_bytes < actual_bpt_bytes)
-		actual_bpt_bytes = data_bytes;
-
 	/*
 	 * the caller may want to set the number of bytes per frame,
 	 * allow when possible
@@ -2126,6 +2123,9 @@ int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
 
 	*data_per_frame = actual_bpt_bytes;
 
+	if (data_bytes < actual_bpt_bytes)
+		actual_bpt_bytes = data_bytes;
+
 	if (command == 0) {
 		/*
 		 * for writes we need to send all the data_bytes per frame,
-- 
2.43.0


