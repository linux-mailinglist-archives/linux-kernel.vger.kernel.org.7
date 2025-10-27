Return-Path: <linux-kernel+bounces-871802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF0C0E66F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50823463D82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF93093D8;
	Mon, 27 Oct 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW2jXaGX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC57307AF8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574556; cv=none; b=SwuZka+QLTDEVvrHc4zLP3k9ldLQA8B5FmyJY3JOnuSasLZ6XEb0mTB5Hyhh19LC0CutBUWCAb9TydulXOfWnCLBMuSJd7/4GAoZqHQgvOJZgt8kwPyZ6wE0zHXEl9K08zdP2zg/qYwUmLDA3m05qpeV9w1UvFrvvE/IWnQAxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574556; c=relaxed/simple;
	bh=JZj9auJ7JYGycI9LrR62D2gYRthD2d4QaIrDPfu4Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnN0oqTcoSdM2DpW19fGZiTWh3tc+tOyIaMR0qvPB2Fw7UDgMeKaiMS0uHeCaOefUq9+gML+hg6nlZCTRUNpxYAHEQfZl0SI5ZIQJ/x+vswfnVRYVcYnLTEBaM9cdIMMXBxuz6c7AQTgUdra4djhZp4+gSc1JcM9+gCUxWX8wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW2jXaGX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2253077b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574554; x=1762179354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=PW2jXaGXr8d8MXnoC/F/rUW6bezF7tGwtdmG9+abD60GHBL9XIBd/Z6dBC5pI6nu4X
         LOKZyIbO9Qe/P63CnKuunwInSgVrSWbvsDYX0C71h4QWJpYUXrfjyXhj+KjStsmUZ3SA
         AMCIykmxhaDyE7n6pZaBhRzZ7CP9cXU4mint0z/uQNFRTRtV61pSaWTr6sXEQa3zN45b
         k/52fA6UNGaI9BlOzi2mMBric5BHxZGOqbk02bragPVOG+sMmsmOiAamgixNnz0Nsy+W
         nMdT0H34biT3x2yXPWsbak3ImnahfTZ1HEKcE9aonx/cKgDWg0iPLGMHNBzfemiyH08W
         uItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574554; x=1762179354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=n/ZZjvOwQLf+Grmy4JvA9JM4POfAmE0sqJt9YbE56SCXZNnqDcEnT76+Ct3BNx3Ijh
         oy2c6t5HOy2e45CI8PkZaA54U2juZzCZWbng1ccjfya+s8gU3rjOGUloTnUJrfrLiXvS
         EjYp28Wt6AwrqmTIdcNLm6iDUUIfxlQ62q/cUwddXIdwweA9GfDPhEwJlNMOTW5Ffq39
         MjQZUmiwVG6fka/RZPLQDqpqGTtzLDIkoP0Gcp+omVGJsqs1EkVdAEda26IZ4JXhTb0R
         ciKmYdCAZjVzBoGkxfkH2bF7TLpPPJnPX9lPwl18/Q+rpu7RPrZ2a7tFNeDW/VPoQKnX
         +WkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHQRvP/1gZioQkfM2kaJcrvhsoPipU9HwIZFfFt2icEEasqBehkQXUkMrGiAj4vLqiYTpDBpiA/+7H6g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2xlyCgK/GNhyoPMaBjFggYIJUWlfNd0RG78I64+2mKeFjaBM
	sRCzKw0mG/I3Qn+h06ae3XmopL3uJGrsUoe7zSPJ4wqMTGw6WQoo1xA8
X-Gm-Gg: ASbGncsdgfc2ZCI1OsILfGefieM8TVGXO1XdfGPg5CYFy6uBUh87bPU4RHNezd37C63
	zAOiYiKt1H9xnySoA2gX8CfQv3BZSdG2m12JZVrBXa7+rURNwX7mx8t2Jass+nuWbJvoR+I6xO1
	+m8Sic9Bcly+io21XCbxLdQhReLQ63SU26jv36IbBcQwBr4qlS0t1n0ZoRpl2KywVDUJF0FZXYp
	hgFl0UM+pxulhhD6xX5t9gGEQ3GsHQ5ahj4TfnVcv/0Ql2oVgntQ8D2ZxR/o3WPrw6RBwnGiyFZ
	SLacES6/GYS7uGr5r/LJeAtj8s8JiH2vuuGH6ZNVJzFaxB6kTaEZqaPRhbb53+4Rz1O1oEiL2uu
	s/UsWSbUlnCcb1zkuQNDg+iu1dMwF8OB7Hc4QnFCR8DsVJtHUGJRYrKClSXQBCastdBdnqgDZmT
	XJwJeA6nmK/NkxXLcP7ohmS+IHBTkEOH9CpQ==
X-Google-Smtp-Source: AGHT+IE4ewuhHOjIKzBuurO8PWyGcEPZzNSnYycAofW4be6Zd5cxVgsCUw64WxG7+RbjBFiYdXSD8A==
X-Received: by 2002:a05:6a20:158a:b0:32b:83af:317 with SMTP id adf61e73a8af0-334a854648fmr51702392637.15.1761574553752;
        Mon, 27 Oct 2025 07:15:53 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6788166b3a.3.2025.10.27.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:15:53 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wokezhong@gmail.com,
	wokezhong@tencent.com
Subject: [PATCH v3 1/2] net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window packets
Date: Mon, 27 Oct 2025 22:15:41 +0800
Message-ID: <20251027141542.3746029-2-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251027141542.3746029-1-wokezhong@tencent.com>
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
 <20251027141542.3746029-1-wokezhong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TCP connection is in FIN-WAIT-1 state with the FIN packet blocked in
the send buffer, and the peer continuously sends zero-window advertisements,
the current implementation reset the zero-window probe timer while maintaining
the current `icsk->icsk_backoff`, causing the connection to remain permanently
in FIN-WAIT-1 state.

Reproduce conditions:
1. Peer's receive window is full and actively sending continuous zero window
   advertisements.
2. Local FIN packet is blocked in send buffer due to peer's zero-window.
3. Local socket has been closed (entered orphan state).

The root cause lies in the tcp_ack_probe() function: when receiving a zero-window ACK,
- It reset the probe timer while keeping the current `icsk->icsk_backoff`.
- This would result in the condition `icsk->icsk_backoff >= max_probes` false.
- Orphaned socket cannot be set to close.

This patch modifies the tcp_ack_probe() logic: when the socket is dead,
upon receiving a zero-window packet, instead of resetting the probe timer,
we maintain the current timer, ensuring the probe interval grows according
to 'icsk->icsk_backoff', thus causing the zero-window probe timer to eventually
timeout and close the socket.

Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
---
 net/ipv4/tcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a..22fc82cb6b73 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3440,6 +3440,8 @@ static void tcp_ack_probe(struct sock *sk)
 	} else {
 		unsigned long when = tcp_probe0_when(sk, tcp_rto_max(sk));
 
+		if (sock_flag(sk, SOCK_DEAD) && icsk->icsk_backoff != 0)
+			return;
 		when = tcp_clamp_probe0_to_user_timeout(sk, when);
 		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, true);
 	}
-- 
2.43.7


