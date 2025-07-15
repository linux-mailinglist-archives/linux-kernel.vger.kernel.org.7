Return-Path: <linux-kernel+bounces-731473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8FB054E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2684F3A8B62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5AA2459D2;
	Tue, 15 Jul 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FCoYxd/8"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47817A31C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568267; cv=none; b=BMVCW17qMdfeG/x7xHuK/iKBRpx1PP0nVg1B0HfEkM7RI/y7XHqE7At0lzvF1qPY95PAaXsgia1ZhDmamO5vfB3KornjlUYcX3Wn/Ro3nZglAn+IkQ6JI+FsbJCAucjKcVy67qQbNM6YTD3DSaq55DOc5Hjl0Pm4epItZJIEt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568267; c=relaxed/simple;
	bh=7RChoxNZvIGW01objUPMp18lND3qP5swJI6Jly25b3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzU3ya/hs3inOdzS6nLhRqemSjCZCMXUTCdbn6hEA9BZCSJDt8nb0cnP+JRDcif8hIblxiq5TNgaV5cKwc5/YcMA2iZuJ28x91apQYVTZB3T99gyPmUObwdNuh5MAzU3Nq54FUnIJpafYxr0sIE6tHZLLO3zw3jUrDrLggJWitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FCoYxd/8; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752568202;
	bh=PtRaWMoDptc1e8ypjYcAlmQHmognEHmmTZFTUdTg2kI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FCoYxd/8/eGrGtSqKyHGhTnH82OREw2IdRtXjsRZTEBdlAnJLg4u5IEtwyDP9wt+8
	 B1ksdg4+wn9LtiQpVeX8vAarIgmOHE73KrB+wB8/Ja5vIGHh7Ujpe/8pgx520AYsL/
	 nQM4vIhiN4WbTSIKW5Ei1Q3c+sJriiUJLUBVE4OA=
X-QQ-mid: zesmtpip2t1752568181tad22719b
X-QQ-Originating-IP: 0GVQog9toGo4M4xXdTRBAEj46JRuzpoacgxAEvWriAM=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 16:29:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6392857298671382999
EX-QQ-RecipientCnt: 13
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georg Kohmann <geokohma@cisco.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 5.4] net: ipv6: Discard next-hop MTU less than minimum link MTU
Date: Tue, 15 Jul 2025 16:29:32 +0800
Message-ID: <46839B9D4350724B+20250715082932.430119-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of2cEohDBRJB7tm+XdfNKWDXw/T707neglh0BJTdNWiMlTOsZQv+Arli
	WYSjo/EO+oN19kFJ/NHlWJz62RTg+rtw/N8i2X0VdrlXPVOuSJQ7QMYQkJ7VO6qU7I2ZtAF
	RZxNfycRCkYYL4Zy7LFO/rfKHmZRLZHrEWvYoPivaFRBylXIBxLJCWdj+hL6VFJYP6Z35Hb
	KdBzWkLQuc9yb7/DzUptbNwu+3fQGadwQlEbOX1k9yPEXfR3oEPsOfqWNIEuAq/m0BVHK31
	YUbBrVmYvPNO7g9VDoELDJt+WPrCfJYR6Jes5ZyLIPfbaqKs7gZNLc67c/m+ZQtb8mF1jYp
	rppj5ZcoyLC5q1gSb1fGIV7pvwu01os9w+h+Sl+RYYUeMqxVOtdkKelCIRd8ljLp1elzLo6
	AtYjykyia6WouvnW5DBigB9zipApMfF92H0hPAhmzXwRXtduJALK4EM4USwdw3BtIxcn34e
	X3/7SNFfXdtOrTRkjSU3TNYygmZgEN+sqN1Dwr1ZQ8NzCHCYnT8Jc2GqC9kJijnSboAHJlY
	lWUsYwJ2uZipM/KnSBdXbZpuQfsf1JJhwVmCXa82tjy1q1WyAGYUugCU370spUTvoWh5Es6
	hCvXRj7qKeaBdbGp6MVTL++e5dTZzFC9NpmVWx8mtjHKKv7bar8oxq+z0NokrspFAegAvwm
	isco0+SSn2rf8yWnouhoJKCKo3uxdCMhk8VkmuxSvtI2qiiUAJ4sy9n2Bp/2ef5UnoNWrGb
	3Tbbws4X5LOd4TAo6ohQsE6nFMWG5NLc33A+VpbnipH4GP/Mky/b1gkBs0bJvU3NfJugG7Q
	3SBG5UK8JMNUAgCvp1M6AJIozBynFCSyZbjpROUMAcjzSGsiW+w7BGAG4Qe416vAi/htu74
	vap3UUdoNTTW8ArKeYJz2GoJBLUusVgBv+umvMxpUn/Lp5DepdQIoxi4TjjijwK/uNvDrvx
	JjDnZzWCnRTIwK8TDpmREk75fCt8bsO0UIEsnmiJVyaPjCsNK915LZI41Cj5LnT7opLANEt
	rkdronUg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: Georg Kohmann <geokohma@cisco.com>

[ Upstream commit 4a65dff81a04f874fa6915c7f069b4dc2c4010e4 ]

When a ICMPV6_PKT_TOOBIG report a next-hop MTU that is less than the IPv6
minimum link MTU, the estimated path MTU is reduced to the minimum link
MTU. This behaviour breaks TAHI IPv6 Core Conformance Test v6LC4.1.6:
Packet Too Big Less than IPv6 MTU.

Referring to RFC 8201 section 4: "If a node receives a Packet Too Big
message reporting a next-hop MTU that is less than the IPv6 minimum link
MTU, it must discard it. A node must not reduce its estimate of the Path
MTU below the IPv6 minimum link MTU on receipt of a Packet Too Big
message."

Drop the path MTU update if reported MTU is less than the minimum link MTU.

Signed-off-by: Georg Kohmann <geokohma@cisco.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 net/ipv6/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b321cec71127..93bae134e730 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2765,7 +2765,8 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 	if (confirm_neigh)
 		dst_confirm_neigh(dst, daddr);
 
-	mtu = max_t(u32, mtu, IPV6_MIN_MTU);
+	if (mtu < IPV6_MIN_MTU)
+		return;
 	if (mtu >= dst_mtu(dst))
 		return;
 
-- 
2.50.0


