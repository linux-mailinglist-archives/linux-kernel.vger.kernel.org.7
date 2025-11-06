Return-Path: <linux-kernel+bounces-889307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42256C3D3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B7244E5625
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315B355046;
	Thu,  6 Nov 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSexhXqE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAF34DCE0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457296; cv=none; b=RtldX3T6YIIXbdRvf9XhTk3E6Zcqt+p8clUrIXeimqZjVOJ8n0e8EwLr7JLko4JHtIFqethWet3BPfaoKx0kgCVpZpxTwrT0mviHvmrIe1Nycnt63DEcJ31emxzb/qgo8F58tJaL6o1Gi7PauyUcQWdF1QNH7btq8L5hCkkzy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457296; c=relaxed/simple;
	bh=iDX+Xjk6YPshtFGXJ/bFso821Raymie9r/DGYwcIVUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=baf9Azina3gdBvEu/kdusDwm7/kgmSlad45VAeWrlLmShgKkjr/KeflKHcPQV87honh+8W0TGev5y9T6Z5v2nqjKySTQgwZKpIZvWwIsILR/0uX9KlCLCPjfHw4BxRH4Sn0QUeKWQT6xM/cZ7ilvwijIcI09Q6qPOtCI7vK2j/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSexhXqE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baf262850so27528a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457294; x=1763062094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIN6Z9i91+duDdYVW8qK20gY3PDqSGvt0BSLKjqFHuw=;
        b=RSexhXqE0fInpyvdEwGWthH0Wn8vP8La8rCLhZnmhAGOJEjpmkQ/bUc3xdowwdKr+S
         WxTU9sISsMQMRRyfDKj4yOiyPLsDj+6P9aoXp1SfkKf/djgV7Ne9kn0IGnLdE37wt+Dc
         K6H6jNzxys/FWUd7eohVwW8+jdVzJC5eBtdPdpF1H/PHGle7bjVmCxz9DGFs+7ZD8r2m
         XGLaR8DWd+Mw110KD2kitRHUdz7fbEgMNgFQeIeNB7Fe7D33K7/k1y7ig5py639uMK83
         Y24CReCgUfdqycq16sQ2DYQDk9tyLEwpyK4JKc8MKkgz47xOw+hAATedHcp4aufCNBj8
         nW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457294; x=1763062094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIN6Z9i91+duDdYVW8qK20gY3PDqSGvt0BSLKjqFHuw=;
        b=MuY17ivvORE5twcDePw/S2lSYeQID8b8zAbCwz1qvYYZmSmRNYkiBKavV6VtsXNrGr
         J4lSYNAJFdjJZz/2nsHsIihZVaLuhSWfe6RX0kj5lOsggUuAYUOZszXDxKpSReRwJxeV
         JLJjMWrryYefUmaEYp6Ln4et81CknmTZZHuE5eDW5MiZqI/TO5h6+MvErU+lbSDvUzag
         kNkZB4AVIOFlAhVZJhn/3JEFsGRPOIkOkeNDb6mNdXQH6t4c/W4xOPRlujgucV5gspbK
         0WluBE4cFoVDVRwggCue2MpX0zRBUZ+PCG6nMUKorfyOomzmmxkz2PmwRZ+NXF0hzIxf
         DS/g==
X-Forwarded-Encrypted: i=1; AJvYcCXG7zVSvsivap/3VycqiSpDguVmeU67j6wsaedrYpjJzS7hqE2YIXLxlAIrO6x2QVJBh05L/6XBBFBWs7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLy9d6DWrQ9bV/b1wn+d/UlxE2jW2pmgN1h1fQsNa+yC1NENJ
	wknXf2/YWJPfSwe/CWVBdDdsSVBAskMTAoJG/MBMx34aL9cZZhnwB4On3jYQNAvIUDbKWc6SuCP
	CEzW1q4PiT8wWXw==
X-Google-Smtp-Source: AGHT+IE40sp+DzYKQD/+xYllnXpCS8xcKrLwbzO/rBj+3SuPPrgmpHyIs5cY0wvKNyo/ls3d26o2FlPqwqdiVg==
X-Received: from pjbfy4.prod.google.com ([2002:a17:90b:204:b0:343:4a54:8435])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:50cf:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-3434c577697mr370154a91.30.1762457293812;
 Thu, 06 Nov 2025 11:28:13 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:43 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-2-joshwash@google.com>
Subject: [PATCH net-next v3 1/4] gve: Decouple header split from RX buffer length
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

Previously, enabling header split via `gve_set_hsplit_config` also
implicitly changed the RX buffer length to 4K (if supported by the
device). This coupled two settings that should be orthogonal; this patch
removes that side effect.

After this change, `gve_set_hsplit_config` only toggles the header
split configuration. The RX buffer length is no longer affected and
must be configured independently.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  3 ---
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 --
 drivers/net/ethernet/google/gve/gve_main.c    | 10 ----------
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ac325ab..872dae6 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -59,8 +59,6 @@
 
 #define GVE_DEFAULT_RX_BUFFER_SIZE 2048
 
-#define GVE_MAX_RX_BUFFER_SIZE 4096
-
 #define GVE_XDP_RX_BUFFER_SIZE_DQO 4096
 
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
@@ -1247,7 +1245,6 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
-u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index b030a84..db6fc85 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -606,8 +606,6 @@ static int gve_set_ringparam(struct net_device *netdev,
 	} else {
 		/* Set ring params for the next up */
 		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
-		priv->rx_cfg.packet_buffer_size =
-			rx_alloc_cfg.packet_buffer_size;
 		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
 		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 347391a..453e40a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2041,14 +2041,6 @@ static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	priv->tx_timeo_cnt++;
 }
 
-u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hsplit)
-{
-	if (enable_hsplit && priv->max_rx_buffer_size >= GVE_MAX_RX_BUFFER_SIZE)
-		return GVE_MAX_RX_BUFFER_SIZE;
-	else
-		return GVE_DEFAULT_RX_BUFFER_SIZE;
-}
-
 /* Header split is only supported on DQ RDA queue format. If XDP is enabled,
  * header split is not allowed.
  */
@@ -2080,8 +2072,6 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 		return 0;
 
 	rx_alloc_cfg->enable_header_split = enable_hdr_split;
-	rx_alloc_cfg->packet_buffer_size =
-		gve_get_pkt_buf_size(priv, enable_hdr_split);
 
 	return 0;
 }
-- 
2.51.2.997.g839fc31de9-goog


