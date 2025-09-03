Return-Path: <linux-kernel+bounces-799043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BCB4263C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CF948565F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC02BD030;
	Wed,  3 Sep 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wS/PGVh2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9A2989B5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915709; cv=none; b=G3IlAekegnfVsIeDAWEd0bvv+5yhzbn5MylrI9IlxnLxBeYZ8Rkq9fN53LgcdeiHtOe/ncIoD8V7BLP1Vlt5MjVCE0kpgDm9dbFXhifTfF6EkjojtaOz7M4CnubAIDV0/ObGoWzBq6lA3ztaLG5Xr1jHdKetf8ZodYK9hxGxCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915709; c=relaxed/simple;
	bh=TcnOqHnxWtRRf9NT+MerUvHTwyfwaLmdD3fXWcz/5rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvQ6asAbjDM34sRp4aNAGjrpy0rmMDjXJuW1HskA8OuEnfxWNtoNPJD9+rcgaYIF1wDKbmprcWQvrQyMwcNtJ79Oa7+YsbIAbwR38AJmM5yxCKAxHI07G1ZyolMZfv8KJ60W63hQEOHRVaVmY4EqOCTlOz5AIKdJmiGf0Cqf6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wS/PGVh2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24936b6f29bso179215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756915707; x=1757520507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4oEAPOJhyq1/T6c/PPsWOSFUUJWRnUyjFcO2apuW1o=;
        b=wS/PGVh22PJRIzDq0hCSGIKALbg7w6cbkw2fRA4MeSsWP2DZegKdpGOz6ZOpIZu96K
         V6vjjEBXH6aOSxcboq9qLpuyXLC1Jo2ZXwdGSUPPmhPF/n5CD7nnBjRct4Mpi9zhMPoS
         ASwaAKpVm05h9YYu9hhGhPSRiEZ6otMFek3U0V/dHkiGQdOki5za0BDMcoGFm0gv720q
         K5isr/SmPZoNzQNSOFfwPgh1VBp62X2GmWuI7xiHgs1ztRSrjGBEct1IeEoc+T2+dMhT
         xXJKkMM3w8BXsi5sS3SktKegQ9mBVpnw3HtC9ZlNuRc6VODq7skyoGKVEd6SXaipgUxx
         K6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915707; x=1757520507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4oEAPOJhyq1/T6c/PPsWOSFUUJWRnUyjFcO2apuW1o=;
        b=b46N+zRo6ANiaUTKUYon2+ScNP4MbPYX+2wdQUplkvKL2ODXgYSi9SH/0KTnx3PE0M
         WLEQayo5wTf3L+5WHQz8GyYFTuFgcxKYD6jNgP381jj4GJ0U/meu0DVzdhPr4F7Z9cFr
         qnJs+SJrXV0ggYlTzcwGylrljXjpydrua7qIqs0cjEVA6xQi8/bDzq8jyqTJBNSAdr8o
         okr1xikZV7IUqTYTPYwg1HgUehwu3samVFoBhfONbtAxUA6LqIBXehIpml1sZaPoHZUR
         2uWa8EnUp3v7QnbrZUDbzhAdiFvQlijIRGENr4t70xBc8xI4d5Dm5M55AKo+QnPHzt6l
         WedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhCMxJ/b7FrEDndXIWaCM0oCvBLcLgPvkRx5KCLIAsraL01XXH73WxBJAtrDEvN+tPYmYzlG3zTovb1uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykPKHGvl8GGXPjQaedsWXvcX96yWWjerXYLoGpH/MfkkSKMVS
	vDbCPKLf0NIDNL1W7nxwIV4neXYiO5hwyCGhMfwDopurZk2rKzOBbT1yM1+K9tVzY6GH5wcdj6g
	cpPCobzl44y7BHHBVhqEnlPglk1gsyL3QEwLbxPuG
