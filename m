Return-Path: <linux-kernel+bounces-832707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE544BA023E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BED65E0FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC82EBBAA;
	Thu, 25 Sep 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pg23J2YQ"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE612E2667
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812644; cv=none; b=oBT3xGNU+8+/Vhe2AjW8H+kTQPLdokV78KixYak605SpMI4SikzGqAmh2zxw1a1fpBDeFHt9MLdJ9Z8EZXLCdM/hfj3nQLycFp2YcFeFfdVjPb7zmQbkwo+9d4q5bgyvheVhVLdCBfox2QlZuotVS1HLbygvOrOAb+bRBLUC7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812644; c=relaxed/simple;
	bh=iPtudmCoZ1Y2YRs+oxivEfgiwzAncbwAgskDeIoNQPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9V2b2Qtb6qR+xb0HwT2Jn6antIxW7HUrZCfhf0gg1I/LxAy515RJRXkifMLQfdptxATyrt0q0Qt3sxDSfRYmDsnzWak/cl+ehkBIerABCErZwnq1FJzTChvfynaLWb1WVfCrpgA1HIiQy2BFfUb/zuwFVMKaKVktoAGxJV56Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pg23J2YQ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758812640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmLfEMR0Vw9wPWJkVM3oKv7COMTxVJz60j3r9iGyw40=;
	b=Pg23J2YQzR/u3/d6RmJbd+JFQmaFrm1PUKwptCHKoxr9JCjx7OrMjRncrUGClJYFezae0p
	AvQbA+Eqp98MuIv8akkafKCvwmlYO3tm2ZyENDBVZx+wlys5VAMQjoKvG2IJkBMtJBc17O
	xpaHDoUn+W3H/tfbNKkXeAnfskccvjE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 1/3] coresight: Fix fwnode leak in coresight_register error path
Date: Thu, 25 Sep 2025 11:03:40 -0400
Message-Id: <20250925150342.1845615-2-sean.anderson@linux.dev>
In-Reply-To: <20250925150342.1845615-1-sean.anderson@linux.dev>
References: <20250925150342.1845615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If registering the CPU map fails, we need to put the fwnode. free_percpu
works when called with a NULL pointer, so just use
coresight_device_release.

Fixes: 5ad628a76176 ("coresight: Use per-sink trace ID maps for Perf sessions")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v4)

Changes in v4:
- New

 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fa758cc21827..022c8384b98d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1352,7 +1352,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
 		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
 		if (!csdev->perf_sink_id_map.cpu_map) {
-			kfree(csdev);
+			coresight_device_release(&csdev->dev);
 			ret = -ENOMEM;
 			goto err_out;
 		}
-- 
2.35.1.1320.gc452695387.dirty


