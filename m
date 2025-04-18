Return-Path: <linux-kernel+bounces-609945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCCA92DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 01:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62ABA1B658C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488222154D;
	Thu, 17 Apr 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmXX/tUe"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CF21C177
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931549; cv=none; b=od5wDdWuvcqC/gkMLeALmeMc+bDotyIRRcK5be54vf73bcj9rU03O+oYGhj1T5OyBsfrgljoSe0prcahmE5tg3m9yXLhghQYfoaF3ZDVTB5g/6SkwxLNqLLE/SigRVzi8PGhc50eO+9Mp808gmQvtmCqOmYHIi/QAuhu2AcSPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931549; c=relaxed/simple;
	bh=sK+K61gcxO6m17bJ4fFtOTiisn1JcKzaBb6hmlYNlow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8BtOuqxn7EAAB9NkIJ7azA5LKVI8suDdQlhuDU3i5dV3X+89F0+B6c4fQTE+u/Fm2/RIZAvUvf4dI8M98dmaXGT/6XfXHB/PqSgCPo20vdxmK9iLvvOIlHp0+EtMDM6GfETnZPL1nuyD/IVu0kGH6Pr5pnFgWClRdEf9WjB5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmXX/tUe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so94525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931547; x=1745536347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eeYizTITU+B3gKv1exCccb1cLi2y8PamBFk1DM+qjk=;
        b=fmXX/tUeUM16qcBjD459lcN1mjL4AsQyVkCXGtN7WpJ0vaMyt+44zOV9NMaKy+HKSh
         1SLTicwQhxYA5caU86K3TV0kUIAQtCEGqh1qJJBZqw+PwFbP9YtszHaw8S6Fj7gLYcxd
         4Jq5M5UUr9fU9JeaByAfqmFScCGoP3rrZe0Ng6xV1h+BiY48mhXP9S5C5zQ0GvRnXaUB
         Qom53w3jxfeR1/AyQiFplnL/mKuk+uWPpkWroxW5o4l0OXNngLg9/1NzpktDeONzSwsr
         ji1ccyHXSwF0LQLqbwTNLGpdgJxuLCWy6ZE3jpFGa9pvRPzDVQUHBLeF1No4sDcBiigy
         13dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931547; x=1745536347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eeYizTITU+B3gKv1exCccb1cLi2y8PamBFk1DM+qjk=;
        b=JWySHxG665NQaO8ErDFeJysCZpeU8601dEXi0p5PhYp4muIclAp/B+2nx/lYk0aQ4N
         EKjm9UAAWhOK+3WwLpLrv9rp7uYmXHUuXg93CIBlSszMqFvRl9wsvo+D4xxaIH3OXlcy
         1BlLxudy7WNDmJ+YOav39Z0+s82tSYMR6j6N5C/sFc5oo0msw9JTvQukO5ukZbtnvt5u
         +rJvA8bDxFqJp7jWjRNGP1+iyYgoBGwbEpLxIkybil0oDDYngtj2o6yP9yxanIvQf/zR
         Ntj+t1PtLrpN8hIWjH+aSefxYkHTvqod4pEfM/7ypw/h8862xTRHH2U1CHU6Ckgzh13J
         iR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfCyKdJ0tjqgey5gdyWqm7bMT5Ot/q6ScswH8pvHaBWS+zG27zaP5U7qyrfi3h1qeER1yUwCOS/YGItxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXWR7R78Pmkksm9OlV29NRTY+6UPWmw/7ri4R4ZWo8ujBV9UC
	al/8UPNhlpY/493w17DL3Au7PZ9SkoOr1oazunhVupWI5MxmiFqQhJnFu0MLLOrVQBxE93jvCra
	1VSmjXjYQJGvloATZImITb5v4v2E4bYAAIMsH
X-Gm-Gg: ASbGncvhPYyoNSCit851U2jULwSbZexVgdGFMTVfD6C0uz3AwZvGOEsb/T4/VuXWZnc
	gKe1YoDidR+NwzEILSA3BxZ/3HHcOji3hd2jes4ZeMCAmDUtHrjvSwUxFsnd68FEl08BabYcZYr
	03Z1mwcm0O4RmyVAFTtHbRqrGBZgt1Ie1EuuGTBSsDum2J5wPyiHC3ARXmXlXbjQ==
X-Google-Smtp-Source: AGHT+IGTXo89UWIMnenwDzm7bJl3ibD7/0kXpr1Avf1oYe9YyIOG/R6WwsyJeZjtpDfAoZzDUkbYdiBpE/xVn5Y4jRM=
X-Received: by 2002:a17:902:ce0a:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22c54797b1bmr509205ad.9.1744931547028; Thu, 17 Apr 2025
 16:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aABlDyhAYz95vOM1@x1> <CAP-5=fXeykYoqLJ8t6Gq31cO8eYGOnppgc86PHfWnBoz4xgw-g@mail.gmail.com>
 <aAF5mIul8qhDUYz8@x1>
