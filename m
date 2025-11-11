Return-Path: <linux-kernel+bounces-896156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD61C4FC55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E2A1898CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522735E554;
	Tue, 11 Nov 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MoTx3tVc"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3435E52E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894769; cv=none; b=vFz93b7NwvQ9c+utKiQimo9qHjDpn6xMSzn/zaOKhBQVh8YIKxEwV11JO06u3BfbppBKFaFWgckfthujQxdH80/6lMxiP2FZAaykayiVRskmCUP3aJ652PjO7hjvsRHPSL5Kdr/Ri6xe32YDf9V5eKTSa1ETXutwkWj5lsAg8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894769; c=relaxed/simple;
	bh=genLZqocSwQxlZnEboq+3NUJb1mdBKEdszUDHkHDsSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1ZWi4ydFo0s7c0E0/xyXBcffh9i99GX+ZjBRWRHE+BrMYkGQJ+2FCjVEmAQsUljXdCNXi4p1Ce/STSepo4X/3ly6KD4g5HUoqzV5GxiIY8fFl7haLcuFwzfX1YnR2TS98ihzwVfsrwU2+HeBuIEzEeCUXyVJasMvVzQrFlxQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MoTx3tVc; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-434717509afso667915ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894766; x=1763499566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBEatJrYViFT545+/aoVpFeK11myHI7JC0xCcrfj9YI=;
        b=HuIbLUhhtSFIuAYYVsyhfN+06nhcY5YFYIgCY9hqQejRZBvgknn2tS7mNcOa/FIVCW
         MCXkMj5yDSQmoF7LZJmFkqqPPtI0z/EDa6EEMViEfAFb+nYYxrgHNEdAsvtRdWnLflp6
         9j4cQNTeuDLz+I36Qu+M7zljGezq9oTnAtUhwsbM8ezx8cKSTKjvziXAifq9zoVuuiGU
         gwpCGvVe1eo1pGjJ8qWrIXo5gNfYsEkInmtm2al9LHrRq24EqdAa0zVq0f2mt7z8VB/Z
         aJunljjywcLBK5bAm/uCKz6Qcr12oltT+PrvWu+190Dw3qCnA1djvcqk/I/P1XfvZsp3
         x46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLcij/XGVTmD3UuG9lAhkG+s3kscR9LtF/wi4XdgeAxw+VpdaNXPcVAseAYPThMZ9YVp6/gA9bmNgIvPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1EJmS6zVHR/WBY6kxuVZFJ7VkmyiujTS56LKoziea7spiX0L
	t2oP5KgiGREIaMEeIEyWZRGxhWYqiCc9HDQXOOLoEOWtaBccePJdpdnHJpIxkwXp0WRCRUwWgZ2
	f/GEvLKOpSHdIg+Cm/23AExe5KOgCChBU6xShdDuy87fQqLiHuzt4/yglJIvudZ1SN6IC2LmS88
	D+XGcqe8H3cBM38sIQXIKDdNtZfuYI8+/AG+lhdjEC9gg1BGArqkHiu95khO7FpohA89thRPkBA
	TTT5AT5VL8/jZdnq3r295yuv+L1
X-Gm-Gg: ASbGnctP5Cd/4AFNHvT0pfKwBo1e14jfya70pfnOAVcslgDXc270dj5bVmYKJcTHION
	H5BGpEph66Y8kXdNwG0JidHzt+vsQPLkOJaHV9AxSVv8WLdAO95GdYQX4YRLNgrI6et3QDbNCKe
	MDrVedg8tYActN/5+MrA1zUesitrreHJPMy6SoFAhAb5BIRmu3p8pgFI6gb2ziC6cqhasKCFVYk
	MvnBmUc1+84SZ+tue79VaeBAaT7AMLnRxXyGRqc8a9z8uxpgguYqPIvP7q27CIFeDNEq1OAB4Wz
	xlyzeBcLvQGL/5Pvx3WsevF9og8quUWERvYfZqHKVnbslQVQEHWEJXy3CUqv19wcUTFXXHasomr
	b2IakItQAffj1MeeUWRdytWedpkfl6D/ugeoFIFui5voNftklWNcquoVWNSXUJHmfqI3FR7R3J/
	ZjvdTg5XG4ZH+uytk6LYbsAvsxxBW2bEjP/3SnAd0bAUE=
