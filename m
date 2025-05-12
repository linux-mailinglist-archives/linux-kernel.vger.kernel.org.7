Return-Path: <linux-kernel+bounces-644579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724FAB3E92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697A21689A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543326561A;
	Mon, 12 May 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1+O3fQJ"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3795266566
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069080; cv=none; b=gTnct9sfzAUMFc6cYFVrJ1N0HnkGvPUXz2S0TRnvLR6SouYlWZRcC9LLV6AWme9riBAMAs8O2jvefDGledMzrCkGDccRQJEM0StCv4298+CcC0CgUqV4a5c8pWcnum4yVzwp+U9520mJ2cqXam8nMCdBcY0qfZqBaQDVE8DlPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069080; c=relaxed/simple;
	bh=ynLKaaUGTDfAgS+nKrfsEg6ldDlqJS7zqgcK18hXF3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIU6neP6t57R637gH2ANIdH/D6voYXC5Ea080Y+WxlhgCfBd8OZt6wiPZWSXlWNFlueo2fKNoueK5le8dmZkpwl3NM5rM5CoZNmYs7gkj+2zdco8gdlvWpktPkW5bvRljaTs+PrmWgq35zktyOYpFYRvK/aFP5sfqDIn4a4NcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w1+O3fQJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so9785ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747069078; x=1747673878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRIADOe4MgrN1DSQVCN+js6hsUX4yX+bQNoO/gFotgI=;
        b=w1+O3fQJ5LR/BHWSHTwekkVH4eUC8KFRSN9MZaZv2EKdS2CxhIf0d8vIPr12Cl5Fpz
         T4Jc5ZjEoEuXvkwDrHJ/9DZs7yRoFVUnJCgIlo7TzjQfR0y7pr6ZARXWtJzxZpMSkyBo
         sH+P6fNVrtVWh2Nif5kgg1tuCoowZfCmA9cO3WRPWQJxA+WWBcvpVbHjf1yenLqLvOAb
         GTCQm+nM4HZg0LM/yJ6AnfdNqp15OqucL+FnCWF8u514aU63KmgN3sgqUCkpR7BHdPne
         SCrDjXxCRGIgxpVH9Titr2umDXKilXEOvQ8A2EesGBebJCdRDPn82JTkRUuuUDnmZ/78
         d+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747069078; x=1747673878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRIADOe4MgrN1DSQVCN+js6hsUX4yX+bQNoO/gFotgI=;
        b=YGkKP6JM8P9mUX2VVd99hxA3ZTEyH4rl9TNWwtchxDTJZaZLMDPru0wj443lh5WZgx
         dAxd+Asz2OXkyR5ZylsqhrshzaKp4BLLvJ88RlJheoEw/4A37ZGEy7+qEik+E7iz1T5W
         4FnBOj12s2XTivuEBIZid0CXFMCmoaUj9LiTTyQaREEs4YvLeiXjGJOW35uAwzbfaM+m
         qrf3494t3frCD3sC6n0S3NcVDoe0lLFWi9VZqBaUF0+r6ZQNz9v0MFXoxds8sbT/eV5e
         gWrhy20PPxqQkpVPOU/oh0gQhT+eeINACi6drEVGMgQTFScWY+vRKYgmV33bcTJD6Qqm
         k5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAriyyXYkBkBtIFzb2Bt+4w76uxSlLQCQBUWAZqbmwOCpZE08WCtZbuOTpiGpHhH19IvbQYIPJhZ3OWlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKeFOV7GFtobfA6rRAAJbGvxQY5STjCx8DuBq+rlpZqoBKHOx
	bbCWNYPdEttxB2BJcp9eHMZ65VmXVKeNRfPCp/7q/3u7wsxX626UuGi55+9NCUaPsoDr76hz3Wg
	U7iEV3oODzgMlhF+u8w8t0mxqv5J/bGRzRuEI
