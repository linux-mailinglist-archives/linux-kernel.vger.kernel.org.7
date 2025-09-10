Return-Path: <linux-kernel+bounces-810442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F269FB51AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B105169E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D15352FFB;
	Wed, 10 Sep 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+u5+RcG"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A0338F4C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515850; cv=none; b=iHBGWvIv1/hagAHGro6NpKlS2JpuaZbm5TwOhIT9GYndR8opRcBeLtJQF/zvwwWr2WPe4KX5Ewvwq2yTa/iaecMw/s46ry6xdTXAqpy8nwBhkbpy6wt00GK5tAEmka/wliNokD72EUxZIB3gJh1eThsx0cUkK56l4ykHCVRvwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515850; c=relaxed/simple;
	bh=6amK2zDzJQoyni+FgRKZrCFl7Bf8LJ1vLMULa7OrGHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPrSmwhhBV/kLMJkQx8pyQgtnutULWA+3P3Zi8KCR1dHVYuObSj4PD9fg2gO2aQIclaJkTBvPndARDl5oBkgXW/7c8gdEGWpCSY5QRZYmaBLaF8nNA8xf8jXA8SHbPVwjD+o03LBBEVIJdsyKlTosBpS6rbY2LrmlJ66Mq6/E7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+u5+RcG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b350971a2eso145841cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757515847; x=1758120647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NYbNPMAmwuCrSGeuZHG4yC+dRkmjVH7KJw04/A85tY=;
        b=k+u5+RcG3Ky3uWy29dTukQY2CbUV8Hr788Vh+8saBR/shoZwSJhjmXMMiorM1uJtBR
         YSlVqjsRHHtPMkyh7qxXCKK6L0ONVYMJT9aSO3zKUoDALDyTNFut/dLOZZBGaUQIgfvr
         uLwUeiZk9xyWmI/9Bg6Vy1kB5QPny+OA7BMjbxNU6ATWl5iIgsAR2cogP9E2B79GymIp
         pH0faosp3KT5Pzw6+UprmWMAjeZA3qCoPIji3jFSjPeHH2q4dlaBT4hJIv++BkstSHzT
         m+f+r02dMuZrLyr5q7Bruwo93+V5Ec2B5KtKFPix4c8XW/70ea1ZUNvT7iwLsmxkJQfh
         mzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757515847; x=1758120647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NYbNPMAmwuCrSGeuZHG4yC+dRkmjVH7KJw04/A85tY=;
        b=B3mxZFNbssHx6YUQAqVZbrqPOBNhDslRHsP/qo5iOvjcKl70Z/4q1qxLUqLANJRLQ3
         N7ECBdLHAkaAy6HHomK0IQF+0j/q8EWiKAnOQ9R9tpe7T8fzKcn1+dL4XnN1mFzGPLP0
         pNm4Cudx7w25Xz2MGXakGDYYBNSXwrzkBUc3C9SwWqzYCiYTB/OD8dxNhGn7uxHYuRX3
         c2/Z7WVSnkRTGXYpP3l/0OonTpQBNvO660VtjQux6W37nwwDl85hFjhl34LkTafjZgoW
         VvzTpTsFp/97ORPHGElugqvD6bvyZti6IIHNMmwYsfQlduetlzukj8pKtKxbs/TRvVNN
         hk5A==
X-Forwarded-Encrypted: i=1; AJvYcCXzBCO9wZmKssYrGVi6CdiSFaWP+9LTeGENcutIz3jYZtVn11zboHyp0AXrKB3uBFKrtfs8c6JK46iWLVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgd3nSgSlW6OAI9OJ+8+U31LVJUgFUGN7HfskZU8CxYhJTm4Rw
	mY+XHn9wUfJriDUMK8H6clJffBDV6gIaT/0h9Ru4NQIyDzUkhzX/G4RgF8892tp3yyEq0hofUsX
	lHW0C8na2YR0iEedzXPltJF2YYQjABiPENlMINmaV
X-Gm-Gg: ASbGncs+zlIHERLaj7NblKk8LTwK0QP5qU9c2VQks+NSAa1MXRTDqCc7iVt2iLnicms
	VYCUxPzqXnWM8b32vU8xWDSy9LJARGmy4t8mPVuQpsZdbMvjAlyb8hBsWWctds1zjdVaZtmsH6A
	Id5cETyapN/StoRbzRZNcgU4kYVnTzwySFDR364c3FHUkteRP2wDnMy4HCDY+ftO6BQPf+a8JG5
	RVY4FeBZ2f1tpQuCwfGIidcV5TUy8IJhG2XiTxWj5ui3NGbJmgg4Q==
X-Google-Smtp-Source: AGHT+IFFqOWsPNmQquktqZ1ftZycysGTwGe1ZeTs0yi2D9K5qJeAhA84jkWLC1tZNBrc5ivvqPBodH5PnFD25ShGMuc=
X-Received: by 2002:a05:622a:2d4:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4b626da87a5mr4584991cf.1.1757515846235; Wed, 10 Sep 2025
 07:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <ff28f071-f448-4f25-bea0-17db946e0acf@suse.cz>
