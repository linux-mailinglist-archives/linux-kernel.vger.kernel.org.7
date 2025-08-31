Return-Path: <linux-kernel+bounces-793272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F55B3D16F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202937AC4D6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9232459D1;
	Sun, 31 Aug 2025 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="C6SwVADr"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CC243954
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629860; cv=none; b=nQp88r9ohpZAXF4D8LvjDzoTR56g9yUTQk3PnyTk0/a5wjRh5wtycC4Zx2WycpawykKZKqMxR8q9EXodkmOo2NUyCQgQkdJ0V1xgGcvzkUrIbXGAEThwa3jkqWZrmKtXHI2lpHcc8vzSo4Pc5hmP5uNsRO5ELksAyrOoWsqv2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629860; c=relaxed/simple;
	bh=uIMTQPlnrOmQ3LNumYieghpXG+WssnNAMvKzHkBq8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxxDVcKwBauAzkFQNGkwcB4dro+RviuMFDAQnZJIr1GA27wrMtnJjXHPCUkhLrEgkrEDM4kTsqCarFFDkEi8dYCUpGPVCcHPnr6lMj9VQElaqdqBKlegKIOboOjVfHq7jZV96gizkN0BFY+LLvxuM3tFl/E17llbD/Tt6WH+jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=C6SwVADr; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756629854;
	bh=h7d2eDFVi5AyQ0uQVwyiYIcSQJIITQHnUS/t0m1nwBs=;
	h=From:Subject:Date:Message-ID;
	b=C6SwVADrwqVjjcyNxvLYAvjzOJ4S/DGaRscPA/oiWeyYU6QApm0r7Fd0zpPrAkMml
	 nemCR9aKFqnpSAA62wgsZcsSH/4mM50BAu/koovOR/zDIDuZTCIgh83Zr6xZ/HECfJ
	 qI3CMtkdQsKClUmdhitLovNQtBSUq8ORDhQJEfVg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68B40AC400006C47; Sun, 31 Aug 2025 16:41:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7912796292129
X-SMAIL-UIID: 95630B2A607646EC8ED25A41F15EA250-20250831-164141-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
Date: Sun, 31 Aug 2025 16:41:29 +0800
Message-ID: <20250831084130.6242-1-hdanton@sina.com>
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

--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -59,9 +59,9 @@ static int vhost_task_fn(void *data)
 	 */
 	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
-		vtsk->handle_sigkill(vtsk->data);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
+	vtsk->handle_sigkill(vtsk->data);
 	complete(&vtsk->exited);
 
 	do_exit(0);
--

