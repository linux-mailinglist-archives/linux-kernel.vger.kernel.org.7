Return-Path: <linux-kernel+bounces-895958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B49C4F5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380CB3A6BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1599361DA3;
	Tue, 11 Nov 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSggIIrt"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A20270ED2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884114; cv=none; b=Qfn0adTJChoT7Unly1teQGepOvZaSjdgRf4Zu/FLvqK+hEvUthayUcJO3CpPyUrGytKYqX4J7n1bYKlXGLz8tX19A96zF7AqcODDFxiXD2tRek989u4WBeOuxwe7r6ONdVcgI/KUZdJp1eIfElWMcAzVUZXHNVb3PK+zQ48WDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884114; c=relaxed/simple;
	bh=POx07xgO19fjd2of5y/PICQ1dU681FfqtcMrZwKBY5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orrZ37QuPYvj79xVmOiLzJPnNfhND5L+PohSdLgLS8gSu4g12gpm+CWZnxC8/Oc85+G2M6/fGWtJCtzwCmxE0+l/JLKDGp93698OJYoMv4RwPirItSKLUMaK/+o+snsnq47H5C+a3K5b5gArYNX0gdYvOtJs9b8aWDAsegxaoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSggIIrt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2959197b68eso3575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762884112; x=1763488912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj3oD85/fF4h5DTo6ut15zDZ0vkRj7B3cZojmVYXkZo=;
        b=zSggIIrtaiRWKpB4J+DY3xSg6E+RQFzHDXA7P76UjaNnEpC1fO+3xayXZzq4Dv3Tbc
         Y9GfIehx/N3ZIbDsIvlIfLG7b+fp6tIkoFaYoqXhtz2+R3yFg+yB+JYlzcKZI4Yw/TKZ
         ko41ichxXncrAJUfpOAtega99Yy6pah384EUQe3+EpxO79MR+zPzzHodqw3utMgCerSe
         PuOmusgThYWXs7Xlsh1m7kiALNBqLem4Zsh4b93VF9emeUObAob3T57WLIQ65d1dZaFb
         wr84pB6TWPzXv1wfZf5r4Z+aAEGIBazmHYZVfkkNGC2l1laCjkZxBayawHqSh0ZQUMi+
         1AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884112; x=1763488912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rj3oD85/fF4h5DTo6ut15zDZ0vkRj7B3cZojmVYXkZo=;
        b=T21AQzsdBqLzawC/I3x+zVIV5yfYvHUzrsE3HzYwFnu9PxDhWm08vQhqmi0mTwxpGV
         HbbUGHf0VJwipB38GHmpBL3m+SrlQC5AYBFy5n3Sy+PtSeIE30x9P9T5cP2QfaGmhIuE
         OcMqFHFtvdyIL9dWn4W5+9nA3ob6gzHV22F+0GT2KEZD1OdrVbNu/oO2cz3L9JlI+ZfU
         1GNTMs8X/OsRTHYcvuIpy4K3vfe7MQopDm0KruKE52G+RZqb2HPxXq32vZzW6YXNSfmo
         7JHNPRKF/6Nr0A7MuRh8cAgzAHcQOe1BuewMIMtopZJfpZ29qDIwOiuC7lda4gPzJowT
         YBUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXY0klPuhuNZK9EN1n3Ff5f+7RyeMs8Mn3NkNb7aaakgpeIxsALaa9MnnisaEiwTdvVGGLKsYWPv9yszE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo++4fNEkykR5SR4Jh2a3kAA9cD1MXrbTRll0pwI6BZdiK9lXG
	YdcuTG1OF4p0F6OYQ3ZfrjpOqA0uuSlazIOY7PqLuSVyVHSjdACxtJGykF0f3usDkrrm3CbCsBs
	XIvVWKMxKqqUSM2YheuyTQ/GIG071lgzJOHFdxTKj
X-Gm-Gg: ASbGnct385fVlUWS9WP1tRFRSXD5/CAZXZ7GJsbgbP69BP0R1epxCU5cXWA1OXjYBZN
	ZswbdCUKF/Ojnyoli/+8B1xRTDWiMOJlTuIu/U41T8wsgf+jGB0MZakU4ZV+dK5A5v7FMVYZlhQ
	NZXh/yf4TeHMR0gmhGT9Qt11l4NzwhyHVg9PSprqhxYn5e37KTFfEbIF63U50Z5MjT88TmCi87/
	Q/CpyItDSo2xxY72a7IqQxmZJhZLtZTu3oMiA2Tn7xSfTCqhBPrKkI6np7IrNdzsHPveHqsSADn
	R9xWZirXANP60VuBmfUFoB5e35AnG2M99hx4
X-Google-Smtp-Source: AGHT+IEaYfD4+h5i0LnDfGy3StP6alCdbAGrRzBT449Gnul1EibX1V26xrhMdWylATmgLhu5TZsvpqxt9mZxeWG4ecw=
X-Received: by 2002:a17:903:1a6f:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-2984819f64amr1468145ad.8.1762884111278; Tue, 11 Nov 2025
 10:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com> <aRLV50z1L9A3YRFF@google.com>
In-Reply-To: <aRLV50z1L9A3YRFF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 10:01:40 -0800
X-Gm-Features: AWmQ_bksGFltkNtn8RNtUeEYKdYbTBJDmTCEeYnwmeaDQvhSPtYZgO3gbyAEAPI
Message-ID: <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Tomas Glozar <tglozar@redhat.com>, Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Sun, Nov 09, 2025 at 05:31:47PM -0800, Ian Rogers wrote:
> > Switch the __get_cpuid feature for intel-pt to use the provided cpuid
> > function in perf, this removes the need for NO_AUXTRACE when the
> > feature detection fails. Remove the now unnecessary feature
> > detection. Remove NO_AUXTRACE as it just builds a more broken version
>
> Can you please elaborate what the broken part is?

Sure. I'll summarize what alters in patch 4. NO_AUXTRACE is
controlling 3 main things:
 * set up of aux options for PMUs (code in the arch directory)
   * ARM: coresight and SPE
   * Intel: BTS and PT
   * PowerPC: VPA DTL
   * S390: cpumsf
 * support for decoding aux events (common code that can be
cross-compiled assuming other library dependencies are available)
   * ARM: coresight
   * HiSi: PTT decoder
   * Intel: BTS and PT
   * PowerPC: VPA DTL
   * S390: cpumsf
 * Tool support for aux buffers (common shared builtin code):
  * perf record: aux options for events, snapshot, aux-sample
  * perf inject: aux events will fail the entire perf inject command

So somebody with a NO_AUXTRACE build would generally experience a very
sad perf command. Having the option made sense when there were feature
tests that could fail, but possibly that should have just controlled
not compiling intel-pt. Having the option is extra burden on
developers/maintainers, as shown in my comment:

> This was prompted by needing to make a v2 patch set of:
> https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
> due to a broken NO_AUXTRACE configuration.

Somebody may have been using NO_AUXTRACE as a proxy for not having
some library, but I don't see that in the code. If this is the case we
should add the appropriate feature test, ..
Not having NO_AUXTRACE may have been a bug work around for someone, in
which case we should work to fix the bug. Again, I don't know of this
case and don't see it in the code.

Thanks,
Ian

> Thanks,
> Namhyung

