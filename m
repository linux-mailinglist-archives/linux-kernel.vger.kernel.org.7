Return-Path: <linux-kernel+bounces-825054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F30B8AD02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85308586A73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508FB326D6A;
	Fri, 19 Sep 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OMftSBq1"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E9323F7E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304122; cv=none; b=iemFzkuzbRMjyq56UTY4zLnbYysItJujwdLUDj+CtdXUYIRGkzirnynMTZZ4hAQsGuVixvYH2mNj+wCUmkY9cDo1xEANmQnhABpKeNze1hdqK84sSupsRPLYUYBO0F3+kEbHOXCccuIE2Dyas0kWRoMgkmSeXmlEofUXZj3zf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304122; c=relaxed/simple;
	bh=OfLpipZFBCTyYHs+O8EIrtSKEHVWT2EoKmMEO5+PU6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx7+DzeUEasg28mQm6v9TeuRyrYUjvhuspVP045IjkL7/wH70ra49T9d61HzDJLHWs3W430lLqtRgbDLBHZl8sf+19ZEI6StnAZj/0/aoQRhnw1inNDmI8YKkzYmC/7tw5dt0eU3FKgHYIIxPloEDPk0db5hf74oqfkNYf1GMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OMftSBq1; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-30cceb749d7so1000119fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304119; x=1758908919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW0/1Cei49q5/klZoX7Q0m/rGvA4O6wvwJ9Vo850vrE=;
        b=OJxjrZ4anIiw9anO4Zs4GF4SVVqiw+wE00RuzkK6LDBm38wWk3uDeW16Z63vksDu2r
         Yo0jAm/mvnCXJCSMbk9aqxfsjzb4Qkqk8mj0lVzeM7zKrvWiki/cAtwzUClHyRwMPCaS
         xwikpDWY3jM+fuvRzNkiZ4qAmHVNf7NlskC4lyY27h6Eyd01CcsnP+0WeM2FYCVtPkwL
         bBuzhZjKRkmL4r2wetieqJ9f9ZHDXyrO3EgoRuLoH8pWtL9cjr62Za3AV1lRJqbBGcQZ
         Uy+j1hw11Sa0wkH0VVFU1Eq3VVOt3gRLXPhb/I0yEonFI4rYHMLjw4dwp8a84PmC1Wyx
         q3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWKQGB38FpsrwNVhfKh0UXSH1frk9OlrgtLpURiv5dF7DaZoh06kxegmRFZqE86vpoKJkHa/jZJxCmTUXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByGVdbeAT0WIBnC1PsN13j/73iRF+EDcvEeDW3yk2FBZ3Expn
	LpOmHG+KwIOdUdvr+9Ebv6aZVRI29t/T1bGl+0kavgDRebZhy/Zp+CB8F5QJzyRooPkvjn3jY98
	lTlfJqkI1yrztIYlyLNIcqm3KNlYoEUqn34kN7Yu7xZ6hGXzN0bITHDqLC0yEkRleo6nFqam4au
	OmNh3quewQvNUn453E4C9O/h9RrhERGyS9xOX4IpKZVRd208n3l0BecLMZl98Wfz2XMTy9Ouu24
	3lKOB7lAyk0E++8UgkGXoGhPPOx
X-Gm-Gg: ASbGncuXMvK12r7b4mXi6O5chDvPyjSJ5O9sJHHJLIWzdP+VkcOt4KThy7NqFjW4Ezd
	5zq+vrbIuDiaxmXuth2LIOqQ6Z9isgUa6wsEJNy9bCBYMOZhD/739MqE/sPpo5waGsDVQdgJhZN
	NZ5NH1tW5DwV7JUyPfXHFUqURPQbZZXZyfqXkEz4/s9+shWh8104MgcFUzIhnL+64B3Yl1i7tzM
	0m97wrN7p7vIPc77iYqtmlI8zgYJGnJSsEBawy78BvOiVn7eGbUemU+mPabQtb5oCZ+4pXXkxhY
	l/6CyajB8fivsbcOpcXoww/FVeTzs8sb4n2XL8hoqtin9ExBnQWIeKIQqjl5rKUq7Oo4SldtLyl
	1NY4IzYGAT44THGHKgehIm90CND4cxp8boCxWNM85XTc+TH0gM1iR2GkuYbxSicRB1J5oU4gsEi
	YzjC69YmAc
