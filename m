Return-Path: <linux-kernel+bounces-842996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CABBE298
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97D94ED07B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD292C2348;
	Mon,  6 Oct 2025 13:17:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1647267B9B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756665; cv=none; b=K1LLBPLqp6vDoRfUM0ScpzhbutxIK9VZugWUY4GjJ3dY66ZfWJS36DVldQ/aLxq3DDmrSv8Bre+wk9tz7bUbAt9DDdA1NtlSZx9wiFemKWoh9AaOPWCT7tadB8sXZNo3k4YsxBeSAKiuWb0quj0JRvHEn3hYeM3wxKXntPiGV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756665; c=relaxed/simple;
	bh=IA0d1+EnohBzsTOyaP7DDf08YVdAGq4ZezzPWuABl+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENaS3smGG9+W+gruyAmp2vP9B/yLx17fJb0oxxaHg+eFTfX9wn050U8YjiFDUUFGH2deOC48J3oQgFhMVvpYJaKmySZan5c9xwygL3Xk0GeaNQGeHJGSu8eLDURshjoGbmS//DheIzCpm0rT0qytzJimczn0DZKxK3CxL4XiTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3348C4CEF5;
	Mon,  6 Oct 2025 13:17:43 +0000 (UTC)
Date: Mon, 6 Oct 2025 14:17:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, will@kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [syzbot] [arm?] WARNING in copy_highpage
Message-ID: <aOPBdNLJUdN4EAF0@arm.com>
References: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>
 <aOACSWYIOD3llWnj@arm.com>
 <7af02ceb-563a-4bad-84ee-620aaa513bed@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af02ceb-563a-4bad-84ee-620aaa513bed@redhat.com>

On Mon, Oct 06, 2025 at 09:55:27AM +0200, David Hildenbrand wrote:
> > > Modules linked in:
> > > CPU: 1 UID: 0 PID: 25189 Comm: syz.2.7336 Not tainted syzkaller #0 PREEMPT
> > > Hardware name: linux,dummy-virt (DT)
> > > pstate: 00402009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55
> > > lr : copy_highpage+0xb4/0x334 arch/arm64/mm/copypage.c:25
> > > sp : ffff800088053940
> > > x29: ffff800088053940 x28: ffffc1ffc0acf800 x27: ffff800088053b10
> > > x26: ffffc1ffc0acf808 x25: ffffc1ffc037b1c0 x24: ffffc1ffc037b1c0
> > > x23: ffffc1ffc0acf800 x22: ffffc1ffc0acf800 x21: fff000002b3e0000
> > > x20: fff000000dec7000 x19: ffffc1ffc037b1c0 x18: 0000000000000000
> > > x17: fff07ffffcffa000 x16: ffff800080008000 x15: 0000000000000001
> > > x14: 0000000000000000 x13: 0000000000000003 x12: 000000000006d9ad
> > > x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000000
> > > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > x5 : ffff800088053b18 x4 : ffff80008032df94 x3 : 00000000ff000000
> > > x2 : 01ffc00003000001 x1 : 01ffc00003000001 x0 : 01ffc00003000001
> > > Call trace:
> > >   try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline] (P)
> > >   copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55 (P)
> > >   copy_mc_highpage include/linux/highmem.h:383 [inline]
> > >   folio_mc_copy+0x44/0x6c mm/util.c:740
> > >   __migrate_folio.constprop.0+0xc4/0x23c mm/migrate.c:851
> > >   migrate_folio+0x1c/0x2c mm/migrate.c:882
> > >   move_to_new_folio+0x58/0x144 mm/migrate.c:1097
> > >   migrate_folio_move mm/migrate.c:1370 [inline]
> > >   migrate_folios_move mm/migrate.c:1719 [inline]
> > >   migrate_pages_batch+0xaf4/0x1024 mm/migrate.c:1966
> > >   migrate_pages_sync mm/migrate.c:2023 [inline]
> > >   migrate_pages+0xb9c/0xcdc mm/migrate.c:2105
> > >   do_mbind+0x20c/0x4a4 mm/mempolicy.c:1539
> > >   kernel_mbind mm/mempolicy.c:1682 [inline]
> > >   __do_sys_mbind mm/mempolicy.c:1756 [inline]
> > 
> > I don't think we ever stressed MTE with mbind before. I have a suspicion
> > this problem has been around for some time.
> > 
> > My reading of do_mbind() is that it ends up allocating pages for
> > migrating into via alloc_migration_target_by_mpol() ->
> > folio_alloc_mpol(). Pages returned should be untagged and uninitialised
> > unless the PG_* flags have not been cleared on a prior free. Or
> > migrate_pages_batch() somehow reuses some pages instead of reallocating.
> 
> Staring at __migrate_folio(), I assume we can end up successfully calling
> folio_mc_copy(), but then failing in __folio_migrate_mapping().
> 
> Seems to be as easy as failing the folio_ref_freeze() in
> __folio_migrate_mapping().
> 
> We return -EAGAIN in that case, making the caller retry, stumbling into an
> already-tagged page. (with the same source / destination parameters) IIRC)
> 
> So likely this is simply us re-doing the copy after a migration failed after
> the copy.
> 
> Could it happen that we are calling it with a different source/destination
> combination the second time? I don't think so, but I am not 100% sure.

Thanks David. I can now see how it would retry on the same pages without
reallocating. At least we know it's not causing any side-effects, only
messing up the MTE safety warnings.

> The most reliable way would be to un-tag in case folio_mc_copy succeeded but
> __folio_migrate_mapping() failed.

Clearing an MTE specific flag in the core code doesn't look great. Also
going for some generic mask like PAGE_FLAGS_CHECK_AT_PREP may have
side-effects as we don't know where the page is coming from (we have
those get_new_folio()/put_new_folio() arguments passed on by higher up
callers).

I'm tempted to just drop the warning in the arm64 copy_highpage(),
replace it with a comment about migration retrying on a potentially
tagged page. It will have to override the tags each time (as it
currently does but also warns).

-- 
Catalin

