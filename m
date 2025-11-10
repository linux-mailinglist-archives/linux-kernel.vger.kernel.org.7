Return-Path: <linux-kernel+bounces-894083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB1C493E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A8214EE423
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4852EDD7E;
	Mon, 10 Nov 2025 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbUMGl9Y"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A606289E13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806645; cv=none; b=lRa6ompow7nqbXKaBdMnguTBQFkjR8ZGJm+aXqMgqRaVKjNPSGrwSayO5OvKJq1d+v0NoeZydjAD2p19fZmyXDNNwSXN3RgKjjeo+OrkqhJStiEn7uZrUMTimVKbXfAH816/X7Xx7hOQAyAjqVBti4ClyWMWDx4RbXNVvrBcaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806645; c=relaxed/simple;
	bh=XPCALEKMTqvrYzdXKp4012lIXgr9shCCsxUVs1Kr7cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCbt4oTUfiGYA/MOxjdsQ0ojAFDp1vPIZdbjhwF8+ikq2+LBDH6jFeW9gmD7p7wuMbtozK6bg0I2wg04e5D9OC3v6xXFaRukFNpGfLqwGWVO7GpH7pvM/RncXjZIp3bLLnJpi6GSKJ+6gMjNM7CrvnNiPhDxxS+8+9V8LIfzhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbUMGl9Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so2845241b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806643; x=1763411443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro8LfVFs4vPgQTzcnnWdFnGjc8mt7GRah6t2C6MZm1M=;
        b=KbUMGl9Yo5qAFVgGbUrAm7Oc576vr4RG9tMaeqM3Xx/+fzn0wEOoM1yVPIzVpgkyra
         j7qPCHV/Jz/ZPoIfowLPZf+fTcLgIhcY8aoqBHDAxgWSUI8RpRTwKppHMYPDulKi/Bv8
         1bUtNkJ4pMHe6Tu0N0O2tzeGc/naWbN8LNgCGEjXeXRz3f5oHczgwiQ1YQr5cvR7Z6lc
         CNBVQf+/Curfnts28VUr9g4QBVEE+45elG3hySf8vjiP3mT6f9uuYqMj/PCHwrJkMmlE
         Va5FvQM7BtT2h5fXI/EuTYAflru3CQeDr+/E9XbeRiDSig85dccHfi08zQfdZGbHUs7S
         Hy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806643; x=1763411443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8LfVFs4vPgQTzcnnWdFnGjc8mt7GRah6t2C6MZm1M=;
        b=l1Ttc8Oe/VqBIPlPW+THRxbrUh+Yxm9JY3BqHy0M1t1LXqTZn/MLNps7doo22fI7dW
         bJPk3ftczUe+Ez2vt20iLybpwBH73VQK/N5/MgoX4OPo53Fx47ajSGR2ixhkE7IA0JvK
         u6fjtg/MGF0TcBL+qbb6PNne9e1aj/riuywOmOJXu1/ihGJUF1enjv15me2gJWzO8yV6
         RQTLQ554vFAvPcdMIkmtCDwbo9r8XcdVNPu7gmLXpF3E9pqaGF1alXYrMkFMp7x326WX
         r9w86u4CA8noLF0J81IF42Ot7CItMrCvnC3qLg23sASBLrLltgXOEcHJxdVxqj3xkehH
         Sziw==
X-Forwarded-Encrypted: i=1; AJvYcCXxdCtybTpvmRsKquLFs6EIdYdlnGWMwVkaZ0yo9qZdkd2WLBVTYF8AZ1mnmprop+bEv92eMEEgpSRRg7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y1bTS62KJi8nGCMrPgxTHt7xn52gRkp14d12BOExNyTTB4lO
	31Qa9EF12GKxk+DjJUOFQAQGaGsnFpZvP72bAUw4UVLdar4pb1YYn596mBIYy30r
X-Gm-Gg: ASbGncv/SULbFQXXJN6iIvxFCEibD7ZgK4gCnHPurHyh/6HXjj1RkVHFm2Ef9aKZ1Qc
	FeDQ0FQs+0F6kEQZzb00CbT5XY+y/wH+6ju8na3IpkFfH03GS7ATHIW0hxmfw6ghy/dRd41NWrQ
	YDFs5eNzkYckb5sxMhbjmbQze6XSq0hRJRyoAxy9vq/UobsBUI1O4P36wQ0bopPokclOXCNjpe1
	XrkbnYHLogvsmD7azcycx9byXFq60pKThYFxh1XXO2oH4w+IPPI9XRJ7U3d2KaLMdkwt9i0yght
	ZuNZOq/44ogigC9izQUzBqHhfMmi2SM4QIGAydFqNaav7owoYozkpeJWNNhrdUbLhlIr6nRGuEe
	xA+1C6cwDBNe0O572MxnqRAm1YRyyzus3HM6U3lc9T/os4AEtkzhn6kwtwg/ezhjZxiOkV6zJ6p
	+nXZAx70Snc1fmFhk6
X-Google-Smtp-Source: AGHT+IGkzYVEYBFXghKEZPwUaZCu1Fha5OHUKNcP3PPtxc6UkSUM+cKWRwlTckCHb6/fSObwrLGs6Q==
X-Received: by 2002:a05:6a00:b53:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7b225acd9admr10942610b3a.7.1762806643188;
        Mon, 10 Nov 2025 12:30:43 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm12920048b3a.40.2025.11.10.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:30:42 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] virtio: fix kernel-doc for mapping/free_coherent functions
Date: Mon, 10 Nov 2025 20:29:20 +0000
Message-Id: <20251110202920.2250244-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  WARNING: ./drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr' not described in 'virtqueue_map_free_coherent'
  WARNING: ./drivers/virtio/virtio_ring.c:3308 expecting prototype for virtqueue_mapping_error(). Prototype was for virtqueue_map_mapping_error() instead

The kernel-doc block for virtqueue_map_free_coherent() omitted the @vaddr parameter, and
the kernel-doc header for virtqueue_map_mapping_error() used the wrong function name
(virtqueue_mapping_error) instead of the actual function name.

This change updates:

  - the function name in the comment to virtqueue_map_mapping_error()
  - adds the missing @vaddr description in the comment for virtqueue_map_free_coherent()

Fixes: b41cb3bcf67f ("virtio: rename dma helpers")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..ddab68959671 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: the virtual address that needs to be freed
  * @map_handle: the mapped address that needs to be freed
  *
  */
@@ -3190,7 +3191,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
  * @dir: mapping direction
  * @attrs: mapping attributes
  *
- * Returns mapped address. Caller should check that by virtqueue_mapping_error().
+ * Returns mapped address. Caller should check that by virtqueue_map_mapping_error().
  */
 dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
 				    struct page *page,
@@ -3249,7 +3250,7 @@ EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
  * The caller calls this to do dma mapping in advance. The DMA address can be
  * passed to this _vq when it is in pre-mapped mode.
  *
- * return mapped address. Caller should check that by virtqueue_mapping_error().
+ * return mapped address. Caller should check that by virtqueue_map_mapping_error().
  */
 dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void *ptr,
 				      size_t size,
@@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
-- 
2.34.1


