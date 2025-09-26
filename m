Return-Path: <linux-kernel+bounces-834390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839EBA4990
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27ED3B7A31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5125A321;
	Fri, 26 Sep 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXLigA59"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1F258EE0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903725; cv=none; b=U8+zq09ggrQ/seifTkX/M5i0W0TFil7DX00n5aUZ0eg136G36yeLQNTVLEuwT+8968jHcYtwUrmF/8Rq0vQu7mz1tCTopPX6aE5oSX0hByJPdkFcU2bC1+X0PNdJ8IIIllV10sCIWelp2BByVWi9SnB2TxSfVf7jQEfUzmAMFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903725; c=relaxed/simple;
	bh=jKQgITJETmiKBhjkFFquLptVvWyo2EP8SeSJGnVWpsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By0s0Jp6Nga5lSQLJiREi/gTmkS0MxgDxoUh0EnB1xEEvrkqFARbgNDsTg1EaLas51p++tyL3WdSMEdSn/Uv0eDC6OHABtivL/dp4ABAgiEj4rwBPJFhyjA0X3yZiJi6VFm8GiDvbfR80WXiBvAr6SQ59RCaVOe9CkYZsNmNgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXLigA59; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27eeafd4882so272985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758903722; x=1759508522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CWqaOIIMqQoIlIoSgBGZRVgT39iKXnozMq47+0udes=;
        b=sXLigA59VRqBQ1m+pt92Ol8NDF6Y6eIxuCdT7SHlBoLty9l8ZMpkPAeMThsVD+xu12
         DDUghTjFlH+TvhKDsYCEoSt/Rlw4pj+jKXRvxojhc+V1cUP0Cp9a8l3WPjymjBR1T5N2
         h9IfORaZZ6pb2et2E+MNpXDZCAX4v/QNy9mulMjoU7INAwuVtC+QjDqFdHvfxbq6o9Tb
         MSKMMJGbyGhp0fU1qI7K8fNf460Qd6QakKj+NtHrHsg8NwH0Ffo0RbY4Eu2yUpqpismk
         6SWdtOCc0WyvVBTu4qTO1jXRvq8uPIWQhemzUyZCNdSV53aOBSXDneRzXdXMi5Daw2G7
         wgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903722; x=1759508522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CWqaOIIMqQoIlIoSgBGZRVgT39iKXnozMq47+0udes=;
        b=RnZnw4FgPk8QB85AB+tqjDIXv1hHnCNNajgMIl+dpbfbwKkx+ijpDiMxqWBv1x2C+v
         S32p6DfFpwOnNA6V+4dYunAtMOT+5ahsk+xty4CxJeWzxRrMvmtcg7DjIU8iaO4ixGL5
         nIF87MBfNGDMgHg8jUDUTyBdPw3YcoT+XUZFYhifBLf4tInbeePbBX3tXDrOJdyDMpVE
         aX/oUZKKLqe7rSXBEuWUuPUwQES5Q41wDoaKspomZcJL+MoXGysrAmA0co7RLfA5UDfK
         PHcgWaiSZK6i9czTdlm9M9DITUXKPRYf4Zdh9HDRTwzk1xNCdyH/PfpJbMJEvJOjbaJI
         rsiA==
X-Forwarded-Encrypted: i=1; AJvYcCVYYlLkqZsczaPgXPn+t3ayIOefYD/H48ZJ7l7KRHB7Fv+f2ozGUW2wolWn5BR6vT2z8P4GsRofXfphlkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQ52EMjidWBcg3Rw0Fu7O/obb5wEy3z02TDX7xp/HSVGHlKej
	SXCgLxRaPtbf590/54VDon1DDaxBy7H0s1gQnofliwjlp2IDYghlHveWuv+KHItKAmGgBrwUQBY
	HFTGHJQgw8BeLhM+SnDbCpKdzIYf/rSjDwc5EiwV1
X-Gm-Gg: ASbGncscXlnkuAkHm6aEx121JTFxfnKIU5EX+3jkyO6ULVdA59Q+ePFiBbSUqHaF6oz
	EIR3ZAihUlfBlJpZuq3FCktAcWT5W/sVLxIvBfPqUwvdUmoY7UO+e/C2GxOIb8jJsCtHqDmCeFF
	4o0+XwyX/u/gPlcf9Nb+vYixM6zDFqDSK8kQVOsDJ4H/+DxrROx07Ld8q8wmgbD+7YJkZHksHNk
	ao2I02pHpz2nSVYmM/Ir26RZXEukLyo1lvf
