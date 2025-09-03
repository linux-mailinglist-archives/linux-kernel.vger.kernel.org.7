Return-Path: <linux-kernel+bounces-799219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF5B42893
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DDC1726B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A95136209F;
	Wed,  3 Sep 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="uYn/wP4z"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB322DD4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923574; cv=none; b=XqoBjcETHdHlcCfzJ1g8p5qF/IuzV/x6lZO9UhdbZhC6zQAlpWOJeoVMC3OhvZLlQQqEwskWRFayS/0o43emhX7AIpn7a5+1lKmUPxl/9rM8mdIoDOKA1phzhXPl8QZNkNwFk4IalYx77sXCx7fYuc7kZAVnFDCAe5kQMgBEqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923574; c=relaxed/simple;
	bh=6Jfffm6Ua3AWymd6nMsiCyKUez1IiVld7g/bqmJmrOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5C0SeEl/yFl5u/54xToUro9YMfvUkl+3sMwJAccC5eqI+fP+xGU7DUzSwSfCFoMsTQj8KRelSzh0Nzafw4fxvVMSulIEkpdBPYHbAY1Ty6Wv42zAd94xYZ5xMF7jiAWOCwkgjvXJ8xQcWPHJ+CFqN6O5M7SctKWIp85lHkWZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=uYn/wP4z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so108847f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756923571; x=1757528371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3PqNDVva9AiPaCqeSKtvTwY0a1PD50DZGYN4Z5/1vo=;
        b=uYn/wP4zKBMc/b0MYisM5TIDB3v/7clpAl3mKr0wPpElZWifVov0uF5VqySauX87CF
         QYq7GWh7hwtQzqU/D0OYfqTRgLOP29fH3SBpwYLPGibOv5DNavK9/ZN+SVlCP/mF+eWo
         7PQ2+Rd548ULJgFZGd2R7ECBrdaboXHIS61fSlcN2dsMH9U1OVdyxTJAxZ5xflPbJ1GO
         HV/zucnenwXMHupTt5p2lNlAjIIBq8V9KMYz3im5vjMcGVIFu3jL0KwbwtCE012OgML1
         dOkWiQywBKoNexiQwBW98p3LozuKXxddg/KDM0OhYXdk0APtz/COOtDYUGVasgCaoARU
         jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923571; x=1757528371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3PqNDVva9AiPaCqeSKtvTwY0a1PD50DZGYN4Z5/1vo=;
        b=ReNR5YR/ug/xK3GEw1B3eRR9SQSBeMgpJHvmkkf8laYYP0Jmra/Pylr8rPlTcdqcpj
         RlB4Gzr/fRJERW/3aelNQtESIEa+BN1TTCfUyhZubyHoHTBkV3BweAjmqsXk8EgUiDoT
         wnRB5y4GlZERB+9C8yNgGdI48FMchu27Uz90Z23pCQssRQIkG0CqBKEh7FzE5zY3D/u7
         bxHwZQ0S5v88qE9Z0/PBgcesB9gFoWGaq+Z9NCgFPwwR3MbRfGskjA62gnaRivK7IyKr
         5rK+Gv6GJgDfiGczcNi1wYqFFyXUcDpceVV2SWFNyb7I7o3YlgtS/I0ElcMkdy94EUm/
         p6AA==
X-Forwarded-Encrypted: i=1; AJvYcCXqN9apSPAqdJ+D66z8AdLUbkknjDdaIYXaH9qoNq6Qi7DIbTg3UUdtGX0TNRF8zy9PhjrpfpIp+dPrlKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAi5xt28tTRJf397Iol6u+bUR3Ktf40vL2PxuszojaU5FR08Z+
	WxyCUO1C2vS3T0u3RVSqIZNQX5703fApWmixHC3mrVnmANyHCyNm8Hr1uzNvWdD0KZ4=
X-Gm-Gg: ASbGncvcvYryuXVx3Z4tdrkuSrmO6XyX/dhZAqJ79R2bLiMpWZkBM74rZC5bzUlST+/
	W6/y6dKgJFlyMvQqz/5mG8GOy9dGjb5+nJGuMeopn2/BmLqiDCxdbt4t0ecsX63ufAqMlJVipqd
	w6clHMiqBYcT+MdTWiH4vQSuID5rLfNgzlM/LxB3eSuY5uCyub4OqCl8bLGaRfoyQuLDssbbF5I
	BUUE7mYX85wgdlgNLBaq8Iv68KDqujYqKqv5wN6me3sSqlqzXjQ1AOvkvW3EzN5VBZzFTNJYKT6
	oUR6DrGaX8wE91SsknDHGQR6gI8lsuHtRNtVlbi8AlagiL+ImZ5y1idqnFFgRGVR7Ht67g5hrDn
	TEFSvK7KhemlSNzmXz+KB/JmxJZVZherTEb3GJmbANgmzr+R3EO3klP3syizJ7m725pJK
X-Google-Smtp-Source: AGHT+IGTxOknj5RaZyA3JSSeXvkflIO38qpSnUEvBiIgHTzY8z8Chetm+wS+Zk0akLDeBgRS9qY3Vw==
X-Received: by 2002:a5d:5d02:0:b0:3d5:55c9:f218 with SMTP id ffacd0b85a97d-3d555c9f834mr8571425f8f.2.1756923570788;
        Wed, 03 Sep 2025 11:19:30 -0700 (PDT)
Received: from localhost ([149.102.246.10])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b72c55c1bsm350140715e9.10.2025.09.03.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:19:30 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH net v3] netrom: linearize and validate lengths in nr_rx_frame()
Date: Wed,  3 Sep 2025 21:19:15 +0300
Message-Id: <20250903181915.6359-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250902112652.26293-1-disclosure@aisle.com>
References: <20250902112652.26293-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linearize skb and add targeted length checks in nr_rx_frame() to avoid out-of-bounds reads and potential use-after-free when processing malformed NET/ROM frames.

- Linearize skb and require at least NR_NETWORK_LEN + NR_TRANSPORT_LEN (20 bytes) before reading network/transport fields.
- For existing sockets path, ensure NR_CONNACK includes the window byte (>= 21 bytes).
- For CONNREQ handling, ensure window (byte 20) and user address (bytes 21-27) are present (>= 28 bytes).
- Maintain existing BPQ extension handling:
  - NR_CONNACK len == 22 implies 1 extra byte (TTL)
  - NR_CONNREQ len == 37 implies 2 extra bytes (timeout)

Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/netrom/af_netrom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..f0660dd6d3b0 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -885,6 +885,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	 *	skb->data points to the netrom frame start
 	 */
 
+	if (skb_linearize(skb))
+		return 0;
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
+		return 0;
+
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
 
@@ -927,6 +932,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (sk != NULL) {
+		if (frametype == NR_CONNACK &&
+		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
+			sock_put(sk);
+			return 0;
+		}
 		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
@@ -961,10 +971,14 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		return 0;
 	}
 
-	sk = nr_find_listener(dest);
+	/* Need window (byte 20) and user address (bytes 21-27) */
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
+		return 0;
 
 	user = (ax25_address *)(skb->data + 21);
 
+	sk = nr_find_listener(dest);
+
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
-- 
2.39.3 (Apple Git-146)


