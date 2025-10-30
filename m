Return-Path: <linux-kernel+bounces-877653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860EC1EAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A13A6F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE42334C24;
	Thu, 30 Oct 2025 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dtm81jK+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954833508F;
	Thu, 30 Oct 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807826; cv=none; b=B47K528xPBrIL9hOSTiuP954X0zaKkOCMrpwsvEdnsiUMCoVztr2m7tpNy1WsKqihwLbBgBR4NVw/irpxaISKf1H+DWbfRcHCJ5KbI7mM+J2KtbVdJfpOnTUkFFwpksgxtKylnrWT7fAzZWbrJDQ+IJ3Or4//xUopVZB8or/obM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807826; c=relaxed/simple;
	bh=PPSvyxYNGECSmWuUNiSzRgy7V8JVaZlBRY2HYixRPPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOJah0QzesGS4t0phaSujo6R1+CJRRVMywNU450VWqQGhGTHTfZI8JRJXE1wjtQ1ck0BIQmiHAJ8AN9VqQZht5XPw04VJ97UmBwcduGpZrEbTZTwkZ0qd2KrzrgI6tFkJjZdoEQ4eW4zC4rpjO9wSjXJsuVelaTpWQrm3xdeK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dtm81jK+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807826; x=1793343826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPSvyxYNGECSmWuUNiSzRgy7V8JVaZlBRY2HYixRPPE=;
  b=Dtm81jK+BwwttXkmOgcf1bWkUjm8wkScIA0EDIEic00C6EmTLmF0WlnZ
   zGDcfdikY4+GxDIcSBboPXBbd8nCalj7ROqFw7iZh4hMwiHBIec03/ggv
   +H2HZhWYmNpZ9BTe9uG95026cAx+4lifPfkiWYv6RPfQgDcaYtt+vdkGd
   CPXb4bO7aseLk3yiBrgGynhwLMFqlH/tmcr7UgPFoblfIiu/ybbvfk7+8
   31L+d+sN9dFSiDyh9cYr2hXCdgoYbiy0Oo1PjoYoSIt54S5jHcZBLukTb
   70nM0Vqip1Uusuih8/OZ0R00TarjQmBZbUoU2H/El1WMgAL8JPIDT57At
   w==;
X-CSE-ConnectionGUID: cY/bo//jRYKst5VS8cB9Ig==
X-CSE-MsgGUID: fj70Ml2jStC51gHxER9iuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359520"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:45 -0700
X-CSE-ConnectionGUID: DPFO5W/oRUW0iw7bnqGpnw==
X-CSE-MsgGUID: BoNrOX7qSRO/TdhwDG/DUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621371"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 2/7] soundwire: only compute BPT stream in sdw_compute_dp0_port_params
Date: Thu, 30 Oct 2025 15:02:48 +0800
Message-ID: <20251030070253.1216871-3-yung-chuan.liao@linux.intel.com>
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


