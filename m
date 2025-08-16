Return-Path: <linux-kernel+bounces-772047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651BB28E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CBA16E8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7982E8882;
	Sat, 16 Aug 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VKRS6dKA"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8E2E7188
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351854; cv=none; b=lEL7UNpRDZhT+k2+idum6Ofoqwd1ALAY1+dbJFAXJbQ0XfpEoF3jD1Zq5AhEK66DkGp55OpD/xb/A7Fk+SO6Hx1FNwZDdt0q99C4Kp7BljWIyJRpWTPZXbMJA7CaP5MrHqFF99j3TnXV5q7sffcFhPC1eo/sxQO3Fxe0DkrwY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351854; c=relaxed/simple;
	bh=0CBsvRl/z3kHbG1BlPvEZE1DUMsauChzqShO+41bdWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXH1Lutd0s4yqDc8UWTMdjiL6keBsiMFdQ+uQzDKXyGmNYpmPOnezK7HJxxGvY5QxF6vXa0TS7GPnVrI9EiEDtz9OtnejcH/ajH7e/FNWSwqIriQrkkHkT7r+mI0Yac80CvHwhWTLmN7j3bXyZt4cX2M4S5ixS83OoY0+iSZM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VKRS6dKA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3vjGVqZ801u6hxGqkfTA8jJyWHpR5ckb7YSt41rFQIw=; b=VKRS6dKACAPPqDh+fZxsnlW9j5
	Gzc0ykwuORiofHpTjaOR+cvAHIamo3N6/KepBDvOYVYQKgmSxgxtpqYNe6PIWIJIjlJmdja8E/cCO
	YgoXL4pKNCJ7S7EncWoBc3OzZkImlmk+pLQr1VGpNsWBpw2Z0NNABivkc6MjLKrYlS7WTmFccPAt3
	kYGgp+vCWU6+eBg81d3SfAp0MebvxcWBPDYPSkBug0ny1kXJPu0bPZUEuptIxYybHZFwpxz4dk+bR
	AnCEPs/ORNR/OYkPGmNlatlHWg45izoipH/INp8sPLGr29ZLS6ufDPBWogGm+zGZwnO2w9m76SyGB
	1gl/uCUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1unHCQ-0002D7-1b;
	Sat, 16 Aug 2025 14:43:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1unHCM-0000RZ-2K;
	Sat, 16 Aug 2025 14:43:54 +0100
Date: Sat, 16 Aug 2025 14:43:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
Message-ID: <aKCLGvmPLPwjyw13@shell.armlinux.org.uk>
References: <20250729174332.3acd1a86@gandalf.local.home>
 <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Aug 16, 2025 at 02:04:34PM +0200, Richard Weinberger wrote:
> [Adding ARM folks]
> 
> On Tue, Jul 29, 2025 at 11:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > Linus,
> >
> > Runtime verification changes for 6.17
> 
> [...]
> 
> > - Add a vpanic() to allow for va_list to be passed to panic.
> 
> This change is causing a regression on ARM32.
> panic() no longer shows a proper stack trace.
> 
> With this change:
> [    2.943690] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> [    2.950101] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.17.0-rc1 #176 NONE
> [    2.950509] Hardware name: Generic DT based system
> [    2.950865] Call trace:
> [    2.951722]  unwind_backtrace from show_stack+0x18/0x1c
> [    2.953111]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.953312]  dump_stack_lvl from vpanic+0xf8/0x388
> [    2.953526]  vpanic from __do_trace_suspend_resume+0x0/0x50

Please lookup the value of __do_trace_suspend_resume in System.map.

> 
> With commit  3f045de7f5 "panic: Add vpanic()" reverted:
> [    2.680077] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> [    2.690241] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.17.0-rc1-dirty #177 NONE
> [    2.690832] Hardware name: Generic DT based system
> [    2.691339] Call trace:
> [    2.692530]  unwind_backtrace from show_stack+0x18/0x1c
> [    2.694283]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.694536]  dump_stack_lvl from panic+0x110/0x31c
> [    2.694944]  panic from mount_root_generic+0x1fc/0x2ac

Also please lookup mount_root_generic.

> Maybe it changes the stack layout enough such that dump_stack() on
> ARM32 is no longer
> able to walk it? I'm using gcc 15.1.1, if this matters.

Also please check whether you're using frame pointers or the unwinder
(CONFIG_UNWINDER_FRAME_POINTER or CONFIG_ARM_UNWIND).

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