In-Reply-To: <aAF5mIul8qhDUYz8@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Apr 2025 16:12:16 -0700
X-Gm-Features: ATxdqUFi-tMR8ibqkWmz-tk-QuDdac5Fcz2SSEKgt8jSnq7cGz3oRXYZwgeq_go
Message-ID: <CAP-5=fXxxaBs_JGqZVM8rZzg837Po4_p2wOARBj2i6183kXgjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Remove libbfd from the set of expected
 libraries to build perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: arnaldo.melo@gmail.com, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 2:58=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> > There is a wider set of cleanups that remove BUILD_NONDISTRO and
> > libbfd that I posted back in January:
> > https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com=
/
>
> I thought that discussion hadn't come to a conclusion, then I was in
> vacation in January + LSFMM/BPF, lost track of it, will read your
> message below and look at it again.
>
> Its just that I recreated my toolbox container for building perf to a
> fedora:42 based one and went on trying to build it from the base system
> that gets installed in such containers till the point where I found the
> above problem.
>
> Now doing 'make -C tools/perf build-test' I'm getting this after the
> above patch:
>
>             make_nondistro_O: cd . && make BUILD_NONDISTRO=3D1 FEATURES_D=
UMP=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j3=
2 O=3D/tmp/tmp.NssFD0ssxu DESTDIR=3D/tmp/tmp.oEuROiOLtI
> cd . && make BUILD_NONDISTRO=3D1 FEATURES_DUMP=3D/home/acme/git/perf-tool=
s-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=3D/tmp/tmp.NssFD0ssxu DEST=
DIR=3D/tmp/tmp.oEuROiOLtI
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
> Makefile.config:952: Old version of libbfd/binutils things like PE execut=
able profiling will not be available
> Makefile.config:968: No libllvm 13+ found, slower source file resolution,=
 please install llvm-devel/llvm-dev
> Makefile.config:1147: No openjdk development package found, please instal=
l JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>
>   GEN     /tmp/tmp.NssFD0ssxu/common-cmds.h
> <SNIP>
> In file included from util/disasm_bpf.c:18:
> /home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h:10:6:=
 error: redeclaration of =E2=80=98enum disassembler_style=E2=80=99
>    10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
>       |      ^~~~~~~~~~~~~~~~~~
> In file included from util/disasm_bpf.c:15:
> /usr/include/dis-asm.h:53:6: note: originally defined here
>    53 | enum disassembler_style
>       |      ^~~~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h: In f=
unction =E2=80=98init_disassemble_info_compat=E2=80=99:
> /home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h:50:9:=
 error: too few arguments to function =E2=80=98init_disassemble_info=E2=80=
=99; expected 4, have 3
>    50 |         init_disassemble_info(info, stream,
>       |         ^~~~~~~~~~~~~~~~~~~~~
> /usr/include/dis-asm.h:482:13: note: declared here
>   482 | extern void init_disassemble_info (struct disassemble_info *dinfo=
, void *stream,
>       |             ^~~~~~~~~~~~~~~~~~~~~
> util/disasm_bpf.c: In function =E2=80=98symbol__disassemble_bpf=E2=80=99:
> util/disasm_bpf.c:109:36: error: incompatible type for argument 1 of =E2=
=80=98disassembler=E2=80=99
>   109 |         disassemble =3D disassembler(bfdf);
>       |                                    ^~~~
>       |                                    |
>       |                                    bfd *
> /usr/include/dis-asm.h:411:63: note: expected =E2=80=98enum bfd_architect=
ure=E2=80=99 but argument is of type =E2=80=98bfd *=E2=80=99
>   411 | extern disassembler_ftype disassembler (enum bfd_architecture arc=
,
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~^~~
> util/disasm_bpf.c:109:23: error: too few arguments to function =E2=80=98d=
isassembler=E2=80=99; expected 4, have 1
>   109 |         disassemble =3D disassembler(bfdf);
>       |                       ^~~~~~~~~~~~
> /usr/include/dis-asm.h:411:27: note: declared here
>   411 | extern disassembler_ftype disassembler (enum bfd_architecture arc=
,
>       |                           ^~~~~~~~~~~~
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:8=
6: /tmp/tmp.NssFD0ssxu/util/disasm_bpf.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   CC      /tmp/tmp.NssFD0ssxu/bench/mem-memcpy-x86-64-asm.o
> <SNIP>
> make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
42: util] Error 2
> make[4]: *** [Makefile.perf:798: /tmp/tmp.NssFD0ssxu/perf-util-in.o] Erro=
r 2
> make[4]: *** Waiting for unfinished jobs....
>   LD      /tmp/tmp.NssFD0ssxu/tests/workloads/perf-test-in.o
>   LD      /tmp/tmp.NssFD0ssxu/tests/perf-test-in.o
>   LD      /tmp/tmp.NssFD0ssxu/perf-test-in.o
>   LD      /tmp/tmp.NssFD0ssxu/perf-in.o
>   CC      /tmp/tmp.NssFD0ssxu/pmu-events/pmu-events.o
>   LD      /tmp/tmp.NssFD0ssxu/pmu-events/pmu-events-in.o
> make[3]: *** [Makefile.perf:290: sub-make] Error 2
> make[2]: *** [Makefile:76: all] Error 2
> make[1]: *** [tests/make:341: make_nondistro_O] Error 1
> make: *** [Makefile:109: build-test] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

Looked like a bad cherry pick, I sent rebased versions of the patches
and an extra small cleanup patch in the v4 patch series:
https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/

Thanks,
Ian

> - Arnaldo

