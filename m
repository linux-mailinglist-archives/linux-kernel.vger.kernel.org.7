Return-Path: <linux-kernel+bounces-875174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CDC1862E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 627BA4E030D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B2260587;
	Wed, 29 Oct 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PdGLUKNs"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8E1F4606
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718212; cv=none; b=auaI4Fda/S3Y7vDBXYvcBfEv2EQHJ1FGLRHAmUI8MZMkS+ogknkUTHPy5UJs38UujT7CFhLiAz80FchGEI8dOzybN5IJee/WHL+e6PCsWAt11mAJTMG0FF/fGg0yG1ROBS7IXPEBGCvySGPJKWlqzm7Bv/y37nTtawa1BD68zCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718212; c=relaxed/simple;
	bh=Ngpp/8zqk6wsUmyWsqLDW5fqczuYCzv6VpOD7jIY1VU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NE8iLIIXmqJIsg2KWL8ubnzLtc3oFd3GjRGIMkugjW4VA1EHuCWNxueoFE2vALPBbd96fohDEg0Ubsckh08V6pD4NbB3fSsdANe7yP2gJIFg79AqEXgBu4aUQDcopLUgRSEFgYSUV0n7ntRyLBS1vrBg3gPNL4HrASxtSYPUNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PdGLUKNs; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761718203; bh=6c8StLamAGsCUDoOBRH7WQVE6j2s07lODsxk15SlgYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PdGLUKNsPHBNrov73l00XB8ZrihXw2RD3HbSsoR9jDPLzfuds4IhvkYLhmb6dF99m
	 eA6eRsqcfzYtQWq9z/kKkruZzu+/SLrjdsPALvfuAu69oqhtcHymO1cW9FZGW5Yl6s
	 VJfMAOBG01LG9rOL4zmVc2/b/2jby78xc33NsTa4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id F816820; Wed, 29 Oct 2025 14:03:56 +0800
X-QQ-mid: xmsmtpt1761717836t9qfhq75p
Message-ID: <tencent_BEE7F906E552D68657C9B7EECC6ED7CC9206@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahnOTSVw3pb/XvCB73hmNxwHgUbc7eK/8IfLBC9TxesWiaUpWaKK
	 MwIunf00sbB9//PLtnlzCBMDE7Y90wNUXn/jGaPlCBvN4ik2+B13HvHErb6mQaHsBSLs+Cu4XMPL
	 72fo9iYxxEAReHVDa9yOwNbNUE5qpA1N89UZSgHYmcC1yXhLTAY7BAIeT84tBRQ29SW+PZzzFEMU
	 Mv7nJ0Fc4B6l+AxRSfTtdQpsCpXVPb+Yg+nypj8glaGZw2m6pE4/ZbFWYUnuEpwLC+YsKY5Yo7t8
	 IqS8vmOkMrEefhDPk0qGzffwXt1C01/qcO++VX70Ed4iFAbjAk53NU5K8pZjVIc27j8bj1ejWB+S
	 gOUdCpyLlLiqDzzhVhUHfHSVEamzVoveMecoAnFA+Bo4nYWsRCpaHQPZ5m56VEywNOPY4eUu16SE
	 6BgDaQKLK8Mb85S/vKFplcIY0dALuuTAi7JWE9J+yvoGt1sKNKf6yTzjcgSZLrYcslqaeQizr/bJ
	 mx7xCB3/+4aCcp1IhYu9lOe+YGFWt7xd/Hd5YH1hEDlcvhAXbE577+hZvdizUNZb+eXjtWw2s/RI
	 qTZo3NSTdphZOoZFP+3iaw+1BSbJnv50f3bmwXRVzqfkO28QyCDD6VwZ80iLg9p+F82PEdTpi2ye
	 xlwFCTFWapLrxFTgKC8H4JI+ikNhLF0JqgVWJtHrOM6aG5mMrFQ7leRIFnwQfdqCSJhQlAd3Hjrz
	 mJJILSdVojia3wecOo4NKyq+Stm57OQ9dmJM96cc13yAa+K4s7xUII89xg5isb8oq2yRiDhlLPH6
	 t+B8vdukj0g5O8s8aMwyIfG9FXsYqnxgkugUvDjNVRPtNVUh8W7RIKvd++R9S+SGhCY1xg2nnTMQ
	 8j+PtEgiuhYOHbTw2bkHyYArI+uuT234cfzEwZGZIJIXdXRYX3A8JwZ76ZneOFsUT1bSNg4ONxAn
	 6tK3Yu1fVJiMd4Q51meQeEHoFFHiKcqiYxaOmBqSQCg6BDLHTQK+8QywH+Q0RwbzKHFZr2L7rDv+
	 YYBVZbdddmscABYPhG
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] ntfs3: Remove redundant nls free
Date: Wed, 29 Oct 2025 14:03:57 +0800
X-OQ-MSGID: <20251029060356.3366094-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <69015bf1.050a0220.3344a1.03f7.GAE@google.com>
References: <69015bf1.050a0220.3344a1.03f7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using unload_nls() is sufficient for nls.

syzbot reported:
WARNING: mm/slub.c:6752 at free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6752, CPU#1: syz-executor/5939
Call Trace:
 ntfs_put_super+0x15b/0x1b0 fs/ntfs3/super.c:708
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1847

Reported-by: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cc433e4cd6d54736bf80
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index aae1f32f4dab..02b03d810dcf 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -705,7 +705,6 @@ static void ntfs_put_super(struct super_block *sb)
 
 	if (sbi->options) {
 		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls);
 		kfree(sbi->options);
 		sbi->options = NULL;
 	}
-- 
2.43.0


