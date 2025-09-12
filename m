Return-Path: <linux-kernel+bounces-813213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1BB5420B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1969C4E14C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA0279DC4;
	Fri, 12 Sep 2025 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoYHWbjb"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B12749CF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654918; cv=none; b=PMbvfOF7sh69tfDX3YJ62t2wu9RYrz0FkH5/3Wvqe/Y2oOePCzboDzARYbdklbaBKjYiigwHPZiGG/jayxVVMk2bU4PEZdpfCWfbSoPHmuOyrQzy7LXbm5Q14pd9DOJBX6FxgesK/pnKvUviQqr0K1z+lmAMKcOqHB6jbQYHnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654918; c=relaxed/simple;
	bh=fdrJ2W7mBo4ScK0+ExdwCjhXZ7mjfmL0Ggt7KK74nGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoH0XA/reyEmXMMRQ3ydfVN4B4FCN9CRjA6ZWsZ6WL9/jIVzCzQtr2QYw0lRXornzmn95ti7jt0Wt1QIhVwT8MYerhr4ewKVuccPiBxDBiT4WDYcEIVYUIHNIIoimvrmyDjJICNZuraPmtc/h/zFrzKiX0KC0WETmNwwf0BRhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoYHWbjb; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603a269cso10537047b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757654915; x=1758259715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=OoYHWbjb/V3YOaicu1paxd9GOTv+BujVE6ocJRheTKaEXIXRwpguH/GYcckn3xBbDg
         /CcqRtRN9VHzKWPsi4Uyx/6a3fxsrMjrI5l/N4meuS094QqXIYDQUIPxaP7wtqffRnJa
         sa93PJUlNI03lOucvPEN4pggV+SnpoI7qq+wofjCniOsOOW1MF8Yqdfv4jt/OW4eW1y2
         90YNQU5qCAZhLn4KQM1zKNIJm/5jsHY+60j1pmlw1U3UbWFG/dXFdbnqE5n0E3KA7HYB
         0mpsumgucwjcUVb5EgVRGH+OC+HtLFfWxrOj/bmL1AnBWLFvO+rIZd1Jq0l13iB3/ZJV
         qwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757654915; x=1758259715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=lhcGFUoTkpeqMTezUbfL5kz+mSI6TKCjGng70kGK0BvYgRGaH5qvtYeQOmnEaszMuJ
         2mq6YS3a2OMi0klWumiIPQNK00uJgWC4p1WoJRaLnaz2aXs53o47dKoAqKi7jCG8gD/X
         d/qYm4KRmz54dT4pkiwqRYfsRQIMUEcGV94AxR3OMg8ocsA1cq8h+zzg4FjqM6oAceeV
         zeN9wDV4yBjHfQ2whKm1wGsNyBcJFz7qdb23dzcLSQzZIDqBHee4h2ubUBDLj6qOvTS0
         VITHAJuVSRBsem5rdGwAfWLZ11DJvi17+prPjCAvybpWDBrItI7PzCMr/8z6WRq580xu
         Jgnw==
X-Forwarded-Encrypted: i=1; AJvYcCX1kIRJyy9b8D1gb2T2m2xWtU9xyi/EidI2LlxDczEv56IjvWWx6sTqdzKqDlkKSnH/y9GT8t262QXy7m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTD3eyfvzANWfRourMuVQYd99NalzC8BCgV17kJZO5OYa/p7Ek
	w5d2NOqjIgVl7pdTvu6qka8ezvdISBarERfhBJvzg3kw53qTVJYTv7VO
X-Gm-Gg: ASbGncucDwYScw493oyXVxFjChl77A95gKERyTZ2s1J2+4nY4z/PrZv9PbGK6cRYj/m
	25PvPgBl+UDE80DdapbeVFT58c/CsJCH8LWa+lhk5hgHP78JA1HM/iyN/ujUBOaXDuAk4Fm0o8/
	WXEVTRuykTb7sMJO4J771/HRSbmCwbqJRb2CLL20fK5AU4DHIpuZA2JL5jKQG2fbidYqkjmRJUz
	r4s66OCoDQ9hB6gdvt8o2NQolv4JEfuU7rKRw6WGTK01Kd9FNGaDmCSpeSJ8JYIhtP+VV5GOahf
	YL5Ma8NHmmje2I7RMKeu8hEkqJj6MmeeAuQpxf2Ol8Eqgp/FM4wfHlIf3lL9dACR4OO9iHXZHly
	i+HZD7fdJMt4L7VNJpfjehUl6CilU9fI=
X-Google-Smtp-Source: AGHT+IGQDOKo/+rHOGnJMv9k+15pjzLyuNWmg1SbdxW78JqevUneQyQ65Vm5pm9WI07RFWoIos5Pnw==
X-Received: by 2002:a05:690c:6e93:b0:71f:a867:3fa8 with SMTP id 00721157ae682-7306376c3ccmr16751537b3.20.1757654915409;
        Thu, 11 Sep 2025 22:28:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a35bcsm8520227b3.39.2025.09.11.22.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:28:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 11 Sep 2025 22:28:15 -0700
Subject: [PATCH net-next v2 1/3] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-1-c80d735bd453@meta.com>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
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


