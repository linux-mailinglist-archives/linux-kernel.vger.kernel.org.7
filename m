Return-Path: <linux-kernel+bounces-840713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF69BB50E8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B138B1923DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC62868B7;
	Thu,  2 Oct 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bdt7HM0x"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81E50276
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434850; cv=none; b=LykGeRGfvF1BS9TuWgCAP08pkEMpPR5sn8fRRA+2fwscTQWfW0a2qnLH5V4z2MMfAo9viBhpoyrr455Kovk8I3fgRjOw/2NPfxBg09ATCNDeEktUuxqpuOSLbZUpsax0a70fwXIRgnCRN8aG+606YVk0WjpDcGhtcoiU1smiqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434850; c=relaxed/simple;
	bh=1C0g3QJxXAJ0mUo1B9zb79q75spQVNLpVel8nzMiQc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkRsXWHupN0YclBePBZ1xXyEwM1rQ/Z8lMlxF/7lT/tYJTpYIT1m227n5NDg7xgkCGNBOu24lNh+WSjNpNjkYhN43639na1iMiQTVTwRxON1n0hUCdIGW5A7WCSIUJRhAeRet5+VeMukwZQuSxsKC0/gFQwIZAFGVgK1XuZOVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bdt7HM0x; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b472842981fso211377066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759434845; x=1760039645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I37SSLi2qetMQx6IBceAm8uDQMzW3KruHoh0XNcQuVw=;
        b=bdt7HM0xJ7fQstL8KlgJl0QkrtCtTKG2bj6JbZeM2vzbK0bVU8oU39qwYULAvNJrAD
         JxOT32p23ht1cC3hSxX8EQbijrwVKA2Ig97Q6ESbt6gSiCPm4H9KT8ODCFTDMF0coBdl
         36okpUIHSHjvffOjeN1cpkmE3kCKsbp8X62Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434845; x=1760039645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I37SSLi2qetMQx6IBceAm8uDQMzW3KruHoh0XNcQuVw=;
        b=Qz8kv8OaVKxI5bHq+DzgzIIpoq3e7fPTDWEy7imQzNF1pvroKq2XmdCx1Ppvz9LoYA
         PQC/6pOJO1pDo9zkLWVgeSkzqR6Qa1ZgFDszftFVAbnCaJLQXpXHrrPLffEcGUym7c5b
         Nu2Y/jelPbj5tpOA2q6XzRR2E8M7XtkZQNg90xH1WHBeW1s7GTQ231ee6r9ZmOU/flr0
         Kr31doa6KhhvGq2VvIwijL6X9mvJ/LJaFmBcFHt3UQeMiO0y3GB9Egt3fhT7hXl/ILAE
         z49qaWdgSZq2eUM8HRiyDRfeUHwRlRdkA1DeFcLpv7mJFtFPNBZKJ2RrZrmANdtv7Tv9
         EZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmpMx7oPaoWGpiapDHLOU3aSVT4qlMZia1ygMfgxq2lKSKdOf2hBS/AxBf3NEg0I4IvnWhgcUF12LIu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwE4gru+T6BIVsobQoJctiH3ifxWpbnz7eDiI6NAojtIzt4pFU
	t/h30zNbEed8O8bIOVMSILn5Rq3GfPKv3d/E+McOBJ0qPYUpkaahLv91MjCCyP2pqF+6Rzhgq+k
	NKayOH78=
X-Gm-Gg: ASbGncuhT6NvxBcOpKa0HlCvKadETqpYCly8HysVRYxhr41eE2hr2fcGannpNuOwvbk
	2cavxAn/ekTzgZRctO8bUDsIL56OKUOKrC2qkjxXymFRAcB5EG/kclfe0r1LJvm0JV5Tzhq73lV
	prETfnw7nsZTJnBkib1/XdGdozg0qThpCgCm27Ym7L5lGdCLedjOm+xDLM9tLxpqNmFT8hwvB9k
	K65GpxLRtnJtLPtC5H8qDYlA4t2OTYCqzHA1hjQU9QUGxslBlLRWpTHT6y7YIOvYWO20pRvfd8G
	nZWPKx8TJ+09r/Id80GwvDXttavUjlXReI3b5RzVbjrJeLpC7hGW3Xq5lRlP1Ka178647mqFZX1
	bIlrh3fE1C2PKIronvRtOeJTa7k40BcxJKLV6G398QbbyN/cr5vV8nb2Ev6E/2sHBVMgvgDICz7
	VcfGT9wI5EyCT0sD9IlJJp
