Return-Path: <linux-kernel+bounces-841561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05DBB7A63
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECC694ED638
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F92D77ED;
	Fri,  3 Oct 2025 17:05:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1952D73B0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511117; cv=none; b=sZOwYNZc0hU/PAw4gTeo/9IkgMnsWv1Zb1k0x/jMNGZlQPWZo/sbReXLK8E6KlWN0bXX+vUd+xIJt/mK6ur3hjhU1/jozTVoYkq0eRMsU6ypNyAFEjR37FCRr7LfhoPaVanCaBwhsGswzklbhQ/7V0FDBdnkskI5jhvh+w8wuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511117; c=relaxed/simple;
	bh=dCKrt8dplsaCnu926SB7MnYRZ15xSlDKLeikRK7Sik8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VapgcX4uM4AbMuJC0msvW5sYTItWgwngJkTZsgkFYw56hwgsSvgxzQmRFVFtbagflExCRmj1Hlwmsr82aPUtj6I4OpPMOZrs3XWOMgszNSiVWe5yf/T0cn9b/se2DzGmOvh4WQKLSqUOZAyi7pnelaLKx27VCtYdB1ugnyEyoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17081C4CEF5;
	Fri,  3 Oct 2025 17:05:15 +0000 (UTC)
Date: Fri, 3 Oct 2025 18:05:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: syzbot <syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, will@kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] [arm?] WARNING in copy_highpage
Message-ID: <aOACSWYIOD3llWnj@arm.com>
References: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>

Thanks for the report (for some reason, outlook did not deliver this to
my inbox; Will pointed me at the message)

Adding David H as well, he may have some ideas. I haven't tried to
reproduce it yet.

On Wed, Oct 01, 2025 at 02:48:30PM -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    fec734e8d564 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..

So that's just before 6.17, not something that turned up during the
merging window.

> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12187d34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=13bd892ec3b155a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=d1974fc28545a3e6218b
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-fec734e8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7e18b408aea/vmlinux-fec734e8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9b7984f47117/Image-fec734e8.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 25189 at arch/arm64/mm/copypage.c:55 try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline]
> WARNING: CPU: 1 PID: 25189 at arch/arm64/mm/copypage.c:55 copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55

This warning means that the destination page is already tagged
(PG_mte_tagged set) when it got to copy_page().  In general it is fine
as we copy into and override all the tags but my assumption until now
has been that such new pages are always untagged.

> Modules linked in:
> CPU: 1 UID: 0 PID: 25189 Comm: syz.2.7336 Not tainted syzkaller #0 PREEMPT 
> Hardware name: linux,dummy-virt (DT)
> pstate: 00402009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55
> lr : copy_highpage+0xb4/0x334 arch/arm64/mm/copypage.c:25
> sp : ffff800088053940
> x29: ffff800088053940 x28: ffffc1ffc0acf800 x27: ffff800088053b10
> x26: ffffc1ffc0acf808 x25: ffffc1ffc037b1c0 x24: ffffc1ffc037b1c0
> x23: ffffc1ffc0acf800 x22: ffffc1ffc0acf800 x21: fff000002b3e0000
> x20: fff000000dec7000 x19: ffffc1ffc037b1c0 x18: 0000000000000000
> x17: fff07ffffcffa000 x16: ffff800080008000 x15: 0000000000000001
> x14: 0000000000000000 x13: 0000000000000003 x12: 000000000006d9ad
> x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000000
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff800088053b18 x4 : ffff80008032df94 x3 : 00000000ff000000
> x2 : 01ffc00003000001 x1 : 01ffc00003000001 x0 : 01ffc00003000001
> Call trace:
>  try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline] (P)
>  copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55 (P)
>  copy_mc_highpage include/linux/highmem.h:383 [inline]
>  folio_mc_copy+0x44/0x6c mm/util.c:740
>  __migrate_folio.constprop.0+0xc4/0x23c mm/migrate.c:851
>  migrate_folio+0x1c/0x2c mm/migrate.c:882
>  move_to_new_folio+0x58/0x144 mm/migrate.c:1097
>  migrate_folio_move mm/migrate.c:1370 [inline]
>  migrate_folios_move mm/migrate.c:1719 [inline]
>  migrate_pages_batch+0xaf4/0x1024 mm/migrate.c:1966
>  migrate_pages_sync mm/migrate.c:2023 [inline]
>  migrate_pages+0xb9c/0xcdc mm/migrate.c:2105
>  do_mbind+0x20c/0x4a4 mm/mempolicy.c:1539
>  kernel_mbind mm/mempolicy.c:1682 [inline]
>  __do_sys_mbind mm/mempolicy.c:1756 [inline]

I don't think we ever stressed MTE with mbind before. I have a suspicion
this problem has been around for some time.

My reading of do_mbind() is that it ends up allocating pages for
migrating into via alloc_migration_target_by_mpol() ->
folio_alloc_mpol(). Pages returned should be untagged and uninitialised
unless the PG_* flags have not been cleared on a prior free. Or
migrate_pages_batch() somehow reuses some pages instead of reallocating.

-- 
Catalin

