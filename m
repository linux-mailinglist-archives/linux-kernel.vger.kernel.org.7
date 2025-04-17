Return-Path: <linux-kernel+bounces-608304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD52A91179
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 04:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93295A31EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9B1C84C1;
	Thu, 17 Apr 2025 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzYLMow2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFA2AEE2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855760; cv=none; b=eXNaLR0ghR+AybDIOlSRFG9kdCtHy/yYuhPuLZEaNDUEUWzyvhxHxhA8H/uLk4yEaCcc/xvL4igQrXv0Yli38pX3LshmDqyj16qf+1I/HIW4Dsi4PKhiCvmVZaNvVtWwG+DWzZRxezsX1VmbIZuf3v6IJV10jib4miVFq9qhf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855760; c=relaxed/simple;
	bh=KSelZMOHGBCAC6ffhylcs5ml2BXN3psxianAepa1Pw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAnlYW/Q+Bsa8F89YyWNZHmnQxaKl1tlvQWax15MRTYH8l/VytkpXIStGmp/17RUWlZjXO4GliCJv7XqFK+UzLNow0uTpDTPjWi326QC1XESa/S82LrYfAd/PQmbGeuzjaMB38K+yd/wV2DPmyRnx9mSg+wiSg+KUFrVZW2M+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzYLMow2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso33535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744855756; x=1745460556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSelZMOHGBCAC6ffhylcs5ml2BXN3psxianAepa1Pw0=;
        b=JzYLMow2LkLFPXSefmx1gmC72CSr7O902d+IMLLKHcYAnh4cz8Z42hzFCxR278ZFOh
         rgTm2RhJ8s4j9zKTKcCTzvxUeqkG2ffMfGvV2NpV9o3YnmhZbd6HAWygJywKPPHOBQHT
         v6GIose+LN7ZeN91pXPT1Szt17BECGMYNYtx6/0mCaBNr13XKGiBlBj+5a5QNHqerh+x
         4QXhYYFltm1e2vCJOOijX/HmedyvwaQHIb4WuFedgAfA2W9bVYAgvet+0f1ILZloSDi+
         jgdGGbsEFNJwAzwz7c5kGbLAugnCQp+WN9XRSo8wN4tV3uHaAP2EiTZbCGdRkqhwKqmI
         TI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744855756; x=1745460556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSelZMOHGBCAC6ffhylcs5ml2BXN3psxianAepa1Pw0=;
        b=TXq/co3se3fX4XcMzR5okdlp1ZDkHjPhyqUPGjMiqZStT2dgRGiCygDluSKibAsHYL
         p8DZRXCZ9aaH8v9OhQtAEak49eG0M/ibV3UY3wN/cpUwSON8HZljJLg7Sp6XUdnsDkNq
         +f6VneCXIbcKzCPEv8HXrgyL+NMWnqkLMnSCgXpDBFsD+hOcQrS6feBV0ODIA98m68zJ
         vyPx30CR5sEpwR1r8PIxZaE4ir5UBYROBHB/vp01KJDcpZxUmFseBrNrocedyT3FTZ+7
         rapuCXw7VNQnH9IQvC4wb+tXJ6WX2QBCO9gaSSkUZEoP7tvG6ZmoT4u61cxD7hGRex/R
         f8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3T2xTIrI/8V+NRmpPbzdKKmE200egt5KTVzE3DORC3Y4/ZdMlRFObq83mIhzPabeU/P8bbDQDYb5ef0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddNy1U6QmEjTDDOlAQPJVtXrQ5/pILFoASO28/h9ohTJpacxP
	mv5n+6bl3GyHvOIZ5HZAd4I1AcEPfgncclbBK8ulpm3929SUy0fotC7BVUK35zm8+KE8q6bL+6S
	NYTZeSuZYw9PSs/zQI1lcVMUFy2P4EOCV3CgQ
X-Gm-Gg: ASbGncvzGth/4yHU15BpUwU5b4BkVVK1nGihiCd0R9imqep0cdjQuOBLuLK54nq8Hn5
	MrNh02n84R0FC1m9XADJRuUjuZjIpCBOKqXpYuSVcLZg+d3XEwzLw4Dg3sL9nRnrnQkWDZKylDL
	PPalJY5SnUWD8Zu+oJcSBB/wdNoLIB+fE=
