Return-Path: <linux-kernel+bounces-724499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA1AFF3B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EFE7A6F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360723AE84;
	Wed,  9 Jul 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpegsM1t"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2522D793
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095309; cv=none; b=Zke1VwlONDGpI6GGQWIHwZaGv3XDFZcdJ90Dut1knYLgVR0C3bpShaIwL176OiOtIC/jNfGB7Twor6YOINlXwTqx+YcqbvY2aV2R6tsqSbDXC/0TULy46AhXLPaQ6zDchOynRp0x0JV9yjx0O6cLkiXzijwtiuC/0lwuoBt1DtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095309; c=relaxed/simple;
	bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU2Y677wHic7noaE52eeadXK+ZmqvWjAo7YUDOtQw/6dnqo6g0kWkWj/Tol5G/AhPd3mW/WO2MM5rjuAvmQRYzuVlNz1H8kGK7sJGoovat+Wz2ZRaw+WqzdXMUFUoHeZIOo3DDpxiutBIlfuU0WIrtzqZt7cGmhFHn9Ydus6uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpegsM1t; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f26496daeso141164241.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752095307; x=1752700107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=EpegsM1tJ9Sxuppd0N7nEcOClE62jaJVVTAdJ35RGbVkTX3kMGA4ExFV5ifYdt4WUq
         aQnK3Fm2BJtQnuOKifBJ+ndSfk8u1ANKA7WHDsBzZhVw8PrdhktIEdWBJiCBQbQrtSV4
         gFIGoVC19JbrNBDsi5hxKFFBhyLBaLUlB4NErcP6fw2FlMXWYB/aZubhqkskhyg8tW/o
         BaR4cFAD4D90gWX33iOlt4U2z75R1JBqOdOMUNgZoJoWz5SL2yelb/UsqtX3JSA8Brwy
         +hjzsDfjV6W9e2C5uS8/xzI4gtKdGyX+ZD7g5Ig0WlkjGKr0N2BOXfRsFN07yWvbZonC
         rz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752095307; x=1752700107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=X0DIxiLIN/peNEZILESj2xtJcy71qUxsQebfYFrajs299/O+tpVgBauMsp0irJnhGG
         Py4rz/lVCKAkJ+/aERi75qvyZ9hWrAQlJrax0nXQtQkI0+gTm93ypnOylHgBgGg29qUU
         q8tKqK8zgQilSX8Jn83ZDme4UqWkPRNOdceb6k9y1HofzelWIO20KVvffpnGV2/ycK7o
         6MM6dMJYlTn6GssiVpNxy6AWt9k6vC3NNHCmxeUj1SSp4qQFc6IcdKcPIzq3BMsqm2ou
         fc9ew7xJyZ1z6o8aDrnLQS1VNT0l0wk9n8MZH8CxoysqrvJ1EX9MfEh8Ep81nuKPzqJb
         UwIg==
X-Forwarded-Encrypted: i=1; AJvYcCUg0fjz3zHZHd5XOMMxiXhgtFYIuN6R5pStDP37ePs6syyCJaBPNruVSZm0WzDCiwD5hu8m+sOE3JHlJLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1Zt0P90w5xWI9u3SZ0kJ3pznsL4BlUg0N3OJcuoofBwdDKfy
	ikznUwMrgNbhgfu0gcMP9yjRtmtjR6L6X+LDDQOuXeWH5NTgniMUjK2WkUg9n8Lrff2yj74Wazp
	N7dP5pkcX3or6EpoNUQieArpsRG8MVbrRksiHRrpO
X-Gm-Gg: ASbGncuSPXVE/OIlkkEp2F/ou7KBJT9a1oNr6XRyC3CH2n+gey8mRt9lWTKv2Ktv12S
	ewE7IjhG74H9X5efGf/f3XGZCxh/TX1UToQC7kmv8iPu/nltBzyPByJDC5pTOnT+6QasLjUTvfg
	rDk8SxL//7EJY6wJN7rqT0j9iITdEAb2mWaYHkKfL2TTawPKB3vZ5RVdU2A8FrAfb1/ZYSCagZ
X-Google-Smtp-Source: AGHT+IGdh8eN3h8HscGvSa6bfWmnnHbDwGqF3PtjSKvTxi2yQaiUYm6rNI3VTgW1g2j5SJyRzIJjOT1h1JH55zPabDE=
X-Received: by 2002:a05:6102:50a1:b0:4e5:59ce:4717 with SMTP id
 ada2fe7eead31-4f62df178aamr186458137.9.1752095306773; Wed, 09 Jul 2025
 14:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 9 Jul 2025 14:08:15 -0700
X-Gm-Features: Ac12FXxXtr8XizMgnbtY6unx5cS16grFsxMMxrKhZdDg1-CAlIRC0HFgaVUWbWw
Message-ID: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > @@ -0,0 +1,76 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
>
> The 2nd line in a shell test script is taken to be the name of the test, =
so
> ```
> $ perf test list 108
> 108: SPDX-License-Identifier: GPL-2.0
> ```
>
> > +#
> > +# BPF metadata collection test.
>
> This should be on line 2 instead.

Oof, that sure wasn't on my radar. Should I do a followup patch, or is
it not worth bothering?