X-Gm-Gg: ASbGncsrjeAi290OTwg3MHQLM6rOsivWnw3iyCkqVMejUW+J/EkTD77M5Hm3QfyHsYx
	MIRhRvfKhli0DpA3I0h3LgNMrLKsnPxuKzM35QzWWXKLRdwWOQyLU1AxtjxO2famrbScVMTCLTa
	REP3ErX7jjrFsUq7wDpadZg5dmVLE8MqGlrhdPv22xV1ehEbKT6xJKluZoYCIeyA==
X-Google-Smtp-Source: AGHT+IHOngqmXBHGtgDCgZ0Zmv/o9X5U7f+4TuL2mpqS+AYX3UuzMeZWZaipLe4DNzhn/mmMpggQ1O8fDNScBbxv59s=
X-Received: by 2002:a05:6e02:1a6e:b0:3d4:2a4e:1283 with SMTP id
 e9e14a558f8ab-3da842eee9dmr5412375ab.1.1747069077404; Mon, 12 May 2025
 09:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410044532.52017-1-irogers@google.com> <Z_dp7E2wtSek-KHo@z2>
 <CAP-5=fU6NM4LZWt9SdTFX9JKTgfghwAVvtXc-qBuUb0vpUeTQA@mail.gmail.com> <aCIkl8Skof--Of99@x1>
