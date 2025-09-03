Return-Path: <linux-kernel+bounces-799042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB6B4263A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C9517CEF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7F29A9FE;
	Wed,  3 Sep 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUyKxGU3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA32BCF5D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915663; cv=none; b=A8w72BW/e8WtV0RjM5heSlTl56TBMWOnvkCu2uO3Nji7k72N0+fIwxY45rYBqKzCC19IzwRrhVZtMev6NiQL9oJBbza04D/qni4iQjmoNuOZZ+acc2RPBRkvYiBCPlCv9I85Opq3I9VXgybNhld7Udm7lztdjEes2Oen2bMjiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915663; c=relaxed/simple;
	bh=OFtpyMYJm0RX/dGSDrdWjsxAmihpdsSEchmktPlLzVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDS+zZn55KAg9sIjt2TBHDlsWxLYfjjcru/t1jArL3dC74sMW+7FWMdajqCAKESfzaOFrnuB4Ngn+hy0rYRgfidZkFSsgTM+rR7AhM/fJI/X3dCFoVXBjTA8SLLy1SkMFN3RW0jqslHbidYH2XIVZghHvmTtBKkCJ8LtLzhOVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUyKxGU3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b2d018f92so187455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756915661; x=1757520461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6FyRX3RqQ7uAdygDY5zFdlCnnOh0ERjuiJ9MzY3XoQ=;
        b=zUyKxGU3YT1A0p5UIY09jBfiO3bP9THtEqfxb4+nV7vpB+ZDGkCRNmufhNyiMTFjpm
         vY76kyOX4o4ssHWM3X9L7JCNTi7p/9+/5dJLOLcvgfRxhT2bkCq8hstIEb3HuZxLOyVZ
         IQjcdKLhCy5uUxyINGgHhWPdmM7vEqIVHJb0vLsF6g6ER9n10jidgQNzkqSl1HlYj135
         wGpkLsAVgLsZhVVoIGOo5Q5APirKdFkwFkVRvd+BzrLB7P+TW6Qba70EUZ0KlsA7OXgR
         GYAsAII1PAEKMrTQGY2XE9tICnPcRjl77E2KWSkbAP6EzKS2ogxsgcFXXQM/dvXtO9fQ
         lstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915661; x=1757520461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6FyRX3RqQ7uAdygDY5zFdlCnnOh0ERjuiJ9MzY3XoQ=;
        b=pKu8LY6mTsDPIzPZw0do7KvzyqrkWZ8obKGsPTwCmlRQumpQj2omeagLo2YHv8qBtA
         Ds8LnEN3cKS8XhvTBSuBGvD+U7Ul+XGxNPMbunR80TnXKY7ZbObkYY7PWDL9XmIRWdE3
         yjFOY3Ac/NCbKH/HXJJ/pqi4aLPRiWoliF3v70aeI6JxvJKTliuHWn8ynqYtPgfDDyrH
         Nf1qmLsETZs7xLHCHRDxuFoIpsBejSodfX3/fYKfp7ARHxxj984lzHDl0UKknP1AUZQ+
         W8J3gXBsGwKStUg7ncrRZOuFx24pNRTdGyuTqONT77Srm3BelwxCRCwWneFOYigQTClw
         nDoA==
X-Forwarded-Encrypted: i=1; AJvYcCWdEgObnwtB3Fc2sHKyL4rKWMMlaeRhholyJsYfj/CoZxEY4uTA5qfx+JoskMJAxq/mqhwfhWTj556BaJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2wmxYH4/H3TVqU4yhWiiWDEKDoXwe/zOjuF9VewRPqhxrvUi
	ZowhR9tIiOOh3oZ5UTqo+gKkrRpO0f3PjXH1N8PKrMCpJTphGyns4MInrY7MnavD4G6WQ20f/Eg
	K4NB8tMJ9SMwSoI3mTRGT5rrQU1TWOq/fI649avay
X-Gm-Gg: ASbGncteol6WWLLWyOlSEZnm3Pt0/KrH+mPOOvQJfuTNCzj3oW9WTNkdCBNSqjnyD4q
	7Izt4VVLazX0olcAQv7ucNTl26d00tVYxx7WlpWc5b1DnVK8+rs3gzci320Hi5C8JUKZ1Kcp/Vm
	mm7EwvpMZDOgFT7hA7hqn5aVyivPXR6MNZ/nKxleGgD3zpz2jqpw/X2LCaK+2xdj5ckU45ETrFX
	Kb9MdkzsaKVWJsV2/jFkTvVy8hLIyess8lBcMrJbUA5
X-Google-Smtp-Source: AGHT+IEdKqM0yI9d3FegODPcz8GkpOP5O8L0IfPsJctIDdNBeIqC8u1dG7wD10gYweodKVqqZ6RoslvzScA9OsJ9oYk=
X-Received: by 2002:a17:902:e802:b0:249:2caa:d5c9 with SMTP id
 d9443c01a7336-2493e95f176mr5989925ad.17.1756915660778; Wed, 03 Sep 2025
 09:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:07:29 -0700
X-Gm-Features: Ac12FXzP2PTUXzu2aYtuKjZooEp21EjqaYSgWFDnBx0sI44DuB4kcoiVcARy6Kw
Message-ID: <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: James Clark <james.clark@linaro.org>, Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> read_build_id() now has a blocking argument, but libbfd uses fopen()
> internally which doesn't support O_NONBLOCK. Fix the build by adding the
> argument and ignoring it:
>
>   util/symbol-elf.c:964:8: error: too many arguments to function =E2=80=
=98read_build_id=E2=80=99
>     964 |  err =3D read_build_id(filename, bid, block);
>
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__rea=
d_build_id")
> Signed-off-by: James Clark <james.clark@linaro.org>

Libbfd should go away:
https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
but I can imagine that currently this is hit in a build test - sorry
for missing that and thanks for the fix!

We should probably honor the blocking argument (use fdopen) as the
probe perf tests will invoke perf record system wide with data pages
and predictably hang on this for files like mmap-ed in sound devices.
That said, maybe this hanging will serve as an indication not to use
the deprecated libbfd code. From the sounds of things this will break
gentoo :-(
https://lore.kernel.org/lkml/87ldnacz33.fsf@gentoo.org/

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 033c79231a54..e0d6ff7d0acf 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size=
_t size)
>
>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>
> -static int read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid,
> +                        bool block __maybe_unused)
>  {
>         size_t size =3D sizeof(bid->data);
>         int err =3D -1;
>
> --
> 2.34.1
>

