Return-Path: <linux-kernel+bounces-851739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C5BD729A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4599E19A0C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC83093A6;
	Tue, 14 Oct 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWBiAdpf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A390303A33;
	Tue, 14 Oct 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411709; cv=none; b=ntmbjayVHMQc2Ofpc4TKB47AmvXT0uOX7a91kw3YVMubdDqdPeABeum7RgGyRwN/xGs0oP8QxxlS7T+DGD+uNSTCqBvEU0w09z3pglX+8pKtG/4oAa8Ca8Ua1BoDJ7GkRWp0EnqIQcgXQudicMs0QkJ4T41CfUNeP2hcPRpitFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411709; c=relaxed/simple;
	bh=PPSvyxYNGECSmWuUNiSzRgy7V8JVaZlBRY2HYixRPPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHhasGO2ZAes+MfhqaF/dIR/txnSGjsW1dgDtrWT2CLoQtgB33MrH4G867uBoDwj1biJdwvjvHeBx/RHvVjkd3VFNS1/x8ul5jpmPSkt9Egy8UlMKDlfM09qoitDTZNIT7QFtaD1MegYy9yh5vofH+XWC9/ejUOz2ENcmsa6KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWBiAdpf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411707; x=1791947707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPSvyxYNGECSmWuUNiSzRgy7V8JVaZlBRY2HYixRPPE=;
  b=iWBiAdpfoVP53OTng0icKgBgf0VcrjUlgsOf20g9T4W8/8VRUcY+YgYl
   rqfBBb0Nwaxyls+ithym98V4PghuOFRoXze3mDPCRA6aee4xYtv/OW7w1
   WweyXYTHNFZIBF03/AiD8678hskmoh2fTAbrJjvicpe5gM78EpbWP2yvS
   3eCGoRrqcHUz1Mp4ijqrwu5ussDpSk8ANHUZHs/WvA+cya0BAr4nzLrRv
   22pRSU/Rp9CV4dfbE+Zgtqx+b3dhCbzpVNQ0yBSKQfIYColWwyAKAmPmq
   zGnB1005SvFYQhiiypQZMF92jMyYLkejA+9j3QMZikTZj1MgLKdgz6OQf
   g==;
X-CSE-ConnectionGUID: YW7+WajgSAKVKZxUo2essw==
X-CSE-MsgGUID: XmabuKnOSD2IV01TAchKoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662070"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:06 -0700
X-CSE-ConnectionGUID: BNWxzroNTMq4ZduWPzAu0A==
X-CSE-MsgGUID: oe0MB1VFTNa2Z+A1achI7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198549"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 2/7] soundwire: only compute BPT stream in sdw_compute_dp0_port_params
Date: Tue, 14 Oct 2025 11:14:45 +0800
Message-ID: <20251014031450.3781789-3-yung-chuan.liao@linux.intel.com>
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

DP0 is only for BPT stream. We should not compute and update the port
params of the normal audio streams.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index c18f0c16f929..530ac66ac6fa 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -124,6 +124,9 @@ static void sdw_compute_dp0_port_params(struct sdw_bus *bus)
 	struct sdw_master_runtime *m_rt;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		/* DP0 is for BPT only */
+		if (m_rt->stream->type != SDW_STREAM_BPT)
+			continue;
 		sdw_compute_dp0_master_ports(m_rt);
 		sdw_compute_dp0_slave_ports(m_rt);
 	}
-- 
2.43.0


