Return-Path: <linux-kernel+bounces-726704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72491B0103D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AD8764B68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520CB663;
	Fri, 11 Jul 2025 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="DL3yuzRj"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DA376
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193999; cv=none; b=Spx3imN4QcEspzUZnapo+m49cHTTfJNoXDxbo8PlSrvgC28bHMJK7Cvhfj1/TEKJV2p5gn6AWax5fzLElvZUOFIGU1vHhezXbsZeqXewzT5ZCQoM0qkKCRQERwVPeiasKLOdfU8h4EKmp9eMse8RP0bL3a4kUF80W3RdF98/NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193999; c=relaxed/simple;
	bh=nLBVhmOTFwQicx/0amm3J0sZJxg8zN5jYQvE7jC/bIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUmJIDRuEQh8Fw68s8hjRDexdSvVY4SqsLgeMQF/v7Gai5vrrAVrhy0dOWZ2qAVeSFUbXz42koJOxuq7VVMr4AEwAwe4WW3eFbDCYNPMtwVBGtQrquzxTvYg7URoQaoIPXO+pJBb+HYhA0dD9fKUFTUA/VCOsk2ZbpGmaibOpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=DL3yuzRj; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752193994;
	bh=gDCA32Zv52vzKAykJ8VkNEDYWXoPIxJYR8FQLv/d4pg=;
	h=From:Subject:Date:Message-ID;
	b=DL3yuzRjCj/jicA6p60Uiv64spHpxOmCO7GDKUMs0zgdC3e4U3P6WdlJ8MB5qOAkN
	 DwTRR/kW4B43vpg6/pBvpNY/WBICQclq6B1UaNYGvzN+2iv/WYUp7BELgbZpmPXvph
	 GdeSGQoNGTI4tfWaWhMLcqPjZgP2SRXE+aVVCGCA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68705B9D000046E7; Fri, 11 Jul 2025 08:32:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7878854457019
X-SMAIL-UIID: B0E67940BABB4BC88C93006878F25453-20250711-083230-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
Date: Fri, 11 Jul 2025 08:32:18 +0800
Message-ID: <20250711003220.3259-1-hdanton@sina.com>
In-Reply-To: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 10:52:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1719df70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
> dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124abd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099df70580000

#syz test

--- x/fs/proc/task_mmu.c
+++ y/fs/proc/task_mmu.c
@@ -187,6 +187,7 @@ static struct vm_area_struct *get_next_v
 }
 
 #else /* CONFIG_PER_VMA_LOCK */
+static void unlock_vma(struct proc_maps_private *priv) {}
 
 static inline bool lock_vma_range(struct seq_file *m,
 				  struct proc_maps_private *priv)
@@ -582,6 +583,7 @@ skip_vma:
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
 
+	unlock_vma(priv);
 no_vma:
 	return ERR_PTR(-ENOENT);
 }
--

