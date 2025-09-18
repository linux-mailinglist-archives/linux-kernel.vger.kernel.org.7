Return-Path: <linux-kernel+bounces-806539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B6B49832
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FB73B5A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F931B109;
	Mon,  8 Sep 2025 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="k61XfHHb"
Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F233318139
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355802; cv=pass; b=Z+fZplU1CawfTOSfeBwA9g+KJTBQDO4un+dtiFjJX6/MhZY0g22N/S7QncCDhX+i8kmFXbrUzNfa/nKlQSzk/hDOHCVdyLX93QqV0l9lgNY2pchvgz9Azr6gAmFSoDGAdNM+yBmakJpMc8InshvNdAAXhWS2rqBhgGUJqI+l7To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355802; c=relaxed/simple;
	bh=tJn8wU/FAdYgLMxJPvZZUYUbKifLg26ClGFsuY4bZ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JJ023E50mBmGWH9bDn/O5s6JRcVtQop9bZWGeitxee/8ePf+GyTSbchyClMg1gFYMfW+fFBN7Q7AmIwYx+ReIGVn8Of8W/cl7fXqWdPoOcmJF5PAoUSbL6nwpHudaHY+aIvlnQystnPgvKEMiea1aAHQp+P8aIDJRdF4THHsYfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=k61XfHHb; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2A573904AA4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:16:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (100-107-16-138.trex-nlb.outbound.svc.cluster.local [100.107.16.138])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C33E3905160
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:16:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757355363; a=rsa-sha256;
	cv=none;
	b=LUfYBuzT/vr1g3h8a7KHnK3XL0dGQPnwVmKjZBAh8Eb2/jsxx6YkQTnBqjzgezGKuksFB6
	PKiLO8daIsrnKL7iY0DPMtkXE/vxtKm2m2WviWvX/mk78wNMiZsPtyacHb4+YBgC+rgXzf
	LhwrV7cicb6J8CoQ/5K3OQfnNr9aPgzPNTVGgG3uSwZ4kTvKwZFUbcAnrNH+DPv0aEMHHt
	X83tTnDskNQHnWLlrxjeFZwQNy5hN9fQ/QE1LItaFv+8fejpTghEZKnSPwXnV300FVum8b
	MBz4SkJqGwVtQKdZBPQ3Hev3XjsGM6+B1Iw6pLASjeHp6cV/RswW+XkZdHnFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757355363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=bx4e0pgGb2y8U+QGf21qX2SdVP0uMrcYvKMqsJ4Puj8=;
	b=5eLy4RnUkjQqBkn4aPZYoU/WQJWywWHbfbhniDlDE92l1FnkWQGktlm9G6HlOzKJHt0Fem
	TsAeewiEfUctB3xS6YSpHzzceAjJqutjZQHHfuSU8vgufif1Nk+1xwFMZY8xxl9GM35gTQ
	giKCxJ+xIiIRolEIKaPoCjP2Xxl/M/5jQHfVR2Dv4vWsZR825nDuwEb6QeKBicosvl7qaO
	kLHyWDEiwBK4BjVcx0Tj+N1Jb8jCRPH38F+w/IR6DwoUYL8/6fhBOTeVh75zuR7FGWETgF
	QR5GqpEIiXC7N/u4RGRWrHQ0mRHTePKdQLtx87qBOhTFxiwbQLkNXDG6l4170Q==
ARC-Authentication-Results: i=1;
	rspamd-9968f48fc-22hz2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cure-Cooing: 46846d3879a3260c_1757355364026_1867169200
X-MC-Loop-Signature: 1757355364026:467374492
X-MC-Ingress-Time: 1757355364026
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.16.138 (trex/7.1.3);
	Mon, 08 Sep 2025 18:16:04 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4cLFWR1TLBzhq
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1757355363;
	bh=bx4e0pgGb2y8U+QGf21qX2SdVP0uMrcYvKMqsJ4Puj8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=k61XfHHbtdSc/foF8kmzjrn6KgCH4ZwrjupvX9vwYRJu+Af5y3C92EK6opnGlV7n2
	 olkWmC4w3ClK0f+Ar7N6jvHOUYjOC4Vdmf0AoFwNaWeJ+eFsPRqnmoFEaAG6IXUiPa
	 zouHtw532WU3+J1+r9rB0a5TlPd5BpieB19QKBySU/zIO8OgcVaMy7QU6GFS07nVa6
	 UF55OuyRnS7qcznnACxexXF8Jzx+EYwrZf/PkKsBlOHSpoKzu+LByZetR2WZwuG8lK
	 xwXmzOLONc/GjtFC2iKKYu8FUALUb67rV2ik0POwr9fR6zeGko3ILVwX35qOlxfD+f
	 MgVfcxYkHlTHA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0263
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Mon, 08 Sep 2025 11:16:01 -0700
Date: Mon, 8 Sep 2025 11:16:01 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Reaver <me@davidreaver.com>
Subject: [PATCH net v2] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Message-ID: <aL8dYfPZrwedCIh9@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Users reported a scenario where MPTCP connections that were configured
with SO_KEEPALIVE prior to connect would fail to enable their keepalives
if MTPCP fell back to TCP mode.

After investigating, this affects keepalives for any connection where
sync_socket_options is called on a socket that is in the closed or
listening state.  Joins are handled properly. For connects,
sync_socket_options is called when the socket is still in the closed
state.  The tcp_set_keepalive() function does not act on sockets that
are closed or listening, hence keepalive is not immediately enabled.
Since the SO_KEEPOPEN flag is absent, it is not enabled later in the
connect sequence via tcp_finish_connect.  Setting the keepalive via
sockopt after connect does work, but would not address any subsequently
created flows.

Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on the
subflow when calling sync_socket_options.

The fix was valdidated both by using tcpdump to observe keepalive
packets not being sent before the fix, and being sent after the fix.  It
was also possible to observe via ss that the keepalive timer was not
enabled on these sockets before the fix, but was enabled afterwards.

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Cc: stable@vger.kernel.org
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
  - Ensure local variable declarations are in reverse-Christmas-tree
    style.  (Feedback from Geliang Tang)
  - Use keep_open instead of kaval; make type bool instead of int.
    (Feedback from Matthieu Baerts)
---

 net/mptcp/sockopt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..2abe6f1e9940 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1532,13 +1532,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool keep_open;
 
-	if (ssk->sk_prot->keepalive) {
-		if (sock_flag(sk, SOCK_KEEPOPEN))
-			ssk->sk_prot->keepalive(ssk, 1);
-		else
-			ssk->sk_prot->keepalive(ssk, 0);
-	}
+	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
+	if (ssk->sk_prot->keepalive)
+		ssk->sk_prot->keepalive(ssk, keep_open);
+	sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
 
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;

base-commit: 319f7385f22c85618235ab0169b80092fa3c7696
-- 
2.43.0


