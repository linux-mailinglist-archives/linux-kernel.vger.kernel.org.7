Return-Path: <linux-kernel+bounces-748744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB089B1458E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C91A7AE847
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3DE193079;
	Tue, 29 Jul 2025 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lFYVquxP"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FD3C38
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751276; cv=none; b=hP3ojkfK+N0Rufx/Nf2H0MzX/kqZxHWWlYUkotG5O6Ri/Z2CC2tmqtyOHxSNPsTpROEn8UeXokfPggslT8kr8kOof/hRknAga8mrqSQpPaFMVavv/zmDQvW9xo74BTGM8akR7miWPyP9wDkxI92eGK7egeR93E4sjOzWKbuEhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751276; c=relaxed/simple;
	bh=WD9FaDGb63M7KxP1pupSuXLBiDk6KJua+yjTVfbjOzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPGYcQrVDJu2uSy20ISTrwX/3AJ6bxYKaY/XRHfXl7Gzlaz8uVvuAIynUW/vF5FCRxnIYSONXQcWrpw899WB47+bmUAy/bFUUjLQnDs60CWLeAvS7x9tXxHZtPcvIxmfl39kc4QenZjBO19dTyA3wqpaV7MorJWKPJa8WrWzMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lFYVquxP; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753751271;
	bh=DJcvxvLUlEjzlD05x0/DLHsYRHP+TmolVpjDi1qmHVs=;
	h=From:Subject:Date:Message-ID;
	b=lFYVquxPKGTlfEISnlmLH+d2ssEIdIdk0q47lFj4u+KfeWeF8GT7PdG75mkgBokjM
	 w/pcQ2NaPPTZD2hsbUG0YkP9chFBgTdC/5FrVvp2A5lnlLqMDHXZTYp5IC49zdDHO9
	 7lYVYkZN4+k+rLYdM3Q7Yp4ZiB0PU3laM8jzoKco=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68881EB900004E84; Tue, 29 Jul 2025 09:07:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5217856816227
X-SMAIL-UIID: DBB33BB01FC348DCB0C814F4A4CB1DB1-20250729-090707-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
Date: Tue, 29 Jul 2025 09:06:56 +0800
Message-ID: <20250729010657.3326-1-hdanton@sina.com>
In-Reply-To: <6887ebf4.a00a0220.b12ec.00ae.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 28 Jul 2025 14:30:28 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    afd8c2c9e2e2 Merge branch 'ipv6-f6i-fib6_siblings-and-rt-f..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c71034580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4bcc0a11b3192be
> dashboard link: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b284a2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c71034580000

#syz test upstream master

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -918,7 +918,7 @@ static enum hrtimer_restart advance_sche
 	int num_tc = netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
-	ktime_t end_time;
+	ktime_t end_time, now;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -980,6 +980,11 @@ first_run:
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
+	now = timer->base->get_time();
+	now = ktime_add_us(now, 2);
+	/* is end_time sane? */
+	if (ktime_after(now, end_time))
+		end_time = now;
 	hrtimer_set_expires(&q->advance_timer, end_time);
 
 	rcu_read_lock();
--

