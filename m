Return-Path: <linux-kernel+bounces-804534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A227B47929
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3AA1B228AA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCB1D6DDD;
	Sun,  7 Sep 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0ZKWe6z"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A6F4FA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222202; cv=none; b=Ic5xA7Qw9J/VpC9bf2jIG5b2g82MwLpK7uJRzAGqL28gIG++A2edzMV4LS6xg4eHU3YqcvnWdDsHHDRdXZLrDxFGBJz7V1Bx+5K43bDtTvnOW8pHgS0PzZgSw9Nkg1ochFSc7C87AtEl8begmz4CVy+uIrnq2Pthsh2v0dQw4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222202; c=relaxed/simple;
	bh=ShjqWXCQdzz5P/csLgvS4g4rnUjrvvtx5BIFMZzRD/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evGyAZFx/BZ8tV3keN2axO3lxQp8+8ld5V9tkQFUE607BcM5aZiwwg1YuYFJ4px5UmNZuW/0z94h73pknYFwrzf4WIMMHC98zFUilPPLY4ffBXMB4x4N+rRFAlH8tHe86gIgNuXZU5U7zkO9Q19/fKsBdKptrq9BNFhCR0RpG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0ZKWe6z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b350971a2eso178221cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757222200; x=1757827000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShjqWXCQdzz5P/csLgvS4g4rnUjrvvtx5BIFMZzRD/s=;
        b=D0ZKWe6zJ5DBk3u49sFAXcswZI5xjCLZYkg8a0DwZFax/7MwrgfM+AjDCFdQ4d2Lo9
         /YoN9iLAp5YpeIwo9pTIIlTniIt5haM/bv9zCkazsgJhbyvj139W0CWc+3XRChb6nwwf
         /LIIptyBbClufqYirNxDf14yn/24tMZeQSmYlZ/Dxx/a7KTrYJLddBWG6aYrF8ssQuoR
         8xRz1E2H+am4kSxYtyRAnXIrsBOe614BH+yZ1XensjJC4z6ib+zhlnHBZeAs399NPqHy
         uTuRQtjvfyyNh1pOjbLwkvYS5yz+KH6fvtxnxSz3Cj1PReTaX2XfxnrE+eZ9HCrMRgJz
         p5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222200; x=1757827000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShjqWXCQdzz5P/csLgvS4g4rnUjrvvtx5BIFMZzRD/s=;
        b=j+L4Ray7ycmSa4Pt73V80AW2aOYChih+gYW9rRPem8rTjDuIKhX11RIWqzFMY2DK6b
         OHwd+NKDGiV65TQyMC4p8q0kwePAAe5OHn5FvVcvOApMZNlViJHyTj5icM+Bt1AyVQoB
         ivPu56veOY2TXqih2bMjPIi7pSzxehqakp/JMl60j6Gqx1Pk4hFl+pgNX7NQay7wrG1q
         UM+HnJOw0snOLre8lVlUp5U4Yr7jGZT1w3l14rxhVrLG1r3hTkccQcny8lHNd0nhcMAj
         +Y5MoV3Rghh0UGahIOX1qmmvOVF8vvyAgXy14tWhOG87I/zUkYTzHmKCex/CtNLqPjyk
         EuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc10qyld0TH2Gr86mq9OfQM/m01MH4TifwzYtDopWQ4cc+y3+WBDivooBO4wOm3YYrrMzYADwOIJ201a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMy2CjpLZlayavDGJZWHDohaILOwhxb4iofr6kcdGpu86LEqCL
	3MjtJGB4KEGKu78Q9Sxe9fxJo+5viPLtCeo2tcQqP767ka748mc4lvxACzvC5tK9YOXxQsQVTdU
	6SKKiYeWPSxOeuGP5+Zac4QojBLoqvzezG4AT/gQv
X-Gm-Gg: ASbGncsWk8BOha7vq2sv3YcchImM1HZ1NWzO/nIzOCMuP6LKOt4MN1duJJGoCaRX4Rj
	Y/nG5ePD6BZ72VL9592Ga4afU0L2lffdcf37MUJ//OtGV9fbJtCz2UgcinHkybrtfmFJ1PzY/Mb
	Im6Fym9z6nHjW0ExAVTFxf8TblzcvVnOe9mFg1B3dy/gXX4OZcU8IiVQEpasp9LRnvqLyQ8q1e8
	alWWJdvDvEcMjFsCrnUXrqUrec+K/PBzNgsvcn2A7evMQ8e
X-Google-Smtp-Source: AGHT+IH2UlbxM/Uzxg5uqSqTaCsgQbK9Rw3KZwBmRi8V/IgoDIQG7Ath+K7o+B3tDBsSn2aHT+JwtXNqSdoRpTn2O0c=
X-Received: by 2002:ac8:5981:0:b0:4b3:509b:8031 with SMTP id
 d75a77b69052e-4b5f83cd080mr4076281cf.13.1757222199461; Sat, 06 Sep 2025
 22:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com> <5o52rxp4ujglel53cs6ii2royaczuywuejyn7kbij6jknuglmf@frk4omt5ak7d>