In-Reply-To: <aCIkl8Skof--Of99@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 May 2025 09:57:45 -0700
X-Gm-Features: AX0GCFsL9F-NeeIrpp99ODVTrLtBx-sFYJbvO6TOvca_AxerUk3-e4rvEPQ3qKI
Message-ID: <CAP-5=fWFRtnVjeNu97jW6DYyE8S7o8RkSn87jpQDE4zw==HVSQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Metric related performance improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 9:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 23, 2025 at 01:48:22PM -0700, Ian Rogers wrote:
> > On Wed, Apr 9, 2025 at 11:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Apr 09, 2025 at 09:45:29PM -0700, Ian Rogers wrote:
> > > > The "PMU JSON event tests" have been running slowly, these changes
> > > > target improving them with an improvement of the test running 8 to =
10
> > > > times faster.
> > > >
> > > > The first patch changes from searching through all aliases by name =
in
> > > > a list to using a hashmap. Doing a fast hashmap__find means testing
> > > > for having an event needn't load from disk if an event is already
> > > > present.
> > > >
> > > > The second patch switch the fncache to use a hashmap rather than it=
s
> > > > own hashmap with a limited number of buckets. When there are many
> > > > filename queries, such as with a test, there are many collisions wi=
th
> > > > the previous fncache approach leading to linear searching of the
> > > > entries.
> > > >
> > > > The final patch adds a find function for metrics. Normally metrics =
can
> > > > match by name and group, however, only name matching happens when o=
ne
> > > > metric refers to another. As we test every "id" in a metric to see =
if
> > > > it is a metric, the find function can dominate performance as it
> > > > linearly searches all metrics. Add a find function for the metrics
> > > > table so that a metric can be found by name with a binary search.
> > > >
> > > > Before these changes:
> > > > ```
> > > > $ time perf test -v 10
> > > >  10: PMU JSON event tests                                          =
  :
> > > >  10.1: PMU event table sanity                                      =
  : Ok
> > > >  10.2: PMU event map aliases                                       =
  : Ok
> > > >  10.3: Parsing of PMU event table metrics                          =
  : Ok
> > > >  10.4: Parsing of PMU event table metrics with fake PMUs           =
  : Ok
> > > >  10.5: Parsing of metric thresholds with fake PMUs                 =
  : Ok
> > > >
> > > > real    0m18.499s
> > > > user    0m18.150s
> > > > sys     0m3.273s
> > > > ```
> > > >
> > > > After these changes:
> > > > ```
> > > > $ time perf test -v 10
> > > >  10: PMU JSON event tests                                          =
  :
> > > >  10.1: PMU event table sanity                                      =
  : Ok
> > > >  10.2: PMU event map aliases                                       =
  : Ok
> > > >  10.3: Parsing of PMU event table metrics                          =
  : Ok
> > > >  10.4: Parsing of PMU event table metrics with fake PMUs           =
  : Ok
> > > >  10.5: Parsing of metric thresholds with fake PMUs                 =
  : Ok
> > > >
> > > > real    0m2.338s
> > > > user    0m1.797s
> > > > sys     0m2.186s
> > > > ```
> > >
> > > Great, I also see the speedup on my machine from 32s to 3s.
> > >
> > > Tested-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Ping.
>
> I'll try to fix up it later, if you don't beat me to it, will continue
> with the other patches you listed to get the ones that applies merged:
>
> Total patches: 3
> ---
> Cover: ./20250409_irogers_metric_related_performance_improvements.cover
>  Link: https://lore.kernel.org/r/20250410044532.52017-1-irogers@google.co=
m
>  Base: not specified
>        git am ./20250409_irogers_metric_related_performance_improvements.=
mbx
> =E2=AC=A2 [acme@toolbx perf-tools-next]$        git am ./20250409_irogers=
_metric_related_performance_improvements.mbx
> Applying: perf pmu: Change aliases from list to hashmap
> error: patch failed: tools/perf/util/pmu.c:532
> error: tools/perf/util/pmu.c: patch does not apply
> Patch failed at 0001 perf pmu: Change aliases from list to hashmap
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git am --abort
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < ./20250409_irogers_m=
etric_related_performance_improvements.mbx
> patching file tools/perf/tests/pmu-events.c
> patching file tools/perf/util/hwmon_pmu.c
> patching file tools/perf/util/pmu.c
> Hunk #3 succeeded at 417 (offset 11 lines).
> Hunk #4 succeeded at 451 (offset 11 lines).
> Hunk #5 FAILED at 541.
> Hunk #6 succeeded at 657 (offset 41 lines).
> Hunk #7 succeeded at 1146 (offset 41 lines).
> Hunk #8 succeeded at 1238 (offset 41 lines).
> Hunk #9 succeeded at 1259 (offset 41 lines).
> Hunk #10 succeeded at 2018 (offset 48 lines).
> Hunk #11 succeeded at 2033 (offset 48 lines).
> Hunk #12 succeeded at 2502 (offset 59 lines).
> Hunk #13 succeeded at 2522 (offset 59 lines).
> 1 out of 13 hunks FAILED -- saving rejects to file tools/perf/util/pmu.c.=
rej
> patching file tools/perf/util/pmu.h
> Hunk #3 succeeded at 295 (offset 5 lines).
> patching file tools/perf/util/tool_pmu.c
> Hunk #1 succeeded at 502 (offset 6 lines).
> patching file tools/perf/util/fncache.c
> patching file tools/perf/util/fncache.h
> patching file tools/perf/util/srccode.c
> patching file tools/perf/builtin-stat.c
> Hunk #1 succeeded at 1854 (offset -2 lines).
> Hunk #2 succeeded at 1888 (offset -2 lines).
> Hunk #3 succeeded at 1978 (offset -2 lines).
> patching file tools/perf/pmu-events/empty-pmu-events.c
> Hunk #1 succeeded at 449 (offset 6 lines).
> Hunk #2 succeeded at 495 (offset 6 lines).
> Hunk #3 succeeded at 552 (offset 6 lines).
> patching file tools/perf/pmu-events/jevents.py
> Hunk #1 succeeded at 972 (offset 6 lines).
> Hunk #2 succeeded at 1018 (offset 6 lines).
> Hunk #3 succeeded at 1075 (offset 6 lines).
> patching file tools/perf/pmu-events/pmu-events.h
> Hunk #1 succeeded at 74 (offset 3 lines).
> Hunk #2 succeeded at 89 (offset 3 lines).
> Hunk #3 succeeded at 105 (offset 3 lines).
> patching file tools/perf/util/metricgroup.c
> patching file tools/perf/util/metricgroup.h
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

Thanks Arnaldo! Happy to send a rebase on tmp.perf-tools-next if useful.

Thanks,
Ian

