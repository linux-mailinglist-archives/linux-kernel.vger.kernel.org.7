Return-Path: <linux-kernel+bounces-812766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C0B53C63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6700AA5AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0F36CC6F;
	Thu, 11 Sep 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UmGb7TuY"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53B36C089
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619351; cv=none; b=TMXcQqAKJs/updTYDIN7faelmwOf+avirMgPQq019cs95fGpwRwbCMMTMyPjYMD5O9Rbruw/DylTpNQgm+sM/bR78ZVR+4xqAnrDyweKexD+loFyXP47gtCHqo0lHVNGQaNLEr9kXnEYmbE67s+5ndZHU68OFdLZ1BLwGWxqCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619351; c=relaxed/simple;
	bh=4O7YXPYOscA10Uk0DRt2hD3XYt1pHz59zrt+k3wOR1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzfQ9yOsdpx/8oqnArY4IgpCg5/h9GX0xsfkMqJXKyJUfHH/n4wBChGUpzBknvV1YM+eT9pCHU9vBc+DnOyNiXzAmr7UlkkzeJOiDOMDLKfs9tTx3aYvrd9yNt6I0EttyJ7w6xoZSNBUqJl5Iv4HihvTIDKfXEbRZ4TOBSSMuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UmGb7TuY; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso782854a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619349; x=1758224149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYijjwKvEWRUPax4vk/ZltD2SpKXNMlnN9psxeaWfbU=;
        b=t5WLGEQ+8T5nbQzM1hAi3w39Ru/ic44SWRgqT58hpJcIrc3nPGImjLq8uFEavy3r8v
         cKCmRamurbj5Sj9a6kLDB23tE1MhBUkK30oFil7xEPuQ/V+nizWCE+7XIdXPhYuogI6M
         sWMTE4thvgbuJj+42LRkvGZgamqsZIM2lW87FNHD94iSh4Z+Hf6jrA/U98g9dJHSR3WL
         0Svnsqp87a8MGesh7ehUbhXoz1jVoLU0FuePpfcOJe9aadyxHnvCA7Cq6LgzjJb9pYoj
         LrUliIkLAbHHJQTgYZ3e6baT0Z3XWN9arqpTe9SX65NP5sQLXpd6y4LTGrWgvcXT23oP
         H5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWLKtjnnkkiOSuWSwF2qfDTCsL80AcBjMKJV7ZcS8roOSmTsfw/33i7Wx5KXRWAhssE8bhOt+ETw7gLySs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrhjRq/oLWT2li9CzHHYXSMNjeRuLdBO0hzX60qBVUg6Rn9Gm
	veywdqUNH6ErFSqhShN16DwXo+8jmk52UJzAtKKpunkQULZpWcB5AeFLd/i3lUv1nwJ+s/avg3e
	41IIIXcZts+fmOfg6mtLnL0SjZA/6ZFGnhdnr3bx6CTZSXKKRhUcpGU6cormnZfzuu04n5Xdcvr
	nQjBwJEITe3ucGNJrdzx2iqm9J1v8RuUt4RTJfBzos5EkPewvi9voaRz0xteAshxzdtyg+PSRmq
	OrvTW4NHPdQCZnIL0tGd5tgRzFP
X-Gm-Gg: ASbGnctCKVw2f+g3jkIHZt5tGDAJuWQ4//GJLX5IISep+nmb+AzLdNWWlVOq+VLLpAS
	ma0AhG3WAB9XC5P8/sYpxmUl8trZa7cxgKWAlo+zkBPpGqtcYMUev/NxnSWaB90jk9VsUCXrqv6
	J7tBZUVdXTPWm6ySmmAss49r7GaLTq9tBKCOGu8qDb6zkpsnd3Kx2bGNLlI2BT0sVszPxih9wma
	O4tQBC0qjBFuaefqYjaGpIwAxx0f38WHsx7HVuGQwUhRKXDE1Lzy/ps+bJruWBW+sDp8XUGoltF
	uKRbKU2Lu06TWpvyBb9wsKnA2SPWBoWXNVQRaCrA826ZHxp+mPa5dewdnw+DxOds7i7mwNMtE6F
	DR/sZ+1Gx/ou8pMQzpCj2oGoZYUNKHAyIApB8SID3OuENyIqnqX+nh/4xZvpm0A4KJv2UcQjoVn
	KVxvMTnDxv
