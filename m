Return-Path: <linux-kernel+bounces-839366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92ABB17CD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC43C1171
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBD2D46B4;
	Wed,  1 Oct 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8xZiLX1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FB2D373E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343354; cv=none; b=Lu9Nobq0X3D0RkpXDJIQFJUMnO+7QQOMQxp51k8Hp8uAEsij/eKczRm6Y8wdZ4p+vnpsExpNg5FKTys4zioVFuLG5zifjwMiT/RPHipZ9vSC5O5xabbOtPyC84/NJNIfSXAuygm7EuectDufWfykGh0d0SRd2kFDzxZcjGfj6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343354; c=relaxed/simple;
	bh=2c8vydE0j87T+FcdTUxthuP+NglO3VV4kLkIFoVtjWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ083YOCL7ZeRqpSESogZwaxtUuVaGSc894pi//vTTLBvxxM7zC2uenOKwtDbcvgLJ5kNaCJzNqh7eyRxls6tGwob3nppeUPtb2m7b5I5UGeqqiFc9HSw7LaMpPuEytdek5jJLXynVg0AiQ8c39BquZ0B7UHlx4A9k4OPtfmOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8xZiLX1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2681645b7b6so23245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759343352; x=1759948152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sFyW1u/7NQyxS9RW2mJInFdcUP7OWrs8+QrbdBdhZc=;
        b=a8xZiLX1wpas0TmhRFEMUj9CDtr5QM/ehjsMzYYb1xo3HWb3JilTIz4NNQCkob0eHS
         zOO2ZKnG2Kp/2CgbvPLmryrJYOIcMuvlSGI2oj2UpogMSb3cOiDuTbfu3XzxIcHfPh5a
         HzIB+V71A+J+nQHELSiD0KGcrAd69oZWq40B2GAFvqyAvgAt5WN2XUXZc8rEODMC7mD9
         m3rD713MNqUGKaJ70UZVtfco4y8u0E9goIVHTGcZSjraQ8YkEAdMZTKXVA4P5vikBXrP
         jEWt8yLcsCR81zqw4DKjM7tSVnzym3Me7Hi9PK9uedGcfj2uKmbGYs9U25pdMj/CDyZb
         N/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343352; x=1759948152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sFyW1u/7NQyxS9RW2mJInFdcUP7OWrs8+QrbdBdhZc=;
        b=gXXHRti6pN+l8PYsmKB6GcmWTzaQJJGc43sUkdoUHdApfGxBxV8FzB88v2vDLeDIGi
         74RhO3BxI/2vQJbkpZHLg5A2cz+pnq3o6DbNn49tafHwphi9j7e483GpxFEQun7dfVLa
         uoNyPSWoX+IEkR2OceZft8g6pWyxvJJf5id0KJzc5lbps7EMUfdnzKbgJist32ylwI+H
         MIK/VGbRBlXQW4u2J0go33VM3FhcfLm9mH/PEheaj0WdjtnLE6TM74YxuOni0yMtBD25
         lMmCkaISf+JCJ1LWmQRevDDvam6jUsImsKCk3zWLkvkJIMqd59xyVvB6TqH7LGb2BijP
         cgWw==
X-Forwarded-Encrypted: i=1; AJvYcCVb/W4b2ISehCnsNtEFmtQrXn8nESO+pQsDSKd2K3Z+pNCkLDVCUZqlsBTcrEXODks2w9JrY+0TbTkSVHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdLQ8oXxeT+XTiV2f6kWV3kT/4iLsIkLBQWi7ljLQfES5Bc7v
	SVfpH7c1VI8kpFs5JlzNXCdPbesSa2Q30ttsyWaIWGekGyZVVt5BIXdG8NUfBhrW2spuW54VB2V
	GWLekNGESX2EZBqMQqK7v7I/dASWe04ZX4MOp263P
X-Gm-Gg: ASbGncsKysFJTAtBmOceO0sld1/vsmCfFBLhxnXdiyu6tl+eh4tab4eu+Cv1Qzjuxve
	Dn1fwaC/teiI0LabnKNtgexSzVQM3G8RHboXWZ3n1zOp/conxcnz/h2LLdBY3IqeCYVUPgUDXqA
	ezH4qAvX6PzZoWJSoNU/JWoxRsLQP2wvcPDvGy8dgvmft/5hS/wQHjxYFXoJ3RpydbTF3Pt7p59
	S4YVe3N1DVebfq5HtftAzWv6NSJjoq8nBFwa0rP7eInvEtbYkQ5Q+dlhRQ0+QbGlBNM7B2k
