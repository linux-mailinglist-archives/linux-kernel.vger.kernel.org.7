Return-Path: <linux-kernel+bounces-610326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C5A93387
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 09:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BF4188EFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7C26E173;
	Fri, 18 Apr 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="ew0/N7SV"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F326A0AB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744961522; cv=none; b=KLx57O6MoLHoSmrjp5fiiCFgDQ+w13g0QY7bRU6eYZX/u7+iMKuMO9rGTem3MI/4X4qThSexyxEdklwCsr65UVkC4K7t/5jkiHDfKaERIX0yb1RpwG8GrlWLMB4siSNL5IU7J/KjZeQO+P7DE2zfLcj5hLObhtxyUr1eAyN5ssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744961522; c=relaxed/simple;
	bh=UcdEpiXFzC8AsBaOTOkXbBE+EOhb8L2+7Sb0WBfailQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGdMiooNhIA3Srqg7qBOyH5jzRvaVspZ9ldLj2KOGCZmtU7oVDPAugwIp8SeV6Kvj6udABmsZS2yOv0KGWZR+ofCP92ZuDQLBuq9gW9bq/e3sAHzVy1vLFHCv/i/t/HpdyunWP7xb9zrQ7j3fuea1n35zjTh39mNppO3qPgT0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=ew0/N7SV; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250418073158816ebb358a89d088e2
        for <linux-kernel@vger.kernel.org>;
        Fri, 18 Apr 2025 09:31:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nt46wyX3vInf9nEJO3STUSubJKhNa7Mq0IAjgmyGm+I=;
 b=ew0/N7SV8ocpPGEhZTz/xQ+DyeZbuMX14POxCPjdsGVFWNSMS5S1mPfkMH7o7gJKLlwyY/
 pCvAEvD3KsHwOU59DVCIcMKh169q3voszK33WG4F50eYslAn71Ysc+19mNiaTuYCLlHgaeNT
 1JF3popdz30s9xnL7PFitb8uNE3CUTgUBY9DOa9pX0eSzAa3jZpbaqDfPJUdiwUzedHiqz2U
 a5RdyNEKx/yvTrDixV27oUAiLeXHaMxOxg+KMqW55TVYD4A8jNV8nu5FuJug6KIPfH86NzUI
 xVBSPIHs2Xj34+25AhFfWpvYf21V4Kue+T/64+g/fCusrFI+EvBvOWMg==;
From: huaqian.li@siemens.com
To: helgaas@kernel.org,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	ssantosh@kernel.org,
	vigneshr@ti.com,
	iommu@lists.linux.dev
Subject: [PATCH v7 8/8] swiotlb: Make IO_TLB_SEGSIZE configurable
Date: Fri, 18 Apr 2025 15:30:26 +0800
Message-Id: <20250418073026.2418728-9-huaqian.li@siemens.com>
In-Reply-To: <20250418073026.2418728-1-huaqian.li@siemens.com>
References: <20241030205703.GA1219329@bhelgaas>
 <20250418073026.2418728-1-huaqian.li@siemens.com>
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


