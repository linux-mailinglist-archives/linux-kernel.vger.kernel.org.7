Return-Path: <linux-kernel+bounces-615444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9940EA97D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 05:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C917917F787
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED2266B4B;
	Wed, 23 Apr 2025 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmgXomUl"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F4265621
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377884; cv=none; b=VAWpjkapgUkWrtyornDygjJcPu4rJqUX9UnP57EMYk1hsE5uBq2unEu27cXMKCyCOIp0Ij+7Jzi4y+nUZ+o7lgPb/IOINm8EuZnpNtgqvPEmd9YVvVfqfcOTAGBIEfHJsqBlSqq8WLmIHdVcRr8Gs1Lo1G5WrIeci009WWmqY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377884; c=relaxed/simple;
	bh=4G6PWQVuDvN75y22hCzNOaMSSVueFKJQsuXjCZZMx9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vx6C7SdDGaGZ+jTjN3K05FyTOe2IH9DMCqHo5d+JtOROlt7k05GlOQd9fgHSth7d8tt9hb33suIYTQQITjLXKEup5OZTKXIZTGbFdDIWIfdk0GY+Ah/v65e2TONfJGQgBNp2C21yXr7GA47MSV4pIUCTgPLFNuBBw7I6bD1s2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmgXomUl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c1ea954fso3139097b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745377881; x=1745982681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8selbbQToSUa/Bg+HZMawzfuX6zEarAEcQjX78fl4Q=;
        b=NmgXomUlonZR3NNxekMVcJpYhOgISYfrOz/+jwlXIJX55FpaE6cpoxN2hWzhbY21Qq
         x5AeGY+fIF7FojxFJ+fTZHtJOtBkvuL6vk53L9wB/N18dVrJCtbu/Yf7ITAA3BUbKNKA
         9vlQsSRhnhX8GakYKRD3xcIgO+Z4zW/GntHpQhnHg1T1SMLE7oLeh3552QTFrHNGoYEf
         9n+trteekcQ6sLhvq03CihrdSnYg/iZJLYs9CfJhUwBPpokG7w9m3IopuoWIbUSFdXQq
         RQUopCAcSHDJhDhWMGYPwzitnrVrV62phcVyGKWP+oF8aKWRCvqNRuXAZgdhSJxKmBv/
         A34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377881; x=1745982681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8selbbQToSUa/Bg+HZMawzfuX6zEarAEcQjX78fl4Q=;
        b=Y1gArBfchrtYgrRt9geNQt6KwsXIxm4TU5OGmX15fllaDcTaVL1N6cOTppQUr4X03d
         L2rkrMXDYXzxUIgt4toGNmX5EYoi8iIFiw/EYEeeVCxtajfdQqti5zVR6dH93bY4xBgA
         ofnbVrX6i7e01K+EqFYIR5jH7RJssK+XYfWJcxDDd4PpD/KeWeiRB13GwmY6sQ5dmHvg
         qr6aniCN9eks/k1t1RS1oFNduPEpySPXkb2/kGm87pvQDmelaFhZ+TkIXCYgRBmPEgKL
         oxIm5ZvkkNGBnRwCOKPmKCB5dJJKc+vPWgNnDuC3YQCL93WqLzoIbo9vIKvgUJNOd/jg
         MLrg==
X-Forwarded-Encrypted: i=1; AJvYcCV+HeAqmlFPNPpMSlHJnaPOPK2UvtplSTKxHCr1sQsOB+K0H1YdLWnMLsKEjy/8OxqRCZfsfQVzcxjQIjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfHBh0p/bWep8TNpLrx1+aPCP/roBSxiVqIsWvYs2tyTdHAQG
	rzUOBiSegdccKVb4sLX8xd4Y/apIBH5VtCGxljHIV2xEy9Xx2JW9v/m4yKzFPAVjHLejcJurs3R
	f1gCqyp01V7YbZ+dIbHGiBg==
X-Google-Smtp-Source: AGHT+IHU4/dyYnBOZEE59+3Rh6d4oIpl4blTPMaAsd4rLItdVF0P0sFEZgSP8/ttfcIBBwfCCnTsssXIdoZ3Ux50tw==
X-Received: from pgbcp6.prod.google.com ([2002:a05:6a02:4006:b0:af3:da1d:452])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158c:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-203cbc74cdbmr27664801637.24.1745377880870;
 Tue, 22 Apr 2025 20:11:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 03:11:08 +0000
In-Reply-To: <20250423031117.907681-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423031117.907681-2-almasrymina@google.com>
Subject: [PATCH net-next v10 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch


fix iouring

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b42..64af9a288c80c 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,8 +20,17 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
+enum net_iov_type {
+	NET_IOV_DMABUF,
+	NET_IOV_IOURING,
+
+	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
+	 */
+	NET_IOV_MAX = ULONG_MAX,
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0f46e0404c045..17a54e74ed5d5 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -247,6 +247,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
+		niov->type = NET_IOV_IOURING;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d04935..f5c3a7e6dbb7b 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,7 +30,7 @@ static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
 {
-	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+	return niov->type == NET_IOV_DMABUF;
 }
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -266,6 +266,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 		for (i = 0; i < owner->area.num_niovs; i++) {
 			niov = &owner->area.niovs[i];
+			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-- 
2.49.0.805.g082f7c87e0-goog