X-Google-Smtp-Source: AGHT+IHCbwr834wa3+NIhY+SdhWnLGVZJwTTHUmJwd+DZoNDhBYxDxcGzuWmuexEi2FOQYOR0Ckrraqa3lxOyhtbhzQ=
X-Received: by 2002:a17:903:28f:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-27eecd5a3e2mr5287745ad.10.1758903721985; Fri, 26 Sep 2025
 09:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com> <20250918222202.1353854-4-irogers@google.com>
 <CAATMXfnqCjxSV2wOqDJ9copKMWyR5hNe9p78kwtrn+W7UCV2DQ@mail.gmail.com>
In-Reply-To: <CAATMXfnqCjxSV2wOqDJ9copKMWyR5hNe9p78kwtrn+W7UCV2DQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Sep 2025 09:21:50 -0700
X-Gm-Features: AS18NWB2aQy4RycLfAr0p-6NwAohkFphoJ7DxBMZko1nSlUFSrkfnQ2FbrMbims
Message-ID: <CAP-5=fWb5R3Gu+01Qr0+fu7n=RL8hs2b-timZKzqnATa+DRMyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Avoid uncore_imc/clockticks in
 uniquification test
To: Qiao Zhao <qzhao@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:00=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Hi Ian,
>
> I tested your patch (latest linux-next code + your patch) on hybrid
> CPU machine {CPU Model name: 12th Gen Intel(R) Core(TM) i7-12800HE}
> and failed,

Hi Qiao,

in your output is:
uncore_imc_free_running_0/uncore_imc_free_running,data_total/
ie the uncore PMU is reported twice. This is fixed in the immediately
prior patch in this series:
https://lore.kernel.org/lkml/20250918222202.1353854-3-irogers@google.com/

Thanks,
Ian

> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> # perf test -vv "perf stat events uniquifying"
>  95: perf stat events uniquifying:
> --- start ---
> test child forked, pid 21799
> Uniquification of PMU sysfs events test
> Testing event uncore_imc_free_running/data_read/ is uniquified to
> uncore_imc_free_running_0/data_read/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 1.47 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_read/
> CPU0                 1.47 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_read/
>
>        0.000925108 seconds time elapsed
>
> Testing event uncore_imc_free_running/data_total/ is uniquified to
> uncore_imc_free_running_0/data_total/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 0.59 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_total/
> CPU0                 0.58 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_total/
>
>        0.000969877 seconds time elapsed
>
> Testing event uncore_imc_free_running/data_write/ is uniquified to
> uncore_imc_free_running_0/data_write/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 0.00 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_write/
> CPU0                 0.00 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_write/
>
>        0.001183888 seconds time elapsed
>
> Testing event uncore_imc_free_running/data_read/ is uniquified to
> uncore_imc_free_running_1/data_read/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 0.29 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_read/
> CPU0                 0.29 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_read/
>
>        0.000710088 seconds time elapsed
>
> Testing event uncore_imc_free_running/data_total/ is uniquified to
> uncore_imc_free_running_1/data_total/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 0.62 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_total/
> CPU0                 0.67 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_total/
>
>        0.000959074 seconds time elapsed
>
> Testing event uncore_imc_free_running/data_write/ is uniquified to
> uncore_imc_free_running_1/data_write/
> Uniquification of PMU sysfs events test [Failed]
> # started on Fri Sep 26 04:49:54 2025
>
>
>  Performance counter stats for 'system wide':
>
> CPU0                 0.23 MiB
> uncore_imc_free_running_0/uncore_imc_free_running,data_write/
> CPU0                 0.23 MiB
> uncore_imc_free_running_1/uncore_imc_free_running,data_write/
>
>        0.000775028 seconds time elapsed
>
> ---- end(-1) ----
>  95: perf stat events uniquifying                                    : FA=
ILED!
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> # ls -la /sys/bus/event_source/devices/uncore_imc_free_running_*/events/
> /sys/bus/event_source/devices/uncore_imc_free_running_0/events/:
> total 0
> drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
> drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit
>
> /sys/bus/event_source/devices/uncore_imc_free_running_1/events/:
> total 0
> drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
> drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
> -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit
>
> - Qiao
>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>
>
> On Fri, Sep 19, 2025 at 6:22=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The detection of uncore_imc may happen for free running PMUs and the
> > clockticks event may be present on uncore_clock. Rewrite the test to
> > detect duplicated/deduplicated events from perf list, not hardcoded to
> > uncore_imc.
> >
> > If perf stat fails then assume it is permissions and skip the test.
> >
> > Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines =
with 'uncore_imc'")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++----------
> >  1 file changed, 49 insertions(+), 60 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/p=
erf/tests/shell/stat+event_uniquifying.sh
> > index bf54bd6c3e2e..b5dec6b6da36 100755
> > --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -4,74 +4,63 @@
> >
> >  set -e
> >
> > -stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> > -perf_tool=3Dperf
> >  err=3D0
> > +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> >
> > -test_event_uniquifying() {
> > -  # We use `clockticks` in `uncore_imc` to verify the uniquify behavio=
r.
> > -  pmu=3D"uncore_imc"
> > -  event=3D"clockticks"
> > -
> > -  # If the `-A` option is added, the event should be uniquified.
> > -  #
> > -  # $perf list -v clockticks
> > -  #
> > -  # List of pre-defined events (to be used in -e or -M):
> > -  #
> > -  #   uncore_imc_0/clockticks/                           [Kernel PMU e=
vent]
> > -  #   uncore_imc_1/clockticks/                           [Kernel PMU e=
vent]
> > -  #   uncore_imc_2/clockticks/                           [Kernel PMU e=
vent]
> > -  #   uncore_imc_3/clockticks/                           [Kernel PMU e=
vent]
> > -  #   uncore_imc_4/clockticks/                           [Kernel PMU e=
vent]
> > -  #   uncore_imc_5/clockticks/                           [Kernel PMU e=
vent]
> > -  #
> > -  #   ...
> > -  #
> > -  # $perf stat -e clockticks -A -- true
> > -  #
> > -  #  Performance counter stats for 'system wide':
> > -  #
> > -  # CPU0            3,773,018      uncore_imc_0/clockticks/
> > -  # CPU0            3,609,025      uncore_imc_1/clockticks/
> > -  # CPU0                    0      uncore_imc_2/clockticks/
> > -  # CPU0            3,230,009      uncore_imc_3/clockticks/
> > -  # CPU0            3,049,897      uncore_imc_4/clockticks/
> > -  # CPU0                    0      uncore_imc_5/clockticks/
> > -  #
> > -  #        0.002029828 seconds time elapsed
> > -
> > -  echo "stat event uniquifying test"
> > -  uniquified_event_array=3D()
> > +cleanup() {
> > +  rm -f "${stat_output}"
> >
> > -  # Skip if the machine does not have `uncore_imc` device.
> > -  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> > -    echo "Target does not support PMU ${pmu} [Skipped]"
> > -    err=3D2
> > -    return
> > -  fi
> > +  trap - EXIT TERM INT
> > +}
> >
> > -  # Check how many uniquified events.
> > -  while IFS=3D read -r line; do
> > -    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> > -    uniquified_event_array+=3D("${uniquified_event}")
> > -  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> > +trap_cleanup() {
> > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > +  cleanup
> > +  exit 1
> > +}
> > +trap trap_cleanup EXIT TERM INT
> >
> > -  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- =
true"
> > -  $perf_command
> > +test_event_uniquifying() {
> > +  echo "Uniquification of PMU sysfs events test"
> >
> > -  # Check the output contains all uniquified events.
> > -  for uniquified_event in "${uniquified_event_array[@]}"; do
> > -    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
> > -      echo "Event is not uniquified [Failed]"
> > -      echo "${perf_command}"
> > -      cat "${stat_output}"
> > -      err=3D1
> > -      break
> > -    fi
> > +  # Read events from perf list with and without -v. With -v the duplic=
ate PMUs
> > +  # aren't deduplicated. Note, json events are listed by perf list wit=
hout a
> > +  # PMU.
> > +  read -ra pmu_events <<< "$(perf list --raw pmu)"
> > +  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
> > +  # For all non-deduplicated events.
> > +  for pmu_v_event in "${pmu_v_events[@]}"; do
> > +    # If the event matches an event in the deduplicated events then it=
 musn't
> > +    # be an event with duplicate PMUs, continue the outer loop.
> > +    for pmu_event in "${pmu_events[@]}"; do
> > +      if [[ "$pmu_v_event" =3D=3D "$pmu_event" ]]; then
> > +        continue 2
> > +      fi
> > +    done
> > +    # Strip the suffix from the non-deduplicated event's PMU.
> > +    event=3D$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
> > +    for pmu_event in "${pmu_events[@]}"; do
> > +      if [[ "$event" =3D=3D "$pmu_event" ]]; then
> > +        echo "Testing event ${event} is uniquified to ${pmu_v_event}"
> > +        if ! perf stat -e "$event" -A -o ${stat_output} -- true; then
> > +          echo "Error running perf stat for event '$event'  [Skip]"
> > +          if [ $err =3D 0 ]; then
> > +            err=3D2
> > +          fi
> > +          continue
> > +        fi
> > +        # Ensure the non-deduplicated event appears in the output.
> > +        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
> > +          echo "Uniquification of PMU sysfs events test [Failed]"
> > +          cat "${stat_output}"
> > +          err=3D1
> > +        fi
> > +        break
> > +      fi
> > +    done
> >    done
> >  }
> >
> >  test_event_uniquifying
> > -rm -f "${stat_output}"
> > +cleanup
> >  exit $err
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >
> >
>

