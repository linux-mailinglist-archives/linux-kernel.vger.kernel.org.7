Return-Path: <linux-kernel+bounces-897874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413AC53DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128A93A2BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9173491CD;
	Wed, 12 Nov 2025 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1bO5TAF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F63375C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970677; cv=none; b=uYH/gv9XJ0NqkeH1N38eA0HxpNvEP111xii+REEVE37xPPdazwKVDUzFdivTO/2AIXlfJ1BuDp0Jl0SmxBvzKjjfEZc2So730HUqFi9fjWh/9qfVZCaFO95H1pMb8thjYHlMz+hlbjBSuXwXh/JawG3Nm2jQ2LTsWoBcQ5cWf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970677; c=relaxed/simple;
	bh=35PnpAEJSKZMmmhjKvYkQ215RwpMHnVFMt8P/XdW7lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf/ZxC+whnT7nHaJcxkCRqisdGILM/cS49QiAJdxqbw4alcJwM4JWkkm5OGGcU+dTSZpIXI+tVOTfXYo6i0afXDOr7MME3R8HeI41hbf/0A2pC02t+Gyla1Xy30992veFRAcbkh6QJAVwYa+q8ZS1b2VFqnTbILkXfI+pmulkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1bO5TAF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1000327f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970674; x=1763575474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjs87PRrJ2JNr9G8+c1Tv8wLpCpPRdNvapIiVHZg5Aw=;
        b=m1bO5TAForDqWwyl1V9RFjfiFrlWeTvXxSIR5gY7VLAC0xHlzRxWjmHt9cClIPx50Y
         rC1EX/qXz9tkQGs1THJ5Ir9gGVhGbCGY/OI+IPwhp8N6vBbsrW14WyDJY1KqR9JKElW2
         f79vAWgNzB7trBK5zghYNUaDIhQzavMep4UF2unjjRUnvAdLvbtdrAahlCX3UWzMeBfi
         hnB/aXoyk8NuWgbQzT1YyM3ySApxgiLnZMhHlevWfLExlG+ehHaVQ7EfPbA5a1+/uCzJ
         jvOuB+gT+ZpiALqhlpGN02SvSTh+1lHBA+JwCc9FL8zX3RqWNLqmrLY6bNmbr1BixVGh
         q65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970674; x=1763575474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjs87PRrJ2JNr9G8+c1Tv8wLpCpPRdNvapIiVHZg5Aw=;
        b=Zoo83PN73ikWJvSx8LwCyyBOxTgxIq80OLvTF5lEyxBAlwXQzneAvhkhO5MR1KqU6X
         YI4cStdxEv/b8IOmCM1S9pAf3dAzcsWFayrjMUZK0E1aUVhNe+zIn/0cUCWZZnX3Zqem
         efRkPvz6R+MnBmLghFxewGs8MyD6UMNIGRZYUfvGwZtHb+jtWyEtwz1eqs3CPbB9lpQO
         PIUo46Kl2RhJO4DkGPyGc/G/gErZBnMDnE1Db5nAV0tQxlAplqvogVCk5CnXnZ5H3A5h
         JUStH+phyrjngw4BBZVaPRHvkgZizTz24ytW0SWyEP60+o5oKCTut7Hw118DmjZ3FpSg
         DmHg==
X-Forwarded-Encrypted: i=1; AJvYcCW2R+X8HHSlciPRpjvxqlmgR5xNXH1BQmnDm8EkrOM1+NqQ+Pw6jAlmROennner08KZm9QVCD8g57MnDIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliKKnRPBUXkwPiAaJnaFS33Hp2hcSA4k/3zaKYS2tFXWjLaGr
	CrikVgpWUp2B/pUMLh4wuTuh2P+sNQU23DUJxDAys/OEzAuC1E2H3m5S
X-Gm-Gg: ASbGnctv1o0kObhI3xjrDP8orDnBqI3ood8ew3Xzf2gcXT5kvD0XS8pRJETnsSmpghR
	dUN6U1Gk1VDplJPSNqG6kJezzIv6a3+77q5Pv/q4VhBxQrAcNepOLTN7jTeHWZC/vtgGTPE/h6f
	qt17R/EWVcB0uRKuzYayRO1vnlJOyWfRSWeVRyDgvV+Jyu++Kn9d5Eppxbh5adiq3XP+n9Mu0Oo
	//nhX3/Rm8akY//51E9WKN4VY/y73L8PEQvxcK7SKNB22lVbwYcU4669ctc3D+swMXn8iZ7JBCX
	nGt6LDPXxogDYlNGR+JMptqQqhmW23jdzb49Pa6jwWtev5Vgtr6JJE+Wqsh7hT6F//bYHcRnApj
	KnxR3HLmG7hy6IK32CqOJAOVUZFw+OtuUhUupen2qSnHpR7XfLEQqRRdm07emgvzjHvbK/1MT