X-Google-Smtp-Source: AGHT+IFn2C68NSnPVrTLxyD60ALu6OZmFUwfAYjbnDkYhpPEVs9wbKYe05r1H3eG8ZCZcs78iV0mRsu7lAm2
X-Received: by 2002:a17:903:983:b0:258:b756:7db0 with SMTP id d9443c01a7336-25d278284b1mr4852285ad.54.1757619349215;
        Thu, 11 Sep 2025 12:35:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25c39f7ec06sm1963775ad.66.2025.09.11.12.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2507ae2fb0fso8989715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619347; x=1758224147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYijjwKvEWRUPax4vk/ZltD2SpKXNMlnN9psxeaWfbU=;
        b=UmGb7TuY8676UNuyBMGyfnkzqTbzfHYsMEOW6A2BmtCFn3+lS4RYN/nKFJaB6ptUWv
         YIlm/wEwrN7pl2ypNo5k2kf50syBOrM3N0Z9fvWeHT1+zzKGf0+L5bvodDtY0jnf7cYU
         /oaeig2Aceh0uETB9Xl+dJN0Nkyf+8P+S2JFI=
X-Forwarded-Encrypted: i=1; AJvYcCWCKH/+PuJPijR+me9e+X0yB+Fm7P17ieWkFr0WRCo0gzrQIbAo+mxQEVMkL2DdRtT+UnTYqZhhDTSPWdk=@vger.kernel.org
X-Received: by 2002:a17:903:4043:b0:246:9e32:e83a with SMTP id d9443c01a7336-25d271344afmr2990145ad.47.1757619347247;
        Thu, 11 Sep 2025 12:35:47 -0700 (PDT)
X-Received: by 2002:a17:903:4043:b0:246:9e32:e83a with SMTP id d9443c01a7336-25d271344afmr2989955ad.47.1757619346744;
        Thu, 11 Sep 2025 12:35:46 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:46 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v7, net-next 06/10] bng_en: Allocate packet buffers
Date: Fri, 12 Sep 2025 01:05:01 +0530
Message-ID: <20250911193505.24068-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Populate packet buffers into the RX and AGG rings while these
rings are being initialized.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 223 ++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 77bd8f6ce39..ee7cf8596cd 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -257,6 +257,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
 }
 
+static void bnge_free_one_rx_ring(struct bnge_net *bn,
+				  struct bnge_rx_ring_info *rxr)
+{
+	int i, max_idx;
+
+	if (!rxr->rx_buf_ring)
+		return;
+
+	max_idx = bn->rx_nr_pages * RX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
+		void *data = rx_buf->data;
+
+		if (!data)
+			continue;
+
+		rx_buf->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, true);
+	}
+}
+
+static void bnge_free_one_rx_agg_ring(struct bnge_net *bn,
+				      struct bnge_rx_ring_info *rxr)
+{
+	int i, max_idx;
+
+	if (!rxr->rx_agg_buf_ring)
+		return;
+
+	max_idx = bn->rx_agg_nr_pages * RX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		struct bnge_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_buf_ring[i];
+		netmem_ref netmem = rx_agg_buf->netmem;
+
+		if (!netmem)
+			continue;
+
+		rx_agg_buf->netmem = 0;
+		__clear_bit(i, rxr->rx_agg_bmap);
+
+		page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
+	}
+}
+
+static void bnge_free_one_rx_pkt_mem(struct bnge_net *bn,
+				     struct bnge_rx_ring_info *rxr)
+{
+	bnge_free_one_rx_ring(bn, rxr);
+	bnge_free_one_rx_agg_ring(bn, rxr);
+}
+
+static void bnge_free_rx_pkt_bufs(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->rx_ring)
+		return;
+
+	for (i = 0; i < bd->rx_nr_rings; i++)
+		bnge_free_one_rx_pkt_mem(bn, &bn->rx_ring[i]);
+}
+
+static void bnge_free_pkts_mem(struct bnge_net *bn)
+{
+	bnge_free_rx_pkt_bufs(bn);
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -737,6 +807,156 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 	}
 }
 
