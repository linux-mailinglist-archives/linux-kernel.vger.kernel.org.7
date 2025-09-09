Return-Path: <linux-kernel+bounces-808849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3261B50572
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5517B8B58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276127735;
	Tue,  9 Sep 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3x1fj1sq"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A78246BA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442725; cv=none; b=gA3iH19iXRtQTaaLx6ehrqkzbdYEgSiCHnGjcQaWKd1LqhafBnr5UpEHgviL2u10JHHVCgUwNnFd3X82v0AXBfkfaz4gmU+PFXTN2yFbZshhXEtgwq85sdXLFQ3710ZH+DtVXzjZFy3w9121Q8k2OeAknorIZUkr+dch8wlH8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442725; c=relaxed/simple;
	bh=6AAUlrnohGGrI+J0MWrA1OGh0ETm6EyZ1CIiP3AnRCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC3csG8ca987OzFpkuG9QhbmZgtE02Xbn5fo6wDhX0ydfbDJuDsPdy2Kg51iA9V+TQp7IYOZDprTDCeIv4zQdfhure96Fi3/WZZ0sRiqserXgPofmhUgY5RgtDxOzVLh3jAK84IXSGAs9ZCSysT2pAcol+iEkFSvme1huMVuH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x1fj1sq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b2d018f92so27895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757442723; x=1758047523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIPDNeClQeqdnLL/QKbandyvntWZcY3ztNetbZo+c00=;
        b=3x1fj1sqWkZwfX2dHcj5J7oEDfwg4nHxIxJVlMzH0ivxg+WBYRGqSZYkBKjMiTWPdV
         FjWkdEnLXzlSwTl/0UhMc5lIsh8uBRfNe2wGmbc2KqP3ggg75vVQY4CI6A1itZ7uUdqV
         /Hn/ATQWf2tMH1EMMhxMK4AtQi6xZT4tooqF2g1PUOJffo30y8lEiIpdqzidC7GFYwVY
         OIOA2F0SpCD/0cxn+Hsa0qgBkqzt3vgMM1t6+uQVeunypEDMFZpdfJveJX4x5SZhLETr
         tygC5F+mv9d9i1FcLevBiTWx/r5RQoUdU0Qgdpng1BI8LK4UcInKqRwI9Z4dc3l9CWfC
         NGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442723; x=1758047523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIPDNeClQeqdnLL/QKbandyvntWZcY3ztNetbZo+c00=;
        b=talLRhUWDPmszeBqjpnba4ap3FxJvdxgzZSaXBbJM1Pb1DVvaffBXLo/1e3gIEkn7/
         YtkwODN2nHLDbh8//8m8FnSOKlpKoFlnwrbsdZpuUixFFEGMcdHmUsDJj4kIaau2d7WH
         8W2JI+y0Gns8i0Tz/Gw1rMrl5xtSyY+xLWEnrYOdNIt82r1ifIlAqd+L6NlKYVMQjOpq
         KFoXxgp55t29cGzucxf4gsOscwt2PiAcjeXPIY3BA1P2a/GSBga2LKEO6x9m6Qa7JdgB
         WeKPGKfSwE46LgT4mDykkOYTcAl3nIRLRrGYcWdsh8+2c5NuchRSR1Z/ffwrGEmKR4oi
         MDVg==
X-Forwarded-Encrypted: i=1; AJvYcCVm8D/SD6wItLzfXfhEpjaphyluq/WaObhIqwtTsjOBpKDeQO2gjKfdG+J8CohvCTv1EmKNOsX6rykyxlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8BbQoWAzqSofSEWjc6xNx/DPxKLJSpYRow24DtW379oOZYcT
	kN+l1SPR5d7nBkQ+Q6dMfjBNZkxroSKpXdhR4XgZa0IoCki/5pTJqGos3ir2bZPWHciI27UKdne
	ATHkQpdOIk0SU1kaV0j+QWoc0+cYd1gCXTY7COWwK
X-Gm-Gg: ASbGncuKtlx1ASIhT8ULaf8JqoSwhyaa1aV9Y957xFJcjnJuipfiztAHhGdV5qTKdqG
	km1XUz8jAyD3PgVDmXzknPwJ9jIpvz+ZDdw/6LkaFLXzoza7JLMp2HgCQUqKi7+bme2XIEmuYQZ
	iZr9kKozXJwWaU/yR3Ua3adOs880c1qXyhyY2AsakzPJFzxnOCXq9Xwn3ZuLld+6VkMTVlvYgHo
	ow4yyFgTF/PDqm0qPinmCxi3moAwi7om1yEjlcPLoGZuhSxZva6n7CSKQxcR4LAkw==
