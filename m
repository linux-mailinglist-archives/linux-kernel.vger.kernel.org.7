Return-Path: <linux-kernel+bounces-760921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3BB1F1FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F69958234D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEBE223710;
	Sat,  9 Aug 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Z/VuOy91"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FE126BFA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754708024; cv=none; b=OOTFV9WhLH3ubTj7yrhsLhCVn80/uEGPrsJNEcMNg5/SjhbiEtbDX5hbvgbrl2HiZFoz465nJs6wU2mVey1Rhr8eOTxheIDuYPa/8p7B2PsRjHNLll5vUs9ZOPtLBRGBbGKBpbzfJ1aQIwSjaksKHFnD4GBzNZIdszYLq8BKk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754708024; c=relaxed/simple;
	bh=rshu1EznhtWCQ3f262wqHAvjArFZVH/xgOZiidDze+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgJ6yw+X9bSTZ7Y1VmKr5a0A/6V00R+UcX5fJNoVWirzGDRSPUYigyXskjVGQRgC18I0W6E90f6Cg0soP9WDgbuhHCNxbTcm/Ted3m2/vDrfaNO3kUoDLpqnpheWmJR5QC/ers4/edl7Bgt4/PghoLJQQ0pkj92pVgWqBlgLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Z/VuOy91; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754708019;
	bh=rvsKC8gpfHRa9+JDANyj7H168oO0fQoMpmQCu1RBaf0=;
	h=From:Subject:Date:Message-ID;
	b=Z/VuOy91H/cIEzGmw4qxfG1Fo66lccN3Sodn/mfWgBefk1PFG4NRGPnP6cfZktdIr
	 5zSOYNhJx5wEuh4VVEk5z000+5TT/e1KHv/HehALjNYjeXaffoIEECYtEUhg+qWriG
	 syexnsdvGSKfUl6oZUwwwHg9xtFSWgNihRp+uYQk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6896B82600007516; Sat, 9 Aug 2025 10:53:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6750976291944
X-SMAIL-UIID: 78276F9A5FD548E2B94EDE40A56E4657-20250809-105328-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
Date: Sat,  9 Aug 2025 10:53:15 +0800
Message-ID: <20250809025317.4045-1-hdanton@sina.com>
In-Reply-To: <6895de6e.050a0220.7f033.005d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 08 Aug 2025 04:24:30 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7abc678e3084 Merge tag 'pmdomain-v6.16-rc2' of git://git.k..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b0a4f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12b5044868deb866
> dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a20f22580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af2f22580000

#syz test upstream master

--- x/net/kcm/kcmsock.c
+++ y/net/kcm/kcmsock.c
@@ -717,6 +717,8 @@ static void kcm_tx_work(struct work_stru
 
 	lock_sock(sk);
 
+	if (kcm->tx_stopped)
+		goto out;
 	/* Primarily for SOCK_DGRAM sockets, also handle asynchronous tx
 	 * aborts
 	 */
--

