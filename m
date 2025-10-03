Return-Path: <linux-kernel+bounces-841765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8999BB82FF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37434E8991
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AE265298;
	Fri,  3 Oct 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aorZwbA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB022571BA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526963; cv=none; b=EZj7PmYFPtDhDW7+jU6GylNJ+HvBvNAmzh7YwaYnygwJOYSfQF/5hWIaN5i2b4qgc+9TcKjHTY+1tgjnrQuLXPRMkJxC10P/H4hUXRq2jd5gYjlkvUhyaW0cSNhbL6std+6XZOPMb+rj+uC2EVT9pmb+Xtluoo+zfmcip7/QRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526963; c=relaxed/simple;
	bh=sgCLR2ngapQNLouWMOBzkBY/LCsMsAk0k5g8Ou9XOII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXOhGueGNFw282gWJ8h1MdKsd+UML18d0h2yrvlrOTXTJUC83PjWqftboSpYk2Sw3rpo49s7XRSpVN9/iV1Cm2DMFx4NZvRoHqolwajFF7I1cFcUvnwtEjx8ygOdphmc+gnzvSXL/NVIqgAWD2kl7OoDWINvOAbB22Bdc0lvCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aorZwbA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so22085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759526961; x=1760131761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9VRi3EH24xBcxIT9mshnPJiIjgju22iBD0ykQ5/sxM=;
        b=2aorZwbAXX68+MXVgPmvCfhv4jEkNdI8P2SEUuAFRkKtw32p+yGosSsrAXRrQUk4XP
         jQxW2slUmMzmOAxwFTUou5iqmN/moFDfe0DhB5vHkbUZc7HZxI4OdVsfrzR4VF2dQrn/
         em1xYW6dMWvZfpzGhXnTaL2o5NI1lGTGFd3zHechaiDYiMNsUmP21oAVqBUpfcR0/6Zo
         0yyJ4u8+XwrkROX9C7gvje+LVKe5NrmOboM8ftRBA/EG2y7212bJx/lEOp8vHb18hMTb
         JZjAFn28RwzbxMpNOAQ4ibXAL99MXKuv2nMc1gtmBiUVxhRuyhgh8s/2UOblddLLLmsj
         tQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759526961; x=1760131761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9VRi3EH24xBcxIT9mshnPJiIjgju22iBD0ykQ5/sxM=;
        b=ryZKaB2CgZXnpRIpjPLS3rhpre4HseSO1J7MhT+hB7clZ5ABYy+RdDufStkfbRSd26
         aE50cx1aY3DlcRk3V0B8b37nArn8ADly9vzjUDfSNtQTYHR6uD+TZZLNRxqmIdCoFLcp
         xwxICp0m95WIem99gT3MtuivtEyvLmzvxsTCKX/TCKcuBBwoDtRrH9hzm5nif2SbIejs
         lvK5Uy1syzlDzEY5W+Dmh6+h0jLf2LJ0YpNpUl/EVd7XnnrWiDp+oa52CAB5Z6LUGpcW
         5+V1zJ4VU2dTlqVQDcUqMOSdzjHB2Xv+VFc/ES/XEpa45Y3vnxjWM7ta6kStzg9GfdXz
         o1zg==
X-Forwarded-Encrypted: i=1; AJvYcCW6gX4r+hkE8L81WLPh19wmLR+D5tQ1TCHjFkZyyKX1Objdf9xPLQuEhzI5RrCfy640aDofohMtaVQ8m4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCru0pWuCDymkq5qOmVHlNMaFc5QgdJPXzlFzXt9GW3wzfsylG
	L8kGDEcyCApzwIQlwbzhceh3pJQTvP6HspBzmiMb0jopcVw5OqZFEWvSO1O+ha9nWqZTJ8UWHuG
	pbzIWCc0/GQcpA6ePgOlozNGo6HkZ1AaWnjAbJeKE
X-Gm-Gg: ASbGnctVv5t0fNMfNEbOpQfZKsOL4xkfNGVuaXrXjkP60TjhXeEwekzhaJNHLGSq9lb
	IcpG+NQCywTT1ZQzykDSQGd1pmztJsBQr+vUDGtNUNmk6+8IqZ02UPKsTAiFPIjNhYqNM2UvV0o
	n0rO7gIihPo2BQoDqkgkPzx2MxLj5+YgAVyBRA559wYUFjj7GutBQ9m+z/gQXlf8xD+LBgiOTQr
	QoJ2lrPTIzJwsPmfshadZoT147HUXQ9d7zRnzU=
