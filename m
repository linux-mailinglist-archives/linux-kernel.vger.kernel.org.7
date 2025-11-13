Return-Path: <linux-kernel+bounces-898601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6394C558EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65F53343B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083E3002C2;
	Thu, 13 Nov 2025 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJP6Dw7o"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA02877CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004270; cv=none; b=IRq6xbzMowyUO4D8pqbzDN/GaULGfRl5UTACo1NM+KNzhO3Vwfdw4pzngohOy4sj24KTLzTOWCx/sYavciKH6kDDyOgNh8h/pJkysOJFDSzlaccXwFt21yTFr2xjOPc3KyT1aaLRUiJEYTNxiMSKqRv0lt/G75GR+3M9oimcQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004270; c=relaxed/simple;
	bh=w19LmHl9EzPoq+VagsivemZSdZB3oysJfy50JY4ePY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2losKM0g7m8zJ1Bgpe0R8y4NGG1iHqsPgbEoFEoHRTvs25ZnORA+KltEnjXjzioUGsWg4XC9blPRig0L+pGl7oegDjYPQzY16l8NJdc5BpdqX5D5q0Zt6d3IPl1GDjaYNNUBdYwJuUD9QOwGS8CT3kJTBnj4kZzX0QccrQ3qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJP6Dw7o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e13bf404so107605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004268; x=1763609068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGyRfQ7sxinUKyVvjsR+Vqj6OVZ9Yu2U/bhjn87KrGg=;
        b=hJP6Dw7oqVNrhg1lKL3H5OLVdY1uhO1tC6VnPHqHtPBr4TAW+FrtzCO1T2pUeIKGb+
         Y5DNrJpTAZ1qu4HSOQexkPscc5bYoDMwTAs2UHkhr4tIlXYmJc95X6LN4OPKmCg9/sZb
         VG/VnERPPln2XGhmGgU0nXN3Mk0hA7mY4b3/fFFF+63qNtg/6yskv28tdFYY+Ojv8U6u
         hlws2FiuIiTUT0pOwFD9ByAVHsY0yiKTvfB9H05hGYmdQCSKx/Vlew0leTvM75SL6owb
         eBCoDOURkl0vmCaKiKBIDtXnd4YbMktY/u8K2wumY/X/tsVf1JCTS2h7DRY4kjJCI0Xu
         bm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004268; x=1763609068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGyRfQ7sxinUKyVvjsR+Vqj6OVZ9Yu2U/bhjn87KrGg=;
        b=iY+Y01Eu0B/b7nPR7Dv2dkUF69+24P9/x09SR/vXofGhK/hPWiuuOFjxQiQxJU9fTX
         if6l6HjVBCQVc8WEmsoAtaLlB5sIudypbwakT/I/Xa//l6ocgw4HQmD4+lS3EJCtHale
         w/1mI8WuaDkv3h/iNR31/viL0aPUg3nP7EvZHprtA/4P5XXamxYa0N4gPN0Qud3aZ/aM
         5aGjGYibwaao66350R+V02RVmrUivb8/FqXPb88KFQ/2sSYjF2JHl2L2LNgnj+Zy5o5I
         vUhuye4s5ouecQ+Oa2InEP7nQnn/27ahi1ErrdL1M030BGlLKIXfk9Vly7wzr0eNhXnf
         hUNg==
X-Forwarded-Encrypted: i=1; AJvYcCWL60wMZJVn3v/KrpcenZqam2d7qPNuNh5hA7G3vE99UYCotio+fefudLSm7aoeUYy94vw6P6UR2Wb1O80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeweb/84A01/YLPauVNmzqM3d7x80DkDURPOT9fRy/h2h3CkI
	IU3ORVYdDc8k5MAeEovMBWyRCCVgN8mqrAwF2SR58MGP0GPpsCekpsl1UplW5UZB5vOIrdTcFsj
	+688FJfGbXJRKG/S5sp/AY60Yap4iirBPyDW05M9im01DBa3LiTVU5H5Z
X-Gm-Gg: ASbGncsZycAFAWuRkwZ/wEyo8hTefY8ZXY9zJpCj1CH9nNmElAhcbUCdIttGE0R9Lbi
	E749k4NQAwNdxdHBH0EPNpr8lpkNP6Ihiy+BoAkXgYl3tsAovME06NBrnFaQg+df9rXgOGyvTwB
	CAGIDpw+2f2HPEXtFNEsikqkMt8BYUiRiQzToaq/Mt7gjFL1fmJ6qtB0pLTBeknW3KsU8Se/9ZU
	WlySBvpDlN7TUJa3reuWjXDLO+d63q94lwp1pfY49Z9cs59dk+4BYaWBkOoJEwKzg79ws+R
