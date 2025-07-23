Return-Path: <linux-kernel+bounces-743286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3588B0FCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6EB587999
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535127146E;
	Wed, 23 Jul 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBrjVNcP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A7273D90
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309714; cv=none; b=G2haouu718GRy2RfVA+ek3pahsAj4n7mosIY9JSMpZQSrauSWyGybYJKHhxWjwEmICYw9f26bFltz/Sb9OKf0qK5y9sCIfFOJHvQz6ftLLqHTcj9x8PODmOdjaLJguIUOOj01oWKW0eM6wxURpPHJ/T6CHA4yVnOaLp9S7MhoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309714; c=relaxed/simple;
	bh=VvUDt6FWFoyoDIDged2fZ1ZVOvIafQIneLMPsAZxYGs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qd+sgN+sHrpreCE3tsQt8+KANsJauPjcPWSxNqa+6xh1mNAAmQbG7yCMweBYJ/84TN/Lxm0nK0RSaQ4gec9j5K6CeRSQZqHyUQIuALtWwsyf+v9OA07fQijevtWMfVAzzXu1zjps3TTeHPBtbS9yaDnxUExGaIqJN5SVeu6kEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBrjVNcP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso283760a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753309712; x=1753914512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=maxoCoCzZYBwjX5BKP0pvsUFSndKViTHC8/D3FpCBB0=;
        b=LBrjVNcPtjzrPzpYwZtLwa3EPmZhQmWWQnPzuLq52zGauBkbW9ShWruo6wy214sxWf
         bxCb5qavvd9CC7PWSZido5cPPxMIiLGn/tnZICfj6B/xpcMT3wLsV8jEkXflpjAEKRsJ
         gULignJwl9x+nx6qKaoorm/K0WkU97+Te5LPHjjU8qX1P2/MYrA6/OvasgJWYL8/DTP4
         Epj6X5uRa9xdnh9eQ2FmH9JkOe2HEPtZ6y5ESg5JEeTW/QbNIRE3Vt1RgzhmS7YpcKd/
         DJCavZ+NltENwZHjAgDKbIYXxPpOX/snSdnK8sQ5/VVxICNVHSxm2lvojzscto8ZK/xy
         nEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309712; x=1753914512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maxoCoCzZYBwjX5BKP0pvsUFSndKViTHC8/D3FpCBB0=;
        b=dlrseWmhIy5hWkMLNoOvpSmnECAbKGcvMhAZX+CbXeQ6/u+Ydf1GlZ3ye4M4h30SlE
         MqnbgTeMDe68gfoS5CyHwlaQMSs7zHSI7N5dXRsfayDLcBN/BpZ2+qDOz3jO0N0dCWS/
         yVOCS4DPeEEEf8cPcZq30QUQgmti032h/Y3B7B3X6zfxK0xmbve3JKsiLg8sGpyoVDZp
         qyY0hMzLjMVydCoBSw2pKuZPINqV+TAae2EJZfV9fRwcNofoHpda7hB6Mw+8dKfEphJ0
         Vshj44vPFFJ6AMGIt0XHNJuclaql4O5Mf/VF366UiMtcW/HtAmtf7mAl1LWrdNIxgVat
         EI/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQNlvA+Gz7xoDzZB6V+OiM0Fv+ymXTpMkxQsQJnTC3jnMUEKmhe1qxNFBqhLBIsQ3tYspNenUcX+H0dn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEin0ICM/SGTVI2WHLu1tf+ugDp3lUZrJx2cuGmy76cqj4L46
	VCEjQXnIcvcgIBm5RSytxEp9THZrgV3hD6T3TK5iq0g3lePuk3phFFjeqtq9WMxF5IHxr2FRca1
	V2ksBA/+zOjyQNg8LTkhG2D02Ng==
X-Google-Smtp-Source: AGHT+IFxGNtqJ26mBeUuULBu7HleUmr3O2AVx8P8w6Q3+FKJVsiAhBbN7BqUKAMBmasnh+F58Ye1cOC9ZU84HvXLrg==
X-Received: from pjwx11.prod.google.com ([2002:a17:90a:c2cb:b0:312:e266:f849])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e183:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31e507ce7f7mr7052868a91.27.1753309712524;
 Wed, 23 Jul 2025 15:28:32 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:28:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723222829.3528565-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: support unreadable netmem
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mina Almasry <almasrymina@google.com>

Declare PP_FLAG_ALLOW_UNREADABLE_NETMEM to turn on unreadable netmem
support in GVE.

We also drop any net_iov packets where header split is not enabled.
We're unable to process packets where the header landed in unreadable
netmem.

Use page_pool_dma_sync_netmem_for_cpu in lieu of
dma_sync_single_range_for_cpu to correctly handle unreadable netmem
that should not be dma-sync'd.

Disable rx_copybreak optimization if payload is unreadable netmem as
that needs access to the payload.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  5 +++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 36 ++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 8f5021e59e0a..0e2b703c673a 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -260,6 +260,11 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 		.offset = xdp ? XDP_PACKET_HEADROOM : 0,
 	};
 
+	if (priv->header_split_enabled) {
+		pp.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+		pp.queue_idx = rx->q_num;
+	}
+
 	return page_pool_create(&pp);
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7380c2b7a2d8..8c75a4d1e3e7 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -718,6 +718,24 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_dma_sync(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state, u16 buf_len)
+{
+	struct gve_rx_slot_page_info *page_info = &buf_state->page_info;
+
+	if (rx->dqo.page_pool) {
+		page_pool_dma_sync_netmem_for_cpu(rx->dqo.page_pool,
+						  page_info->netmem,
+						  page_info->page_offset,
+						  buf_len);
+	} else {
+		dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
+					      page_info->page_offset +
+					      page_info->pad,
+					      buf_len, DMA_FROM_DEVICE);
+	}
+}
+
 /* Returns 0 if descriptor is completed successfully.
  * Returns -EINVAL if descriptor is invalid.
  * Returns -ENOMEM if data cannot be copied to skb.
@@ -793,13 +811,19 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
+		   netmem_is_net_iov(buf_state->page_info.netmem)) {
+		/* when header split is disabled, the header went to the packet
+		 * buffer. If the packet buffer is a net_iov, those can't be
+		 * easily mapped into the kernel space to access the header
+		 * required to process the packet.
+		 */
+		gve_free_buffer(rx, buf_state);
+		return -EFAULT;
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
-				      buf_state->page_info.page_offset +
-				      buf_state->page_info.pad,
-				      buf_len, DMA_FROM_DEVICE);
+	gve_dma_sync(priv, rx, buf_state, buf_len);
 
 	/* Append to current skb if one exists. */
 	if (rx->ctx.skb_head) {
@@ -837,7 +861,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		u64_stats_update_end(&rx->statss);
 	}
 
-	if (eop && buf_len <= priv->rx_copybreak) {
+	if (eop && buf_len <= priv->rx_copybreak &&
+	    !(rx->dqo.page_pool &&
+	      netmem_is_net_iov(buf_state->page_info.netmem))) {
 		rx->ctx.skb_head = gve_rx_copy(priv->dev, napi,
 					       &buf_state->page_info, buf_len);
 		if (unlikely(!rx->ctx.skb_head))
-- 
2.50.0.727.gbf7dc18ff4-goog


