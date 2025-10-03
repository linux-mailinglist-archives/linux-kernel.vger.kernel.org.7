Return-Path: <linux-kernel+bounces-841203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B0BB67DE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49C1A4E16D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF82EAB89;
	Fri,  3 Oct 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH/ApZUs"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CB28FFE7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488794; cv=none; b=bh2/RdeZ/Vex917oDVxxYBSQzo56uyTTFwl22y2FJIjLCcDYYR0U+1ZENBSyNHg98n8n10uF062bnt+TiXLm4/YpK3PoU8wmp6zG4jwACBwodrYl83TiJoVPk4TMflyFk3BWM+Ide9rnpExPIOvIBRdUFGCbK7CXJSaUmoRlkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488794; c=relaxed/simple;
	bh=50SjqpAtWA26xzVP678IqddLO8bbsqgQcQQoPJ7nbYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuv0w7whA0oJfM/wXCROjQQuiqe9fgHDXKCS6LdfEPVbNYbbIibj+uVC8U2KyC7MuCfrzHfo2WTvh20jxBGkK9DZaYnYhv0PgCgJ3SLK7d0N+Ei1d9GtnaA6QYA//Bh2zFv1Gk9ULmEzxJLTldxSLloE3Sprl6G0a63uQ2nUvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH/ApZUs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so420056666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759488791; x=1760093591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv2gpNFgYGQlw771XZUydF0n4XV+aO27CStYLLyqj80=;
        b=PH/ApZUslxMa9w9/0yCaw6Xn4+PDyppwxrotYiY24JIWcWjOmu/wWl6RPPFJ7CyJZ4
         +HLv10T677byZ6HyUlQo5mUNOrTjGsfIwNFCTUmJQarQL3BbDm1IB5O+y1JUTwKY+Z1A
         +Xom4orqGx7HiQe/ANr2P65GexF9Wzj3Yg1QEcIhN23txkaOikhF1UAvmYsuN2ItNJec
         DkON6IZPJajh5ZHozvyw6NiKZ/5/PjwptJnqt3tudZ81D8SH1mRuufkQcVXvXsDcckd6
         icUSIO8V8fmqKATdDFSg3vIVcxufrqFVTZss/I5mUygSrH7oVx4eW2FTxQmyhzoeuWfG
         9nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488791; x=1760093591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv2gpNFgYGQlw771XZUydF0n4XV+aO27CStYLLyqj80=;
        b=DquGpmuYh+vnXjmArAy6g8wBq+snI7h1yrwcYH5ZIjnGL9ixOe994gLBAp6huxOkY+
         WAxg8Yn0g7IwEs6xQG8xq3ZHzfs2qjK3BhkRhXSMaKkYZ3Z7YTTVIKdCtRhp/Ctycib7
         UzukmNGApLOA6tuhDP3kzP7eG9pLjClBwce3GGCACsQWqiNWVeLCswdQOf+BS+np13KI
         EItFk1NR/2hQLtucpojGG0PNccpaoIsVVJ3GjWILeCKVj7aEY6kf4mo04mybtv8nMpaR
         viLvnheu9D49s9NhWpUyqTxMUtgtl2Nt4v0S1mkphLG138WntrNpdHNnyFYAeW3i5e1s
         zHgw==
X-Forwarded-Encrypted: i=1; AJvYcCW+exSGMdYUxmHRzuqvankMMAPy5tqAj/aLGuXd5A9OTG517ndHiW6EY63KpSgEs0gbfby1/v9SFC/yi/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHzgqOYn6Fiqqe2tr6hmz7RnyXvX8P8Q0iDmCGiL4bP39DNzM
	QNBQX+0oj0lOTN4JgRoo+Z28+DQbJbVOrnL5xfyKhyE6if7RMPyF1ZFHlBBQQIIIRoHwU2gEPOY
	mP9V0hKScpAnQAhdzIY7C6RKd7vtsiwQ=
X-Gm-Gg: ASbGnctD93bEo+582SxfEEqW6nTFt2VvA7FtfEUhzbppQwDcDW20GcbSFLKB5VtK6mi
	HKTIVTmZnLa8RwnAEi56fWAICbGpqg5y3hyiYpUSfvuggAKb0LF5YGIVmmrEVjlYKjGMrRUyz1r
	x3tfT8pIkhAQZVtKIx4P5hDnsXJsIK97Qvf1BUa3LjuO8bxOJ/+6A/vy0vmpiCONDLB94CpLjZ2
	T53tQfsrHKmTpqyHqtuyatlOS2lvpOn2NfvR6Xy
X-Google-Smtp-Source: AGHT+IGqD7IH0wzy2/Gvx8OVGLPE6VYVfVxxFLMsDXK6gStEMs7q8K2hIp1eXWthqk7Jht+6JYh+PeboTzqTp/1AZJM=
X-Received: by 2002:a17:907:7213:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b49c449b9bdmr304825066b.64.1759488790849; Fri, 03 Oct 2025
 03:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
