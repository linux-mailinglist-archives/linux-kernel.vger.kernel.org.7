Return-Path: <linux-kernel+bounces-850831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7ADBD4564
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF53E5EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BD314D00;
	Mon, 13 Oct 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHPXqlsQ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6579314A74
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367250; cv=none; b=Iojx7hDinKpsNQ4iSH0jK82o1LZ85jcFdyp8jP4/W3U6fvHxPPF6OER3L0ecb2bRMt8nvLLjpXMqqJTfyiYMJm17fe/WcjDzWVImA5Tr9v07LLwxRvirossntpCeCtGxMriMNom7AMweQO8fu7iyfN9pclXvo3db8Y+UMwC3AtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367250; c=relaxed/simple;
	bh=8nj7s55nWrv3kfW1Lj+b1IRgHimBBeikPlUQlGK/E9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YloQxqsqOIORKIDrrU+t/bhRBTC3+PTcgqlJ/p3A8AfH5V4qWzVS1srHVkA32iE1JSMr+JnF0gwFKW/l6MtQHi+AOm9cKgwqiqZlM10wEPKbe7eOMf4K97eJLwBqkcuWcvXfheeeMVtWm2QhdRYfBfcL/jzKTB+pPFWOpkEoGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHPXqlsQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3467446f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367247; x=1760972047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rMa+hYxMGJABpEUiqAoWqCld8h0vc8bkSgfbD76NHE=;
        b=mHPXqlsQr4UHdgi+7bVVHaCgbdxiNRDMqkMqr/BWvMoqSRzk/QiVccGwrwMkdh2JIb
         85/Rmd9DWwgwgrx8tBGG7e+xK3o7AaVxoeL2fJys2W4gBjUY5zZ8pKZlPQZ+V6fbN03W
         puI7FjVGPDYLGsL3Z92Xf9MNRW3TX7o+G77oqRC4ai4i9CLR6gEvfBDLuu3FyGKJxCK3
         YerGbQh0sUElOZbyOGL2qrkHw4InlHAH6ilqxu67NG6N3Wl/mEpyVbt7J4ymBlErop9O
         nhX9IpSMjyAm+Sj6m768qbBj76JFdFcdtUlXmJmItXojiMCm/kDjj5NuzAzC9KUo0c58
         KvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367247; x=1760972047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rMa+hYxMGJABpEUiqAoWqCld8h0vc8bkSgfbD76NHE=;
        b=eFMZuJVWuXF7u/lFP4oPFxROFIl1q3dFqA/6a69pWHgWtUqwxvZqS+L9VjC6mBR4Wh
         Zf6IWeZG2ll1E/0y1tsSgajadthSdHQfCo8KGncTbZDeTp0uC8vHt7AvYqRyGvVxm8BQ
         NelLxo03d5oHDiMMJ6YgLiNhzz839NltZ9OAFvWs/bZ7feuK8F5BL5u7MAmsrAuNAWUw
         ya6g4px5iisoH2kwox1LfDt95Y1Vcb2x9T8IEtoML2zFZ21hITUOqSTCdvDzYTUgiBUS
         /zzl7eq46xridvKGGH6PyLPKLQERLFZfDqt5iyyEYj1Ee4S8fDpz1yokHqzhukhP2BWB
         Zf6w==
X-Forwarded-Encrypted: i=1; AJvYcCXDXVso0qgbWEowafOXQNX5Kr5CAheTUPekl7WLyjlqP248gBpqxxpFtyt195AODe7oWvwRnqPOlqCloSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+f6KX0ZV1YQzC30CqnxLEKec8mOum4F2VXAZ5ge3rFfcs/qW7
	jHd8qcg8KXDjxfk8IdaJKL84nN4qmrwRtxwN3fOae8QN7yDmutqDyztE
X-Gm-Gg: ASbGncvKWfMPo6rtf9JXW8yOkUQe8BRyTbq5DznAfcqN3r9K6fpl22wYqo44zRv2Rl0
	pb3vbAgIs/sWWr7gfGBuGzsgYdpGPhtc5cZ7lvGj+AjDw2/ukLR0ubXwtyipCzf7CbJHhswNCRA
	cqWM/YS2aCk51rueh5GEh27kd7NBSnD5YD1ctozDaNtjoP10OW9T3mB+IngmTzixIjk+j27M4Rx
	HC2Du7E7nAdbyaBlmq0YXQWjHg6xa72PqEZ/jboneOMoqqjJYG8I1mBz1kDXu37+aTUFKVIHQKl
	fAMo7KzcJx6bINl4ZFD6UjntWIBjae1X2+kEIpePSfS+SvubRKjEUzwRobCPaJCBsR6vAOdaqYF
	3xMfdNHIIhVTHgGsN4fiEX1YxM/6hgsOKSPw=
X-Google-Smtp-Source: AGHT+IEpoY9zZ3UQGIBW1agBnvc5SnHYP477nBEWy4ZfZ4s18JUiHbQP7nwwR40939/5pAfGzkUEsg==
X-Received: by 2002:a5d:5d02:0:b0:425:7c1b:9344 with SMTP id ffacd0b85a97d-42666ab87c3mr12930214f8f.15.1760367246796;
        Mon, 13 Oct 2025 07:54:06 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:54:05 -0700 (PDT)
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
Subject: [PATCH net-next v4 24/24] net: validate driver supports passed qcfg params
Date: Mon, 13 Oct 2025 15:54:26 +0100
Message-ID: <bc5737ba2a1e5586408cd0398b2db0f218ed3e89.1760364551.git.asml.silence@gmail.com>
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

When we pass a qcfg to a driver, make sure it supports the set
parameters by checking it against ->supported_ring_params.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/dev.h             |  3 +++
 net/core/netdev_config.c   | 26 ++++++++++++++++++++++++++
 net/core/netdev_rx_queue.c |  8 +++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 63192dbb1895..96eae1c51328 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -103,6 +103,9 @@ int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack);
 void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
 				    unsigned int rxq);
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				 struct netdev_queue_config *qcfg,
+				 struct netlink_ext_ack *extack);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 2c9b06f94e01..99e64d942d44 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/netdevice.h>
+#include <linux/ethtool.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 
@@ -136,6 +137,31 @@ void netdev_queue_config(struct net_device *dev, int rxq,
 }
 EXPORT_SYMBOL(netdev_queue_config);
 
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				 struct netdev_queue_config *qcfg,
+				 struct netlink_ext_ack *extack)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	int err;
+
+	if (WARN_ON_ONCE(!qops))
+		return -EINVAL;
+
+	if (!(qops->supported_ring_params & ETHTOOL_RING_USE_RX_BUF_LEN) &&
+	    qcfg->rx_buf_len &&
+	    qcfg->rx_buf_len != dev->cfg_pending->rx_buf_len) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+
+	if (qops->ndo_queue_cfg_validate) {
+		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, qcfg, extack);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack)
 {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 5ae375a072a1..a157964cf60d 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -46,11 +46,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg);
 
-	if (qops->ndo_queue_cfg_validate) {
-		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, &qcfg, extack);
-		if (err)
-			goto err_free_old_mem;
-	}
+	err = netdev_queue_config_validate(dev, rxq_idx, &qcfg, extack);
+	if (err)
+		goto err_free_old_mem;
 
 	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
-- 
2.49.0


