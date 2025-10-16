Return-Path: <linux-kernel+bounces-856723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3751BE4E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400F61A63773
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9251EDA2B;
	Thu, 16 Oct 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StXFPJsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A143346A1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636840; cv=none; b=Xg4N2/f/k2Yefv6mLjT9i0cW1dTs/xiLPkjTJJJH4N+mmSCeflRGZNBnJl22hEqZI+y8bbowGeTYoLYeQ5HU+X4PchTw+NH3RJPdS/KPJTjmuqwAj/PDlC6y/VCusHwaaih+tC1ceOpb3miqGJIU1hmeQMJEeVArI932nejNtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636840; c=relaxed/simple;
	bh=r6DPlZVy4qFQFCrpXk4SSFgx6SI+uqSLFd6ZAb5HV1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkvVdGB+0bHIGqKfcg8i9IwsCMhgKHBUpBuNs6/0a0JOWysyA5USeDTppg061P+0Rfuhz+OD1fNSu9EQeY7LZ75RJ+JUv9d8S/xJzCRHKCwHXER0ZwTGft7X8J+2Kyb2PEOOa9cQYJbccPiMpU7E5SVMUXFzsGBmrYps3SLIQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StXFPJsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B95EC4CEF1;
	Thu, 16 Oct 2025 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760636839;
	bh=r6DPlZVy4qFQFCrpXk4SSFgx6SI+uqSLFd6ZAb5HV1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StXFPJsrgX576876aQGb7oiXW0p6Oq4IfTuzmeTH3RSrHRNxNmjX9I5WE1cvPaP7J
	 VvP263mbNKSQNv2grpRt1gk+sQ9bLHAeKG9N2AO1IhM+sfL4Ee1qBVVKKENjhM/xeH
	 gO79bbOXKhaO9rOZNngA3TX1uY5Auo0R1sVT/f18E4Ep6BtBPm+PM7I/Y0HD9rmSet
	 mA/P9iQIVZ7fLg/g9zjFmGnWSWqNd3C9rxnktme6ZkPQYh5qajCTopKinzpTn+wAtC
	 zKSbSSQ9UkW5B+vaeAUFufZbRi+e+clEMLWqE3QaYqH4p64r3oGwbAm+pLkRjraTDG
	 Li5fE1fCG8fsw==
Date: Thu, 16 Oct 2025 17:47:17 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Jan Prusakowski <jprusakowski@google.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
Message-ID: <aPEvpeM_cXWcxcZe@google.com>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
 <aOkuA_Ffq2klE5g6@google.com>
 <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>

On 10/11, Chao Yu wrote:
> On 10/11/25 00:02, Jaegeuk Kim wrote:
> > On 10/09, Chao Yu wrote:
> >> On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
> >>> Xfstests generic/335, generic/336 sometimes crash with the following message:
> >>>
> >>> F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
> >>> ------------[ cut here ]------------
> >>> kernel BUG at fs/f2fs/super.c:1939!
> >>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> >>> CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
> >>> Tainted: [W]=WARN
> >>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >>> RIP: 0010:f2fs_put_super+0x3b3/0x3c0
> >>> Call Trace:
> >>>   <TASK>
> >>>   generic_shutdown_super+0x7e/0x190
> >>>   kill_block_super+0x1a/0x40
> >>>   kill_f2fs_super+0x9d/0x190
> >>>   deactivate_locked_super+0x30/0xb0
> >>>   cleanup_mnt+0xba/0x150
> >>>   task_work_run+0x5c/0xa0
> >>>   exit_to_user_mode_loop+0xb7/0xc0
> >>>   do_syscall_64+0x1ae/0x1c0
> >>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>   </TASK>
> >>> ---[ end trace 0000000000000000 ]---
> >>>
> >>> It appears that sometimes it is possible that f2fs_put_super() is called before
> >>> all node page reads are completed.
> >>> Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
> >>>
> >>> Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
> >>>
> >>> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> >>> ---
> >>>   fs/f2fs/super.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 1e0678e37a30..5c94bc42b8a1 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
> >>>   	f2fs_flush_merged_writes(sbi);
> >>>   	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
> >>> +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
> >>
> >> Jan,
> >>
> >> At this stage, GC and checkpoint are both stopped, why there is still read
> >> IOs on node page? Who is reading node page? Can you please dig more details
> >> for this issue?
> > 
> > We don't actually wait for completing read IOs. So, I think it doesn't matter
> > the threads are stopped?
> 
> Read on node page should be synchronous? so if the threads are stopped, there
> should be no node IOs? Oh, Or there is still pending asynchronous readahead IO
> on node page after all threads are stopped?

I remember we submit IOs and wait for its completion when we need by lock_page.

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>   	if (err || f2fs_cp_error(sbi)) {
> >>>   		truncate_inode_pages_final(NODE_MAPPING(sbi));

