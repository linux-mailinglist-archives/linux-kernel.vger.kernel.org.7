Return-Path: <linux-kernel+bounces-848506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505EBCDEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 694B44E1DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF02FB99B;
	Fri, 10 Oct 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5qvV7zU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263D2FB084
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112133; cv=none; b=k9Jn7ZPIIL0RrGjT8JNZxLYZLx7xUPFTmAzHSUTiWMkEOOHi/0GUOgFkd4sXSuwTObQAXGWhqT/a4ALBu7nQOHRtLVMsZS3lru44YZ+zG+b0LU5w/82VZtUKHfbEMCUKU/9s//SK3iJyhkQy3KH6uvqWThYrfL96E4uxYtuyUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112133; c=relaxed/simple;
	bh=eoWQ7nY21cD8Wjcz79k3l5le8v7O57flhDTB/bONqaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxzPi940oBgmkl1vdQmlz6/sb6D9YhbM+cvVEs9qyLm+WaPi0TFSRFSBsq/gI5FKz0Yz0fKPRWMQCCETkefpzzJTVXoJE5OhN7hxNCwxZrh8uyjjZ1RlyyOTc+RY/HB9SYOIy0qeET+tgVQzF1Nr4zC7UNCe0xuyeNe5Z14RgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5qvV7zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CA4C4CEF8;
	Fri, 10 Oct 2025 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760112133;
	bh=eoWQ7nY21cD8Wjcz79k3l5le8v7O57flhDTB/bONqaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5qvV7zUkzFExEhhc8IlfftrVbOp3oA4/Vz+wdC6EAysWPxGg4yfpHpei/HYztExp
	 4VcZK5gg0rAYd6fWFYtnQHUNdYJuYeMRVUz/r5fTqql9IFCmYUsvwnQAXFVVNKLjls
	 hcJh2Kw1i194GWbi5H91jtAGSmXouBK+mEFVprqfYeb9nrW+068He7oWHNQoKIKVFQ
	 TJlUoDRFcX1A/Oteq5/xj5toHnEBYagxNLY7FbUT+nWgTE/WzYhXF948Wl09s0WXIL
	 IR2lpESlXCu6AAsHzeTAbPPfgwIoig4y/sO57K18ri6JOJuPgVAqmKp8uxAnirKWwN
	 rteYLRhWMMOEQ==
Date: Fri, 10 Oct 2025 16:02:11 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Jan Prusakowski <jprusakowski@google.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
Message-ID: <aOkuA_Ffq2klE5g6@google.com>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4643bb6-882a-4229-b938-e94398294905@kernel.org>

On 10/09, Chao Yu wrote:
> On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
> > Xfstests generic/335, generic/336 sometimes crash with the following message:
> > 
> > F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
> > ------------[ cut here ]------------
> > kernel BUG at fs/f2fs/super.c:1939!
> > Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
> > Tainted: [W]=WARN
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:f2fs_put_super+0x3b3/0x3c0
> > Call Trace:
> >   <TASK>
> >   generic_shutdown_super+0x7e/0x190
> >   kill_block_super+0x1a/0x40
> >   kill_f2fs_super+0x9d/0x190
> >   deactivate_locked_super+0x30/0xb0
> >   cleanup_mnt+0xba/0x150
> >   task_work_run+0x5c/0xa0
> >   exit_to_user_mode_loop+0xb7/0xc0
> >   do_syscall_64+0x1ae/0x1c0
> >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   </TASK>
> > ---[ end trace 0000000000000000 ]---
> > 
> > It appears that sometimes it is possible that f2fs_put_super() is called before
> > all node page reads are completed.
> > Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
> > 
> > Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
> > 
> > Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> > ---
> >   fs/f2fs/super.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 1e0678e37a30..5c94bc42b8a1 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
> >   	f2fs_flush_merged_writes(sbi);
> >   	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
> > +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
> 
> Jan,
> 
> At this stage, GC and checkpoint are both stopped, why there is still read
> IOs on node page? Who is reading node page? Can you please dig more details
> for this issue?

We don't actually wait for completing read IOs. So, I think it doesn't matter
the threads are stopped?

> 
> Thanks,
> 
> >   	if (err || f2fs_cp_error(sbi)) {
> >   		truncate_inode_pages_final(NODE_MAPPING(sbi));

