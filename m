Return-Path: <linux-kernel+bounces-818087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F0B58C79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9351BC475B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC061E633C;
	Tue, 16 Sep 2025 03:48:47 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B83D81
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994527; cv=none; b=mg6NBXoqo9Pww1er3DKmWyZNggeOspqHNMNP0MBeR+m9LIAyMVJ4eT1nos+h6fyLNx9scg50lE0bmDy8dR6YpN/YbzrVtW3Zlmm8PqCxxPS4qZ5no9484ShKC+OiuSicjeFCEh5czvSVv5z8t9qmVCQMsN9VfgaMdIIS/9dlfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994527; c=relaxed/simple;
	bh=g0I8tdNJy31FA1lpkShNGzfuDpdWLTjA+UmF81CHzt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YUKRtHV84XofasN+ERWXHduJ90Xrg0FKk3c8N8LADH1O+HHhSDXZH09DyVBwsblDn65QufBYzv1VX1y862kNGGdUUD0Ym5Z9Mfsx53eQoyQWCL6SfMWX+it1ITLCmeCtYdAa2dDDg5vRyHcF2LM1anFWs1TrY6kOwqYjE0S6HOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58G3mP68038991;
	Tue, 16 Sep 2025 12:48:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58G3mPG6038986
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 16 Sep 2025 12:48:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bcd184f1-acbc-46c7-9e30-045a8f17fc5c@I-love.SAKURA.ne.jp>
Date: Tue, 16 Sep 2025 12:48:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 ntfs_set_size
To: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev
References: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

Well, we need to also initialize ni->file.run_lock, for vfs_truncate() now
passes the

	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
	if (S_ISDIR(inode->i_mode))
		return -EISDIR;
	if (!S_ISREG(inode->i_mode))
		return -EINVAL;

check. But do we really want to pretend as if S_IFREG ?

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..ea2193ebf8fc 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -471,6 +471,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
                   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
                /* Records in $Extend are not a files or general directories. */
                inode->i_op = &ntfs_file_inode_operations;
+               mode = S_IFREG;
+               init_rwsem(&ni->file.run_lock);
        } else {
                err = -EINVAL;
                goto out;

Are records in $Extend expected to be truncated to arbitrary size? Should we
prepend something other than S_IFREG (at least S_IFREG so that truncate()
will fail, or possibly S_IFSOCK so that open() will fail) ?

On 2025/09/16 3:17, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1379b934580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
> dashboard link: https://syzkaller.appspot.com/bug?extid=bdeb22a4b9a09ab9aa45
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144aa762580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c8762580000

