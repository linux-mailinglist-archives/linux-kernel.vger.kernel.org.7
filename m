Return-Path: <linux-kernel+bounces-793242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC70B3D100
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEEA440A80
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539981C1F05;
	Sun, 31 Aug 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="r0jntuYR"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668A168BD
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756619673; cv=none; b=NimH7uZjhFCeywLlqeubCB4B+0CuLgWBLY4eASAiAE+6VXJtfcS3Y953aRWshuILhADzwlziNuHdXCZjhBAjMyg8hBuOxXJX6btTm3h1y8ZO/SrWQZGdja4SLMI58rEb6fLNnrAU9dW18N5Evwof2L0dEYgsTfG4QfnqGKjCPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756619673; c=relaxed/simple;
	bh=1gKGU80sVeH2ymc3lkeDcPWdrj5ARQCinAUBXIHq+ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lziosdib61wI2D8A3FuXKb4aOuMnXhiYT2Tq8GeMyv5XTL2PSFclR7oG2C0t8Qnc7u5uzO9fth6mYpOCWyPg9LsiSA4ZLjzPgLV/CuFb5cAf5x6NXhEGzmYcWz4mz8dpgNt+8SBR5rQ2asgJ4O9KIRdVHT8GNY9neRyTwiO6SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=r0jntuYR; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756619663;
	bh=1Go6r1pPVA1kb1vlFEdGxvvy7m6v9fkC3gXKtCoVb+s=;
	h=From:Subject:Date:Message-ID;
	b=r0jntuYRznupXn39e26FaLHvf0Rhd00Fhe5m2VLiXQEVYuLuz2E/gcvrAw2D8IOm0
	 3C0rD0P68I9KcpLym9E7qNtEEEWI98hZt7wSj2cbBb1BhrQ5G6BM7FTrGAW+G6Ev56
	 i3ZQoaeq5hOoFsz3zyLrYGJrVEUefgZyv106MghM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68B3E382000039D6; Sun, 31 Aug 2025 13:54:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3302026291844
X-SMAIL-UIID: 589DCAB089894068B9FDBEC06AE3E9A7-20250831-135413-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
Date: Sun, 31 Aug 2025 13:53:59 +0800
Message-ID: <20250831055402.6159-1-hdanton@sina.com>
In-Reply-To: <68b3b1ac.a70a0220.1c57d1.028b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 30 Aug 2025 19:21:32 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    11e7861d680c Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c5c242580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1671ba62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1685aa62580000

#syz test

--- x/kernel/vhost_task.c
+++ y/kernel/vhost_task.c
@@ -34,8 +34,10 @@ static int vhost_task_fn(void *data)
 		if (signal_pending(current)) {
 			struct ksignal ksig;
 
-			if (get_signal(&ksig))
+			if (get_signal(&ksig)) {
+				vtsk->fn(vtsk->data);
 				break;
+			}
 		}
 
 		/* mb paired w/ vhost_task_stop */
--

