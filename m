Return-Path: <linux-kernel+bounces-889309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A61C3D3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BADBB4E5D51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F23563D1;
	Thu,  6 Nov 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nuipWcF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533403557F6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457300; cv=none; b=A+K3d1bQPmOBqAa2X3yUMZ/AYsm8+eCeiIT8HehB/4mc9vQ0hSqmWY5DBM2XlZIt0jdHz27HP6akjxPAHHUOo8rDACw3L6GQyLxspaMxd/4VlB7qgrqg6zSVRgvKIP/ltxRNGTL4WK3umTMAsJwxpfROP89ClfS1/7cibLCs9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457300; c=relaxed/simple;
	bh=Xb4EfJdY6bPJY5RRiIfdF/NTZ7iibhgTGr5o3oPF3g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aeQLfULt5oJo6BO59pyuelCajd9VkxI/Hv9srPyrKvxZiEAXOBgiP+GHxFUH+PLTXJs6213SdETD4CDv5Hu6iNgTXSWcUONC3PaK7JGwxiB9kbe3/fnO8r3B6KQwRESWOUQ6+471tAq+BOD0vhZbcr3vYE33xXwv7RX3trJKdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nuipWcF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso10459a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457297; x=1763062097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=2nuipWcFo49jIv9Iv2llln7A70bCFjYdz1Bk3nKkpbomUK6i9r7zGcu8Mnb2V2xEWc
         zm0kTah+sYnHqcHtXwnoFjhc7Yt4aYMn600D2awCjouzJeM2GaIhCcr3tAMAOpH0ynA5
         p46QszYhZExLydXFxfMgmFdigKiSkHEMEwpUklO8cCDjbhlbaxuc0k97Eqn57rC+uSZS
         eXJCMK6plNOtoo8IlQInP+BTv+huvLYZPVl9NNDe6SJ6rEMNO1u+l1vf+bYVdkuqZslP
         r3aGFKnhMN9Z0PnXsRLPYA/59TewJ0/OxtnfEfjfpPxiBk4EzV6zgeMK+xy7sANsGewe
         N/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457297; x=1763062097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=OgPMx8rQWezoLCttrt29Tt3lcqCGgaBa4qByvr5fkdmgqWt+PShkBfvWKEXVPEsfl4
         vINL+rnwoOi7ffMbqblCIH6LPs681gq205oc10QL+f8he3nbjGSSuhOgKTMat68s818w
         cPU/6VfqgNTQpFSEVHhFfQx9b/Juf4+QOA6L6EMKSiHnybdp1pU2gs+bzvl4XfXtJ/ZO
         hb8WkHYEcYVBOW8Ag4CneWuxZ/YQEG8Z0Nh5aF77MN7KM0hs09eYGVHHtEHIVahnhrRt
         SjHp2P4HdpF/4BG3sQKR0sgLNkxvcbTyk5x5w2WH7Xh0c2+Wg+/4w/1AUMy5Bu+9rWWa
         zc/g==
X-Forwarded-Encrypted: i=1; AJvYcCVEM2Uy1Zd+8b9ohBJoAzFQJd7Rj48mseLgVX0cd+8Q57lZb1EV6eVfA2NFI9yPUNSsO8O/x3whOSWQMiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsAtgQXHcxByHRouLCcDgCCAki0+QEaaspRKyczZrCA/mSipt
	QNntnkGFLi62+tYUim7HU0HwLT1eUawVIWZt2YtVakwBAGVFCAL1dr4pcJFFMHeEfk1A7VH8KpS
	KRcHfB0xD7a4kDQ==
X-Google-Smtp-Source: AGHT+IHGM7JVCPtaPwEFgfbgQR8t2tAo11fskdg8fmXe8PTIoLmsll2rbUTNi7cuelWzWi1tOatyEbKa4QTqwQ==
X-Received: from pjty1.prod.google.com ([2002:a17:90a:ca81:b0:33b:51fe:1a89])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3885:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-3434c4fa855mr370694a91.14.1762457297556;
 Thu, 06 Nov 2025 11:28:17 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:45 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-4-joshwash@google.com>
Subject: [PATCH net-next v3 3/4] gve: Allow ethtool to configure rx_buf_len
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
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
2.  In `gve_set_rx_buf_len_config`, rejecting buffer length changes if XDP
    is loaded and the new length is not 2048.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
* Removed newline from extack messages (Jakub Kicinski)

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
+				       "XDP is not supported for Rx buf len %d, only %d supported.",
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


