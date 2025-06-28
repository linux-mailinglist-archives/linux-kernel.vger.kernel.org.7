Return-Path: <linux-kernel+bounces-707349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2116DAEC2EA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CC74A751B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 23:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7F28DB6D;
	Fri, 27 Jun 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbmmN9MH"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34B262D14
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751065937; cv=none; b=PTFcSp1Ra1QygTrHzgtXDX9iioF91U3DZzzm+x7sVoWYn2ZfkEC6woMZyoPrE7f3d7gjlbEyGE8Q7XCbYcSoa5YxWDMwqWQELRc4/dPYnon6cwVU3uStpi+NarNl1ZCOPD8T0/eIFXhfcFOxdIz+DHhcMLRiY2pKZxG9j5VWVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751065937; c=relaxed/simple;
	bh=YuqwH8cbCH5F3qAu2+0Ut4+LEcu+ucY0mniwxqXcIow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhOmL4C2sdUj6rYNg+wJf1tvnRcIYfLnfk4BkvslNwPutcX3yMmATHRsnJY6j109U/jAKpSE4zdwb/Ks/GKrY1HxYRIiZrSK/TgItxGnI80VdAE+MvKctou6c0hlJ/Vm0HXdSxJtRL+4KnDmZAZhufE1gNE+638bgFdGyL49DNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbmmN9MH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so117315ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751065935; x=1751670735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1zvsSb8Lx5PZaedN0uK/WI1ZEPyBwoWV3MPpqK56ns=;
        b=wbmmN9MHTiG8zjqeab7MBDUKYhRqU/6Aoe6ii2lMAukk5PCzl3xnIz3V0jn9r4ZPzS
         JtMFCIetiS3/8AO4tIg5cP9JMx1JbIQIbLNtrIFw076/DSkI3ltblMBB4zyFxyabeLgg
         ehLYSDGdVmpbujaCBQiGvgX9YRy9uRAQH3c4U0069PDdpS9TgKmZHJIMSePaG5SA5Kh8
         xLBzl/+hOqWQH+Fngz8eCCSaraSPQqxJx7NnlLZ/KM/CilINXBzoXxGm8Hqgq7DODc1K
         /9qcY8m/WcjNjgNUt0EBGFcN3qXgbzHW9g0k0XwrYHYpRlheFFgbU9aUjH2+Q12oGNdl
         Bc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751065935; x=1751670735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1zvsSb8Lx5PZaedN0uK/WI1ZEPyBwoWV3MPpqK56ns=;
        b=h7qw9tJXnkSXucJpxS9QrGxhS8BlquMxV3zbLUHy+wF0CP30ZYLzEXRzhCfFczzLPM
         mpOMmI6/KPwnRmWpE4xBG+geLLPHsXDlFcJLv29vE22+E/nMFKs7BHOiFDggJfT3aVpb
         NVVA4qjfSVtKBky2G8pyDCqLaestZqnUfGujTkEvaCy7Rpl5Z19rvmlsIhFZwfm/XVCA
         0e8DLwrT7ihX0PZ5OTHSalGHjpI1oAd80B0UwLjTIT6KzXXXc+9MDhUjMaww68O0MSdp
         GbxQgZH6HHfJmry+FtZziaTOG2614SckbA9vTtHy9/sOAgEX8mEUW3DJB8rBTBNfuOxB
         zXmw==
X-Gm-Message-State: AOJu0YxkJHVCFHDauDe97npI1QUXVYCaDcZT3UrC3fmj5QVSWwiWXkS+
	fWno9v4R3DLqxGjCwu6muVo6xADIdn1JsKDNdveA9RT31tTQ1aQtt7qb+bgEhdoiF02LGtPJ9RN
	SkbXJSKoIezJdz3rMNLLnkJf19GPmAhb8qlhbu4cmX68P/6sm+dd0KWlO
X-Gm-Gg: ASbGncsjOh80ZvGzGVslY9tM74q1ioQQU4u50O8fHiUY5Z3e0zPg5rUcintlp6xPtJF
	SfumetJFsHUvNOBUqlczFwatCLbKJ6fNAnBrYs7+ZwRQlgfECfjEa3rLhQ1LqWC4p3ig3ISFhwH
	BFmGqmaX/L6NW19I7CD59oJOznyhSFiWti2JSGQl27lfGF
X-Google-Smtp-Source: AGHT+IFiP9mgaAJu7hY8feMZdxPoDLsyOz0/rHLfCq881q0Uf/Jvvpxq3KdhXMNp2+26ZOi5jwxVzVPx3mDloKwQEJ8=
X-Received: by 2002:a05:6e02:1a6d:b0:3dd:a7f3:a229 with SMTP id
 e9e14a558f8ab-3df55712664mr1324585ab.4.1751065934740; Fri, 27 Jun 2025
 16:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627201818.479421-1-ctshao@google.com>
