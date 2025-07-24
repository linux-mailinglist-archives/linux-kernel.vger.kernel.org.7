Return-Path: <linux-kernel+bounces-744540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA1B10E48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627831CE5C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE92E9721;
	Thu, 24 Jul 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPoZHjCq"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944992E03E3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369520; cv=none; b=aBFNIqQrFas4UcmIkTvQUS2K5nf7w+TCJNtScGjbgPpu3U9zbdbQX79jhW/0aFEVVH03HuKsiHV85mXFpWr4zMk/Vv3b+74sTBWWlq8WQbgbZG4PJgcCjPpzqRoppKI76//vaDxjBsHh5cMQW0fW0tz5A4711EP88pXxH+MZ5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369520; c=relaxed/simple;
	bh=XS49UAWaM6g57Ov/kyZQ0TdAaGw+pgSYdI+CbbjwHDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBMjAoPwigGw0+pYiZpucEqUHWuizgnFcGkUkqDHZ1PfEW8+yt3JRfxATtj8hkoA9F338GZBK2ILlFUBM5M53dpoctNlsmnOBsYJrt/fa2kaMRO4ziHz3Q3aiVNRl161a1w5jPtOOBQifGnKcs1qdLt7p2XvvjIP+wd/Q5gpgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPoZHjCq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df371e1d29so120625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753369518; x=1753974318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvJko2i1qJQeNj8KL/Ae2uOExbpWlktOcGSi8mGX7iw=;
        b=UPoZHjCqjEFexTCuQKfpeVA2SCOIq5J+ZbBnTsd5M65PpwzgMcQrXzLaRJwHFftdUo
         KqrWDS7Xse5JnDL3pD3Y51rMg1CWNU87QHRHxu6VCPwTMLpBIEM64ubeUOR3YPp8DTZQ
         jNJ5tLAhHRvOQ5zvjDOUxG6RAvakrQ8UfiY2p9rpf0tXqCqVjVW9FuopKXY5jTHnVTJq
         ePNMH89UjJwhQAvkn4pId8vjcU4WTx6EJ/eqjyWpvR1tQQHPNb9p8FTeKAnIQjBs+VXv
         hWW8DdioAsMHMIVtnaIUJCrjUqR/oTUvtuFXyR0GiHDDFny5G+uQdK0vUx+pfKmRKQEB
         GzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369518; x=1753974318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvJko2i1qJQeNj8KL/Ae2uOExbpWlktOcGSi8mGX7iw=;
        b=e02pWlWR4AEpCMNOv8jsmwccSc+nAsC8kVoKEhCqpzyUvxke0Q7sIwa5fcGGOBfT3b
         oxH1bbDmo1Boxr9hzGmd8wim5TScWG77Z0PXAJgyAaYAElAMCp6xdh3q2UQFUkdXgtOv
         lHCt7JYcW8AXOCpEp+HMWlQGf8/DQ2Asxhvu+TzY61TW1aTee81Otcx+XFfoikS6AIgy
         oX27YiFh3qy49deq7mryJV1UrCOPA7TB1e4Ux88l3v3xcAngMP7zLxfFw/2GaXu5yp0a
         FUz/ViIjo9cadda08ZodvzTka8QA5QSwhHKrAG54HDLChXztekhd7s2+gd5ZEiEAR/CM
         e3tw==
X-Forwarded-Encrypted: i=1; AJvYcCVqa0Ur50g+MVC+AV1IeSTx+x3iiChi88BKB0E7tybE5c6cDyFFeWYzBE1q25OVZnDKY6l9wJdcQ74lzqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPR7mE9KcMna0DfNH2IjdheFlTHAdb0S4wJ8BNGS0xl079LPL
	8pHH36D/48grsjbqdCPq4LwEOSmwSsZ9jjc4YTFWaBnVEQss9AKbokfJ3fTMkDkoGsOkhm1SGdb
	WO+5OmZ2bc7SZQ/jF4UT09G6SkOyUsOoaBMUJIx+S
X-Gm-Gg: ASbGnctvLHQ/7vduFhg6YQMP1sasUDSvq6uIjkHHw9GdOFo6EucP7zXCa8UagnuFznn
	ZmnU5yqk71rDMMdizE+/VkNJ3DTx5fQbnt1HNLsU+ZNs3jgMj2TNCWi9og8lTut3b2gsXaYM4/5
	cQPBVkMa3bVAvToV6jKu6g/KVngfA8bOwRR+FNb3IJ7SUZNzVRa9FRQ5s4y7hb45/rnPwak45GY
	HnxbLdS5G4KzIcStwSnNEAlWXeUAIxvZlHm
X-Google-Smtp-Source: AGHT+IFlvgfC1WSKV++RmyX0sLt7P/0dcLE8O0wKmgO0LT0s4nsCS+0JUzGQFSrFE6LkHFpTjI6fgghCvV1uSGLyR6k=
X-Received: by 2002:a05:6e02:1a6a:b0:3e2:865b:6b62 with SMTP id
 e9e14a558f8ab-3e3b7324babmr3227455ab.1.1753369516998; Thu, 24 Jul 2025
 08:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com> <20250723232217.516179-2-irogers@google.com>
 <aIGBAQv2Cn9qGqP1@google.com>
In-Reply-To: <aIGBAQv2Cn9qGqP1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Jul 2025 08:05:05 -0700
X-Gm-Features: Ac12FXwiaiafw1HYwJqDKYeKgUMZ_hcmmEdj70cxz9U-2F3-RpBomriDPMoKJF0
Message-ID: <CAP-5=fV96=Vtgzu6quGC5pHHL8JECHtvXzUJJgOxzc15=fKJRA@mail.gmail.com>
Subject: Re: [PATCH v8 01/16] perf python: Add more exceptions on error paths
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 23, 2025 at 04:22:02PM -0700, Ian Rogers wrote:
> > Returning NULL will cause the python interpreter to fail but not
> > report an error. If none wants to be returned then Py_None needs
> > returning. Set the error for the cases returning NULL so that more
> > meaningful interpreter behavior is had.
>
> Nit: I still don't get what "add more exceptions" means.  What I'm
> seeing is adding more error messages.  Also returning NULL from this
> function won't pass it to the interpreter as the convert checks the
> return value.

So it isn't error messages, calling for example:

  PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
event->header.type);

is like setting errno as in there is a global/thread-local current
exception object. When this is set/pending, returning any value will
cause the interpreter to throw an exception on return, so NULL is an
okay return value - normally for returning NULL you need to return
Py_NONE. Anyway, the old code was returning NULL but without the errno
like exception object set and so the interpreter was crashing/failing.

> But anyway, looks good to me.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

