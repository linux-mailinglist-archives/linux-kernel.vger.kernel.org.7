Return-Path: <linux-kernel+bounces-811621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC4B52BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F371C8231F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF82E091D;
	Thu, 11 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhnD4yxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C235949
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579330; cv=none; b=ageLbRm59BcrB9DLMokMFmi3VG7wXsK2xej40rKKPq/UQel4n+RdHrkg5ftXqcdZbeorhxdrJJsXwS+/1/GZwZxCjukCMq8Wh2PSvsoq7KjOSCYofhB5vaR1KCdVfs9hHu80hCzetk77cx8o9HnjWH0ujJTfiZvvUF8IDqBvEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579330; c=relaxed/simple;
	bh=cb0wyntMwgB1gjC+HWYBQ+NKZZAa9aHSE8Hd61ANSTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFpqZT1u9qQ1QujaP4rrAlnmTQJ0M0+IauyrKKfd2rCCJZ3BzEHTScafOWgBel66Uqq5Qj19VVKn1HqEOfxrEFs1tjfmI3fXb6FBGdZczUIvx1xz/Os8F2mRuNrMua/ZvXOcn8K6oyoCv/xjprT/WMsUkWuiLPOqmfk46T7sNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhnD4yxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B21C4CEF7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579329;
	bh=cb0wyntMwgB1gjC+HWYBQ+NKZZAa9aHSE8Hd61ANSTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EhnD4yxX5cx91wpWJgbz9LWCNM2nleFRjOs9gEpy/hkiKBT/qhxzeKiKewAcTQ+3u
	 qdso5bB0FdHXURrcCSIyaYBx0VKBqWRNOjykU3DQVxta1WqfBXAVactgXlCCpBbKnu
	 axhUmQcRzAYyP/PJC0yHleAp3LTtLgip/TMUO/k8KkyjSTZ9AK3vl24Oa6Bm0JvqX6
	 /3228bEfRxCkm0ntWB/zaseSB1nrzq+jufSoIo0g+RHOmnuLhNMqyRMyLlZerRyuyY
	 z1rbne8llmNUZjLYmjw9QynjWkfBowLsEjwJlFhDaUobcZI3qTEzPrjujuWog7PdnA
	 ogj9WwOPLGHgA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042eb09948so85453066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKBC+G4giEjNfVry57H+g5Q+QwXc74YkOer1aYnKJPrOcX9pFnb4/3YZSHsTztxtaTUs+Jknz5Ir1QktY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYU8oCy3d52y2pYGOFzqO5yBUvrlHy60bpIv41hzzMtvfltK/
	oNnpR5QEuOC3gii3ENKstTNmjpFmseCJSQhXXWtJB3vFVY2Vx/d6T3QDCRlNhY1TnR9aCIttxbj
	OHigpOSgmYwPQVWncmqQkcQ0kCJgqaGA=
X-Google-Smtp-Source: AGHT+IEHXNgN50M8HXyQdlQC/5yNQQZlA/Ec0hkxp8QsM3mL5Qa8fI7BgwhYPjfTAlpheFgOzZ+r3v2LqCIH7zWhD70=
X-Received: by 2002:a17:907:84c1:b0:b04:31c6:a41f with SMTP id
 a640c23a62f3a-b04b1697ae6mr1350979566b.41.1757579328222; Thu, 11 Sep 2025
 01:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
 <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn> <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
 <domy5iwmaasksrm7srdmus5vifcxrzvozwpnc3ht43qtxvkjhd@gkyxt3qaeyqu>
 <CAAhV-H47Tfzb-JbM1-mN1c0WaodPM0G0ip6NCDwZb8Yj=E8+Fw@mail.gmail.com> <kuf6r3fuxftpwccnz7llw6vta4ec5f2z53isgw34iow546j73l@zbcse36q6dsj>
In-Reply-To: <kuf6r3fuxftpwccnz7llw6vta4ec5f2z53isgw34iow546j73l@zbcse36q6dsj>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 11 Sep 2025 16:28:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6A_swQmqpWHp6ryAEvc96CAMOMd2ZGyJEVNMsJfLkz6w@mail.gmail.com>
X-Gm-Features: AS18NWBgObv5qE04wF8boTWHO4tfzJjtMf3zuv6zHJMJT_hNGITOslklVGB1_fI
Message-ID: <CAAhV-H6A_swQmqpWHp6ryAEvc96CAMOMd2ZGyJEVNMsJfLkz6w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:23=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Wed, Sep 10, 2025 at 02:55:20PM +0800, Huacai Chen wrote:
> >
> > On Wed, Sep 10, 2025 at 12:05=E2=80=AFAM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
> > > On Tue, Sep 09, 2025 at 12:10:29PM +0800, Huacai Chen wrote:
> > >
> > > Then it can be __HEAD_RODATA, with the "w" removed:
> > >
> > > #define __HEAD_RODATA   .section        ".head.rodata","a"
> > >
> > > > From my point of view, the text section is still the best for HEAD.
> > >
> > > It belongs in a data section for two reasons:
> > >
> > >   1) It's an image header data structure.
> > >
> > >   2) We don't want objtool (or any other tooling) to try to validate =
it
> > >      or otherwise treat it as text during the build.
> > I'm sorry but I insist on my opinion. :)
> >
> > Yes, there are reasons to put it into a data section, but there are
> > also reasons to put it into a code section.
> >
> > 1) ARM64, RISC-V and LoongArch have the same style (mix code and data
> > in __HEAD), I don't want to do something special.
>
> There's no need for anything special... Fo ARM64 and RISC-V, if their
> head "code" is actually just structured data, that *also* belongs in a
> data section.
>
> And that can get changed if/when they get objtool support.  If not
> before.
>
> > 2) __HEAD is used for nearly all archs, except ARM64, RISC-V and
> > LoongArch, other archs are almost pure code (so they must use a code
> > section). However, the code in __HEAD is usually not like a regular
> > function. In other word, if other archs add objtool support, __HEAD
> > will also probably cause problems.
>
> Hm?  Objtool can handle "non-regular" functions fine.  That's what the
> unwind hints are for.  x86 has that already and it works fine.
>
> What *actually* causes problems for objtool (and the whole point of this
> discussion) is the placing of data in a text section.  I don't
> understand why we're still arguing about whether that's the right thing
> to do.  Not to mention the fact that using objtool as an excuse *not* to
> do it seems completely backwards!
>
> > 3) Many archs put __HEAD between __init_begin and __init_end, which
> > means it is discarded at runtime, stack unwinder is useless for it.
>
> Unwinding can easily (and often does) happen during boot, before init
> memory is freed.
>
> It could even happen in the head code, e.g. in a debugger.  (whether
> that actually works might be a different story.)
>
> But also, keep in mind that objtool has many other features beyond just
> ORC generation.  In the future it would be quite foreseeable for some
> other objtool feature to get confused by this "code" again and spit out
> more warnings.
>
> Similarly, if loongarch eventually switches to using sframe, and the
> binutils assembler learns how to autogenerate sframe with minimal cfi
> directives (a planned feature I believe), it would have the same problem
> trying to decipher this "code".
>
> > So, ignoring .head.text is not just a workaround for LoongArch, it is
> > a proper solution for other archs.
>
> I'm not convinced of that.  I don't think we want to ignore it on x86.
OK, then don't ignore .head.text in objtool. But I also don't want to
change .head.text to .head.data. So Tiezhu please just use unwind
hints (UNWIND_HINT_UNDEFINED) in __HEAD like the earliest version.
Thanks.


Huacai

>
> --
> Josh

