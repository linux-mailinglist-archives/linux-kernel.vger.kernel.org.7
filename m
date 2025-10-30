Return-Path: <linux-kernel+bounces-877654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D61C1EAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E178B189886C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0C3358DE;
	Thu, 30 Oct 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilRyRZJl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5C3358BD;
	Thu, 30 Oct 2025 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807828; cv=none; b=LHpVYfFrdY7npIBOYKEVmj/jGdlmGXbiXyQYICBZ6rNOtYqEtQylwVS+R1K0E2QKkauQ6b5EcJPmiZ07bqk5udPQVAV+lnNDAtyoNs2Nr/GFdsefoyKcXphwUJc1g43RRN2+NdeY5l5fW7A2iqsY7y7QPdwT+Vpc2FdfsXqnyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807828; c=relaxed/simple;
	bh=QMApVb7vwwvBCryw7oaYh9kuIeLOvRukrcN3SkjHiCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDn7jdKizppAFALcLvueb3k9rCg9s8GG5enTWF3CWOiR3qmFIKYnjXoFSsWCqWmxaZ12gMBjX4x+d192i/FaqkVTELlQB73LpUjMgB+WMpED8O1droRUTno/P2FQurg62B2nAiwQDABvlf5XjnS1JETNtJlglo7FORqQeUnsgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilRyRZJl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807828; x=1793343828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMApVb7vwwvBCryw7oaYh9kuIeLOvRukrcN3SkjHiCw=;
  b=ilRyRZJllU8i6vNm6th9Xi6ZLrldVebOTjtlnT3yo/eFEGfkjlSB/gWh
   iwycb3kz7oJ13M8budBXbxOVT2BNHKoLUepuSpSNYyNivmbU0BIViyOj+
   Ld1BbGpkcAWIpUELaqa6UffHn/cBPLJMnvGFWrWxaKDJre8yj17tOCep3
   3rHtLsdM+X06IulHoH74OM3J3xo4bfv2qua8liGZ4JSZWyFRx/yuwtlST
   LyjA9eP0TKTNlDohw2t26qPuzeX3/7qyKxihynbmlTZR77wWPhRAYxVoZ
   18YjiJqdi1C0oHXT3yE7DJOanVvYvm7wEV60RsjH/lBD2iM5R3ohKTYSq
   w==;
X-CSE-ConnectionGUID: CC92KasBRzKlNgEr4Astkw==
X-CSE-MsgGUID: q5pNviYVRx+r9v8abbXkLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359523"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359523"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:48 -0700
X-CSE-ConnectionGUID: 0Nb65DsBRIusOfpvZhi2Fw==
X-CSE-MsgGUID: VD01LurZT8CKgOuasKyD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621387"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:45 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 3/7] soundwire: cadence_master: set data_per_frame as frame capability
Date: Thu, 30 Oct 2025 15:02:49 +0800
Message-ID: <20251030070253.1216871-4-yung-chuan.liao@linux.intel.com>
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