X-Google-Smtp-Source: AGHT+IHeyVjIewk2nxGI2f/Yo9rnAFD++Txt9J+ZHHi3v+ztQpzxrSPqRixtOX/wT6+GIL73xHFCeQ==
X-Received: by 2002:a05:6000:26c7:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b4bb981f9mr3973943f8f.20.1762970673365;
        Wed, 12 Nov 2025 10:04:33 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm25285170f8f.16.2025.11.12.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:04:32 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk
Subject: [PATCH net-next] eth: fbnic: Configure RDE settings for pause frame
Date: Wed, 12 Nov 2025 10:04:27 -0800
Message-ID: <20251112180427.2904990-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports pause frames. When pause frames are enabled presumably
user expects lossless operation from the NIC. Make sure we configure
RDE (Rx DMA Engine) to DROP_NEVER mode to avoid discards due to delays
in fetching Rx descriptors from the host.

While at it enable DROP_NEVER when NIC only has a single queue
configured. In this case the NIC acts as a FIFO so there's no risk
of head-of-line blocking other queues by making RDE wait. If pause
is disabled this just moves the packet loss from the DMA engine to
the Rx buffer.

Remove redundant call to fbnic_config_drop_mode_rcq(), introduced by
commit 0cb4c0a13723 ("eth: fbnic: Implement Rx queue
alloc/start/stop/free"). This call does not add value as
fbnic_enable_rcq(), which is called immediately afterward, already
handles this.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  2 ++
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |  8 +++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 26 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index b0a87c57910f..e6ca23a9957d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -73,6 +73,8 @@ struct fbnic_net {
 
 	/* Time stamping filter config */
 	struct kernel_hwtstamp_config hwtstamp_config;
+
+	bool tx_pause;
 };
 
 int __fbnic_open(struct fbnic_net *fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 7ce3fdd25282..c9ed13e37d62 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -36,8 +36,13 @@ int fbnic_phylink_set_pauseparam(struct net_device *netdev,
 				 struct ethtool_pauseparam *pause)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
+
+	err = phylink_ethtool_set_pauseparam(fbn->phylink, pause);
+	if (!err)
+		fbn->tx_pause = pause->tx_pause ? true : false;
 
-	return phylink_ethtool_set_pauseparam(fbn->phylink, pause);
+	return err;
 }
 
 static void
@@ -208,6 +213,7 @@ fbnic_phylink_mac_link_up(struct phylink_config *config,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
 
+	fbnic_config_drop_mode(fbn, tx_pause);
 	fbd->mac->link_up(fbd, tx_pause, rx_pause);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 57e18a68f5d2..c2d7b67fec28 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2574,11 +2574,15 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 }
 
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
-				       struct fbnic_ring *rcq)
+				       struct fbnic_ring *rcq, bool tx_pause)
 {
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
 
-	drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	if (!tx_pause && fbn->num_rx_queues > 1)
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	else
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
@@ -2588,6 +2592,21 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause)
+{
+	int i, t;
+
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+
+		for (t = 0; t < nv->rxt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
+
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, tx_pause);
+		}
+	}
+}
+
 static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 rx_desc)
 {
 	u32 threshold;
@@ -2637,7 +2656,7 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	u32 hds_thresh = fbn->hds_thresh;
 	u32 rcq_ctl = 0;
 
-	fbnic_config_drop_mode_rcq(nv, rcq);
+	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause);
 
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
@@ -2700,7 +2719,6 @@ static void __fbnic_nv_enable(struct fbnic_napi_vector *nv)
 						  &nv->napi);
 
 		fbnic_enable_bdq(&qt->sub0, &qt->sub1);
-		fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
 		fbnic_enable_rcq(nv, &qt->cmpl);
 	}
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index ca37da5a0b17..27776e844e29 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -184,6 +184,7 @@ void fbnic_reset_netif_queues(struct fbnic_net *fbn);
 irqreturn_t fbnic_msix_clean_rings(int irq, void *data);
 void fbnic_napi_enable(struct fbnic_net *fbn);
 void fbnic_napi_disable(struct fbnic_net *fbn);
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
-- 
2.47.3


