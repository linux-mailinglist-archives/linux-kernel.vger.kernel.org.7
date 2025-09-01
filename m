Return-Path: <linux-kernel+bounces-793932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45909B3DA66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AE63AD50F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98558257845;
	Mon,  1 Sep 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KovP2iGq"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2351E9B3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709863; cv=none; b=naG+IglBe3LsPj3vZEuWTPljupJgxD3MDfgPtIKv+YbR8U0BRJ/7VW+xH72MS7IL0MKGNehq226cvVU36CnunB9nofnb0g5dGdRJelwIj6ng8y1Wk31WhUFUPEwA//PwYOSwx0bFfpBGHiH5NQ07D+03c3PjE8pN+MELnsTrZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709863; c=relaxed/simple;
	bh=Fub1UP+n8NmRNScoI5qW04yCBWTUD5j5Dg7nDWvwPd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utp+DpdJdX32xegpWNOkJOLlDDsiGnWabkVU6d9whC+fD94G7NOUr8SYHuRBACTd2IWQ9leOOYPPLosF4toilmBQKV7MCFlRqKy64sw/E9Cr2T67iH3G5guE1X4f/ZE5W32ZKz06/9t0cbxHN7Itozd/ds6rGW3oZHJMMZth+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KovP2iGq; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756709858;
	bh=k1SQLLjHxbi67NqmhR5akSxouIODcWy1++inNt4SAlY=;
	h=From:Subject:Date:Message-ID;
	b=KovP2iGqTTQ3QkdYGMir4tKNyRRwIp7hzS0iSOqrF7KpC8LEa73aeOuZPoRqhrcxX
	 gC79knk1HCYN1lr1imIYfPm1rWdOdqs6ZLcy8JUde8WOM6GdPcTdaoIQC9uXK/0e7p
	 Jzsfb44ARniTcfkI93X6m8E3vf4lg/mQM49IAXKc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68B543DD00006983; Mon, 1 Sep 2025 14:57:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3181326291978
X-SMAIL-UIID: BB4FEAE35CDF403283C31FC5FC93B100-20250901-145735-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
Date: Mon,  1 Sep 2025 14:57:20 +0800
Message-ID: <20250901065724.6315-1-hdanton@sina.com>
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

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3652117f8548

