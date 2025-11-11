Return-Path: <linux-kernel+bounces-895026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DFC4CC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F82A3A6FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A642EDD63;
	Tue, 11 Nov 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyVYgXbf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED92EBBAF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854189; cv=none; b=QW1aaF7BW4pNbv5O4mWB/xeWkjXR+7Uj5coZ/Q4ydTIxRh7VeTPW98GsgT1sy+yDDbPkCEBTHwoH/KEzUHjCkUNaba5kw4Cl9Jp5pSB00U+AenNH85/k9E2z/oE6X4Kjf4daGoQmVHBD6IpSIVY9jFjd18/hCdnpo30+i2mF/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854189; c=relaxed/simple;
	bh=10rqRjZ8FJxa4fWhd2WsF1XaPdd1zqUWSYmMcKmDX8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qGNah3RPdvcdKWwGKfv+M3Q0W6ywNS9OfqdPAQkmbJSDoX2vbmzf10Aizu4au/9nQP8pbNHwbtmVjEmeVKoTCltX8PVZFE2ATQyySzIrACczhF8jssNojQNVZywEISn5YdElD80J58i89pUcSDf9GSvMiJQEUvLpjQCmOzCM95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyVYgXbf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762854187; x=1794390187;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=10rqRjZ8FJxa4fWhd2WsF1XaPdd1zqUWSYmMcKmDX8M=;
  b=ZyVYgXbfMeyHOVuACTM2jFcM/Let0Lx+LgygTJlqkogT9c0jmkB/MSPW
   Nc9TdB231jnlJf+BpfMMyqvd3rZSF7IIPXNYu4HHVseUtCZAa8mClMrxW
   7/7ZGTMgyx4fJCjP18ckx4XJOpNbsoQVmpp+f3Gnp+YMXb8BoLKU/uG0q
   1VeZxlrv1z5n1nYWbSbijy7QmLm1wkOWD3IV6Nhk7OZ/l1k22ihuw7yjR
   jkn/EsmqaW+/PntmeF93DW1/9awfCXfvllG8CnMpkqGKHBslZ9j1LuPsv
   JY8SozcUtLDzyncX3DJuWE0QuR9dpUxiUjNoboQr7X9Ssl+NjvEvbKgMX
   g==;
X-CSE-ConnectionGUID: To9c1ENsS2u8AKwFMpnDuA==
X-CSE-MsgGUID: XNiScXlLQJeJRR7tNi8wUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65004297"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="65004297"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:43:06 -0800
X-CSE-ConnectionGUID: bgWImfY+S+SSfaj2HO3hDA==
X-CSE-MsgGUID: ay2pvhksTkmAE5B270h0RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189352697"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:43:05 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D50EB11F983;
	Tue, 11 Nov 2025 11:43:02 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vIkty-00000000OiV-30ZQ;
	Tue, 11 Nov 2025 11:43:02 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 1/1] w1: omap-hdq: Remove redundant pm_runtime_mark_last_busy() calls
Date: Tue, 11 Nov 2025 11:43:02 +0200
Message-ID: <20251111094302.95003-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/w1/masters/omap_hdq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 69b1d145657a..d13db3396570 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -445,7 +445,6 @@ static u8 omap_w1_triplet(void *_hdq, u8 bdir)
 out:
 	mutex_unlock(&hdq_data->hdq_mutex);
 rtn:
-	pm_runtime_mark_last_busy(hdq_data->dev);
 	pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return ret;
@@ -466,7 +465,6 @@ static u8 omap_w1_reset_bus(void *_hdq)
 
 	omap_hdq_break(hdq_data);
 
-	pm_runtime_mark_last_busy(hdq_data->dev);
 	pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return 0;
@@ -490,7 +488,6 @@ static u8 omap_w1_read_byte(void *_hdq)
 	if (ret)
 		val = -1;
 
-	pm_runtime_mark_last_busy(hdq_data->dev);
 	pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return val;
@@ -525,7 +522,6 @@ static void omap_w1_write_byte(void *_hdq, u8 byte)
 	}
 
 out_err:
-	pm_runtime_mark_last_busy(hdq_data->dev);
 	pm_runtime_put_autosuspend(hdq_data->dev);
 }
 
@@ -625,7 +621,6 @@ static int omap_hdq_probe(struct platform_device *pdev)
 
 	omap_hdq_break(hdq_data);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	omap_w1_master.data = hdq_data;
-- 
2.47.3