X-Google-Smtp-Source: AGHT+IHRK1oSaJYeZTutaeOHMNBmswKw5Ta59S5jssXGLeK3yX/NcJR/iXqcSgW8S6E2nWJ913NqPBCv2Egy1EX0ZtY=
X-Received: by 2002:a17:903:3c2f:b0:264:1805:df20 with SMTP id
 d9443c01a7336-28e8d954347mr597755ad.4.1759343351170; Wed, 01 Oct 2025
 11:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com> <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
 <aN0vu4yoVWjmTbtJ@x1> <CAP-5=fX46C2A22B1TBSgNb0BR1BumvqQeZvaFbU=9OqHmYPqrQ@mail.gmail.com>
 <aN1xiDKUpNw83h8B@x1>
In-Reply-To: <aN1xiDKUpNw83h8B@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 11:29:00 -0700
X-Gm-Features: AS18NWCocfBeNVJIfR9A0FtB4zrLhjvYZ5y1o6oRjlzwuHyCmI9jqKvhuwN7VCU
Message-ID: <CAP-5=fW_zZ8GuWYb5gn7skijz1igQawztfew9puVZGSKTyWaAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 01, 2025 at 07:55:12AM -0700, Ian Rogers wrote:
> > On Wed, Oct 1, 2025 at 6:42=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> > > > On Wed, Sep 3, 2025 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > The 'import perf' test needs to set up a path to the python modul=
e as
> > > > > well as to know the python command to invoke. These are hard code=
d at
> > > > > build time to be build a directory and the python used in the bui=
ld,
> > > > > which is less than desirable. Avoid the hard coded values by reus=
ing
> > > > > the existing shell script python setup and determine a potential =
built
> > > > > python module via the path of the perf executable.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Ping.
> > >
> > > There is another patch in this area to make it work, right?
> > >
> > > After applying this one I get a failure, only when I set PYTHONPATH i=
t
> > > works:
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ export PYTHONPATH=3D/tmp/bui=
ld/perf-tools-next/python_ext_build/lib/
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf test -v pytho
> > > Couldn't bump rlimit(MEMLOCK), failures may take place when creating =
BPF maps, etc
> > >  88: 'import perf' in python                                         =
: Ok
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >
> > Hmm.. if you are running from the install directory then I guess the
> > assumption should be that the install bin directory is in the PATH,
> > lib in LD_LIBRARY_PATH and PYTHONPATH set up for the directory too? We
> > could have the script look for a python module going from ..../bin to
> > ..../lib and fix the PYTHONPATH for you. Wdyyt?
>
> I reported it more in the sense that something that was working before
> stopped working but having not yet tried to see why it stopped working.

Not working is not good. I'm not sure what I should do for the fix.
Aside from cleanup I was hoping we could get this working so that we
could start testing things like ilist.py that depend on the python
module.

> Another thing that I just noticed that may be related:
>
>   35    97.47 fedora:rawhide                : Ok   gcc (GCC) 15.2.1 20250=
924 (Red Hat 15.2.1-2) , clang version 21.1.2 (Fedora 21.1.2-1.fc44) flex 2=
.6.4
>   36    36.81 gentoo:stage3                 : Ok   gcc (Gentoo 13.3.1_p20=
240614 p17) 13.3.1 20240614  flex 2.6.4
>   37    77.37 manjaro:base                  : FAIL clang version 16.0.6
>       AR      /tmp/build/perf/libpmu-events.a
>       LINK    /tmp/build/perf/perf
>       GEN     /tmp/build/perf/python/perf.cpython-311-x86_64-linux-gnu.so
>     /tmp/build/perf/python_ext_build/tmp/git/perf-6.17.0-rc6/tools/perf/u=
til/python.o: file not recognized: file format not recognized
>     clang-16: error: linker command failed with exit code 1 (use -v to se=
e invocation)
>     error: command '/usr/sbin/clang' failed with exit code 1
>     cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No s=
uch file or directory
>     make[2]: *** [Makefile.perf:747: /tmp/build/perf/python/perf.cpython-=
311-x86_64-linux-gnu.so] Error 1
>     make[1]: *** [Makefile.perf:289: sub-make] Error 2
>     make: *** [Makefile:76: all] Error 2
>     make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
>     + exit 1

Hmm.. maybe that relates to Leo's changes. He modified the clang
options in setup.py which this aligns with.

Thanks,
Ian

>   38   130.27 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 15.0.7 flex 2.6.4
>   39   119.76 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 15.0.7 flex 2.6.4
>   40   120.03 opensuse:15.6                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 17.0.6 flex 2.6.4o
>
> - Arnaldo

