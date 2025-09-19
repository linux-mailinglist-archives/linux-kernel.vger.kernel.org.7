Return-Path: <linux-kernel+bounces-824934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07525B8A805
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845581C21177
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AA31E88A;
	Fri, 19 Sep 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aDtWBw75"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432623C4F3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298035; cv=none; b=p8vWvBJZwCMrKsYL/f0EbL/yr0GBGNQpWHJ8A+W84XLnrFYfaP52wufwmk1LzPzfsiAJJ7BAkgrcUbcQVRk9haVendehEEM8JHeldPoUdN3d6ItCXL/8oXsdsMg8Vv/NOBXGUjAmF60rvTNSS1Ig77t2wb9BUz8YkI2x2Ka5Y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298035; c=relaxed/simple;
	bh=Zkf4labI49fgjP/HEegGogYjo29jkFb/3BULoc5Bqnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxH7FjfUq98Rrou/7bUWsBoSQpX1PWkZpRhU/PArEEetiLiY4tppp6h6sVFhyIyiyQLXmK9OWkpBuKtDCA6uvbS/nSidwjqhpRDfZ/AJgHCtqxkzZ5uXvS4x93JwciTLdMcQkCl6z8KlFzCIXRzUYLongetj/qt4kdU6WAc+mQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aDtWBw75; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758298030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pewuq/6rdA5KtkL6k1lLoSccaVHqQNLVmKiQfNeqa94=;
	b=aDtWBw75kNoVs/Ue2TDQfvKyZcBBG3whUZfr+yqPzDQCmPzrj5IvEFQVe0ou0GzzB44Zks
	bNK33hSuM7rQN7UzNVYZMiR5wOB3jEH/pJjSZhIgYHoXPXunihQvwzdYJarGaOuTbUGfUg
	DrS98w2Q4L79AInszSTzPqHtrtD9PVg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 1/2] coresight: Fix fwnode leak in coresight_register error path
Date: Fri, 19 Sep 2025 12:06:52 -0400
Message-Id: <20250919160653.507109-2-sean.anderson@linux.dev>
In-Reply-To: <20250919160653.507109-1-sean.anderson@linux.dev>
References: <20250919160653.507109-1-sean.anderson@linux.dev>
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


