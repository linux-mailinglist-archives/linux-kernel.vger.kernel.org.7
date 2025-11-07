Return-Path: <linux-kernel+bounces-889592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58BC3DFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074A23A3B01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D012DA76F;
	Fri,  7 Nov 2025 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ufTml4WA"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8629299944
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475739; cv=none; b=ATz6F5qfqIvD8Ji7U8kmRkvkM0rTHUQqp1Rkl8dhJw6fRZGIHfp9mGRz3EoLfPVdY5rKYuOSfpfCRxfkJa+tUT4uhLlFxhN5N4uJKLMAdW/qx7aVU/s/dPeQroiojoWidSUAVTk7sp5W8k/4PSGqOkkti3e0gGivmNegNpg2oGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475739; c=relaxed/simple;
	bh=zwUfV7lqbo2CaFVr8AM+cWLA7dHtK3BlSmekr+U9Bfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpEWhjKhQCDONDGmDFf3qYOcQyf7mYjNxMYqTpBXdSJpwuDOoRQfXEXmltE9H0AcQXWCv9vp5XEAb8tHmKckfBIfCnYA3pow3r5F5WkIo9ONNn6SADzpNFsq7qfPenbRMi3FZZPuVwafkyMQ5xhxua+eS6OXSoNbZyhIgTK5Ms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ufTml4WA; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762475734;
	bh=34vIBNK9nQ5tMEq/sdQZ+aezaD1zsAOClxUHn47StHo=;
	h=From:Subject:Date:Message-ID;
	b=ufTml4WAXGd7vGbACynGNprPfPcVoR4DTZ//BzTzF9T+6XuvYXJIFWwJUTawHx4ne
	 YwR8V3a88763HYwee0hfiVmKanGDEGBt5m3JaDfxlsOMJKSqCSL+dpgZAlHcDmOh/T
	 q1+MLAGb9s0xNd83M5dbDGbKvXTmvUOKTRHguoq0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.250])
	by sina.com (10.54.253.34) with ESMTP
	id 690D3ED0000034AE; Fri, 7 Nov 2025 08:35:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5643576292042
X-SMAIL-UIID: 2B3510977F9446C5A763CB96187788FA-20251107-083530-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ba535cb417f106327741@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sctp?] BUG: corrupted list in sctp_destroy_sock
Date: Fri,  7 Nov 2025 08:35:16 +0800
Message-ID: <20251107003518.8936-1-hdanton@sina.com>
In-Reply-To: <690d2185.a70a0220.22f260.000e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 06 Nov 2025 14:30:29 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1a2352ad82b5 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1110fe7c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=810aeb811fb1cca1
> dashboard link: https://syzkaller.appspot.com/bug?extid=ba535cb417f106327741
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ff9704580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11372bcd980000

#syz test net-next main

--- x/net/sctp/socket.c
+++ y/net/sctp/socket.c
@@ -4895,6 +4895,7 @@ static struct sock *sctp_clone_sock(stru
 	sk_sockets_allocated_inc(newsk);
 	sock_prot_inuse_add(sock_net(sk), newsk->sk_prot, 1);
 
+	newsp->do_auto_asconf = 0;
 	err = sctp_sock_migrate(sk, newsk, asoc, type);
 	if (err)
 		goto out_release;
--