In-Reply-To: <5o52rxp4ujglel53cs6ii2royaczuywuejyn7kbij6jknuglmf@frk4omt5ak7d>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 6 Sep 2025 22:16:28 -0700
X-Gm-Features: AS18NWBwfIS7dirB4t0GoXLCzK48DFFhzngu30-yZfZ5H5ufI_4DrJL5bIsH4mQ
Message-ID: <CAJuCfpE3pXB5=sZLywPgCk5sU1t-=G00TG-dLaXpYheSPYz1RA@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yueyang Pan <pyyjason@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sourav Panda <souravpanda@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 2:15=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Aug 26, 2025 at 07:32:17PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Aug 21, 2025 at 12:53=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > > Right now in the oom_kill_process if the oom is because of the =
cgroup
> > > > > > limit, we won't get memory allocation infomation. In some cases=
, we
> > > > > > can have a large cgroup workload running which dominates the ma=
chine.
> > > > > > The reason using cgroup is to leave some resource for system. W=
hen this
> > > > > > cgroup is killed, we would also like to have some memory alloca=
tion
> > > > > > information for the whole server as well. This is reason behind=
 this
> > > > > > mini change. Is it an acceptable thing to do? Will it be too mu=
ch
> > > > > > information for people? I am happy with any suggestions!
> > > > >
> > > > > For a single patch, it is better to have all the context in the p=
atch
> > > > > and there is no need for cover letter.
> > > >
> > > > Thanks for your suggestion Shakeel! I will change this in the next =
version.
> > > >
> > > > >
> > > > > What exact information you want on the memcg oom that will be hel=
pful
> > > > > for the users in general? You mentioned memory allocation informa=
tion,
> > > > > can you please elaborate a bit more.
> > > > >
> > > >
> > > > As in my reply to Suren, I was thinking the system-wide memory usag=
e info
> > > > provided by show_free_pages and memory allocation profiling info ca=
n help
> > > > us debug cgoom by comparing them with historical data. What is your=
 take on
> > > > this?
> > > >
> > >
> > > I am not really sure about show_free_areas(). More specifically how t=
he
> > > historical data diff will be useful for a memcg oom. If you have a
> > > concrete example, please give one. For memory allocation profiling, i=
s
> > > it possible to filter for the given memcg? Do we save memcg informati=
on
> > > in the memory allocation profiling?
> >
> > Actually I was thinking about making memory profiling memcg-aware but
> > it would be quite costly both from memory and performance points of
> > view. Currently we have a per-cpu counter for each allocation in the
> > kernel codebase. To make it work for each memcg we would have to add
> > memcg dimension to the counters, so each counter becomes per-cpu plus
> > per-memcg. I'll be thinking about possible optimizations since many of
> > these counters will stay at 0 but any such optimization would come at
> > a performance cost, which we tried to keep at the absolute minimum.
> >
> > I'm CC'ing Sourav and Pasha since they were also interested in making
> > memory allocation profiling memcg-aware. Would Meta folks (Usama,
> > Shakeel, Johannes) be interested in such enhancement as well? Would it
> > be preferable to have such accounting for a specific memcg which we
> > pre-select (less memory and performance overhead) or we need that for
> > all memcgs as a generic feature? We have some options here but I want
> > to understand what would be sufficient and add as little overhead as
> > possible.
>
> Thanks Suren, yes, as already mentioned by Usama, Meta will be
> interested in memcg aware allocation profiling. I would say start simple
> and as little overhead as possible. More functionality can be added
> later when the need arises. Maybe the first useful addition is just
> adding how many allocations for a specific allocation site are memcg
> charged.

Adding back Sourav, Pasha and Johannes who got accidentally dropped in
the replies.

I looked a bit into adding memcg-awareness into memory allocation
profiling and it's more complicated than I first thought (as usual).
The main complication is that we need to add memcg_id or some other
memcg identifier into codetag_ref. That's needed so that we can
unaccount the correct memcg when we free an allocation - that's the
usual function of the codetag_ref. Now, extending codetag_ref is not a
problem by itself but when we use mem_profiling_compressed mode, we
store an index of the codetag instead of codetag_ref in the unused
page flag bits. This is useful optimization to avoid using page_ext
and overhead associated with it. So, full blown memcg support seems
problematic.

What I'm thinking is easily doable is a filtering interface where we
could select a specific memcg to be profiled, IOW we profile only
allocations from a chosen memcg. Filtering can be done using ioctl
interface on /proc/allocinfo, which can be used for other things as
well, like filtering non-zero allocations, returning per-NUMA node
information, etc. I see that Damon uses similar memcg filtering (see
damos_filter.memcg_id), so I can reuse some of that code for
implementing this facility. From high-level, userspace will be able to
select one memcg at a time to be profiled. At some later time
profiling information is gathered and another memcg can be selected or
filtering can be reset to profile all allocations from all memcgs. I
expect overhead for this kind of memcg filtering to be quite low. WDYT
folks, would this be helpful and cover your usecases?


>

