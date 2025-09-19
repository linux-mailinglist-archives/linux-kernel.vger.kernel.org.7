Return-Path: <linux-kernel+bounces-825035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D4B8AC42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169E05A40E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38C322A1D;
	Fri, 19 Sep 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Cl3pj9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC322766
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303027; cv=none; b=Wd7AJw4Yc8xWn036LTzc6fStw9+bNfFbb0rhKxXso6fRXThsCMN5twxBBE1Xa1/s1XD7tlm5F6ooqqXX5QugX3E7wQCMhK4imAKsiEaMMHKGcgBqUd8lvrA2TrTgjFbPKgctIhWYDQrFvqJgMaRPPVqPQzs0Gb6YN1N6E3/rro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303027; c=relaxed/simple;
	bh=JZj9auJ7JYGycI9LrR62D2gYRthD2d4QaIrDPfu4Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtwUXy197oSWK4Rl703Q3nRRhtSjuc6r8Q7xCOzzJsYFSi4Dn+GqmhCH5VRuYcO6FXFYyCf7yAlYX0fspyZ2isyO5efG5n2AI9ETgnTnwEcdWRyF8QIYG9xixsQN0IoObVaWJt9vse1Jj5HDwrFUUOcP0J0Wei3v1LgU9WM/7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Cl3pj9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457f581aeso24401205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758303025; x=1758907825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=O4Cl3pj94Y74HTI235JeXeAuHXdQRYeQsydVKpBRkTj1lkDJZ24cUdjOAz9XLuu6lA
         mWCNpygvRP0OCCBSuzarLOkUmE+6fho3SCB4zy4O88di1zviUXC/VkTqJCqLXUxHmLWt
         4LGAS1OQnlPUEysmxw4Pol2r69+SVjfuCLH0/ND2KBuQkc70x0EgRIvjtaJ/MDZVlNKV
         SFdhK6CzpI5nl6A6pG2ZzoxbcK7PK4VrkcIhn4wHfMSQEobNzZfU+AuXckqAk8B7cLyP
         /hDwsz/F+7kGpPm0xUUlNDiVxqXyyTtldDqaoN4fnzQAmWvoK7rmSJzdx4VrbNWBwl/X
         lw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758303025; x=1758907825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=hPjQUDoInp2kF2s9DwmLzgeyqx+0zUg2IcC36GDS58H45WSFmT0sXVZ8JfPKw7gaB8
         RxV/mC0iZFOdqabF8ITHOq8LEDu25Tyd80asFP9FfGQVM8IGY6jsTnFOhgzWvMZnnM4u
         7TzM9RGcL7pIBnY0B03DjUzne69SJS3ffEhNT2u0TgYbl/hQLOnAnZHedSIJ2zahRhnr
         vD0njzsPFbby6J9XZVWNT1fRfjqXU78Uo4WtZF5xtze8sMF8lEw6P7jZ6g7wQ8lFwbCQ
         bwYz5OuV/UEUkAG/MQQ34UUGektNrgDcnV5V0GQXvDIskVwVXDKO/YJNCNbJHuyshqSO
         0g8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa2WP0J+GxXdRM0PYh+bB7TKLDbHCYkXCXIRitxVVqSAV2KjWNZQnZWsoo8lj+KM07AQCe5pIwvNRm4Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIEwxS8rWl1mdGPq4zUHoXjXTbxveW43ksKzP3aXstv3fND+H
	cOXX6x4/OhqgpUNfBIussext1LRK/uXcR9+cp15CFwPuolTUnl5JEm0o
X-Gm-Gg: ASbGncuY/dg3vUgEiPW/tFUbfszkPhSfiZNG16uSyH9EIpBKjPvX5tR4kK94oQIp+wR
	hOLsJQE5W7ksdjktam57cSCHbtB23SweGZtgfExCaIP8i0ZJmdx5NAGnL2N/Rl3DqQRoHeITbvT
	NkMO7saNdg/AQDljRKbMaIGAI3i8U+BiK1yGWXJEhpUp/fB8e/uwrHIryYMcEKAgpo9xS5HX4gz
	ZugDRzWMeYmOLyF5COLPXF1VVHK733OIW97f8qEUomdDXId2QZY2RRRnsff/7cDt/PdoDDPBwLx
	8/Z91GiOEjth6LvfvxJNRGxioULbElBLcDEhVO9xuLFYpYEN6uYWwV9trmowgf3W4ACXWVMc/aB
	b/5UkHUY8uu8pXbhfO58AMEicrq3dO4f2WLw=
X-Google-Smtp-Source: AGHT+IH4tmDryks4lpWMvZ7RPdjoVOLv7Whjz+fTz4uGIXQE7YrtEn7NauesGMcUefMfTnayFjWwpA==
X-Received: by 2002:a17:902:8bc3:b0:269:b2a5:8827 with SMTP id d9443c01a7336-269ba467eebmr44697195ad.16.1758303025452;
        Fri, 19 Sep 2025 10:30:25 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053ef0sm60865185ad.28.2025.09.19.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:30:24 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [RFC net v1] net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window packets
Date: Sat, 20 Sep 2025 01:30:15 +0800
Message-ID: <20250919173016.3454395-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
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


