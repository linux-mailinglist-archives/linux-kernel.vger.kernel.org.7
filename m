Return-Path: <linux-kernel+bounces-850814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AACBD3F96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF44FDD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84D3112B7;
	Mon, 13 Oct 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFVHgG6J"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3A30FF2B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367222; cv=none; b=e+k9k/QAC7qY/j8op+l2BODyX+nayz/g/uco4nKa7Xh1oeb7CiFYURQy3g6/jHsWFkG+wds05a773JtFN+Fp9vbkMBDw+foyunOKVhsoNR2A/2T5sGsbGihY8mPBzHge6DSTPsc7e1HheVik1DCMUI4Y+Dd7MpFvSfOmTmEUBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367222; c=relaxed/simple;
	bh=kYq0RQ8YrvfPuA2ch2Lr96zLv/LgeMZHSYJ35zuO0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvnc62wLT6WGqsFzhx/Q8v03bYL+X98NDNVQnfJue+0yls7xKi3figXCCkrUuGP7ues9UqccUM5vHjkuIbMpKY06oV/18pBYMyMrRAWx2c3zfNLUGNZSBBdkBw2AxmDPohGYNGG3W4mH8sOdBZZNFGD20b9pxgDjbrXG2nFFoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFVHgG6J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so23542275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367218; x=1760972018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=gFVHgG6J93eClI/ZIex9xvVEdr8050jQpjnhPYM8mn3NgFH8qg/9+PR4DR6l4ZjH7M
         f2Fi4GF4nzqZG9j+g1ckiUzhqsBO1Syfy5CRBebDGu2nxq+kLw4UltxeJ8wEUXQS27Lh
         53WWBdcxD+yyQ/sLN/OMPzBk2l5UbrhOKfGerp4WDwR33RZUaQX1ugo+UVZBVS3wOb9b
         r5jz+sNcGj7Ga6F/EI4cBrleA2WYwRCnQtDiPowCtGrwFeOQJaRpBsdC67w+oeq4XLqB
         ItXWXX45h/dINsZSY0r25MtUpQvOr7poZqEfV+IEFSVvFyT3rq976kwUer5S24TmWd2H
         1cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367218; x=1760972018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=Z+NLhb/nrsLQav81LH62YfRE97W94PWC6/ZWF5ouOE/NUgGYrk35J7PK2Jgw6WMLka
         7EtF5W1gDZYu0QEji2WsEsNwP15+lsgBqxvKSQlACYGSIU6wxdM7fBQz0yd3gmUdjGxw
         O0Jmbvu37OnLr0CKYkRQy8b8to9kdrHCuRPKbGuPSgctdjKddjFfHxh42KsDROU+bIbQ
         iVQbvizs4VLBJEkQCvDLxXfQuu09ivZkQaWISFFnFLB0JRmrbmz9qGzUB/DtqHzk2kGq
         MRr1cnXbXCYVQE3QbpHZwvcoOV7edGpDNBmb2DL7gjK4WvL/awwjCGk51tFWx4VCSFX1
         9vEw==
X-Forwarded-Encrypted: i=1; AJvYcCWh5D9NvNSHEpxP8mPsYJFSpoff8PUjqVdqY3wcccK84xM958sGVkjXE2ZvHyhQ6QSjvEN1QMiShdMAoU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjzG+ky+Dzuyq9Aib6hABWo1i0SDR1IW12J8TCF7dYBXkp4nF
	tqyxsGAS6zIJ7VfhK7tIoPGfg92XqPbHjaCnoQyY0ItvszWGZNSDLUFt
X-Gm-Gg: ASbGncvEGlpa3GPiJyaB9u6l725242xKA32yIiSid0EnfBwGj/UpkAzyoV8FUrsPasG
	TK6fB8YQe7yIHbI9g+xteWF7PPU1xaHCigoddSnQKUxHzuuxerrLKh8OyYVN/Nq3vCmS3iZuANB
	R7bNYQumvW+nVE8H31y2e1RY/1gB0XNY6Mi01dqwf81FFWHFsDnUMmK2yyFgtgr8uPP0KhNOA0X
	/kG3lxbvI6ZzwrdnKnI3LDNhFdpaO64wIBNpeUhQvs2rw6ibOjsvAHGMEJ2OKQo0j7hYIrAogcm
	/agrl5T2abkOJgrvYeG+GZeEhoKETsbwbrTjUjbGiGc9Vu+amICpTbB+zqay6cVlGasZi7zQ0AN
	OxX5CAMX2PIZWhjjdTTj6XGFnf04cfN5wjvU=
X-Google-Smtp-Source: AGHT+IED3GRiP+h7v/FeCyojCF1RwIXSpzaWATh3pEDXx0dXFBUhT/YkmwA0d8YAYemw1uBFEREaKA==
X-Received: by 2002:a5d:5d08:0:b0:425:7ce6:fd50 with SMTP id ffacd0b85a97d-4266e8db473mr14976457f8f.53.1760367218044;
        Mon, 13 Oct 2025 07:53:38 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 09/24] eth: bnxt: set page pool page order based on rx_page_size
Date: Mon, 13 Oct 2025 15:54:11 +0100
Message-ID: <df0727b497d5aebf7c2746f0fb8b0f07c482feae.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

If user decides to increase the buffer size for agg ring
we need to ask the page pool for higher order pages.
There is no need to use larger pages for header frags,
if user increase the size of agg ring buffers switch
to separate header page automatically.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: adjust max_len]
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 13286f4a2fa7..5c57b2a5c51c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3829,11 +3829,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(bp->rx_page_size);
 	pp.nid = numa_node;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3844,7 +3846,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
-- 
2.49.0


