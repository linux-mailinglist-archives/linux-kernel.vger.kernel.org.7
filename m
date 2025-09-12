Return-Path: <linux-kernel+bounces-814488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63956B554AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A61C20A22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9FE3176EF;
	Fri, 12 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9eqaYZs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB83A1C9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694710; cv=none; b=qsjEjxT48IwGQJu8Ss0qts9B6cfBJ0XdbFERQRgkXkie1rw9al8Xd+SCg1JL8rm46LrvLzCfrUf1yB+4niQNhZH0pNbAAbVhCgit4/Gi5jk+04adp5W/OqaJ/QdPtpoqiE5tbZc0EEBaUA2AuFU09cpV5vhUPOn51/HF2gzsGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694710; c=relaxed/simple;
	bh=9ihUSfzSFkwLShWje0yO2srPckLAAToJdNnr5Y0SusM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JqyAlOmfKnM+q6DkFa3cM8W1FmFj0RTpWUNCytGU6tsT4ksN/teKZTCMparDONpWnebtARhD5aSE+a3potFA43OZDKO7x2QnYoUDlNi0aF8MnFpIsWJ3isp5zSNAl4PuGSNb0Jt5BewSg1fBWcJLUI0ZIzqNXuo+5SVV4s8qDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9eqaYZs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso18251195e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694707; x=1758299507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtKuOJb160u4mrJLBMsiqKEZV9s8rb8J9qjSnxTlACY=;
        b=H9eqaYZsV/SEKfw+wGD3shjT9uPhaD2GpRZrWX1FwxMVksRLBVvueSGYixtC5Gv+gZ
         6mDOIsNVcLpxmVn+zeq3rlg5od84xJXerX5EMTUr2IoA+h3HndRWVmVzjg1MwF0nd9/1
         on+ah4fk8mgjyPYqRtDabi2KUdgeVgkcvssgPH4kdemXfanXM9R6ORipFx3k6M8oQzA5
         f6W66NWpef6en3LosJMPvUVpfTQh5fIZNE4n36Y8p6wb9fPRpnDhuwt0V8BpyImLH5Cb
         kv1W/db8YIsQnwHGr7T2BVDXmAsFGPCQi5X1UdDbqGU32467ctLx8GF8YpT//AnJzJyF
         ASxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694707; x=1758299507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtKuOJb160u4mrJLBMsiqKEZV9s8rb8J9qjSnxTlACY=;
        b=dep6p3GsSHvtm4LU/OWT0kwXBjNd5y1/F8m0tw3LL9QeZHpeHt+GUyY/WyMYNgc7KG
         pL/ELu989lln+XIe0sfMstov9PDRNI04DIfEX5RpEKVnxryApqANI4xvCjGuIB/cn8K+
         mM1rWj6QQAb1WUI9MB0tZIv9JZc2/CS0n6fNWITorgBOth0ph9dtAuNSzbHpfJ23Ud6N
         GSwxfE2X9GYnMVrIzpmDL158L80huZ5DjrQRG5qyzLiPkiC6/+Ls5qXu2Gx+Pu7A06Vc
         yOlqxtNG5FA+wcQ3xlqf4yV4c3ZK5LqHYkAy/AozVViE5Jx7jQpAxO7Bpyf0MPKjdhcm
         NeCw==
X-Forwarded-Encrypted: i=1; AJvYcCXV/BlJrPRj0SN75xbjAzrUV03+IqJ2jk9iJi/SK4RuiHBrZyc+20yPnv1rAO5ldXvQAUjhsPDgZnkKK6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqE9o8rdn1VJBoCmkehwyD3JXb+aZMLhtrbouIuBCWhM4EleU
	nBHaHF7lrFseodOHqNiEpcJDOU/cl0auVfVO1HzX9CeqrUL2oLTY1+3z