X-Google-Smtp-Source: AGHT+IEv2AVqFugzppDx9Bun72F6G0d+YI6+wws07KE/W8hn/tyPKdH0ydrL0PXO2SAy+QU7K/jSAd0X39Mg
X-Received: by 2002:a05:6870:353:b0:315:3103:6e7a with SMTP id 586e51a60fabf-33bb67fa8dfmr2136515fac.43.1758304119408;
        Fri, 19 Sep 2025 10:48:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6eb0a53sm559009fac.26.2025.09.19.10.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so2088084a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304118; x=1758908918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW0/1Cei49q5/klZoX7Q0m/rGvA4O6wvwJ9Vo850vrE=;
        b=OMftSBq1rmahEpL9HIvGbxgQpawizmsB+82tjsdl2okYNrCVnX1fS6NymWLMyTCvGB
         Sp+Vj+Z/l98RDSRMOrSBIMBTZiRbS1MyyWdZH33JD/ft3LaZGw5KABlIJlbEVQrWqnEw
         rYWAgkZkTFY2DKxzIyksOliED29fgTsHBIJ60=
X-Forwarded-Encrypted: i=1; AJvYcCVTO35h/2mqnBt7FVVgPDV1iceZh2nnjmc2vrawlr9F8reouliEMl4Oiw+IL7c97e9jAwwWHMeJ+LY+CvE=@vger.kernel.org
X-Received: by 2002:a17:90b:562f:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-330bca51b24mr1722749a91.32.1758304117764;
        Fri, 19 Sep 2025 10:48:37 -0700 (PDT)
X-Received: by 2002:a17:90b:562f:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-330bca51b24mr1722727a91.32.1758304117235;
        Fri, 19 Sep 2025 10:48:37 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:36 -0700 (PDT)
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
Subject: [v8, net-next 06/10] bng_en: Allocate packet buffers
Date: Fri, 19 Sep 2025 23:17:37 +0530
Message-ID: <20250919174742.24969-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 288 +++++++++++++++++-
 1 file changed, 287 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c3418b3fe05..1ccc027c021 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -259,6 +259,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
 }
 
