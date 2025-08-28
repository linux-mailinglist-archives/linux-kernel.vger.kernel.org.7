Return-Path: <linux-kernel+bounces-789451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFBAB395AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB50188BAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435B2F546E;
	Thu, 28 Aug 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="wP5SLTSh"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3129D28B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366738; cv=none; b=Bp8lSBgH/IlfRKJCojeJNY8drY7PFg6D8XmipiiMx92JbxGKK7HCnPlWHfwNcqBDeYqlymGIsJRex2cw1pNWNS3m73WHsAvg1tVvL1xs44TZ5D16R3pwDOePegFmwIdMIjSTJPNtoEvQi38vLFUKHE8FhpzKt5LwcSU4Yf9cEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366738; c=relaxed/simple;
	bh=i6bfWI6FyGsXYagDvtXoYptu2RIx4bPhqJ7dXA18FKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDZHv53fi6EOrBBRPfVT9lgK0Lct8/k9ClUx2sji7Mpv4AGntfJXLerDJIwXycsa2VUTZIw+ZZMQhak0v4bPW48mjyF6Kn4bv3oDtCNAD9ri8PTMyIsmS1/G7c5Uld01y7tCLA87FolrPpt8wmL3q55aPZpuiW69IQvBD73t99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=wP5SLTSh; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756366731;
	bh=H4YCtLmRJ3C5AmyFNtWQ4OjqeMA9OYtnMboZaNYgDro=;
	h=From:Subject:Date:Message-ID;
	b=wP5SLTShnfLzyYrL3bhywvOoJ9Bk45fxZWQvn352CjYcepUboOwyyuKvuIUsweyxx
	 HvOhSYWiA+YvjmMgXEfnApAkW5WjeGQAgsaHxuMfw3jx2Nv7MtOX8bXZTlGJEBU5KW
	 ZYjbq/lLmu+MjqyJsCmMAPcjdMkFgcRIx2UUzlDQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B007800000189F; Thu, 28 Aug 2025 15:38:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7216306685243
X-SMAIL-UIID: 609EFD9129CC4AC88E4D68610F2FDCE6-20250828-153841-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in copy_process
Date: Thu, 28 Aug 2025 15:38:31 +0800
Message-ID: <20250828073832.5955-1-hdanton@sina.com>
In-Reply-To: <68af9193.a00a0220.2929dc.0006.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 27 Aug 2025 16:15:31 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1036def0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13595c62580000

#syz test

--- x/mm/oom_kill.c
+++ y/mm/oom_kill.c
@@ -997,6 +997,8 @@ static void __oom_kill_process(struct ta
 		queue_oom_reaper(victim);
 
 	mmdrop(mm);
+	write_lock_irq(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
 	put_task_struct(victim);
 }
 
@@ -1031,6 +1033,8 @@ static void oom_kill_process(struct oom_
 		mark_oom_victim(victim);
 		queue_oom_reaper(victim);
 		task_unlock(victim);
+		write_lock_irq(&tasklist_lock);
+		write_unlock_irq(&tasklist_lock);
 		put_task_struct(victim);
 		return;
 	}
--

