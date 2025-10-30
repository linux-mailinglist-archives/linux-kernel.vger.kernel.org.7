Return-Path: <linux-kernel+bounces-877542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C760C1E63D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606643B7450
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783729B78E;
	Thu, 30 Oct 2025 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQJNNXr5"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF978F2B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800649; cv=none; b=aHXHPoatZHdN4Ekl6exmFHcrZ9n7611Zpfc4wJ8avV+ZxFx8AAKR2vvJwaf56UXd1zMg/1ZPID+vRA7A/BVaDv5Qvo0AoFND25hlZx02jb3/jzlH3oIKoOZAxUyI4AZ2WmSbio5nWZOHMljhc+QvilyWMkmtkzzK5psqIVHp3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800649; c=relaxed/simple;
	bh=hW+kS+9mzorf2jrcrOtFPVTPybuO8bZezLBdGIwS2xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdxaoSPvStQVcDH465wyuuDfh0rcfuTYIaXCJRKhPORcgGU41sjz5uKs53urWaWRu3cJPeTXS1mYOVMW6KvxRH0wC199/3o/qp7S4U5HZKni0G6T3919V2v3b/D68lrm6kEbk4hRrQsnyiY3eE2y0NtiS9r8PPy/S5fFOtWZNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQJNNXr5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso143391cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761800647; x=1762405447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imCnF/sFJhKXZqCTXzziLsifvuU1OPsnWOgGGE2EO8o=;
        b=xQJNNXr5BAjE6a5oP18PCgoXt21YHW86YQaZpyMHK0a3UzX3g+2mjFwdUZXTpTvD5H
         BxuLZ7dDQW7wIiUkoaHSjZjU3moY8XRR/YYnWTVLBXVJILqSUZwnmmCSnTIVSvDU5eCY
         lLcoiS3tn6HL9sS+E3Ses/UBgsV9L4KvhoQ6JQ7ciZyxKYIp+EE3Jg/0B9seVmGYFEQp
         nuRjNJSkiTlljwgFFWeUWNLxru5P7TqirNLybXcVBGtHvc4P9Qt56tMBGMRpg8xz0YbI
         8WJ9YIT24ePIAVOaZX/yfia0jEj1RI3MLvK9KHTxgTi6DYFIMQXtvtv6jDDtw6qGTa/v
         kQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761800647; x=1762405447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imCnF/sFJhKXZqCTXzziLsifvuU1OPsnWOgGGE2EO8o=;
        b=vxLMsFySalTxB2ICnBljphu3nqeKVOgInp457MtPLDxQV5UoM0YFikeXtFOMO6ED+s
         CSx/VY0bzDWjTFTLq3KNgtIbUdi5B9EagRG4DU2QN7LoZU889U3XbyXxmVialu4Rlge6
         yvNKFoZ+ouGe1FPsWkubshzq4Iixf1j23s/V60fWy0C81pHNL0NxyGQiE1qQZnqSuBYh
         xMMN2VP4KsKrPbX7739G8eaU8GRr2OPQsa7GC3J9pn4p9g6KUfFAwU7vtCIEbUXzausp
         5RFvGadaaxYaKYb+H3YxhYEQX6yBzG2ftajOBHQmHjppChjMC9etRXdIkqsn7ghEqMSL
         c3nA==
X-Forwarded-Encrypted: i=1; AJvYcCUck+YwpkI/sSmiSEb0hSj4/qCdb/1L3OWqoQW8EuTVD6A6ZAqp2CYrehqyF5Ds/mHVWB3Gs/H8tmA9GUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYDuiarToW/bZbgHWLtg3tWIEAJvfiz+zicx/mdeRQtozum7E
	4h/uPTvVFtjXQ3sk5j7gbSVyM1NItTemKgUdtrsCLnCFuIGj1APNUAxSlKXlAqu0trXFk+dB4NH
	B8rnM1oejkmG+I/4buWel+j637cOubO2QNjbRETSC