X-Google-Smtp-Source: AGHT+IFrppytZV5cSJfrYgzaifTbDrHqkypNt5Bohd7JB9cXbxaDZ8Ylu35PtX/6cVUznzvu+dDy2IZggStg9q0OeRc=
X-Received: by 2002:a05:600c:3042:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-44063d2802cmr294225e9.1.1744855756423; Wed, 16 Apr 2025
 19:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
 <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
 <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
 <CABdmKX1tDv3fSFURDN7=txFSbQ1xTjp8ZhLP8tFAvLcO9_-4_A@mail.gmail.com> <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com>
In-Reply-To: <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 19:09:04 -0700
X-Gm-Features: ATxdqUFLL37LKBoNbpt1TbRt2xDWynqShrVasUjLiM1tjzZW-eK8x-aahsy-M1I
Message-ID: <CABdmKX1p0KgbipTSW1Ywi4bTBabQmsg21gA14Bp5atYHg8FeXQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Apr 16, 2025 at 4:40=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Wed, Apr 16, 2025 at 4:08=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Wed, Apr 16, 2025 at 3:51=E2=80=AFPM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > [...]
> > > > >
> > > > > IIUC, the iterator simply traverses elements in a linked list. I =
feel it is
> > > > > an overkill to implement a new BPF iterator for it.
> > > >
> > > > Like other BPF iterators such as kmem_cache_iter or task_iter.
> > > > Cgroup_iter iterates trees instead of lists. This is iterating over
> > > > kernel objects just like the docs say, "A BPF iterator is a type of
> > > > BPF program that allows users to iterate over specific types of ker=
nel
> > > > objects". More complicated iteration should not be a requirement he=
re.
> > > >
> > > > > Maybe we simply
> > > > > use debugging tools like crash or drgn for this? The access with
> > > > > these tools will not be protected by the mutex. But from my perso=
nal
> > > > > experience, this is not a big issue for user space debugging tool=
s.
> > > >
> > > > drgn is *way* too slow, and even if it weren't the dependencies for
> > > > running it aren't available. crash needs debug symbols which also
> > > > aren't available on user builds. This is not just for manual
> > > > debugging, it's for reporting memory use in production. Or anything
> > > > else someone might care to extract like attachment info or refcount=
s.
> > >
> > > Could you please share more information about the use cases and
> > > the time constraint here, and why drgn is too slow. Is most of the de=
lay
> > > comes from parsing DWARF? This is mostly for my curiosity, because
> > > I have been thinking about using drgn to do some monitoring in
> > > production.
> > >
> > > Thanks,
> > > Song
> >
> > These RunCommands have 10 second timeouts for example. It's rare that
> > I see them get exceeded but it happens occasionally.:
> > https://cs.android.com/android/platform/superproject/main/+/main:framew=
orks/native/cmds/dumpstate/dumpstate.cpp;drc=3D98bdc04b7658fde0a99403fc052d=
1d18e7d48ea6;l=3D2008
>
> Thanks for sharing this information.
>
> > The last time I used drgn (admittedly back in 2023) it took over a
> > minute to iterate through less than 200 cgroups. I'm not sure what the
> > root cause of the slowness was, but I'd expect the DWARF processing to
> > be done up-front once and the slowness I experienced was not just at
> > startup. Eventually I switched over to tracefs for that issue, which
> > we still use for some telemetry.
>
> I haven't tried drgn on Android. On server side, iterating should 200
> cgroups should be fairly fast (< 5 seconds, where DWARF parsing is
> the most expensive part).
>
> > Other uses are by statsd for telemetry, memory reporting on app kills
> > or death, and for "dumpsys meminfo".
>
> Here is another rookie question, it appears to me there is a file descrip=
tor
> associated with each DMA buffer, can we achieve the same goal with
> a task-file iterator?

That would find almost all of them, but not the kernel-only
allocations. (kernel_rss in the dmabuf_dump output I attached earlier.
If there's a leak, it's likely to show up in kernel_rss because some
driver forgot to release its reference(s).) Also wouldn't that be a
ton more iterations since we'd have to visit every FD to find the
small portion that are dmabufs? I'm not actually sure if buffers that
have been mapped, and then have had their file descriptors closed
would show up in task_struct->files; if not I think that would mean
scanning both files and vmas for each task.

