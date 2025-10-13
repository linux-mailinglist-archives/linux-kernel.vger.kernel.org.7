Return-Path: <linux-kernel+bounces-850815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA0BD4025
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FF584FBD18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51831194E;
	Mon, 13 Oct 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSKpqIQH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24456310654
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367224; cv=none; b=q6Jw5vHbaWIMdbNIBZn4A/SruAQYyHqEk0mXKAilxODCYrzkoowzyKhZqDfpxk41qZYN2bTw1ruOhftEso/+f8NxLyHRd/VXzyXV7JjT2aXG4XIcYFMv9an+pBtAC7F4Gd1BO+x/yGbhN2yAnx45SuNrvSPEFYt/4kOJt2Cr5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367224; c=relaxed/simple;
	bh=YfJ1fqXNyw5aWMbbwGECFiNPz3jXV/l4u98wRnHXoPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCavYVMJa28/iLj8/fLYX7yuk3A9eMCIGAbgMt4NvuLiCDdZsPmm+dV90a1Qp8H13Ga/l6OPvJYN/IQ1Zy6E3fZQiC97VBd6JMldttOYXCv8ajlOkdo2S8Ylyd9xLHYz/JaLCwhF0DUbiIbDIN42NfqNOW0bII5cWXRp/6Ob1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSKpqIQH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2537412f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367220; x=1760972020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkTczQTZHYryzPDWDXYNY8z0qrPjMacwqBMHw46Z8LQ=;
        b=lSKpqIQHRd3woDV+87HYJx6DE8z9s2XGSHnzaW+2akoWtXg4Xe8StTaroJF71q/hdU
         BHEp3Y4kR75wUi+xOs/FNXY/CA/trMdZzg+6qyn3dWT4gFSXzNKLjlms46r1MKeT8RRl
         xCfhwqdqlt1mODLzhvoGYhzeqCms9oWhCZmIXmZAoqCQaMwBXylgPByhLdh42fXbO20P
         R8aR0n8ijPEB/15RMK0aqBdXb2D17WV/R0xC6aW7fspUnQ5XVfY0BTcLU/NOoFO439jJ
         kFuGXDcrtq7U3vaYHMOkA/QVE19Vc9bzDzU/kBp9DJQsqkuGS4QHeQ+J1f0My+FqDmmv
         /CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367220; x=1760972020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkTczQTZHYryzPDWDXYNY8z0qrPjMacwqBMHw46Z8LQ=;
        b=UJk+h6r0s7TetNDRQX8iq0NUEdK1ouX0GekEZ8q5MewDic3sfmU2zdRbsfqPyrjtAX
         izQMsc6EwaTbTKaI7gPFxwMkW5P72a6KeHuuc23rSg0uu0kDM1gJPsQ1RlSCDVzysrFa
         ur98Cy1IYkFpgBRRZDo2fWDpwJsy5utRIWULkb8ZaN33KkZd0iLesVsEa9ogjhk8Utx7
         Ftcx+l3nXIeK+B7vC1sFwAR8UNK5SippIgMBV5i65i20muZWE1VCb7IH/5w+o7BkXOPX
         L2kr+2ZcH/LmMPnrsUTaGkPFlOrgJBIkGYn2WceEUM/+eLzrMD2OS7Y7gzG7kryQ71O0
         kn+A==
X-Forwarded-Encrypted: i=1; AJvYcCXO6fGNtou5PyKMZ5liip2NWaw45gzdi5USLgdaXgdsHbuSOgYljHwmWRdIOS3XQHQ1uczd92Z13FWaGuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn27OBZOIegPsG3YFIZKokb9bOsdh89YYIsx72UXy3uUOUWQ0x
	j/Sm9mb1XHKtJFks8Uz+l3D3UzEJn83EO4pNVDnrlSqfSX3eDZVad7ab
X-Gm-Gg: ASbGnctthzxGX6U54Oi8pTvfE3OWCT/o34QFotUvVJSsFrtAPqxiD7nPAhgWhwMLdAu
	0gNz8q9kMl9S93tqxWpxrpX48x4ejIZpzMBukKw11EvsCECbaqsEuZX9TNVyXT1oLHudpReFIHp
	oZSnk42z3BN+xqozj2uHQn77TA1lTPdjxujMmX64bAp1D4HFKmd/blzHAwWO5fPj+7Dd31qT8r5
	+zCzY2rhgaYE2Kgox7816GkuAgL1r/zld31MW7y/waZLVAMRO0HAltHdCn+pf8oWwGF2gQ0L28a
	MDWf06y38tmOG7RkVFZjPmLesZwcI2sKWGceebvrDimP+6uAPPSVIAnp5klb3adgUijqqqix/h9
	bZ2d5qeHzBXUi/NOGpGE9K7twhwNk8lLmux8=
X-Google-Smtp-Source: AGHT+IH1AcW1vbl3T0tBxKkGhV2edrcBa7q1HnLUi7VWiRaXXYXEc5A2MgNgOomw2NjVWPsYTALNzw==
X-Received: by 2002:a5d:64e7:0:b0:425:769d:4426 with SMTP id ffacd0b85a97d-4266e7dfff1mr12304230f8f.34.1760367220062;
        Mon, 13 Oct 2025 07:53:40 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:39 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/24] eth: bnxt: support setting size of agg buffers via ethtool
Date: Mon, 13 Oct 2025 15:54:12 +0100
Message-ID: <7760b969989404e3ea3fa5ed3404b54378b09e4e.1760364551.git.asml.silence@gmail.com>
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

bnxt seems to be able to aggregate data up to 32kB without any issue.
The driver is already capable of doing this for systems with higher
order pages. While for systems with 4k pages we historically preferred
to stick to small buffers because they are easier to allocate, the
zero-copy APIs remove the allocation problem. The ZC mem is
pre-allocated and fixed size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bbf4ff49ac0f..3abe59e9b021 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -758,7 +758,8 @@ struct nqe_cn {
 #define BNXT_RX_PAGE_SHIFT PAGE_SHIFT
 #endif
 
-#define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE	(1 << 15)
+#define BNXT_RX_PAGE_SIZE	(1 << BNXT_RX_PAGE_SHIFT)
 
 #define BNXT_MAX_MTU		9500
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 41686a6f84b5..7b5b9781262d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -835,6 +835,8 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
 
+	kernel_ering->rx_buf_len_max = BNXT_MAX_RX_PAGE_SIZE;
+	kernel_ering->rx_buf_len = bp->rx_page_size;
 	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
@@ -862,6 +864,21 @@ static int bnxt_set_ringparam(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
+		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
+
+	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
+	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
+	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
+		return -ERANGE;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
@@ -874,6 +891,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
+	bp->rx_page_size = kernel_ering->rx_buf_len;
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
@@ -5577,7 +5595,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
-	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+	.supported_ring_params	= ETHTOOL_RING_USE_RX_BUF_LEN |
+				  ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 				  ETHTOOL_RING_USE_HDS_THRS,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
-- 
2.49.0