+static netmem_ref __bnge_alloc_rx_netmem(struct bnge_net *bn,
+					 dma_addr_t *mapping,
+					 struct bnge_rx_ring_info *rxr,
+					 unsigned int *offset,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	if (PAGE_SIZE > BNGE_RX_PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     BNGE_RX_PAGE_SIZE, gfp);
+	} else {
+		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+		*offset = 0;
+	}
+	if (!netmem)
+		return 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + *offset;
+	return netmem;
+}
+
+static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+				struct bnge_rx_ring_info *rxr,
+				gfp_t gfp)
+{
+	unsigned int offset;
+	struct page *page;
+
+	page = page_pool_alloc_frag(rxr->head_pool, &offset,
+				    bn->rx_buf_size, gfp);
+	if (!page)
+		return NULL;
+
+	*mapping = page_pool_get_dma_addr(page) + bn->rx_dma_offset + offset;
+	return page_address(page) + offset;
+}
+
+static int bnge_alloc_rx_data(struct bnge_net *bn,
+			      struct bnge_rx_ring_info *rxr,
+			      u16 prod, gfp_t gfp)
+{
+	struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
+	struct rx_bd *rxbd;
+	dma_addr_t mapping;
+	u8 *data;
+
+	rxbd = &rxr->rx_desc_ring[RX_RING(bn, prod)][RX_IDX(prod)];
+	data = __bnge_alloc_rx_frag(bn, &mapping, rxr, gfp);
+	if (!data)
+		return -ENOMEM;
+
+	rx_buf->data = data;
+	rx_buf->data_ptr = data + bn->rx_offset;
+	rx_buf->mapping = mapping;
+
+	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
+
+	return 0;
+}
+
+static void bnge_alloc_one_rx_pkt_mem(struct bnge_net *bn,
+				      struct bnge_rx_ring_info *rxr,
+				      int ring_nr)
+{
+	u32 prod;
+	int i;
+
+	prod = rxr->rx_prod;
+	for (i = 0; i < bn->rx_ring_size; i++) {
+		if (bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL)) {
+			netdev_warn(bn->netdev, "init'ed rx ring %d with %d/%d skbs only\n",
+				    ring_nr, i, bn->rx_ring_size);
+			break;
+		}
+		prod = NEXT_RX(prod);
+	}
+	rxr->rx_prod = prod;
+}
+
+static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+{
+	u16 next, max = rxr->rx_agg_bmap_size;
+
+	next = find_next_zero_bit(rxr->rx_agg_bmap, max, idx);
+	if (next >= max)
+		next = find_first_zero_bit(rxr->rx_agg_bmap, max);
+	return next;
+}
+
+static int bnge_alloc_rx_netmem(struct bnge_net *bn,
+				struct bnge_rx_ring_info *rxr,
+				u16 prod, gfp_t gfp)
+{
+	struct bnge_sw_rx_agg_bd *rx_agg_buf;
+	u16 sw_prod = rxr->rx_sw_agg_prod;
+	unsigned int offset = 0;
+	struct rx_bd *rxbd;
+	dma_addr_t mapping;
+	netmem_ref netmem;
+
+	rxbd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bn, prod)][RX_IDX(prod)];
+	netmem = __bnge_alloc_rx_netmem(bn, &mapping, rxr, &offset, gfp);
+	if (!netmem)
+		return -ENOMEM;
+
+	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
+		sw_prod = bnge_find_next_agg_idx(rxr, sw_prod);
+
+	__set_bit(sw_prod, rxr->rx_agg_bmap);
+	rx_agg_buf = &rxr->rx_agg_buf_ring[sw_prod];
+	rxr->rx_sw_agg_prod = RING_RX_AGG(bn, NEXT_RX_AGG(sw_prod));
+
+	rx_agg_buf->netmem = netmem;
+	rx_agg_buf->offset = offset;
+	rx_agg_buf->mapping = mapping;
+	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
+	rxbd->rx_bd_opaque = sw_prod;
+	return 0;
+}
+
+static void bnge_alloc_one_rx_ring_netmem(struct bnge_net *bn,
+					  struct bnge_rx_ring_info *rxr,
+					  int ring_nr)
+{
+	u32 prod;
+	int i;
+
+	prod = rxr->rx_agg_prod;
+	for (i = 0; i < bn->rx_agg_ring_size; i++) {
+		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_KERNEL)) {
+			netdev_warn(bn->netdev, "init'ed rx agg ring %d with %d/%d pages only\n",
+				    ring_nr, i, bn->rx_agg_ring_size);
+			break;
+		}
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+}
+
+static void bnge_alloc_one_rx_ring(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
+
+	bnge_alloc_one_rx_pkt_mem(bn, rxr, ring_nr);
+
+	if (bnge_is_agg_reqd(bn->bd))
+		bnge_alloc_one_rx_ring_netmem(bn, rxr, ring_nr);
+}
+
 static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
 {
 	struct rx_bd **rx_desc_ring;
@@ -799,6 +1019,8 @@ static void bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
 			     &rxr->bnapi->napi);
 
 	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
+
+	bnge_alloc_one_rx_ring(bn, ring_nr);
 }
 
 static void bnge_init_rx_rings(struct bnge_net *bn)
@@ -1106,6 +1328,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


