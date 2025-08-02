Return-Path: <linux-kernel+bounces-754218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D5B18FDB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB027189A4F8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E00253F1A;
	Sat,  2 Aug 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0b1Hr8I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4EAsEqB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078C1519AC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754164722; cv=none; b=r8mdIQt7e5E1iR1w4PAXUacPBGY1sHVjpUU3amIgfzrs1iSCLA8kT4zqtKt6QfoQlhPuVtFmH+3ULTGd0N6SGBafx7xL9eyQHUGjBqVBH4YGpwsgLP5T3L/FxoxxLD81yiE081gS09iK3s/MDzdbzWXQ0qRuAizG9MbpUiSatmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754164722; c=relaxed/simple;
	bh=/vBZ1/BpD7d3X4+AS7e7RJct8ddLPud+/SzCRxR37Y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhEM3P78uHY4+ZILVSsnjEYpGUlj2AeWq+Pi8mOBeaZjxim9deowWupwGkNSJlQ5hQmywYxDyuel+t+UjwRIvtzztGFY9KFBYh+7qy9h48mbeBx7532jZWODJmgmzd14UZYlXRfLoZ46tqiPDuUEw9ErO3IlS/ovvcMRlo0/A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N0b1Hr8I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4EAsEqB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754164718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKXG94kfTFLiLWx0RaDNk8kUJe6jq0WHVrvRBmun6UI=;
	b=N0b1Hr8IBaY8wbU+9aK0sqkRXePkKOEIgeRvOU+m3j1pWKTO2KPztHnXEUcp9bdaZDsOzq
	OJ00wqRQnb/X8WMaRWBzN6hVk4zoNmE5mVxtASHQi0NdVY9NtZGflZQPhzxDnpeC814kuO
	ZZZeL6f4BDbvaTzGYjXz91zTgxVJZtWUgZoIg8HQrmKtMUHkj+E2O2IulDig/WFidV/Fy1
	XeAdHXTmIRwoUbbjKInXwbeVfRHD1hUIXXw/yXJ6Da9PZe/Br9QQ0C4V+VmQccobSf2KkY
	qIA6s8ZsxGHJlHmJxWNeKTRP12xUv85BOUAONpejcZeYINa6/UU+S4wo/ADPUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754164718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKXG94kfTFLiLWx0RaDNk8kUJe6jq0WHVrvRBmun6UI=;
	b=U4EAsEqBJKAC8BIzajhJ/gaPBoFr6JSRh7JSrFPvaQeY6etZYXv4+3C3eqdT8TYgTqdN+3
	b548tE4QVq22r0Ag==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/urgent 2/2] irq.c:undefined reference to
 `lock_vector_lock'
In-Reply-To: <202508022015.ZX6l8pZr-lkp@intel.com>
References: <202508022015.ZX6l8pZr-lkp@intel.com>
Date: Sat, 02 Aug 2025 21:58:34 +0200
Message-ID: <87plddh4wl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 02 2025 at 20:02, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> head:   69adc077da4c247dd39a8a0e3a898a25924e98d0
> commit: 69adc077da4c247dd39a8a0e3a898a25924e98d0 [2/2] x86/irq: Plug vector setup race
> config: i386-buildonly-randconfig-2002-20250802 (https://download.01.org/0day-ci/archive/20250802/202508022015.ZX6l8pZr-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508022015.ZX6l8pZr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508022015.ZX6l8pZr-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: arch/x86/kernel/irq.o: in function `__common_interrupt':
>>> irq.c:(.text+0x4f): undefined reference to `lock_vector_lock'
>>> ld: irq.c:(.text+0x73): undefined reference to `unlock_vector_lock'
>    ld: irq.c:(.text+0xa8): undefined reference to `unlock_vector_lock'
>    ld: irq.c:(.text+0xc5): undefined reference to `unlock_vector_lock'

Bah. The config guard in hw_irq.h is bogus. It's equally bogus as the
whole APIC=n legacy which we still carry around for no good reason.

I've amended the commit and force pushed the branch...

