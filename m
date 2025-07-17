Return-Path: <linux-kernel+bounces-735890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E1B094E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59B4587AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C72FF484;
	Thu, 17 Jul 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaWqBezb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A412FE321
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780030; cv=none; b=SwB9TxEEQf9im7aTGEqkY+d4KByLvtPhm0NZunTLCAnI13AAMMy/nU4buWIxBE1raoe9y7a5EJQoYFm7bHkfA/M4Cyn0IfzVKYwhpWqaKi9JwnuU1ZdeQwe8ePoOXT3XJtXVPdjnlt3Ld51ZfCwmqEZrxzKbapo3fne4r9KisFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780030; c=relaxed/simple;
	bh=qHNE6ZJsNsPHrMLOVMlNPJ1T9cDi7uaDRJUDA35BTb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BRUkCCVK6gOnZCiKIMDI73TtYfAqCPy522d7OlAyldcA9/V+pvwl+OExDuaPMToq0XR+7g1ZAfqyQEnL/iESYO8Orxqnqa7rEbHCvQ6f/SrcZ0ZRxM88jmZWwHbNvH4qbEyLtSIMPyAA3FXN2sdQq7iykwz88Zvhuth7hQco7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaWqBezb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso1325556b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752780028; x=1753384828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HR8MX3mhC9f/vMePEVzAQse8ycjHGoEB8XupYWNC4G4=;
        b=IaWqBezbXIkLjDNaoGB+MlwdD1pruj2ZbzfmKZ2QiGS5h0VaJ3b0XdeWAJWdJYru22
         6yoTT4tDf2k0ufGvFa+x7O9AW6pO+14NEQ+sLnx5SI1rVbzAcOsH4hytR6lH2RY96wwW
         L8PPDGlbtOFcvsZyOnz4CVC801aBxgfbICL/wHYuUYkA13noBKhVtcwECP1rnZJEiqaC
         FNetg/p8flCbis+oVAlmMOutQN9warI1JFqRGfu7iUMvqxPdmVgNNWY+wqsrPmoQryNk
         pNiSHamVHUKClXyPcKuI33C7EYTpSjaBN9AOMn/2tG1vwa5col1nraiLlkt/basc/HSa
         6bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780028; x=1753384828;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR8MX3mhC9f/vMePEVzAQse8ycjHGoEB8XupYWNC4G4=;
        b=q+MwwKFAstpbYzW8e8StunOhzwjSmVTuaWJmnuDQKqWItm2xUH/LX5mIhRP7ppOGr3
         Dql40SHEME1FuVbGosBUDccFbkkWK7td6x66MxshJNy9RBACHyLREGMMxyFtm/OdGMY3
         A9iKXCm6bQXFrKB05CeOn0dNfgGThDWUQjd9506dbhnOKfQvsUNI35SQQZjfrEk+NoFO
         Jl4UXp1aedaoAElwqohIZcutntVa/Raxt+yesEUhIOhTycc/0DypYaAU70cZ4ExQb5zX
         hclo+Q0L+L9nLb3d4HH/W/2WKVdzep0o3kvaF6+cRBbpn2C1yiL74fnupecz9/dEdjPr
         ViZw==
X-Forwarded-Encrypted: i=1; AJvYcCVhjBR0DD2wx3aNgJSdbTAdbWE5NlDu9HYE+Gf2M4afVHzGC5by0QDU8pEgrhLQB9bAmkNqpjtdiqmt/gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8C7f9b0zDwxG+m8a7nf9jdsBJwvZmePBC1uj52RQUBrvUb5zh
	4894TO/6/VakQPOxTrFRmPqhaajJMVfcM9S4IhVyzQsvzDFlSzBWUHhG3kTegZgRtnhCrO4Zs8H
	8pzmd8yDjTF6Kycn1/oh4DvjGag==
X-Google-Smtp-Source: AGHT+IEtBesc2N/Fs+i9lOTd8XbLy9wXA+Q1KV0da06KAym2OQZ4lDK2l1GvqB7GpOLTPoD+KcroaFJ0N6GKz0JNag==
X-Received: from pfbki26.prod.google.com ([2002:a05:6a00:949a:b0:748:f3b0:4db2])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:985:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-756e819fa32mr11350357b3a.6.1752780028251;
 Thu, 17 Jul 2025 12:20:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 19:20:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717192024.1820931-1-hramamurthy@google.com>
