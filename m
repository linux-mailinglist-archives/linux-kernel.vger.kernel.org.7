Return-Path: <linux-kernel+bounces-880583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0CC261AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA56580EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D12E92D9;
	Fri, 31 Oct 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMkebEAu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27F2E92A2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927040; cv=none; b=FmMVyS5mZ/qaoC/QQNQaKh+h0aqZDZlKZa/tbMcEApW/l3SQV8DZyu4610KpuV+T8stbsNwLPL+iXJEBk1LuuFvZMdVYZmWrYsIxuiRPdPDlDQe6F6gtYk8R2SC3RAgit7Nb3Ww/XzBglvm3o9i4weDatb7R5ty/9RsftVDDO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927040; c=relaxed/simple;
	bh=TAxzTfAH15ikAqnfTFk68QwqGL+1mN/BsZnt/ZLstuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IV+VnBeNmtnRb9QpbY3UCP9/kP/IaxrajGQ5uenXFhRFQp0fTRiShZ3xFgBTDqUEecjcXn8si7i/FeVVywCTGkIh3czH5NBvz+Xwyja0D1GJPKxCbR7ekbiTf3jmw8Fdl3KLaMe0Ai/gHP8xZbSJQoor6qMQJZn/LmUtd0ASMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMkebEAu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290da96b37fso223895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761927038; x=1762531838; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox59yowNWyjiX1gk5+cWPDLZYRx/RstMsmczOvK3gpc=;
        b=MMkebEAu+iNPLEhYuao4kg4t3WmW4E3LR0a0Y7EZlWyUpWvnyRR/RLpw3pBWVOcIo1
         5GAEK4hCeB+6/5rIpQJU4ipHqdEkhxPwrWs7jEprLapOkXKz/+EuXDsKtxc6e0LS+lef
         1yXuB5mnxd8FXjWOylhxCmOFcpxdBAPe8uDO4f4XpZF2h7BjoLhszpELWK7V/8e4wek8
         itgW5nhjhRK4sHLUqkK2rQ3b9twYwTdyhmuZdtgdY2ktt/xLlZpWS4OI/xUwLOUiuTxa
         TS2fMOSyKs9RTWjEcqwGbEJmrOD/Br/sGFPFmSQWLpaZXUZqpRHNaaGMcHsGWxFdzS+0
         7jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927038; x=1762531838;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox59yowNWyjiX1gk5+cWPDLZYRx/RstMsmczOvK3gpc=;
        b=eOUeFB893q53rfcf2LZqO8YRKQdOSzU+ero5uUtH+idO9uL+4aUcZzx8aTJ58OIsCg
         vpgloeNfUqjYotp+2zg8cs3dZZrnlUxcwsIp9PlzLgqYmxKwYH//a5i/McqTraO/m/bl
         wkApFOm7MrEhwHnSmi5lUlOzrhH8UGklwvCbcqL3uhCIp/5qxDbHRrc8+g4fuZJHSB5O
         ZhC2e0Wi3kVUy+I1oAKYul2VMWqUospQBeFa7nnhz2UcX/Jsynh7N2jxHQy9kuoyGOda
         Sucj6Ibkj9ZfJNkvN3EtECGtA4BmrEpNlia7v8jmIrAQIgC7fUDQCPZmXu/+6n8AE0Ol
         cvuw==
X-Forwarded-Encrypted: i=1; AJvYcCXGzhFVLIad2pqAsZiPWE9FH6dhWRChHdSWrOVeC6js+biFoiWhKWtYwB/1KslA0uPHspax6PErn98bt+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPX69H9GEnCjtcz09a4DZHOK/7F1fAKjaM0qZaDJ1i1PtS0+rb
	RQELEZOu0Udelp7LzhbO6j1HI4mk2LIv+4obQblFBj+kI9vruzDeVjUr0mBOAgPR2OGLBcWWYUC
	aqrYxOUt4oEjX7ftVV1Yj47PvAyQGwmm7fxPObwSw
X-Gm-Gg: ASbGncujii7kzs7uXzTeGgnKC92qeR/JiR0fp/YgY9YLqlXoRupAWFmLUKDxwfqsYJk
	Kve0v9ieYdso2SruEi86PbuUljaysJyQvuJi2ayLaUK/9uzPJcOK2prLBF2MXbQ8uptGklPh96c
	8CBYBUUNNvD35q3WAiEdwg02dTI26vkdEqBraifmENPstLBpkSV+PFVarF/zMRcSgzMEJKLaDr0
	NaOufQ0yYRFRjOhe6XnrU5y6SFrS1vCbaLwyhNmfmTn+NfxYLG8s7xK9PBlF98sCFmOZVMmSHJj
	vtf8pSsgb9+PGFc=
