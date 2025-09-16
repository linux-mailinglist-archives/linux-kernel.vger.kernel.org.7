Return-Path: <linux-kernel+bounces-819586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE55B5A36D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7871A484020
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C002868A9;
	Tue, 16 Sep 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgJAZTDt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB82745C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055541; cv=none; b=VTwvOX14IPYLJT2GJBC4dE0jEFjyPBKmZX332c2OLXQ+yyAG+OxXKhp6mI/mMYX05rj++u2Zy7TYfN0M3ZIMm5kV8ecSGG6dsA12ilIjUyb1xlnjQDvE0krlVhsu91kkXhEsEKSPAckhPLSF+rFaHHdHc1mf+e+LbnTWOeAthDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055541; c=relaxed/simple;
	bh=mVRrvULAl7a0H/lqI4gVzZBVDQkbVAzrjpf+kq3CEPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/AepHGMA+w/buGCFRegLLxdk27e9nsAFJd0yt0g8tqIou6XRDZSboLqVyJjZsJui686+WILw6etBHK76ONHJEOjo1xi+Gsj3B2CZC3Yto8LIrgj5C1b7Tbqdd0cI03HoSTaUp/RjFTS5JmgK05kynC2/RW/4XHRcApDzk9RtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgJAZTDt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2637b6e9149so24655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758055539; x=1758660339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7JtOn5iRbugClaljDWKp0nSVh0pzob9CHuUB5oZ+Go=;
        b=GgJAZTDto2OH/+dRA3x57dnQiWpH/kCGAQCr8AAZl7sIFLBcO7Ikd3llFzVOvnE7y/
         9ERjmWOviU3+X0dMvBfWnk7MnVTTYgE2nsToHQk3F/C5w60V21N1LXDf7XziThTQZyo1
         03vGCxG1Fzidx8WFKTYA9V5hHFk4RchMm8vZoARCSlKAiTytjqlGIOC4fnjPHOjQUb5y
         oSDoxwTNrAhs9VB20sm0usnSzSRe8AgZ1nYvhp+otoW0Xo1HOb/aJGynvZB+jX4TeKh/
         reXf5oHIAGxZpG/ds0rB0rtqnOhn8AISjQxRbdbLEFZvlWdHmXUP8GPsOo+4DrO1BuUp
         oTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055539; x=1758660339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7JtOn5iRbugClaljDWKp0nSVh0pzob9CHuUB5oZ+Go=;
        b=GISMosrbkknahf1uHTz5JfZNbGcJHlX+Kvzz8LFDjgBIhsKWu3Pw1qw6lU781yyJGk
         8xQCb+NOj5Hm2lC7x7PYBxzquvhjNlAYEOTg36QWFKv85xt/cN8AIh1LD0AvIsnmB9Je
         D702fz0FmGSeuiM1CEW+RqMSzj01B6ZhaqwSfGxOn0e7XntZ3KHM5YVTilvfyFAh9rFK
         TOH1ypc89qc9E7utH6fE/C4GbHPXzjcM5I4JCEQsInMj540HfenKA0Hh+xuCOoyw2uoZ
         xAhRDkfG5c33C5NcKwc/JL9KTAq9SeVwUuySyiMRXjD9ZebYKUjkv75O6Ne7k6D7tE5P
         QrsA==
X-Forwarded-Encrypted: i=1; AJvYcCXuakxHHhXSk3fkG4jymMwQp0/6WVkQ+nX5kDSwu+6E9iK0UHzP0ZrGUkeunJlwVInFQXv6oFfMIsIFFnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvIehzxyFmuj92j5mFeHrWwB+Fl1j89oqkf5KrjI9rw32rdu+
	FwArMbPYqnYaUvk7NpGF2gta0ptH0O3VLedgqUYvMg5grkj9Vayqwb/deYYdwYL93qxUrA5MYdH
	JYU0ZtZJroAxJqtPKg9eXSRk/pdEVdIv5FZJGp/kg
X-Gm-Gg: ASbGncv24QznCSOR88xze6POCfwjsqia5qQ7J6x0xUUD5OsGlNGqLWCWQNVpOuWesqW
	Y2hKhJhFbmASGBLhAcTT2rVaApBn9fbDN2U+FmQtZ2XM4Dj+C5mc50yP9aL3Q3bT42B0/mChCJb
	8PNDw57OSyTISRiJ5CsGEMJbh6FE/xfaXreMWA4/pCc7SmgwPd3YEZCMCA8xBFCLrm6KacrwCpa
	N+9Dbbc9Ro55d7P00/xQbDd2Kk/RDDsCrR5krUmb0OTJp/sLf0ZltY=
