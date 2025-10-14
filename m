Return-Path: <linux-kernel+bounces-852636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03331BD9835
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C96619A1601
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F46314D18;
	Tue, 14 Oct 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlShYp1S"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51F313E0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446843; cv=none; b=sWhnUUh5lqEu9nH9b1zW+42oqgDL702OnqNd5m4kGuuwEE6e2N+qYvvE4TUlvsx0ugEot74hvpqe/mze87cvFL7lsAVUD9qriZynwcKWKreJZqQtBGWLDZn1aqdCNLhNAKt6rh98BCwVqMmo+HqWK6X5Gtk6+KBFDTRI5OiprhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446843; c=relaxed/simple;
	bh=HRBeeqncveoZFS7vcpAo1b3/1g5dn/bW6PkOv+8KzhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny8udOhxKReA8hcXAfWj7dC95Ep8CuojrGxMxxVrwa7U9fD8l5cVsISJYibMPyKvIhTiFmX6DbMs4hXEhpveY47c1B/9npBd1V3jn/4RbK+aBVfPWm91Mk2X9afhVU0+UBqKeDgsXt9ef+JNh0VYQGxLkQm1nmolAEMc9TG4tJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlShYp1S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42568669606so3887231f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446839; x=1761051639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr+blYainBcpT6wR27xzUZrr6kB24eyLx7MFFl01tLI=;
        b=OlShYp1S6wwr3A3l3D/OKq1RWcY7wjbrWDhM5KKUdElsltBDlIYZPuDuIeIBheWPDX
         G70nBH1jc+JSGI/04uLkWAPJ7s70pEFmxZiEOx/Dff+D5u6+tXyV4ZWmnjsypo2CMvJa
         2QmzLDYAas4AXbdI7OEkVHOVIzbAustBzwz/SV5+IruPp7oSpS0C8VUSOrVK2SWSlRO0
         BzLb+BqYb17tZnMAiVdyZXR9xtGOCXJc+Gok/Vtld7s90g3qCQYZG/aiwHk9P6CItY8z
         a0Wvi0YeIIEqc2ZWZQ7pVar91bLOD0qY2JdOVOq2F+G/hEuRXgxUbdNIviM/by9cZuP4
         Ca/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446839; x=1761051639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr+blYainBcpT6wR27xzUZrr6kB24eyLx7MFFl01tLI=;
        b=KhvSE2yFlnnoL11tY6EJa9SemSOpb9oqIpMtTymMaL4EfUgsOJu0OzVNyGPZQmdS8H
         7oMPMxY5U4pMTGmfz0kGMfQeNNBjEtWviSYM3O3DIJcxdf264acKL6QDeX6YjJKo7wRS
         v5Lpak7WerV+wpKzxEaFMZCedS4ge9KJQy0rRB2NV3ucEJeedjC7ynUUnkRZ6U6fdGgF
         1hj3kBgjAE7hrEXjEdCP12OtTDyEZmqcWs4XEG0M7a7Mo0ltOC9MBWuVmoH9tRXlN2bm
         qNXaH0K1fo9UFOBkBvRDZ6nrTbxyFSyf8m/R2Z8EBs0jmltF/2cqTNG25PZsGV7fHg80
         NYwg==
X-Forwarded-Encrypted: i=1; AJvYcCUy+gHSFOoINaFxG7VY5/pkYgBy/dANZV06QUkhAoMoHIGwt/ZbwQ/CJQXhP1gdDr6GeIW9mv0MozVGYWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYV7otbY3XwulVZVLO9B6N7eWcTbKavYSq7x7gGpUllT8ZaqL
	FrhxMlOvSHQD355PNR1nt4i4Mo0NCsYooGtBviXrbIFTF88oKNmwnlfO
X-Gm-Gg: ASbGncv6NICHK8rgui4b+xEjc8NigtnNh/2ioqBnudcpm8185kKj0ZZ0JT53eijdLBp
	oE+YZOjb6G3O6cIxKPe17MwzZfJ2nOio497JCnOeS+Zw5a4XWqfkVH00Hp45+lDCg220XtL4tTJ
	5tqW0PaqeK5hstAA2cKLnHyWpyxzZrmhhH4lxOOs6fmAKJtYtZSBD7nHUeuY61HwCniEcTIwHax
	rcK+DQjz6LjDdbZhINbkZyTmBzBCX8G6Iq5eZp118klc8eLDPLRYpb0KASpWmA7UJIqNcpEXeAh
	78UCx8UuNYetTSTGAQY6LM8D3EJn4gKfmOzSC26Jazl4O6bvnZ4CnCftF0p44qWAOFC/gNBCpP7
	1k9XANlLXEDuq0lhGq623Vs3m
X-Google-Smtp-Source: AGHT+IGcoZuBqHvgvUSsgwLain+WF6qicDLZHuH6hV35Q+IUg9D7eRD2PZdvbylFSmz/OUoUDJoUoA==
X-Received: by 2002:a5d:5889:0:b0:3fa:ff5d:c34a with SMTP id ffacd0b85a97d-4266e7e15bbmr17795709f8f.39.1760446839125;
        Tue, 14 Oct 2025 06:00:39 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:38 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 6/6] eth: bnxt: allow providers to set rx buf size
Date: Tue, 14 Oct 2025 14:01:26 +0100
Message-ID: <f389276330412ec4305fb423944261e78490f06a.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement NDO_QUEUE_RX_BUF_SIZE and take the rx buf size from the memory
providers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 34 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 950e60d204cb..8d0e69dc900e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15906,16 +15906,46 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static ssize_t bnxt_get_rx_buf_size(struct bnxt *bp, int rxq_idx)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(bp->dev, rxq_idx);
+	size_t rx_buf_size;
+
+	rx_buf_size = rxq->mp_params.rx_buf_len;
+	if (!rx_buf_size)
+		return BNXT_RX_PAGE_SIZE;
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		return -EINVAL;
+
+	if (!is_power_of_2(rx_buf_size))
+		return -ERANGE;
+
+	if (rx_buf_size < BNXT_RX_PAGE_SIZE ||
+	    rx_buf_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return rx_buf_size;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ring_struct *ring;
+	ssize_t rx_buf_size;
 	int rc;
 
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rx_buf_size = bnxt_get_rx_buf_size(bp, idx);
+	if (rx_buf_size < 0)
+		return rx_buf_size;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15927,6 +15957,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = rx_buf_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16053,6 +16084,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16205,6 +16238,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.supported_params	= NDO_QUEUE_RX_BUF_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3a53d9073c4d..d84c0de231b3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -759,6 +759,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE (1 << 15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.49.0


