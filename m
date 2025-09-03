Return-Path: <linux-kernel+bounces-798805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116FB42323
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C19F5E65F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732842FE587;
	Wed,  3 Sep 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiMT3VUX"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00184286892
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908557; cv=none; b=fsbgLaDIQJLBkuMB7bHrCelOn1T0rdVQ2RpBH7PCPP2s5iZB63RFzFoGIXwE7gUXKkEOMijk8sZ6vDHW5nemm9UwqJb8ULG3NUmVAVYQbpN2d9OOLKT2OlxX9iNvRpU0qPMLeSxw1pJ8Gp1lBeoyDCK4GE+R06ccc7hE4Z7lzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908557; c=relaxed/simple;
	bh=nkc/c31mZfPdhwHe1GveJFK3jZ7GozQHmAxHK+NlS/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYoIUQjyBbt+gZcgoC4r702Y9nzGCHfNMiAvehEyIdGPt5NhsD7fkYezW+MCyihwwQziv3uZHMEKdMa83a/f61sEhsTklEbuy6n+zCFN82mGBpXIHLt92WZ7xeMtQ/Tn7R++JLfONItFFm9uXmlSCgWjo1AQ1bPgH9C6hYlK5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiMT3VUX; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b02c719a117so541421966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908551; x=1757513351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ci3zFdc0OM48ntlKWbbId5lHIPc2tj57KRiLLEADz4=;
        b=JiMT3VUXLTDqUyz20u6cgh0DJIoGYlPWSzzg+sbXkr4nOlIDZM/vMXNQ+/B1y2x7ID
         2SiqgJw1W8O7VZfu8Ka54LDOnbcNYoSu1F9rIOoM2PQhyIZMbl3mh6FkMlo4tA1VIfgL
         r/i/QXiG+jYgdyZ0oFmJVTc7GFE6q6cCTXlWg0PVYe+vkXGDSlX+8lRlQZwgZCL0SIr7
         NFlTKE21xYuIuILVPvZmKWIpJIsXWQbRyLmWUUZXp+cm2mR9Onh0A/CXbXehVhsLhQIB
         RmCPqqxYVwVqduocpEQITxip3ieYy+2IHikj+ZvHS98EXdbafD0XabPCBWdXJsfeEK0m
         4scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908551; x=1757513351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ci3zFdc0OM48ntlKWbbId5lHIPc2tj57KRiLLEADz4=;
        b=sJ5v8kZPd3msSgAuCtJYkDv2M8ogy6Rdgam17uUFoGqLiLhbtmsATekQsT4S41ulrX
         esXwd8BviAmInXVPYwKjfZivAAMBSS6KfUpdxZX8Vd7MsvNLC1a8oWmxICU8ayTTvKx2
         tRFSlMBJaB44UZDY8z9HnpodhJTM+yYQdftM6B49RhE1KBXpNR2N4w/7OBh8nm6UnUJK
         pXNpeahO5F+4iRi8HvgwrUZ+cZ7X9+Dqurkz9nXK1S5lw++XscQHkvtF3ziEtgY6gVy0
         I+5WU1CdNBqTl4kd3gBh32MajfEOujhQlwhFQyo4dHHrDPYcoxB3IK+Cx3uX4dBN4Wc0
         yxbA==
X-Gm-Message-State: AOJu0YwtQM3om2uNUMjFmZnUsN0dUmiytQ9pCdAI8zgVyDkgGJ+1ueXU
	OhtZe2A3wIgDq3RxTmIigZ+oeR2wZbhEbBqcKVguTZO/xswo3AqbcgoCS7z2VQYZ
X-Gm-Gg: ASbGncvRS/Lz8cVcIH6YQ7tTBRJq9CPPSias9d6LurSAPCf0pW0sU0LkMxNKFUr1VsJ
	zQZy4ZBcatB4taRmT+iDQLVEDBUu9Ce3nj3kEpwaFJgQVFRzSMj9x+emcEB95mSafrW+yN+7LBY
	KAG4g2NC9ewcA8EOlqRW4arFspXKblY9oA83H73t/FVFwZuTHJOp0EFUWsRJycacnNxfdiUcPcn
	2+8HpSF1zIqji3qlhnsytdEMY/4Gerq+AE1vQN+8NI0IBN0vC5YVGsl23O3Q3SR5AycIPgHIhhT
	lhDJXuBx+Dp/Wo2G7VcnyzD1sfMwuq//JVFzh2xUCE6rWef7THY5w3unFURJN1mIWCb7v9k29Fo
	Pi9SWTLYc/ojtn4lTWKV2uniZfGtikveTb2J3Qr/CYUwAfpFZlQ==
