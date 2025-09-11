Return-Path: <linux-kernel+bounces-812075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD2B532A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35B77BB595
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50046322A05;
	Thu, 11 Sep 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xn8Tawu/"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474A32276F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594720; cv=none; b=H+H7AriQG3nGQsF3MNTiWl+hEuXoChpuP/2FwDUjKVI/J1UGoKYjuCmf/XIKjGJxrJ7R9qg2SxesVsMrr8YvtWeitHVm1XrOTcJ14ei3vT9BVRQW+BxsGGY6dErzhLIySFghCeWTtwlJKo2lhLKan8r2KQxm1DYWTUxCaWJXj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594720; c=relaxed/simple;
	bh=kohYFVXIspoaPKJua62Rblg42hVWuEWH4mMzi3ehyc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKLHsZ7Cu/CYSlcb8BQkdEon9ki0jeudf6N3aHBaCsJ5j91d3FjznrfLcsMp6w0ZIgt43Uv43iGdPEvczZBp7vniLy62ntTqPq4vFEllgE+VBp50EGUGl9+lrdxQY1tPQ7PBlW4WeF4FSxpSrjisPVyhpF6nciT7Mhw7xq7wO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xn8Tawu/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757594714; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=klrJ7g5FLgpuRyahGw6eB5ihL1iuaDQ6Jxw1/EVd0js=;
	b=Xn8Tawu/lSHe5b+OTSAts4Qr+ckhRNC9D/ewvfXDSE1q5MCBFTc2NJ6ESgZahBeI/qDYK9Jf2esy6Q3ifVNszXXBpsMTjZpUQs8/dcOplB7cUm98mdp2kP1F3zGKYLQ0VmwZbRdoiidYWsW0CpnbARpcYZid51UYYyMcWOU1gYs=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnmLJjq_1757594712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:45:13 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [RFC PATCH 4/4] riscv: trace: Support sink using dma buffer
Date: Thu, 11 Sep 2025 20:44:48 +0800
Message-ID: <20250911124448.1771-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

In common SoC systems, the trace data by the sink is usually
written to the memory, and the memory needs to be a large block.

We have two methods to achieve this. One is based on reserved
memory. This method requires pre-isolation of memory and is not
flexible enough. Therefore, we chose the second method, which is
based on IOMMU to map non-contiguous memory to continuous. When
implementing the driver, only the DMA alloc related APIs are needed.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/events/riscv_trace.c | 49 ++++++++++++++++++++++++++++++++-
 arch/riscv/events/riscv_trace.h |  4 ++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/events/riscv_trace.c b/arch/riscv/events/riscv_trace.c
index 3ac4a3be5d3e..e8deaefa0180 100644
--- a/arch/riscv/events/riscv_trace.c
+++ b/arch/riscv/events/riscv_trace.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/perf_event.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
 
 #include "riscv_trace.h"
 
@@ -55,6 +56,44 @@ static void riscv_trace_init_filter_attrs(struct perf_event *event)
 		riscv_trace_pmu.filter_attr.priv_mode);
 }
 
+static int riscv_trace_sink_dma_alloc(unsigned long size)
+{
+	struct riscv_trace_component *component;
+	dma_addr_t dma_addr;
+
+	list_for_each_entry(component, &riscv_trace_controllers, list) {
+		if (component->type == RISCV_TRACE_SINK) {
+			component->sink.vaddr =
+			    dma_alloc_coherent(riscv_trace_pmu.pmu.dev, size,
+					       &dma_addr, GFP_KERNEL);
+			if (component->sink.vaddr) {
+				component->sink.start_addr = dma_addr;
+				component->sink.limit_addr = dma_addr + size;
+				continue;
+			} else {
+				pr_err("dma_alloc_coherent failed\n");
+				return -ENOMEM;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void riscv_trace_sink_dma_free(void)
+{
+	struct riscv_trace_component *component;
+
+	list_for_each_entry(component, &riscv_trace_controllers, list) {
+		if (component->type == RISCV_TRACE_SINK) {
+			if (component->sink.vaddr)
+				dma_free_coherent(riscv_trace_pmu.pmu.dev,
+					component->sink.limit_addr - component->sink.start_addr,
+					component->sink.vaddr, component->sink.start_addr);
+		}
+	}
+}
+
 static int riscv_trace_event_init(struct perf_event *event)
 {
 	if (event->attr.type != riscv_trace_pmu.pmu.type)
@@ -105,7 +144,7 @@ static void *riscv_trace_buffer_setup_aux(struct perf_event *event, void **pages
 {
 	struct riscv_trace_aux_buf *buf;
 	struct page **pagelist;
-	int i;
+	int i, ret;
 
 	if (overwrite) {
 		pr_warn("Overwrite mode is not supported\n");
@@ -135,6 +174,12 @@ static void *riscv_trace_buffer_setup_aux(struct perf_event *event, void **pages
 
 	pr_info("nr_pages=%d length=%d\n", buf->nr_pages, buf->length);
 
+	ret = riscv_trace_sink_dma_alloc(buf->length);
+	if (ret) {
+		kfree(pagelist);
+		goto err;
+	}
+
 	kfree(pagelist);
 	return buf;
 err:
@@ -148,6 +193,8 @@ static void riscv_trace_buffer_free_aux(void *aux)
 
 	vunmap(buf->base);
 	kfree(buf);
+
+	riscv_trace_sink_dma_free();
 }
 
 static int __init riscv_trace_init(void)
diff --git a/arch/riscv/events/riscv_trace.h b/arch/riscv/events/riscv_trace.h
index c28216227006..7819fbeace1f 100644
--- a/arch/riscv/events/riscv_trace.h
+++ b/arch/riscv/events/riscv_trace.h
@@ -49,7 +49,9 @@ struct riscv_trace_funnel {
 };
 
 struct riscv_trace_sink {
-	;
+	u64 start_addr;
+	u64 limit_addr;
+	void __iomem *vaddr;
 };
 
 struct riscv_trace_component {
-- 
2.49.0