X-Google-Smtp-Source: AGHT+IFvX+w6kQnM90Qu+4371v3PWJDmXNp0TT/zYEXUsM++pjw7Q6luGaXvXS7OaVcr59y5RcLPUg==
X-Received: by 2002:a17:907:3da0:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b49c393a608mr77519966b.43.1759434844828;
        Thu, 02 Oct 2025 12:54:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b422sm269969766b.54.2025.10.02.12.54.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 12:54:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so2562258a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:54:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+MwhLXuDmOFgpDsgnwI+hX6dFyY6LdvvZWR37qjxOtjFQaxngEOVTER7I+s6/DphYE2CTZEcWJcQEqFE=@vger.kernel.org
X-Received: by 2002:a17:907:3d91:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b49c1f54862mr76088066b.29.1759434843265; Thu, 02 Oct 2025
 12:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 12:53:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
X-Gm-Features: AS18NWDXy-JXhX78nkhLH5FtPzyaZrdPMLmE90_MFn-_upbdYrA-tUUT0FXOA4I
Message-ID: <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Miguel: Rust conflict resolution question at the end ]

On Tue, 30 Sept 2025 at 21:06, Dave Airlie <airlied@gmail.com> wrote:
>
> As usual, let me know if there are any problems.

You are still corrupting indentation in your explanations.

I don't know *what* you are doing wrong, but it's wrong. You seem to
have lost all indentation.

Look here as an example:

> rust:
> - drop Opaque<> from ioctl args
> - Alloc:
> - BorrowedPage type and AsPageIter traits
> - Implement Vmalloc::to_page() and VmallocPageIter
> - DMA/Scatterlist:
> - Add dma::DataDirection and type alias for dma_addr_t
> - Abstraction for struct scatterlist and sg_table
> - DRM:
> - simplify use of generics
> - add DriverFile type alias
> - drop Object::SIZE
> - Rust:
> - pin-init tree merge
> - Various methods for AsBytes and FromBytes traits

Notice how there are multiple sub-areas: Alloc, DMA/Scatterlist, DRM and Rust.

But it's all just a random jumble, because you have apparently pasted
it into your editor or MUA or whatever and dropped the indentation in
the process.

Or something.

What kind of *broken* editor are you using? I'm not trying to start an
emacs or vi war here, but you seem to be using something truly broken.

EDLIN?

And similar thing here:

> msm:
> - GPU and Core:
> - in DT bindings describe clocks per GPU type
> - GMU bandwidth voting for x1-85
> - a623/a663 speedbins
> - cleanup some remaining no-iommu leftovers after VM_BIND conversion
> - fix GEM obj 32b size truncation
> - add missing VM_BIND param validation
> - IFPC for x1-85 and a750
> - register xml and gen_header.py sync from mesa
> - Display:
> - add missing bindings for display on SC8180X
> - added DisplayPort MST bindings
> - conversion from round_rate() to determine_rate()

Look, again, no logic and you've completely corrupted any multi-level
indentation that presumably existed at some point judging by the
organization.

WTH?

I try to make this all legible as I walk through it myself.

So I regularly fix up peoples language skills etc, because I
understand that English isn't always the native language (and that
even if it is, some people just aren't very good at writing
explanations).

But these kinds of "I'm pretty sure you've just corrupted the
formatting that was there in some original message" is just
_annoying_.

Please make the explanations *readable*, not just a random jumble of words.

And on a more technical side: I absolutely detest the mindless and
completely crazy Rust format checking.

I noticed that people added multiple

  use crate::xyz;

next to each other, so I turned them into

  use crate::{
     xyz,
    abc,
  };

instead to make it easy to just add another crate without messing crap
up. The use statements around it had that format too, so it all seemed
sensible and visually consistent.

But then I run rustfmtcheck, and that thing is all bass-ackwards
garbage. Instead of making it clean and clear to add new rules, it
suggests

  use crate::{xyz, abc};

but I have no idea what the heuristics for when to use multiple lines
and when to use that compressed format are.

This is just ANNOYING. It's automated tooling that is literally making
bad decisions for the maintainability. This is the kind of thing that
makes future conflicts harder for me to deal with.

Miguel, I know you asked me to run rustfmtcheck, but that thing is
just WRONG. It may be right "in the moment", but it is

 (a) really annoying when merging and not knowing what the heck the rules are

 (b) it's bad long term when you don't have clean lists of "add one
line for a new use"

Is there some *sane* solution to this? Because I left my resolution
alone and ignored the horrible rustfmtcheck results.

I tried to google the rust format rules, and apparently it's this:

    https://doc.rust-lang.org/style-guide/index.html#small-items

can we please fix up whatever random heuristics? That small items
thing may make sense when we're talking things that really are one
common data structure, but the "use" directive is literally about
*independent* things that get used, and smushing them all together
seems entirely wrong.

I realize that a number of users seem to just leave the repeated

   use kernel::xyz;
   use kernel::abc;

as separate lines, possibly *becasue* of this horrendous rustfmt
random heuristic behavior.

              Linus

