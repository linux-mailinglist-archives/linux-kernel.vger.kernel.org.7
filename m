Return-Path: <linux-kernel+bounces-823914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9EB87B71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA117C0A21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2A274B35;
	Fri, 19 Sep 2025 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hKmFhFJG"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5692737EB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248356; cv=none; b=XOWmoNBzE0mAKSjRFImQgqLBQ/l3a5niOl3xHWoTETTG8XELkFcPqR8BT8/n9ezBzxQTubPiY8z/0T1EbhRGMJPOCUmEsiSM2ayUhBEtG2u/BrO5CUzt7Rx2dPRUwEFXw3n43k5xrO48eS7p7Q/ywVjinEskL+7TXopPxlbbbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248356; c=relaxed/simple;
	bh=sFRzPeEUbfwXjETO8DhUwHf2ewNSCrg5fO2NPPdHa8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhhSq4qwgiJkvZ9iSw5cnABaNiKczf0k9MPpC4UYgqAXS+Jt1KpxG7hlHYUy2AAKmmQnt3XfPcXlkZT+BXEjaRk13Vz+SbVrjSZgck67J3u/wPHA0UqDeC9CwvizJ8NMfpGfbx0jeHA17pawcBMmRKiOpSrFbuKXINKGI3DrV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hKmFhFJG; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758248350;
	bh=Y803CjAYkloWrgedTw2DDjDhJYKKMtqAYtox1HE3UrY=;
	h=From:Subject:Date:Message-ID;
	b=hKmFhFJGSauBJZrcWOCTBqa/QC2ONZqZmxGGAwhAjCeMxVai3c/nHO/Smr1YZ2mda
	 rDQa0NT8f+8LWzxGpeXiIj1uzijhuVchmQT9E6GIznAH6yhswTC6XgkXU/W2q+qBW8
	 HDR8UHvtD4ewns7jexT2d0B2o6e/yd4jw6HdU9FI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68CCBD93000043EF; Fri, 19 Sep 2025 10:19:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2983136292027
X-SMAIL-UIID: 4CEB83AB8242444B9C7B570082D513D3-20250919-101901-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Date: Fri, 19 Sep 2025 10:18:50 +0800
Message-ID: <20250919021852.7157-1-hdanton@sina.com>
In-Reply-To: <68cca807.050a0220.28a605.0013.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 18 Sep 2025 17:47:03 -0700	[thread overview]
> syzbot has bisected this issue to:
> 
> commit aaec5a95d59615523db03dd53c2052f0a87beea7
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Thu Jan 2 14:07:15 2025 +0000
> 
>     pipe_read: don't wake up the writer if the pipe is still full
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175fa534580000
> start commit:   46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dfa534580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10dfa534580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17692f62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361f47c580000

Test Oleg's fix.

#syz test upstream  master

--- x/net/9p/trans_fd.c
+++ y/net/9p/trans_fd.c
@@ -666,7 +666,6 @@ static void p9_poll_mux(struct p9_conn *
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
@@ -686,14 +685,7 @@ static int p9_fd_request(struct p9_clien
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
 
-	if (test_and_clear_bit(Wpending, &m->wsched))
-		n = EPOLLOUT;
-	else
-		n = p9_fd_poll(m->client, NULL, NULL);
-
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
-		schedule_work(&m->wq);
-
+	p9_poll_mux(m);
 	return 0;
 }
 
--