In-Reply-To: <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 3 Oct 2025 20:52:58 +1000
X-Gm-Features: AS18NWCy6wg3P3shM0ZZ_lTlUy8RmsVTWNDf1yncrmx783MLpOxMuvgdnU4fC8c
Message-ID: <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 05:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Miguel: Rust conflict resolution question at the end ]
>
> On Tue, 30 Sept 2025 at 21:06, Dave Airlie <airlied@gmail.com> wrote:
> >
> > As usual, let me know if there are any problems.
>
> You are still corrupting indentation in your explanations.
>
> I don't know *what* you are doing wrong, but it's wrong. You seem to
> have lost all indentation.

I do that on purpose. there are Alloc: to show. Think C no python :-)

I get about 15-20 pull requests in various formats from very different
groups of people, if I just cut-n-paste them all into the changelog it
would be horribly inconsistent.

I try to harmonize them for myself, so they are somewhat visually
consistent, i.e. single level of indenting is my limit.

I can keep all the crazy if you feel it's valuable, for me it's just
different forms of the same information.

I'll let Miguel deal with rustfmt.

Dave.

>
> Look here as an example:
>
> > rust:
> > - drop Opaque<> from ioctl args
> > - Alloc:
> > - BorrowedPage type and AsPageIter traits
> > - Implement Vmalloc::to_page() and VmallocPageIter
> > - DMA/Scatterlist:
> > - Add dma::DataDirection and type alias for dma_addr_t
> > - Abstraction for struct scatterlist and sg_table
> > - DRM:
> > - simplify use of generics
> > - add DriverFile type alias
> > - drop Object::SIZE
> > - Rust:
> > - pin-init tree merge
> > - Various methods for AsBytes and FromBytes traits
>
> Notice how there are multiple sub-areas: Alloc, DMA/Scatterlist, DRM and Rust.
>
> But it's all just a random jumble, because you have apparently pasted
> it into your editor or MUA or whatever and dropped the indentation in
> the process.
>
> Or something.
>
> What kind of *broken* editor are you using? I'm not trying to start an
> emacs or vi war here, but you seem to be using something truly broken.
>
> EDLIN?
>
> And similar thing here:
>
> > msm:
> > - GPU and Core:
> > - in DT bindings describe clocks per GPU type
> > - GMU bandwidth voting for x1-85
> > - a623/a663 speedbins
> > - cleanup some remaining no-iommu leftovers after VM_BIND conversion
> > - fix GEM obj 32b size truncation
> > - add missing VM_BIND param validation
> > - IFPC for x1-85 and a750
> > - register xml and gen_header.py sync from mesa
> > - Display:
> > - add missing bindings for display on SC8180X
> > - added DisplayPort MST bindings
> > - conversion from round_rate() to determine_rate()
>
> Look, again, no logic and you've completely corrupted any multi-level
> indentation that presumably existed at some point judging by the
> organization.
>
> WTH?
>
> I try to make this all legible as I walk through it myself.
>
> So I regularly fix up peoples language skills etc, because I
> understand that English isn't always the native language (and that
> even if it is, some people just aren't very good at writing
> explanations).
>
> But these kinds of "I'm pretty sure you've just corrupted the
> formatting that was there in some original message" is just
> _annoying_.
>
> Please make the explanations *readable*, not just a random jumble of words.
>
> And on a more technical side: I absolutely detest the mindless and
> completely crazy Rust format checking.
>
> I noticed that people added multiple
>
>   use crate::xyz;
>
> next to each other, so I turned them into
>
>   use crate::{
>      xyz,
>     abc,
>   };
>
> instead to make it easy to just add another crate without messing crap
> up. The use statements around it had that format too, so it all seemed
> sensible and visually consistent.
>
> But then I run rustfmtcheck, and that thing is all bass-ackwards
> garbage. Instead of making it clean and clear to add new rules, it
> suggests
>
>   use crate::{xyz, abc};
>
> but I have no idea what the heuristics for when to use multiple lines
> and when to use that compressed format are.
>
> This is just ANNOYING. It's automated tooling that is literally making
> bad decisions for the maintainability. This is the kind of thing that
> makes future conflicts harder for me to deal with.
>
> Miguel, I know you asked me to run rustfmtcheck, but that thing is
> just WRONG. It may be right "in the moment", but it is
>
>  (a) really annoying when merging and not knowing what the heck the rules are
>
>  (b) it's bad long term when you don't have clean lists of "add one
> line for a new use"
>
> Is there some *sane* solution to this? Because I left my resolution
> alone and ignored the horrible rustfmtcheck results.
>
> I tried to google the rust format rules, and apparently it's this:
>
>     https://doc.rust-lang.org/style-guide/index.html#small-items
>
> can we please fix up whatever random heuristics? That small items
> thing may make sense when we're talking things that really are one
> common data structure, but the "use" directive is literally about
> *independent* things that get used, and smushing them all together
> seems entirely wrong.
>
> I realize that a number of users seem to just leave the repeated
>
>    use kernel::xyz;
>    use kernel::abc;
>
> as separate lines, possibly *becasue* of this horrendous rustfmt
> random heuristic behavior.
>
>               Linus

