Return-Path: <linux-kernel+bounces-617167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B03A99BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 00:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BB13B04A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642121FF47;
	Wed, 23 Apr 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnWMNJ/a"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C86139566
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448552; cv=none; b=JNoIegYx08HEOp5PK4gFeX2GPabRvmCVC8vEcGOldEtsAzOkqQZKruJ5Gp4eZmOzMX5y0yP3bpJXuUUHXxEW4xetW8lD1M1jKJVeYZEvC32ILf5Shsv+OhdTADRHfmLB2qaGmmWG9yzCZAgp01juEQliKd1HNWfe9iGUrHH1I/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448552; c=relaxed/simple;
	bh=1Gi0O3bymMAhwOE7EO9gUhKQ5ASLF7SPZ8b+OzOFjI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKt2PdBbnwVBXEJTYq1KrqT6EslfxDAdozmw+tOvRziwKf2z4Xx0fzZe5FGkVdKNdu+Ec8sNvE2PsfiU2HaZeZFCnGGmcOtoVTcXoWAEJRL7LSQG4kYOC/kuck8YZ77CbBkwTCu3F+XwODtAAfjlZODqg1rv4AYug9XrDp02Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnWMNJ/a; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb615228a4so256376366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745448549; x=1746053349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFqMsc9Cgrc/jOwHdKO+Q6o7jkhid+GmOd9W2mEHoHY=;
        b=cnWMNJ/a9UDVqY1QAMgi68edJFwQ0x4rKWKnWZszqmk6Vq2bdWGIRI30zlP3eYheUH
         wpHFf1TMsI6/8t5kk+gi//Ayv0S9OIH0Zn5kLEyqJMd0jG88bELti3yyWyaWR7z8BC/U
         tZv7Z8TPLxF8/JMd85DseQQUu6siXYS6F17igEw6uookl+kqPReG5pvwy6sZUqPuqEcz
         w2QenS40Zsdp/eltm55zG59cYfKXFiGOb+2kloyZ/2pAw/BinF/NNf+IUJx62m9lgnCG
         rd3NK1oqWFukaN/JoqY7Hpp59+vRFTMm3Xm4FUwqzPRGPQw3+intc82l4gEedIfvuoxs
         UBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745448549; x=1746053349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFqMsc9Cgrc/jOwHdKO+Q6o7jkhid+GmOd9W2mEHoHY=;
        b=vxQ4IOJElmeqDcymiLiecrtBMV6lq7dI78XFBOIqcGlCTWJ8t5aoH5PQnY/n3Zfxak
         CaAaXq5w95vcjEADseR+DpJvwoTj7jwRzjr3oeUKEJbSRVUq6M3CWTUqrRtGo6oSyUqB
         8P8MufBvtoEQxYbH2NgIKnOV8z+mYdzI7r9hUkFKAqc4WQkRMyjbJk+UOcz9SOcD8WUM
         6D2KCfwxesFnefEVz8C/5fmkL0Shg+W3Y3nzecX6DoAXcHqa/lYlenAQZR2+gXYL6A9/
         l+Ls+o2PiHTouCf3fpzrg/5LMct8L6m6MxeNFO2wzPLWVBfhdoNsVLE/lqrlMm+4gtFc
         gZng==
X-Gm-Message-State: AOJu0YzcZ63dGfnT8D2QqHbcM8pTmrpedksroaS3oZq//8f6FhF8PUm6
	k+vn3LNEa4R91Yx+zqqyUQudZuBbRl3/mtrZL77YKMiZHYcsCVPiuKDggyMdMDxmPMcYAHBO66/
	80y88Ba7mThZt33UvH36Z7qA/7jLwkVFkv1XL
X-Gm-Gg: ASbGncuRD83tpCX+EA6o5WV03FvWQtEOCOO+kxPS+WrV5BBsSNG9SnDMGRTV4MDgAxt
	jA9Ti2P6MkvdIx3srl25e1Y71glXymmSOWLzPDqj28D0yykLexu1tPdjxRpFJjJ4O8rKYtp+RSj
	wpTTyW1VXr+WlFS91jTdi7+2UzyUa82nfcXj/ZZ5KAQC03D48=