X-Google-Smtp-Source: AGHT+IGZLwzdjypUrYwsHkVBGt+rdl3qjVNxww8nM8h1q9KwE/jrMFjGashARVH68XP4Y+EA2LtLQmYuSwlViGOmG1c=
X-Received: by 2002:a17:903:185:b0:248:f683:e980 with SMTP id
 d9443c01a7336-25a539a4fecmr487735ad.2.1757442722903; Tue, 09 Sep 2025
 11:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701201027.1171561-3-namhyung@kernel.org> <20250909094953.106706-1-amadio@gentoo.org>
In-Reply-To: <20250909094953.106706-1-amadio@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Sep 2025 11:31:51 -0700
X-Gm-Features: Ac12FXymMBpx6OEzUcR2rYto9x8srb0rgq2MgfkIOdb5qVU4JRQYY3mKRpIU3is
Message-ID: <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
Subject: Re: perf --help triggers an assertion
To: Guilherme Amadio <amadio@gentoo.org>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:49=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi Namhyung,
>
> I was updating perf's package in Gentoo Linux and noticed some problems
> which were not there before. I tested with the version below and the prob=
lem
> still seems to be there. perf --help triggers an assertion (see below).
> Looking in the list, it seems related to the patch below:
>
> https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyun=
g@kernel.org/
>
> Cheers,
> -Guilherme
>
> The problem:
>
> gentoo perf $ ./perf --help
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
> Aborted                    (core dumped) ./perf --help
>
> Some extra information:
>
> gentoo perf $ ./perf version
> perf version 6.17.rc5.gf777d1112ee5
> gentoo perf $ ./perf test subcmd
>  69: libsubcmd help tests                                            :
>  69.1: Load subcmd names                                             : Ok
>  69.2: Uniquify subcmd names                                         : Ok
>  69.3: Exclude duplicate subcmd names                                : Ok
> gentoo perf $ ./perf bad-command
> perf: 'bad-command' is not a perf-command. See 'perf --help'.
> gentoo perf $ ./perf --help
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
> Aborted                    (core dumped) ./perf --help
> gentoo perf $ gdb run --args ./perf --help
> GNU gdb (Gentoo 16.3 vanilla) 16.3
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://bugs.gentoo.org/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./perf...
> (gdb) run
> Starting program: /home/amadio/src/linux/tools/perf/perf --help
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
>
> Program received signal SIGABRT, Aborted.
> __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ER=
RNO (ret) : 0;
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:89
> #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=3D<optimized out>=
, signo=3Dsigno@entry=3D6) at pthread_kill.c:100
> #3  0x00007ffff747509c in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
> #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> #5  0x00007ffff746e023 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x555555974d03 "cmds->names[ci] =3D=3D NULL",
>     file=3Dfile@entry=3D0x555555974cfc "help.c", line=3Dline@entry=3D104,=
 function=3Dfunction@entry=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclud=
e_cmds")
>     at assert.c:118
> #6  0x00007ffff746e075 in __assert_fail (assertion=3D0x555555974d03 "cmds=
->names[ci] =3D=3D NULL", file=3D0x555555974cfc "help.c", line=3D104,
>     function=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds") at =
assert.c:127
> #7  0x0000555555693813 in exclude_cmds (cmds=3D0x55555614e5e0 <other_cmds=
>, excludes=3D0x55555614e5c0 <main_cmds>) at help.c:104
> #8  0x0000555555693eb3 in load_command_list (prefix=3D0x555555954071 "per=
f-", main_cmds=3D0x55555614e5c0 <main_cmds>,
>     other_cmds=3D0x55555614e5e0 <other_cmds>) at help.c:252
> #9  0x00005555555e9987 in cmd_help (argc=3D1, argv=3D0x7fffffffd1a0) at b=
uiltin-help.c:458
> #10 0x0000555555685d45 in run_builtin (p=3D0x555556130de0 <commands+192>,=
 argc=3D1, argv=3D0x7fffffffd1a0) at perf.c:349
> #11 0x0000555555685fe1 in handle_internal_command (argc=3D1, argv=3D0x7ff=
fffffd1a0) at perf.c:401
> #12 0x0000555555686142 in run_argv (argcp=3D0x7fffffffcfac, argv=3D0x7fff=
ffffcfa0) at perf.c:445
> #13 0x0000555555686493 in main (argc=3D1, argv=3D0x7fffffffd1a0) at perf.=
c:553
> (gdb) quit

Thanks Guilherme,

I tried to reproduce the same version with various options: DEBUG=3D1
-UNDEBUG in EXTRA_CFLAGS, -fsanitize=3Daddress. Being in various
directories with "perf-" prefixed files. I'm afraid I wasn't able to
reproduce. The assert is trying to avoid a memory leak, so
non-critical, and I couldn't in a quick inspection eye-ball an issue.
Without getting a reproduction I don't think I can make progress with
the issue.

Thanks,
Ian

