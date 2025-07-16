Return-Path: <linux-kernel+bounces-734007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5AB07BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208D11663B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90542F5C39;
	Wed, 16 Jul 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWp0HYhC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fonCkGI1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1E27510F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686286; cv=none; b=MYwZKcw81eTyyQXoga7OVs91HfsooVMT00PQ+N83pxC7i8KBPRnsRpa/vndN+fCveCO+t3IQzX1o2L/MqRrmJMn1t2HVM7HD/Pb2fSr0ZDeTahxw1ly7JZg5peKXyrm7e8LISJIeiY1INsMjVPxy2bxPOY+jyR3BlI6U3ktcmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686286; c=relaxed/simple;
	bh=cAoVPxkt/dinsa6nJwl+96VpyIGHPL7qFsPziq3Z1r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6Iyfj8K0mGSRfPpaklxWHroqtkMwMx4EBB5ZbQBZidGLOH1mo7B8cGHm9MKMa/UADi6kB5qIZHxoOlTQOfXTVbjGUfj3CmDA/y6pZ3QU0ck4LBRsg6rxpopB96n8ssbMlM9C4cI8mauuOoCG7N3pUMDARUBE9aIY3fL6J1fv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWp0HYhC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fonCkGI1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 19:17:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752686273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFNvBmuWcrSDG+7MTp9BSMX1nNEj1yPghZI+Kgwr7fA=;
	b=KWp0HYhCCmSRIhzS/mgd4Hb433TYSiUd6hjruBiZsfBNH3O3ldqZr77YBWJP5hAv/sQzmL
	ovTa9Edy9+4EbPkne0Gbr8fy6hGbL1EtUHuxw7VI/I0DO8hukJ7jWC7EivCBwACs3svwS4
	ecYtf+Nc0XmRPVzk58bpSpu48TS4fB0dHwxyUgS8w6CWychMXieomcJzhT8QjOY53jowZj
	Nkrr6UjO31SsdiT4ILEGb9CWVWDrTqaNx5c4XZo8EFBDzbk+fSZ+q+p5b9Ck9FKac4/tSM
	fl6Pyy/nSIYEqUT3cnOJBCA8tDx4Zgz2/sPot3ztPteE7JTf7k6r8QhwDis6hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752686273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFNvBmuWcrSDG+7MTp9BSMX1nNEj1yPghZI+Kgwr7fA=;
	b=fonCkGI1Tk1whOZH+s5kMMPnYyht+a62wgXi4OeuKLujHGLgy5giIr7DgOA8HvPfYzse1J
	SR9QOeTWDObeCVCA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] x86/cpu: <asm/processor.h>: Do not include CPUID
 API header
Message-ID: <aHfevkaADwRv0Fzb@lx-t490>
References: <20250709203033.90125-7-darwi@linutronix.de>
 <202507150403.hKKg9xjJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202507150403.hKKg9xjJ-lkp@intel.com>

Hi!

On Tue, 15 Jul 2025, kernel test robot wrote:
>
> All errors:
>
>    drivers/char/agp/efficeon-agp.c: ...
>

Sorry, my "i386 compilation testing" was to do an allyesconfig, disable
CONFIG_64BIT, then compile…

This — now I embarrasingly discover — does not enable the kconfig options
that depend on X86_32=y; e.g., the CONFIG_AGP_EFFICEON case above.

It seems that, kinda like cross compilation, an "ARCH=i386" environment
variable should do the job well with allyesconfig and the rest.

I'll make sure that all future CPUID work passes that step before sending
it mainline.

Thanks a lot,

--
Ahmed S. Darwish
Linutronix GmbH

