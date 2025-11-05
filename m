Return-Path: <linux-kernel+bounces-887109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127BC374B1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C111A20FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF072BD597;
	Wed,  5 Nov 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2J3bPEJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB278299A87
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367186; cv=none; b=SfMmiDKAqWp+PiqhiImBaOm62DyqKXRoq8MMTJsDFs+Yr2lHqyKaDj6XjINZCIwjtr+be0IczGew+ozkO3qz311xFWowVN0jxm3HlQyFLKtrK/7Swd2q8UXcGlRJ5uCihuA/ZYYEMJuxuRf28KuWRaf18lFX/461Hp6JQh4o8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367186; c=relaxed/simple;
	bh=+AIABo2PkfWKFZR1x0fGZjz0ONmonDPl4r98ftHTv3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nSAoy0Ny7U9VM0wMQQIrsu4xBcBgd4/+ZBrOhHe6kzleuRnnLAyr9utghPqhyTuyzXeMdoaHdi/Ncepca+h5LZgAuNOI7wqRHtAL88PvfeTGzwNchU/taYC4WZLGCqwGPP+tUpbIPsMoVD6w0R2/0A6VBLEKoYMEj4ovMMmexOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2J3bPEJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3407734d98bso186541a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367184; x=1762971984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo7vE6RiW6/08n7eSV8+kI339/dOO29zkRCIpRjmsrU=;
        b=p2J3bPEJWLZ6NUOy2beKDQ13VJm5LQ2kYjeX1d+vNXV57bHx5aPDdiwDdxxWHOTcef
         ncUnDrXWCYSRsktFZvnosZW2OK6x/G7/upq79S6IzmWbnApsBA+Wvuq7KnXTTk0q47ON
         4Vvnxf1Lf9++0TAs4YaIJj4snqFG6wXTSlIYljMzgGC4BM/cOIYuiUzBq/0yyZ+QQ3yo
         eBhb9JT8URzMUcMN6Chy5yqpVUBwlEFUtMdFnoS7DDfrpuLSl5eGZ064anqNNG+uFT+h
         Xi03U8FjoD5/x/bIPMqNtAZXcBYcvWnfMxciUcDYVxrCOoBEWwcapB0T8qZR2ynZTST2
         Qp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367184; x=1762971984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo7vE6RiW6/08n7eSV8+kI339/dOO29zkRCIpRjmsrU=;
        b=AX41P/U6eh8Ey6F1vh6R3lYQsT2DPUZg3JyBZ56KcyEDjojjkS5QW5SpdhrrRu/KSP
         ha/wZfYt8xQ+SrY+C2LsUbTwbzMsSMBdsTM3rAjxEZtNWob4EKYUTWWL6vf5eJOnv/k1
         nhlwwngpPdH/sB0tzCs+K1sKJT4qd4wsvXuhXnZ9Gw9opllmTR1lgfXsP1kd3bAQ+8KI
         k9d/YvpH5UBy7jTiTxgxPavOggvVJHpRaLwAnfW7VXBMbYW8VxqdIGvqlsCeZc8zgFvR
         cbVUDRzN5JfkXsLw7rlAo3xwCD/V8i888QM8WAM+edSs2FR2q8QJvs6p5wkT2P3VZVou
         0xJA==
X-Forwarded-Encrypted: i=1; AJvYcCVj5rKChSknyt97Oou38jbReJIMXYWZBE56F/36kxIzhtq5EP4EJd2aGazjXH422pwbnmhAW/+wYMQfzxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eVcm3400j5uStLDiSr0ZYx5ucSG9y9QWYBHcwQRYjL6KMZVL
	+exZVDTuAGLJw/UeJ/qmMkksBCzhvboMoB+L6M+4+XsnmEBPrdtfgeHECAAG5BzVRHAMZjwsET1
	hBuFnBeog7OD/Sw==
