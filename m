Return-Path: <linux-kernel+bounces-843298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D09BBEDD3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48D934EE15C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580422D29C8;
	Mon,  6 Oct 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSIxygju"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22473285C8D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773417; cv=none; b=pG+aMdiD1d5VP484e8akQrrbciadmwBM627GmIXsJX+RCJeRRBOt04nyyhMtir9bvI9kLO3pjosLx5PWc2xC5TeFC4zwQM5CWwwO1TaOMJWqvOt0+mhA13z6NICxpnXVIh/6Gza/QWf0E139FrneNCPD8H7fFpfkrLVU8t2eb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773417; c=relaxed/simple;
	bh=U9ffjV7BL0HXoD5lEUkf+VHuGrAOPXko+Tm91qRV1X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e81McXhBmOUqhKZCu1+gqfgp1eMjFv8XXBteKEoOWQu1QFRGU04Q4dsd6WM/0fRKe0yursECPgKWdYiLrG3zeB0akiaWs6jHF14vhOLbVNaVJgYbR6ch+0A0KkTuYuC1lEt6gEUib6FPRPlXTWBWM5fc8Ddkq3+pONoVk/l1V4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSIxygju; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2681645b7b6so17025ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759773415; x=1760378215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgNIO/Vg03wOgHjezxsvevp0MBXeQPhEmL6wrOMft2c=;
        b=WSIxygju6iIKEtTrD16QZ/mTgPhebjWB3QpDBPi9iOxLjKN03N+ex5zy72LT10lxgx
         hu6HmYK0RaHXx4bWIqjws7eu1UUf9CXtREfv3gZO2f87EzDF/sWoGIu19A2QWl7trJKy
         JyJPq6j9/RraWr2IaH9W6oDwvaP2hl6M2vfJa8b8scZitJxPfa4629rmECxCn7tmnEBy
         q4tfm1kHpAGC0ODe5BME90UfEapXZtbkXGstmRS+alo9/iiyJ//dL2MfNzdC7JPeKmzL
         gqOcylK59mkZfp+OvEeVcV7Djnx7CmVh6RYjvB8Fz5EDDI9kvuW2eWoRXnNgs7IpWszA
         L6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773415; x=1760378215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgNIO/Vg03wOgHjezxsvevp0MBXeQPhEmL6wrOMft2c=;
        b=dab8I28m0p+7sGenC3E5ZnLXVkVlakI+QM0gbGjqkDPibkCJbt0ymtZMfs2hobvhn6
         E8vvP4zX/PMBFzvr2llwDlrbgKEuHrzNzeaKzCKdKu/Lpr2OA4wZXOtmv/H4hkjYCEtn
         drxIGsRO3h8f9005ym0JWXJO04KSEALEu4sevQhips2erFvTJo/27NHJ9Z8uPoUct2YR
         ceiuyEqkaZ7DUhLapnjmuksO3FeV5Pf/QGf/o4092QKnhTwgAyuUP8thatjX5dEdMInO
         BZ2kmSMmB/ZK9QzU/8Xc5yCDCyC79AhIKLmIekrCRKKJiuQjL32eMttXREWPaRI0hhYf
         +V8A==
X-Forwarded-Encrypted: i=1; AJvYcCXb+wIoc5a//LxAOnoatmtyleqCFoq4jM0OMYtqkvoExS8AMalOckNvyCQpI013h8eCLkCtubTg2s/C27A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ePc/4QPrqKj1ejUlL7ZebHQsl7N8WPnChWJO6Z5yNbhNndcW
	XIMTO3m6NsAOYv5IzoSyflqCeUh4+cHn6v09ZmJIq1OJoTEHilP4BPOuFKdLz5U6aa8eJXFMpNv
	Xq50Az/8qeU+68utKruz1DftmsH/zKzLOUMy03gB+
X-Gm-Gg: ASbGnctKMrkRBx+zHZ8x6wYjU5iIOOI+ov2SdsH/PVx42N5mO7aPgwH0TPgKHdK55dE
	VUD94RUTlh6BM7P1+tlLKahMtrGRhUBV+wf0eFRuCB+8n3N5otwYCnxwPKcCc/8EKafjH6MGVmP
	9EhFT4/RBz4CWcuOv3tKWZUv/IJ4U5tv49OEOpAQoMOh4w/Z7S3nixccgHbiSRNFPb5iF6uz3IH
	zTHH0r4FBt5uBxvFU42KnEJ5X96LRJu9oC4Z+RZyG/DWawjivJMYcy0PnffVxwGJq4yZ1F9dzLr
	GFQ=
