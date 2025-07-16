Return-Path: <linux-kernel+bounces-732691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E186B06AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13444A632A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1293137C52;
	Wed, 16 Jul 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KPtZpNs0"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB34315C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626725; cv=none; b=RFYYtQEyu+Sx0riOqQeIIYBB4mluELnJUU+Yhl21E0kgMbL1tlKRUm5MzZOVswUUhkvIIk/fQcXcT/ilUNGaY3kjh9+qECzGwzB3ud/JHdFRaxM1He+PkDf1gUE0vv1OSsfDn+/VeH4MMYaE91Px2sVeye/fIrERsr4kvCViYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626725; c=relaxed/simple;
	bh=hOhF5b6Wo+iuFrdgS3rZewKm2d19avygFGeuQaTTA0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR8RGQa9pGbDZowLURAfTnGt0TGhQG74OjHwXobXEzl7pkJ8klZFJWy+TMIzAhsbZ/wB9oso3RYKO+VFPmvscqUtC9RiRaWrHRhsBa1bBJmIoZLTohq9ByYJ/J66fIeHHd6pTYJd++oaTenYq3mGsVxB6yRBz38/bCVbc9Aqa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KPtZpNs0; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752626720;
	bh=q97efxuGXSOoPx89viyX9vgtfWt6DOPRRcVCkcv5CUU=;
	h=From:Subject:Date:Message-ID;
	b=KPtZpNs0s77U9UmxRmtu5h6Da00gOVZ6lIhwZxPe5a6Mzw2OhfwGrPlrFehtgt0MO
	 3GGMc6T1j+CjcG5lHxR0nTC/KlRqLBbWIHymhzklAZ4+jwm4hWpwtqRlW7lwxDYAN1
	 yoRqztk0f71LA6gmvWU3oH8f/ljA+iSZ974dXOW8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6876F61500006956; Wed, 16 Jul 2025 08:45:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7541436816353
X-SMAIL-UIID: 006F4471C96440999A91735DA77DC5AB-20250716-084510-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
Date: Wed, 16 Jul 2025 08:44:58 +0800
Message-ID: <20250716004459.2148-1-hdanton@sina.com>
In-Reply-To: <6876cc3c.a00a0220.3af5df.000a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 15 Jul 2025 14:46:36 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    55e8757c6962 Merge branch 'net-mctp-improved-bind-handling'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15834382580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d2a6ef56c3805144bf0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1445058c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148e098c580000

#syz test

--- x/net/ipv4/tcp_input.c
+++ y/net/ipv4/tcp_input.c
@@ -5514,14 +5514,16 @@ static bool tcp_prune_ofo_queue(struct s
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
 		goal -= skb->truesize;
-		tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE);
 		tp->ooo_last_skb = rb_to_skb(prev);
 		if (!prev || goal <= 0) {
 			if (tcp_can_ingest(sk, skb) &&
-			    !tcp_under_memory_pressure(sk))
+			    !tcp_under_memory_pressure(sk)) {
+				tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE);
 				break;
+			}
 			goal = sk->sk_rcvbuf >> 3;
 		}
+		tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE);
 		node = prev;
 	} while (node);
 
--

