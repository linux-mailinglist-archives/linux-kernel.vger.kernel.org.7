Return-Path: <linux-kernel+bounces-898016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CEC5426A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D223BACDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146BA352FA2;
	Wed, 12 Nov 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfoHLUic"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057335292C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975382; cv=none; b=OQdTwOg0O6YLIGlD75mcIxdNxk7FNMlrAl2lWCaluy8wxe9SvmPp12UIwFUwZw7McrsmT2HRVqH86EoxMeAgNfPRNQ/mitp3KRlvUmKRrsLuNUgveZgXQy1q/uOb8TixehpOciwBVkbDoOkdVFLQzpgpSvXoYtT8FzKTG4ZHdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975382; c=relaxed/simple;
	bh=k+h0e9DGqf0UqZUIrxgBUd3HnlRFK4yhRYHVnGolsNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKRQ6e1VzzRynlBz/JDzBIAWFh3GEbPP3fZ06Djg+WdYUObrBn81YMhdPRftkEaGp6MhXSdz0/FOnshK9lLkY2i8zcg3Ze9X6sBXwrnjFjFGLFc7/JkUaBr4i5WZpllXLtqqcCdJJgxHEpJ3C+fSJiBz44oTXtyf5/9BUnRuMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfoHLUic; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ad1e8ab328so976932b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975379; x=1763580179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SClEIRDGqMM6/CDJu3mQTJlAF3rZlqeqRl58NIDI91g=;
        b=FfoHLUicROa1zGG9apeygIYfM4wzyjoC627aZ/S2iUJ0L0pNpvaO/uKQnvTk/gOFmO
         h0AatnUScnQNhZuWEaM2kgu6KB1+iDnaRQ+znXqsIWnEaTiIERYbdmnyDwtHjuHB8HVw
         pZ25Su3qV5/xtGwl19WxCilGp6rQNnDVDzp1s/ZsUQwsefSb4Sgm1ceFu5qmOW9FkNLc
         Zsn0FPV5t9ihuZhGWfsr7/PUcghnUPRB7NW2WUU+DUUd9K2+KyNItp2I7vgQvUfFLtPI
         EfNEyxbH7HVNNyzIedrnIHYhN0WYXPrMIl0EsgyUhT+8XiQhFzCWtXpokpb4Q8d/pkBM
         +hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975379; x=1763580179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SClEIRDGqMM6/CDJu3mQTJlAF3rZlqeqRl58NIDI91g=;
        b=rddz96Z0W4pPTDQuhDvQzibQIozwRrQVAdejQxghOu84QiO+oW9iIEM6JahMUK4bvG
         EkmH8JJ4Z1C282YxeqotQxlQPVuo+BZ2mkjO82U+FcRxJrI/uttWE1F3QmV5wqWQ44a/
         L3KwBzC/w5fZSByD4V+Z8iClztv64pojmVB6W+NBbz/vWblLOPMqRmBGesohdN6sNS6B
         VZjgP+etnf6WnydkkqVAtAN8pYGrSfQQx0Vj+9LEZE0OTlSt/b5z/RQx6kdSVm2wMX33
         h3tvKce7YvtyHWlhg3IJ24fJqYlSwDwNjMsMQcwQD98pN2JE8J0QqKcH0++sEAhPNMjX
         blFw==
X-Forwarded-Encrypted: i=1; AJvYcCVqcS3XgXoR0zicUK1FcHw/ulFV/VyIi7V2PEVEGCqdIrQwyfa3XPzGh6IVUU6IVJpY8I9cHlyR29ZUWbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuP4v+wG1y924O2HXMLTytnAT5EDYoTnUgt3Wu2KpQOQk3IvZ
	xDZT2JsTasfQZtvqKTMJLxIBGgiIAHk1fAoiklHud03Uq7DMXh9xcApbfh+HztemndwB/czONCM
	+73kXVbEgvpWJjw==
X-Google-Smtp-Source: AGHT+IE0RR3NaaZRsX42px2Ui9QqlKLfhYBC7yf3CJtNKth46iGLw6TE7T3Z9+SvRXK+RFn/1Hq1EWdkmDrSvA==
X-Received: from pfbfk7.prod.google.com ([2002:a05:6a00:3a87:b0:7af:350d:6082])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c4:b0:7a2:1b8a:ca22 with SMTP id d2e1a72fcca58-7b7a52c4d9cmr4929208b3a.25.1762975379566;
 Wed, 12 Nov 2025 11:22:59 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:24 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-11-dmatlack@google.com>
Subject: [PATCH v2 10/18] vfio: selftests: Rename struct vfio_dma_region to dma_region
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename struct vfio_dma_region to dma_region. This is in preparation for
separating the VFIO PCI device library code from the IOMMU library code.
This name change also better reflects the fact that DMA mappings can be
managed by either VFIO or IOMMUFD. i.e. the "vfio_" prefix is
misleading.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 ++++++------
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 12 ++++++------
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 12 ++++++------
 tools/testing/selftests/vfio/vfio_pci_driver_test.c  |  6 +++---
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index babbf90688e8..7784422116de 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -80,7 +80,7 @@ typedef u64 iova_t;
 
 #define INVALID_IOVA UINT64_MAX
 
