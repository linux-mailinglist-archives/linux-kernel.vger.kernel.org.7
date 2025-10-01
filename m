Return-Path: <linux-kernel+bounces-839003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E764BB09C1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BC8174135
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B630214D;
	Wed,  1 Oct 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyxdMBj/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EC2EFD96
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327393; cv=none; b=MOFPGPm7r2/+Tq497QXuNuhoCBj9G0R/jnfXouBOm7Icg2XXefNDUKxOp53QeN1pReDYe7mpCIk2Tzf7KpfmfxUDSbNtPaHiBenG+ksYdBQemPwZKSAmNUZo934F2Bl5iOcxvSvihvpRDfaHJ/5wuW4ZG2u5+LteSrei3/Gx2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327393; c=relaxed/simple;
	bh=+Im5V+9+8bCIyHvOmWKH2aB5A0da0eSg5DrmhXw7S3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ1EycB+NUSjZGbsBmYRMC+JN23xCXq8ACxJxsoIhLVJzkrFJd+5rbvUQW99D4JJGcKI4AsWfduW/+4qSz44k2Xd9INbm4fhFZp5xppNoD3UX0Hko33EU9cgD3ZlW536WVjFxkI5VYAn0L5dRNm/+gCTMW93EkCDQ1agmC/du3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyxdMBj/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e542196c7so6256065e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327390; x=1759932190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsug1ilq4WUq/pn5yxhX5suvNAknwwxISuFBz65ikYs=;
        b=EyxdMBj/OxsvUHsjDlal1sOCqxc2oXENgOoz+XCvnk0j4kFcYk1siJPmtW0EAswA+i
         lGtKA5sDdLUAmBxoLcHbFIdopOMxZkYTkOdQRoSYBLpHBdNf/xco1AwZTng+XIJaRRmB
         a2aSCtu6cfu7GMoDq5/KTR6fEswHJBidbZm7gmRHzOZBz9P2so0PtKivvWtIHlTL5S1y
         FYT0ssUlWxsw810naGI3tXhlxMI4V4aDOOoOiaUzKbiPBCbFbqWhdMEZBDSYSokRUMf8
         pmIHmsW+qf/iGk4HCMdftQrhJlzHlvUM/j37Wx62Az+T1pCMgw6zv/X1FNHf2R6hQEu1
         gC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327390; x=1759932190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsug1ilq4WUq/pn5yxhX5suvNAknwwxISuFBz65ikYs=;
        b=kkXyY6kj6Mxzp8iZQrRDEuyoU4zFYiZE8fOW3bcaDc9qwypuPuifYmoSZAok4BhGJl
         1jp4fy1yfH6xPTEeGKqT5VPw6cUgyIrLAom1OOu4TWcc117FHx5rSmZZEC/dR+O91Na0
         gLe2iSATYRzF7ouEwuCfOqGvAKLf11yzksa6DVs6ryiaKLIlGP4SpZlUqGRv6lOQo1Mb
         vWeye+Lp0TjHfKgRgTAzF2BVNQVcFdCD2F6rKOIvlWlNq1mn/yS2JGGqTDbdYxaBp1Fd
         8aAr1+HsnlN9OcEiTvj/dbM5MWhkQQHCWW27lf1aK6kKZwRT31kk6QKePwPWbaV+pQbO
         mfVg==
X-Forwarded-Encrypted: i=1; AJvYcCWL03rtViHDSm3gMXVfbbszXFjzIo+GceTdxAL+QtescMA1IXZfEEUqUqHOG1c81UEXRrQ0xnkF1QcciGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmQdHO7FwqfgSuuUchVO7yFZZUrq5JGAUeygi7UEN6k2QSGzz
	WORqGD5pi+ZLUeD/pcbtQETpVpwAmUOppE1lXJS5yce419xsWVaJHHA0vjySOsFKkhUMKrvghXK
	cSDBRYF/A+dDLVfdVOD4xM4iMlSJd9OQ=
