Return-Path: <linux-kernel+bounces-880850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA12C26B89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225F13AF79E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD08229B18;
	Fri, 31 Oct 2025 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/UHlTcT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DA30B511
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938501; cv=none; b=IfOQkug4gdLwJHhww3zyH7ShZQounzjLnGvdRHCX8f6eI30xuyInrDkxz9jP+BPfwFJd7CfqLRglRtuzMDKqR1TzJkJ15QMFUj+JU+uKQ4bTGT+kZ0U5tabzkzf2WZ80aTHXIkUZOm55jMAtKLzfh8q2S8VsGFQI+ihHbWVZlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938501; c=relaxed/simple;
	bh=IKykEbYZCcLlUg4KrFApgwoDlyD4UsFbAAB9qbP5KRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlxIXgglq8hsovUGij6xvuDAobE4egYOq5FzZ2hD48zKDRrZqkzLYg/agJy2GfSiuorZWj1/hlMGj70GRfjZnsPCauFxXyc82KucIHlKBNYSuvS3+gI+VmdT3cqniIApqG7q8U3Z9lAHk6EkjmKdWwXLcS8WrbVI3aPIxaoNXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/UHlTcT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so40105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938499; x=1762543299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS5w6YyvPhKniGTg9Zltau2UNMNMQ1CYb3u0bWLzUzw=;
        b=f/UHlTcTJSt0cS+xe3dWwK0cs6HoA3VZjvEh+BVu4Hzx86U2dQbY3YBz7X3tOnGmE/
         fN+EN35OYM9OFLLIa4VrK2JdEE9NdlsCjaq2FyCy+rC5k3+zFdcqwZEOb9yBtazpJ0AF
         SasZ2bs6716bH2J/K0zHICcar7PASFRE/Aaxn0WPY8XZepuqUxMHdwg8UzqUA2q2XtkM
         3n6k4ihvc+w5SPyxREbVr4WzL+ShP2tsOt0FszZoE9EAgT6zRSVRXx43VqjVnhsXge+Z
         rvTqm40jVATngzpqos4fZFkD3U1z5OUreMrOXwnfJ0FmtsfMTDFeSBimDLrQsttLHAEK
         5Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938499; x=1762543299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS5w6YyvPhKniGTg9Zltau2UNMNMQ1CYb3u0bWLzUzw=;
        b=icordTtMJF/G07JvzmpdrEDyaBA/tif061a0YK8Rb8qke+PMFi4sbsyIixKcjv03Il
         1wssaCfz0y5UbRY8opNHK4CZrjGUW+GKAoq3109YE8IxxkDR5kNWmINq8EcFYBMTDdGC
         v0Y6ER41DqpP2JewNOwr25BBaXHQ7tAuXWFP1kGDYzwxzlxGM0O7xg3CUBOmHGESNj3A
         0QUCSzuABkFfz5imhtg10tgNM5ArBD890Z/SyHuHCQ0ElFeCD/QE17hp0GT+q6xDXiPa
         /oJA8giaoQsmSfQ2soYKTdqqH8uv414ZOA4aEj5M/81khFVDbLwgrWnZdEWLK024QZjB
         iBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfkxzyZBmXoPbpDeNSjrD5hu1Q3NhBSP/+L6UFHDHKoGbrVtbB2WCCUL7jU8GmJXEPqZ15z1Fprz+GMNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yVDvpnL9ccnQebopijKPghAuN5FoKdFy1Bo0AEy/M2lnIudU
	b2KvY9k4AD3dKkakgdsIbJ1j5mYPHatzTzK1VJZI41QWETpKtzWFzn1LLi4QJDHvUp8sQg5ix5i
	c54jtN+bVxOFeN6sCGADgasK71R3YTAaGMAjgnBPZ
X-Gm-Gg: ASbGncuIui3W++3Eb8XgYQq3rZOBSoUfZ83LtExqFf80qfrLTRsWQtyVqRuruUt2wnU
	95XZHbVsHQg9hfHYsGCB0e58cZoviWQqyCzzlQWPcLG3Lu9COmDnAj1ewKZDeTSqxQlTDZW9hc5
	mzwFDG1ofqV4j4aenLX1j9r977nnbCZOohYYJ7hVfkrAykZ6gCBeMPCXedb2v9XzUt+XL9N0qM/
	qx95c5zmPSyRPWw4j08m1VEI9Dd7ks/RPz6/V4533/ufEyhC+rKmYckjTnYwwyevSanHi8hqSmy
	zViq/gH2zONqgSsE5FzpD04ZaQ==
X-Google-Smtp-Source: AGHT+IEhfAExpGgethZEcA6bBOOjL/P1I77mpqVU3G01mbpDDGArm5Q97pVKlwIHj1kJZGc/Zj0coJ28ayizUFu26cg=
X-Received: by 2002:a17:902:ce82:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-29554cb679emr620315ad.9.1761938498585; Fri, 31 Oct 2025
 12:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031161213.1452901-1-irogers@google.com> <aQUCVvIEC7brqaG-@google.com>
