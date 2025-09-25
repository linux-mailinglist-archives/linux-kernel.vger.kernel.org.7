Return-Path: <linux-kernel+bounces-833328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E6BA1AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9181E16A65D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50867271459;
	Thu, 25 Sep 2025 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ysJVlEj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03D1F91D6;
	Thu, 25 Sep 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836983; cv=none; b=KweyT1n1B5me97I33RuTWeir63yoS3d1Z+NNuaPIexIpebeIADEMhmVTbFkB3ho9FjTjkYq9TxhXk3cT2IacPXZmFuOo9y/UwbLq37NFczY03fPhHH+h7TbzLb6njqXqulliccv1fhLEe9buM9viGvmEtErAGkSxkCiyQmfBqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836983; c=relaxed/simple;
	bh=yea2XZBdKd29JLgdM6CX1rrbboEwDzwvwj7Fijsfs0k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cjKQU2M9yd3dXCPGhabtH9cCD3nSoyLugBPC5k3sybd5/YLwxlTyBL78k8f/b8Yr9dkQ4KMtmVUi6kyd3zKvDDjhrYvHl5rG9yy3wKrdSg4PFsZ9AIuGErVfsEfv2KcUfL/VzRDz7hh9tsSBLy4u+fw7TMDj2GzcNKj2P4DiBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ysJVlEj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6953BC4CEF0;
	Thu, 25 Sep 2025 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758836982;
	bh=yea2XZBdKd29JLgdM6CX1rrbboEwDzwvwj7Fijsfs0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ysJVlEj3H84pHjMNJYPYrrzHWL47O/50ZHIBr3yLvdWQP/CArhHENoBvHRg4hUOhr
	 IuMlSd3Yf79fPTmvIBPuLXHU6TqBiaI/O2kdPzDzNNEUgvGkt/B9JENnp/7ZFUysCQ
	 AxA7KMh76CjtuPGer/mDvfyPtoSKtoij57MP18Vk=
Date: Thu, 25 Sep 2025 14:49:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot ci <syzbot+ci74a400bb557985f4@syzkaller.appspotmail.com>
Cc: david@redhat.com, kartikey406@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, muchun.song@linux.dev, osalvador@suse.de,
 syzbot@syzkaller.appspotmail.com, syzbot@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list
Message-Id: <20250925144941.125467b7a7717211f6322482@linux-foundation.org>
In-Reply-To: <68d5aee9.050a0220.25d7ab.008a.GAE@google.com>
References: <20250925144934.150299-1-kartikey406@gmail.com>
	<68d5aee9.050a0220.25d7ab.008a.GAE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 14:06:49 -0700 syzbot ci <syzbot+ci74a400bb557985f4@syzkaller.appspotmail.com> wrote:

> syzbot ci has tested the following series
> 
> [v1] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
> https://lore.kernel.org/all/20250925144934.150299-1-kartikey406@gmail.com
> * [PATCH] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
> 
> and found the following issue:
> WARNING: lock held when returning to user space in hugetlb_vmdelete_list
> 
> Full report is available here:
> https://ci.syzbot.org/series/7d3a090c-ec8f-4d0c-8f7b-8797e63f1fde
> 
> ***
> 
> WARNING: lock held when returning to user space in hugetlb_vmdelete_list
> 
> tree:      torvalds
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> base:      07e27ad16399afcd693be20211b0dfae63e0615f
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/06671e7c-eebd-4d11-9f0d-d9dae5637c0a/config
> C repro:   https://ci.syzbot.org/findings/75fcdb87-67fc-45ee-a70d-3064e8c1126c/c_repro
> syz repro: https://ci.syzbot.org/findings/75fcdb87-67fc-45ee-a70d-3064e8c1126c/syz_repro
> 
> ================================================
> WARNING: lock held when returning to user space!
> syzkaller #0 Not tainted

um yes.  Presumably something like the below is needed.

I'm wondering how this passed runtime testing?

If resending, please let's add a comment telling readers why we're
skipping !__vma_shareable_lock vmas.

I'll drop the patch, thanks.

--- a/fs/hugetlbfs/inode.c~hugetlbfs-skip-vmas-without-shareable-locks-in-hugetlb_vmdelete_list-fix
+++ a/fs/hugetlbfs/inode.c
@@ -488,7 +488,7 @@ hugetlb_vmdelete_list(struct rb_root_cac
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
 		if (!__vma_shareable_lock(vma))
-			continue;
+			goto skip;
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
@@ -499,6 +499,7 @@ hugetlb_vmdelete_list(struct rb_root_cac
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
+skip:
 		hugetlb_vma_unlock_write(vma);
 	}
 }
_


