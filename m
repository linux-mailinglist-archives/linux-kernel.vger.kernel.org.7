Return-Path: <linux-kernel+bounces-720716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6399BAFBF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AAB173756
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C331DBB2E;
	Tue,  8 Jul 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0I08XUG4"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D281ACA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936396; cv=none; b=mQxaM4jidoVi9AfhU+RzU8fSxcOsglC94n/i6HtqTH9KqDuISiarzEfzgLGtIXqhcOWli5fWXpam9nTm4SfCW/snCyYONyd2wvYTXCcTr58a0kmqMZdW/6bL4GiKDd3VyRhp/rT6uNNmfnvBs9Jf+s/xgGUFrwXQVpL3Nrs5/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936396; c=relaxed/simple;
	bh=bJWdH9gxeG/byqjB241KwUfed22zlhN9HeqJUzblv2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBQ8u7/C3fMGQDjoPv4MuFSqND94FHpR0qWlVBEIwcCThj/EOOenrH1ILdt5FDV1iTicgFSydM+8vuaUz9zBGHOsD96vQhs8talZg5Nb4BrpD5kIiD0RTkM2xV2eZbAJslp0PfMsLx4lY+1glZ8lyx97nV19BjAcXq6lJv4ZYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0I08XUG4; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751936390;
	bh=TAxl3qt/+THsmGheBOTvDAcCaj89BV92E3P5dRrHewo=;
	h=From:Subject:Date:Message-ID;
	b=0I08XUG4ULNBh7cByDnc+eFGum7wFxIyJvSQkApOrspagEC3AqJpTkPM+OoJJBoY2
	 VJ1DhWF2w09nziHqkhpJOPsorO/rAKLTyjJSgopIpXoji40sOzuLz9B8qvy9SBc/tN
	 v0eC5jZ7gAfAucIpdiHyu70ZC6HJBNawbu0PP1Is=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 686C6D7C000057D8; Tue, 8 Jul 2025 08:59:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9178284456975
X-SMAIL-UIID: 7DC7C4062E8947D2AD82C76B66ADD331-20250708-085941-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in l2cap_sock_resume_cb (4)
Date: Tue,  8 Jul 2025 08:59:29 +0800
Message-ID: <20250708005930.2818-1-hdanton@sina.com>
In-Reply-To: <686c12bd.a70a0220.29fe6c.0b13.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 07 Jul 2025 11:32:29 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1597828c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=e2df3a66f7d16fa6ec55
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c4cbd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d11f70580000

#syz test

--- x/net/bluetooth/l2cap_sock.c
+++ y/net/bluetooth/l2cap_sock.c
@@ -1703,6 +1703,9 @@ static void l2cap_sock_resume_cb(struct
 {
 	struct sock *sk = chan->data;
 
+	/* sock dead? */
+	if (!sk)
+		return;
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
--

