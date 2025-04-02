Return-Path: <linux-kernel+bounces-585818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF4A797E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 23:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB92C189570D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBD155382;
	Wed,  2 Apr 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcVUN/8E"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FF1F4615
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631034; cv=none; b=lRfWbWfx9A/+KX90vepSt+8QC8Eoo9OMC/nYZRnKc6VpyaydCBDQwtDng7CJAyNrQhrlOXZvnmSelIWLlVj33wMBs4l8nsHftkq0m3A1LIE/K8Ls7uvHPl9mp0aQvQhvoajKYTS0aWFf/gOtLpAWXpGdqjeZ7JtWQQt7xBlZyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631034; c=relaxed/simple;
	bh=sZgJaFM/GPh2oWYGpowCLzvx3H4iO+SVj2cRVqudPM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P7bsiBnk2Pg08Q9X1Zn/XyzP/vK2i0NLOahvp2VGxE7qwdEinYpIxFbqLsbsxAIDjTpnaBI+hqHl537xBTbYqkj7KHxa7x+L7aX2rCJgsdxUWaMHBBYC1KfL8lKP4zOUcC546+UIKmCMti7ElLf2v/eoMUB2LhO3TGpFtVLduS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcVUN/8E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264c9d0295so315275ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743631032; x=1744235832; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM+jWPv3K/nQ3Kg9TjMXv9TDh1L/e0CE47ZwZvq6Tz4=;
        b=dcVUN/8ERLw9QPPeW3py0f6mwyzOzVVlt4IrnJ4l0MUHkaYEY0hMf3bzWuWvqj5vxf
         w3UaukXNRPw/MDEejiy90u9tWWKELc7yETD2N5a6buLHHnr5nLYOsmg5Kmcsik0UMi6q
         /SappQOJ0Z8Jqjkj+NKlf0rt1OTHu/gsOBeITKUWIMq+6c4gZ3agKXlh2IU0TCah1hrl
         uavPGxKWXcduCR8lxk+ZnNrPyZJkSgeCz3UPpj0Vp9Wn81D7B/rn4efJYJt4xbEZ5MTr
         oAo6BzN1K+8Ct1sP/Nz+CqqOZ2ocNvmKOaNi6OWjOaoy6klhY/65B5D3hSCkIO8X/HZw
         VHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743631032; x=1744235832;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM+jWPv3K/nQ3Kg9TjMXv9TDh1L/e0CE47ZwZvq6Tz4=;
        b=AJpUiF8Jz10m5vD3ekmST5dTP6y8lXnbBd3OoY8yHWVXNZoVbdqIEIiv8WW59U72Bo
         tirOmlDMX+GCDzYmVWwX0mmuFeHcYwcQw3usAPFzX3eYEqsjzLZMMeV/aUHKKZfyBF5a
         qdzOIutp+gLYaxIdCjAh/i5AlIh0Nn/ae6/6i3tHPitE2DauHTnpQU89dKQzecINCEqT
         zuIsHYpdgjN4zga7CYtdv9/tvtpxVqQ0EdYOUaXq96tDmfrLHjCLhx3QrJs3vXazua1N
         xPy/Cw98jVzfsUnCKNKoAQLMRDipWJzmC5H84WI8mmqYtqm5/rxU91Se+8dVspeCYE8v
         Shvw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ogHn+zygUcMfwy9CFk1lWXpoZyIRc80d/3DQrdeGtX/LJti2V63oMe97kH54/DTF5Ia5ILFTpJrTY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvch3wu2MYW7vdkkTSjW0sdbgcCo/lQEIj67JthvnOoGdlVTQS
	1VHwfocyoC84zSiBYLpPpl/FrL1yxJPX0Fsu7lDC2Kf/CKAHx0GNsWMy3UpHkQJDJngNJZuwWHB
	udsFyWPXgSA5jHrRQC8T/0b3fcYvaOIt/21+O
X-Gm-Gg: ASbGncu3xuz9gkclRdxAe+Yy9hGhI6goHHRsJB9kNvrpWnrML7Q+iqwq4X+lAAgFfbL
	r0wXe5X8olVHFvEgjrWPHzqInsORh1ZJvoeunGchvFDQDBtZ5/t7I/fN5EjHvQ9hYuRhC4+uTeZ
	seLOSdRzCqcjA0tgEDdepp3GE97sjw47rCeWm/zTVCFVf4SDI+6F+V
X-Google-Smtp-Source: AGHT+IE92yLS2/+wWqwy+hrbq/Bh0anK7D+XCgmIjXlBWutUA0gRV5fpkslAccNPdlX4RoPmf+df/LPNM+h6N9E9QiA=
X-Received: by 2002:a17:902:d4cb:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-22978360b83mr313565ad.23.1743631032305; Wed, 02 Apr 2025
 14:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com> <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
In-Reply-To: <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Apr 2025 14:57:01 -0700
X-Gm-Features: AQ5f1Jq5oNxocL07Mtb5IgaU2Z7YnKdJ71A4Y8TJl5HHO52uIhvurX3QuDcsvNI
Message-ID: <CAP-5=fW1cJRnU73udpXC9ayN8j-cAyjJK_ZOp97Z=LsagQcevg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for cpu event term
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:22=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 10, 2025 at 10:38=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Being able to set the cpu mask per event was discussed in the context
> > of a sysfs event.cpus file is discussed here:
> > https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUo=
o8f-4j8Y+eMBg@mail.gmail.com/
> > Ultimately Kan preferred to have multiple PMUs with a cpumask each
> > rather than an event.cpus file per event. It is still useful to have
> > the cpu event term and so the sysfs part of the original patch series
> > is dropped.
> >
> > v5: Purely a rebase.
> > v4: Add the stat-display output change for zero counters Namhyung
> >     requested as part of the series:
> >     https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
> >     This skips zero values for CPUs not in the evsel's cpumask rather
> >     than the evsel's PMU's cpumask.
> > v3: Drop sysfs event.cpus file support patch from series.  Reference
> >     to using cpu to modify uncore events is dropped from the commit
> >     message. Reference counting issues on the cpumap are addressed.
> > v2: Add support for multiple cpu terms on an event that are
> >     merged. For example, an event of "l1d-misses/cpu=3D4,cpu=3D5/" will
> >     now be opened on both CPU 4 and 5 rather than just CPU 4.
> >
> > Ian Rogers (4):
> >   libperf cpumap: Add ability to create CPU from a single CPU number
> >   perf stat: Use counter cpumask to skip zero values
> >   perf parse-events: Set is_pmu_core for legacy hardware events
> >   perf parse-events: Add "cpu" term to set the CPU an event is recorded
>
> Ping.

Ping.

Thanks,
Ian

> Thanks,
> Ian

