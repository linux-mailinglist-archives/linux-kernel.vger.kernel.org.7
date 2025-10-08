Return-Path: <linux-kernel+bounces-845612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A4BC5851
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5B164F9546
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC62EB851;
	Wed,  8 Oct 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3pRjs7i"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07354286413
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936078; cv=none; b=NZ7cDk1RL2ZeLF6tpI3M9p5lBrpMpbAse66Oqza/geY4ZSafYydniJJ1Jna9E8H0QrO0ifzHXIww/eFZ1Sbe/tOL67PaQG2bLypExuoxwUpWjpFnnES6bBbSWpKKpKmOQf4Wa9+GX7qZr6f3mYSoRsV3WaNsByONa7Mdz8ddmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936078; c=relaxed/simple;
	bh=Nm7aX1Bb8l40LyIYWaF3fwVxtzyrnMlq872TDd6+wfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWUlkTCdaiStvCu6hbX9DwOYKijs4+xZiAvuv6y8yP9FFiBeUDslM8nJ6gFrHKn2GD1c9+mRMJuU4hC/jYSEmn5jQ1uzOwY6yFFNSnI1abcVLHcbSQW6LTlDtcsGQiKssMHP5lQqrWDX4hEzK6aoCt+6dYdRyEcnTxMpTwKykaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3pRjs7i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2731ff54949so198585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759936076; x=1760540876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZb0E/ciyXI/QUv2L4T9aSkLcWAAZb1kZeJF5tHvIuI=;
        b=R3pRjs7iHTmizXoQOyBAv824Qt1KFMfPiTUw81K4R3NC2qaCwsq8sMMPUofD4/F82K
         9ex6xizLJ6GZKqCoaXPz366EzeQVD5ku5XklY2bxzy09OzypIEyh4+3U4psEuEHiUKe7
         jZyeXtZuQMDsNqYElLwaqhVCPWNU6K11OJXJJJ+wrpUEbnt4JCWfZttfWB9M4coapjcx
         N/AXW3GQ+EXAHO5MNiqvRIr4ZG3DO27bPOZTEwbLerlo+Us42DBCIusUbvZLQebBILls
         /eKL4w6WQJpaTxfTC+flqkA4g6LmpDUUDi5d/taeIX+AJE7SD1q3LCMyW1fXJ3p9EB+y
         PwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936076; x=1760540876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZb0E/ciyXI/QUv2L4T9aSkLcWAAZb1kZeJF5tHvIuI=;
        b=KOE1pxfQ+ZzjiGrRckaq77A1THPKynu3rxvAsuEUgXbrpx2O7n6qFrVamTe53zrt4J
         IG3n2qLzLODliXTeMZtg/4KJYF8iPGwOQS/AtqmWcYK2LFi9fKyK58zBOZLmKQNWsHWC
         UDMnkOdU7BKm2e+4BTkr6kZEofkbNuDrq1qls++BM7K78pKYMbKFPDTd3bfdUsIVR7h/
         LMo/+wYHdnd/thHd80rCdjP8yH3t6ch6DfNHsSo+OwQ2+z9sU7Tc12TPsyZ8+3NCqNfQ
         Vx32sfwOkfSv3nQU0sVhBmsk1OmbqOYgrSazE35PdSCehoO/DUwMNgLoeKga9JcNRf2u
         YkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWFqopS8wstDKJoY2jlmJ7/1Kr6K17jQ0bu76aWOit7c13+WCL5NKsMA/r8OEkghoN2C3mgc2Pqq4R0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N1JXJcXEVAE90aM8bgIGf2KLNDrJ8ahrhnI352rarSVPCyTc
	sQ2iOUPgbRmXysVN2ORlBo30MFjPrBSxmbqxQAq+B6PW8O/0nqe5wN8SRg2srPakXdURtQfeArC
	paMm5hX5xw68ZYyUd7WyjNBM6zTe+6gevsio06AUP
