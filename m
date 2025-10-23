Return-Path: <linux-kernel+bounces-867216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F77C01EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E075B3B03DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A833030C;
	Thu, 23 Oct 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXR9j7CI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FE32E73E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230915; cv=none; b=Qf1q62k6Upuj8BYYC4DkA/RSl2hs5QqC0xmVcxLm1ms+7NUlm13/ns5/DO9n2/bFO436FAHqTcoRtUesjDufEh6TaYcennXw9C0auXOHwxjRH2Aj+4Y8YCl73yWN0qkYhPua2wq8++OaxcE4pXR6dMyj1/NJLxtzDiBt64eKI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230915; c=relaxed/simple;
	bh=1RLm51KmhDL4fPLUXOHnRQ9p9SNejUKMXy4N86leZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtg2EIDllu4VCvm/tkmRJwAV89t8+1Tg7M95uMwxecSxxp/mF65ywXxNX0IE2f/NKIv1scrQod+I3ML6QWRVQvsTstusfaCJcXwghZFYOFd49+FNlbnNb0FbEU1546+6gpIvAIdWqAs5YCPPZmarRe9ZoEV2UI1L+abizBNeffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXR9j7CI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso671237b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230914; x=1761835714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtgf55Q8soB7lkjT4R/RfaWXPHzbko4ONHYYpSLOq3o=;
        b=dXR9j7CIqr3fzReU0Gg8RQwY/6p+mX3TzGwOz9/YPdc2azkpLpNBvhFNpokCXn8Sz5
         aaiUPd78mHphDJr+IqZvL1yTfKf/nxFBu/8rmgOGnleisthL4MQugkT5sjmbyPzqI0LV
         nAYjQxLIQNE64nsZbyJV0RswDt7DzwxoyTf3A/5S6dZM0CIBcFGgb/yPcgVlI6uSF8mR
         rm9spHCGw2tRSfQwnyNfv5uEY6HZckymjRtO90RvDz5Q2hrWa3aUXjtlGcW1/gJ6m6+x
         1Yp3VQ0LXmzLOsv1/E7V0gzIIGeZIYRugUbVwQCUsIo9sQv3Fr8S5pro140Ztv47UfTy
         GU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230914; x=1761835714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtgf55Q8soB7lkjT4R/RfaWXPHzbko4ONHYYpSLOq3o=;
        b=kHwCeXz2jNLR/Oqn0CPO7YCkSBV8qRRj6U95JKJk1jiGqRgZAo/saeN2yljKhtpoAO
         hoQPrxzeJoifsODzSqucrKWBAAH1NYH5oyiWxtwSti7luvdwj7PjOsXhsXuk+Ef3v9a6
         zSRHDDekYRY9sj2rTqQ9Gzh3A/dCwFISM1J/eF192lglPN1Rz8hwnZSQ4cBLX1EJUiHo
         n+84rxQzvZcY7eyf2M/dnPdvuvMHybXBejKBoDp8L1vlKEyL3fkTtUKXVXyix+Z3PzA5
         l1XFpejWol8/7yglIsMQbsnmn0oZ/kBQESfx4TOgRoKpIBZ7TfvDCjA1avE6ergzcYAz
         At6g==
X-Forwarded-Encrypted: i=1; AJvYcCV8qEGu0gquUdxzlYmxjqs+b3Maz19mDrcMw2W1K2lE8bil4oe8VGQs4mDEt9mi1/qmfkx0NDt4LqstRaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9qQgHkidXvb0tNxfbEfcUESeBeVxRr0XbfkU/UBPryEmwQnL
	QH/+ew0qjZUdV3y3pCxf8c4TqcqT3ZVkaNUy9h2z1nhvSlWJ2W7eIvO7
X-Gm-Gg: ASbGnctNAzOjpG9EAgxb24KtJ67LnG9NJj86diwC6fq4/FFnkQeGn55WZ0uIMUTPSXF
	KjEXkXW8wQk1iAwj4mLO9ierKsU0VGad+rrn9rU5fHbSIZB9ZqAXhky8xDXzoESTCDlcbNLJAH+
	/YMYznA1qtVoQIM+TSAXCsXSnwpt3aKms/LeAI+yMKYYW1trRWJ7cdMSthv1XyVwoFHyTZno6x5
	aeWxU2kWGAxjfqJm7kmPZfF472rwnGeM9zk/0LXff6+6cHLAHrdNMqbLekyXYp2xZVe7GP5EPNv
	IAJVO/Ou2mPLjrpgLhXBRFRA2ZSd86Qb1cU6FKGBA0wD+4Nz4itT1OKoYRMyGEt13D8Z9m0lLze
	mHRdTq/fJkBee+vYQ3Ynaz+EMwXMaswxEn5Aed6puCATCE03BphQbiIA0kviS5477i00Nw56CR0
	0CZ8a3PfddDFXC/djtdGqkQP8=
X-Google-Smtp-Source: AGHT+IHzFewBHGqghBRejHizY3eX5Vsyf6r2hKKKFtbyXvSw4LFsDF2WHnt5wMD9J0AnknEoq5ezpw==
X-Received: by 2002:a05:6a21:3289:b0:334:9cbd:7293 with SMTP id adf61e73a8af0-334a8617389mr29937464637.42.1761230913580;
        Thu, 23 Oct 2025 07:48:33 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm6045716a91.14.2025.10.23.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:33 -0700 (PDT)
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
Subject: [PATCH v2 0/2] net/tcp: fix permanent FIN-WAIT-1 state and add packetdrill test
Date: Thu, 23 Oct 2025 22:48:03 +0800
Message-ID: <20251023144805.1979484-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for your review and suggestions. As requested, I've added a packetdrill test to reproduce and verify the issue.

Changes in v2:
- Added packetdrill test in tools/testing/selftests/net/.
- The test reproduces the exact scenario described in the commit
  message.
- Test verifies that the connection eventually times out after the fix.

The test covers:
1. TCP connection establishment.
2. Peer advertising zero window after receiving data.
3. Local close() with FIN blocked in send buffer.
4. Continuous zero window ACKs from peer.
5. Connection timeout verification.

About your question regarding the case where FIN was already sent but peer retracted RWIN:
In that scenario, peer will drop the FIN packet due to "TCPZeroWindowDrop". The FIN will be retransmitted by RTO, not by the zero-window probe timer.

I tested this with multiple kernel versions and the test reliably reproduces the issue before the fix and passes after the fix.

Thank you for your guidance!

Best regards,
HaiYang Zhong

HaiYang Zhong (2):
  net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window
    packets
  net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix

 net/ipv4/tcp_input.c                          |  2 +
 .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt

-- 
2.43.7


