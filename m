Return-Path: <linux-kernel+bounces-765966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE67B240AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07581BC064C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9FD2D0635;
	Wed, 13 Aug 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMxgGq1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D02D028A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064150; cv=none; b=XICTP4ctyvq9p7RTmJbgn+gkHw3oB//iSXY1bkhNEA942+92jPCrNxTm5IIXjVOodjynpFImP6td1/H2d3IpVS95EqSFU9nUNgKHxdCrSOOeX7rImbT6F7g9fZGT+h15wquIhvwdH9fyWbY8kzZplDSTilR59zm9M512IS/pC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064150; c=relaxed/simple;
	bh=5oqAJoPzHR0GxmVVo7AvUscPsv5V0EJLro0zKMyYk2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpbdJXrpCQIxOGu1tHU0uk5ReDp9S910Fmd/5xHA09amLdGnwHP9a81R+yQkmhzNyhJP9qZIelGLHshcOjNjUvbWMH+pM0AzbOYBsUmwOPCTYg+ajwDrSyrsg6fYdkQlkQdAA9V9OxMmJFuM5SAHLV9O+I1hhxVLP7vSVEsZxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMxgGq1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80lhT498S4jOzJ/P6kb5gkt8pK+u0mT9rN4yk+mBlD0=;
	b=BMxgGq1k7USUxNj7fponfYCZxpy97LmHAbZKZt+XdTHoZspUm8SsFon1me4o6Tx5TTZgG/
	ta/DFRwXWyzn7wbTddPnAEuRyG7qzY/KZCllA4EAU5kNtT74KVdOka+tdC6VNJYqQmFNzA
	DMjCuIq4Fbh4nH1O83LX2B5eHELJgss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-o41aZ9LeO8mQGQu7Ep0CAA-1; Wed,
 13 Aug 2025 01:49:06 -0400
X-MC-Unique: o41aZ9LeO8mQGQu7Ep0CAA-1
X-Mimecast-MFC-AGG-ID: o41aZ9LeO8mQGQu7Ep0CAA_1755064145
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFF12180034F;
	Wed, 13 Aug 2025 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4A3F180028D;
	Wed, 13 Aug 2025 05:49:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Date: Wed, 13 Aug 2025 13:48:27 +0800
Message-ID: <20250813054831.25865-6-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-1-jasowang@redhat.com>
References: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Following patch will introduce virtio map opreations which means the
address is not necessarily used for DMA. Let's rename the dma_handle
to map_handle first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fb1d407d5f1b..94b2a8f3acc2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			       dma_addr_t *dma_handle, gfp_t flag,
+			       dma_addr_t *map_handle, gfp_t flag,
 			       union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev)) {
 		return dma_alloc_coherent(mapping_token->dma_dev, size,
-					  dma_handle, flag);
+					  map_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
 		if (queue) {
 			phys_addr_t phys_addr = virt_to_phys(queue);
-			*dma_handle = (dma_addr_t)phys_addr;
+			*map_handle = (dma_addr_t)phys_addr;
 
 			/*
 			 * Sanity check: make sure we dind't truncate
@@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			 * warning and abort if we end up with an
 			 * unrepresentable address.
 			 */
-			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
 				free_pages_exact(queue, PAGE_ALIGN(size));
 				return NULL;
 			}
@@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 }
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
-			     void *queue, dma_addr_t dma_handle,
+			     void *queue, dma_addr_t map_handle,
 			     union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
+		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
-- 
2.31.1