X-Google-Smtp-Source: AGHT+IET2jzGv22qFGYzYgBvGvfIe5eJnj7IAX2cABZdqxy9Xi0Ge1lrllrdq2zKbFwAYFKpEx3lgnkNxvYprRHLu0s=
X-Received: by 2002:a17:902:e746:b0:290:be4a:40d2 with SMTP id
 d9443c01a7336-2985c41ca40mr1781765ad.13.1763004267309; Wed, 12 Nov 2025
 19:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRUs5Lp7RM2qx1Gl@x1>
In-Reply-To: <aRUs5Lp7RM2qx1Gl@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 19:24:16 -0800
X-Gm-Features: AWmQ_blvZBbQKrOg0P6KfvzAlgf6prkDH91L0xaddiPExbWTy0XYsLDKlYlOGgU
Message-ID: <CAP-5=fUtdjaGHCQBNGuVfq7AYMsk67m1zhtrAwsbcwPSvDEr3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Don't fail fast path feature detection
 when binutils-devel is not available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.
>
> This is one more remnant of the BUILD_NONDISTRO series to make building
> with binutils-devel opt-in due to license incompatibility.
>
> In this case just the references at link time were still in place, which
> make building the test-all.bin file fail, which wasn't detected before
> probably because the last test was done with binutils-devel available,
> doh.
>
> Now:
>
>   $ rpm -q binutils-devel
>   package binutils-devel is not installed
>   $ file /tmp/build/perf-tools/feature/test-all.bin
>   /tmp/build/perf-tools/feature/test-all.bin: ELF 64-bit LSB executable, =
x86-64, version 1 (SYSV),
>   dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
>   BuildID[sha1]=3D4b5388a346b51f1b993f0b0dbd49f4570769b03c, for GNU/Linux=
 3.2.0, not stripped
>   $
>
> Fixes: 970ae86307718c34 ("perf build: The bfd features are opt-in, stop t=
esting for them by default")
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/feature/Makefile | 4 ++--
>  tools/perf/Makefile.config   | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 49b0add392b1c11a..95646290cb89cda3 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -107,7 +107,7 @@ all: $(FILES)
>  __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c=
,$(@F)) $(LDFLAGS)
>    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
> -  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-DPACKAGE=3D'"perf"' -lbfd -ldl -lz -llzma -lzstd
> +  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-ldl -lz -llzma -lzstd
>
>  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bi=
n,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
> @@ -115,7 +115,7 @@ __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o=
 $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>
>  $(OUTPUT)test-all.bin:
> -       $(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
> +       $(BUILD_ALL)
>
>  $(OUTPUT)test-hello.bin:
>         $(BUILD)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5700516aa84aec2c..2dd5f5a60568d002 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -354,9 +354,6 @@ FEATURE_CHECK_LDFLAGS-libpython :=3D $(PYTHON_EMBED_L=
DOPTS)
>
>  FEATURE_CHECK_LDFLAGS-libaio =3D -lrt
>
> -FEATURE_CHECK_LDFLAGS-disassembler-four-args =3D -lbfd -lopcodes -ldl
> -FEATURE_CHECK_LDFLAGS-disassembler-init-styled =3D -lbfd -lopcodes -ldl
> -
>  CORE_CFLAGS +=3D -fno-omit-frame-pointer
>  CORE_CFLAGS +=3D -Wall
>  CORE_CFLAGS +=3D -Wextra
> @@ -930,6 +927,8 @@ ifdef BUILD_NONDISTRO
>
>    ifeq ($(feature-libbfd), 1)
>      EXTLIBS +=3D -lbfd -lopcodes
> +    FEATURE_CHECK_LDFLAGS-disassembler-four-args =3D -lbfd -lopcodes -ld=
l
> +    FEATURE_CHECK_LDFLAGS-disassembler-init-styled =3D -lbfd -lopcodes -=
ldl
>    else
>      # we are on a system that requires -liberty and (maybe) -lz
>      # to link against -lbfd; test each case individually here
> --
> 2.51.1
>

