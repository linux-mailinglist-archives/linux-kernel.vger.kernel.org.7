Return-Path: <linux-kernel+bounces-664503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73777AC5C77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B001717E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15B2147F2;
	Tue, 27 May 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTu8asSc"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621291F8937
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382776; cv=none; b=topLJ6uGAnE35OQsPepcrxoxICoWQ0qOpgIEEbz/ii4PZeSudKZf0XFUHordAQsRBtUWjOGBD6itCeF/YRvFut8b6+2vPQS3277vMXbs3JSnWiNUweNVVK1UISEe4F8xtN0ya4ysI3oZLDEBmr6PaDRdSvplAvNPZm3iaKmri68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382776; c=relaxed/simple;
	bh=NajqaMwzak2ZVvXTy1LnEbealGJdqp9h9PckD2MrsnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCAS6z1uZcn8fyvct36iBL5wths3FR08EaxxMy8e3enCdd8svsCQ85Ah7X80RgTrYl2ebqD03VX+vxDm0kBiJmL2xKKlIMdFQlVX+XkHvlDTA1cfOpg+5/qXq3YL9brmeKmrlcrAz/+J3f2tWKIjpPlXI7kNIOxbhMWZnHW4hHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTu8asSc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso29535ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748382774; x=1748987574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzy/VP72yEkDUxgyVW5whFWNlXXozP4lwanJ50OlT08=;
        b=qTu8asSclUdczT+2ecciVMS/9GtUzWFFG1rTsc+q4bxn8wnLDpQKZ5onrW0MshLnmH
         V6ReJ+bhl0oGM7YgNuW1PxX7W5dkmtTFwlgk1aY31KB8/NqLYMbuINE6o5YqC0SsgkaP
         HBMelfZWhKB7ZIQXULzxe7MciM9xRmEDv/kJ0yjTU1h0FqCtzJyoG3Tte8yrfv96EAUK
         W5/5lYAsySL/xNUzDx4BTU+6Ko5NgPNddpREtDMPt5eXbYTdVzv4TWgiNSgEE3fjUsRp
         hGO+Pi3LU88pQyH3lTHOQ6WoYIA4X7e2o+wco1HAPI6ng7w6xDxJtJ0eR6iPy1+KIhWr
         2l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382774; x=1748987574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzy/VP72yEkDUxgyVW5whFWNlXXozP4lwanJ50OlT08=;
        b=VSSl/Dd0rKaf18VuBX2tFU2pCvbvJyG5WSWZF7HuLb1cegPgZwCNNJCtMA65qamNQO
         OyKicvC3bnRhujVjOtGrp0wFbNdC5C+G9aWKTvNVERM7DLOAjhyzHTBL3VGTXzdStg+I
         ZZX2SCF6DU+jj+7iSNt52KfN/27TiNIl0rXOiUyqfpi6GiWhOeLT5Kk9O4b/ULtYy5z7
         TGNpw4YgZsgegFPy61nCwPNJBcedwF5bf0ISUdeAe980BJwJ/aeklta2kXHQd60DNoW6
         oj0ZnT0NXVXvctp8KKUyalLtbc2c3TPshbPZcWOn2xq/CnKF830lwVqmgPGnCiJ7d5jr
         /1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVvRujPCT1V8SfYC7KNaB86taBvE+u2Ctbo1TEpNUfJdffIxi9kV0LSoYMbS/mQujQoVYwVefaNlEWI9Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jVNgi5TAUvds51nJfG1iMH/tqlg4e3pSeFr249JQ6XvH+aDk
	YQZmu62f1m3t+yAIh9gFCJl6leiwrnFNI5yZuExZa2pquzEfrtJqWDGAoxUpt2AxFPSf2k4AW36
	llcxqEpn+zMy86/bEMHgYMJvoWxD1Rd/22GVQKAOE
X-Gm-Gg: ASbGncv1dy+1JvxsZmqnBZm82GVpPQ/vtSg9nF+rb7fQoGUUMBHG+JP1fqa9xAusddr
	T1mfekfP75w99wcB2pA9ZtoMB7roJPUsWfQukya9i3UGtIQwLyc4T/vvXaPDYGfcsS6Ey0L9Pbe
	WXAE1dXL6r8Gm34ndrieOy0K8m4RniHH8x7UBu3oV69Cvyj6tc5SxkyMzBqOZms7fOFFMbON4C
X-Google-Smtp-Source: AGHT+IF/X/d3ehgRBp3+RuMKNjyxr4o+rJWM+7S6FJZ0zE8aw5lm5Q/+wDtlGaOZJXxw2jrY/SoQ1HqZJ1vSLGyJoeY=
X-Received: by 2002:a05:6e02:2302:b0:3dc:6fb2:dac7 with SMTP id
 e9e14a558f8ab-3dd88f5058amr1391775ab.10.1748382774033; Tue, 27 May 2025
 14:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402211301.4153441-1-irogers@google.com> <Z_Af-KAKuOlqALH6@google.com>
 <CAP-5=fUiWm9kq2fhT-9+8LOmC2Yen9Mw2P8yPLTJH+nk83nmmA@mail.gmail.com> <aDYnLedM8RT17FHx@x1>
In-Reply-To: <aDYnLedM8RT17FHx@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 14:52:42 -0700
X-Gm-Features: AX0GCFsymAJ2MGDqkcBSLY_tqzADwkSXe8XrJLlBH-xRrruWMpTuGsuArIlRpOU
Message-ID: <CAP-5=fWciArAOkiJDhahxvL3S0zWCNHVEK2msPNT58W9otDOqQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in wildcarding
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:57=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 27, 2025 at 01:33:35PM -0700, Ian Rogers wrote:
> > On Fri, Apr 4, 2025 at 11:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > On Wed, Apr 02, 2025 at 02:13:01PM -0700, Ian Rogers wrote:
> > > > The pmu name or alias_name fields may be NULL and should be skipped=
 if
> > > > so. This is done in all loops of perf_pmu___name_match except the
> > > > final wildcard loop which was an oversight.
>
> > > > Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix =
or wildcard variants")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> > Ping.
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < ./20250402_irogers_p=
erf_pmu_avoid_segv_for_missing_name_alias_name_in_wildcarding.mbx
> patching file tools/perf/util/pmu.c
> Hunk #1 FAILED at 2060.
> 1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/pmu.c.re=
j
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat tools/perf/util/pmu.c.rej
> --- tools/perf/util/pmu.c
> +++ tools/perf/util/pmu.c
> @@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct perf=
_pmu *pmu, const char *to_mat
>         }
>         for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
>                 const char *name =3D names[i];
> -
> +
> +               if (!name)
> +                       continue;
>                 if (wildcard && perf_pmu__match_wildcard_uncore(name, to_=
match))
>                         return true;
>                 if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(n=
ame, to_match))
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/=
util/pmu.c
> 754baf426e099fbf perf pmu: Change aliases from list to hashmap
> 255f5b6d060be5a4 perf parse-events: Add "cpu" term to set the CPU an even=
t is recorded on
> fa1332a8011eebe1 perf mem/c2c amd: Add ldlat support
> fc807b6bde6ad332 perf pmu-events: Add retirement latency to JSON events i=
nside of perf
> 58b8b5d142a8bd5c perf cpumap: Increment reference count for online cpumap
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Can you please take a look?

Done.
https://lore.kernel.org/lkml/20250527215035.187992-1-irogers@google.com/
Not sure what put patch off given the small nature of the change.

Thanks,
Ian

> - Arnaldo