-struct vfio_dma_region {
+struct dma_region {
 	struct list_head link;
 	void *vaddr;
 	iova_t iova;
@@ -154,7 +154,7 @@ struct vfio_pci_driver {
 	bool memcpy_in_progress;
 
 	/* Region to be used by the driver (e.g. for in-memory descriptors) */
-	struct vfio_dma_region region;
+	struct dma_region region;
 
 	/* The maximum size that can be passed to memcpy_start(). */
 	u64 max_memcpy_size;
@@ -236,20 +236,20 @@ void iova_allocator_cleanup(struct iova_allocator *allocator);
 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
 
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		       struct vfio_dma_region *region);
+		       struct dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct vfio_dma_region *region,
+			 struct dma_region *region,
 			 u64 *unmapped);
 int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped);
 
 static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
-				    struct vfio_dma_region *region)
+				    struct dma_region *region)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_map(device, region), 0);
 }
 
 static inline void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-				      struct vfio_dma_region *region)
+				      struct dma_region *region)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap(device, region, NULL), 0);
 }
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index f3aea724695d..877b145cef63 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -275,7 +275,7 @@ iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
-	struct vfio_dma_region *region;
+	struct dma_region *region;
 
 	list_for_each_entry(region, &device->iommu->dma_regions, link) {
 		if (vaddr < region->vaddr)
@@ -387,7 +387,7 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 }
 
 static int vfio_iommu_dma_map(struct vfio_pci_device *device,
-			       struct vfio_dma_region *region)
+			       struct dma_region *region)
 {
 	struct vfio_iommu_type1_dma_map args = {
 		.argsz = sizeof(args),
@@ -404,7 +404,7 @@ static int vfio_iommu_dma_map(struct vfio_pci_device *device,
 }
 
 static int iommufd_dma_map(struct vfio_pci_device *device,
-			    struct vfio_dma_region *region)
+			    struct dma_region *region)
 {
 	struct iommu_ioas_map args = {
 		.size = sizeof(args),
@@ -424,7 +424,7 @@ static int iommufd_dma_map(struct vfio_pci_device *device,
 }
 
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		      struct vfio_dma_region *region)
+		      struct dma_region *region)
 {
 	int ret;
 
@@ -480,7 +480,7 @@ static int iommufd_dma_unmap(int fd, u64 iova, u64 length, u32 ioas_id,
 }
 
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct vfio_dma_region *region, u64 *unmapped)
+			 struct dma_region *region, u64 *unmapped)
 {
 	int ret;
 
@@ -504,7 +504,7 @@ int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
 int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
 {
 	int ret;
-	struct vfio_dma_region *curr, *next;
+	struct dma_region *curr, *next;
 
 	if (device->iommu->iommufd)
 		ret = iommufd_dma_unmap(device->iommu->iommufd, 0, UINT64_MAX,
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4727feb214c8..289af4665803 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -136,7 +136,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
 	const u64 size = variant->size ?: getpagesize();
 	const int flags = variant->mmap_flags;
-	struct vfio_dma_region region;
+	struct dma_region region;
 	struct iommu_mapping mapping;
 	u64 mapping_size = size;
 	u64 unmapped;
@@ -208,7 +208,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 FIXTURE(vfio_dma_map_limit_test) {
 	struct iommu *iommu;
 	struct vfio_pci_device *device;
-	struct vfio_dma_region region;
+	struct dma_region region;
 	size_t mmap_size;
 };
 
@@ -227,7 +227,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
 
 FIXTURE_SETUP(vfio_dma_map_limit_test)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	struct iommu_iova_range *ranges;
 	u64 region_size = getpagesize();
 	iova_t last_iova;
@@ -264,7 +264,7 @@ FIXTURE_TEARDOWN(vfio_dma_map_limit_test)
 
 TEST_F(vfio_dma_map_limit_test, unmap_range)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	u64 unmapped;
 	int rc;
 
@@ -278,7 +278,7 @@ TEST_F(vfio_dma_map_limit_test, unmap_range)
 
 TEST_F(vfio_dma_map_limit_test, unmap_all)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	u64 unmapped;
 	int rc;
 
@@ -292,7 +292,7 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
 
 TEST_F(vfio_dma_map_limit_test, overflow)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	int rc;
 
 	region->iova = ~(iova_t)0 & ~(region->size - 1);
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index b0c7d812de1f..057aa9bbe13e 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -20,7 +20,7 @@ static const char *device_bdf;
 
 static void region_setup(struct vfio_pci_device *device,
 			 struct iova_allocator *iova_allocator,
-			 struct vfio_dma_region *region, u64 size)
+			 struct dma_region *region, u64 size)
 {
 	const int flags = MAP_SHARED | MAP_ANONYMOUS;
 	const int prot = PROT_READ | PROT_WRITE;
@@ -37,7 +37,7 @@ static void region_setup(struct vfio_pci_device *device,
 }
 
 static void region_teardown(struct vfio_pci_device *device,
-			    struct vfio_dma_region *region)
+			    struct dma_region *region)
 {
 	vfio_pci_dma_unmap(device, region);
 	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
@@ -47,7 +47,7 @@ FIXTURE(vfio_pci_driver_test) {
 	struct iommu *iommu;
 	struct vfio_pci_device *device;
 	struct iova_allocator *iova_allocator;
-	struct vfio_dma_region memcpy_region;
+	struct dma_region memcpy_region;
 	void *vaddr;
 	int msi_fd;
 
-- 
2.52.0.rc1.455.g30608eb744-goog