Subject: [PATCH net v2] gve: Fix stuck TX queue for DQ queue format
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, willemb@google.com, joshwash@google.com, 
	ziweixiao@google.com, jfraker@google.com, awogbemila@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tim Hostetler <thostet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Praveen Kaligineedi <pkaligineedi@google.com>

gve_tx_timeout was calculating missed completions in a way that is only
relevant in the GQ queue format. Additionally, it was attempting to
disable device interrupts, which is not needed in either GQ or DQ queue
formats.

As a result, TX timeouts with the DQ queue format likely would have
triggered early resets without kicking the queue at all.

This patch drops the check for pending work altogether and always kicks
the queue after validating the queue has not seen a TX timeout too
recently.

Cc: stable@vger.kernel.org
Fixes: 87a7f321bb6a ("gve: Recover from queue stall due to missed IRQ")
Co-developed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v2:
-Refactor out gve_tx_timeout_try_q_kick to remove goto statements
 (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_main.c | 67 ++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c3791cf23c87..2fdb58646132 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1916,49 +1916,56 @@ static void gve_turnup_and_check_status(struct gve_priv *priv)
 	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
 }
 
-static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
+static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
+							unsigned int txqueue)
 {
-	struct gve_notify_block *block;
-	struct gve_tx_ring *tx = NULL;
-	struct gve_priv *priv;
-	u32 last_nic_done;
-	u32 current_time;
 	u32 ntfy_idx;
 
-	netdev_info(dev, "Timeout on tx queue, %d", txqueue);
-	priv = netdev_priv(dev);
 	if (txqueue > priv->tx_cfg.num_queues)
-		goto reset;
+		return NULL;
 
 	ntfy_idx = gve_tx_idx_to_ntfy(priv, txqueue);
 	if (ntfy_idx >= priv->num_ntfy_blks)
-		goto reset;
+		return NULL;
+
+	return &priv->ntfy_blocks[ntfy_idx];
+}
+
+static bool gve_tx_timeout_try_q_kick(struct gve_priv *priv,
+				      unsigned int txqueue)
+{
+	struct gve_notify_block *block;
+	u32 current_time;
 
-	block = &priv->ntfy_blocks[ntfy_idx];
-	tx = block->tx;
+	block = gve_get_tx_notify_block(priv, txqueue);
+
+	if (!block)
+		return false;
 
 	current_time = jiffies_to_msecs(jiffies);
-	if (tx->last_kick_msec + MIN_TX_TIMEOUT_GAP > current_time)
-		goto reset;
+	if (block->tx->last_kick_msec + MIN_TX_TIMEOUT_GAP > current_time)
+		return false;
 
-	/* Check to see if there are missed completions, which will allow us to
-	 * kick the queue.
-	 */
-	last_nic_done = gve_tx_load_event_counter(priv, tx);
-	if (last_nic_done - tx->done) {
-		netdev_info(dev, "Kicking queue %d", txqueue);
-		iowrite32be(GVE_IRQ_MASK, gve_irq_doorbell(priv, block));
-		napi_schedule(&block->napi);
-		tx->last_kick_msec = current_time;
-		goto out;
-	} // Else reset.
+	netdev_info(priv->dev, "Kicking queue %d", txqueue);
+	napi_schedule(&block->napi);
+	block->tx->last_kick_msec = current_time;
+	return true;
+}
 
-reset:
-	gve_schedule_reset(priv);
+static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct gve_notify_block *block;
+	struct gve_priv *priv;
 
-out:
-	if (tx)
-		tx->queue_timeout++;
+	netdev_info(dev, "Timeout on tx queue, %d", txqueue);
+	priv = netdev_priv(dev);
+
+	if (!gve_tx_timeout_try_q_kick(priv, txqueue))
+		gve_schedule_reset(priv);
+
+	block = gve_get_tx_notify_block(priv, txqueue);
+	if (block)
+		block->tx->queue_timeout++;
 	priv->tx_timeo_cnt++;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


