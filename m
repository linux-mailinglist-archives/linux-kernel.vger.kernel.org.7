Return-Path: <linux-kernel+bounces-811286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF017B52701
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008DF1BC3145
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D051DED5B;
	Thu, 11 Sep 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMl+6QVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3222288C6;
	Thu, 11 Sep 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561014; cv=none; b=OWS87ov7JkVuMk7VCKXjrxzbdsaGBSP0JxAuxBd/2gjVtp+glXAemeBPCIw+9Tm4pxjF3cG4O6ae2vlCMzeWfcOhOXn62GssIxnKsR4ktXl/9v6XuZFepUJWh0sAARIysP5XvVuMfpdkwoCltp07AkiBNLdUIXyEZVYMyP9VAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561014; c=relaxed/simple;
	bh=IpqqSiAsTBw2eT4G1BupaTAVa9Si9yghg0Fg3LrmZ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O01Z6qssiZ06Ck+pOKgBYzwiRRkknxZ2ZLpC6e4VOimPsfUpoC+UDbha7TDGwCUuITgnnXPdt7CNaI/50mpv9VLBco92RP47amRSkpei0GJ+Cd0AqDfL49hb0mx47u36iMvtW7bIa16o64CLh/Rjf/hVqsSjOSB9yi8eTRF/kSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMl+6QVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD3FC4CEF1;
	Thu, 11 Sep 2025 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757561013;
	bh=IpqqSiAsTBw2eT4G1BupaTAVa9Si9yghg0Fg3LrmZ+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMl+6QVSqbyeEyz/S43i3sh0uvrZ5ZtcUuV8mm2gSpPgK6VMCLURM6AFMI5WrY8EM
	 5SAMULqzgMM3P7ZllhdZpUfHVguFADtVdYLHJ53j07uObFvOqY3nC6bYxr7MyLlnqR
	 976Iy+83pj93XzyhH4FgfqHmhqWHsQesWIaNS7t/ibaP79c4yWR44c9Zzwr2exlnKY
	 rBzZfJnTq4jA78GZOmHP9zs80qaLmtTPpDYQKnUL7xafZuPMbeqZJ7bCJ3I4ZbINk3
	 dVTv6yrNzThQqIrD8hO1q9lcLCHJNB82MmH7oQTNc4T1jhE8dB+VzLdlO8Q8RpwrvO
	 1CacwngngdjmA==
Date: Wed, 10 Sep 2025 20:23:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
Message-ID: <kuf6r3fuxftpwccnz7llw6vta4ec5f2z53isgw34iow546j73l@zbcse36q6dsj>
References: <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
 <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn>
 <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
 <domy5iwmaasksrm7srdmus5vifcxrzvozwpnc3ht43qtxvkjhd@gkyxt3qaeyqu>
 <CAAhV-H47Tfzb-JbM1-mN1c0WaodPM0G0ip6NCDwZb8Yj=E8+Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H47Tfzb-JbM1-mN1c0WaodPM0G0ip6NCDwZb8Yj=E8+Fw@mail.gmail.com>

On Wed, Sep 10, 2025 at 02:55:20PM +0800, Huacai Chen wrote:
> 
> On Wed, Sep 10, 2025 at 12:05 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > On Tue, Sep 09, 2025 at 12:10:29PM +0800, Huacai Chen wrote:
> >
> > Then it can be __HEAD_RODATA, with the "w" removed:
> >
> > #define __HEAD_RODATA   .section        ".head.rodata","a"
> >
> > > From my point of view, the text section is still the best for HEAD.
> >
> > It belongs in a data section for two reasons:
> >
> >   1) It's an image header data structure.
> >
> >   2) We don't want objtool (or any other tooling) to try to validate it
> >      or otherwise treat it as text during the build.
> I'm sorry but I insist on my opinion. :)
> 
> Yes, there are reasons to put it into a data section, but there are
> also reasons to put it into a code section.
> 
> 1) ARM64, RISC-V and LoongArch have the same style (mix code and data
> in __HEAD), I don't want to do something special.

There's no need for anything special... Fo ARM64 and RISC-V, if their
head "code" is actually just structured data, that *also* belongs in a
data section.

And that can get changed if/when they get objtool support.  If not
before.

> 2) __HEAD is used for nearly all archs, except ARM64, RISC-V and
> LoongArch, other archs are almost pure code (so they must use a code
> section). However, the code in __HEAD is usually not like a regular
> function. In other word, if other archs add objtool support, __HEAD
> will also probably cause problems.

Hm?  Objtool can handle "non-regular" functions fine.  That's what the
unwind hints are for.  x86 has that already and it works fine.

What *actually* causes problems for objtool (and the whole point of this
discussion) is the placing of data in a text section.  I don't
understand why we're still arguing about whether that's the right thing
to do.  Not to mention the fact that using objtool as an excuse *not* to
do it seems completely backwards!

> 3) Many archs put __HEAD between __init_begin and __init_end, which
> means it is discarded at runtime, stack unwinder is useless for it.

Unwinding can easily (and often does) happen during boot, before init
memory is freed.

It could even happen in the head code, e.g. in a debugger.  (whether
that actually works might be a different story.)

But also, keep in mind that objtool has many other features beyond just
ORC generation.  In the future it would be quite foreseeable for some
other objtool feature to get confused by this "code" again and spit out
more warnings.

Similarly, if loongarch eventually switches to using sframe, and the
binutils assembler learns how to autogenerate sframe with minimal cfi
directives (a planned feature I believe), it would have the same problem
trying to decipher this "code".

> So, ignoring .head.text is not just a workaround for LoongArch, it is
> a proper solution for other archs.

I'm not convinced of that.  I don't think we want to ignore it on x86.

-- 
Josh

