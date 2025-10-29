Return-Path: <linux-kernel+bounces-876509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F168C1BC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108775873CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BD31E0EF;
	Wed, 29 Oct 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLxJP1vK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7A2F7442
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751492; cv=none; b=F7jjI9pRVzR2N9u9rEee1mXOq+z+sbBprZxS30jPoZVDFu0nMg/7qgu4HosbV8cqaaPzzncSRBnNOidozB7H5Gsho0WbWWJbu0C7zuZK90noaNcjOCEGnD6xs2icExxif8bRZUU4EqoT3Ja+hTeZI9yqNn2KngjKrwecvmxwIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751492; c=relaxed/simple;
	bh=KvM3yAit5/aU5CrrYY64Jjy9JkZfQApA1gRH0OBVsOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGbH17Lk9veCSs7Lh0Fr9qZaLxIdhA4kirfKEaJWL2J2MHdTwtMDqS9JcfIp47wtZiY8ZP9w8gYvf97nSW8w/+Gt1WdYjqxjk0jdad9K9dxzH2x3u+NE2SWQlC9Pln7mKccTWB1XUl4j9K/UZSpO/ZKtg3LSIa3aVqwa6CZt92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLxJP1vK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so12828a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751489; x=1762356289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2iJ+gYl0WvAKtN7IryWto0AZlGcZPV36GKYmbq25K0=;
        b=PLxJP1vKjV1inw/eXjaPWqq1hNjviK6y8ad/zMP8biGQ+LEi26mYpSws9YbHDtgqYK
         pPBME9obWeVzTRod1fpx68mMBKHDEj6YSt5+sv7Zh63lvPikkgk8YRwhxD28TfgEpFrZ
         heN4PCwbqYkryFJpD26uJnexTM2W7HCLlhwedjw5r7S8RBKO/8Qo3Y6GM+lPG7YYoJvY
         +2cV727f3hebry8RbZ0U+qbfZ01pVrGBmLVLv0XvoUCl7oi7TGog94/O7yY5No+ysROw
         KCSONOPwDvNNxf0jl4AcQsA2eGKA0hjvD0bME6hkhCh2anCK9zYQ1uFcfCi06gdRBIik
         GfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751489; x=1762356289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2iJ+gYl0WvAKtN7IryWto0AZlGcZPV36GKYmbq25K0=;
        b=Am0A4l3+aK+PewQvnyRtyc1Nq4uvaA3hcRvtCI7S6Zgi1Rm/Xas9MEmRqTv6Re+jps
         UmOsPei9dN1UFOT7HBN0jWpUe7TnMk3rKiP42sr8eUIwzBdFgdgLe3BkC1HxhanNJuhD
         eCmZcfVql3NWcEDFkgCcPDtA0qWGdDaW+iY3tQSfeiVXDPY8F9Exwo2ytQrOjcW4kxOC
         iHEjQkHYpPhqtu1d6uOlrzo6Xai6vzjrJWArcDRsafH5dwnoyLlad+UImUa7a6zP57Qu
         k6S7e+5k2qyjcvHqlOTVCGoZoiLy70ZP+8Zae5QS/U36+1wtstuOKA4xxP/ePdUKpKfi
         cD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvFkPWMY/fJp/YD9D6R3RHWfTj6jvKs1DgEzY4aTaNDhHXYRG0+wKc9nT4ctZnv2HMbrRorIqW5MXRiDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr422eSo5+tNMn0hScuiBOpr9RFcZQ08Mo0VyW0fWgrP9Yv/4q
	g4l+ehxvJ/9zZmIN1tYB8+at+zRRTAsZn4SeUItMnfQ/NFYvPRkQiwsTtO2BVP/Mch5TdV9ovJx
	0rU8ua7fIgF+c6rgN/n/b6Fiq7vynZPu0J622LK1J
X-Gm-Gg: ASbGncta+ekPW+H675Ueyo4G2RXh5+9sl9rxhrgsca7mZI4Upcjm/wg4qA0zG2XX3e7
	oiQ5sI+nwKTNoocLdI2bBfTRwBBFPiuvphBsHClQBLSYFksDIkCk22sPxgIoZCKTAC/AtOq07lT
	zMIpZ/4Mi9Ljjj6MsWEIbbZYcrz8QLt40Fve9lLT9leDvVbGD9ermfIsF2BwiIdfYFwyy8I7JE3
	67raBJH6fqSGFfBE/ZDFwYVLySdH3Zd0uKbJgsqwxMs7qNmCXM5/iyfKC6vT+tieOmrw5ta1A7Z
	WgB2M0XLTHrDD1uQBfy/holzEw==
X-Google-Smtp-Source: AGHT+IGU+esMxf3ccvuz4aU0iKC9IRrUhCYYRzaNs+SjfV5pALSJtfH3UmgORTtgzOclQeamunCFAq3K9fIJ6y1muIQ=
X-Received: by 2002:a05:6402:24c9:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-640452b67b6mr123042a12.7.1761751488647; Wed, 29 Oct 2025
 08:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-4-harry.yoo@oracle.com>
 <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com> <aQHVB_8NVMZ2cuvh@hyeyoo>
In-Reply-To: <aQHVB_8NVMZ2cuvh@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 08:24:35 -0700
X-Gm-Features: AWmQ_blnOhRrDyAN8bKG9PnCSCcBONfyThj1KPKRqtofem1VL-BK-gJoV4GKMAw
Message-ID: <CAJuCfpGFPuoUceB7SvAJPtVvzOOCzqS50yCcjbuMxV2a0e0KWA@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 1:49=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 10:55:39AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > Currently, the slab allocator assumes that slab->obj_exts is a pointe=
r
> > > to an array of struct slabobj_ext objects. However, to support storag=
e
> > > methods where struct slabobj_ext is embedded within objects, the slab
> > > allocator should not make this assumption. Instead of directly
> > > dereferencing the slabobj_exts array, abstract access to
> > > struct slabobj_ext via helper functions.
> > >
> > > Introduce a new API slabobj_ext metadata access:
> > >
> > >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> > >   struct slabobj_ext element at the given index.
> > >
> > > Directly dereferencing the return value of slab_obj_exts() is no long=
er
> > > allowed. Instead, slab_obj_ext() must always be used to access
> > > individual struct slabobj_ext objects.
> >
> > If direct access to the vector is not allowed, it would be better to
> > eliminate slab_obj_exts() function completely and use the new
> > slab_obj_ext() instead. I think that's possible. We might need an
> > additional `bool is_slab_obj_exts()` helper for an early check before
> > we calculate the object index but that's quite easy.
>
> Good point, but that way we cannot avoid reading slab->obj_exts
> multiple times when we access slabobj_ext of multiple objects
> as it's accessed via READ_ONCE().

True. I think we use slab->obj_exts to loop over its elements only in
two places: __memcg_slab_post_alloc_hook() and
__memcg_slab_free_hook(). I guess we could implement some kind of
slab_objext_foreach() construct to loop over all elements of
slab->obj_exts?

>
> --
> Cheers,
> Harry / Hyeonggon

