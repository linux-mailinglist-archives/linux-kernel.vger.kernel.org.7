Return-Path: <linux-kernel+bounces-844940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E569BC31AD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFCED4E91B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089E28CF7C;
	Wed,  8 Oct 2025 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="r+Kuc63Y"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4D1DE4FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759885851; cv=none; b=dFi7n3DU60jfKPD+i9kREAVTCHNi1wCbOKMTbHj3JsfgfC8NmeA5ib31UGFFJpsdlGWzo5WDlPSPAK+X+Bbs6FbgRzPXpEKc0gq9wA/29nrzfzQ9x1K5IvPoy2woihapu7B95Jmz4/fWkFrhlmpvY6gaPjyfJwyZAIonWx9m1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759885851; c=relaxed/simple;
	bh=whGDHiCRfNS7j5DWDDgdMwTjwwfI6IJun0sN9QVlHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWkrphrxY4r1yd92qGcOd2JoDz93TErMkQeKx0zb/qpLL5R4vdSmbAPsKnK2WnURcBkOHEJxJXgl6DbkQUynG3jn8YNoh1mwjPv41HbAeM4p3L6ykjTN+OKlzqhztfbcmanmxHNOgFsO8u9x2mi0mgxiH1eLK5HOv2yGLjcEEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=r+Kuc63Y; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759885842;
	bh=jCebY8UK4SHidkoM7FSA/sJzpS1AI0S6Bypqpp6wEsE=;
	h=From:Subject:Date:Message-ID;
	b=r+Kuc63YMQJmQ7MlGzJIbwR7RpN82Bs1pt8dDk5wf6IunIYwqNBw+IruJ7Je9xcfA
	 m3+eBvoy4seEdEH7L3dzmTRjKHoBV4rNgy9Ua5teB/5smvpxc9E08tyzDkyhWJUGYc
	 poCtlZCuWQj0rJLaMlqfT58SFenq1+XHayW9Xfv4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68E5BA070000733E; Wed, 8 Oct 2025 09:10:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9110464457053
X-SMAIL-UIID: A59A077D66C24934AA0D36DD0E91EBA3-20251008-091032-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
Date: Wed,  8 Oct 2025 09:10:20 +0800
Message-ID: <20251008011021.8322-1-hdanton@sina.com>
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

--- x/lib/flex_proportions.c
+++ y/lib/flex_proportions.c
@@ -64,12 +64,14 @@ void fprop_global_destroy(struct fprop_g
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
 	s64 events = percpu_counter_sum(&p->events);
+	unsigned long flags;
 
 	/*
 	 * Don't do anything if there are no events.
 	 */
 	if (events <= 1)
 		return false;
+	local_irq_save(flags);
 	preempt_disable_nested();
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
@@ -79,6 +81,7 @@ bool fprop_new_period(struct fprop_globa
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
 	preempt_enable_nested();
+	local_irq_restore(flags);
 
 	return true;
 }
--

