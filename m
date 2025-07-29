Return-Path: <linux-kernel+bounces-749935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5EB1551E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A764E7EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFA27F18F;
	Tue, 29 Jul 2025 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9ywN+MK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651EC1946BC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827141; cv=none; b=WYY0DvV+83xeh/6j7bxph5JV/+0YZcC0M3g/dLS0M8dLPh9iOxDEd/poDU15Ew79uEskfN4VOJGo0+KbL8P6b0n0dq9YFnYrlvI9rmvr6wIyY46+eSoDYKV3hfkllpCHG8oU4lEe1WYnfYbCH/Z9f6zXvtrZYn02ntdivt7/hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827141; c=relaxed/simple;
	bh=ukluxmvbolYh6949M07cea3x/KhWJmLpWSMjsHwoDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENL5XeMQ/TSy2y5K04a2tcbvxiCR39hS/hBzfA0eHLzrynNEaUKmdhWGNzLjYlS3fgr8yUQ+dWVYy6n6Wpda4rjFmMDVN7b9os8ndPr0SIhP1hzoroVo+3lBgYpHnVnM2R4scMUcZ2nEIVDlMA6GA3e4PwKZ7OOh5pHBICIMUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9ywN+MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38ABC4CEEF;
	Tue, 29 Jul 2025 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753827141;
	bh=ukluxmvbolYh6949M07cea3x/KhWJmLpWSMjsHwoDI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9ywN+MK0Tse8fONtO7wCTrL2D8B/k5W1TW9e/jK2dJyIqQh9iqkyxD2LZw5P/c3R
	 mNS1bcbjj0cmYpd1sG8FiJLlz6E85LQb+WntNcAOxym8aH873C2V2nXR7pOXV6txRK
	 vHxw7NSXgjhYFs8/vhD+YQtHFvb2vzArL38FY4lxMfvEj7qwRvR0xyvBs/IJwnG9dU
	 YUGRz1b6julSsip1yIt8Z+nOSo+RrdJtyZf+BdQicEBBttvA6nqQufATTYH1JGqxfv
	 7oAmBmepJJ97JHKdovXWd6oSzOnLpw4n/VHnwDqXAOnhiUyeaHHxCKBn8+bRU6s1ct
	 JfsibE92xbEVA==
Date: Tue, 29 Jul 2025 15:12:20 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, x86@kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [syzbot] upstream build error (23)
Message-ID: <202507291506.1DF23781A2@keescook>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <87cy9ikcwh.ffs@tglx>
 <874iuuk87e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iuuk87e.ffs@tglx>

On Tue, Jul 29, 2025 at 11:17:41PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 21:36, Thomas Gleixner wrote:
> > On Tue, Jul 29 2025 at 06:43, syzbot wrote:
> > and to keep the call for efi_init() as a symbol for the linker to
> > resolve, which obviously fails.
> >
> > If I change the efi_enabled() stub to __always_inline, it's optimized
> > out.
> 
> Kees has addressed similar problems in:

The change that I made that is triggering these warnings is:
381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")

The __init vs inline warnings I saw as I was working on this and had
been tackling them. Arnd found a couple more recently, too:
https://lore.kernel.org/all/f8bcf5ce-8b8b-4555-a210-14e1974eac92@app.fastmail.com/

> > Disabling CONFIG_KCOV_INSTRUMENT_ALL makes it go away. So GCC confuses
> > the optimizer when CONFIG_KCOV_INSTRUMENT_ALL is on.
> 
> Seems to be GCC 12 specific. GCC13 does not have that problem.

Now this 'efi' issue got noticed too, and it seemed to be a preexisting
problem with GCC 12:
https://lore.kernel.org/all/202507272255.50254C0C@keescook/

There were the same linking problems even before 381a38ea53d2.

> > The kernel is full of such inline (not __always_inline) stub
> > conditionals which evaluate to a constant....
> 
> And chasing all those stubs and convert them to __always_inline seems to
> be a whack-a-mole game.
> 
> Can we just stop pretending that GCC12 is KCOV capable?

That's fine by me, but I do think something weirder is happening here.
Those efi linkages should be entirely DCE'ed?

-- 
Kees Cook

