Return-Path: <linux-kernel+bounces-834284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CEBA455D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108D93BE131
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD3200127;
	Fri, 26 Sep 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmprx3Gp"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88F1EF38C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898980; cv=none; b=F+mCAtu2IGC27pZtn9mz5Jf0ZyTfZcVbGW84mBPGFn5OytPoqIWnBUvj2kuKtHzX7TqjYAJkOFPSI3p69wMVjKQN8vIA14HvBfYURInWUFss+upJId2v+2aU7Ts+pI/Rue2Ti+/vps+CFbAckQ/dB/UQ+7W43X8cZ9DngtyDJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898980; c=relaxed/simple;
	bh=fdrJ2W7mBo4ScK0+ExdwCjhXZ7mjfmL0Ggt7KK74nGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcumMpZnSSACyt4sbSsfjjIJDCCOs+WL6uAWORNZEgMDyQJS+Mynm/RqxuD6k1FavgW6m2QKMl3TjyMOvzBo0COC5KvBMPH55EzOwnLGRp6EN25GXpaHJd6CCaFsaKVv2DfXjhxosvY/gHA+rCcS2sAu4jvZ3Ll63v3gRWI/jXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmprx3Gp; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6360397e8c7so2267886d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898978; x=1759503778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=Jmprx3Gp3d4SgPUqQokJjR3jmGedHB5V4IxFVDPhierKVihClajZ2igUc9H9oxKAXu
         MY8nBpnpyX+cfsRF+ZyBZnf7EExWu6v7sCXzSew8/+WFxK+/bCn5GAf6S47mY9l6ezCK
         EDRR+arKKMfV8fbCdOFANAV+Oq9TXNIHXgF2VZND4i8wWp9lMSAsmB8iac2GrnsXqHYP
         4J3HNU3Cp2Xj2gU1U1lFEfA7KxHrDPjSJgA56ZnnF2hNK5Y7QaE4Q0wPMOS9oc28y9bA
         QLJD77q+zEjSvtgtEtA1Sw1syIlV2xSH39AaHjgVwUVV59ngWv/3H+2bxDoWNwPd2xoc
         l3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898978; x=1759503778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=RDQHsRRmyOEchsi/uVHdYpRLNutmuVrQ/RspKGWpWT/z+NdJsqybJIDq9JvPKefM5d
         mXC1+FysiWvY1ITMvhIHj8mlz4laASvZwUQCiB+iPz7EgIZI3lw78vMf/IJMA/JgMC58
         FAo+FfGNgGlidzRyXsAg6svz5SEFFdmBVC1EAccVb8oFyrBvhhLXTg8JHGpsrnvyG18r
         f8+U9UivCk+YnSKn+jPmQWNgYLIuEnSa9ti7APgvYXcWemxj4VePfcjVsx379ulEFydT
         i2Qx7jS7PzO+O54tltxlGs35IzCVCJCDIzTKpH0CT0fBt8LsrL/4y67sO0f99vSTR27m
         CfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeRj4z83Gg99Ef+S5fkD36Jw0nj5YVGSC7RUpyAJ65PQ4q7EP6m+/F7CkGO8iq6lxExZRdnXbLG/CKWuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyNu6mALMIBKA/5XMyMZJNKOXKYUcWMC2S6g8la58Usd7h29e
	dm1/N++FjV6MGlPT+T12XFGZ7fKiHXB3XvZ6cc90Ss6D+og37u6+HXIP
X-Gm-Gg: ASbGnctHv/iKfegyiKo5z2O4OHUdsq5YQpmksc7FXH8WnZErPEv9j4WJnNkSX+tMv0V
	g9zoKwgbpdGgMXdDbmFBdlTR23a+4JesIGNXN8LgLSi6PPS4v5GSp+cUVXzySCOWOWyQoXgeB+P
	LsBNAofnm6Kk1aioWRY+5gWID6RCzhyLXv+7ajCqnh/6NPPjaF/ES2gRNpaH+CQHGs5qMFcJVwm
	VYCAxENJO4zbaMKO/HMcNN7p+TpFMPgLlxOWw1CAajkBXDTfGKPdLA7LF9umBGVKERYEzT4xkbA
	WxxY3gGJN0WKI3lt6W2DiO/S8amIfkqIqeQJzeSgo7hY60fP2NxoHrg+VKfOoMe5MP/EHAmKr5x
	vfqR2m2JpVc074MSXPBYV5A==
X-Google-Smtp-Source: AGHT+IGfS9RCAJUvgFuEzk5qzM9Yazg//6yHH9Ci+kJAaw6QrFBXmu7CRHau3FH/9E1y1zRZTkfY8w==
X-Received: by 2002:a05:690e:d59:b0:632:eeee:c6de with SMTP id 956f58d0204a3-6361a717e72mr7694844d50.16.1758898977606;
        Fri, 26 Sep 2025 08:02:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c60b76d2sm11556567b3.48.2025.09.26.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:02:56 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 26 Sep 2025 08:02:53 -0700
Subject: [PATCH net-next v3 1/2] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-1-084b46bda88f@meta.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index d9de31a6cc7f..b4c570d4f37a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -74,7 +74,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -231,10 +231,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -248,7 +248,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -294,7 +294,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -314,8 +314,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -361,7 +361,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -393,7 +393,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
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


