Return-Path: <linux-kernel+bounces-863817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A1BF92D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D4E18C8255
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB728C2BF;
	Tue, 21 Oct 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yCHvnADN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E076285C8C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088020; cv=none; b=j//XXdMQy5+qH+PQMn1lNoxwY/ypoaqLOPyVSPfLNVKSHiTFzePVnq6NYtjND8+3lJNZxpT7vku6kiQbdr/cEj+e0A3Sz9NbFTI/GS25J6hNMD0zv++KWor0P7TVKA+bl+ClzlHzov782lnhvfci+PHxgEpKO8LAwBx6k0IWRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088020; c=relaxed/simple;
	bh=oOACCClxAEyNfZVhcvJdsNwkAGOMQawD8Hmc9TvywuA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kdQC8cQdYjPodcAoC6BHk++BlTakGE87bky1q44nZB5Ej7nKDyU1/wY/i838BZHddL2vv9EDo1WFf1UDM3fX2vwHSDGAI+1otu2yQ8N710BaSse+5ywML9bHLbdVmA4yd6ZOU77W7iQo6p/BDah5BBYuWdcrs40KjA97fp1+cD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yCHvnADN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3833C4CEF1;
	Tue, 21 Oct 2025 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761088019;
	bh=oOACCClxAEyNfZVhcvJdsNwkAGOMQawD8Hmc9TvywuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yCHvnADNQ9b8LvZl+RpaJT/78rSIFVF4088ebcMZFPcvisQgQ5WBYUr2Q/kw/7Xhc
	 MBOC//It6rg3MR0gK5G4MfUDxKFTzmw883uxHLOS5a+qqk5OqGqAajURVlP2HN/6Pl
	 1X09f034xSKqNt2so0fmKHhBDfvdApc35RA6iJEM=
Date: Tue, 21 Oct 2025 16:06:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst
 <brgerst@gmail.com>, Christian Brauner <brauner@kernel.org>, Francesco
 Valla <francesco@valla.it>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu
 <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
Message-Id: <20251021160657.29b745a94ff8cfd2fe92c7af@linux-foundation.org>
In-Reply-To: <CAD=FV=XXpMnjXzPgDseoLGOYUHVQy9Z2cjmCC+OE+uDC43eNRw@mail.gmail.com>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
	<20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
	<CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com>
	<20251021135553.811b77539d2d41fff3c3b992@linux-foundation.org>
	<CAD=FV=XXpMnjXzPgDseoLGOYUHVQy9Z2cjmCC+OE+uDC43eNRw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 15:57:18 -0700 Doug Anderson <dianders@chromium.org> wrote:

> In other words `dmesg` seemed to be trying to read 2047 bytes from
> `/dev/kmsg` and this wasn't enough to hold the output line. You can
> see in the kernel function devkmsg_read() that when this happens the
> kernel returns -EINVAL.
> 
> We could _try_ to improve devkmsg_read() to be able to return partial
> log lines, but that violates the docs. The file
> `Documentation/ABI/testing/dev-kmsg` says:
> 
>   Every read() from the opened device node receives one record
>   of the kernel's printk buffer.
>   ...
>   Messages in the record ring buffer get overwritten as whole,
>   there are never partial messages received by read().

Well that was dumb of us.  POSIX be damned.

> So tl;dr: as far as I can tell, we simply cannot put the whole cmdline
> (which is 2048+ on many architectures) on one line without breaking
> userspace. My userspace reads 2047 bytes and we'd need to return not
> just the cmdline but the prefix "Kernel command line:" as well as the
> data about time/log_level/etc.
> 
> 
> Does any of the above change your mind about my wrapping scheme? ;-)

Yeah.

> Obviously, I'd want to update my commit message with some of the
> research...

Sure.

