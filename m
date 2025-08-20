Return-Path: <linux-kernel+bounces-776985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483DAB2D3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B05627DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB574273D9A;
	Wed, 20 Aug 2025 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ETSyGPIX"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7B21CA0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669035; cv=none; b=VpGj5ZJC3ZGU8Ap+5IDSnFH6fqKMpEglsg1gTu5GhRt90V4FZLdg97oKR8yWjapb06evJtrevTKzORLVX7jULLIRqZno4cAwSbhSg3xbV/wj0b/eYuV2RPJmhGTuYD4RLAzsKeYAKCt+V7JQkCkqLa6HwxLTEZbq/8+r6t/MXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669035; c=relaxed/simple;
	bh=tUi2Hk74JbT2NPZDSyLVr/bpFU5smG5I3zgVr5wntjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IY2AoXr1rNZZ6DtQfXescAZPsjmexp7TOxnii3AgdFC5F6NLDARibxPw5RUZ2LXU/aKkO2LwlACeLID7tOBJLy16zIQzwqeOMGXxXJXSCQOjTbGtkv0cMRbd8C74r8wDKRyrSFig9brNu/EOctnGWqFE3nEfYRgY7pRLbfsl2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ETSyGPIX; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755669023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2nUIvCe3BL/RCqTjkt6a5hcMmtvPa2e8DeB7m/+h0HQ=;
	b=ETSyGPIX2l7sntI30RW50KhlrK9N5Q0rGbLrRCLEgMhsH0xrE6Wx6Z3fHXmKSwRqrLfTKvsSj3qv9gdFY0gPH+GRXmU5wdKmC6oBhuCburET5Z2cg1xq9lUQnHxQQPDEBiTrJigEuKadwjDKve9pERDEcXXUqHKjozlN9E2N+dc=
Received: from 30.221.144.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WmAOjH8_1755669022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 13:50:23 +0800
Message-ID: <c72cede4-34de-4e53-8ede-ff57b8f2f4f3@linux.alibaba.com>
Date: Wed, 20 Aug 2025 13:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ocfs2: prevent release journal inode after journal
 shutdown
To: Edward Adam Davis <eadavis@qq.com>, akpm <akpm@linux-foundation.org>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <tencent_5E787A6C242FE96CC89454E856EC52CEC40A@qq.com>
 <tencent_357489BEAEE4AED74CBD67D246DBD2C4C606@qq.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_357489BEAEE4AED74CBD67D246DBD2C4C606@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/8/19 21:41, Edward Adam Davis wrote:
> Before calling ocfs2_delete_osb(), ocfs2_journal_shutdown() has already
> been executed in ocfs2_dismount_volume(), so osb->journal must be NULL.
> Therefore, the following calltrace will inevitably fail when it reaches
> jbd2_journal_release_jbd_inode().
> 
> ocfs2_dismount_volume()->
>   ocfs2_delete_osb()->
>     ocfs2_free_slot_info()->
>       __ocfs2_free_slot_info()->
>         evict()->
>           ocfs2_evict_inode()->
>             ocfs2_clear_inode()->
> 	      jbd2_journal_release_jbd_inode(osb->journal->j_journal,
> 
> Adding osb->journal checks will prevent null-ptr-deref during the above
> execution path.
> 
> Reported-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=47d8cb2f2cc1517e515a
> Tested-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> V1 -> V2: Corrected typos and comments.
> 
>  fs/ocfs2/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 14bf440ea4df..6c4f78f473fb 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1281,6 +1281,9 @@ static void ocfs2_clear_inode(struct inode *inode)
>  	 * the journal is flushed before journal shutdown. Thus it is safe to
>  	 * have inodes get cleaned up after journal shutdown.
>  	 */
> +	if (!osb->journal)
> +		return;
> +
>  	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
>  				       &oi->ip_jinode);
>  }


