Return-Path: <linux-kernel+bounces-650608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BCAB93BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 03:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BFC3A84D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A622D4DD;
	Fri, 16 May 2025 01:40:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804121ABB4
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359647; cv=none; b=u8y2xWZzuzzbAWaDZGlAb8opp8n0kVutWD89gAzxlYFUx6Q/zLD3N5o4YW0Fk8CGJDkoIaVVmdWbTIbUl4J6joaueFbqkuAlECntTE5R3MXe+DlBODvTQ890q4dn6+6X6l/li0rdbEYP62EvrIR/aFTpqjD+tNT177xXi+Z/hP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359647; c=relaxed/simple;
	bh=DmYPolF3D2IG3Iz9Q5jhq3/pStdUj+Lyi/uPJ4380H8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCxwww3eYefkIeoSc0OsvPCX0+t5gU7QKDhPm+nLHXsRTZ+wLdmvvzq67Pt8rvWJr0giazTTxEdVRk/GL8gV1S7sG9n2iMSrei8ewVhiC94E8SQXvYGc6nNLbK1RIbaJY5DWQqncfgx+aJEyf38N/bXbE1HvgWBy8KMuZtGBcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zz8rD5kQXz1DKdV;
	Fri, 16 May 2025 09:39:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 0354C1402ED;
	Fri, 16 May 2025 09:40:37 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 09:40:36 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 2/4] dma-mapping: benchmark: modify the framework to adapt to more map modes
Date: Fri, 16 May 2025 09:40:32 +0800
Message-ID: <20250516014034.1577549-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250516014034.1577549-1-xiaqinxin@huawei.com>
References: <20250516014034.1577549-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemj200003.china.huawei.com (7.202.194.15)

In some service scenarios, the performance of dma_map_sg needs to be
tested to support different map modes for benchmarks. This patch adjusts
the DMA map benchmark framework to make the DMA map benchmark framework
more flexible and adaptable to other mapping modes in the future.
By abstracting the framework into four interfaces:prepare, unprepare,
do_map, and do_unmap.The new map schema can be introduced more easily
without major modifications to the existing code structure.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h |   8 ++-
 kernel/dma/map_benchmark.c    | 122 +++++++++++++++++++++++++++-------
 2 files changed, 106 insertions(+), 24 deletions(-)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 2ac2fe52f248..020b3155c262 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -15,6 +15,11 @@
 #define DMA_MAP_TO_DEVICE       1
 #define DMA_MAP_FROM_DEVICE     2
 
+enum {
+	DMA_MAP_BENCH_SINGLE_MODE,
+	DMA_MAP_BENCH_MODE_MAX
+};
+
 struct map_benchmark {
 	__u64 avg_map_100ns; /* average map latency in 100ns */
 	__u64 map_stddev; /* standard deviation of map latency */
@@ -27,6 +32,7 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76];     /* For future use */
+	__u8  map_mode; /* the mode of dma map */
+	__u8 expansion[75];     /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index cc19a3efea89..05f85cf00c35 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -31,17 +32,99 @@ struct map_benchmark_data {
 	atomic64_t loops;
 };
 