+static void bnge_free_one_rx_ring_bufs(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr)
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
+static void bnge_free_one_agg_ring_bufs(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
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
+static void bnge_free_one_rx_ring_pair_bufs(struct bnge_net *bn,
+					    struct bnge_rx_ring_info *rxr)
+{
+	bnge_free_one_rx_ring_bufs(bn, rxr);
+	bnge_free_one_agg_ring_bufs(bn, rxr);
+}
+
+static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->rx_ring)
+		return;
+
+	for (i = 0; i < bd->rx_nr_rings; i++)
+		bnge_free_one_rx_ring_pair_bufs(bn, &bn->rx_ring[i]);
+}
+
+static void bnge_free_all_rings_bufs(struct bnge_net *bn)
+{
+	bnge_free_rx_ring_pair_bufs(bn);
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -739,6 +809,194 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
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
+static int bnge_alloc_one_rx_ring_bufs(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr,
+				       int ring_nr)
+{
+	u32 prod = rxr->rx_prod;
+	int i, rc = 0;
+
+	for (i = 0; i < bn->rx_ring_size; i++) {
+		rc = bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL);
+		if (rc)
+			break;
+		prod = NEXT_RX(prod);
+	}
+
+	/* Abort if not a single buffer can be allocated */
+	if (rc && !i) {
+		netdev_err(bn->netdev,
+			   "RX ring %d: allocated %d/%d buffers, abort\n",
+			   ring_nr, i, bn->rx_ring_size);
+		return rc;
+	}
+
+	rxr->rx_prod = prod;
+
+	if (i < bn->rx_ring_size)
+		netdev_warn(bn->netdev,
+			    "RX ring %d: allocated %d/%d buffers, continuing\n",
+			    ring_nr, i, bn->rx_ring_size);
+	return 0;
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
+static int bnge_alloc_one_agg_ring_bufs(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr,
+					int ring_nr)
+{
+	u32 prod = rxr->rx_agg_prod;
+	int i, rc = 0;
+
+	for (i = 0; i < bn->rx_agg_ring_size; i++) {
+		rc = bnge_alloc_rx_netmem(bn, rxr, prod, GFP_KERNEL);
+		if (rc)
+			break;
+		prod = NEXT_RX_AGG(prod);
+	}
+
+	if (rc && i < MAX_SKB_FRAGS) {
+		netdev_err(bn->netdev,
+			   "Agg ring %d: allocated %d/%d buffers (min %d), abort\n",
+			   ring_nr, i, bn->rx_agg_ring_size, MAX_SKB_FRAGS);
+		goto err_free_one_agg_ring_bufs;
+	}
+
+	rxr->rx_agg_prod = prod;
+
+	if (i < bn->rx_agg_ring_size)
+		netdev_warn(bn->netdev,
+			    "Agg ring %d: allocated %d/%d buffers, continuing\n",
+			    ring_nr, i, bn->rx_agg_ring_size);
+	return 0;
+
+err_free_one_agg_ring_bufs:
+	bnge_free_one_agg_ring_bufs(bn, rxr);
+	return -ENOMEM;
+}
+
+static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
+	int rc;
+
+	rc = bnge_alloc_one_rx_ring_bufs(bn, rxr, ring_nr);
+	if (rc)
+		return rc;
+
+	if (bnge_is_agg_reqd(bn->bd)) {
+		rc = bnge_alloc_one_agg_ring_bufs(bn, rxr, ring_nr);
+		if (rc)
+			goto err_free_one_rx_ring_bufs;
+	}
+	return 0;
+
+err_free_one_rx_ring_bufs:
+	bnge_free_one_rx_ring_bufs(bn, rxr);
+	return rc;
+}
+
 static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
 {
 	struct rx_bd **rx_desc_ring;
@@ -803,6 +1061,22 @@ static void bnge_init_one_rx_ring_pair(struct bnge_net *bn, int ring_nr)
 	bnge_init_one_agg_ring_rxbd(bn, rxr);
 }
 
+static int bnge_alloc_rx_ring_pair_bufs(struct bnge_net *bn)
+{
+	int i, rc;
+
+	for (i = 0; i < bn->bd->rx_nr_rings; i++) {
+		rc = bnge_alloc_one_rx_ring_pair_bufs(bn, i);
+		if (rc)
+			goto err_free_rx_ring_pair_bufs;
+	}
+	return 0;
+
+err_free_rx_ring_pair_bufs:
+	bnge_free_rx_ring_pair_bufs(bn);
+	return rc;
+}
+
 static void bnge_init_rx_rings(struct bnge_net *bn)
 {
 	int i;
@@ -1030,13 +1304,24 @@ static int bnge_init_nic(struct bnge_net *bn)
 	int rc;
 
 	bnge_init_nq_tree(bn);
+
 	bnge_init_rx_rings(bn);
+	rc = bnge_alloc_rx_ring_pair_bufs(bn);
+	if (rc)
+		return rc;
+
 	bnge_init_tx_rings(bn);
+
 	rc = bnge_init_ring_grps(bn);
 	if (rc)
-		return rc;
+		goto err_free_rx_ring_pair_bufs;
+
 	bnge_init_vnics(bn);
 	return rc;
+
+err_free_rx_ring_pair_bufs:
+	bnge_free_rx_ring_pair_bufs(bn);
+	return rc;
 }
 
 static int bnge_open_core(struct bnge_net *bn)
@@ -1105,6 +1390,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