X-Google-Smtp-Source: AGHT+IFgpKfqGZMjY3OVk2+0ldI4BFAwiXgWaEbASeMv6uWptaDbA+XCFixqgI0jJ65953CGbIqkmUd14ITbU/4zts8=
X-Received: by 2002:a17:903:2f8a:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2951e61f447mr5020115ad.4.1761927038157; Fri, 31 Oct 2025
 09:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030172140.1113556-1-irogers@google.com>
In-Reply-To: <20251030172140.1113556-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 09:10:26 -0700
X-Gm-Features: AWmQ_blD1fpniav2g4meIWSAmydK7XkPmCLw6-WavK4mFbwbHTpdGktypqvI2cI
Message-ID: <CAP-5=fXvRK6PpYctLa4UXFbr5xzGDCAUkFuc4JWCEtd0s5QRaQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf s390-sample-raw: Cache counter names
To: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:21=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Searching all event names is slower now that legacy names are
> included. Add a cache to avoid long iterative searches.
>
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-=
e4a64ed61d38@linux.ibm.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> --
> v2: Small tweak to the cache_key, just make it match the wanted event val=
ue.

In this thread Thomas added his Tested-by tag:
https://lore.kernel.org/linux-perf-users/0d4b605b-64ab-48a0-bd95-8465dabbba=
e3@linux.ibm.com/
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks!
Ian

> ---
>  tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sam=
ple-raw.c
> index 335217bb532b..f5acf6dfa8d0 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -19,12 +19,14 @@
>
>  #include <sys/stat.h>
>  #include <linux/compiler.h>
> +#include <linux/err.h>
>  #include <asm/byteorder.h>
>
>  #include "debug.h"
>  #include "session.h"
>  #include "evlist.h"
>  #include "color.h"
> +#include "hashmap.h"
>  #include "sample-raw.h"
>  #include "s390-cpumcf-kernel.h"
>  #include "util/pmu.h"
> @@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
>  }
>
>  struct get_counter_name_data {
> -       int wanted;
> -       char *result;
> +       long wanted;
> +       const char *result;
>  };
>
>  static int get_counter_name_callback(void *vdata, struct pmu_event_info =
*info)
> @@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata, s=
truct pmu_event_info *info)
>
>         rc =3D sscanf(event_str, "event=3D%x", &event_nr);
>         if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
> -               data->result =3D strdup(info->name);
> +               data->result =3D info->name;
>                 return 1; /* Terminate the search. */
>         }
>         return 0;
>  }
>
> +static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unuse=
d)
> +{
> +       return key;
> +}
> +
> +static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void=
 *ctx __maybe_unused)
> +{
> +       return key1 =3D=3D key2;
> +}
> +
>  /* Scan the PMU and extract the logical name of a counter from the event=
. Input
>   * is the counter set and counter number with in the set. Construct the =
event
>   * number and use this as key. If they match return the name of this cou=
nter.
> @@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata, s=
truct pmu_event_info *info)
>   */
>  static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
>  {
> +       static struct hashmap *cache;
> +       static struct perf_pmu *cache_pmu;
> +       long cache_key =3D get_counterset_start(set) + nr;
>         struct get_counter_name_data data =3D {
> -               .wanted =3D get_counterset_start(set) + nr,
> +               .wanted =3D cache_key,
>                 .result =3D NULL,
>         };
> +       char *result =3D NULL;
>
>         if (!pmu)
>                 return NULL;
>
> +       if (cache_pmu =3D=3D pmu && hashmap__find(cache, cache_key, &resu=
lt))
> +               return strdup(result);
> +
>         perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=3D*/ true,
>                                  &data, get_counter_name_callback);
> -       return data.result;
> +
> +       if (data.result)
> +               result =3D strdup(data.result);
> +
> +       if (cache_pmu =3D=3D NULL) {
> +               struct hashmap *tmp =3D hashmap__new(get_counter_name_has=
h_fn,
> +                                                  get_counter_name_hashm=
ap_equal_fn,
> +                                                  /*ctx=3D*/NULL);
> +
> +               if (!IS_ERR(cache)) {
> +                       cache =3D tmp;
> +                       cache_pmu =3D pmu;
> +               }
> +       }
> +
> +       if (cache_pmu =3D=3D pmu) {
> +               char *old_value =3D NULL, *new_value =3D strdup(result);
> +
> +               if (new_value) {
> +                       hashmap__set(cache, cache_key, new_value, /*old_k=
ey=3D*/NULL, &old_value);
> +                        /*
> +                         * Free in case of a race, but resizing would be=
 broken
> +                       f  * in that case.

Oh, there's a typo here. I'll send v3 with just this comment fix.

Thanks,
Ian

> +                         */
> +                       free(old_value);
> +               }
> +       }
> +       return result;
>  }
>
>  static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample =
*sample)
> --
> 2.51.1.930.gacf6e81ea2-goog
>

