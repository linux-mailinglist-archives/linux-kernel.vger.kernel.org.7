Return-Path: <linux-kernel+bounces-760930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B0B1F219
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573DA7B644E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BB274B42;
	Sat,  9 Aug 2025 04:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="AnGwo0L7"
Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35561AF0A4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754714250; cv=none; b=OK56gzSnCK2N+PO7hvCfKFbl+dwx9oRSoNXzerdaswP639k1lCDhamwBPg90O7k9zWenJTd3C9qwJEY94+XPUG1pTZUtzIk7Q6kT8sYmjVufCdD/N5H/vPMKVGBnKPKEHgnpTRFvBP+uvh2yzP9CjBDKAe+10t5m/tOk5mKl0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754714250; c=relaxed/simple;
	bh=WkhxfAOQkG5MJJGvLE6rgTEHSF5rujoEESvhB3AUL8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxp0cJnGiBhERWBJGtYLkamAkpSttkj+irPyzfHvYLyp7Xca9a4Y7/ssCw0EU/CHSDcHLDyjNT3ZTa5A6TGPaAFpiVvLBwEutG1msM9+FPrmHDEiWlzRdO8W6Z0LqDiB5upWUDX5qC5A7xZ8CPTCVhscs2F1UyHt2G27rMPF8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=AnGwo0L7; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754714240;
	bh=fHYr6wuj+No69YSyVQZGcqc4NlvSpj8920mUQ1xahWI=;
	h=From:Subject:Date:Message-ID;
	b=AnGwo0L7HCr22JiqYGMdXfD4BGldADzs6gUC5SgfNpULzOUENuvBBu7EonQcntfbi
	 /QxUrg+EVs6FKiCUe0/f/w6MBrBTqOLTsulNSbyiTgkK4FgC4s1A1nHJgL/XYh5HEC
	 F/hCiUdiYHmXVhL6kU3sN2kanpYKN7QOTKRhUmp0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6896D074000077B0; Sat, 9 Aug 2025 12:37:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2808156685206
X-SMAIL-UIID: 8CE9C169CD6B40ECB9C251DAB08E642A-20250809-123710-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
Date: Sat,  9 Aug 2025 12:36:57 +0800
Message-ID: <20250809043659.4068-1-hdanton@sina.com>
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
@@ -1733,6 +1735,7 @@ static int kcm_release(struct socket *so
 
 	sock->sk = NULL;
 
+	flush_work(&kcm->tx_work);
 	kcm_done(kcm);
 
 	return 0;
--