X-Gm-Gg: ASbGnctNimQdR3AuIFfsWxka3YmOJ9cnvDZ36JR64fgSliVXydtJ0NFbgKjzs9zCSok
	RTiJxqaRc0BXtvF54Iw/18AL0ogIHeXV4ivfBqF99x3lMAXSzHT/KTF0Ggu0n27rPNKD6WKPCHs
	yhs9dwhCTMCYt3wxzBH6VNlhcCQfLXLBYJEkjwNFDX9rFg+hxZvTZR411mKP5fNDWOH0AaDrN9J
	wnTbe3nkFMEm0AV+rCed4Hxwcfi4aerQ/aMYjke0YmjjlEP3T2QSDvQ0ew+Efgg4Ujy
X-Google-Smtp-Source: AGHT+IFiThZkf1CHvwbFmuIjDclrlQRkzSg5IQ4HojWsioD+qhs7llL+rWqNNmlCx92DTvW9gyjiFsxhQhZAxyC7iSM=
X-Received: by 2002:a17:903:38cf:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-290276dfef2mr4977015ad.16.1759936075946; Wed, 08 Oct 2025
 08:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
 <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org> <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>
 <aOZplPKCRwvlOgUA@stanley.mountain> <be4fae8b-d49f-4a90-a617-1ac2b22a2356@linaro.org>
In-Reply-To: <be4fae8b-d49f-4a90-a617-1ac2b22a2356@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 08:07:44 -0700
X-Gm-Features: AS18NWBgSIC-Q9EYl79OeIgdXgIl5ccn5b34hbYIPhNuXzYuXKiZ4uxhtK6Tzgs
Message-ID: <CAP-5=fVzOQv5OVk8mchZ_w11iHr02AB7c6jn1tKSE4pmHiq14A@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code reading"
To: James Clark <james.clark@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:11=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
> On 08/10/2025 2:39 pm, Dan Carpenter wrote:
> > On Wed, Oct 08, 2025 at 11:21:34AM +0100, James Clark wrote:
> >> On 08/10/2025 9:32 am, James Clark wrote:
> >>> On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
> >>>> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
> >>>>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
> >>>>>> On Mon, Oct 6, 2025 at 6:11=E2=80=AFAM James Clark
> >>>>>> <james.clark@linaro.org> wrote:
> >>>>>>> +       data =3D zalloc(sizeof(*data));
> >>>>>>> +       if (!data)
> >>>>>>> +               return true;
> >>>>
> >>>>>>> +       data->addr =3D addr;
> >>>>>>> +       strlcpy(data->path, path, sizeof(data->path));
> >>>>>> nit: perhaps strdup rather than having 4kb per tested_section.
> >>>>
> >>>>> Oh yeah that would have been better, not sure why I didn't do it
> >>>>> that way.
> >>>>> Although the max sections I saw was around 50, and it's usually
> >>>>> a lot less
> >>>>> so it's probably not worth the churn to change it now that
> >>>>> Arnaldo's applied
> >>>>> it?
> >>>>
> >>>> I see you submitted a patch for using strdup() and then there is a n=
eed
> >>>> for checking the strdup(), etc.
> >>>>
> >>>> Since at this point this is an improvement on a test and all is sitt=
ing
> >>>> in linux-next and the window is closing for v6.18, lets leave this f=
or
> >>>> the next window, ok?
> >>>>
> >>>
> >>> Makes sense.
> >>>
> >>>> These would be good things for some tool to catch, before it gets se=
nt,
> >>>> but that is another rabbit hole :-)
> >>>>
> >>>> Thanks,
> >>>>
> >>>> - Arnaldo
> >>>
> >>> Does Smatch work on Perf? I imagine it would catch this if it does. O=
r
> >>> just plain old cppcheck. I'll take a look.
> >>>
> >>> James
> >>>
> >>
> >> Smatch doesn't know about strdup and seems to be more focused on kerne=
l so
> >> probably isn't a good fit.
> >>
> >
> > No one is going to write a check which tells people when to use a fixed
> > array vs when to allocate memory dynamically.  Those sorts of decisions
> > are too complicated.
> >
>
> I mean "doesn't know about strdup" in that it would have to know that
> it's an allocator and can return NULL which should be checked etc. Not
> that it should know about Ian's original suggestion to use strdup in the
> first place.

