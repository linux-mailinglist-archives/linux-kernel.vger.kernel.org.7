Return-Path: <linux-kernel+bounces-797605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2158B41265
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E5701808
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19451DE4CE;
	Wed,  3 Sep 2025 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dgpAtYmU"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507441A8F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866835; cv=none; b=QzNA+kY4KxzRU0brfxTR/rKiti0x0H8C7rx36TRpWBdHNlcyHzxZf5ogDLzXKq3OpDfxp8WS3xTHSo8BlQF9NiUpt0kkfY/m8TWHEss43khGWj0JneRXpMZcszzu7iJuLFVFGDz4qkj9dJaeBhhXvSUsvIb5DTf3DoeyNPJmh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866835; c=relaxed/simple;
	bh=6xZfxtcaUzl5/9Cm6wTgROkR0boDAFypzIxXKko+w9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4CN6z+i5OmnLiGM1Bd24dyMHdVdGnAMzxM21gTsMPwtQhAomM0379Ghrw6RVEjFpxEBe4lJn+ZEu2h1sZT6hJ/+h7kFuppFunJpHUK5DT/KHWL6r/Cao9SRvOcan1I5JPNQE9PejvLE4L7DL3gA6Iu9+wq1IukRp3KOuc37UIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dgpAtYmU; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756866826;
	bh=nU9T5G15JS845jaGvFfo+n9HslrBJXYb/KPr7JZHe3k=;
	h=From:Subject:Date:Message-ID;
	b=dgpAtYmUXQDTCivW4AFqAyjGoHvgMsJOlKYnSeZsiFeboPkp3E1qzBn4OpTNzQ0Ak
	 OzAZRbF6ZLOJMOYRXCppYOKHsMAMuCUOfTqA9gMtXGMYYjR78cisD1t3s3i/JuE3ND
	 8D3EnqAeppr5H9Z3lEmA/GxzmgzVnDn8v7C1Vwz0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68B7A8FE00007E03; Wed, 3 Sep 2025 10:33:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4886904456632
X-SMAIL-UIID: 0E16182F2EF54347BF04119F51E20543-20250903-103336-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [mm?] INFO: rcu detected stall in wb_workfn (4)
Date: Wed,  3 Sep 2025 10:33:25 +0800
Message-ID: <20250903023326.6389-1-hdanton@sina.com>
In-Reply-To: <68b70218.050a0220.3db4df.01d1.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 02 Sep 2025 07:41:28 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b320789d6883 Linux 6.17-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1406ae62580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5e34580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1639ca42580000

#syz test upstream master

--- x/kernel/rcu/tree_stall.h
+++ y/kernel/rcu/tree_stall.h
@@ -590,8 +590,15 @@ static void rcu_check_gp_kthread_starvat
 			if (cpu_is_offline(cpu)) {
 				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
 			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
+				int i;
 				pr_err("Stack dump where RCU GP kthread last ran:\n");
 				dump_cpu_task(cpu);
+				for_each_online_cpu(i) {
+					if (i == cpu)
+						continue;
+					pr_err("Stack dump on CPU%d\n", i);
+					dump_cpu_task(i);
+				}
 			}
 			wake_up_process(gpk);
 		}
--

