Return-Path: <linux-kernel+bounces-850821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BDBD3E76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D291889716
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9682312834;
	Mon, 13 Oct 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwgEaukU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABE3126B7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367232; cv=none; b=LwmI9lGBuJOMsREJLwAYdtVeuIFtnlHb0D1IDNumeTHBbcABkrmNaIQziH5kImC/cnRsofioO+m8kS2HmQMMkx02uV8AWcGR3FDNG+oUwdS133Nm50h0eFHqHdwkhAM4l+lI2UqhrwU+xHYWyGd86I4h+pai5xtZirXW7g868Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367232; c=relaxed/simple;
	bh=D68sIcGcW8AD97DUUABnw+4SAHYdP99w8kG7MJxPpuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQOlI5QTC44lIRo102rzNnbLnfvq+qCwGN50ppSv4lKvFnOgl/1j824A/G3Byyl3WwbbEvP0GY10Wh7k6jMbEyE3e2hDdz3GHIX4eAM6TguHWGiKaIha1GLsdNMN0786FqZHXpXz6Xeb0sVDv6YHcXuTlAEHtzvWNEHvcLKdz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwgEaukU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b303f755aso37499395e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367228; x=1760972028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=fwgEaukUjhYVnmQ8AVW6BNlVQE0cMo3BWtp7IVfC1O9B0iLe1lhk8FxlPVq1fTRKyb
         pBz4705SNJ6SLjEATAjDzJVeK4rsXJcyRUwRkyQ9F0h2mV/D8f+uBF/vNIMLlOu9LK3A
         alb0iAvwxGsR43s6gCBb6VGXijw46omDMwcUd7DzijeTnXsWuAnI2Rc6KsPEmxvhjgV4
         xK40mJjVCKZEXies9kmVueGSl0BcuIArtqE429PstvO2mFo7/HdoYdNJEZFi4aDJC3wC
         0yXeBoiQxfhgRE8I3sroNOFrYTfjIa6k/VY/L8xbiCb6hEUgapWQc7FQDuj3CJP2XO+e
         3Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367228; x=1760972028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=WuIPRY86CRvBiDwkUWIHS+qZHTrQN2CyR1RDF7tCzf/YN4KdbPWTDjnHANNLop3hmo
         4mJeWwU81btbzedWnIkPAcM8PFNEVPp3cwW/dXq5JISof1/hwp6NYTnioT/Ng4AhxsZ6
         tSytjWVSVSKHQJ5jX5kvMmVpXk97yr25CL5V3/8ZgwlgTiYz4vYQQLGAKFbGgK150CqE
         rE/2Nadmq6mJxSMaGsgsBQNJkdc0lnRsdb2MhzOnhPhKn3UzuCnW4mYEg0AwU8QBVet+
         4xDH0qFvvRJSViPsMPZzfT7XazqXBcieEAGj8geFpDY4zp0wc8/OXVYXu24w8jic58hu
         D8zA==
X-Forwarded-Encrypted: i=1; AJvYcCXNUK9A6PjrHuefQNlnxSL7dSdkDsBvZVyOQ1lVED21ptiGNW8vlihm+pUapsfXsDkY0w0SEnUbJdS1avA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAAN26MT0Sz7KPIHye0opNXQsY8jCqamGnH2uJRz9IcUb7HHD
	7VCBVhHxgwx1Vs2w0MX4eVru0R3f2Kxnoeef3V8otrUXUpjTTpkJHhBy
X-Gm-Gg: ASbGncti7SmoTN/2L9q/S1OX4HW6Y1IoV3ozrHo8xUcifvYXAV0QMeosxVLc7OA3q+z
	YqChi++aPcXfIya1rpXLDoH1yZeftS99zBvqJIV8cUiGRTS072OtCHs2VmDHbufNxexbSuLV+6U
	Q1MC7oEh645a4dSs87h1HCMBazfk4optCs1Sxb6OUFTtJAGMIxOdLMAqYulu1gh/xq8kcUj5NJU
	BBNUI1UwO40PmKKSA/M4tYVVK0XcJ6Y9R+mJsC2zEY3RWjvNpsBTj9F8HAe6fofLd+reaFNv+F6
	t5uLNI4gRgtSK1RL1M00lPsqVAvFlmG+1pSC+aKaJiqozWDhKZ8Yk36v+chc6azbOA/A6bWnTbp
	r0EeQmKhhJti5kX4oKvi3YWfn
X-Google-Smtp-Source: AGHT+IGhdCNMbexhcA+WKt1V3KL/FuPKgFmigZrXjQ1ZszoP38SE47hCNbYpQqpsjRmxatSSV4+luQ==
X-Received: by 2002:a05:6000:4b1a:b0:426:d818:e46a with SMTP id ffacd0b85a97d-426d818e49fmr5836115f8f.60.1760367228006;
        Mon, 13 Oct 2025 07:53:48 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 14/24] net: pass extack to netdev_rx_queue_restart()
Date: Mon, 13 Oct 2025 15:54:16 +0100
Message-ID: <c7bc7d4cb8e3dd6b13f044495ed9efef8aab294b.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/netdevsim/netdev.c            | 2 +-
 include/net/netdev_rx_queue.h             | 3 ++-
 net/core/netdev_rx_queue.c                | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d7a9d5bc566..61e5c866d946 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11570,7 +11570,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr, NULL);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 032ef17dcf61..649822af352e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -886,7 +886,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	}
 
 	ns->rq_reset_mode = mode;
-	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ret = netdev_rx_queue_restart(ns->netdev, queue, NULL);
 	ns->rq_reset_mode = 0;
 	if (ret)
 		goto exit_unlock;
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..a7def1f94823 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -56,6 +56,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index f6a07fccebd1..16db850aafd7 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -19,7 +19,8 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
+			    struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
@@ -143,7 +144,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 #endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx, extack);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -186,7 +187,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, ifq_idx, NULL);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.49.0