+struct map_benchmark_ops {
+	void *(*prepare)(struct map_benchmark_data *map);
+	void (*unprepare)(void *mparam);
+	int (*do_map)(void *mparam);
+	void (*do_unmap)(void *mparam);
+};
+
+struct dma_single_map_param {
+	struct device *dev;
+	dma_addr_t addr;
+	void *xbuf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_single_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct dma_single_map_param *params __free(kfree) = kzalloc(sizeof(*params),
+								    GFP_KERNEL);
+	if (!params)
+		return NULL;
+
+	params->npages = map->bparam.granule;
+	params->dma_dir = map->bparam.dma_dir;
+	params->dev = map->dev;
+	params->xbuf = alloc_pages_exact(params->npages * PAGE_SIZE, GFP_KERNEL);
+	if (!params->xbuf)
+		return NULL;
+
+	/*
+	 * for a non-coherent device, if we don't stain them in the
+	 * cache, this will give an underestimate of the real-world
+	 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
+	 * 66 means evertything goes well! 66 is lucky.
+	 */
+	if (params->dma_dir != DMA_FROM_DEVICE)
+		memset(params->xbuf, 0x66, params->npages * PAGE_SIZE);
+
+	return_ptr(params);
+}
+
+static void dma_single_map_benchmark_unprepare(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	free_pages_exact(params->xbuf, params->npages * PAGE_SIZE);
+	kfree(params);
+}
+
+static int dma_single_map_benchmark_do_map(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+	int ret = 0;
+
+	params->addr = dma_map_single(params->dev, params->xbuf,
+				      params->npages * PAGE_SIZE, params->dma_dir);
+	if (unlikely(dma_mapping_error(params->dev, params->addr))) {
+		pr_err("dma_map_single failed on %s\n", dev_name(params->dev));
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static void dma_single_map_benchmark_do_unmap(void *mparam)
+{
+	struct dma_single_map_param *params = mparam;
+
+	dma_unmap_single(params->dev, params->addr,
+			 params->npages * PAGE_SIZE, params->dma_dir);
+}
+
+static struct map_benchmark_ops dma_single_map_benchmark_ops = {
+	.prepare = dma_single_map_benchmark_prepare,
+	.unprepare = dma_single_map_benchmark_unprepare,
+	.do_map = dma_single_map_benchmark_do_map,
+	.do_unmap = dma_single_map_benchmark_do_unmap,
+};
+
+static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
+	[DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+};
+
 static int map_benchmark_thread(void *data)
 {
-	void *buf;
-	dma_addr_t dma_addr;
 	struct map_benchmark_data *map = data;
-	int npages = map->bparam.granule;
-	u64 size = npages * PAGE_SIZE;
+	__u8 map_mode = map->bparam.map_mode;
 	int ret = 0;
 
-	buf = alloc_pages_exact(size, GFP_KERNEL);
-	if (!buf)
+	struct map_benchmark_ops *mb_ops = dma_map_benchmark_ops[map_mode];
+	void *mparam = mb_ops->prepare(map);
+
+	if (!mparam)
 		return -ENOMEM;
 
 	while (!kthread_should_stop())  {
@@ -49,23 +132,10 @@ static int map_benchmark_thread(void *data)
 		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
 		ktime_t map_delta, unmap_delta;
 
-		/*
-		 * for a non-coherent device, if we don't stain them in the
-		 * cache, this will give an underestimate of the real-world
-		 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
-		 * 66 means evertything goes well! 66 is lucky.
-		 */
-		if (map->dir != DMA_FROM_DEVICE)
-			memset(buf, 0x66, size);
-
 		map_stime = ktime_get();
-		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
-		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
-			pr_err("dma_map_single failed on %s\n",
-				dev_name(map->dev));
-			ret = -ENOMEM;
+		ret = mb_ops->do_map(mparam);
+		if (ret)
 			goto out;
-		}
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
@@ -73,7 +143,8 @@ static int map_benchmark_thread(void *data)
 		ndelay(map->bparam.dma_trans_ns);
 
 		unmap_stime = ktime_get();
-		dma_unmap_single(map->dev, dma_addr, size, map->dir);
+		mb_ops->do_unmap(mparam);
+
 		unmap_etime = ktime_get();
 		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
 
@@ -108,7 +179,7 @@ static int map_benchmark_thread(void *data)
 	}
 
 out:
-	free_pages_exact(buf, size);
+	mb_ops->unprepare(mparam);
 	return ret;
 }
 
@@ -209,6 +280,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
+		if (map->bparam.map_mode >= DMA_MAP_BENCH_MODE_MAX) {
+			pr_err("invalid map mode\n");
+			return -EINVAL;
+		}
+
 		if (map->bparam.threads == 0 ||
 		    map->bparam.threads > DMA_MAP_MAX_THREADS) {
 			pr_err("invalid thread number\n");
-- 
2.33.0