X-Google-Smtp-Source: AGHT+IGEIz0cx3bEItvXyAT1JAvBIFiUAM6WpNdyYKcNZr5SJsgq1W3uSlW55d+rZlVRcw7kx+odRogiec5A4w==
X-Received: from pjdr5.prod.google.com ([2002:a17:90a:2e85:b0:340:bc7b:2b2f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4acf:b0:32e:3552:8c79 with SMTP id 98e67ed59e1d1-341a6defc72mr4777964a91.29.1762367181865;
 Wed, 05 Nov 2025 10:26:21 -0800 (PST)
Date: Wed,  5 Nov 2025 10:26:02 -0800
In-Reply-To: <20251105182603.1223474-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-4-joshwash@google.com>
Subject: [PATCH net-next v2 3/4] gve: Allow ethtool to configure rx_buf_len
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Add support for getting and setting the RX buffer length via the
ethtool ring parameters (`ethtool -g`/`-G`). The driver restricts the
allowed buffer length to 2048 (SZ_2K) by default and allows 4096 (SZ_4K)
based on device options.

As XDP is only supported when the `rx_buf_len` is 2048, the driver now
enforces this in two places:
1.  In `gve_xdp_set`, rejecting XDP programs if the current buffer
    length is not 2048.
2.  In `gve_set_rx_buf_len_config`, rejecting buffer length changes if
    XDP is loaded and the new length is not 2048.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v2:
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve.h         |  9 +++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 ++++++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 872dae6..bebd1ac 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1165,6 +1165,12 @@ static inline bool gve_is_gqi(struct gve_priv *priv)
 		priv->queue_format == GVE_GQI_QPL_FORMAT;
 }

+static inline bool gve_is_dqo(struct gve_priv *priv)
+{
+	return priv->queue_format == GVE_DQO_RDA_FORMAT ||
+	       priv->queue_format == GVE_DQO_QPL_FORMAT;
+}
+
 static inline u32 gve_num_tx_queues(struct gve_priv *priv)
 {
 	return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;
@@ -1246,6 +1252,9 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 bool gve_header_split_supported(const struct gve_priv *priv);
+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 /* rx buffer handling */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index db6fc85..52500ae 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -529,6 +529,8 @@ static void gve_get_ringparam(struct net_device *netdev,
 	cmd->rx_pending = priv->rx_desc_cnt;
 	cmd->tx_pending = priv->tx_desc_cnt;

+	kernel_cmd->rx_buf_len = priv->rx_cfg.packet_buffer_size;
+
 	if (!gve_header_split_supported(priv))
 		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
 	else if (priv->header_split_enabled)
@@ -589,6 +591,12 @@ static int gve_set_ringparam(struct net_device *netdev,
 	int err;

 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+
+	err = gve_set_rx_buf_len_config(priv, kernel_cmd->rx_buf_len, extack,
+					&rx_alloc_cfg);
+	if (err)
+		return err;
+
 	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split,
 				    &rx_alloc_cfg);
 	if (err)
@@ -605,6 +613,8 @@ static int gve_set_ringparam(struct net_device *netdev,
 			return err;
 	} else {
 		/* Set ring params for the next up */
+		priv->rx_cfg.packet_buffer_size =
+			rx_alloc_cfg.packet_buffer_size;
 		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
 		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
 		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
@@ -944,7 +954,8 @@ static int gve_get_ts_info(struct net_device *netdev,

 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
-	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				 ETHTOOL_RING_USE_RX_BUF_LEN,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c1d9916..2a24b3a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1725,6 +1725,13 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}

+	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "XDP is not supported for Rx buf len %d, only %d supported.\n",
+				       priv->rx_cfg.packet_buffer_size, SZ_2K);
+		return -EOPNOTSUPP;
+	}
+
 	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
 		max_xdp_mtu -= GVE_RX_PAD;
@@ -2056,6 +2063,38 @@ bool gve_header_split_supported(const struct gve_priv *priv)
 		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
 }

+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	u32 old_rx_buf_len = rx_alloc_cfg->packet_buffer_size;
+
+	if (rx_buf_len == old_rx_buf_len)
+		return 0;
+
+	/* device options may not always contain support for 4K buffers */
+	if (!gve_is_dqo(priv) || priv->max_rx_buffer_size < SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Modifying Rx buf len is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (priv->xdp_prog && rx_buf_len != SZ_2K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 when XDP is on");
+		return -EINVAL;
+	}
+
+	if (rx_buf_len != SZ_2K && rx_buf_len != SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 or 4096");
+		return -EINVAL;
+	}
+	rx_alloc_cfg->packet_buffer_size = rx_buf_len;
+
+	return 0;
+}
+
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
--
2.51.2.997.g839fc31de9-goog