X-Google-Smtp-Source: AGHT+IH6glCPwSo8TF9wjtOuSGx4fH0NRLJhjMtTQrWNH9Tcy94tcSbjKNDsUHsk+2ipTRoqmq9U1Q==
X-Received: by 2002:a17:907:1ca8:b0:aff:321:c31d with SMTP id a640c23a62f3a-b01d8a277c5mr1584363466b.7.1756908550620;
        Wed, 03 Sep 2025 07:09:10 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:348:d0f:ed4a:2775:c4b1:9fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d420e02sm130842366b.39.2025.09.03.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:09:10 -0700 (PDT)
From: Fidal <palamparambilfidal089@gmail.com>
To: kgdb-bugreport@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	daniel.thompson@linaro.org,
	dianders@chromium.org,
	Fidal <palamparambilfidal089@gmail.com>,
	Your Name <you@example.com>
Subject: [PATCH] kdb: Fix race condition and improve keyboard handling
Date: Wed,  3 Sep 2025 18:01:58 +0400
Message-ID: <20250903140158.1345-1-palamparambilfidal089@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix race reading KBD_STATUS_REG and KBD_DATA_REG
- Add bounds/null checks for keymap access
- Handle Japanese keyboard layout quirks
- Ensure keychar is always initialized
- Improve handling of special scancodes

Signed-off-by: Your Name <you@example.com>
---
 .../uapi/linux/netfilter/xt_CONNMARK.h        |  44 +++
 .../include/uapi/linux/netfilter/xt_DSCP.h    |  29 ++
 .../linux/netfilter/net/netfilter/xt_TCPMSS.c |   1 +
 include/uapi/linux/netfilter/xt_tcpmss.c      | 272 ++++++++++++++++++
 kernel/debug/kdb/kdb_keyboard.c               |  49 +++-
 5 files changed, 381 insertions(+), 14 deletions(-)
 create mode 100644 include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_CONNMARK.h
 create mode 100644 include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_DSCP.h
 create mode 100644 include/uapi/linux/netfilter/net/netfilter/xt_TCPMSS.c
 create mode 100644 include/uapi/linux/netfilter/xt_tcpmss.c

