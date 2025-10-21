Return-Path: <linux-kernel+bounces-863418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B29BF7D67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F0189839A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9834B192;
	Tue, 21 Oct 2025 17:14:19 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E934B186
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066859; cv=none; b=D4ywrDLeNopXQBcSaEsDB+qP++K2J66LYbDDOQVPalvUHiJ87iM8BP9HanePw34VK9yq70Mqj8idMfScbOG1hk9l0t7iLR4W0i6hR0/L9IPvnbQHXPU0F/YuZGJv/WFlZfc4TmMw9BonB7ckUotXBNy1yPUyv/5fCMMA+w8WIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066859; c=relaxed/simple;
	bh=m9I51bYY1m0WNs/hOiA/JO2dxI3lUIwza6OUCjsL2hU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fCnxgt28FQ9VQnNi2YRM/16dHpMcZf84hMJi7cZ/b+LecNW2gEbooG+fJYusXYDQY/FoI6Qsb+GajSw88tgB3XFCLW915CJT09TXk7r1tnIZnsgsVjZP9/09V+habrcCsqSy5JF99TP7C5X0lfODV8uJlMmrzl7Fep/z/XTJpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430db6d358bso98113705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761066856; x=1761671656;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IzUxC1g+9YHJve3PM4ojm62q86eibiPXknM8z0/u0U=;
        b=sBzzM8+Toq7ZAyMK7gP3oR429xuH8GAKvlPRcWibmYGLtwLJklbWRQF4yjvP4In5bj
         Y5LCN+LIhfEtJRnYhkRUW65uB2Arw/n+9cSQyIh65q1frBSR2erjT/nVUYPgQGdHFBoT
         iMqnU9Hw0Etq4kSwJQoqqJrftb9KQDzZPhD8u/xNfowVY5amZyEnnJF1THiKtCU7qvaN
         eb+n//+gQnSXVr83Jm2sUL0/zmxc+43Qg5poaC9EFVnTRL3WEFjKbTqudUyMDY7calv5
         sVT9Gx+6JMKxGzsW+bCW8t+tMAUmteB1OA4yPBUpOrDxFrgrxOMsIkO3pRwql1IpXnoG
         yIcg==
X-Gm-Message-State: AOJu0Ywxi12yb+1MzcGwShF7OGW47dw/orgjjZaQc0hkJBMx1n8rpb6o
	eMcv1HO1h2wRg44NpkApeFriaY+Ivth2MqEYDK0iOWdpCXtgd7a2/l8K6j5FNlC8E9RPZqo0b7N
	RZoL+K9T1XbY9FwiPh5a7jKNCNj3HL3PPIfG2OXWq96Pk1076x7uUMfrf7b0hog==
X-Google-Smtp-Source: AGHT+IEbCecws4o5ZNPdTx6Mc2K419p4OBioUSvhE5KlKdV6tVTzu8M0pQ7fqIfcSQm5dqVFMdvQcjniU4ykLceymB95gsneGMJh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:430:b6a3:53b4 with SMTP id
 e9e14a558f8ab-430c52343f1mr283815495ab.3.1761066856292; Tue, 21 Oct 2025
 10:14:16 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:14:16 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7bf68.050a0220.346f24.0022.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
Author: listout@listout.xyz

On 20.10.2025 14:07, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16be6734580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
> dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111e7dcd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1223a492580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8ad8459a8da/disk-98ac9cc4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/28720fa307c1/vmlinux-98ac9cc4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e4f310acec99/bzImage-98ac9cc4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
> 
> mac80211_hwsim hwsim5 wlan1: entered allmulticast mode
> =====================================================

#syz test

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..05bb49afd5ef 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -938,9 +938,9 @@ EXPORT_SYMBOL(ieee80211_amsdu_to_8023s);
 unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 				    struct cfg80211_qos_map *qos_map)
 {
-	unsigned int dscp;
-	unsigned char vlan_priority;
-	unsigned int ret;
+	unsigned int dscp = 0;
+	unsigned char vlan_priority = 0;
+	unsigned int ret = 0;
 
 	/* skb->priority values from 256->263 are magic values to
 	 * directly indicate a specific 802.1d priority.  This is used
@@ -963,10 +963,18 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
+		if (skb_network_header_len(skb) >= sizeof(struct iphdr)) {
+			struct iphdr *iph = ip_hdr(skb);
+			if (iph)
+				dscp = ipv4_get_dsfield(iph) & 0xfc;
+		}
 		break;
 	case htons(ETH_P_IPV6):
-		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
+		if (skb_network_header_len(skb) >= sizeof(struct ipv6hdr)) {
+			struct ipv6hdr *ip6h = ipv6_hdr(skb);
+			if (ip6h)
+				dscp = ipv6_get_dsfield(ip6h) & 0xfc;
+		}
 		break;
 	case htons(ETH_P_MPLS_UC):
 	case htons(ETH_P_MPLS_MC): {

-- 
Regards,
listout