In-Reply-To: <20250627201818.479421-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 16:12:03 -0700
X-Gm-Features: Ac12FXwXycCiyMHk4wB7XkLW-Sdugex5_McwQgLKn577VRsOKCxxln4khGONKAg
Message-ID: <CAP-5=fWJD4gT+CxBLDdjbdrJF0xyPTobPu20LSZFf-RSJAXMpg@mail.gmail.com>
Subject: Re: [PATCH v4] perf stat: Fix uncore aggregation number
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, weilin.wang@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 1:18=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Follow up:
> lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZFMcsnOOJgX4Kg@m=
ail.gmail.com/
>
> The patch adds unit aggregation during evsel merge the aggregated uncore
> counters. Change the name of the column to `ctrs` and `counters` for
> json mode.
>
> Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> cpumask=3D"0,120"
> Before:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket cpus             counts unit events
>        1.001085024 S0        1         9615386315      clockticks
>        1.001085024 S1        1         9614287448      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   cpus             counts unit events
>        1.001029867 N0        1         3205726984      clockticks
>        1.001029867 N1        1         3205444421      clockticks
>        1.001029867 N2        1         3205234018      clockticks
>        1.001029867 N3        1         3205224660      clockticks
>        1.001029867 N4        1         3205207213      clockticks
>        1.001029867 N5        1         3205528246      clockticks
> After:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket ctrs             counts unit events
>        1.001026071 S0       12         9619677996      clockticks
>        1.001026071 S1       12         9618612614      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   ctrs             counts unit events
>        1.001027449 N0        4         3207251859      clockticks
>        1.001027449 N1        4         3207315930      clockticks
>        1.001027449 N2        4         3206981828      clockticks
>        1.001027449 N3        4         3206566126      clockticks
>        1.001027449 N4        4         3206032609      clockticks
>        1.001027449 N5        4         3205651355      clockticks
>
> Tested with JSON output linter:
>   perf test "perf stat JSON output linter"
>    94: perf stat JSON output linter                                    : =
Ok
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v4:
>   Modify perf-stat.txt and json output lint test
>
> v3: https://lore.kernel.org/20250624221545.1711008-1-ctshao@google.com/
>   Rename the column to `ctrs` and `counters` in json mode.
>
> v2: https://lore.kernel.org/20250612225324.3315450-1-ctshao@google.com/
>   Rename the column to `aggr_nr`.
>   Remove unnecessary comment.
>
> v1: https://lore.kernel.org/20250611233239.3098064-1-ctshao@google.com/
>
>
>  tools/perf/Documentation/perf-stat.txt        |  6 ++--
>  .../tests/shell/lib/perf_json_output_lint.py  |  4 +--
>  tools/perf/util/stat-display.c                | 34 +++++++++----------
>  tools/perf/util/stat.c                        |  2 +-
>  4 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index 61d091670dee..1a766d4a2233 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -640,18 +640,20 @@ JSON FORMAT
>  With -j, perf stat is able to print out a JSON format output
>  that can be used for parsing.
>
> -- timestamp : optional usec time stamp in fractions of second (with -I)
> +- interval : optional timestamp in fractions of second (with -I)
>  - optional aggregate options:
>                 - core : core identifier (with --per-core)
>                 - die : die identifier (with --per-die)
>                 - socket : socket identifier (with --per-socket)
>                 - node : node identifier (with --per-node)
>                 - thread : thread identifier (with --per-thread)
> +- counters : number of aggregated PMU counters
>  - counter-value : counter value
>  - unit : unit of the counter value or empty
>  - event : event name
>  - variance : optional variance if multiple values are collected (with -r=
)
> -- runtime : run time of counter
> +- event-runtime : run time of the event
> +- pcnt-running : percentage of time the event was running
>  - metric-value : optional metric value
>  - metric-unit : optional unit of metric
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index 9e772a89ce38..c6750ef06c0f 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -45,7 +45,7 @@ def is_counter_value(num):
>
>  def check_json_output(expected_items):
>    checks =3D {
> -      'aggregate-number': lambda x: isfloat(x),
> +      'counters': lambda x: isfloat(x),
>        'core': lambda x: True,
>        'counter-value': lambda x: is_counter_value(x),
>        'cgroup': lambda x: True,
> @@ -75,7 +75,7 @@ def check_json_output(expected_items):
>        if count not in expected_items and count >=3D 1 and count <=3D 7 a=
nd 'metric-value' in item:
>          # Events that generate >1 metric may have isolated metric
>          # values and possibly other prefixes like interval, core,
> -        # aggregate-number, or event-runtime/pcnt-running from multiplex=
ing.
> +        # counters, or event-runtime/pcnt-running from multiplexing.
>          pass
>        elif count not in expected_items and count >=3D 1 and count <=3D 5=
 and 'metricgroup' in item:
>          pass
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 729ad5cd52cb..9cb5245a92aa 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -50,15 +50,15 @@ static int aggr_header_lens[] =3D {
>  };
>
>  static const char *aggr_header_csv[] =3D {
> -       [AGGR_CORE]     =3D       "core,cpus,",
> -       [AGGR_CACHE]    =3D       "cache,cpus,",
> -       [AGGR_CLUSTER]  =3D       "cluster,cpus,",
> -       [AGGR_DIE]      =3D       "die,cpus,",
> -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> -       [AGGR_NONE]     =3D       "cpu,",
> -       [AGGR_THREAD]   =3D       "comm-pid,",
> -       [AGGR_NODE]     =3D       "node,",
> -       [AGGR_GLOBAL]   =3D       ""
> +       [AGGR_CORE]     =3D       "core,ctrs,",
> +       [AGGR_CACHE]    =3D       "cache,ctrs,",
> +       [AGGR_CLUSTER]  =3D       "cluster,ctrs,",
> +       [AGGR_DIE]      =3D       "die,ctrs,",
> +       [AGGR_SOCKET]   =3D       "socket,ctrs,",
> +       [AGGR_NONE]     =3D       "cpu,",
> +       [AGGR_THREAD]   =3D       "comm-pid,",
> +       [AGGR_NODE]     =3D       "node,",
> +       [AGGR_GLOBAL]   =3D       ""
>  };
>
>  static const char *aggr_header_std[] =3D {
> @@ -304,7 +304,7 @@ static void print_aggr_id_std(struct perf_stat_config=
 *config,
>                 return;
>         }
>
> -       fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, aggr_=
nr);
> +       fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, /*strlen=
("ctrs")*/ 4, aggr_nr);
>  }
>
>  static void print_aggr_id_csv(struct perf_stat_config *config,
> @@ -366,27 +366,27 @@ static void print_aggr_id_json(struct perf_stat_con=
fig *config, struct outstate
>  {
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> -               json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-num=
ber\" : %d",
> +               json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : =
%d",
>                         id.socket, id.die, id.core, aggr_nr);
>                 break;
>         case AGGR_CACHE:
> -               json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggrega=
te-number\" : %d",
> +               json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counter=
s\" : %d",
>                         id.socket, id.die, id.cache_lvl, id.cache, aggr_n=
r);
>                 break;
>         case AGGR_CLUSTER:
> -               json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregat=
e-number\" : %d",
> +               json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters=
\" : %d",
>                         id.socket, id.die, id.cluster, aggr_nr);
>                 break;
>         case AGGR_DIE:
> -               json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\"=
 : %d",
