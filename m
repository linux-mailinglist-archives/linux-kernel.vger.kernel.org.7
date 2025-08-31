Return-Path: <linux-kernel+bounces-793471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7DB3D3F4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052CC18987EE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14226D4DD;
	Sun, 31 Aug 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="nyE345xQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF821BF58
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756652189; cv=none; b=Q3lRN1bAQjYLieRfjZyU6lZKj0DgTZ3QRqA0fgPSnxPbF3rqVBWLUKgd8T65DN8hS5iW9Cd1ggmoQNf41lfwNKqCYuqPvl4F0mOJnu/SWWLfx2mv59TXj59XLLBCC4/Bbz3aSiWzn/Fz5QOtj5Tj18+hqNaS9pus/VceNJ1CEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756652189; c=relaxed/simple;
	bh=EtfLYB6Ix1bHJE3YAm2Ocn1PZIurA8/YM1AS4zYQv1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ws/UCRbJHedk80Zz2POA+wLFkj2w4NzZfF+Is/AqLNJpqyAPKPsKdsGJ3CeXxDJJbSddNgQfUx3ZwtiAvm2zHcACw3rjjMo0J20pRx8Ti4xEyCO/xtF51WFGWEXrtTMKXk83C4uEhRlCfpcxpAUHh8NCPus/VTOqv9MEGSdY8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=nyE345xQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so1253445e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756652185; x=1757256985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=nyE345xQLfwxPHvLxyJ3uhaokRhb893FhFR76s+U7p4mLAY4I5OWSvpK5zDJ6/EVfP
         tzQ6MCgHE9KLZZvrI47zmcKPW3yjyHkUrOKVLcUCWERAvgB3ExiQ/ub1m/Ih+YsGFG87
         HHYo7xbLycthPDd4z5aY667Nmp8vQi1TEmja88ZyHBFmmKhE65p7fayurx6kR0t+XLzD
         FlRsjTrVZmu/nr4dDRHCdaORvFMaeWOsAkzo6t0CF669L3iAfzZ87itVXyHo5Pdv7sMV
         j5qLgiB5JXTUWH4JsxHcaRo/tE2u86Pb1fnxU/ppbMjvcSOebkFpvp17S9B1kfoTmVH6
         KSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756652185; x=1757256985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=ewFlN4CavgIS8ukaaxxuCSmCsn+1GcwNCckg3AWdWJKZSe5UJebl+pJYv8VvA+LkqL
         Uz7jfojljDZYofbsopZZxTAmu/B0LfaySLcK7NG/Fr5fUDX88OTCs3hhUcGxAFMa3j7h
         sSQ55jN3nK6JX1JIHEUEmUYGzhrzbiFAPENsa7V75Ti0IxOpyWH0eb9QPMnt+au+A7qK
         97CGLOXF7KEoUdW0IjfOPYkqd4vhXtG+yISkPnzaoU/hBrJOLA3umIPQyKJ2tbQNJgpS
         aCEFw+B/aYQxY0qKzF8RhX1nSP8Px/7FWCWM18nf28LfVSdVUIhgJhW6TxkNxiLbWVzj
         n4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSRiHV+yUWBhcUtB8z/cS1V3zTNj2jy1SZXSXILIVTxNEXXP9EtxqeTjaiBihqfjElEAMfbkKiMKDQ324=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIn3XpmgUoSukPWES3vfToN5CScHk9lYnjFFo6W0nQlH86Bhr1
	Nbe5WQvm2mEPKrVx9UKdR38Ajp/nU14tXe4QWkygIPo01BJKjevCS5yyBstwFMAMY0A=
X-Gm-Gg: ASbGncvhlR8C4LshJVAaQlBY6s7CkmaFCtrt+VdECHrrQekNRnIuVDvn1BsnmAxedkf
	719G10EET11hWs0Jb1O9w9aq6/PkL5OXZAfoL0llQHDdFGGSEPzzsZI7xKQT2fuDkyrck6TQW7D
	+x2UrdQFnsMNBzSKRI1+SWvUJbSxNtQ33T1qoB3oCksVo1In34RY3o7vzsjJu818OC+02mbISBV
	iJ3x8uXbCwbQmn9OmWiy9QvF4REca10kSQ/hT6MQmDT5odasVBCRZa41OBqt7mGbzEqGWrlKIX7
	tmfC6bhVTTxiTKsf/uhVYqGo5h0Vdj1hSXrDhURyddgqAbk6vMEk2sdY8JrYsKULvAkmdKQ/kSi
	+JgrDbIYy9oqb3l/S2Jv16gBrGvvkNBZwiW3379MXtjZVNnH/1koKpvdwe+mG73MEycy8p20Omj
	p5SN+dM04BggAMs4gXjQ==
X-Google-Smtp-Source: AGHT+IFECZm94cv0ABA94deFhM69SwEYykQaQ3t0S0Jj1eMYv2dW7N7j1CEH45wVfmQ9gpzQYScDYQ==
X-Received: by 2002:a05:600c:4715:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-45b8558ad00mr38526875e9.35.1756652185412;
        Sun, 31 Aug 2025 07:56:25 -0700 (PDT)
Received: from localhost ([193.138.7.149])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fbb3ccsm11425183f8f.51.2025.08.31.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:56:24 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED),
	linux-kernel@vger.kernel.org (open list),
	disclosure@aisle.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] batman-adv: fix OOB read/write in network-coding decode
Date: Sun, 31 Aug 2025 16:56:23 +0200
Message-Id: <20250831145623.63778-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc..af97d077369f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
-- 
2.39.3 (Apple Git-146)


