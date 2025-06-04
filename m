Return-Path: <linux-kernel+bounces-672539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F26ACD0B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84891898798
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D96AA7;
	Wed,  4 Jun 2025 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEPJ2IZA"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98A6FC3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997107; cv=none; b=b6tKX6RPPF8Z4BSQmXjYCHazWxEeJdfqgngGPj3jw+OqlsaZ1KQ8YXeUujfm7UwVrvy35DABi7TTjPXhj+WfXeHUGmTgWktyDGEGHbLOOMF4ODDcbTxwuzOtRVG6ZowouNFgJkP7ib/+5/PyyeIv68aADDc+xZSl+8rpJmHpQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997107; c=relaxed/simple;
	bh=Y8P8ekuWQTrstTqgqgBrAMIigYehAZBJN5IKXdgoKKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk9QAQxVnVbsKLtHM8dZ4MN7TMpkZ4yElWAp2nPmhwp/33tVTzfSZg6KUwCeGKS2PcSRYOW3D+4Oice18MBEJL59TDBgxFFSnTOpmRqniIzcq6oXptItC1jVjzS+qieE10kxOkY1Od7svMMLXCIxJQEYfEwKGjIMh1kjpnCM+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEPJ2IZA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dd89a85414so96175ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748997105; x=1749601905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFyU6o5bbTPzDuRugXqSPb0fdFrTDPydzDyGunNiVuY=;
        b=pEPJ2IZAIr3WGtw3jJq6I2mOemOBFbof+qWlStqXZLJ+4qqh9MhS4T1xV7pz+4a7um
         N+0S6V8rxjDC/YVLidCinC4yipTKBStpHqjSqVPezOA4ZltmP17drWECZUzh9K2EEZ/5
         ddFDT38nOuNaL7PzmGmXZvN5K8UHO8QHVMzE5fc76ig+8OYsK6t3CwT3ErqUB0QBT0nK
         gHLZ+U8LWHyFFojFORS2SvLbk++ihTwWy+H/3NQdlUDXtlRO5tDgRndHNNydA+t7/Ca8
         RKCjUUGF9z3vGbzA4X1hvl9O92kYuedJ+JUyWKZKgFWpcR+Te2924jm5y252+HUXPutj
         E4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997105; x=1749601905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFyU6o5bbTPzDuRugXqSPb0fdFrTDPydzDyGunNiVuY=;
        b=ctJi9laAs+G37+hEv33XEkppGP0Zq5+lCT1OH8P4/C9sA4KvK6LXFBz6L5ZJOyFcjJ
         ZbIz3E1oMxz984lD6EHlAYFJfznR/zzZP9rZHolWvdpb+SdDC2i0fVxeUQ2vgHyQR3RI
         NmpQAn8fof7bU4SQ8bLu6wGX3j/8AC48wSt87YLeecY+9mPS2cH0JAlVagedNjN3wOlK
         89LqsYJszDOFTDG6lEv67XY5TaL8wiyPip5GGUWJJX19qxYAtRy9vnn+prGVtPPrCXHZ
         UDJMYtHHg90Vn8mPYhfDDu8ZzVliJnCParByemDf4Q2RUDDi5XwVeDgrHlc22I92je9o
         8qiQ==
X-Gm-Message-State: AOJu0Yzo5mycP4cdu/ilLLfUHNJQMK0pQhRYbj+AXwyPceHZhwHPaeOL
	8NCXxTNv2Qnq9tT0RT6iKOeWguI7FUQbekcfCVncL9/DW2gMadhpJAHfAN93/PBq5jCRScgC69U
	5GL6pMF0OUEmvT4AjImW85E6wk0++aeI574zzxGlR
X-Gm-Gg: ASbGncvRT5VVnARZ3x1VZYQ+HEOFIKrDlvPjRrQgyhGs+Tev/kWoH5+6pPfPfkUaKPI
	d9AgkaAMxi6SJWdZYz1XU8UFmgPpkebVnsX7VJgpqSjlrDnsiRctiMDmi0Ud5RNYZC2HnV11ajE
	jU/vcPPQD/vt+9JgiCEbXHavBITBCYhCpzrAorrlGOp05sbdy8I/S9XbpGUGNmCUeJ7HJzy2/8
X-Google-Smtp-Source: AGHT+IGN1RzMt774VMiAKYM+BFCQtMMsQ/NFjgCEHHcR1j4hf5n4Qujv8UMtHZZGwpMckBzrcS+lu40QAR+LWD3VAO8=
X-Received: by 2002:a05:6e02:260c:b0:3dd:b688:1b1a with SMTP id
 e9e14a558f8ab-3ddbe78db44mr1907205ab.10.1748997104576; Tue, 03 Jun 2025
 17:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521224513.1104129-1-ctshao@google.com> <CAJpZYjV_XquU785dhOPVGM7k9N_6QV+1OxenXLj4-fbDCj=yWg@mail.gmail.com>
