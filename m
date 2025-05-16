Return-Path: <linux-kernel+bounces-650611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396BFAB93BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 03:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9217F1BC6ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF2233145;
	Fri, 16 May 2025 01:40:49 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817B22A4F2
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359648; cv=none; b=e7ESDaeQtTIaXth3bn5wSMeOvRKbLgInpPLgirGq+nt4s/Swbwdf+uR28Eh46cJsaXPcJ7W6hVnqJt6uhboue/PoE7vXQm5ltHuABXKaBsJc78pnnWrIQTSTy+GwqcYkV5X7KpxHfnsnC3XmGZ6oWORIwbpgb77IuPeHKyQ9puA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359648; c=relaxed/simple;
	bh=2vnT2i1xN5daZtW7H4aFUWo3uraWJ893sxEvdprct/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlOPHj/foCGVWzSx4b+OSoQ6GWgMt5VrnTsdU7PPDK9pCDtlGcC86cTZVuuDAqw9I+UB5qPX829vTZwiNfAfWDZXt9qSdyzIab5TmLopu1Z0q/5V6woPEBiWwOmBSz4kn8vtRVrDg5296zJN31b23aVspCOuo++ntLWNBvfKSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zz8rF1hTFz1DKdX;
	Fri, 16 May 2025 09:39:09 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 70A9B180484;
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
Subject: [PATCH v4 3/4] dma-mapping: benchmark: add support for dma_map_sg
Date: Fri, 16 May 2025 09:40:33 +0800
Message-ID: <20250516014034.1577549-4-xiaqinxin@huawei.com>
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

Support for dma scatter-gather mapping and is intended for testing
mapping performance. It achieves by introducing the dma_sg_map_param
structure and related functions, which enable the implementation of
scatter-gather mapping preparation, mapping, and unmapping operations.
Additionally, the dma_map_benchmark_ops array is updated to include
operations for scatter-gather mapping. This commit aims to provide
a wider range of mapping performance test to cater to different scenarios.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h |  43 ++++++++++----
 kernel/dma/map_benchmark.c    | 103 ++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 020b3155c262..9e8ec59e027a 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -17,22 +17,41 @@
 
 enum {
 	DMA_MAP_BENCH_SINGLE_MODE,
+	DMA_MAP_BENCH_SG_MODE,
 	DMA_MAP_BENCH_MODE_MAX
 };
 
+/**
+ * struct map_benchmark - Benchmarking data for DMA mapping operations.
+ * @avg_map_100ns: Average map latency in 100ns.
+ * @map_stddev: Standard deviation of map latency.
+ * @avg_unmap_100ns: Average unmap latency in 100ns.
+ * @unmap_stddev: Standard deviation of unmap latency.
+ * @threads: Number of threads performing map/unmap operations in parallel.
+ * @seconds: Duration of the test in seconds.
+ * @node: NUMA node on which this benchmark will run.
+ * @dma_bits: DMA addressing capability.
+ * @dma_dir: DMA data direction.
+ * @dma_trans_ns: Time for DMA transmission in ns.
+ * @granule: Number of PAGE_SIZE units to map/unmap at once.
+	     In SG mode, this represents the number of scatterlist entries.
+	     In single mode, this represents the total size of the mapping.
+ * @map_mode: Mode of DMA mapping.
+ * @expansion: Reserved for future use.
+ */
 struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
+	__u64 avg_map_100ns;
+	__u64 map_stddev;
+	__u64 avg_unmap_100ns;
 	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
-	__u8  map_mode; /* the mode of dma map */
-	__u8 expansion[75];     /* For future use */
+	__u32 threads;
+	__u32 seconds;
+	__s32 node;
+	__u32 dma_bits;
+	__u32 dma_dir;
+	__u32 dma_trans_ns;
+	__u32 granule;
+	__u8  map_mode;
+	__u8 expansion[75];
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 05f85cf00c35..843be4dc0993 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
@@ -111,8 +112,110 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
 	.do_unmap = dma_single_map_benchmark_do_unmap,
 };
 
+struct dma_sg_map_param {
+	struct sg_table sgt;
+	struct device *dev;
+	void **buf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct scatterlist *sg;
+	int i;
+
+	struct dma_sg_map_param *params __free(kfree) = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return NULL;
+
+	/*
+	 * Set the number of scatterlist entries based on the granule.
+	 * In SG mode, 'granule' represents the number of scatterlist entries.
+	 * Each scatterlist entry corresponds to a single page.
+	 */
+	params->npages = map->bparam.granule;
+	params->dma_dir = map->bparam.dma_dir;
+	params->dev = map->dev;
+	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
+				    GFP_KERNEL);
+	if (!params->buf)
+		goto out;
+
+	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
+		goto free_buf;
+
+	for_each_sgtable_sg(&params->sgt, sg, i) {
+		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
+		if (!params->buf[i])
+			goto free_page;
+
+		if (params->dma_dir != DMA_FROM_DEVICE)
+			memset(params->buf[i], 0x66, PAGE_SIZE);
+
+		sg_set_buf(sg, params->buf[i], PAGE_SIZE);
+	}
+
+	return_ptr(params);
+
+free_page:
+	while (i-- > 0)
+		free_page((unsigned long)params->buf[i]);
+
+	sg_free_table(&params->sgt);
+free_buf:
+	kfree(params->buf);
+out:
+	return NULL;
+}
+
+static void dma_sg_map_benchmark_unprepare(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+	int i;
+
+	for (i = 0; i < params->npages; i++)
+		free_page((unsigned long)params->buf[i]);
+
+	sg_free_table(&params->sgt);
+
+	kfree(params->buf);
+	kfree(params);
+}
+
+static int dma_sg_map_benchmark_do_map(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+	int ret = 0;
+
+	int sg_mapped = dma_map_sg(params->dev, params->sgt.sgl,
+				   params->npages, params->dma_dir);
+	if (!sg_mapped) {
+		pr_err("dma_map_sg failed on %s\n", dev_name(params->dev));
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static void dma_sg_map_benchmark_do_unmap(void *mparam)
+{
+	struct dma_sg_map_param *params = mparam;
+
+	dma_unmap_sg(params->dev, params->sgt.sgl, params->npages,
+		     params->dma_dir);
+}
+
+static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
+	.prepare = dma_sg_map_benchmark_prepare,
+	.unprepare = dma_sg_map_benchmark_unprepare,
+	.do_map = dma_sg_map_benchmark_do_map,
+	.do_unmap = dma_sg_map_benchmark_do_unmap,
+};
+
 static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
 	[DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+	[DMA_MAP_BENCH_SG_MODE] = &dma_sg_map_benchmark_ops,
 };
 
 static int map_benchmark_thread(void *data)
-- 
2.33.0


