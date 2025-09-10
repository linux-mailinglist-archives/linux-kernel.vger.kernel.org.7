Return-Path: <linux-kernel+bounces-810461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63FB51B10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C5A081F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468512580E1;
	Wed, 10 Sep 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbbp+90h"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10982241673
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516438; cv=none; b=W2P8D5XmeJCNQfEQE24OSdaHZCwf6hMYX1CsFZqD81Fc8Dq2EPCvuX3j2eztZkgceBAAL2hwsUtozhDSTuGVaje9O1QoLLfSFANcslnifo4GYOXaPDDnmxFk5WebrvBO3ycObcVbuhQqYm54WE+eiONxYmGOEvAS5h+WDFGE+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516438; c=relaxed/simple;
	bh=yyCBvmzhs/mvJ3yr3svszkOJYjpUZ5oLKLTr35nIJ88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lotCDfZbmw6RePLf7sf2ilmfF1CSte0/Bzd7vunxR1ds+Ub0brzL5CSkJyA0mKkAspBdok9SQHovaT2W5ym/kbfh5rDXVzUo8fIZuV/LPmdzP3oC8od2GBWQnPcGYHRIzr2wws7wyDD7bHUjp43IPkdhyB/di8S7AmDhPYjgwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbbp+90h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b2337d1bfso215565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757516436; x=1758121236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weuvA194fKCjKwZnheH+7smLoUqlaZCSgWfuNlCklyM=;
        b=tbbp+90hAAohGqdgMzSkNsq8Kj6rYSZf+AEfXWOfIZgLrrL3jkjHROqzg8Ll8+sBLc
         jU62SDKbm6ztHpHySjkN/XL5d7JikLKtx0sneYH7rhCEC/gUXXnT4O5Au1SfPVxt3ZYx
         geZaH80aW+6lUOHikToRT/MMgY4jRIJu45+pO8q3AoLWOoBnKfL0+B0LFCJ9AtEjd9gq
         GmJhtDMjWR7r9aGcdT1GpYipJjraa1A63Dvb0VEGUvcE28jZXCi8HYb0IKfNwevwpqij
         a0/eJduce/JT+ExGvTOUjkD2vKcDcczIlUXUQRgFyyNfrOQnr4sS0PGH2doJ408/rP96
         Q3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516436; x=1758121236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weuvA194fKCjKwZnheH+7smLoUqlaZCSgWfuNlCklyM=;
        b=oP02n5fhokfG/pL1fZ0sMp1eL9d1Mc+u+YoRA7+iqeodn1dMLrNtWLdP9KtanvBFrQ
         AsiAq8jUkkobW2SWqgGW/2QhU2WCpgO+9lfEWMHeNWWbBxmiupc6GYOGcEk4pxLxM1l0
         Vm8qEhOTVUVHhhAV8toYNHFlfYlmTxPRk/tNVD/McV4tqM+Yq7Z4JB9chMS4V6c4JGCM
         XRW+Wl6yhgIDZ+apHm0MIbh4FuIdMGXrcsDnfZcUaHAxUgeHrhb2DhqcwjR62UIRYkKL
         GaXrzYIGP0ZPFNCa8Pm0QpGBLN5hHq0OojWY9vPQ9skYsB/zgTA8nqvZKm8NhW0qykto
         XDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVO/bYpvZCYb4VX3zvGSlXMSyoObH5R5QVjvz+m8MpLpe4D3kljsyVT93xss4XvYcAx7aHkpLgmF2gkAOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDz12psVBYZndAy41aimMY965AwM5Yi4gk8NtR++75ToQZGvcF
	u+a01ygQCbV/d/GTsxv7p4w8/Klwy0sOjKwNrHbHDlUx4MDsAXgtQWak1jHK4qAwBN6qgZ/2hb4
	38d4Dmhx+UQLlfNNHlakGqd3eSCS71NxoO8fgKlZ6
X-Gm-Gg: ASbGncuxar+ujAytdc92Pi+HthB3DFLZ7n89vhLLChz7ql7gu6OpcGMkJwrIIUWB8KH
	tlMF4ZCaEd41QxuoM6Qcdl8fYJZ9PXA2iH8vzBR/N6nOGgl4KcCrjjoq3rhepHky3dT7xlTpAh5
	ctu1JI18NXFgoTn6Ura2Am0dx6FMzQB3rQi9C7NPFfC+AYa3aLxumijOkJEmv6HuNd7j7DX122H
	Q7LDXxkb6pAvFUUJd1R6Q6xXgwPYyhnU7jrB1Fv1AKsU4NICF8ecpg=
X-Google-Smtp-Source: AGHT+IH1042rZlLfxKs7Y+xux3JwZNmIbzFLATrg2+c5aXZKMwyE2s3Ww9mR5fOFhPP0GiKrmdRSfEs8AtaExPp4CHc=
X-Received: by 2002:a17:902:a516:b0:24b:1b9d:58f1 with SMTP id
 d9443c01a7336-25a7f4bde70mr3189515ad.17.1757516435531; Wed, 10 Sep 2025
 08:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com> <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
In-Reply-To: <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 08:00:22 -0700
X-Gm-Features: Ac12FXwPnKvmnBzu34VagSylw1N28rbQG7YHbvq2KGGi5XeyvRAcKMxWmzvI_pg
Message-ID: <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:14=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 28/08/2025 9:59 pm, Ian Rogers wrote:
> > Mirroring similar work for software events in commit 6e9fa4131abb
> > ("perf parse-events: Remove non-json software events"). These changes
> > migrate the legacy hardware and cache events to json.  With no hard
> > coded legacy hardware or cache events the wild card, case
> > insensitivity, etc. is consistent for events. This does, however, mean
> > events like cycles will wild card against all PMUs. A change doing the
> > same was originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > his dislike for the cycles behavior on ARM with perf record. Earlier
> > patches in this series make perf record event opening failures
> > non-fatal and hide the cycles event's failure to open on ARM in perf
> > record, so it is expected the behavior will now be transparent in perf
> > record on ARM. perf stat with a cycles event will wildcard open the
> > event on all PMUs.
>
> Hi Ian,
>
> Briefly testing perf record and perf stat seem to work now. i.e "perf
> record -e cycles" doesn't fail and just skips the uncore cycles event.
> And "perf stat" now includes the uncore cycles event which I think is
> harmless.

Thanks for confirming this.

> But there are a few perf test failures. For example "test event parsing":
>
>    evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
>      misses,branch-misses}'
>    FAILED tests/parse-events.c:1589 wrong number of entries
>    Event test failure: test 57 '{cycles,cache-misses,branch-
>      misses}:e'running test 58 'cycles/name=3Dname/'

I suspect the easiest fix for this is to change "cycles" to the
"cpu-cycles" legacy hardware event for this test. The test has always
had issues on ARM due to hardcoded expectations of the core PMU being
"cpu".

> The tests "Perf time to TSC" and "Use a dummy software event to keep
> tracking" are using libperf to open the cycles event as a sampling event
> which now fails. It seems like we've fixed Perf record to ignore this
> failure, but we didn't think about libperf until now.

I'm not clear on the connection here. libperf doesn't do event parsing
and so there are no changes in tools/lib/perf. If a test has an
expectation that "cycles" is a core event, again we can change it to
"cpu-cycles" as a workaround for ARM. As "cycles" will wildcard now,
we don't want that behavior in say API probing as we'll end up never
lazily processing the PMUs. That code has been altered in these
changes to specify the core PMU. For tests it is less of an issue and
so the changes are more limited.

Thanks,
Ian

