Return-Path: <linux-kernel+bounces-867217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CEC01E42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CCA1A66298
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621B3321B4;
	Thu, 23 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO93ORRL"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FA331A55
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230919; cv=none; b=NCylpQdjDG8S1bLQb6iKYY/bb8yR9yIsyWK27x2sMcsDfC1IB13LCWfTWog00WGHxmmAhl7jcW5MF5j06XYSs2C/2T+nYEx0eScAA01PdrB810zPUneE7I370+b3cTDm5jIP02B0dZMQp28LsJbAHhNtvOtfIpyT7halzNDV0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230919; c=relaxed/simple;
	bh=JZj9auJ7JYGycI9LrR62D2gYRthD2d4QaIrDPfu4Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owcXPDzPUhu5PDubJcLd+VNIoDD3wMs4vjsYkF6bcPAkwzrtFfJzop2cX3izADw9fFR0bTdGve5KMlrs3OYmS9iC17Sf2iQ9ZoZNO7E6mTZIsnrX1XdYcXOEhQCNGMm67CFc1ek3Qza086DhEbaKV8Sa8ZfLRYYlwLS3OyDN/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO93ORRL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso1046571a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230918; x=1761835718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=dO93ORRL7KkyXq0+NXln1mFyTwiweCqMNAFLLXmbyk045Sg0mJKbPLaejnBI/YlkH/
         2hHayxoU6KHPv8jj1srDaNrJUN2Xf1A1VRNjZ5Bry73Syj7emY1pPKXlIhivM0Nv6cyU
         Xdg8BTP/apvzx6lMdh8ucMah7YvnKRd2cdsA4Y2BVRLoO6ciXfdg2zQ6PL/jAsh5ehxt
         RiZnNCLbV14mDFwXxIN01cA52HT5z4saAw3Nqn2wq/laCQs6jnX3DFHy2ylbhbzuyrPX
         fW6H7svavJHJNroVxXs7Es7ricFfSYOshVbIeZSE/gELMIga1xriyfuXoqD+G2KYHrpj
         ugNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230918; x=1761835718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=EB4NnqRqC7gy211NFT1X7UuAPU+46YHIc0XjzTRQq25dF6UjHWwc73RSzEYt4V5+J7
         iNxyHtH3ZXa/3uiVa/Ub0Y394z8W7990QC7zEQPgEQkZSRVk6eGOm7uVZzRQUnqjlUvy
         f1zoTzBKQwDaAQcjDcbKNcK3up7U2izafhGNKtr8S2Iu9cpinZLlkb98oWHQRjEVLMJb
         TrrDEOUrN8kscurtPeusJ5t26acwieEKZmnnMiMJh+cIJxJrDVG/OJbHMOhklJcjQeE4
         5SVs7QdkgfPhvRy4U2Q8XZzJqa0IDPg4yLRMCXVLhOj5psmQKN+JFd8kE1n0cVA12iF0
         +rew==
X-Forwarded-Encrypted: i=1; AJvYcCVTvCd/QKdoJngzwGRNLpFEyKLcFmUcA3doO52zFpZQcgb2bFdnh7H2Me5S8aQkS5zeRyzia/C/rihUFAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCvRnTFZTK5QPrYJCDLNrBIY1xEifWs6pz+awylT1icPnvyjo
	vw52H4OqI/iY5ni++M1xz9oaEfMX37pdvNhiHkoaDNCgVYZ/aTpE93Ny
X-Gm-Gg: ASbGncvV7wTAH5AYHQNaY8LsaixCpNMarSHCDVjVThiYtlkFE8xd1JeYFqllN4RF13x
	MeyDl9268V4sW0VwQ9abqoqc04VcXlXcorU9VtKR06n+ezyxm/HyLpp7/1rpYlndz2MEm6A+Bli
	WPq1kJRnuP3tKPsSCgw6CuCsD4dtVc3JssYhPdzNdud4QSc1SFwtUdg0bhTbptJjtTNTpwzjvVv
	JaI0JaKuWn3HaC078aVe83vDF97k0ANhJRIfmbBV4qGQo90ALwESJnzL8P/HSOu9/IHPGK2jqnl
	GP+VE+L3zUKVk6lo9r1F5emumuxtRqjaUi32BLohBdGbSWp6WRm75Nt7xir5Yv9gQMK6fa2Ltw1
	NhdcxIQItSy7N36IMw2b/vcmCgh1rjtI2mHwQHRhKsMnVdvrgqS3EvybdtivWBdQKK968E6kdZL
	OmPGu2+VxDCJWTFeVdwlL5Tq4=
X-Google-Smtp-Source: AGHT+IHFnP+dNzR2Yod0rw+D0nRCh4IMvaIH69R6QfSNYJtyQuMQ9Y/Stv1TY6C8rzjwn4OZCUgTnw==
X-Received: by 2002:a17:90b:28c4:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-33bcf8e6348mr32236334a91.21.1761230917698;
        Thu, 23 Oct 2025 07:48:37 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm6045716a91.14.2025.10.23.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:37 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [PATCH v2 1/2] net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window packets
Date: Thu, 23 Oct 2025 22:48:04 +0800
Message-ID: <20251023144805.1979484-2-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251023144805.1979484-1-wokezhong@tencent.com>
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
 <20251023144805.1979484-1-wokezhong@tencent.com>
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


