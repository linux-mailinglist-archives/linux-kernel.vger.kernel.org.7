Return-Path: <linux-kernel+bounces-616994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A47A998F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 21:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD244A2F92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF62676CD;
	Wed, 23 Apr 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywyS3iY9"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330325C82C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437945; cv=none; b=nO+nygciZOTW/WPV++vrCRfNG1s1WBgHDEQhvmqZiNdaFR2XFuLcvXMuNRBx3Pr/PZSt60gHihYVD/U6TRGQ8/nomQ9YyQHYgZ/yhlQVJrlXaKen6hFE0RpAx4Rqjy6WNKQiAq+/SH42NID1PCkEmv7vmSxpHP7pzYbNqn2VkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437945; c=relaxed/simple;
	bh=6CFbqi4rYx8ZGB/rgVhh/cJewRwwE8YJCMFAGQ8OFpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXppEwYcIxGrMvh8LVn7VfBB8i0VAZF0GtiDnvdtTkaXVv5GMXe+/AtH1ln9MffP3EB1mNyr9Iw/Mu2KPbuJ01Z07L0SYr/xseNGitP+bMC18QCtUwText//Jj4a8KsKl/2ycWwqrttq6n9whWV6/utPYJGNHGQ9lcWnMQ+6q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywyS3iY9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6eeb7589db4so3663176d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745437943; x=1746042743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xVavQGeHiKp7rEiymJ5kdyLh0t3H4T8Z/fRsD3R+Vc=;
        b=ywyS3iY9aaQBGYSlCyP3Nhl7+XtapcTMxc3Znr0nYP7b6i5DpcX448vNu0zz9JjYX8
         IFaDwg5mTLIYD4UpslcMOVADTaTn4c/CU//HvniXx/GTo2hYGgKx4aAiV84H3kL/aNfg
         O0ji3AX8JiRSjdcTBsuETrG2FbOiBnvvUSWuCBTpaz7X3iHq70+UIZNb9yPSEdoJmq+f
         Z62cwgcYqyBDk7/+I4Jv6NjW2vbUDn42HrJbo8TrQFk9CcrPIpIPqTTUYa8EymI7PkCR
         GIqful2iWfVaoyZekvmu86lsWblzio5Vy46JIUIQ1LGPURomgY58YvVwU7E3r3G9JPJ4
         sjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437943; x=1746042743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xVavQGeHiKp7rEiymJ5kdyLh0t3H4T8Z/fRsD3R+Vc=;
        b=J+xrjza+Iw55IcPsnpg1eLB+SND1VqJSIlVc5yNob9b8C7ff6xz4SR+690Wea7v689
         9GWJMW5HzfpeflQ20FY5z8BbWDbmBgrKnak6RulqDMWxLW2raQhKBP/df6eipjayfF+V
         IFzJdQfneSIySWGEStirR7e3GROt7RHH8pzfUJRsk3h9LblzqgndPusFKjV/NB4xNK7t
         xqJttVi4VdfRbheFHEWDWFO2mBi9DnrNu4Xr6C+fgcOPcptojhpbkbiQeEY5Q/fQ2x2g
         GE32pmy29e3v1aWrUGWQ/6wrue/dh9ys9NYJi/mqpHjZTfZXwCS0CA+SL4om9ewX5zVo
         ykmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/HbLj8DWWSBjnsOszulBlZj7Bweo/LFu3F+M5+fZP3+ecn6R6eQUsKjsV5WbKUowZXVUDnlblUO4cIb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9Laa5JDer1qtWxN9dcNiD1YjGG7AkwoOuHNm+3PhPqnAkzqr
	td4ELo+5/8AjGw5oE3KLJFxcyBnas+wUJ0vju+VigXf1Mb96mn7U+QOavI0TcCEcPKqh1SVHDVi
	2gmrTp20qNkAmjVmlZNS5+N907K7jaR+dZGQ=
X-Gm-Gg: ASbGncsAI+lIFMmMVXneFthbsBZyGIG2elK3+NHUWVzCQRmedqU836CF/F4MVto2nMv
	Dx0ipQJZlCgXnsArSDG9A/r1v1Ub0V1mF4Wx2YZ7OjswREm7aNVmcqDodIfN2bl26PRhc1Fy9lf
	IlE3JLIIcI9kMcA08viGEx98RwToweLJTShHqtKh0yB0CXnOK5zJ0=
X-Google-Smtp-Source: AGHT+IGvkeMBlU3PpGjnWugnhbT53UHQ7DwITUrvLyvzt1HBLSHaQaZ8fpdIp3kWeT20F4N4HGIU5JKsHeWBdDZUuKM=
X-Received: by 2002:a05:6214:27ce:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6f4bfc1a1f9mr498676d6.23.1745437942447; Wed, 23 Apr 2025
 12:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com> <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org> <aAeQcgmL-iqGbG_g@gmail.com>
 <20250422141026.GH28953@e132581.arm.com>
In-Reply-To: <20250422141026.GH28953@e132581.arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 23 Apr 2025 12:52:11 -0700
X-Gm-Features: ATxdqUF-LMwUWmW3taSe4IV8gwEgoHiIaDfjDbYRrV--toG-Jr8hdz8bhgWNT-Q
Message-ID: <CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU capability
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mike Leach <mike.leach@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 7:10=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Apr 22, 2025 at 02:49:54PM +0200, Ingo Molnar wrote:
>
> [...]
>
> > > Hi Yabin,
> > >
> > > I was wondering if this is just the opposite of
> > > PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default
> > > for all devices to solve the issue you describe. Because we already
> > > have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages.
> > > Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high order
> > > allocations for AUX buffers optimistically") that explains that the
> > > current allocation strategy is an optimization.
> > >
> > > Your change seems to decide that for certain devices we want to
> > > optimize for fragmentation rather than performance. If these are
> > > rarely used features specifically when looking at performance should
> > > we not continue to optimize for performance? Or at least make it user
> > > configurable?
> >
> > So there seems to be 3 categories:
> >
> >  - 1) Must have physically contiguous AUX buffers, it's a hardware ABI.
> >       (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)
> >
> >  - 2) Would be nice to have continguous AUX buffers, for a bit more
> >       performance.
> >
> >  - 3) Doesn't really care.
> >
> > So we do have #1, and it appears Yabin's usecase is #3?

Yes, in my usecase, I care much more about MM-friendly than a little potent=
ial
performance when using PMU. It's not a rarely used feature. On Android, we
collect ETM data periodically on internal user devices for AutoFDO optimiza=
tion
(for both userspace libraries and the kernel). Allocating a large
chunk of contiguous
AUX pages (4M for each CPU) periodically is almost unbearable. The kernel m=
ay
need to kill many processes to fulfill the request. It affects user
experience even
after using PMU.

I am totally fine to reuse PERF_PMU_CAP_AUX_NO_SG. If PMUs don't want to
sacrifice performance for MM-friendly, why support scatter gather mode? If =
there
are strong performance reasons to allocate contiguous AUX pages in
scatter gather
mode, I hope max_order is configurable in userspace.

Currently, max_order is affected by aux_watermark. But aux_watermark
also affects
how frequently the PMU overflows AUX buffer and notifies userspace.
It's not ideal
to set aux_watermark to 1 page size. So if we want to make max_order user
configurable, maybe we can add a one bit field in perf_event_attr?

>
> In Yabin's case, the AUX buffer work as a bounce buffer.  The hardware
> trace data is copied by a driver from low level's contiguous buffer to
> the AUX buffer.
>
> In this case we cannot benefit much from continguous AUX buffers.
>
> Thanks,
> Leo