X-Gm-Gg: ASbGnct4Q1W5TjjNWu6xixC8+BEUphvx7fzoo65jgmeAo5i9clZ6Tt4D7d+FwKwvI4q
	+2i2wSNmQWiad5G882kwo23zvSzGnc7UxXLWRh/QVBsT2hY3EAsMDtfl93sp49o4DncPbGzNcej
	+md0MrL6C0rrZkT+H7LSoqPgTqfQotRxduxNH3LaLlwd1vMdL+sjiBwsbGXkJsEB8Xdez/gjGOU
	QJzFpeqxtWSnlAndLeaCweiZN1ijSD4OkwncgfjtO762kk7/fIZ/wHXpaCcvW8NR8TZ/T0E6jNT
	EgM1TL9tBLl94uJWUWdVefop5cYYy6ZgGqzHzurbwoqC0rPRw3zoeA6lQJSxnTwkazQLV+smk1f
	KFQbE4tfdmlFES+n5jNdXSmDKAGCSfCeirsmwIrAZW8XSIhYx03Dv6+6gQ9PECM1q
X-Google-Smtp-Source: AGHT+IHIRSdEBgoLi0Q0DuZdQBqEeXcgKeXdgViwtka9Vqo2HBpKPmSlfWNGtBJ9utLxGObmeSXi0A==
X-Received: by 2002:a05:6000:3101:b0:3ca:3206:29f with SMTP id ffacd0b85a97d-3e765a2d9f1mr3941616f8f.40.1757694707074;
        Fri, 12 Sep 2025 09:31:47 -0700 (PDT)
Received: from elad-pc.lan ([2a0d:6fc2:68d0:5700:2165:4513:68b5:3f5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d638dsm64844795e9.22.2025.09.12.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:31:46 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action for nft flowtables
Date: Fri, 12 Sep 2025 19:30:35 +0300
Message-ID: <20250912163043.329233-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When offloading a flow via the default nft flowtable path,
append a FLOW_ACTION_CT_METADATA action if the flow is associated with a conntrack entry.
We do this in both IPv4 and IPv6 route action builders, after NAT mangles and before redirect.
This mirrors net/sched/act_ct.c’s tcf_ct_flow_table_add_action_meta() so drivers that already
parse FLOW_ACTION_CT_METADATA from TC offloads can reuse the same logic for nft flowtables.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..bccae4052319 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -12,6 +12,7 @@
 #include <net/netfilter/nf_conntrack_acct.h>
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_tuple.h>
+#include <net/netfilter/nf_conntrack_labels.h>
 
 static struct workqueue_struct *nf_flow_offload_add_wq;
 static struct workqueue_struct *nf_flow_offload_del_wq;
@@ -679,6 +680,41 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	return 0;
 }
 
+static void flow_offload_add_ct_metadata(const struct flow_offload *flow,
+					 enum flow_offload_tuple_dir dir,
+					 struct nf_flow_rule *flow_rule)
+{
+	struct nf_conn *ct = flow->ct;
+	struct flow_action_entry *entry;
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)
+	u32 *dst_labels;
+	struct nf_conn_labels *labels;
+#endif
+
+	if (!ct)
+		return;
+
+	entry = flow_action_entry_next(flow_rule);
+	entry->id = FLOW_ACTION_CT_METADATA;
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_MARK)
+	entry->ct_metadata.mark = READ_ONCE(ct->mark);
+#endif
+
+	entry->ct_metadata.orig_dir = (dir == FLOW_OFFLOAD_DIR_ORIGINAL);
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)
+	dst_labels = entry->ct_metadata.labels;
+	labels = nf_ct_labels_find(ct);
+	if (labels)
+		memcpy(dst_labels, labels->bits, NF_CT_LABELS_MAX_SIZE);
+	else
+		memset(dst_labels, 0, NF_CT_LABELS_MAX_SIZE);
+#else
+	memset(entry->ct_metadata.labels, 0, NF_CT_LABELS_MAX_SIZE);
+#endif
+}
+
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule)
@@ -698,6 +734,7 @@ int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 	    test_bit(NF_FLOW_DNAT, &flow->flags))
 		flow_offload_ipv4_checksum(net, flow, flow_rule);
 
+	flow_offload_add_ct_metadata(flow, dir, flow_rule);
 	flow_offload_redirect(net, flow, dir, flow_rule);
 
 	return 0;
@@ -720,6 +757,7 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 		flow_offload_port_dnat(net, flow, dir, flow_rule);
 	}
 
+	flow_offload_add_ct_metadata(flow, dir, flow_rule);
 	flow_offload_redirect(net, flow, dir, flow_rule);
 
 	return 0;
-- 
2.48.1


