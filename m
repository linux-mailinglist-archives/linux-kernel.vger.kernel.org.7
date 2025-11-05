Return-Path: <linux-kernel+bounces-885670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D806C33A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AE4654E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112424678A;
	Wed,  5 Nov 2025 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbKiRJKa"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57624BD03
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305807; cv=none; b=FZM/0ywLW1Yyk3zmBMmpRXVQyeVUACRxVliZlSQz7sccbkXjORU58IqIh8TW1r20FJ6gI+V/evznHBWgfAgPZ1/WlV39HWX2TXcloUqyUMPnsmp1vemufJS99kIaBwEyByFspBRMf9pJ+zFPVf63+8hQ3qGOQlPo0mvQQE7sLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305807; c=relaxed/simple;
	bh=OvzNhBXxuWUIF6RvKnWgwOVCFYbwugbVchWt/Nz0HFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/prt1awwiBgHpyS1f6JpBuWGOK5qsF0pPOGCTop5dmN5eY7kjwoU0AwRKwcF50G/y4uYH1TmJEzl6eRev62Rv26Wwg6WXtGIS3iwR/wvxKdTAPv3/JILzCagxHV5A6b1eCVAp10PYPoSiPD8yW7PyLmsZ5JWVqmxmrmf/C+oSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbKiRJKa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7864cef1976so6946777b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305804; x=1762910604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+SHvc7nB9HHEDm3HUCX6qil9+t5RGl5tlTHjTzf/d8=;
        b=bbKiRJKaCxxCePZ3MFJn14tbhBMXlMebKzsToyhvXUnlWvzLKWy9Ubg3yBBhnBKIcq
         8ZshJNuCT1wcMTMMr2dEFKAkKKU+H33EKMe3Lsh+Fgy8m9rBL/fmKoNgZ5Rbh2UwTx8F
         9f7ojtB+BrfUXQevhivZARAjJfSISBdNWuzgIY0IkqSfAs7qOzWbLIWg6oa6Y9yxgAT2
         TTIouHeHrtH2g2ca40JQEiK0okNcM9dxpWgec5el7ndxmLLZ6hEBSkb25rkezMEjJ+xt
         KBYLg5rIq7aH1puTak7ss07+5q5+fx/YgK5gxuRLPTKBm1BLmMAsPahiQD7PlzMcR3GG
         0P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305804; x=1762910604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+SHvc7nB9HHEDm3HUCX6qil9+t5RGl5tlTHjTzf/d8=;
        b=hsV/gvajNfiRYa6zmw/oV8DJ9oE5C3v7XY0GWWmEsBKI4LFzGpsmeW7sbyIsVlz2C2
         IXDscAabfn1Q8dX5XpLarqNHSwbwX1MsCYqM9eOU5k1MxFzyD72Yc8pefRp9xLna5AEL
         TXvo+JCu8I0WtkHejdLaVbYOeRisjYOEX8QYKPCFk/sxxtsVFNzNfC8SgSLh+4qJkrMz
         goxLP4B6gDFb2CXJY0e35/NrNvn0bQTs+emDtCOF26ql0Jx6xFpf6RJ6JNV9SjIrSPmC
         eTXGCyisFU1iROuKUHOAr3RplnmaiRJwK6ROKQ5xR4u4Qfqjm/w+O7qASv0IJ7Cro0Xl
         82EA==
X-Forwarded-Encrypted: i=1; AJvYcCXdLTi3UBN5Uv4UAYs2KdN4JldTxgPgrSWDM+NnM5cUVaMWXaiICTfcTP4dfLcPYzwY4JUObged8UVU49Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HhBeUY1l9GT06gr8b2F//9GUc8pd2BpZ65KQO1cVrLz4ftvN
	M0VVeyyhfloOPMmKEewFannekWJmgb0qWcHFtoEQZ44DpOS4P/hc5Ndf
X-Gm-Gg: ASbGncuT0gpBqvh7F8WI/DzIuiKGHSC+yg9+eP9BuDiveXM5Rd9YMyEUMtGamJBlENy
	VTFfb6VC1AaRFa8plBPdeywcUajp1YbWy+Y2ATZ3BsxqyDEWWsxvhWSnPZ5zAKW6igRJXM+PPvK
	G3B1LgQMHg4KI4DcAza2Mo5olWSnx26+St6NOkUyehyO2m14N4VPow1IIOtJx6CwvbqXhBnMEgH
	iHs92P5xh9nQdLJKfPaGOAsajLy3si+mHCJpYQPArQ7zKIRqo4RYr0c4nltVk8mH06TwEAXhOjW
	eXm+JK4puiH3ILlNLnEasUVsavkn5SBG/M+mnOoCOwbyYnDk0S06d1vCp7AaqOvbhzB6uSn5mwG
	KPEWa4pXhmad4j0azNgVYHrcAyX578gpQIF6S3H1sdF6E3c7CVCRtYzZmZI5N1ltwpDdJc/Ekvj
	6vrHCstdSIlYc=
X-Google-Smtp-Source: AGHT+IFeyI0Qmv/W+8x9HEVce2BJ1U7rPbvYiu9qefbETDwwR8GfWjNVDPJZ55xAV6KEJZjaAcCOAw==
X-Received: by 2002:a05:690e:1c0b:b0:63f:af0f:aaf with SMTP id 956f58d0204a3-63fd31161f5mr1195839d50.1.1762305804005;
        Tue, 04 Nov 2025 17:23:24 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc92f0a66sm1316651d50.0.2025.11.04.17.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:23 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:20 -0800
Subject: [PATCH net-next v6 1/6] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-1-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756..4dee2666dd07 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -75,7 +75,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -232,10 +232,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
-		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-						 sizeof(struct net_iov *),
-						 GFP_KERNEL);
-		if (!binding->tx_vec) {
+		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+					      sizeof(struct net_iov *),
+					      GFP_KERNEL);
+		if (!binding->vec) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
@@ -249,7 +249,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -295,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -315,8 +315,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 	gen_pool_destroy(binding->chunk_pool);
-err_tx_vec:
-	kvfree(binding->tx_vec);
+err_vec:
+	kvfree(binding->vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  direction);
@@ -363,7 +363,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -414,7 +414,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 101150d761af..2ada54fb63d7 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -63,7 +63,7 @@ struct net_devmem_dmabuf_binding {
 	 * address. This array is convenient to map the virtual addresses to
 	 * net_iovs in the TX path.
 	 */
-	struct net_iov **tx_vec;
+	struct net_iov **vec;
 
 	struct work_struct unbind_w;
 };

-- 
2.47.3


