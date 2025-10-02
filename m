Return-Path: <linux-kernel+bounces-840400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8ABBB44BC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EA619C033E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AD61A08A3;
	Thu,  2 Oct 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVCkjtH7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D519C556
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418482; cv=none; b=T5FrJDiYECNo/VrccQj7cUO2cmxUjrE7sL0gnDpwt3eWuZgPqmBESl1qYtA+a/kN+Ocn05P63nMtYzM0+/6xMjvY/BmI5OA4Vh14r0SHoSXAk9Ll4xVmcEy9RFmPCbOGC5gtFLF9oUNTbOUCWRjXRrYHv2ikQjV1BAGGnniNkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418482; c=relaxed/simple;
	bh=au0L0L5y1Va8qmlbtxSp7z32qjebxGENjTcKRT+huE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT1rNILlNP69k8lTrijTqQUSce8eq3xWk5p4rX7StJnJUbkT+gHvuQyl3r3Oo5F8TW9Hyby7Iz8F5VQcxvIf8D7flWoRAftpI+wx6l4bqjkecHPiR6F5bhdhOhb5yEA+VLCDEzV+Ggknx322fnupi+Xd3Pbl+sWiZTIbORIgq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVCkjtH7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2731ff54949so168665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759418480; x=1760023280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzuD0Qbpcsv+bB7o0y2z3UTAxu+Q+U8P/zH57agUqr0=;
        b=mVCkjtH7bB0qQcEEd0z+KSdSCYOneexJwUTHNHhjPtCPNMhVv530Jl1KnGoYzbTkDJ
         IHqc8kfNsjTq8txZXfiIjKh4b4EUeaD0k1EU5+hQbpis2jyJaPLjUmrB3jPVHMZ7rC2z
         dUhAc5L9UHxJKmXL9UAsW6U5g+J0r7YB3XIkjkPNx4uaYxkrZ2xMmL3yhAknSghiTOZz
         oiWRYV0GuzB3XTm8Ie0513rLicaecsCUEDYybcUNxlsg7woqne02iwDlD7TdWiWtEyWI
         TfIuH9UrRFRUiBD2eJ4nbnHlr8I4zXoJkHovCaSCGKSoljRhnGPWKiyLHmh5belU+eq6
         cX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418480; x=1760023280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzuD0Qbpcsv+bB7o0y2z3UTAxu+Q+U8P/zH57agUqr0=;
        b=wPExqhGrnKejAyFmHvBYLqJMt8JgdrMBjZzFhtCQ/NULp34cEYBVbDRg+PbgQ2uHWo
         cXJPTH/v+PxyyKdBWerdUhK6uAEJpXuUpBw5p8uCCL9m1T7Qrc9ZybLEy1bH15LCTSVT
         j/tstfQJy8vJuS34POI2QleGYijbUlsP/omr0m97+GLDKQ4RZBBYMeN73rxk2gdX37hL
         TfCnCsHhNdmaDE/e/mG0BVBYtvcxZBAGBFMxUTqAKQ3mnl8Vja+i9+dHZIQZ4UN0xrJ5
         uXOZp1MXz693Am0o59xXO6qRJmOOoDXsb6lMmI63i6Ao/d3s32Ifjf4DxBdiiTRzyLUO
         kWvw==
X-Forwarded-Encrypted: i=1; AJvYcCWEfyd/wUjaJSV1WaibnbMDYtXtXjM8XniKRzaw/bU/Xxs1226WjrPxi1fmmbGOgJu7iejIS2PQ27n3WFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80ngSADNwyvpyRPOZb/ZVs7T+H+iF+/LUm92OTuLbsOmN1Mvc
	Yb32J5HV2cz1l83nd0q5hA0u8tPPUYcVBS3oesvG8hOqD4Nz7lOjSgKCbRd2WxSBQZO4+hemsIG
	D6RF8qNZT/Wi/nsll2lF3pcy5bQuPk3ATD4SWUMZu
X-Gm-Gg: ASbGnctJ995F4yx1RB+zUI1PAlbbBeho83IRfqgLFDDGBa9LRVR1zSu2dNY6qCYFO+e
	8qMeEteX3G+8BmVE0H8R++nAW8KEnRgXmTnakKf/XxsL1yFpDM5BVMsrObpTqSiS+NxTAcHjiX9
	0cGpRQIK+JsjYuA20m3BFQ69bc6F3zuGbB1IUiwVMQ8HZZYiIK5UJp34KSjGy6SMfp/UNC4BoWL
	BnQK+v8KLfuPo1Hv91fkZf2YtZka3MizuhjFUIyOJny3SP9WQfKWuHmGl/wiWODiMRf
X-Google-Smtp-Source: AGHT+IGPDOrxe5jkTqdZP2fGXdmC5UXMtH86TTeBanybD5T6KXcL/otW1ZKqETuBaYFxoV+HYe1rpuQvvash/vcmxJM=
X-Received: by 2002:a17:903:2311:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-28e8ea94067mr4001035ad.15.1759418479089; Thu, 02 Oct 2025
 08:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN54leQ54ozcUXBO@x1> <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
In-Reply-To: <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 08:21:08 -0700
X-Gm-Features: AS18NWD-KWXKQwTjwoUcQOpcNDl34rotcBCKuH03fCgN2iki8OY_tRBPChx1Sgo
Message-ID: <CAP-5=fUfBzUTOJG7t7nwvZkcf+LKVakGnNqgVLSW8CjsLxFkDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always available
To: Tomas Glozar <tglozar@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 7:13=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> wr=
ote:
>
> =C4=8Dt 2. 10. 2025 v 15:05 odes=C3=ADlatel Arnaldo Carvalho de Melo
> <acme@kernel.org> napsal:
> >
> > perf doesn't use libtracefs and so it doesn't make sense to assume it i=
s
> > always available when building test-all.bin, defeating the feature chec=
k
> > speedup it provides.
> >
> > The other tools/build/ users such as rtla, rv, etc call $(feature_check
> > libtracefs) to check its availability instead of using the test-all.bin
> > mechanism, stopping the build and asking for libtracefs-devel to be
> > installed.
> >
> > Noticed after applying Ian Roger's removal unused libtracefs
> > configuration in tools/perf/.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Gabriele Monaco <gmonaco@redhat.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tomas Glozar <tglozar@redhat.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Acked-by: Tomas Glozar <tglozar@redhat.com>
>
> Perhaps it would also make sense to clarify in a comment that
> test-all.c is to speed up perf build rather than rv, rtla etc. (which
> don't use most of the dependencies listed there)?

There's a big comment in Makefile.feature:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/build/Makefile.feature#n24
I think that FEATURE_TESTS_BASIC tests are covered by test-all.c so I
think this change needs to remove libtracefs from FEATURE_TESTS_BASIC
otherwise  $(feature-libtracefs) will evaluate to 1 even though no
libtracefs testing has been performed. We can't just remove the
tracefs feature test as there are dependencies in rv, rtla, etc.

Thanks,
Ian

