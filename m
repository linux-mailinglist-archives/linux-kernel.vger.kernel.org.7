Return-Path: <linux-kernel+bounces-783275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98739B32B32
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC031BC238C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950B21638A;
	Sat, 23 Aug 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LpYMMTV9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6E393DEA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968824; cv=none; b=Nc108h+24GhllLzSoim4kX7opNE2/DrCLBZZprN3eqXM95t9/fSj8dfklOzbxJ37eHdPSQdQW8Pb1ydJyxLe+g5qzeiLPc8qZXBv/j9nGg8X0NPf4DKT1RuTmzbV4TcHnrJmrkw2T7tahykD2skgYu+A5P92Otq8izFk+D58z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968824; c=relaxed/simple;
	bh=zsnLpOJ+msRihUwNBF9a5KmdzajefwvuxfqUE283cp8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EfVLY0I5at2e/FTcRfrar3ajJWQat2oPWuNEIUp8+5DSserrC+GWCiuxFeRSTv7dMZXazkWR8SSkNZVnCvr1dlOrx+ommQitFhpZ4Q1LZny6zgGkB7QOeNBwDqJDxmQiToa8uO1W+S/JQssdaG/x/AsQ02iSuyCavhbfWiwnQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LpYMMTV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EFAC4CEE7;
	Sat, 23 Aug 2025 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755968824;
	bh=zsnLpOJ+msRihUwNBF9a5KmdzajefwvuxfqUE283cp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LpYMMTV9QibwTHYmaRpvNBq+xiR0jSQM86DOFG9fPeqgQH1S5TinNmns1FwCAxM2L
	 lBqCmVK+wN156VaB0d9J4p2KYFnuEBpxaecgqzD9U7aTtp7KwuaZWGpREvoo6EKVMr
	 umTzZzvQOqT3Q5+ysFuXtoi9Ukf3QqwOSjxY7Nvk=
Date: Sat, 23 Aug 2025 10:07:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com, Andrew
 Donnellan <ajd@linux.ibm.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_set
Message-Id: <20250823100703.0a0239d204ca2487363d2adf@linux-foundation.org>
In-Reply-To: <875xeeafgv.fsf@gmail.com>
References: <68a7ef20.050a0220.37038e.004d.GAE@google.com>
	<20250822181653.cd2024360870ef94cdb7db07@linux-foundation.org>
	<875xeeafgv.fsf@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Aug 2025 08:53:28 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Thu, 21 Aug 2025 21:16:32 -0700 syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com> wrote:
> >
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=15f926f0580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
> >> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >> userspace arch: arm64
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15faa7a2580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144143bc580000
> >> 
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com
> >> 
> >> ------------[ cut here ]------------
> >> kernel BUG at mm/page_table_check.c:118!
> >
> > Thanks.
> >
> > Presumably due to the series "Support page table check on PowerPC". 
> 
> The syzbot triggered this on:
>  HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
>  git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> 
> This tree does not have "Support page table check on PowerPC", correct?

Yep, sorry.

> Also, I guess Dev's change fixes this reported problem which could happen in
> this path: commit_anon_folio_batch() -> change_pte_range() ... 
> 
> [1]: https://lore.kernel.org/all/20250812060124.C9344C4CEF0@smtp.kernel.org/
> [2]: https://lore.kernel.org/all/68a80cc6.050a0220.3809a8.0002.GAE@google.com/

Cool.  Dev's fix is in 6.17-rc2 as cf1b80dc31a1.

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c17b750b3ad9

