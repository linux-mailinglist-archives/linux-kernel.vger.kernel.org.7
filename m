Return-Path: <linux-kernel+bounces-803450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A49B45FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AE15C492C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25B374281;
	Fri,  5 Sep 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JLQ7Poyc"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FD37428F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092844; cv=none; b=YhWN0vAlqncleUbh6biYAHhbRdPzpGEiAQvYZy4D6H4ohjO3MVt9PxQFTFaOvYhxDQAyqFxsHMseANfN4eYpvBermnq8SPqs75r7ivh1FBt/R5XKDWkglMndO2svRCVmMls7cFDTs8NjAro2RBXF6a0wOIkTGuGDx9zjy174i64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092844; c=relaxed/simple;
	bh=zO5AUhiyBcaDn20NMDzr0lBMIQ5fea78M6A8WTV5ik8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/dRaY3kWT6TfNPyRd0Vw7FeexIwX0VfbA9QAmOGRbv3duLLn3lzcAG14SMkEeR9Wb1o8h13iHMoLbNmxCyj7JW/hRtnI4TmIodj5a8e+aIa4spwEvffUVZptyCT62ch1oDJnpSezefLnpwAQqjPgNHa9uWPrU8+bMF/BZyCTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JLQ7Poyc; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3f05a8fa19bso25317755ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092841; x=1757697641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPtLPCbW9cI52nHjoIxx9FA19cFt1KOBK+vvcRFUVCI=;
        b=E3GVzJfD49ELO+CcbbOf3pZu8mrpTqfVfNc9ZrU1UJUaX9tXWNX8SYy38MjNAuQOVC
         oL1NlCJIdo8mIZZVDCwX+uKhMA0aSA+MQekT/jehuHBrwuYQBXh5l87x5Gm4B7hkfd43
         VQHqcQf+AkX6knYWl+/5rYcgJEEEdJWJakVklSbaISKsTRkvHuI87ffZvSg6ZKG2f/hs
         R+sPWxfC9jw7l+aCdcqIjlq8IfwEVvTI+3UDBTBy/IrAVSCLfsAHx2+UazmFuupnc2MA
         QuQgbuDLcM2KNvPCE3xsDE+qWh4HECf1pgTeQXSll5j4kW0bqpBkK3VE7L8UnygURBlX
         g7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZk8T3KRnsX+W2xgLLOiBMQ+nARJzKAoS3dakO/5NvNyOaLf00N9jArDcZ780UdiycYUk0xlbwJTmXFis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VEMSVD1hXiqeAVW73xNZJzgsLqeejidFYYdEwgrfW73Ju47v
	3WDvfOR6gk68YaUlbsY7ozCqq6Wudo49xzDUiLIl0hlVeIJBG0NXkvn5K2yCj0t+ALK/Ljh+ow/
	evea/R2WRCgVTPR1AwnD2SItJNl/BVaH6bWsiEqVzuqi+z7Ldk5Kh2jkJgATopk8XUDg3XcQ6Rv
	Wg80E1ULprFemBA66D/FiLIfIYbgPfHvB1xvyuLonX692VZav+FV5PXpm/uMyO1t6b5LISEmbwB
	QzNEDqvl14RxOXjCXQajZx7F0Sh
X-Gm-Gg: ASbGncsUtR+jI6VEIA7cPuJD5RxVYhCSjhVm2wNXk2FMD95//n2dw/awgh26+B6pztV
	uzQNbWF8Iy6/WmX7TS9nZ0463g5EL54+OBj36JlU/Xtbh4x3SMYIVFxRj9CKXYXD4N44p+Y4o0u
	5WcOllB53dJs0pwwjkyy6bIVTOQ7JL9y/mRluumRZVFQCPBhtwzP7llcHz+/HzPOopWN6yl50jB
	A/Qh3/tSLe9CehvzgW5k8XoMrkYRMQ71emiiYiZnrMaXlQzZhitLkVP5a1HrBl2DYt0N+Ok4j6A
	h8TgDzVygdMnZXHNe3jFVsv8JpRw4oUVuw6lf1bVCQ6i0Q01jo2BKFgr+pF5wmr6aXYyh4Gly+P
	85ErhHwLMuvZHaGN498MPoOtAE4QhUmNUSkMWGVhzl0UBDByMQwDgtge9kR6ntrzSxT/88yIOth
	9qMFmlqw==
X-Google-Smtp-Source: AGHT+IG7VEMHaGzdaxCOi1GSqQK3djVTlcwVdPK4Ci7w3BPDkk7ldzCPXELcHmKI6CxiaKuNejl7W3M24F9u
X-Received: by 2002:a05:6e02:4619:b0:3f6:554f:f839 with SMTP id e9e14a558f8ab-3f6554ff991mr244342315ab.26.1757092840706;
        Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f2d00d1sm1058100173.34.2025.09.05.10.20.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7725c995dd0so2380770b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092839; x=1757697639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPtLPCbW9cI52nHjoIxx9FA19cFt1KOBK+vvcRFUVCI=;
        b=JLQ7PoycZUTQOZu6U9i6erPdgjNgKSMOnnn9GMO3+e7CjiPtnxkQEKJPiyUilFOF2r
         E4Pxdi+L7Koq4VCgRs6QazrsoHkmTGTHgFLVMsr5BYfXRXTASW9h0X7SrqbE2X2PpB/A
         Ivot8qg487HdC1IKGTMD3o+JwIFseGygZ91x0=
X-Forwarded-Encrypted: i=1; AJvYcCXVUp1FgitVUXJnUOaylxVVpHpgrSPlRA+1GdiyOWldzkyzN1gI6hugUJlU2BCxh317tIcFdCT+9KKbZ0s=@vger.kernel.org
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr32004509b3a.4.1757092839111;
        Fri, 05 Sep 2025 10:20:39 -0700 (PDT)
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr32004483b3a.4.1757092838657;
        Fri, 05 Sep 2025 10:20:38 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:38 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 06/10] bng_en: Allocate packet buffers
Date: Fri,  5 Sep 2025 22:46:48 +0000
Message-ID: <20250905224652.48692-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 227 +++++++++++++++++-
 1 file changed, 226 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ee0cdea6fc0..a9fd5b242cb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -263,6 +263,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
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
@@ -733,6 +803,160 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
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
+static int bnge_alloc_one_rx_ring(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
+
+	bnge_alloc_one_rx_pkt_mem(bn, rxr, ring_nr);
+
+	if (!(bnge_is_agg_reqd(bn->bd)))
+		return 0;
+
+	bnge_alloc_one_rx_ring_netmem(bn, rxr, ring_nr);
+
+	return 0;
+}
+
 static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
 {
 	struct rx_bd **rx_desc_ring;
@@ -800,7 +1024,7 @@ static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
 
 	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
 
-	return 0;
+	return bnge_alloc_one_rx_ring(bn, ring_nr);
 }
 
 static int bnge_init_rx_rings(struct bnge_net *bn)
@@ -1149,6 +1373,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


