Return-Path: <linux-kernel+bounces-686940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B32AD9D85
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEDA1899A76
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A32DFA24;
	Sat, 14 Jun 2025 14:35:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F11FC8
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911709; cv=none; b=cius5K8cdXrDN4pLI+Kt2AFYOvN4CUKA98U+q1ttRiDHEWGtMKPZ5MvuPBCUHkcPekgxtPY5uGr+inIjZu0uNElgLA3HczUdt/f4rK2+ZMldmbuXKFmxeeRfG8T3H4OxlIDGONI93COOj32F0FZQntvBoEIz1rofdkk5YPZgDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911709; c=relaxed/simple;
	bh=LviThTNa7WFSySQCtkVWg9h/yH8uPysYxenL5Gkm01I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTL8dQ8eBjHadWRfM3gFcPN9dzOjoFVpUk6N19uIbC87MhkmiSPfyzR0m6208HcC32BdYelLf4pHHu0a8rBN3jDN7H+bQmYxK+9a/5hosNmwFvjCAb7JR2T/Ggv5Vb69FRAs9QCVDSqP85WXEhKFvlMroIkjmKvbBNXdT90uTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bKJbG0RyKzRk30;
	Sat, 14 Jun 2025 22:30:50 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B15CB1800B1;
	Sat, 14 Jun 2025 22:35:04 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Jun 2025 22:35:04 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <xiaqinxin@huawei.com>
Subject: [RESEND PATCH v4 1/4] dma-mapping: benchmark: Add padding to ensure uABI remained consistent
Date: Sat, 14 Jun 2025 22:34:51 +0800
Message-ID: <20250614143454.2927363-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250614143454.2927363-1-xiaqinxin@huawei.com>
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)

The padding field in the structure was previously reserved to
maintain a stable interface for potential new fields, ensuring
compatibility with user-space shared data structures.
However,it was accidentally removed by tiantao in a prior commit,
which may lead to incompatibility between user space and the kernel.

This patch reinstates the padding to restore the original structure
layout and preserve compatibility.

Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
Cc: stable@vger.kernel.org
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..2ac2fe52f248 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -27,5 +27,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76];     /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
-- 
2.33.0


