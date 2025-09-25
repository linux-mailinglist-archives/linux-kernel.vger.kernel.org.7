Return-Path: <linux-kernel+bounces-832542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6382B9FA16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FC73B71BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C071274659;
	Thu, 25 Sep 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDH9MEgK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D152727E6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807741; cv=none; b=a12DUQE+54pB2bMxouyU8uCRXMHuXUxC9ekMXHWDkbKJ1xgasQlZGZ6Gb4RUVILNkgDh7v+xsYGoou+U/i70Iigwh658ntdP0aqObowPQEqr1pdJmiWP/HSZFB+5oLdTq+GoT9olHEnCtKeiGR3LORdH/pa3yva5aY3bWuXgUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807741; c=relaxed/simple;
	bh=sPuyYm1C4sHaTPsabJ3pDG8Xk8pUeu54NQrBF163+mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hz7uXQugATNP4zMVGf8habtM9iPOT9gfhOkcoWMLG9BNedkxZgl+4JNOsbcgX/5gmuKIK5nnZk32t7et51xhOaCzF/hYgJoC816BQNm6qMdUny1MRdE3g+tJxzo4z4kdquNDOXJHxHifJEYMl/i2P31Axw/W63DZq36/G4jOBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDH9MEgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758807738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8vHsJwdUMBe/dp6r1dI75OkJ9Hs0OM9rJATtz7xS340=;
	b=dDH9MEgKO0e3un26EeEDXHXgMtVA60X5AIfOYq79bSE4nn8+NAQIajEcfrxv/QnzMj/qGH
	okZ+SB812xCbh6r0B76nHX24O0o49T/NGR0ccL4h4MZ1Eopbo6s6ShX4ibHZhVqxFVEloZ
	dejYA5CGBoq9mXYV3STPPenP9wdCJPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-PqtUKMjWMh-Xzk6R6qSUNQ-1; Thu,
 25 Sep 2025 09:42:12 -0400
X-MC-Unique: PqtUKMjWMh-Xzk6R6qSUNQ-1
X-Mimecast-MFC-AGG-ID: PqtUKMjWMh-Xzk6R6qSUNQ_1758807725
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 508D51800284;
	Thu, 25 Sep 2025 13:42:04 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA1F7300021A;
	Thu, 25 Sep 2025 13:41:59 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	ej@inai.de,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: include source and destination ports to NETFILTER_PKT
Date: Thu, 25 Sep 2025 10:41:56 -0300
Message-ID: <20250925134156.1948142-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

NETFILTER_PKT records show both source and destination
addresses, in addition to the associated networking protocol.
However, it lacks the ports information, which is often
valuable for troubleshooting.

This patch adds both source and destination port numbers,
'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
SCTP-related NETFILTER_PKT records.

 type=NETFILTER_PKT ... saddr=127.0.0.1 daddr=127.0.0.1 proto=icmp
 type=NETFILTER_PKT ... saddr=::1 daddr=::1 proto=ipv6-icmp
 type=NETFILTER_PKT ... daddr=127.0.0.1 proto=udp sport=38173 dport=42424
 type=NETFILTER_PKT ... daddr=::1 proto=udp sport=56852 dport=42424
 type=NETFILTER_PKT ... daddr=127.0.0.1 proto=tcp sport=57022 dport=42424
 type=NETFILTER_PKT ... daddr=::1 proto=tcp sport=50810 dport=42424
 type=NETFILTER_PKT ... daddr=127.0.0.1 proto=sctp sport=54944 dport=42424
 type=NETFILTER_PKT ... daddr=::1 proto=sctp sport=57963 dport=42424

Link: https://github.com/linux-audit/audit-kernel/issues/162
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 net/netfilter/xt_AUDIT.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index b6a015aee0ce..9fc8a5429fa9 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -19,6 +19,7 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <net/ipv6.h>
 #include <net/ip.h>
+#include <linux/sctp.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Thomas Graf <tgraf@redhat.com>");
@@ -32,6 +33,7 @@ static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
 {
 	struct iphdr _iph;
 	const struct iphdr *ih;
+	__be16 dport, sport;
 
 	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
 	if (!ih)
@@ -40,6 +42,25 @@ static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
 	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
 			 &ih->saddr, &ih->daddr, ih->protocol);
 
+	switch (ih->protocol) {
+	case IPPROTO_TCP:
+		sport = tcp_hdr(skb)->source;
+		dport = tcp_hdr(skb)->dest;
+		break;
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+		sport = udp_hdr(skb)->source;
+		dport = udp_hdr(skb)->dest;
+		break;
+	case IPPROTO_SCTP:
+		sport = sctp_hdr(skb)->source;
+		dport = sctp_hdr(skb)->dest;
+	}
+
+	if (ih->protocol == IPPROTO_TCP || ih->protocol == IPPROTO_UDP ||
+	    ih->protocol == IPPROTO_UDPLITE || ih->protocol == IPPROTO_SCTP)
+		audit_log_format(ab, " sport=%hu dport=%hu", ntohs(sport), ntohs(dport));
+
 	return true;
 }
 
@@ -48,7 +69,7 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 	struct ipv6hdr _ip6h;
 	const struct ipv6hdr *ih;
 	u8 nexthdr;
-	__be16 frag_off;
+	__be16 frag_off, dport, sport;
 
 	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_ip6h), &_ip6h);
 	if (!ih)
@@ -60,6 +81,25 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 	audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
 			 &ih->saddr, &ih->daddr, nexthdr);
 
+	switch (ih->nexthdr) {
+	case IPPROTO_TCP:
+		sport = tcp_hdr(skb)->source;
+		dport = tcp_hdr(skb)->dest;
+		break;
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+		sport = udp_hdr(skb)->source;
+		dport = udp_hdr(skb)->dest;
+		break;
+	case IPPROTO_SCTP:
+		sport = sctp_hdr(skb)->source;
+		dport = sctp_hdr(skb)->dest;
+	}
+
+	if (ih->nexthdr == IPPROTO_TCP || ih->nexthdr == IPPROTO_UDP ||
+	    ih->nexthdr == IPPROTO_UDPLITE || ih->nexthdr == IPPROTO_SCTP)
+		audit_log_format(ab, " sport=%hu dport=%hu", ntohs(sport), ntohs(dport));
+
 	return true;
 }
 
-- 
2.51.0