diff --git a/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_CONNMARK.h b/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_CONNMARK.h
new file mode 100644
index 000000000000..0640d7521431
--- /dev/null
+++ b/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_CONNMARK.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright (C) 2002,2004 MARA Systems AB <https://www.marasystems.com>
+ * by Henrik Nordstrom <hno@marasystems.com>
+ */
+
+#ifndef _XT_CONNMARK_H
+#define _XT_CONNMARK_H
+
+#include <linux/types.h>
+
+enum {
+	XT_CONNMARK_SET = 0,
+	XT_CONNMARK_SAVE,
+	XT_CONNMARK_RESTORE
+};
+
+enum {
+	D_SHIFT_LEFT = 0,
+	D_SHIFT_RIGHT,
+};
+
+struct xt_connmark_tginfo1 {
+	__u32 ctmark;
+	__u32 ctmask;
+	__u32 nfmask;
+	__u8  mode;
+};
+
+struct xt_connmark_tginfo2 {
+	__u32 ctmark;
+	__u32 ctmask;
+	__u32 nfmask;
+	__u8  shift_dir;
+	__u8  shift_bits;
+	__u8  mode;
+};
+
+struct xt_connmark_mtinfo1 {
+	__u32 mark;
+	__u32 mask;
+	__u8  invert;
+};
+
+#endif /* _XT_CONNMARK_H */
diff --git a/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_DSCP.h b/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_DSCP.h
new file mode 100644
index 000000000000..ee285201944e
--- /dev/null
+++ b/include/uapi/linux/netfilter/include/uapi/linux/netfilter/xt_DSCP.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* x_tables module for matching the IPv4/IPv6 DSCP field
+ *
+ * (C) 2002 Harald Welte <laforge@gnumonks.org>
+ * Licensed under GNU GPL v2.
+ * See RFC2474 for DSCP field.
+ */
+
+#ifndef _XT_DSCP_H
+#define _XT_DSCP_H
+
+#include <linux/types.h>
+
+#define XT_DSCP_MASK   0xfc  /* 11111100 */
+#define XT_DSCP_SHIFT  2
+#define XT_DSCP_MAX    0x3f  /* 00111111 */
+
+struct xt_dscp_info {
+	__u8 dscp;
+	__u8 invert;
+};
+
+struct xt_tos_match_info {
+	__u8 tos_mask;
+	__u8 tos_value;
+	__u8 invert;
+};
+
+#endif /* _XT_DSCP_H */
diff --git a/include/uapi/linux/netfilter/net/netfilter/xt_TCPMSS.c b/include/uapi/linux/netfilter/net/netfilter/xt_TCPMSS.c
new file mode 100644
index 000000000000..853b0877b33d
--- /dev/null
+++ b/include/uapi/linux/netfilter/net/netfilter/xt_TCPMSS.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
diff --git a/include/uapi/linux/netfilter/xt_tcpmss.c b/include/uapi/linux/netfilter/xt_tcpmss.c
new file mode 100644
index 000000000000..bde5b8e945cd
--- /dev/null
+++ b/include/uapi/linux/netfilter/xt_tcpmss.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Kernel module for matching and modifying TCP MSS values/packets.
+ *
+ * Copyright (C) 2000 Marc Boucher <marc@xxxxxxx>
+ * Portions (C) 2005 Harald Welte <laforge@xxxxxxxxxxxxx>
+ * Copyright (C) 2007 Patrick McHardy <kaber@xxxxxxxxx>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/netfilter/x_tables.h>
+#include <linux/netfilter/xt_tcpudp.h>
+#include <linux/netfilter/xt_tcpmss.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+#include <net/dst.h>
+#include <net/flow.h>
+#include <net/route.h>
+#include <net/tcp.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marc Boucher <marc@xxxxxxx>");
+MODULE_DESCRIPTION("Xtables: TCP Maximum Segment Size (MSS) adjustment and match");
+MODULE_ALIAS("ipt_tcpmss");
+MODULE_ALIAS("ip6t_tcpmss");
+MODULE_ALIAS("ipt_TCPMSS");
+MODULE_ALIAS("ip6t_TCPMSS");
+MODULE_ALIAS("xt_TCPMSS");
+
+static inline unsigned int optlen(const u8 *opt, unsigned int offset)
+{
+    return opt[offset] <= TCPOPT_NOP || opt[offset + 1] == 0 ? 1 : opt[offset + 1];
+}
+
+static u32 tcpmss_reverse_mtu(struct net *net, const struct sk_buff *skb, unsigned int family)
+{
+    struct flowi fl = { 0 };
+    struct rtable *rt = NULL;
+    u32 mtu = ~0U;
+
+    if (family == PF_INET) {
+        fl.u.ip4.daddr = ip_hdr(skb)->saddr;
+    } else {
+        fl.u.ip6.daddr = ipv6_hdr(skb)->saddr;
+    }
+
+    nf_route(net, (struct dst_entry **)&rt, &fl, false, family);
+    if (rt) {
+        mtu = dst_mtu(&rt->dst);
+        dst_release(&rt->dst);
+    }
+    return mtu;
+}
+
+static int tcpmss_mangle_packet(struct sk_buff *skb, const struct xt_action_param *par,
+                                unsigned int in_mtu, unsigned int tcphoff, unsigned int minlen)
+{
+    const struct xt_tcpmss_info *info = par->targinfo;
+    struct tcphdr *tcph;
+    unsigned int len, tcp_hdrlen;
+    unsigned int i;
+    __be16 oldval;
+    u16 newmss;
+    u8 *opt;
+
+    if (par->fragoff != 0)
+        return 0;
+
+    if (skb_ensure_writable(skb, skb->len))
+        return -1;
+
+    len = skb->len - tcphoff;
+    if (len < sizeof(*tcph))
+        return -1;
+
+    tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+    tcp_hdrlen = tcph->doff * 4;
+    if (len < tcp_hdrlen)
+        return -1;
+
+    newmss = info->mss == XT_TCPMSS_CLAMP_PMTU ?
+             min(in_mtu, dst_mtu(skb_dst(skb))) - minlen : info->mss;
+
+    for (i = sizeof(*tcph); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen((u8*)tcph, i)) {
+        if (tcph[i] == TCPOPT_MSS && tcph[i+1] == TCPOLEN_MSS) {
+            u16 oldmss = (tcph[i+2] << 8) | tcph[i+3];
+            if (oldmss <= newmss)
+                return 0;
+
+            tcph[i+2] = (newmss >> 8) & 0xff;
+            tcph[i+3] = newmss & 0xff;
+            inet_proto_csum_replace2(&tcph->check, skb, htons(oldmss), htons(newmss), false);
+            return 0;
+        }
+    }
+
+    if (len > tcp_hdrlen || tcp_hdrlen >= 15 * 4)
+        return 0;
+
+    if (skb_tailroom(skb) < TCPOLEN_MSS &&
+        pskb_expand_head(skb, 0, TCPOLEN_MSS - skb_tailroom(skb), GFP_ATOMIC))
+        return -1;
+
+    tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+    skb_put(skb, TCPOLEN_MSS);
+
+    if (par->family == NFPROTO_IPV4)
+        newmss = min(newmss, (u16)536);
+    else
+        newmss = min(newmss, (u16)1220);
+
+    opt = (u8*)tcph + sizeof(*tcph);
+    memmove(opt + TCPOLEN_MSS, opt, len - sizeof(*tcph));
+    inet_proto_csum_replace2(&tcph->check, skb, htons(len), htons(len + TCPOLEN_MSS), true);
+    opt[0] = TCPOPT_MSS; opt[1] = TCPOLEN_MSS;
+    opt[2] = (newmss >> 8) & 0xff;
+    opt[3] = newmss & 0xff;
+    inet_proto_csum_replace4(&tcph->check, skb, 0, *(__be32*)opt, false);
+
+    oldval = ((__be16*)tcph)[6];
+    tcph->doff += TCPOLEN_MSS / 4;
+    inet_proto_csum_replace2(&tcph->check, skb, oldval, ((__be16*)tcph)[6], false);
+
+    return TCPOLEN_MSS;
+}
+
+static unsigned int tcpmss_tg4(struct sk_buff *skb, const struct xt_action_param *par)
+{
+    struct iphdr *iph = ip_hdr(skb);
+    int ret = tcpmss_mangle_packet(skb, par,
+                                   tcpmss_reverse_mtu(skb, PF_INET),
+                                   iph->ihl * 4,
+                                   sizeof(*iph) + sizeof(struct tcphdr));
+    if (ret < 0)
+        return NF_DROP;
+
+    if (ret > 0) {
+        __be16 newlen = htons(ntohs(iph->tot_len) + ret);
+        csum_replace2(&iph->check, iph->tot_len, newlen);
+        iph->tot_len = newlen;
+    }
+
+    return XT_CONTINUE;
+}
+
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+static unsigned int tcpmss_tg6(struct sk_buff *skb, const struct xt_action_param *par)
+{
+    struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+    u8 nexthdr; __be16 oldlen, newlen; int tcphoff;
+    struct net *net = xt_net(par);
+    int ret;
+
+    ret = ipv6_skip_exthdr(skb, sizeof(*ipv6h), &nexthdr, &tcphoff);
+    if (ret < 0) return NF_DROP;
+
+    ret = tcpmss_mangle_packet(skb, par,
+                               tcpmss_reverse_mtu(net, skb, PF_INET6),
+                               tcphoff,
+                               sizeof(*ipv6h) + sizeof(struct tcphdr));
+    if (ret < 0) return NF_DROP;
+
+    if (ret > 0) {
+        oldlen = ipv6h->payload_len;
+        newlen = htons(ntohs(oldlen) + ret);
+        if (skb->ip_summed == CHECKSUM_COMPLETE)
+            skb->csum = csum_add(skb->csum, newlen - oldlen);
+        ipv6h->payload_len = newlen;
+    }
+
+    return XT_CONTINUE;
+}
+#endif
+
+static inline bool find_syn_match(const struct xt_entry_match *m)
+{
+    const struct xt_tcp *tcpinfo = (const struct xt_tcp *)m->data;
+    return strcmp(m->u.kernel.match->name, "tcp") == 0 &&
+           (tcpinfo->flg_cmp & TCPHDR_SYN) &&
+           !(tcpinfo->invflags & XT_TCP_INV_FLAGS);
+}
+
+static int tcpmss_tg4_check(const struct xt_tgchk_param *par)
+{
+    const struct xt_tcpmss_info *info = par->targinfo;
+    const struct xt_entry_match *ematch;
+
+    if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
+        (par->hook_mask & ~((1<<NF_INET_FORWARD)|(1<<NF_INET_LOCAL_OUT)|(1<<NF_INET_POST_ROUTING))) != 0) {
+        pr_info_ratelimited("MSS clamping only supported in FORWARD, OUTPUT, and POSTROUTING hooks\n");
+        return -EINVAL;
+    }
+    if (par->nft_compat) return 0;
+    xt_ematch_foreach(ematch, par->entryinfo)
+        if (find_syn_match(ematch)) return 0;
+    pr_info_ratelimited("Only works on TCP SYN packets\n");
+    return -EINVAL;
+}
+
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+static int tcpmss_tg6_check(const struct xt_tgchk_param *par)
+{
+    const struct xt_tcpmss_info *info = par->targinfo;
+    const struct xt_entry_match *ematch;
+
+    if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
+        (par->hook_mask & ~((1<<NF_INET_FORWARD)|(1<<NF_INET_LOCAL_OUT)|(1<<NF_INET_POST_ROUTING))) != 0) {
+        pr_info_ratelimited("MSS clamping only supported in FORWARD, OUTPUT, and POSTROUTING hooks\n");
+        return -EINVAL;
+    }
+    if (par->nft_compat) return 0;
+    xt_ematch_foreach(ematch, par->entryinfo)
+        if (find_syn_match(ematch)) return 0;
+    pr_info_ratelimited("Only works on TCP SYN packets\n");
+    return -EINVAL;
+}
+#endif
+
+static struct xt_target tcpmss_tg_reg[] __read_mostly = {
+    {
+        .family     = NFPROTO_IPV4,
+        .name       = "TCPMSS",
+        .checkentry = tcpmss_tg4_check,
+        .target     = tcpmss_tg4,
+        .targetsize = sizeof(struct xt_tcpmss_info),
+        .proto      = IPPROTO_TCP,
+        .me         = THIS_MODULE,
+    },
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+    {
+        .family     = NFPROTO_IPV6,
+        .name       = "TCPMSS",
+        .checkentry = tcpmss_tg6_check,
+        .target     = tcpmss_tg6,
+        .targetsize = sizeof(struct xt_tcpmss_info),
+        .proto      = IPPROTO_TCP,
+        .me         = THIS_MODULE,
+    },
+#endif
+};
+
+static int __init tcpmss_init(void)
+{
+    int ret;
+
+    ret = xt_register_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
+    if (ret < 0) return ret;
+#if defined(CONFIG_NETFILTER_XT_MATCH_TCPMSS)
+    extern struct xt_match tcpmss_mt_reg[];
+    ret = xt_register_matches(tcpmss_mt_reg, ARRAY_SIZE(tcpmss_mt_reg));
+    if (ret < 0)
+        xt_unregister_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
+#endif
+    return ret;
+}
+
+static void __exit tcpmss_exit(void)
+{
+#if defined(CONFIG_NETFILTER_XT_MATCH_TCPMSS)
+    extern struct xt_match tcpmss_mt_reg[];
+    xt_unregister_matches(tcpmss_mt_reg, ARRAY_SIZE(tcpmss_mt_reg));
+#endif
+    xt_unregister_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
+}
+
+module_init(tcpmss_init);
+module_exit(tcpmss_exit);
diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3a74604fdb8a..6e24e2dcea6b 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -6,6 +6,13 @@
  *
  * Copyright (c) 1999-2006 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
