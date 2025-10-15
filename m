Return-Path: <linux-kernel+bounces-855302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E806EBE0CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061BA19C6502
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B112F7457;
	Wed, 15 Oct 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUHAPlzB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CB2DC79E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563495; cv=none; b=oblNlZXZXJ7sH5VN0dl/lhrnVY7jY4kI62HNh9d+ktOL28hhuix8cZZofSd03dRmNallyEkfLaP4nOmdt//jQ4Kae1/fAVnlvnkrt3l0fyQwQbXIFloXaYU2Q1mR4ww0frHrma4QZ+G5+jV9AoQnvG9S2GCgjZwnebiD/Wd6Oik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563495; c=relaxed/simple;
	bh=W1g4/t3DMHUeDcN2igXiKHkc93YpFK6eSsbRMAAyTns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b606Gv2507g2JmPt0JUqWfAg3Cz8umFMVx+qPaYWAC9HN+GRTrAZpQXQ9yL5YfuvZ3/5IUfkm+vD7p7QrUu1O5ASqeh7rwvO9V8UZ9Tg/X58OW7bHBEjCtDgnz7skIhvczdyvAMNPZJEv4J0T8DtYFaJgRpAuFSjDQEFD7eUC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUHAPlzB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2681645b7b6so15045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760563493; x=1761168293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFOj+Y3JzrGlsyh+9lR59Vs13yNcy5DdHPtE8235H5Q=;
        b=aUHAPlzBQnMPcVy2ggFMHxkUaK1Yda6Lqgc4W1qbFvN7SqamfpAO3oVpbHG+6VZgq6
         mMnrOvo49t2y2tOt/9PS+ZIw6i2q91BvbwlMuSt2hhwFc28H0oFKlZ0zufZ1qpsXEXU/
         K7yU/dJjt6R6IxplC4+jYsNW24ShOZ+r0lmHqUktDlHxup9hM+AIlTTziZ7EZQ44XoH8
         Td0X4+G66vyH1nTAShYzKya0vpEgYEs0E8juWuWbbzXdvlgt6By1EVOtWCUmt7+2BtBB
         QeTEhLqrg5uT6mpTRYaWcPMGvosOM4JJHwUdRseVQ77fU016Ant1m0LWAFzmi8NUMnRO
         S8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563493; x=1761168293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFOj+Y3JzrGlsyh+9lR59Vs13yNcy5DdHPtE8235H5Q=;
        b=dWGgYiQYEVBqGi8gaJJ5HmkBgBeMI0P6hmCJ7xzFRZ2Eejoc3YOiEFWiOEnTsOXXsI
         +5UDw/HaRLPCsISSXoqCBf40FjJE/wtoyob5kpjSkVm8SmqCxSAhF4MQQqgE0pfyD4IS
         c+fba8bCjeob8l9iePkiY9aPX0pnIwylykgccDpgTeDO3HxOBCImGWkGdmsvtZsXi7UO
         3i1a6Fhhc4VGfv8tZP7oHyJ+jbYKIkTKvyMR9E9dKzRPvPDOl9E4Th/4aXEeAWPJpC7D
         ircrIoxqSmf8RMWpfPEg1fycY7DJhTaqO+0rNc0U01rL4s4pMySjHOG6D8KYjtNZ2+0z
         BGAw==
X-Forwarded-Encrypted: i=1; AJvYcCXcLl9D5vDnnqNNTAYjD3NBVc0RgoNCTw/EFZBXqOBNiiXxp+0rJVEc1yZ4kJVGZxyv6Ff5p+cDeLyY5jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1t/f9usp0uKWY4rj+iLHfyjXLf9rVRPBd2mOsmFaRr7TAAgO
	KpzOaqnQpyniJXJSBt24PRwyELstvOiDPX/oCaTaa0YA8vM8AySB368ZDW5dYRB5LqX6Agk8THS
	xpTWAROk4g9+NM7ybtIg+h9FT9pGFubz5cfOprw77