Ooh, is smatch smart about errptrs? perf is using the hashmap code
from libbpf and rather than doing the more conventional C thing of
setting errno and returning NULL from hashmap__new it encodes ENOMEM
as an errptr thereby breaking NULL tests. We seem to always forget
this and eye-ball checks of hashmap__new results being compared to
NULL are reasonable. For example this fix for the issue:
https://lore.kernel.org/lkml/20250917095422.60923-1-wangfushuai@baidu.com/
I believe in the kernel coccinelle will spot this but we don't have it
as part of the perf build.

I think to make the C compilers smart enough to catch this we need to
do something like:
struct ERRNO_OR(hashmap) hashmap__new(...)
where ERRNO_OR would be a macro to add a wrapping struct and then we'd
force users of the hashmap__new result to check if the value were
errno or a pointer.

Another source code analysis tool it'd be interesting to have on the
perf build would be clang-tidy.

Thanks,
Ian

> >> Cppcheck struggles with a lot of the kernely style that's used in Perf=
,
> >> especially the headers. We'd either have to silence a lot of the warni=
ngs,
> >> or start with almost no warnings enabled.
> >>
> >> It doesn't have a warning for usage of a malloc return value without N=
ULL
> >> checking, so in this case it wouldn't be useful.
> >
> > In the kernel we care a lot about missing NULL checks but in userspace
> > it doesn't really matter in the same way...  It's easy enough to write
> > a check for this in Smatch.
> >
> >>
> >> I'm not 100% convinced that the effort of integrating one of these int=
o the
> >> build system would be worth it. I know that once they're in, there wou=
ld be
> >> constant maintenance of silencing false positives etc. And a lot of th=
e
> >> warnings are more style or opinions about undefined behavior according=
 to
> >> the standard, but aren't real based on what the compiler actually does=
.
> >>
> >
> > The thing about false positives is that people should just ignore all t=
he
> > warnings except the new ones.  In the kernel, this works well because w=
e
> > fix all the real bugs right away.  And if we haven't eventually someone
> > will look at the code again and after 10 years or so it all either gets
> > fixed or it doesn't matter.
> >
>
> This requires some infrastructure though. The easiest way I imagined it
> working would be more like how we have compiler warnings and -Werror
> currently.
>
> Not that we couldn't come up with some kind of infrastructure to track
> new errors. But I think it would be applied too sporadically to block
> people from sending a patch in the first place.
>
> >> As an example, cppcheck on code-reading.c with --enable=3Dall gives 17
> >> portability, 11 style, 3 warning and 1 error outputs. Out of all of th=
ese
> >> only two of the warnings are significant, from commit 0f9ad973b095 ("p=
erf
> >> tests code-reading: Handle change in objdump output from binutils >=3D=
 2.41 on
> >> riscv"):
> >>
> >>    token =3D strsep(&version, ".");
> >>    version_tmp =3D atoi(token);
> >>    if (token)
> >>        version_num +=3D version_tmp * 100;
> >>
> >>    token =3D strsep(&version, ".");
> >>    version_tmp =3D atoi(token);
> >>    if (token)
> >>        version_num +=3D version_tmp;
> >>
> >> "token" has already been passed to atoi() so can't be NULL in the if
> >> statement. I think the atoi() needs to come after the null check.
> >>
> >
> > Yep.  Smatch does cross function analysis so it would have caught that.
> > (I haven't tested).
> >
> > regards,
> > dan carpenter
> >
>
> I ran it on this file and it didn't say much. Although I don't know if
> I'm using it properly:
>
>    smatch --full-path -I. -I../include -I../lib/perf/include -Iutil -I../
>      arch/x86/include -I../lib tests/code-reading.c
>
>    tests/code-reading.c: note: in included file:
>
>    /usr/include/x86_64-linux-gnu//sys/param.h:93:10: warning:
> preprocessor token roundup redefined
>
>    tests/code-reading.c: note: in included file (through
> ../include/linux/kernel.h):
>    ../include/linux/math.h:17:9: this was the original definition
>
>