In-Reply-To: <ff28f071-f448-4f25-bea0-17db946e0acf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Sep 2025 07:50:35 -0700
X-Gm-Features: AS18NWC9mJuXsavWmAH7PEGfLW6cRsq8rLva9jLniFjBoy0_5OAKF6IjEcnNVRA
Message-ID: <CAJuCfpFf+D1C9esHXpR5WaJ_4=JmvZkYQMWY7KVYf42JLDTFZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:25=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/10/25 01:49, Suren Baghdasaryan wrote:
> > While rare, memory allocation profiling can contain inaccurate counters
> > if slab object extension vector allocation fails. That allocation might
> > succeed later but prior to that, slab allocations that would have used
> > that object extension vector will not be accounted for. To indicate
> > incorrect counters, mark them with an asterisk in the /proc/allocinfo
> > output.
> > Bump up /proc/allocinfo version to reflect change in the file format.
>
> Since it's rare, is it worth the trouble?

Apparently they are seen in Meta's fleet which instigated this thread:
https://lore.kernel.org/all/17fab2d6-5a74-4573-bcc3-b75951508f0a@gmail.com/

>
> > Example output with invalid counters:
> > allocinfo - version: 2.0
> >            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_=
data_nodes
> >            0        0 arch/x86/kernel/alternative.c:2090 func:alternati=
ves_smp_module_add
> >           0*       0* arch/x86/kernel/alternative.c:127 func:__its_allo=
c
> >            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_=
set
> >            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_re=
alloc
> >            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_en=
able_hybrid_capacity_scale
> >            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:=
init_amd_l3_attrs
> >       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_devi=
ce_create
> >        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_ge=
n_pool_create
> >            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thres=
hold_create_device
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Here a link might have been helpful :)

Right, here it is and suggestion is in the last paragraph:
https://lore.kernel.org/all/20250519160846.GA773385@cmpxchg.org/

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Patch is based on mm-new.
> >
> >  include/linux/alloc_tag.h | 12 ++++++++++++
> >  include/linux/codetag.h   |  5 ++++-
> >  lib/alloc_tag.c           |  7 +++++--
> >  mm/slub.c                 |  2 ++
> >  4 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 9ef2633e2c08..d40ac39bfbe8 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_ref=
 *ref, size_t bytes)
> >       ref->ct =3D NULL;
> >  }
> >
> > +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> > +{
> > +     tag->ct.flags |=3D CODETAG_FLAG_INACCURATE;
> > +}
> > +
> > +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> > +{
> > +     return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> > +}
> > +
> >  #define alloc_tag_record(p)  ((p) =3D current->alloc_tag)
> >
> >  #else /* CONFIG_MEM_ALLOC_PROFILING */
> > @@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(void=
) { return false; }
> >  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag,
> >                                size_t bytes) {}
> >  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)=
 {}
> > +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
> > +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { re=
turn false; }
> >  #define alloc_tag_record(p)  do {} while (0)
> >
> >  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index 457ed8fd3214..8ea2a5f7c98a 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -16,13 +16,16 @@ struct module;
> >  #define CODETAG_SECTION_START_PREFIX "__start_"
> >  #define CODETAG_SECTION_STOP_PREFIX  "__stop_"
> >
> > +/* codetag flags */
> > +#define CODETAG_FLAG_INACCURATE      (1 << 0)
> > +
> >  /*
> >   * An instance of this structure is created in a special ELF section a=
t every
> >   * code location being tagged.  At runtime, the special section is tre=
ated as
> >   * an array of these.
> >   */
> >  struct codetag {
> > -     unsigned int flags; /* used in later patches */
> > +     unsigned int flags;
> >       unsigned int lineno;
> >       const char *modname;
> >       const char *function;
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index e9b33848700a..a7f15117c759 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void *=
arg)
> >  static void print_allocinfo_header(struct seq_buf *buf)
> >  {
> >       /* Output format version, so we can change it. */
> > -     seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> > +     seq_buf_printf(buf, "allocinfo - version: 2.0\n");
> >       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
> >  }
> >
> > @@ -90,7 +90,10 @@ static void alloc_tag_to_text(struct seq_buf *out, s=
truct codetag *ct)
> >       struct alloc_tag_counters counter =3D alloc_tag_read(tag);
> >       s64 bytes =3D counter.bytes;
> >
> > -     seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> > +     if (unlikely(alloc_tag_is_inaccurate(tag)))
> > +             seq_buf_printf(out, "%11lli* %7llu* ", bytes, counter.cal=
ls);
> > +     else
> > +             seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls=
);
> >       codetag_to_text(out, ct);
> >       seq_buf_putc(out, ' ');
> >       seq_buf_putc(out, '\n');
> > diff --git a/mm/slub.c b/mm/slub.c
> > index af343ca570b5..9c04f29ee8de 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache=
 *s, void *object, gfp_t flags)
> >        */
> >       if (likely(obj_exts))
> >               alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size=
);
> > +     else
> > +             alloc_tag_set_inaccurate(current->alloc_tag);
> >  }
> >
> >  static inline void
> >
> > base-commit: f4e8f46973fe0c0f579944a37e96ba9efbe00cca
>