X-Gm-Gg: ASbGncvC7DKJoVhxLsf4UrvdMgr1+V6su66N+J5BI1I5O7pgSbDRABwKZPTdoMJCc9W
	lum5yy98lXn46wd4H9MHkZPtiYRiyc6bkTX8IdB+ZZtr+uIXDooRznNPpqlUEvJHJ1t2mcy4fRu
	XjpgM4qYExtPmw8s2Rb4mRsfPFPuoXQh5eiNY9Cf3D47gZb2HpnOP24o6yW0BDoEn7AnuXKkA7O
	C4PWw6/IJ0W58HmqSkcj3Erq3I8y5zox8cQDnm8xHlpfK9tit/K7zo=
X-Google-Smtp-Source: AGHT+IENJInbMwsLUHTnIJnRhiUAa7cm9vbNoqrqt8ITIvS5UFXyo67xRMtE2rrpaCdKkatE3lcGXTFlCVlawA3h0U0=
X-Received: by 2002:a17:902:ced2:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-2493e9224f5mr16770495ad.8.1756915706497; Wed, 03 Sep 2025
 09:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com> <efb8ef2a-f5e4-4d7d-ba8e-fee5055f7c20@amd.com>
In-Reply-To: <efb8ef2a-f5e4-4d7d-ba8e-fee5055f7c20@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:08:14 -0700
X-Gm-Features: Ac12FXw05mbX-2WBsT9OXc79YW05EK_HXIDNJcJcMhrjtnv_6s36hT6DAMsOy4s
Message-ID: <CAP-5=fW6Pzd0mpdXbZmvNjx=UEY__qfcoFZGTsv6SJ4R=ngwfg@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Python generated AMD Zen metrics
To: Sandipan Das <sandidas@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:26=E2=80=AFAM Sandipan Das <sandidas@amd.com> wrot=
e:
>
> On 8/29/2025 9:01 AM, Ian Rogers wrote:
> > Generate thirteen sets of additional metrics for AMD zen.  Rapl and
> > Idle metrics aren't specific to AMD but are placed here for ease and
> > convenience. Uncore L3 metrics are added along with the majority of
> > core metrics.
> >
> > The patches should be applied on top of:
> > https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.co=
m/
> >
> > v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
> >     names with lpm_ (short for Linux Perf Metric) so that python
> >     generated metrics are clearly namespaced.
> >
> > v4. Rebase.
> >     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google=
.com/
> >
> > v3. Some minor code cleanup changes.
> >     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@googl=
e.com/
> >
> > v2. Drop the cycles breakdown in favor of having it as a common
> >     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
> >     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@googl=
e.com/
> >
> > Ian Rogers (13):
> >   perf jevents: Add RAPL event metric for AMD zen models
> >   perf jevents: Add idle metric for AMD zen models
> >   perf jevents: Add upc metric for uops per cycle for AMD
> >   perf jevents: Add br metric group for branch statistics on AMD
> >   perf jevents: Add software prefetch (swpf) metric group for AMD
> >   perf jevents: Add hardware prefetch (hwpf) metric group for AMD
> >   perf jevents: Add itlb metric group for AMD
> >   perf jevents: Add dtlb metric group for AMD
> >   perf jevents: Add uncore l3 metric group for AMD
> >   perf jevents: Add load store breakdown metrics ldst for AMD
> >   perf jevents: Add ILP metrics for AMD
> >   perf jevents: Add context switch metrics for AMD
> >   perf jevents: Add uop cache hit/miss rates for AMD
> >
> >  tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
> >  1 file changed, 651 insertions(+), 3 deletions(-)
> >
>
> For clean builds, I am seeing some warnings for the "context-switches" an=
d
> "energy-pkg" events.
>
> ...
> /home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:124: SyntaxWarn=
ing: invalid escape sequence '\-'
>   cs =3D Event("context\-switches")
> ...
> /home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:615: SyntaxWarn=
ing: invalid escape sequence '\-'
>   pkg =3D Event("power/energy\-pkg/")
> ...

Thanks Sandipan, I'll fix the warning in v6.

Ian

