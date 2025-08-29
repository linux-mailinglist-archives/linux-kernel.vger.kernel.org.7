Return-Path: <linux-kernel+bounces-792478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD7B3C48A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3012189269F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722C276041;
	Fri, 29 Aug 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdQRQG/s"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D13597C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504815; cv=none; b=OQVcGdDxcI2kTmRO2VjtLbxn0P9GvV78QNPJPaoAhOdjvLqVXdb37VrKwbiggHFseXcHK6OAS154fAmPRPHhjo8EKLO/n6zMfMvmcpNUhlGNY9v2MKCh1d3IepoUKWgVrkN3+FBoJDAmdrGB9d0GGAut+53b+410aepRLm8O59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504815; c=relaxed/simple;
	bh=/P6RowOz1b0vyseyrjEnqHcevhbD5nENbQPjjjlmckA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IWqGFjVgsQ9lHDjTG17WPRzDcU+qjg2xPK9UyAr+OaVEXSCygy7Ow7G29vFNxQgJ266erKYpYeYw/ClbDcdUZl2PohEnVVoy33wYr+3TcoddZXEWhADoNEO8R1+AQ8jPJUJ7Twa+noZQhBV68d7FedWWLEgzyJNTdtYh9f/A8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdQRQG/s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so26380005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504813; x=1757109613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAzCvl0ldkRzudSduBa+UTTFBtOSyy1B+vOLHTPWCIE=;
        b=fdQRQG/sMO0Qwf9P0XZfpDkSLEN3xLvQGGlAE1pjGq6G1qRGvgXxYxzOZUZrjKW36w
         79yZNYz37v68AnAK8wz831QH5hLOq6EuQO4ghMYwkw6gQoXtv0xsHguDerKTz7ZrNq7J
         JTitZ8cDXAkoS4pSxe7BoN3u4lgDBlsxFnDXGMVKwfvH7hzC48T0lnUDMle/Ec+MlXi/
         OvkITOTevgTzLLYos7IUTP3wUEY01l9Z/DPjAYqNmd8Qe/buLHaChL8lGaRmVmuh3nTm
         YyAp6V81pr6wq4A44Xc6PrAQFsjyrnr82XeRJEgfr90O1iA818zhn4gALFaKDfFGWVwD
         Op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504813; x=1757109613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAzCvl0ldkRzudSduBa+UTTFBtOSyy1B+vOLHTPWCIE=;
        b=om7uqztSyixuEb9houKrD4/xErFu9zQHaPWU/oyI8Zag0lKAp9AeIhF53uNFlwjlMz
         L59LQaexpdKTKkh+/r0jSDfTy3PxN0QwLF7QkBpDNvQClje+YRuW4gsuHYp2ZcDi+Cje
         4mTPxiSsmxyiEpU5Il+bFCiFruNAzuPYMwhh43DnZHcE6xTNmaGDUUGM0Q2N7gCsFFIs
         6xWzInRdRBYLo8BN8+uby/x3qH+Q0HOU3l0Xan8105S7ndmq7tBVwV72PRMH+iA7buOu
         D95vp8wL0y4zLgbDNKxeWVe7JPemPuwfFuK82N3ESdXTdVeHcBjtD2jCbOwWDwQZmFsO
         fGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOwWPtnBfgtTlcoRtRJLlt3UxdIkBJBab6CzsdDSB818vtS/XdgY+xLgEzOM9iSKc5EMiALTIWpC4KkZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycAKq4PiZbCebLxA4DxBPbumHnU7kAINAa3HG82jknFSqyd7hW
	l+Fb2Fn8pyIRZqCoP0T5iJZzjya7zxQIzGKKZZqM7OqTe8SvJ+Nu9MSCTAFyo5HEu994KAl5YJy
	AZb9Dv0hb9NIAAtjq4Usu3e6Jhw==
X-Google-Smtp-Source: AGHT+IEKrhZ3OKLQxYoEKQKZHhOayEYySIWPtx97dJ8GVIzQwF9KvqViD5qC8rCJdQxii7XJlUjw1LorWZiSeDav0A==
X-Received: from plcs9.prod.google.com ([2002:a17:903:30c9:b0:23f:df55:cf6f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120a:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-249448e65c6mr1874055ad.20.1756504813488;
 Fri, 29 Aug 2025 15:00:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 21:59:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829220003.3310242-1-almasrymina@google.com>
Subject: [PATCH net-next v1] net: devmem: NULL check netdev_nl_get_dma_dev
 return value
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
scenario that netdev->dev.parent is NULL, or all the calls to the
ndo_queue_get_dma_dev return NULL from the driver.

Current code doesn't NULL check the return value, so it may be passed to
net_devmem_bind_dmabuf, which AFAICT will eventually hit
WARN_ON(!dmabuf || !dev) in dma_buf_dynamic_attach and do a kernel
splat. Avoid this scenario by using IS_ERR_OR_NULL in place of IS_ERR.

Found by code inspection.

Note that this was a problem even before the fixes patch, since we
passed netdev->dev.parent to net_devmem_bind_dmabuf before NULL checking
it anyway :( But that code got removed in the fixes patch (and retained
the bug).

Fixes: b8aab4bb9585 ("net: devmem: allow binding on rx queues with same DMA devices")
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..779bcdb5653d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1098,7 +1098,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
 					 dmabuf_fd, priv, info->extack);
-	if (IS_ERR(binding)) {
+	if (IS_ERR_OR_NULL(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
 	}

base-commit: 4f54dff818d7b5b1d84becd5d90bc46e6233c0d7
-- 
2.51.0.318.gd7df087d1a-goog


