Return-Path: <linux-kernel+bounces-892595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60352C4568D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304D5188FA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445992FD67E;
	Mon, 10 Nov 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCsDn5Q0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC502EBDEB;
	Mon, 10 Nov 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764308; cv=none; b=Anyqjx+Ks3PU6Bj7LF6RSpsGAszAl0BgyjmfvsT3UOOZT/f3dhUgm8sPRtBHdB9k5ClgwVvor+kyiCkD8hmEDmua+mJpKFlXQATZqnJP5vs2YOoLVnKSgEygUeU2NyweOo0N6ZiYP6SFRaOOPVF8IRTjpG5SA/ulk2nLHGEXuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764308; c=relaxed/simple;
	bh=g2a0vGTvGldA8i5v9Mt5hb7o4lxuAAGirkRFTeAXyAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6mvxBAmySfY+5EtMUHV0I/JJOHngxSRRAJiAZjzN1C650bzxJH4eU1HpvNZ096MBbQpXBk16ZBz9hJ4OXN7lN/6iT7i3eDEugtREw8vmxBpyPm9MLfSTB5AfwGCMXltNWhQ5uxPzPta8P3UxFSyxHjXN07x6K9dbz60piwR2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCsDn5Q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F4C4CEFB;
	Mon, 10 Nov 2025 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764308;
	bh=g2a0vGTvGldA8i5v9Mt5hb7o4lxuAAGirkRFTeAXyAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCsDn5Q0tvBi5ln80ZSRIeQXFoKObYPhgw98a0bVXizLp7nFrowHC2D5UOHNpRXlX
	 9HTfT4anyd6ZxCeACG8KRxV0iFYU7GsYUQoZoOz4mUxaNfB6J+m+PdbmtewBjXOFaz
	 nmCas9paaU0O4fNQVOXqGPjxYYNfRysIQTKnJxU689aAyahbNdm4CLeHXiGHuPW8bF
	 RZvB601F6t/B8soXHWQwrn3OUGtk20s95IOn7jTQTIG3SlqIX3rq29NN7GbJe87o+a
	 fi3A3vCQ5nsO84WVYzWngYuSkz1ONZQGBgTqKGlTilDtIaQyqDynAhYNjd4mpFKUYK
	 U9IMUxTsg536A==
Date: Mon, 10 Nov 2025 09:45:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	luto@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
Message-ID: <20251110-hufen-klang-9cf8ec9dda59@brauner>
References: <690dfca7.a70a0220.22f260.004d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <690dfca7.a70a0220.22f260.004d.GAE@google.com>

On Fri, Nov 07, 2025 at 06:05:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c09bcd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9995c0d2611ab121
> dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1500a532580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0a114580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a4d318147846/disk-17490bd0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/86641a470170/vmlinux-17490bd0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/35c008a540c8/bzImage-17490bd0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com

#syz test: https://github.com/brauner/linux.git work.namespace-6.19.fixes

