Return-Path: <linux-kernel+bounces-613572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C236CA95E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09916165612
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B543238C1D;
	Tue, 22 Apr 2025 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="ZgVX89uR"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079D22A7E9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303859; cv=none; b=eP2onUQUu5ajI2UI264UF+WuYV4XSWRINAaT+WMJj+UVBKzZrmUfh59Pc0dTJVY829i4iSoxzTAiymAEiiOgMaa4RWAV6VKrUwCwLo02lthw1/Bm7cx+2hDCWLQpd5+agcxJ53HrNxD800Lz8q37valffPiw3G68pFEBKpnRCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303859; c=relaxed/simple;
	bh=UcdEpiXFzC8AsBaOTOkXbBE+EOhb8L2+7Sb0WBfailQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAc5WSaUfSz2QGHrWJGqgX/GMuc47fDYXAL9IIrRNJzP1yIVXZFHer256K/eRKFhhkuqdPI0YL5scMSH9AyjnTXhzJyWMe+59FYKPzRzV34Ny9CbKBYviFRD65en3sL+bRfSwrwYVbw9JO7LOJKFu49hIsAbClIIi3vWpDlO1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=ZgVX89uR; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202504220637321dc83df70c507acd5f
        for <linux-kernel@vger.kernel.org>;
        Tue, 22 Apr 2025 08:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nt46wyX3vInf9nEJO3STUSubJKhNa7Mq0IAjgmyGm+I=;
 b=ZgVX89uRFaDVpnmoy6wTuTQjf50vAVEIjLhyw/3KF8CrzYvi8YKNa+jlj7HQ0p7LZT7QGR
 mwrkrTqyaAYHZ0xkw5oJcnaHS8O0s4+KpmjRrkRXCArzVUWAV7MIlVHMiW5/wm6xQFLAQvDx
 Yq46x7FUqamcQGXztfPQsNZsxo8WK14Kc+3DOmo8jN5JRdrtU+S2a4uitIICx2ufyufiB6dT
 ZsN07ne7sKAt9MblrA8UF/QKiVqD80MHpCIhvKqp1CXeHrn1G8pl5J92SQuSDRs8Th9dY2IT
 KbwsGRy272d2BgrcwHyIt7msyTcaKP3boJBDawQvvI9CmKQbPh/Kcd5Q==;
From: huaqian.li@siemens.com
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: baocheng.su@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] swiotlb: Make IO_TLB_SEGSIZE configurable
Date: Tue, 22 Apr 2025 14:37:19 +0800
Message-Id: <20250422063719.121636-2-huaqian.li@siemens.com>
In-Reply-To: <20250422063719.121636-1-huaqian.li@siemens.com>
References: <20250422063719.121636-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

In some applications, the default value of 128 is not sufficient for
memory allocation and can cause runtime errors. This change makes
IO_TLB_SEGSIZE configurable, allowing it to be increased if needed.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 include/linux/swiotlb.h | 2 +-
 kernel/dma/Kconfig      | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..145c71f8329d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -23,7 +23,7 @@ struct scatterlist;
  * must be a power of 2.  What is the appropriate value ?
  * The complexity of {map,unmap}_single is linearly dependent on this value.
  */
-#define IO_TLB_SEGSIZE	128
+#define IO_TLB_SEGSIZE CONFIG_SWIOTLB_SEGSIZE
 
 /*
  * log of the size of each IO TLB slab.  The number of slabs is command line
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 31cfdb6b4bc3..38bfa84b96b6 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -102,6 +102,13 @@ config SWIOTLB_DYNAMIC
 
 	  If unsure, say N.
 
+config SWIOTLB_SEGSIZE
+	int "SWIOTLB segment size"
+	default 128
+	help
+	  Set the maximum allowable number of contiguous slabs to map.
+	  Must be a power of 2.
+
 config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
-- 
2.34.1


