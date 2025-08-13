Return-Path: <linux-kernel+bounces-765727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E433B23D60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604046E09B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981867261B;
	Wed, 13 Aug 2025 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WvjxPPL8"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBD41C72
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046591; cv=none; b=AZIG9KuyEOiziEmzhfJ24IJC0mUSKo85TP2b4/l7I9GaE1RnLdlpRpbicPAx3zjdduHekqrV28boTY0Z1mV0CR/cDt5pAaohXN7iBwBiMcJozAnwXE1LzlLWqZuD47v0CLKPU9ownClI5CrVK8+9rh/mhHsDDpqMrEUQoShoxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046591; c=relaxed/simple;
	bh=HeMs1zHUklwS4lRn3c4GRn2Mj+gq/8f6LebuEQULqE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlnXhYj5aualvLW0Sqa8N2YMH3cksVqb0h4QXWsGUD0enpJPhkp5zQbYE890yan1dEFmYS+Au2IwlQrp8kYRJtrRIqzuaBrnxKjqydoUYOX2uE1HuQD16xzw/CwP5im5HqiZWobe6upH8IYCumaemvIvX2v8zX0+N31sdELDTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WvjxPPL8; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755046582;
	bh=aCl3WCLM27r61awMhmhUc3uEv6ThXfR/LMEEHoKtA4A=;
	h=From:Subject:Date:Message-ID;
	b=WvjxPPL8NJE7hrJDC+pZb2h8qShf0b3uyZWh1sc0GZmrQk18xGZy8E6/g+q1YLDN7
	 y8DjE3P+Op7zUb12xYkirOkDlGUBuTpWhuWfaoVa9wE6u+95vIb7zN00fxKqPtaP2l
	 cDylnabIFtWA+9+nbizlFisbo5DAv+WLRbVzQbm0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689BE2AB00000484; Wed, 13 Aug 2025 08:56:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 106194456622
X-SMAIL-UIID: 407C2B96D0A240E6A615DA42EEC5360F-20250813-085613-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	edumazet@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
Date: Wed, 13 Aug 2025 08:56:00 +0800
Message-ID: <20250813005602.4330-1-hdanton@sina.com>
In-Reply-To: <xalg6eonr23hzgr5cbnmxfid2sv7crwgtehmytpkdiqzvpdsn6@tkjqfsirrlrv>
References: <688bb9ca.a00a0220.26d0e1.0050.GAE@google.com> <689b1044.050a0220.7f033.011b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 08:33:58 -0700 Breno Leitao wrote:
> On Tue, Aug 12, 2025 at 02:58:28AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c415a2580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151be9a2580000
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7f26eabe958a/vmlinux-53e760d8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/60128fb74c23/bzImage-53e760d8.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
> > 
> > BUG: unable to handle page fault for address: ffff88808d211020
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0002) - not-present page
> > PGD 1a201067 P4D 1a201067 PUD 0 
> > Oops: Oops: 0002 [#1] SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 6665 Comm: syz.1.416 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full) 
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
> > RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
> > RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
> > RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714
> 
> This is being fixed in this thread:
> 
> https://lore.kernel.org/all/20250731184829.1433735-1-kuniyu@google.com/

#syz test

Fixes: 2a68a22304f9 ("netdevsim: account dropped packet length in stats on queue free")
Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/688bb9ca.a00a0220.26d0e1.0050.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/netdevsim/netdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 39fe28af48b9..5cbc005136d8 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -710,9 +710,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
 static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
 {
 	hrtimer_cancel(&rq->napi_timer);
-	local_bh_disable();
-	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
-	local_bh_enable();
+
+	if (likely(dev->reg_state != NETREG_UNINITIALIZED)) {
+		local_bh_disable();
+		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
+		local_bh_enable();
+	}
+
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
-- 
2.50.1.565.gc32cd1483b-goog

