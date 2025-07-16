Return-Path: <linux-kernel+bounces-734277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF19B07F59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE040A4642E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6717291C2C;
	Wed, 16 Jul 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOxmiFxU"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C519755B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700354; cv=none; b=SBhkUwsTvp7c+7GHq5CwKBuPTrSQwWKgmfbNF8ShTIHlsWEhxRH1WbqrnsipUJ8SMz6sU5z8rWVD5hKAUzcfsJYfnal6wKZrkX4NNgfiFf78iz11Qj2lvgMWTZEGpRC0C6iVwQFlLtIoYaN1Ym9nfHeZtAxY39QsWuKQpDHTnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700354; c=relaxed/simple;
	bh=bE2hmpZk6nfAhq9yRQDtTrqnDJCp4qJzFSLaxLUsiEs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VzgUE5AkirVZV4118DIfEnWj3Z9OjrcwopnljbBdYxiBvqEnJbB2JTmfOe4JPEV+eZDcXcLaLU5QBZ9unTvIbkENUiql8clhk1PMPu9KgOapIvEKF7G1jDNL0PPiD3U3uAQuYAcv58W3BcS/RJembM2IIVKIAT4jT5RbNycsRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOxmiFxU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so277508b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752700352; x=1753305152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bS+xpV3zOGVjEkUbvaxcfcu5iay3jFphm1yv0dXxru8=;
        b=fOxmiFxUJ3MuAgSaYePrmfVNQWSDn4BF2jWXKGb3l7RzC8HMBv69zSwGB3GlwxW90T
         Nl2mdO0kb1luVoumjxEbxp9EVdNKF5HIBJFw2nNIpwLouHwIQ0yjk78gl5zZjBrHQimC
         vrVqemKmVzF8dYK5XIYaoclLvMmnd/Q2sN8OYLyxgNa5nByso4lLh3atvuux98IgezLX
         GnF3AIzjXFkl2YlXtSIu6S7tnS0LlDH84N+Fufg7TTKA5QjYCrW+R4b6kqcsyDBG4h/x
         /t5366ba0Vc18JU7VceB+CQeCli3eR8KGQOejBQcLw9TjjrYqkuSuR2SaNuynPi2mnpi
         l+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700352; x=1753305152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bS+xpV3zOGVjEkUbvaxcfcu5iay3jFphm1yv0dXxru8=;
        b=uceUcorc+fHpfQ01eDsceS5jJ7lFc4qVAYuWDq+Il2hHCquINz8c3zCTO3U5DyVZAa
         zM9ssBWDy34cLmugiT8nHUxdm6RuQyblQ8r1bkIFPBOUD59ZH+8fHTXQGuRGhqX+TBb5
         Y+i6tjiVFHxpE4hgpn9IH55OBJnRti2ofe/F1DlRn13IebJTxecEfsMqCCHlC/I69OKb
         bNWawHfOQLazo+NOjpYtBwUFHF6loMqKaev1Kz1A/Yoh+k4cOpeSIfrpspvM8QXFvyTg
         glQeMiPe9o/aYcKiW4HRWMIKwbid8RPyx7p314zdNXUs2+f1cX+pyq9TJiVkadQurN5F
         VwJA==
X-Forwarded-Encrypted: i=1; AJvYcCV9pQN4t8j+cCWBcegWZ/tzsIqJeo71Ddnr6AORku6lolxz64a7RRG9E7tPxF1H3mAoE8Yb7OAG6wnnF20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJPvZ45M6jryBPaepuKfuJcPfzDz6I5RZqoffp0bdJvBjv7FB
	kP0IeTYLt4zPCWCxIzwxFJhoDdouBdqM6nDsEy3pvdN2BAMPGZ9jsqHeiPEsM1egimnt98x2GtN
	QuZbqlXeLgqmjlQ==
X-Google-Smtp-Source: AGHT+IFp0Y3qf0j8IoxbNQMboo8HUABVitL3rc+jXI2qO1HNqcxupsp4DHCARmZZ5MeqkQfpQ8Z5oJBIzPN2Xg==
X-Received: from pfbgt11.prod.google.com ([2002:a05:6a00:4e0b:b0:73e:665:360])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d87:b0:232:a1a5:8c1f with SMTP id adf61e73a8af0-237d7024c9bmr6835815637.26.1752700352218;
 Wed, 16 Jul 2025 14:12:32 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:12:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716211230.3592838-1-skhawaja@google.com>
Subject: [PATCH iwl-next] idpf: set napi for each TX and RX queue
From: Samiullah Khawaja <skhawaja@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: skhawaja@google.com, willemb@google.com, almasrymina@google.com, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

Use netif_queue_set_napi to associate TX/RX queues to the relevant napi.
This allows fetching napi for a TX or RX queue using netlink queue-get
op.

Tested:
python3 tools/net/ynl/pyynl/cli.py \
	--spec Documentation/netlink/specs/netdev.yaml \
	--do queue-get --json '{"ifindex": 3, "type": "rx", "id": 2}'
{'id': 2, 'ifindex': 3, 'napi-id': 515, 'type': 'rx'}

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index bf23967674d5..f01e72fb73e8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4373,7 +4373,7 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
 					 struct idpf_q_vec_rsrc *rsrc)
 {
 	int (*napi_poll)(struct napi_struct *napi, int budget);
-	int irq_num;
+	int i, irq_num;
 	u16 qv_idx;
 
 	if (idpf_is_queue_model_split(rsrc->txq_model))
@@ -4390,6 +4390,20 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
 		netif_napi_add_config(vport->netdev, &q_vector->napi,
 				      napi_poll, v_idx);
 		netif_napi_set_irq(&q_vector->napi, irq_num);
+
+		for (i = 0; i < q_vector->num_rxq; ++i) {
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->rx[i]->idx,
+					     NETDEV_QUEUE_TYPE_RX,
+					     &q_vector->napi);
+		}
+
+		for (i = 0; i < q_vector->num_txq; ++i) {
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->tx[i]->idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &q_vector->napi);
+		}
 	}
 }
 

base-commit: 4cc8116d6c4ef909e52868c1251ed6eff8c5010b
-- 
2.50.0.727.gbf7dc18ff4-goog