X-Google-Smtp-Source: AGHT+IEhI9gwl0jx0nRJixa5TgtHxkdh1vVishGEGqqWghEreiBWKo2Gb6zhpoSpatC73VotSSIdfNYVN8cdkllkDhI=
X-Received: by 2002:a17:903:c0e:b0:264:f533:75d0 with SMTP id
 d9443c01a7336-26808ace187mr191175ad.9.1758055538225; Tue, 16 Sep 2025
 13:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com> <20250821221834.1312002-5-irogers@google.com>
 <aMm3N0dfD_r46K6A@x1>
In-Reply-To: <aMm3N0dfD_r46K6A@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 13:45:27 -0700
X-Gm-Features: AS18NWBOlU8DP_bSxREVcvnvIiT2DqyOOyoJjjUlRHup15VyUKxwr08I8rlwT9Y
Message-ID: <CAP-5=fX3Pv7CSN4EApGZ_Wn666Wf6cyhjhYp5Tr175aS89wURw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] perf test: Avoid uncore_imc/clockticks in
 uniquification test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 21, 2025 at 03:18:34PM -0700, Ian Rogers wrote:
> > The detection of uncore_imc may happen for free running PMUs and the
> > clockticks event may be present on uncore_clock. Rewrite the test to
> > detect duplicated/deduplicated events from perf list, not hardcoded to
> > uncore_imc.
>
> acme@x1:~/git/perf-tools-next$ perf test 96
>  96: perf stat events uniquifying                                    : FA=
ILED!
> acme@x1:~/git/perf-tools-next$ perf test -vv 96
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF =
maps, etc
>  96: perf stat events uniquifying:
> --- start ---
> test child forked, pid 86847
> Uniquification of PMU sysfs events test
> Testing event uncore_imc_free_running/data_read/ is uniquified to uncore_=
imc_free_running_0/data_read/
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for=
 event (uncore_imc_free_running/data_read/u).
> "dmesg | grep -i perf" may provide additional information.
>
> Unexpected signal in test_event_uniquifying
> ---- end(-1) ----
>  96: perf stat events uniquifying                                    : FA=
ILED!
>
>
> Works for root:
>
> acme@x1:~/git/perf-tools-next$ sudo su -
> [sudo] password for acme:
> root@x1:~# perf test 96
>  96: perf stat events uniquifying                                    : Ok
> root@x1:~#
>
> acme@x1:~/git/perf-tools-next$ ls -la /sys/bus/event_source/devices/uncor=
e_imc_free_running_*/events/
> /sys/bus/event_source/devices/uncore_imc_free_running_0/events/:
> total 0
> drwxr-xr-x. 2 root root    0 Sep 16 16:09 .
> drwxr-xr-x. 5 root root    0 Sep 16 16:09 ..
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.unit
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.unit
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.unit
>
> /sys/bus/event_source/devices/uncore_imc_free_running_1/events/:
> total 0
> drwxr-xr-x. 2 root root    0 Sep 16 16:09 .
> drwxr-xr-x. 5 root root    0 Sep 16 16:09 ..
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.unit
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.unit
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.scale
> -r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.unit
> acme@x1:~/git/perf-tools-next$

Looks like a permissions issue (opening an uncore event with user
filter is a bad idea, but is tried when open fails and we do
fallbacks). I'll do a v2 with a permission check fix and resolving the
earlier merge conflict.

Thanks,
Ian

> > Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines =
with 'uncore_imc'")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
> >  1 file changed, 44 insertions(+), 61 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/p=
erf/tests/shell/stat+event_uniquifying.sh
> > index bf54bd6c3e2e..9bc7a1f520f9 100755
> > --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -4,74 +4,57 @@
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
> > -
> > -  # Skip if the machine does not have `uncore_imc` device.
> > -  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> > -    echo "Target does not support PMU ${pmu} [Skipped]"
> > -    err=3D2
> > -    return
> > -  fi
> > +cleanup() {
> > +  rm -f "${stat_output}"
> >
> > -  # Check how many uniquified events.
> > -  while IFS=3D read -r line; do
> > -    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> > -    uniquified_event_array+=3D("${uniquified_event}")
> > -  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> > +  trap - EXIT TERM INT
> > +}
> >
> > -  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- =
true"
> > -  $perf_command
> > +trap_cleanup() {
> > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > +  cleanup
> > +  exit 1
> > +}
> > +trap trap_cleanup EXIT TERM INT
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
> > +test_event_uniquifying() {
> > +  echo "Uniquification of PMU sysfs events test"
> > +
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
> > +        perf stat -e "$event" -A -o ${stat_output} -- true
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
> > 2.51.0.rc2.233.g662b1ed5c5-goog