In-Reply-To: <aQUCVvIEC7brqaG-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 12:21:27 -0700
X-Gm-Features: AWmQ_blB1hhdIjnN1ryfJypIwWZzqTSFQwygC4SAtwH05uJJWpIBVzla6fxjaZ4
Message-ID: <CAP-5=fU8=-Bj7i-WUXfm8qJYDN3B=91VTmMFstEoZ2ub5MZw8w@mail.gmail.com>
Subject: Re: [PATCH v3] perf s390-sample-raw: Cache counter names
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 11:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Fri, Oct 31, 2025 at 09:12:13AM -0700, Ian Rogers wrote:
> > Searching all event names is slower now that legacy names are
> > included. Add a cache to avoid long iterative searches.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877=
c-e4a64ed61d38@linux.ibm.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> > v3: Fix minor comment typo, add Thomas' tag.
> > v2: Small tweak to the cache_key, just make it match the wanted event v=
alue.
> > ---
> >  tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
> >  1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-s=
ample-raw.c
> > index 335217bb532b..4f269ea7c93b 100644
> > --- a/tools/perf/util/s390-sample-raw.c
> > +++ b/tools/perf/util/s390-sample-raw.c
> > @@ -19,12 +19,14 @@
> >
> >  #include <sys/stat.h>
> >  #include <linux/compiler.h>
> > +#include <linux/err.h>
> >  #include <asm/byteorder.h>
> >
> >  #include "debug.h"
> >  #include "session.h"
> >  #include "evlist.h"
> >  #include "color.h"
> > +#include "hashmap.h"
> >  #include "sample-raw.h"
> >  #include "s390-cpumcf-kernel.h"
> >  #include "util/pmu.h"
> > @@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
> >  }
> >
> >  struct get_counter_name_data {
> > -     int wanted;
> > -     char *result;
> > +     long wanted;
> > +     const char *result;
> >  };
> >
> >  static int get_counter_name_callback(void *vdata, struct pmu_event_inf=
o *info)
> > @@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata,=
 struct pmu_event_info *info)
> >
> >       rc =3D sscanf(event_str, "event=3D%x", &event_nr);
> >       if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
> > -             data->result =3D strdup(info->name);
> > +             data->result =3D info->name;
> >               return 1; /* Terminate the search. */
> >       }
> >       return 0;
> >  }
> >
> > +static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unu=
sed)
> > +{
> > +     return key;
> > +}
> > +
> > +static bool get_counter_name_hashmap_equal_fn(long key1, long key2, vo=
id *ctx __maybe_unused)
> > +{
> > +     return key1 =3D=3D key2;
> > +}
> > +
> >  /* Scan the PMU and extract the logical name of a counter from the eve=
nt. Input
> >   * is the counter set and counter number with in the set. Construct th=
e event
> >   * number and use this as key. If they match return the name of this c=
ounter.
> > @@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata,=
 struct pmu_event_info *info)
> >   */
> >  static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
> >  {
> > +     static struct hashmap *cache;
> > +     static struct perf_pmu *cache_pmu;
> > +     long cache_key =3D get_counterset_start(set) + nr;
> >       struct get_counter_name_data data =3D {
> > -             .wanted =3D get_counterset_start(set) + nr,
> > +             .wanted =3D cache_key,
> >               .result =3D NULL,
> >       };
> > +     char *result =3D NULL;
> >
> >       if (!pmu)
> >               return NULL;
> >
> > +     if (cache_pmu =3D=3D pmu && hashmap__find(cache, cache_key, &resu=
lt))
> > +             return strdup(result);
> > +
> >       perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=3D*/ true,
> >                                &data, get_counter_name_callback);
> > -     return data.result;
> > +
> > +     if (data.result)
> > +             result =3D strdup(data.result);
> > +
> > +     if (cache_pmu =3D=3D NULL) {
> > +             struct hashmap *tmp =3D hashmap__new(get_counter_name_has=
h_fn,
> > +                                                get_counter_name_hashm=
ap_equal_fn,
> > +                                                /*ctx=3D*/NULL);
> > +
> > +             if (!IS_ERR(cache)) {
>
> Shouldn't it be if (!IS_ERR(tmp)) ?

Yeah, that's me trying to make the code less racy. Will fix in v4.

> And it's not released.

It's just a global leak for the sake of performance, similar to pmus, ...

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +                     cache =3D tmp;
> > +                     cache_pmu =3D pmu;
> > +             }
> > +     }
> > +
> > +     if (cache_pmu =3D=3D pmu) {
> > +             char *old_value =3D NULL, *new_value =3D strdup(result);
> > +
> > +             if (new_value) {
> > +                     hashmap__set(cache, cache_key, new_value, /*old_k=
ey=3D*/NULL, &old_value);
> > +                     /*
> > +                      * Free in case of a race, but resizing would be =
broken
> > +                      * in that case.
> > +                      */
> > +                     free(old_value);
> > +             }
> > +     }
> > +     return result;
> >  }
> >
> >  static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sampl=
e *sample)
> > --
> > 2.51.1.930.gacf6e81ea2-goog
> >