In-Reply-To: <CAJpZYjV_XquU785dhOPVGM7k9N_6QV+1OxenXLj4-fbDCj=yWg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 17:31:33 -0700
X-Gm-Features: AX0GCFtzXLKwBtN12F6R483HTnfj7EEsTmE5CJFeSewNOo0eXBMIidccxIFKn9o
Message-ID: <CAP-5=fWcW8Fhe8rwUxOdHWbxF0V9CM40p0J3O97X391LxVT9nQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Restrict uniquifying test to machines with uncore_imc
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 9:21=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> Ping.
>
> Thanks,
> CT
>
> On Wed, May 21, 2025 at 3:45=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > The test would fail if target machine does not have `uncore_imc` device=
s.
> > Since event uniquifying behavior is similar among different
> > architectures, we are restricting the test to only run on machines with
> > `uncore_imc` devices.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/tests/shell/stat+event_uniquifying.sh | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/p=
erf/tests/shell/stat+event_uniquifying.sh
> > index 5ec35c52b7d9..5a51fbaa13bb 100755
> > --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -9,7 +9,8 @@ perf_tool=3Dperf
> >  err=3D0
> >
> >  test_event_uniquifying() {
> > -  # We use `clockticks` to verify the uniquify behavior.
> > +  # We use `clockticks` in `uncore_imc` to verify the uniquify behavio=
r.
> > +  pmu=3D"uncore_imc"
> >    event=3D"clockticks"

I'm a little concerned the test will only run on Intel server CPUs.
Another event that is on a lot of PMUs and needs uniquify is "temp1"
by way of the hwmon PMUs. Essentially the first temperature event on a
hwmon PMU will always have a temp1 name.

```
$ perf list temp1

List of pre-defined events (to be used in -e or -M):


hwmon:
 temp1
      [Temperature in unit acpitz named temp1. Unit: hwmon_acpitz]
 temp_core_12 OR temp14
      [Temperature in unit coretemp named Core 12. crit=3D100'C,max=3D80'C
crit_alarm=3D0'C. Unit:
       hwmon_coretemp]
 temp_core_16 OR temp18
      [Temperature in unit coretemp named Core 16. crit=3D100'C,max=3D80'C
crit_alarm=3D0'C. Unit:
       hwmon_coretemp]
 temp_core_8 OR temp10
      [Temperature in unit coretemp named Core 8. crit=3D100'C,max=3D80'C
crit_alarm=3D0'C. Unit:
       hwmon_coretemp]
 temp_package_id_0 OR temp1
      [Temperature in unit coretemp named Package id 0.
crit=3D100'C,max=3D80'C crit_alarm=3D0'C. Unit:
       hwmon_coretemp]
 temp1
      [Temperature in unit iwlwifi_1 named temp1. Unit: hwmon_iwlwifi_1]
 temp_composite OR temp1
      [Temperature in unit nvme named Composite.
alarm=3D0'C,crit=3D84.85'C,max=3D80.85'C,
       min=3D-273.15'C. Unit: hwmon_nvme]
 temp1
      [Temperature in unit spd5118 named temp1.
crit=3D85'C,enable=3D0.001'C,lcrit=3D0'C,max=3D55'C,
       min=3D0'C crit_alarm=3D0'C,lcrit_alarm=3D0'C,min_alarm=3D0'C. Unit:
hwmon_spd5118]
$ perf stat -e temp1 true

Performance counter stats for 'true':

18,446,744,073,709,284.00 'C   hwmon_acpitz/temp1/

            40.00 'C   hwmon_coretemp/temp1/
            30.00 'C   hwmon_iwlwifi_1/temp1/
            38.85 'C   hwmon_nvme/temp1/
            43.75 'C   hwmon_spd5118/temp1/

      0.001488897 seconds time elapsed

      0.000000000 seconds user
      0.001568000 seconds sys
```

Thanks,
Ian

> >
> >    # If the `-A` option is added, the event should be uniquified.
> > @@ -43,11 +44,17 @@ test_event_uniquifying() {
> >    echo "stat event uniquifying test"
> >    uniquified_event_array=3D()
> >
> > +  # Skip if the machine does not have `uncore_imc` device.
> > +  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> > +    echo "Target does not support pmu ${pmu} [Skipped]"
> > +    return
> > +  fi
> > +
> >    # Check how many uniquified events.
> >    while IFS=3D read -r line; do
> >      uniquified_event=3D$(echo "$line" | awk '{print $1}')
> >      uniquified_event_array+=3D("${uniquified_event}")
> > -  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]"=
)
> > +  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> >
> >    perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- =
true"
> >    $perf_command
> > --
> > 2.49.0.1143.g0be31eac6b-goog
> >

