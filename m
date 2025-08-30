Return-Path: <linux-kernel+bounces-792617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7444B3C6B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265805A4D06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32D21B9F6;
	Sat, 30 Aug 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CHrV7b82"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66F20B80B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514773; cv=none; b=OdKdNK6Zo5Vh94H5Fppwk72TBD+ePfJYJYXRajVlAq2d6QqCPHS1hctiSk37XwN84haLNtawrYcJ25iQDXBrnZXACUZaqP2JXRIWiaj44o0IZkdCcvCQIbIk/QDIraMTCdGswNSik0Mu8ww59paHcicFET45ofUVWQ2Zp+QRuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514773; c=relaxed/simple;
	bh=O2YgX+JruXR6onRfFHNHOFxmMwYdN3MBokIGWnyLdec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsZT4zmuKTJQ/snhY/fh3lMUg3ftnW3vF/lAfLM9vgNXc6eo4Fj9/VILdk33OARvhcB/PzXpfis8Z5XUYjt+MN1JyoQhOi5Hy5LEahmul7cOetMyC8tXoTqG82LxmYh4NamHGLjutAKve+BKvW7u5XQQqmKSIg7S8bKggmJYKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CHrV7b82; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756514768;
	bh=O51t9uXRZDWfHOs4T+32Q8b9n8HEvnl1dQIluZTl7qY=;
	h=From:Subject:Date:Message-ID;
	b=CHrV7b82bIOwfZee2j6LxUiQjJ8Je4ec5ANr5gf45EG8OUrG/SZREMnHXv2k/y+gQ
	 OHG31PX41OKh6K5l7YZXZGQLLIweVqOydlyHbDjQ4m+2yGXzD7I9osd1lioQLttDP0
	 G05I3p66faKbJI8cNYPIidgn2VkF4i2ax4/kcQKU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68B249C5000006E5; Sat, 30 Aug 2025 08:45:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3237406816158
X-SMAIL-UIID: D69BC2B74D4A42CDBC68A0855DD2F677-20250830-084559-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Date: Sat, 30 Aug 2025 08:45:48 +0800
Message-ID: <20250830004549.6070-1-hdanton@sina.com>
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 29 Aug 2025 11:38:35 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17333fbc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e9262580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ed0242580000

#syz test

--- x/kernel/time/hrtimer.c
+++ y/kernel/time/hrtimer.c
@@ -1718,7 +1718,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer_clock_base *base,
 			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags) __must_hold(&cpu_base->lock)
+			  unsigned long flags, bool soft) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	bool expires_in_hardirq;
@@ -1755,6 +1755,8 @@ static void __run_hrtimer(struct hrtimer
 	 * is dropped.
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	if (soft)
+		hrtimer_cpu_base_unlock_expiry(cpu_base);
 	trace_hrtimer_expire_entry(timer, now);
 	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
@@ -1762,6 +1764,8 @@ static void __run_hrtimer(struct hrtimer
 
 	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
+	if (soft)
+		hrtimer_cpu_base_lock_expiry(cpu_base);
 	raw_spin_lock_irq(&cpu_base->lock);
 
 	/*
@@ -1822,7 +1826,8 @@ static void __hrtimer_run_queues(struct
 			if (basenow < hrtimer_get_softexpires_tv64(timer))
 				break;
 
-			__run_hrtimer(cpu_base, base, timer, &basenow, flags);
+			__run_hrtimer(cpu_base, base, timer, &basenow, flags,
+					active_mask == HRTIMER_ACTIVE_SOFT);
 			if (active_mask == HRTIMER_ACTIVE_SOFT)
 				hrtimer_sync_wait_running(cpu_base, flags);
 		}
--