X-Gm-Gg: ASbGnctPvV2wFrN9WtcYU1mv4hgBSyHax5PmXlclUW5oTkT9MZQ+zK9QQ9ITiGhBZ+e
	67in480QXZx3y9QAl78+anoRY9wDKMbBNdpp8AP0sTP2oSlSF0dZLHG9fkcJX8e0JBx8NvFkANO
	wR06sYf5tpykGm1OgmvfH7ocbFny7WAtV99cz9WIJepFGCkCTKOvLk4Uvz9VYoCIOhXap7awddp
	KvoiBbkS6C6sNVbk6muNC7S6uOfF0tKMfoKEdU4BFgfgiZJaTgugkU43kqkVn2hD09Tb4CRXBSB
	xY+O85XImk7ca5a+A25lZDADA9Vz3edg
X-Google-Smtp-Source: AGHT+IEW5YPLjBUnEmpkq2n072rZTOEa3bB8A8FX6Qjm4Df+twFjbBIiYmmxKWceu6WF8JREJH8kbhCKirJwZ9Ey/fg=
X-Received: by 2002:a17:903:3884:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-29088b3a4e6mr6336795ad.3.1760563492415; Wed, 15 Oct 2025
 14:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com> <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
 <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
In-Reply-To: <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Oct 2025 14:24:40 -0700
X-Gm-Features: AS18NWDXk7S0rdGhapkXDUl7AG-b9T2LxalgMsX3Hw5djZFKJRshjXgu_HXKANM
Message-ID: <CAP-5=fX8ZV6WTmKcrrfPo0MUFiruJoWhYeUk3JrToEP=9-aPCA@mail.gmail.com>
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:39=E2=80=AFAM James Clark <james.clark@linaro.or=
g> wrote:
>
>
>
> On 15/10/2025 4:53 pm, Namhyung Kim wrote:
> > On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
> >
> >> Mirroring similar work for software events in commit 6e9fa4131abb
> >> ("perf parse-events: Remove non-json software events"). These changes
> >> migrate the legacy hardware and cache events to json.  With no hard
> >> coded legacy hardware or cache events the wild card, case
> >> insensitivity, etc. is consistent for events. This does, however, mean
> >> events like cycles will wild card against all PMUs. A change doing the
> >> same was originally posted and merged from:
> >> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> >> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> >> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> >> his dislike for the cycles behavior on ARM with perf record. Earlier
> >> patches in this series make perf record event opening failures
> >> non-fatal and hide the cycles event's failure to open on ARM in perf
> >> record, so it is expected the behavior will now be transparent in perf
> >> record on ARM. perf stat with a cycles event will wildcard open the
> >> event on all PMUs, however, with default events the cycles event will
> >> only be opened on core PMUs.
> >>
> >> [...]
> >
> > Applied to perf-tools-next, thanks!
> >
> > Best regards,
> > Namhyung
> >
>
> Hi Namhyung,
>
> I'm still getting the build failure that I mentioned on patch 5. This
> only seems to happen with out of source builds:
>
>    $ make -C tools/perf O=3D../build/local/ V=3D1
>
>
>    static const struct pmu_sys_events pmu_sys_event_tables[] =3D {
>          {
> -               .event_table =3D {
> -                       .pmus =3D pmu_events__test_soc_sys,
> -                       .num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_sys=
)
> -               },
> -               .name =3D "pmu_events__test_soc_sys",
> -       },
> -       {
>                  .event_table =3D { 0, 0 },
>                  .metric_table =3D { 0, 0 },
>          },
> make[3]: *** [pmu-events/Build:54:
> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log]
> Error 1

Sorry for the issue. Is this happening when you don't do a clean
first? I tried recreating your output path, but I can't reproduce the
issue on a clean build. The diff above indicates some issue with the
Makefile processing tools/perf/pmu-events/arch/test/test_soc/. This
directory should be copied to
../build/local/pmu-events/arch/test/test_soc/ and so I wonder if the
copy failed for some reason.

The copy rule is:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n33
```
# Copy checked-in json for generation.
$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
$(call rule_mkdir)
$(Q)$(call echo-cmd,gen)cp $< $@
```

The mapping of file names happens in the patsubst in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n42
```
GEN_JSON =3D $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
```

Those files are dependencies for the empty-pmu-events.c test so I'm
not sure how this can be failing for you.

Thanks,
Ian

