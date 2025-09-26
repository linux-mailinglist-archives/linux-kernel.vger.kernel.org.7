Return-Path: <linux-kernel+bounces-834324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE1BA4720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FD87AD103
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FD212B2F;
	Fri, 26 Sep 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ayE2oDV"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F19FA93
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900986; cv=none; b=bXRa4R0VM2WJrxwIb0V0Klgtp4OLtOwpK1KGeheYdzVxSTHn0A36IIBJpW9XrsxjvPftDTJhfLTz9ME3kUc9aYtV/qr3H2PUgsC6JXdA8Cjzt6SkPSKH/U0/kRdP6DQFU0wgiO2fmXMItAmWoo49naTpaSbpSNdF1br+6Mgghjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900986; c=relaxed/simple;
	bh=qAlQBCHkVNdri2wsgGqTnCtud5aoTRwzthHd5ubpOBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpOVj8WPX2Ayed2v4SDvMr7KsLBASW/kHr/lvvftAxmVk53ZzNUBvo6UCXJj/SUca7HdtT/xWUmoRl/GpJv7lFnPjdAYcq+F3mls5Fx/XYBOwgmVwExuex/WAOfqMGgdz35pUj5f8r9BQE0CsV6Vq0IdBIBZTMIorjIYDvffKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ayE2oDV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de60f19a57so253751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758900983; x=1759505783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZSv7jCMIO3/8aLO/JxtF9r3uIns87B1XPQ7ZuJUAZ8=;
        b=1ayE2oDVoAz1WbmY91hoCMFJzIZ2MGVhpvx37HX45fht3XjgdMqugqXW8n5Znw/M6t
         LGzDAhmJgDKQitbvvpAL5hID7/MJRvZSEkE4kXmYwO5wUL81Uc8bRVMrtCcgJmKRpO1A
         Rn7a81RszR3Dwp2IGG1Azl+yb7wDQSBVMst28XqGOfa2qxl/750OZWmHlfu9McvYd1ir
         wyasBOpTIevuQV+0uqqDM3re7dwYBiqLxtpXdgy1N26FQ8kBCrZTyVvFV0Tj5NDoqeY2
         1DK4CvQ6JjULtzCNDkb5TESzNnexg/wOO/yzdlGYN6hwnAunjNQS4wsY1LAezxhoBaON
         bYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900983; x=1759505783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZSv7jCMIO3/8aLO/JxtF9r3uIns87B1XPQ7ZuJUAZ8=;
        b=jaFm6cW4EFOj0bL8BYlmO/6oj1no/Q/aHy5EjrxsgwJxle9NxDN8d9zki/Z8Nc2nis
         jUwjlq3VWGE3/SW9o4BBRvIyXeZH3o6IAOzXU/BSTLDIb6yuP1KSyqqgohA4B04FuxJn
         XTQ5rwAioEVpcg3xyDmTIN2FETh1H5Us534bkCJc7NAk3UUjCs8cCQUAoQm95rvlsIcH
         26MoOA4N3+zE7stxxpEIPWQtdeKXYFAUQrQQR/qezrceH36MkY91Z2Wz3eznvKQqnZxT
         JlXVAW7HGl+u3lDqMat+Bk3dTIxLX6X8opPqwWBfIqItJLqmd94jo2vSyyzauWwbWn+O
         7v9A==
X-Forwarded-Encrypted: i=1; AJvYcCUAXqzktqqc7v02T51QIQ4CBlONEuuRzOzlWoTmJPg+p62rc0W5X2mvxY7UbvELMdyPMuvt73A0/SXem8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3fZ3gqhJqMb++cEm0OhabYN9SXKmuPViVlpQ6FiGf7Zr8ole
	ZZWJxpjeOxOxXnZDMUUMz6IwaEON8B9O6Tn1O+BCz8p0eu49faEo5+Bu2gj5XAuzGDNmzyWM6sf
	8YhQDi2q3DYqfIX4UfcRE16SHkqkrI02VUva+rO37
X-Gm-Gg: ASbGncviQCCX2PqfT1CP343ABZKh774cDP7Owlv88bQg9Y2G4Fk0Ud5DNfccUpa651+
	VaeawNRvK20XHVcV5krgkmh6ccZC9IcvU21e1x5RHlFPP26EKsVRxa3K8edmgmRyHl23zCA5WY9
	0/bCJM8aUg5jmMdggEcwm7p12D4dhQ/1DM5SlmowKpgQJm+RxeB/aS8BNw3U+Ono/OKlpLFqQQX
	OXMFLCUVMsk3E8L8R9sahE=