X-Google-Smtp-Source: AGHT+IFG8dRZkSZpPEQakc1TglaVQvtJD6Xe4nIsST891/GWZ0tqSiTzOqFaLiAAFMAejEMfbAi/KSXl2H7X
X-Received: by 2002:a05:6e02:214e:b0:433:773d:adc0 with SMTP id e9e14a558f8ab-43473d91878mr8661135ab.17.1762894766406;
        Tue, 11 Nov 2025 12:59:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7aaf509c4sm63177173.8.2025.11.11.12.59.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55735710f0so234900a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894765; x=1763499565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBEatJrYViFT545+/aoVpFeK11myHI7JC0xCcrfj9YI=;
        b=MoTx3tVcpx8Pih8a3fjqxn0GFTPSAmPFT3C/rAwmeHrldl+b30L9fuA7asEqlSn5SL
         IC8dPC5xlt+KM4sWMN/GW/IajY+epJmoC6d/eiIaVuiBt3eyReD27bqeY2X9FkDEPT7e
         NCECDl5FCgX3tIFb8RJksqR/s5OKsChpfjAyk=
X-Forwarded-Encrypted: i=1; AJvYcCUrVGYxPPRoMT165CODq2sWoi8BtUKdZEcDwm1hSt44fM9R2EJlk7zdvZ8rZDAv7SgljLCuAorhwXWWxA0=@vger.kernel.org
X-Received: by 2002:a05:6a20:12c4:b0:347:9ae1:cffb with SMTP id adf61e73a8af0-35909c711a9mr603862637.24.1762894764901;
        Tue, 11 Nov 2025 12:59:24 -0800 (PST)
X-Received: by 2002:a05:6a20:12c4:b0:347:9ae1:cffb with SMTP id adf61e73a8af0-35909c711a9mr603834637.24.1762894764469;
        Tue, 11 Nov 2025 12:59:24 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:24 -0800 (PST)
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
Subject: [net-next 06/12] bng_en: Add support to handle AGG events
Date: Wed, 12 Nov 2025 02:27:56 +0530
Message-ID: <20251111205829.97579-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add AGG event handling in the RX path to receive packet data
on AGG rings. This enables Jumbo and HDS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  13 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  17 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   8 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 216 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   1 +
 5 files changed, 247 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index d0b3d4bea93..a41f4b00003 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -4,6 +4,19 @@
 #ifndef _BNGE_HW_DEF_H_
 #define _BNGE_HW_DEF_H_
 