X-Google-Smtp-Source: AGHT+IEc0OvHtFH5e8JUnvIJenLMDF0rFXPhnKj1FxC7gkK5Xn2psBR9dBkn9cD2lkoGGsFgB9c6AUjOaYgzf5qGaJo=
X-Received: by 2002:a17:903:3d07:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-28eca40ef40mr356805ad.10.1759773414620; Mon, 06 Oct 2025
 10:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com> <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 10:56:43 -0700
X-Gm-Features: AS18NWBYM4S-kQkaLa4kp8LfC_m-pnaoulSPmNbf8CExHNpB0ol_xCKKyPKhVEQ
Message-ID: <CAP-5=fUVs8Dn+kQDgPW08SNC=W5ZQKMFEETjjqkOJ_Mvbv22dw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] perf build: Disable thread safety analysis for
 perl header
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:21=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> When build with perl5, it reports error:
>
>     In file included from /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi=
/CORE/perl.h:7933:
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/inline.h:298:5: =
error:
>           mutex 'PL_env_mutex.lock' is not held on every path through
>           here [-Werror,-Wthread-safety-analysis]
>       298 |     ENV_UNLOCK;
>           |     ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7091:31: =
note:
>           expanded from macro 'ENV_UNLOCK'
>      7091 | #  define ENV_UNLOCK          PERL_REENTRANT_UNLOCK("env"...
>           |                               ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:6465:7: n=
ote:
>           expanded from macro 'PERL_REENTRANT_UNLOCK'
>      6465 |     } STMT_END
>           |       ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:865:28: n=
ote:
>           expanded from macro 'STMT_END'
>       865 | #   define STMT_END     while (0)
>           |                                ^
>
> The error is caused by perl header but not perf code, disable thread
> safety analysis if including the header.
>
> Though GCC does not support the thread safety analysis option, this
> negative warning flag is silently ignored by it.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/scripts/perl/Perf-Trace-Util/Build | 2 +-
>  tools/perf/util/scripting-engines/Build       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/s=
cripts/perl/Perf-Trace-Util/Build
> index 9b0e5a8b5070f1a1640518fae75557f824ef21ee..01a1a0ed51aefd721b4bc7eba=
728c29a8ffcd551 100644
> --- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
> +++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
> @@ -2,7 +2,7 @@ perf-util-y +=3D Context.o
>
>  CFLAGS_Context.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-str=
ict-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno=
-switch-enum
>  CFLAGS_Context.o +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-und=
ef
> -CFLAGS_Context.o +=3D -Wno-switch-default -Wno-shadow
> +CFLAGS_Context.o +=3D -Wno-switch-default -Wno-shadow -Wno-thread-safety=
-analysis

I wasn't able to reproduce this on Debian with perf-tools-next and:
make -C tools/perf O=3D/tmp/perf DEBUG=3D1 CC=3Dclang CXX=3Dclang++
HOSTCC=3Dclang LIBPERL=3D1 clean all
but my libperl is 5.40. I'm a little concerned that the warning may
cause an unrecognized compiler option warning/error with GCC given
progress on thread-safety-analysis has ended there. Anyway, these
aren't blockers.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
>  ifeq ($(CC_NO_CLANG), 1)
>    CFLAGS_Context.o +=3D -Wno-unused-command-line-argument
> diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/sc=
ripting-engines/Build
> index 2282fe3772f3bdc35056cb5e66efb3462dc1c2e3..24f087b0cd11b3e06a338c394=
dc2c650bc2c60b1 100644
> --- a/tools/perf/util/scripting-engines/Build
> +++ b/tools/perf/util/scripting-engines/Build
> @@ -3,7 +3,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>  endif
>  perf-util-$(CONFIG_LIBPYTHON) +=3D trace-event-python.o
>
> -CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls=
 -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-exter=
ns -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-a=
fter-statement -Wno-switch-enum
> +CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls=
 -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-exter=
ns -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-a=
fter-statement -Wno-switch-enum -Wno-thread-safety-analysis
>
>  # -Wno-declaration-after-statement: The python headers have mixed code w=
ith declarations (decls after asserts, for instance)
>  CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-d=
ecls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecat=
ed-declarations -Wno-switch-enum -Wno-declaration-after-statement
>
> --
> 2.34.1
>

