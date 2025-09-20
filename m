Return-Path: <linux-kernel+bounces-825604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA95B8C4F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569E656060E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBAB288C25;
	Sat, 20 Sep 2025 09:43:16 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46F25F79A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361395; cv=none; b=L56mEe5eiMWnuNq8ENCbu5Ug8EdwUdZFLDcbEJVREEbOI3fi2uRgk2o+MlXAyS+xUihW4tGyQ38XOkGoRPr+IIWbWooa2GyEt5PRhFkN0oDeeXkzMBAkZtvgcz2uRtaGWK1Swfp2436ma86MUL2blex3YpRX8PGnFnrfcs7h4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361395; c=relaxed/simple;
	bh=QXKBZxBbIIrY7dUNDCSovURrM6TC+8t9ufoJYA27PI8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e0lu9GILCjaXPcKR3PtslC49NtSW+7OG8ccCx/M9W0rkhy8UdhvkBdtLsGxJ81mDJKgZMncnLIU6WXFFHf4EmRCFu+lr1I67htRR9YYuuOKlL6ll+fu/tiwD0usFVEuq8eHt/Z0TWVgr01nKEPETQK7KuvsVF+GK65wfi/Z6Z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58K9gk0K057448;
	Sat, 20 Sep 2025 18:42:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58K9gktk057445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Sep 2025 18:42:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d79cb8dd-7dc3-49da-8fb1-793fa7e2a7e0@I-love.SAKURA.ne.jp>
Date: Sat, 20 Sep 2025 18:42:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 ntfs_set_size
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        Edward Adam Davis <eadavis@qq.com>
Cc: syzbot <syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
 <bcd184f1-acbc-46c7-9e30-045a8f17fc5c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <bcd184f1-acbc-46c7-9e30-045a8f17fc5c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/16 12:48, Tetsuo Handa wrote:
> Well, we need to also initialize ni->file.run_lock, for vfs_truncate() now
> passes the
> 
> 	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
> 	if (S_ISDIR(inode->i_mode))
> 		return -EISDIR;
> 	if (!S_ISREG(inode->i_mode))
> 		return -EINVAL;
> 
> check. But do we really want to pretend as if S_IFREG ?
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 37cbbee7fa58..ea2193ebf8fc 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -471,6 +471,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>                    fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
>                 /* Records in $Extend are not a files or general directories. */
>                 inode->i_op = &ntfs_file_inode_operations;
> +               mode = S_IFREG;
> +               init_rwsem(&ni->file.run_lock);
>         } else {
>                 err = -EINVAL;
>                 goto out;
> 
> Are records in $Extend expected to be truncated to arbitrary size? Should we
> prepend something other than S_IFREG (at least S_IFREG so that truncate()

pretend something other than S_IFREG (at least S_IFDIR so that truncate()

> will fail, or possibly S_IFSOCK so that open() will fail) ?



Well, ntfs_extend_init() verifies that the inode returned as the result of
looking up MFT_REC_EXTEND is S_IFDIR.

	ref.low = cpu_to_le32(MFT_REC_EXTEND);
	ref.high = 0;
	ref.seq = cpu_to_le16(MFT_REC_EXTEND);
	inode = ntfs_iget5(sb, &ref, &NAME_EXTEND);
	if (IS_ERR(inode)) {
		err = PTR_ERR(inode);
		ntfs_err(sb, "Failed to load $Extend (%d).", err);
		inode = NULL;
		goto out;
	}

	/* If ntfs_iget5() reads from disk it never returns bad inode. */
	if (!S_ISDIR(inode->i_mode)) {
		err = -EINVAL;
		goto out;
	}

Then, should ntfs_read_mft() pretend as if S_IFDIR ? Also, are conditions

	} else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
		   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
		/* Records in $Extend are not a files or general directories. */
		inode->i_op = &ntfs_file_inode_operations;

correct? These conditions do not check ref.high == 0 and name is "$Extend".
Don't we need to verify ref.high and name here?