X-Google-Smtp-Source: AGHT+IEI/jk3UcCkf9eM5O2gzijjqrX9cyj5UxKnCeRHeu/NPv0BxP2Itgt6Aa8b5z+x4oXG2jQMDdeupRKQ2GBDutE=
X-Received: by 2002:a05:622a:14c:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4dd1675a20amr6239261cf.2.1758900982412; Fri, 26 Sep 2025
 08:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926080659.741991-1-ranxiaokai627@163.com> <96d00a94-1a4b-4378-8d89-0554f89778e1@suse.cz>
In-Reply-To: <96d00a94-1a4b-4378-8d89-0554f89778e1@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 08:36:11 -0700
X-Gm-Features: AS18NWDFkKvKtLcxfc1dJhlxjz81QX6DLo5WA6zWZ5CPFfbG2tUlSc1PeLBvbDE
Message-ID: <CAJuCfpHhOohLKDkVKiY11tHnuKLr1C=ffVqUY3BpV+30kDZjgQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] alloc_tag: Fix boot failure due to NULL
 pointer dereference
To: Vlastimil Babka <vbabka@suse.cz>
Cc: ranxiaokai627@163.com, akpm@linux-foundation.org, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:48=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/26/25 10:06, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > There is a boot failure when both CONFIG_DEBUG_KMEMLEAK and
> > CONFIG_MEM_ALLOC_PROFILING are enabled.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > RIP: 0010:__alloc_tagging_slab_alloc_hook+0x181/0x2f0
> > Call Trace:
> >  kmem_cache_alloc_noprof+0x1c8/0x5c0
> >  __alloc_object+0x2f/0x290
> >  __create_object+0x22/0x80
> >  kmemleak_init+0x122/0x190
> >  mm_core_init+0xb6/0x160
> >  start_kernel+0x39f/0x920
> >  x86_64_start_reservations+0x18/0x30
> >  x86_64_start_kernel+0x104/0x120
> >  common_startup_64+0x12c/0x138
> >
> > In kmemleak, mem_pool_alloc() directly calls kmem_cache_alloc_noprof(),
> > as a result, the alloc_tag structure associated with object_cache is no=
t
> > defined neither initialized. So current->alloc_tag is NULL,
> > leading to a null pointer dereference.
>
> Agree with Harry. This should be enough:
>
> "as a result, current->alloc_tag is NULL, leading to a null pointer
> dereference."

Yes, that's much more clear.

>
> > Move the checks for SLAB_NO_OBJ_EXT, SLAB_NOLEAKTRACE, and
> > __GFP_NO_OBJ_EXT to the parent function __alloc_tagging_slab_alloc_hook=
()
> > to fix this.
> >
> > Also this distinguishes the SLAB_NOLEAKTRACE case between the actual me=
mory
> > allocation failures case, make CODETAG_FLAG_INACCURATE more accurate.

Awsome!

>
> Good point.
>
> > Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in=
 /proc/allocinfo output")
>
> That's in mm-stable so the fix should go there (probably too late to fold
> now) if it's to be in the merge window PR.
>
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks for the fix!

>
> > ---
> >  mm/slub.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 867a07260acf..09cbe580842c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2197,15 +2197,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s,=
 gfp_t flags, void *p)
> >  {
> >       struct slab *slab;
> >
> > -     if (!p)
> > -             return NULL;
> > -
> > -     if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> > -             return NULL;
> > -
> > -     if (flags & __GFP_NO_OBJ_EXT)
> > -             return NULL;
> > -
> >       slab =3D virt_to_slab(p);
> >       if (!slab_obj_exts(slab) &&
> >           alloc_slab_obj_exts(slab, s, flags, false)) {
> > @@ -2223,6 +2214,15 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cach=
e *s, void *object, gfp_t flags)
> >  {
> >       struct slabobj_ext *obj_exts;
> >
> > +     if (!object)
> > +             return;
> > +
> > +     if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> > +             return;
> > +
> > +     if (flags & __GFP_NO_OBJ_EXT)
> > +             return;
> > +
> >       obj_exts =3D prepare_slab_obj_exts_hook(s, flags, object);
> >       /*
> >        * Currently obj_exts is used only for allocation profiling.
>

