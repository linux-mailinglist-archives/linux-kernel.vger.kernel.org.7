Return-Path: <linux-kernel+bounces-771724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF87B28AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA66AC760B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E41EF39E;
	Sat, 16 Aug 2025 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YfbVTCqc"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF11E411C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322957; cv=none; b=YmOXodJJop1/EcldtzfvYYo0+Tw57KVz0fqq8ZabDNJC+/rTcqjlGtNUcWwDss1MYqRI+Tq+rMgIzO9opPvrlyDYHdvy5z7O9I4J1BhJGk/SeYLjtgbAETr61PYec0uMz4PvwMTGHWb0uGmrTFO375jiaKDasYPHPE5mqSjRQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322957; c=relaxed/simple;
	bh=vtRXaDiFjUuwijTg2k4vk9wZLPZ5iUPoSx/pnYp+Prs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd4gJQBtg8DRKCxDDZBOKuesMtcNXLDDKUEyBhK3C7ACUH+PmjOaz1moF1/M/QnI6JmnJRLbc8vWYghqSt0jc08rgYbypx9qnjQgXImX0CiOh6gAnkYcZgtzTwI14OzffSRUDVLJ9ufKQ2fu8BFHpN3OnklXo6YJKbQeGoiphfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YfbVTCqc; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755322949;
	bh=u+RmHhETebtg+0YvP1h1z6m3p8fzYq0/W06NqADpL7E=;
	h=From:Subject:Date:Message-ID;
	b=YfbVTCqcgEQ0zCPAFdibNxXdHl9n3ThEogAF/XFwx4aR/3WA9kaiP0fvJkndFxflO
	 fkbGdZublZwxFvQfSwZ9vkfvFUZF0qKo4+Nbk3enNlaGNZOLr394uZwLM34YqTx3PS
	 2xwUnzKYyNB3wO9N9QDCivLUUCy3v53HD0FZxk4o=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68A01A3A0000677C; Sat, 16 Aug 2025 13:42:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6151066816310
X-SMAIL-UIID: 41A4EB2ECAB246D2BB9302B65F22721B-20250816-134220-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
Date: Sat, 16 Aug 2025 13:42:07 +0800
Message-ID: <20250816054208.4763-1-hdanton@sina.com>
In-Reply-To: <689ff631.050a0220.e29e5.0033.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 15 Aug 2025 20:08:33 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0cc53520e68b Merge tag 'probes-fixes-v6.17-rc1' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a003a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387bc34580000

#syz test

--- x/fs/overlayfs/super.c
+++ y/fs/overlayfs/super.c
@@ -695,7 +695,7 @@ static int ovl_make_workdir(struct super
 	tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
 	ofs->tmpfile = !IS_ERR(tmpfile);
 	if (ofs->tmpfile)
-		fput(tmpfile);
+		;
 	else
 		pr_warn("upper fs does not support tmpfile.\n");
 
@@ -790,6 +790,8 @@ static int ovl_make_workdir(struct super
 	}
 out:
 	mnt_drop_write(mnt);
+	if (ofs->tmpfile)
+		fput(tmpfile);
 	return err;
 }
 
--