X-Gm-Gg: ASbGncuqwblaKR75gEHdaovBQ4PXejv2ei/3EszzEgNMfc5LybzG2y+nCjD0IE4dL8g
	ZelqkidplNX5p6P9/+9jG9D3c2uWUcU5oGMjpLgrC40nNmpto8rbE3ouNMdUzjD86P8b4KsZ9gE
	qgrEzr0O1TgoXqCb/DKU7QjcbN5u/Vzd7FL03aq2oBPvNaVrmWtoemv8z9k7T5tXEqKzB+hv7Wh
	Zjo17JFGjRnGmscd74eN2MmPn5eIN5CJ+wdsrAnb63vLgXlxoWMsNj7MrXT
X-Google-Smtp-Source: AGHT+IHcZ8geORYZfcAOhaP4e5wNjNO0Gognc1doxkDe33xVdFGfTwi/f8CSeVlvYQomzgVuLkYgEckkFRAMMV40rwM=
X-Received: by 2002:a05:6000:2282:b0:415:15eb:216f with SMTP id
 ffacd0b85a97d-425577761d4mr3304483f8f.2.1759327388947; Wed, 01 Oct 2025
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
 <aN0JVRynHxqKy4lw@krava> <aN0d6PAFg5UTKuOc@krava>
In-Reply-To: <aN0d6PAFg5UTKuOc@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 07:02:55 -0700
X-Gm-Features: AS18NWCzb--1QBSTth2j8WJmtwVSU5P7iFrYwWq0nkHPar-l6o_r9wpK9l4rlxA
Message-ID: <CAADnVQKEKLPvy5etjRvF12hbi4cgZrnXvx6tEfu9aRF4eZv+Ew@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:26=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Oct 01, 2025 at 12:58:29PM +0200, Jiri Olsa wrote:
> > On Tue, Sep 30, 2025 at 07:09:43PM -0700, Linus Torvalds wrote:
> > > [ Jiri added to participants ]
> > >
> > > On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > Note, there is a trivial conflict between tip and bpf-next trees:
> > > > in kernel/events/uprobes.c between commit:
> > > >   4363264111e12 ("uprobe: Do not emulate/sstep original instruction=
 when ip is changed")
> > > > from the bpf-next tree and commit:
> > > >   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> > > > from the tip tree:
> > > > https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> > > > since Jiri's two separate uprobe/bpf related patch series landed
> > > > in different trees. One was mostly uprobe. Another was mostly bpf.
> > >
> > > So the conflict isn't complicated and I did it the way linux-next did
> > > it, but honestly, the placement of that arch_uprobe_optimize() thing
> > > isn't obvious.
> > >
> > > My first reaction was to put it before the instruction_pointer()
> > > check, because it seems like whatever rewriting the arch wants to do
> > > might as well be done regardless.
> > >
> > > It's very confusing how it's sometimes skipped, and sometimes not
> > > skipped. For example. if the uprobe is skipped because of
> > > single-stepping disabling it, the arch optimization still *will* be
> > > done, because the "skip_sstep()" test is done after - but other
> > > skipping tests are done before.
> > >
> > > Jiri, it would be good to just add a note about when that optimizatio=
n
> > > is done and when not done. Because as-is, it's very confusing.
> > >
> > > The answer may well be "it doesn't matter, semantics are the same" (I
> > > suspect that _is_ the answer), but even so that current ordering is
> > > just confusing when it sometimes goes through that
> > > arch_uprobe_optimize() and sometimes skips it.
> >
> > yes, either way will work fine, but perhaps the other way round to
> > first optimize and then skip uprobe if needed is less confusing
> >
> > >
> > > Side note: the conflict in the selftests was worse, and the magic to
> > > build it is not obvious. It errors out randomly with various kernel
> > > configs with useless error messages, and I eventually just gave up
> > > entirely with a
> > >
> > >    attempt to use poisoned =E2=80=98gettid=E2=80=99
> > >
> > > error.
> > >
> > >              Linus
> >
> > I ended up with changes below, should I send formal patches?
>
> I sent out the bpf selftest fixes:
>   https://lore.kernel.org/bpf/20251001122223.170830-1-jolsa@kernel.org/T/=
#t

Applied selftests fixes to make CI green(at) again.
uprobe patch should probably go via tip.

Will send bpf.git PR in a day or two with a couple more fixes.