X-Google-Smtp-Source: AGHT+IHUleMTSV8OFBZDxUEi0C1/AcmU8XAZJZPNf2qZ0+XgxlY77yPW07NAORzho2z6VXpzlcFrk1fhQ/DDZCDalIA=
X-Received: by 2002:a17:903:3c70:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-28ea7f48339mr1229385ad.10.1759526960554; Fri, 03 Oct 2025
 14:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003175613.2512296-1-irogers@google.com> <20251003175613.2512296-2-irogers@google.com>
 <aOAoc0-Oy99l3iQG@x1>
In-Reply-To: <aOAoc0-Oy99l3iQG@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Oct 2025 14:29:09 -0700
X-Gm-Features: AS18NWCd15Gjm1sQjDY-vazJTUi06ucepjQjCnk20HrbpaC4TLu776xKUu3Fsmw
Message-ID: <CAP-5=fXVVg5BC-q85i4s8Phdp86UYEKTaKHcb75W76LdSa+_7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools build: Remove get_current_dir_name
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Oct 03, 2025 at 10:56:13AM -0700, Ian Rogers wrote:
> > As perf no longer tests for this feature, and it was the only user,
> > remove the feature test.
>
> You forgot to remove this:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git diff
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 71ba7001dc25c6bb..8a354b81417c6fcc 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -151,7 +151,6 @@ int main(int argc, char *argv[])
>         main_test_libpython();
>         main_test_hello();
>         main_test_libelf();
> -       main_test_get_current_dir_name();
>         main_test_gettid();
>         main_test_glibc();
>         main_test_libdw();
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> That results, when building with this alias:
>
> alias m=3D'rm -rf ~/libexec/perf-core/ ; make CORESIGHT=3D1 -k O=3D/tmp/b=
uild/$(basename $PWD)/ -C tools/perf install-bin && perf test python && cat=
 /tmp/build/$(basename $PWD)/feature/test-all.make.output'
>
> that needs to be on the makefiles somewhere, shows that test-all.bin is
> failing to build:
>
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>  88: 'import perf' in python                                         : FA=
ILED!
> test-all.c: In function =E2=80=98main=E2=80=99:
> test-all.c:154:9: error: implicit declaration of function =E2=80=98main_t=
est_get_current_dir_name=E2=80=99; did you mean =E2=80=98get_current_dir_na=
me=E2=80=99? [-Wimplicit-function-declaration]
>   154 |         main_test_get_current_dir_name();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         get_current_dir_name
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> I fixed this up already,

Sorry for that. Thanks for fixing it up!
Ian

> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/build/Makefile.feature                    |  1 -
> >  tools/build/feature/Makefile                    |  4 ----
> >  tools/build/feature/test-all.c                  |  4 ----
> >  tools/build/feature/test-get_current_dir_name.c | 11 -----------
> >  4 files changed, 20 deletions(-)
> >  delete mode 100644 tools/build/feature/test-get_current_dir_name.c
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.featur=
e
> > index 9c1a69d26f51..9399f591bd69 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -68,7 +68,6 @@ FEATURE_TESTS_BASIC :=3D                  \
> >          libdw                           \
> >          eventfd                         \
> >          fortify-source                  \
> > -        get_current_dir_name            \
> >          gettid                               \
> >          glibc                           \
> >          libbfd                          \
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index b41a42818d8a..d13d2a1f44fe 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -8,7 +8,6 @@ FILES=3D                                          \
> >           test-libdw.bin                         \
> >           test-eventfd.bin                       \
> >           test-fortify-source.bin                \
> > -         test-get_current_dir_name.bin          \
> >           test-glibc.bin                         \
> >           test-gtk2.bin                          \
> >           test-gtk2-infobar.bin                  \
> > @@ -147,9 +146,6 @@ $(OUTPUT)test-libelf.bin:
> >  $(OUTPUT)test-eventfd.bin:
> >       $(BUILD)
> >
> > -$(OUTPUT)test-get_current_dir_name.bin:
> > -     $(BUILD)
> > -
> >  $(OUTPUT)test-glibc.bin:
> >       $(BUILD)
> >
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-=
all.c
> > index e1847db6f8e6..778883a32afb 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -22,10 +22,6 @@
> >  # include "test-libelf.c"
> >  #undef main
> >
> > -#define main main_test_get_current_dir_name
> > -# include "test-get_current_dir_name.c"
> > -#undef main
> > -
> >  #define main main_test_gettid
> >  # include "test-gettid.c"
> >  #undef main
> > diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/bu=
ild/feature/test-get_current_dir_name.c
> > deleted file mode 100644
> > index c3c201691b4f..000000000000
> > --- a/tools/build/feature/test-get_current_dir_name.c
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#define _GNU_SOURCE
> > -#include <unistd.h>
> > -#include <stdlib.h>
> > -
> > -int main(void)
> > -{
> > -     free(get_current_dir_name());
> > -     return 0;
> > -}
> > -#undef _GNU_SOURCE
> > --
> > 2.51.0.618.g983fd99d29-goog

