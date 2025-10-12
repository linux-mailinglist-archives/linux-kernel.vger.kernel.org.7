Return-Path: <linux-kernel+bounces-849416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B228ABD0107
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 12:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756553B93AF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9326B762;
	Sun, 12 Oct 2025 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deS1KFz4"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F3267B00
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760266346; cv=none; b=XQcIxvx5yGhhflX7TC3flv57qjniy4XEH2esqrGk5lKsodb2Mv4V8AOjdErvTvnSOWWhxO9D2lw7S/8Vj4bW7vZySSLM6Dq1rXA9ZQHQc9xr2LCdGoZ9ZnWIcPpvSwUFUZxgpb6fQJ0mj32fjvHWlsnbqUqLURNj42eW/ljx3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760266346; c=relaxed/simple;
	bh=MqF5cMOJ84e/bDS4TErqwcOhQLiLI58hkMImp466mJw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VlnuhhQAZDfkrM4oypoeX9/V64q5fQzCAb+Zy7pBVtn6CvQ3qvtJ2jvGYIHTeG48rc3xAWyKTDIvi2YIy3DCr6NlWeEFCz2O/oVaURL72MpCgF8dKM0p8q2Oc2HSvIuB2FmdIVbBCnJf7kYJqMAQykq9rlpZ5H3erACzL9/C4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deS1KFz4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso4745145a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760266343; x=1760871143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=deS1KFz4gDKafGaMIQrGPSCIOfMTel+LFfulG3Y3ZWzVS1IiWdlJ/nmy+r3jX/lDf5
         zbWhVIG3gwsHF9h1XAhkzvKPUr8VbCBy5CTtIf/iHUNzsqz+Tmv9Uqpfcoi2IeNdPW3q
         0qYqUjKb3CDXZaYo/l1gHisJCpZ0WWzThwu6VX6TsI0v08DjqpTX4Yi5zR8IgI1/uzSr
         KG5oa5FZlxCdoBAjXWs4jwMfSQvaFFMQNQIebZYTmhbs5snWJrqSBla7TVKyWY27LTgh
         iT2dL3CJmJmoj9nHTTwMSQLbiq3HgU06da+SBHLKinjRt189b2AC4W8xlZt7y2n4yyqO
         r+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760266343; x=1760871143;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=JaH3o3ZrKlE6JDqkyiRGj8u96uAKLLtGsf1xMr0FYCMD6XRwJX3Wc5VaXmwPK4Me3Q
         6RrYYOS03qGU34TsxAIgdlB43x9yLr88eJi5xMb4biebXUEcKjuq1QLkx5j9sUr6Hf94
         80QJtspPeS2IyWVf3F9aOF0SQjow3dJB4wDM/+FujXpYVCC7vNASqnqGgY1BoNcTAsyp
         uygv9F/73dL8T94t+EUVMEdW0+zuVLnyTcsWFbsnvP1ejjdC6XDbDV0dQtAK4NBjueja
         1xOUCHDWnfnS5Nuih5kC85E2ULRDg6io+F0r67XNkZqL3bKFAVaHtXHHj2OwiUB9M3/y
         og5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKJScxMmzNsSW3uXxJTceWrx093JkUEfUXIjwUWQZh2Fb854VcYevRa2m3ixt16680R2XV4eCiyMTKWhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GWzMlZ8pCZH5roa6JEe62zWk1+8fo6mSjZcOx1xoVdbgs8um
	Mbr0X7+qAiy20j8Nu5vCbVpVZI4jxrMx8l5GMj0BrF2tVfo5t/V2enzl
X-Gm-Gg: ASbGncvgnmLC3TlWwzOls29fOga/WGTICNERcPC7ajjt1WrBb8/LGPg79QfjijE+Qtd
	VKTIvUDASV8+KLXaaNE7gy1kjBsP24Fklgnr486JIxKM8NWA31nxm7AOwp2IC0/7wQB2D4hf8Oc
	rfBmB8y3mU8sP0rTMA6OR1LT8obUVF/G+eVf92SSuijvEnTu6UL/X2AUq69lxXfZWU8clEpNVs2
	1/5cnkFShVRV41sX2eeMwVk4GMffoCJe5KWR78tWKWsAR9KkXhx7U1nNLUyY89QW/vpjqiRIdLg
	OftEwCNpUNC8RMfVJuMRVpROsU1uS+cNf5g1WQ07KwqVUQFWy26IonJCj7Mg6BcFPSRBmGhjABU
	WjtHxTkQSY0clyIEKNyzeYg7z0lXv3WZi2q2nXi6hFoqm9oLD0fo+V9DAjCACqTDBLC5d6W2c9a
	I=