> +               json_out(os, "\"die\" : \"S%d-D%d\", \"counters\" : %d",
>                         id.socket, id.die, aggr_nr);
>                 break;
>         case AGGR_SOCKET:
> -               json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" =
: %d",
> +               json_out(os, "\"socket\" : \"S%d\", \"counters\" : %d",
>                         id.socket, aggr_nr);
>                 break;
>         case AGGR_NODE:
> -               json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : =
%d",
> +               json_out(os, "\"node\" : \"N%d\", \"counters\" : %d",
>                         id.node, aggr_nr);
>                 break;
>         case AGGR_NONE:
> @@ -1317,7 +1317,7 @@ static void print_header_interval_std(struct perf_s=
tat_config *config,
>         case AGGR_CLUSTER:
>         case AGGR_CACHE:
>         case AGGR_CORE:
> -               fprintf(output, "#%*s %-*s cpus",
> +               fprintf(output, "#%*s %-*s ctrs",
>                         INTERVAL_LEN - 1, "time",
>                         aggr_header_lens[config->aggr_mode],
>                         aggr_header_std[config->aggr_mode]);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 355a7d5c8ab8..b0205e99a4c9 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -526,7 +526,7 @@ static int evsel__merge_aggr_counters(struct evsel *e=
vsel, struct evsel *alias)
>                 struct perf_counts_values *aggr_counts_a =3D &ps_a->aggr[=
i].counts;
>                 struct perf_counts_values *aggr_counts_b =3D &ps_b->aggr[=
i].counts;
>
> -               /* NB: don't increase aggr.nr for aliases */
> +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
>
>                 aggr_counts_a->val +=3D aggr_counts_b->val;
>                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