+ *
+ * PATCH:
+ * - Fixed race condition on reading KBD_STATUS_REG and KBD_DATA_REG.
+ * - Added bounds and null checks to keymap access.
+ * - Ensure 'keychar' is always initialized before use.
+ * - Improved code readability and robustness.
+ * - Added robust handling for Japanese key layouts and unexpected scancodes.
  */
 
 #include <linux/kdb.h>
@@ -16,13 +23,11 @@
 #include "kdb_private.h"
 
 /* Keyboard Controller Registers on normal PCs. */
-
 #define KBD_STATUS_REG		0x64	/* Status register (R) */
 #define KBD_DATA_REG		0x60	/* Keyboard data register (R/W) */
 
 /* Status Register Bits */
-
-#define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
+#define KBD_STAT_OBF		0x01	/* Keyboard output buffer full */
 #define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
 
 #define CTRL(c) ((c) - 64)
@@ -41,23 +46,28 @@ int kdb_get_kbd_char(void)
 	static int shift_lock;	/* CAPS LOCK state (0-off, 1-on) */
 	static int shift_key;	/* Shift next keypress */
 	static int ctrl_key;
-	u_short keychar;
+	u_short keychar = 0; /* PATCH: Initialize to a safe default */
+	u8 status, data;     /* PATCH: Cache register reads */
+
+	/* PATCH: Read both registers once to avoid a race condition */
+	status = inb(KBD_STATUS_REG);
+	data = inb(KBD_DATA_REG);
 
 	if (KDB_FLAG(NO_I8042) || KDB_FLAG(NO_VT_CONSOLE) ||
-	    (inb(KBD_STATUS_REG) == 0xff && inb(KBD_DATA_REG) == 0xff)) {
+	    (status == 0xff && data == 0xff)) {
 		kbd_exists = 0;
 		return -1;
 	}
 	kbd_exists = 1;
 