X-Google-Smtp-Source: AGHT+IGpnc73DvzgvhXnM6IXi/RiZA/Mw6XZR7FH07n78kbcJVw1ff18xsQwbSwwRBD8xIEozEoGuQ==
X-Received: by 2002:a17:907:3e22:b0:b3e:b226:5bad with SMTP id a640c23a62f3a-b50a9a6d8a3mr1889184266b.8.1760266343213;
        Sun, 12 Oct 2025 03:52:23 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm688164366b.5.2025.10.12.03.52.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 03:52:22 -0700 (PDT)
Date: Sun, 12 Oct 2025 12:52:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH RFC] Implement DMA Guard Pages
Message-ID: <20251012125218.45c5f972.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I wonder if there is any interest in a feature like this?

DMA Guard Pages are unmapped pages inserted between consecutive DMA
mappings for devices behind IOMMUs. A device accessing its mappings
out of bounds will hopefully fault instead of hitting other memory.

I wrote this hack yesterday to debug such a device, since getting
an IOMMU fault is easier to detect and more convenient than looking
at some weird malfunction and wondering where it came from.

(BTW, can a PCI driver "catch" IOMMU faults by its devices?)

It looks like a useful aid for PCI driver developers and testers,
or maybe somebody would want this in regular use for reliability?

Honestly, I was surprised that no such thing (apparently?) exists.
So I dug into dma-iommu.c and wrote my own. The implementation is
trivial, it hooks into iommu_dma_alloc_iova()/iommu_dma_free_iova()
which appear to be a bottleneck where all iova (de)allocations for
DMA mappings must pass. The allocations are increased a little, but
callers are unaware of that and only map what they wanted to map.

It even seems to work, but beware it's first time I touch this code.

Michal

---
 drivers/iommu/Kconfig     | 18 ++++++++++++++++++
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..f607873bf39a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -157,6 +157,24 @@ config IOMMU_DMA
 	select NEED_SG_DMA_LENGTH
 	select NEED_SG_DMA_FLAGS if SWIOTLB
 
+config IOMMU_DMA_GUARD_PAGES_KB
+	int "DMA Guard Pages size in KB"
+	default 0
+	depends on IOMMU_DMA && EXPERT
+	help
+	  Specify the minimum amount of Guard Pages to be inserted between
+	  consecutive DMA mappings to devices behind IOMMUs. DMA Guard Pages
+	  are not mapped to any memory and hardware attempts to access them
+	  will fault. This helps catch hardware accessing valid mappings out
+	  of bounds which could otherwise unintentionally consume or corrupt
+	  other memory mapped adjacently.
+
+	  Size will be automatically increased to one or more IOMMU pages,
+	  depending on applicable alignment constraints. Small power-of-two
+	  mappings may get as many Guard Pages as the mapping uses itself.
+
+	  If unsure, use the default size of zero to disable DMA Guard Pages.
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	select IOMMU_MM_DATA
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7944a3af4545..51edf148f6c4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -746,6 +746,17 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+static unsigned long size_to_iova_len(struct iova_domain *iovad, size_t size)
+{
+	size_t guard_size = 0;
+
+	/* allocate optional guard pages after the requested mapping */
+	if (CONFIG_IOMMU_DMA_GUARD_PAGES_KB)
+		guard_size = iova_align(iovad, CONFIG_IOMMU_DMA_GUARD_PAGES_KB << 10);
+
+	return (size + guard_size) >> iova_shift(iovad);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
@@ -759,7 +770,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	}
 
 	shift = iova_shift(iovad);
-	iova_len = size >> shift;
+	iova_len = size_to_iova_len(iovad, size);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
@@ -796,17 +807,21 @@ static void iommu_dma_free_iova(struct iommu_domain *domain, dma_addr_t iova,
 				size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &domain->iova_cookie->iovad;
+	unsigned long iova_len;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI)
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI) {
 		domain->msi_cookie->msi_iova -= size;
-	else if (gather && gather->queued)
+		return;
+	}
+
+	iova_len = size_to_iova_len(iovad, size);
+
+	if (gather && gather->queued)
 		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad),
-				&gather->freelist);
+				iova_len, &gather->freelist);
 	else
-		free_iova_fast(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad));
+		free_iova_fast(iovad, iova_pfn(iovad, iova), iova_len);
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
-- 
2.48.1

