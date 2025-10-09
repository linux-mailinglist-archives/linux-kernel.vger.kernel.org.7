Return-Path: <linux-kernel+bounces-846488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575FEBC825F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A61A6114E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5F2D3756;
	Thu,  9 Oct 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LDlqpEtN"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068A2D3A9E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000141; cv=none; b=IYnVQ08DUdhmEyKx0nTkHMi08hQT4BJpnxa1lhEDUtaRI9Ma0Pb1qmOXgslyo3w/anLXm8VVUpk9PqPkP/c9AS2fCiivd20ZaZcc8V0OCCQhuu1DRNa5Edzv4oWxs7ML3wtO4mFpISv7XvzQo6r+y7y5vIP21afMu7J4KT39Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000141; c=relaxed/simple;
	bh=xnTi5VA/d59yMJc5spn5eQJkwJMLSaRH9Y+EYI0bvsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZtLH285Jby9KhzuGoZi+L2GoTk+LZv2yT+DDrv0vjPECZxiNMX4jvcEYltGWGhqWmDIS8SyVCVfeErtNgitdxD/BcVtXAM5usiiuRayZcAxW25grDLAW4MImc1vAormn12gtJyiOwNWYAE8+2sQ5q0E1nh2kU/brDSnV1/XWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LDlqpEtN; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760000136;
	bh=qt6bJTnzhAE775NcxlG3BYg+H4u4c9N3AhQKUGu2IO4=;
	h=From:Subject:Date:Message-ID;
	b=LDlqpEtNRUyvy7HSgOjOtbTSeAh3XZCwCRM8Zj4AgyZGvO8LMlIzX0X2Cblp85Rxi
	 3/5IVBDjpb8cUaQIOVOwEqm/FdpzXCK4Fwvab+4fPC3BfKwhqR8wzKom7FJTOVoPQg
	 0+C0PRB1ravqaVoxlAReOaDyvcj8mdIdsbw52/Yk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68E7787C00006967; Thu, 9 Oct 2025 16:55:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1852006685266
X-SMAIL-UIID: 2D7AE35B7A7F4683AD3A834504B52ECD-20251009-165526-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
Date: Thu,  9 Oct 2025 16:55:14 +0800
Message-ID: <20251009085515.8396-1-hdanton@sina.com>
In-Reply-To: <68e583e1.a00a0220.298cc0.0485.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 07 Oct 2025 14:19:29 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a25ee2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b4263e12240e6e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eaea7c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c4304580000

#syz test

--- x/include/linux/flex_proportions.h
+++ y/include/linux/flex_proportions.h
@@ -31,7 +31,7 @@ struct fprop_global {
 	/* Current period */
 	unsigned int period;
 	/* Synchronization with period transitions */
-	seqcount_t sequence;
+	seqlock_t sequence;
 };
 
 int fprop_global_init(struct fprop_global *p, gfp_t gfp);
--- x/lib/flex_proportions.c
+++ y/lib/flex_proportions.c
@@ -44,7 +44,7 @@ int fprop_global_init(struct fprop_globa
 	err = percpu_counter_init(&p->events, 1, gfp);
 	if (err)
 		return err;
-	seqcount_init(&p->sequence);
+	seqlock_init(&p->sequence);
 	return 0;
 }
 
@@ -64,21 +64,20 @@ void fprop_global_destroy(struct fprop_g
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
 	s64 events = percpu_counter_sum(&p->events);
+	unsigned long flags;
 
 	/*
 	 * Don't do anything if there are no events.
 	 */
 	if (events <= 1)
 		return false;
-	preempt_disable_nested();
-	write_seqcount_begin(&p->sequence);
+	write_seqlock_irqsave(&p->sequence, flags);
 	if (periods < 64)
 		events -= events >> periods;
 	/* Use addition to avoid losing events happening between sum and set */
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
-	write_seqcount_end(&p->sequence);
-	preempt_enable_nested();
+	write_sequnlock_irqrestore(&p->sequence, flags);
 
 	return true;
 }
@@ -148,15 +147,15 @@ void fprop_fraction_percpu(struct fprop_
 			   struct fprop_local_percpu *pl,
 			   unsigned long *numerator, unsigned long *denominator)
 {
-	unsigned int seq;
+	unsigned seq;
 	s64 num, den;
 
 	do {
-		seq = read_seqcount_begin(&p->sequence);
+		seq = read_seqbegin(&p->sequence);
 		fprop_reflect_period_percpu(p, pl);
 		num = percpu_counter_read_positive(&pl->events);
 		den = percpu_counter_read_positive(&p->events);
-	} while (read_seqcount_retry(&p->sequence, seq));
+	} while (read_seqretry(&p->sequence, seq));
 
 	/*
 	 * Make fraction <= 1 and denominator > 0 even in presence of percpu
--