+struct rx_agg_cmp {
+	__le32 rx_agg_cmp_len_flags_type;
+	#define RX_AGG_CMP_TYPE					(0x3f << 0)
+	#define RX_AGG_CMP_LEN					(0xffff << 16)
+	 #define RX_AGG_CMP_LEN_SHIFT				 16
+	u32 rx_agg_cmp_opaque;
+	__le32 rx_agg_cmp_v;
+	#define RX_AGG_CMP_V					(1 << 0)
+	#define RX_AGG_CMP_AGG_ID				(0xffff << 16)
+	 #define RX_AGG_CMP_AGG_ID_SHIFT			 16
+	__le32 rx_agg_cmp_unused;
+};
+
 struct tx_bd_ext {
 	__le32 tx_bd_hsize_lflags;
 	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index fa85ff2234e..87b5b2163e5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -10,6 +10,9 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
@@ -980,9 +983,9 @@ static netmem_ref __bnge_alloc_rx_netmem(struct bnge_net *bn,
 	return netmem;
 }
 
-static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
-				struct bnge_rx_ring_info *rxr,
-				gfp_t gfp)
+u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+			 struct bnge_rx_ring_info *rxr,
+			 gfp_t gfp)
 {
 	unsigned int offset;
 	struct page *page;
@@ -1049,7 +1052,7 @@ static int bnge_alloc_one_rx_ring_bufs(struct bnge_net *bn,
 	return 0;
 }
 
-static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 {
 	u16 next, max = rxr->rx_agg_bmap_size;
 
@@ -1059,9 +1062,9 @@ static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static int bnge_alloc_rx_netmem(struct bnge_net *bn,
-				struct bnge_rx_ring_info *rxr,
-				u16 prod, gfp_t gfp)
+int bnge_alloc_rx_netmem(struct bnge_net *bn,
+			 struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp)
 {
 	struct bnge_sw_rx_agg_bd *rx_agg_buf;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 43fda076969..781cba50bdc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -518,4 +518,12 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
+inline int bnge_alloc_rx_page(struct bnge_net *bn,
+			      struct bnge_rx_ring_info *rxr,
+			      u16 prod, gfp_t gfp);
+inline u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx);
+inline u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+				struct bnge_rx_ring_info *rxr, gfp_t gfp);
+int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index f02ac71447f..ccfccb8fcf1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/tcp.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
@@ -39,6 +40,186 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
+				       struct bnge_cp_ring_info *cpr,
+				       u16 cp_cons, u16 curr)
+{
+	struct rx_agg_cmp *agg;
+
+	cp_cons = RING_CMP(bn, ADV_RAW_CMP(cp_cons, curr));
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+	return agg;
+}
+
+static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
+				   u16 start, u32 agg_bufs)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
+	u16 sw_prod = rxr->rx_sw_agg_prod;
+	struct bnge_net *bn = bnapi->bn;
+	u16 prod = rxr->rx_agg_prod;
+	u32 i;
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
+		struct rx_agg_cmp *agg;
+		struct rx_bd *prod_bd;
+		netmem_ref netmem;
+		u16 cons;
+
+		agg = bnge_get_agg(bn, cpr, idx, start + i);
+		cons = agg->rx_agg_cmp_opaque;
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
+			sw_prod = bnge_find_next_agg_idx(rxr, sw_prod);
+
+		__set_bit(sw_prod, rxr->rx_agg_bmap);
+		prod_rx_buf = &rxr->rx_agg_buf_ring[sw_prod];
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+
+		/* It is possible for sw_prod to be equal to cons, so
+		 * set cons_rx_buf->netmem to 0 first.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+		prod_rx_buf->netmem = netmem;
+
+		prod_rx_buf->mapping = cons_rx_buf->mapping;
+
+		prod_bd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bn, prod)]
+					[RX_IDX(prod)];
+
+		prod_bd->rx_bd_haddr = cpu_to_le64(cons_rx_buf->mapping);
+		prod_bd->rx_bd_opaque = sw_prod;
+
+		prod = NEXT_RX_AGG(prod);
+		sw_prod = RING_RX_AGG(bn, NEXT_RX_AGG(sw_prod));
+	}
+	rxr->rx_agg_prod = prod;
+	rxr->rx_sw_agg_prod = sw_prod;
+}
+
+static int bnge_agg_bufs_valid(struct bnge_net *bn,
+			       struct bnge_cp_ring_info *cpr,
+			       u8 agg_bufs, u32 *raw_cons)
+{
+	struct rx_agg_cmp *agg;
+	u16 last;
+
+	*raw_cons = ADV_RAW_CMP(*raw_cons, agg_bufs);
+	last = RING_CMP(bn, *raw_cons);
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(last)][CP_IDX(last)];
+	return RX_AGG_CMP_VALID(agg, *raw_cons);
+}
+
+static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
+			   u32 *raw_cons, void *cmp)
+{
+	u32 tmp_raw_cons = *raw_cons;
+	struct rx_cmp *rxcmp = cmp;
+	u8 cmp_type, agg_bufs = 0;
+
+	cmp_type = RX_CMP_TYPE(rxcmp);
+
+	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+		agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) &
+			    RX_CMP_AGG_BUFS) >>
+			   RX_CMP_AGG_BUFS_SHIFT;
+	}
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+	}
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
+
+static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
+				 struct bnge_cp_ring_info *cpr,
+				 u16 idx, u32 agg_bufs,
+				 struct sk_buff *skb)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct skb_shared_info *shinfo;
+	struct bnge_rx_ring_info *rxr;
+	u32 i, total_frag_len = 0;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
+	shinfo = skb_shinfo(skb);
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf;
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
+		netmem_ref netmem;
+
+		agg = bnge_get_agg(bn, cpr, idx, i);
+		cons = agg->rx_agg_cmp_opaque;
+		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
+			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
+
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+		skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem, 0,
+				       frag_len, BNGE_RX_PAGE_SIZE);
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		/* It is possible for bnge_alloc_rx_netmem() to allocate
+		 * a sw_prod index that equals the cons index, so we
+		 * need to clear the cons entry now.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+
+		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_ATOMIC) != 0) {
+			skb->len -= frag_len;
+			skb->data_len -= frag_len;
+			skb->truesize -= BNGE_RX_PAGE_SIZE;
+
+			--shinfo->nr_frags;
+			cons_rx_buf->netmem = netmem;
+
+			/* Update prod since possibly some netmems have been
+			 * allocated already.
+			 */
+			rxr->rx_agg_prod = prod;
+			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i);
+			return 0;
+		}
+
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNGE_RX_PAGE_SIZE);
+
+		total_frag_len += frag_len;
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+	return total_frag_len;
+}
+
+static struct sk_buff *bnge_rx_agg_netmems_skb(struct bnge_net *bn,
+					       struct bnge_cp_ring_info *cpr,
+					       struct sk_buff *skb, u16 idx,
+					       u32 agg_bufs)
+{
+	u32 total_frag_len = 0;
+
+	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs, skb);
+	if (!total_frag_len) {
+		skb_mark_for_recycle(skb);
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+
+	return skb;
+}
+
 static void bnge_sched_reset_rxr(struct bnge_net *bn,
 				 struct bnge_rx_ring_info *rxr)
 {
@@ -210,6 +391,7 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
 	unsigned int len;
+	u8 agg_bufs;
 	void *data;
 	int rc = 0;
 
@@ -239,11 +421,15 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	cons = rxcmp->rx_cmp_opaque;
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
+
 		/* 0xffff is forced error, don't print it */
 		if (rxr->rx_next_cons != 0xffff)
 			netdev_warn(bn->netdev, "RX cons %x != expected cons %x\n",
 				    cons, rxr->rx_next_cons);
 		bnge_sched_reset_rxr(bn, rxr);
+		if (rc1)
+			return rc1;
 		goto next_rx_no_prod_no_len;
 	}
 	rx_buf = &rxr->rx_buf_ring[cons];