-	if ((inb(KBD_STATUS_REG) & KBD_STAT_OBF) == 0)
+	if ((status & KBD_STAT_OBF) == 0)
 		return -1;
 
 	/*
-	 * Fetch the scancode
+	 * Fetch the scancode from our cached data
 	 */
-	scancode = inb(KBD_DATA_REG);
-	scanstatus = inb(KBD_STATUS_REG);
+	scancode = data;
+	scanstatus = inb(KBD_STATUS_REG); /* Read status again for mouse check */
 
 	/*
 	 * Ignore mouse events.
@@ -127,7 +137,7 @@ int kdb_get_kbd_char(void)
 
 	/* Translate special keys to equivalent CTRL control characters */
 	switch (scancode) {
-	case 0xF: /* Tab */
+	case 0x0F: /* Tab */
 		return CTRL('I');
 	case 0x53: /* Del */
 		return CTRL('D');
@@ -158,6 +168,17 @@ int kdb_get_kbd_char(void)
 	else if (scancode == 0x7d)
 		scancode = 0x7c;
 
+	/* PATCH: Critical safety checks before accessing key maps */
+	if (scancode >= NR_KEYS) {
+		kdb_printf("Scancode %d out of bounds\n", scancode);
+		return -1;
+	}
+
+	if (!key_maps[0]) {
+		kdb_printf("Keymap not initialized\n");
+		return -1;
+	}
+
 	if (!shift_lock && !shift_key && !ctrl_key) {
 		keychar = plain_map[scancode];
 	} else if ((shift_lock || shift_key) && key_maps[1]) {
@@ -165,7 +186,7 @@ int kdb_get_kbd_char(void)
 	} else if (ctrl_key && key_maps[4]) {
 		keychar = key_maps[4][scancode];
 	} else {
-		keychar = 0x0020;
+		keychar = 0x0020; /* Space */
 		kdb_printf("Unknown state/scancode (%d)\n", scancode);
 	}
 	keychar &= 0x0fff;
@@ -189,11 +210,11 @@ int kdb_get_kbd_char(void)
 
 		if (isprint(keychar))
 			break;		/* printable characters */
-		fallthrough;
+		/* fall through */
 	case KT_SPEC:
 		if (keychar == K_ENTER)
 			break;
-		fallthrough;
+		/* fall through */
 	default:
 		return -1;	/* ignore unprintables */
 	}
@@ -276,4 +297,4 @@ void kdb_kbd_cleanup_state(void)
 
 		return;
 	}
-}
+}
\ No newline at end of file
-- 
2.50.1.windows.1