X-Gm-Gg: ASbGncuv5zlVqUyqH7EN/K4sS6LR/OWUOaB/BQJr8x8Eg5Xig/iqhopBwi9OZ45XWfr
	IuYMvDGQHeruKC3nI37zCjH3TX35AXVeZ1qnWi13oNq22yLpU/6OOAkzFLKiEGMk/YgsfTploMk
	EFVXiFvO/0w39wtiAnc3tQ89TL9Ow7W0o/NMswFr56pKkhZ6bmes7T0Nw+X1jfQad8VPZwvnaB8
	0j1TmsS0oPEhalAu/B/y3VkK2GqIM8GcXHwoABxmzHuzUphPFuNTLnyqW21a5b6Q7lQUA==
X-Google-Smtp-Source: AGHT+IEB/ILAA9xYUQfW2KWQNzMMCyTN5Fgh1c/JAVWGUaLoeQoqs8yLNH5vm5UUyHsuDvyZMDkjSMrqPQd6JjIiXNg=
X-Received: by 2002:a05:622a:1992:b0:4e8:b245:fba0 with SMTP id
 d75a77b69052e-4ed24201737mr2800941cf.14.1761800646803; Wed, 29 Oct 2025
 22:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-4-harry.yoo@oracle.com>
 <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
 <aQHVB_8NVMZ2cuvh@hyeyoo> <CAJuCfpGFPuoUceB7SvAJPtVvzOOCzqS50yCcjbuMxV2a0e0KWA@mail.gmail.com>
 <aQK-wyE-h1bvaNOq@hyeyoo>
In-Reply-To: <aQK-wyE-h1bvaNOq@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 22:03:55 -0700
X-Gm-Features: AWmQ_bn3R48jrJn5u8sZk4g75yU9gtIgBe7otWH9hfRDS1mVIDIvKkjdnB9DenY
Message-ID: <CAJuCfpFNsmS-wk8OQJwAsT6kRBz9TOmA2wuCJ=AL4588qhYtJQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 3/7] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@linux.com, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 6:26=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Oct 29, 2025 at 08:24:35AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Oct 29, 2025 at 1:49=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 10:55:39AM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle=
.com> wrote:
> > > > >
> > > > > Currently, the slab allocator assumes that slab->obj_exts is a po=
inter
> > > > > to an array of struct slabobj_ext objects. However, to support st=
orage
> > > > > methods where struct slabobj_ext is embedded within objects, the =
slab
> > > > > allocator should not make this assumption. Instead of directly
> > > > > dereferencing the slabobj_exts array, abstract access to
> > > > > struct slabobj_ext via helper functions.
> > > > >
> > > > > Introduce a new API slabobj_ext metadata access:
> > > > >
> > > > >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> > > > >   struct slabobj_ext element at the given index.
> > > > >
> > > > > Directly dereferencing the return value of slab_obj_exts() is no =
longer
> > > > > allowed. Instead, slab_obj_ext() must always be used to access
> > > > > individual struct slabobj_ext objects.
> > > >
> > > > If direct access to the vector is not allowed, it would be better t=
o
> > > > eliminate slab_obj_exts() function completely and use the new
> > > > slab_obj_ext() instead. I think that's possible. We might need an
> > > > additional `bool is_slab_obj_exts()` helper for an early check befo=
re
> > > > we calculate the object index but that's quite easy.
> > >
> > > Good point, but that way we cannot avoid reading slab->obj_exts
> > > multiple times when we access slabobj_ext of multiple objects
> > > as it's accessed via READ_ONCE().
> >
> > True. I think we use slab->obj_exts to loop over its elements only in
> > two places: __memcg_slab_post_alloc_hook() and
> > __memcg_slab_free_hook(). I guess we could implement some kind of
> > slab_objext_foreach() construct to loop over all elements of
> > slab->obj_exts?
>
> Not sure if that would help here. In __memcg_slab_free_hook() we want to
> iterate only some of (not all of) elements from the same slab
> (we know they're from the same slab as we build detached freelist and
> sort the array) and so we read slab->obj_exts only once.
>
> In __memcg_slab_post_alloc_hook() we don't know if the objects are from
> the same slab, so we read slab->obj_exts multiple times and charge them.
>
> I think we need to either 1) remove slab_obj_exts() and
> then introduce is_slab_obj_exts() and see if it has impact on
> performance, or 2) keep it as-is.

Ok, it sounds like too much effort for avoiding a direct accessor.
Let's go with (2) for now.

>
> Thanks!
>
> --
> Cheers,
> Harry / Hyeonggon