@@ -252,11 +438,22 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	prefetch(data_ptr);
 
 	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
+	agg_bufs = (misc & RX_CMP_AGG_BUFS) >> RX_CMP_AGG_BUFS_SHIFT;
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+
+		cp_cons = NEXT_CMP(bn, cp_cons);
+		*event |= BNGE_AGG_EVENT;
+	}
 	*event |= BNGE_RX_EVENT;
 
 	rx_buf->data = NULL;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		bnge_reuse_rx_data(rxr, cons, data);
+		if (agg_bufs)
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
 		rc = -EIO;
 		goto next_rx_no_len;
 	}
@@ -268,8 +465,12 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	if (len <= bn->rx_copybreak) {
 		skb = bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
 		bnge_reuse_rx_data(rxr, cons, data);
-		if (!skb)
+		if (!skb) {
+			if (agg_bufs)
+				bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
+						       agg_bufs);
 			goto oom_next_rx;
+		}
 	} else {
 		u32 payload;
 
@@ -283,6 +484,13 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 			goto oom_next_rx;
 	}
 
+	if (agg_bufs) {
+		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, cp_cons,
+					      agg_bufs);
+		if (!skb)
+			goto oom_next_rx;
+	}
+
 	if (RX_CMP_HASH_VALID(rxcmp)) {
 		enum pkt_hash_types type;
 
@@ -463,6 +671,12 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
 		bnapi->events &= ~BNGE_RX_EVENT;
 	}
+	if (bnapi->events & BNGE_AGG_EVENT) {
+		struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
+
+		bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
+		bnapi->events &= ~BNGE_AGG_EVENT;
+	}
 }
 
 static void
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index db699ce86b4..d2c9e6f2e7f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -109,6 +109,7 @@ static inline void bnge_db_write_relaxed(struct bnge_net *bn,
 #define ADV_RAW_CMP(idx, n)	((idx) + (n))
 #define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
 #define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
+#define NEXT_CMP(bn, idx)	RING_CMP(bn, ADV_RAW_CMP(idx, 1))
 
 irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
-- 
2.47.3


