Return-Path: <linux-kernel+bounces-852632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53097BD9805
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E48218A6F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F73148D3;
	Tue, 14 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwMl9ymu"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE0313E07
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446835; cv=none; b=VtPzqewkRLGS56DcanqOYKC5Svf/SpNgA3ruh14/GysxI7T4r+lcld+1Wo6XhzhXpYNuLyhv3E7fjA81Q4cAU3JYu80xKiHyKzU5iOBX1Dzuo6ij4f6LBoJs0ldj612ksq6cO4iMcFcBp4YGP+6MSQfDtt+aP56DsWYDZGruaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446835; c=relaxed/simple;
	bh=8sl8zh/edgEOL187hvVRKslTd9Ju8bi2edrvqaXpJ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBs+HcC9PRw4IA/dUoOz5rIuI5R1SloaS/Ij5ojr4jTX2E3iJnVbuclwwuPsVVW/Tr11gmhnx8AR4xLzPGIeMFqp/vt2ORdIsowLFdeq7OiHfAnBDrde8EeDsTOdEETmpcNDFIIz9kTF5dz0T0WsHAIMg0uOfV8ih4YEjnVd04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwMl9ymu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3274421f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446832; x=1761051632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eHv7iWS5Rns6GMFeZ+EPNWQuD+MpI0tmNw4Ue2Rubw=;
        b=DwMl9ymuaASIc2CqbtCQf1Q0NTrmkTfrESnUsQYjUkvV0ApahXP6xW0E3QPOnporiB
         0PzYsKi+aSTzgtqgkViD//LVF5kcoRy79xtjDQtem0iW31PWu8X4j3EX4bZGQS/X0t6v
         ShL0duq0RxfW7nnAt1InePAj9lJ624pP5V6KOL0KCVaL2rD9Sltea1c7IYiGOB4uHi4V
         iqDVPpFCYFaZcqFlIVlFwngwdvZ5FDZJQb75DT9tTTuRxqQOlkL+V91CqKE0wUPFeAPy
         eQ72Miuckzpc/GWI957KVCx6ESACBSlevvFz1LagIDXRt1/dAbbRufmAkBFIGE9dayfn
         YSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446832; x=1761051632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eHv7iWS5Rns6GMFeZ+EPNWQuD+MpI0tmNw4Ue2Rubw=;
        b=ZWUgYX24CFv1f+Xs1IhC/WrYYNk+soEXMpAPLGgRwAgTg74s2k8WDq+phrQFYc0jFa
         lZ1Px/TI9cfXPE2prjxCWtobzFJ+P5fWuskKuyyrUJ/ZhACuvEEpetLiKdojkrqBZXFE
         3wEO0o1K9G8qoCLfpD1cDB6eRs5rBn/ivrbK40BH8e8WfYHzkixRlPvZON1VqEV/qxlK
         8xIY1S0BtZI9GaXBgecKcGyiSfJjXvV9DPISwLJRKz40yom3awEbWmPGb2wufvYY4g1k
         Iu3FHx9aBOirfpYe5Fr7yJykYvsP7Yt2E7YfxIExevSOR7ZLJMDnD1oNPAYXlTrOeWMJ
         qQJg==
X-Forwarded-Encrypted: i=1; AJvYcCWLrMygcPl0Lu5NSs1harIOaKfK5Gbnl/7I5f2RSz+uRoKUF1UVEqLqA6bnl6WpVLLRGE0ZxPHay1JvC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOIimGXnOQAlSel7xMqhvUarTO3XDRTyk4e87uk8BNA/f+Sjt
	sBepNiH1yJYPhIktbt8f7VflVoV/l3aBvK0RytBdDNJfunH3bbLVSzFz
X-Gm-Gg: ASbGncsX8h7/zZOIoS/TpR0OC2z2/IhziWYwNMPLM7fOqxlSd5xlsDzIrEh+l06RGJo
	FJhL4z5IuUfdAlABrqR81z6ZAoL1j415nsnm8fTypRYG6HfjF0hc58lLjE07mDobGlxLFgFzHzC
	tVkT7+Gxc2bdwd4WKALAQPxWPxdlON/bmyOOY5uyA2CbKlhUoqezEEYFAiDlHoc3ISNbyNp8w0w
	ZdYLfMiMKwhaHKpQrW5pw/dYF1+VY3qWKgq9vJsg0wsjuUsnQd5i7lHJ172iE6Xpn6DRlyTxs9U
	TWVP7pYB6qwbfLl7Zw8fThzNgFMjhUi4P0OXucLlYwa1vZG4mUbI/2bdZNM4ul3i5C31HfOMWeQ
	GGgKkAuXU8ROqF819dscxHckMXc4AhD3ne04=
X-Google-Smtp-Source: AGHT+IHTVOrXrZfK+kAqvvmeegQqbXJ5u1kSQeQq4d6GAFTvHJqKybjw0WNnBMaqSNBLp4I965jdvA==
X-Received: by 2002:a5d:5005:0:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-42583349adamr13032753f8f.1.1760446831885;
        Tue, 14 Oct 2025 06:00:31 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:30 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/6] net: memzero mp params when closing a queue
Date: Tue, 14 Oct 2025 14:01:22 +0100
Message-ID: <80f18e7ee9bd50514d7dca31b5f28c5b0b27e3a5.1760440268.git.asml.silence@gmail.com>
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

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.49.0


