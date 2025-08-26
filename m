Return-Path: <linux-kernel+bounces-786534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47FB35B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5071BA13AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B6318146;
	Tue, 26 Aug 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ghXLfl/q"
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE63376AD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207071; cv=none; b=fnksT174W6YVuL/5q41T0SV2j+iPRrT+duSo0WZKq/qaBaaEbrLglTlLqnz9rAxSEcAjA94iuKOzQDS2tGN4QzRbQFhkR1iBC2Ns8k58LID8fC9bBe8kFRuj+MaaFd9hObJKp/IKYqN8wKFWv56y/WQRw5umeeCniUJIwO8OMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207071; c=relaxed/simple;
	bh=b9iX4h2Rv+7Rza+a2/cPDa+vuEaelxvnUA5QKW4L1+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czMCn3KGQi+/ZPZSkIXy/LSoCvqFPWqV4z0PMfkwZ+vzAQvE6U64HzDsJReGUwoXoomBmgWCZaNn5u91lVID2/aYwlFcrhvfuY5uZOWxaRTU0bbOPNV5H3Au69EF9kgw7S92JyDqfwyGFRhTIU6unNFN40EMPMHsv4A04DqXzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ghXLfl/q; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e96c48e7101so1720162276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207068; x=1756811868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pejO6c5MGyl1YKQ5NGOcOU1GlpdjLM886UpYPRgtBuQ=;
        b=YsiHL3Fc5xorvnTc9UB4dew9F/yTiaafu/mT3gPvrRSchCOwOOg9VPrD6zjVyUjJ8c
         xh2On6ya2KA64dgVVn3QdPs5pKRwuXDOjLDNf5P4dHVWgz7THzRqvCxQTUkS2oOa62VZ
         bbXlcxp2fQOUfPYrZGAf+TLY2eK7vaXtqT5QWIqUCDBuYuTbhcId9efIF+UEPYbQ/OUx
         pkgzx/QKhovYKwcYm0ruDQezQYQs7mfBtMkfrMd8UYrUWAETKx16/3hgLkhE/CRuoTgX
         o3QR6MRW6a9Y4wpXqnzktYXJsagRwkg9flAD5rVnS8q8ysT7wfspoLuU4V3SZKXzxQ4i
         vYhw==
X-Forwarded-Encrypted: i=1; AJvYcCUnUvw/OKIlsgWC/zsUZpvcbQ2Mp93t1pXSqPaV9ztbRofUPTMr1tdsl6WBDm+qq+/j1jbBI7Nzxa2v220=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCNKRXV1I9d+DN//+mIG/Vj+epGwa5Ivj8ms0RKYfmTRta6cm
	x/wDt7Cwh4F+yyTa39ZI2F1jfB8zj/H0HAE4foBgM2IAf0LqTZBpS3vHsOU7X85FX/ui1zKc2WL
	xeJ1zHo3AOCQ7TkWtOHJ1Oj5VT772DhoxhQ9NTjAp19w/cbjsL7381ioI/9zigK2BrPAoMLK7Tj
	kS5lkvBxQRQproaON4Y51Pcg/iMMXpnCyqDB87sokON9qS8jMUaJ+kmX/Aegy9Uk9IqrImUm595
	qI/zF5/GgLvIgSU8l1wsM2QKRe6
X-Gm-Gg: ASbGncvkZ965ueNFKEAM564loeZzpmyJeFzecwHJASR9ciQ7i/dxLwAQVM/j6R6gRTf
	952mu1XU8tsrGW7DXJFPVEpH9FdzCtkzb/sqWSa2JOFS9JM2s5oxGQzvrD6lnRe3t5qFP3jCMW1
	VWifyecVtSteIZ/7o0s+zr/kbh05E3d4vLPrVPXTmM0DGvDu2BMvJhZAY0yyHze08ZDpSW8LKl4
	My6KSsrUkGvUE9nQH1xzMLRQ38nwYAt+WJkd88VxYvqvuZe+mp1Cx3aCN9eMCNlRdAVw/6FzhJK
	Tl5Q3BkWaduS78gIgijK4DBg6xMgcde7Wp2RkYcLsotuO6UI+eDhjLRmsQtBR5idmJXxcu9EACv
	gh5PzyblQewA6AnaavECEMBHHFR250w==
X-Google-Smtp-Source: AGHT+IHiBaBsOSCgXQWjhILJaM0iNRP52Jn/1BfuIwXlMZkiPUB2QB2XuSwKNSjdC2VdF2SeBTk4N8ojv5G8
X-Received: by 2002:a05:690c:4d0a:b0:720:9b0:5791 with SMTP id 00721157ae682-72009b05a57mr95285467b3.25.1756207068277;
        Tue, 26 Aug 2025 04:17:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-72139d176e9sm139697b3.4.2025.08.26.04.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49de40e845so1461066a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207067; x=1756811867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pejO6c5MGyl1YKQ5NGOcOU1GlpdjLM886UpYPRgtBuQ=;
        b=ghXLfl/qgQPXdnFuIXgGSXx1lJb8n5rSG8WXmdnJRqqGibw/0Jv0PwxKrD5U7JTAaq
         TgKZ8Fv2aPw3ps4Kmkku7/9Xr1fGjRFsjJatLLeO/l+gF+E5R3cx87mVJypG/BZQIOjh
         afrBrkp8yNZOLBroA7ty495eo/r1lSJs+/pIQ=
X-Forwarded-Encrypted: i=1; AJvYcCVdVpKEYksAHO1ycdLBQfV9QJeHCPbALXfR2bb3HMk3U/ziise+nc5aBBQUk0IBs6SoHTA/lqANeIZDEok=@vger.kernel.org
X-Received: by 2002:a05:6a21:9999:b0:240:1e63:2dfd with SMTP id adf61e73a8af0-24340d8fbabmr23065065637.29.1756207066897;
        Tue, 26 Aug 2025 04:17:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:9999:b0:240:1e63:2dfd with SMTP id adf61e73a8af0-24340d8fbabmr23065031637.29.1756207066401;
        Tue, 26 Aug 2025 04:17:46 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:45 -0700 (PDT)
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
Subject: [v4, net-next 5/9] bng_en: Allocate packet buffers
Date: Tue, 26 Aug 2025 16:44:08 +0000
Message-ID: <20250826164412.220565-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
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
index be068ccda38a..7dae3ebfd88d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -251,6 +251,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
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
@@ -728,6 +798,160 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
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
+			netdev_warn(bn->netdev, "init'ed rx ring %d with %d/%d pages only\n",
+				    ring_nr, i, bn->rx_ring_size);
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
@@ -795,7 +1019,7 @@ static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
 
 	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
 
-	return 0;
+	return bnge_alloc_one_rx_ring(bn, ring_nr);
 }
 
 static int bnge_init_rx_rings(struct bnge_net *bn)
@@ -1148,6 +1372,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