X-Google-Smtp-Source: AGHT+IF8vhtPElp2/qNIeSObRCOdb1stNKogQ7L4t9EfEQ/ciGeZ8TDp+qkyekR47NwH27EEaH1CJUxWIZvWrUjAuU0=
X-Received: by 2002:a17:907:2d13:b0:ace:395c:124d with SMTP id
 a640c23a62f3a-ace5a40501bmr9619966b.25.1745448549160; Wed, 23 Apr 2025
 15:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com> <20250327225651.642965-4-ctshao@google.com>
 <CAP-5=fU37XBFa-kft5JYPO+BCWP5zGnfZCkCqvzYW-yozF8o0g@mail.gmail.com>
In-Reply-To: <CAP-5=fU37XBFa-kft5JYPO+BCWP5zGnfZCkCqvzYW-yozF8o0g@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 23 Apr 2025 15:48:57 -0700
X-Gm-Features: ATxdqUGAMv_9OU25H2O9bUU4wBlTXm4ZUK_M0yXfJBA5sp3etcIw-e-NvW66MDk
Message-ID: <CAJpZYjXZGXFC8CwKahCya9sB6J6OOOdsX7=X9mdPfyxQ7DAGGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Add stat uniquifying test
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, james.clark@linaro.org, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:25=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 27, 2025 at 4:01=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > The `stat+uniquify.sh` test retrieves all uniquified `clockticks` event=
s
> > from `perf list -v clockticks` and check if `perf stat -e clockticks -A=
`
> > contains all of them.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../tests/shell/stat+event_uniquifying.sh     | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
> >
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/p=
erf/tests/shell/stat+event_uniquifying.sh
> > new file mode 100755
> > index 000000000000..5ec35c52b7d9
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -0,0 +1,69 @@
> > +#!/bin/bash
> > +# perf stat events uniquifying
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> > +perf_tool=3Dperf
> > +err=3D0
> > +
> > +test_event_uniquifying() {
> > +  # We use `clockticks` to verify the uniquify behavior.
> > +  event=3D"clockticks"
>
> This event is generally only available on Intel, not AMD or ARM, so we
> will need to skip if it isn't present.
>
> > +  # If the `-A` option is added, the event should be uniquified.
> > +  #
> > +  # $perf list -v clockticks
> > +  #
> > +  # List of pre-defined events (to be used in -e or -M):
> > +  #
> > +  #   uncore_imc_0/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_1/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_2/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_3/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_4/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_5/clockticks/                           [Kernel PMU e=
vent]
> > +  #
> > +  #   ...
> > +  #
> > +  # $perf stat -e clockticks -A -- true
> > +  #
> > +  #  Performance counter stats for 'system wide':
> > +  #
> > +  # CPU0            3,773,018      uncore_imc_0/clockticks/
> > +  # CPU0            3,609,025      uncore_imc_1/clockticks/
> > +  # CPU0                    0      uncore_imc_2/clockticks/
> > +  # CPU0            3,230,009      uncore_imc_3/clockticks/
> > +  # CPU0            3,049,897      uncore_imc_4/clockticks/
> > +  # CPU0                    0      uncore_imc_5/clockticks/
> > +  #
> > +  #        0.002029828 seconds time elapsed
> > +
> > +  echo "stat event uniquifying test"
> > +  uniquified_event_array=3D()
> > +
> > +  # Check how many uniquified events.
> > +  while IFS=3D read -r line; do
> > +    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> > +    uniquified_event_array+=3D("${uniquified_event}")
> > +  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]"=
)
>
> Shouldn't the array contain every sysfs event that doesn't have a json
> component? They may or may not be uniquified so I think the array name
> is misleading.
>
> > +  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- =
true"
> > +  $perf_command
> > +
> > +  # Check the output contains all uniquified events.
> > +  for uniquified_event in "${uniquified_event_array[@]}"; do
> > +    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
>
> Why not pass the file directly to grep?
> Should some of the events not show in the stat output as you only
> asked for the clockticks event? I'm not sure how this test can pass
> currently.
>
> Thanks,
> Ian
>
Thanks for your comment, Ian.

I tried to run `perf list -v clockticks` and grep for all events which
have `[Kernel PMU event]` tag.
Ideally, that should retrieve all uniquified clockticks events.
Then I ran `perf stat -e clockticks` to check if all events from `perf
list` are showing.

I randomly picked some machines from different arches and it seems
work. Let me know if you have a better idea.

-CT

> > +      echo "Event is not uniquified [Failed]"
> > +      echo "${perf_command}"
> > +      cat "${stat_output}"
> > +      err=3D1
> > +      break
> > +    fi
> > +  done
> > +}
> > +
> > +test_event_uniquifying
> > +rm -f "${stat_output}"
> > +exit $err
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >

