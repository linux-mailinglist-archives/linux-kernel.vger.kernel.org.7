Return-Path: <linux-kernel+bounces-819182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55871B59C92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F3E3B04F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31A3705A7;
	Tue, 16 Sep 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isX2h82H"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405625A2C6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037926; cv=none; b=HNKaJ41zxdToj84JK5TtkjGZg/fvJKL3NAolCuyNpconFZ04O7O5NsLgB0YBPMVeIjxMae4LUNajnRqRcLcqJPtt5E+471hKYJp89dfDXpzMQZvU/+I/f6rKt6HI4TBICtOwFfbqYb25jHaWO6jei7LLYsryw4oFNlaGS3HaHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037926; c=relaxed/simple;
	bh=nAry1h/Q3YXqvteB4iARFRxmZBjn+smO8M7Q60bmvCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VliOJ+u0p52zNj9J3tMj5XvVCXt6EhKvs3/xGqBXKGKfNWhiYVfwxjGMu9Eb1YnwGtW+7B0UsaSewX5Bew5S+99NsgMjBG02ZHiniSefFTzwHKEOTH6Fp5eozBnzIXuOvSiB7Lq1lcTduIoMmH1TQIKQShme2FTR1zL1eqsRUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isX2h82H; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso531191cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758037923; x=1758642723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+oASOLPx95oNqK0F5924YvyG+WYdsyr2luDMG22ugY=;
        b=isX2h82HnSE8GzdhByoOIHZRF4eHLHUhs2DKqykFbIS4pOXDe/cRZuHICEwqR4Yr//
         JfYb7tSjv7l+kUQL5/AIb/G/YbOYYcpXvuey4qmOFLmlFRfII0+iQTDh3653duGbdn3l
         peP0hHoJG4JK2uQvzImWmZK8wf2UjN07Ml4l8y0FKjqzAD6dxUFRExk3xHn7jLfj9c4L
         l+gzvnjhlVVE7v8mT/rgfuPJT9VcbUN9+Z7Gyu7TEaGUWZLxAmFONkiFaaFelS0vkp4l
         14RqgJ/4EMU7NWMZSDAk7D3XDwLUyjB1vCteNeEhx+VV/pL2vlPbRKvfuQsjoccTBdKF
         bF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037923; x=1758642723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+oASOLPx95oNqK0F5924YvyG+WYdsyr2luDMG22ugY=;
        b=DGputZMH5xVqiMviu4gwWWYTKhGnda3BRSU+wyKdRSDvkSGi8T1YgLsYyNNaBz/EPO
         M2sRxYBSeQy25tX2PZh/wACRadkPO6X8C5b1v5Od2/xhau/j0mSYSz++yNgIExP5StZ1
         Rv8GZZ3P7uczsbkyHM3XRmJ4sCaLmUdCAyStFkRFoZkwAKDUtX1jl9bp+2nlL6Z0FwGI
         NyOZNxi/ojW6/umi4OZuZ9i8wg493wUBqU8OedaLGG8FkowgdZ1nKluUZzTWLw0C7IRD
         3eFpalodISpjdRKY9ud/IXx5McBiIQydZRdrmkXZK4UWI73TemdWyrEAtNXVzsREKBFN
         nuhA==
X-Forwarded-Encrypted: i=1; AJvYcCUio7TAHv17scThHMAhrGjhZ4cWWNFCmsS12Qb7O1jANb38BJ7kivLt0xEtZlv1J9QHFfiZmKlnPeSoh3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycuqoza4+n0/EH13sM1EXh8mZDoQuPKC4NQWvrW4KBSFZJkxP4
	FsWWNaUs38B0jj58i1njvWQLOqZyD/O39twwgpl/8Trr1fz7K/qwM58xdl/V24e08MZMidqeSAS
	snTzPcCYj+0VpO7M+fV06HL+2yHmacIwxEtl7f1/5
X-Gm-Gg: ASbGncuY5Vy28x31eV2IMQAJlVXKRvzTmQRhQXfUHCeCeSlBoYO4K7dsQK/+5/6UUpC
	Qax+9dh3taYfU6sT6kaOGbXGe5oeHTaJaY37sycbLjOkbDiH3qcHy+KMFIJnJDXyDEZKnRZc7JR
	T5C1aHGfuMxzGax3FcSJ5DOoSXBJp+Vcy9W//Gzk/O0ch6kKbIfKMMaxSXIqiCp0M8XIvt2JmnJ
	ysQyP+DJ742K9+gx0QUsc2J0aOB02HD0jUGTHDnuyTm
X-Google-Smtp-Source: AGHT+IGQjGkUGRtAuf74uHX8AQBwF11GPpY2256/5dvWRpDeCbKTt5r9xOaAnclS0s+qrjOTODrM7eRbOWkwcSu0DaY=
X-Received: by 2002:a05:622a:1882:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4b7b1cc603emr7225521cf.8.1758037922864; Tue, 16 Sep 2025
 08:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
In-Reply-To: <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 08:51:51 -0700
X-Gm-Features: AS18NWA1aMQcro0nHI_awSa8XDDhwp0fYBTaz-bm5DsoeJH_N8UZACj67AWvxw0
Message-ID: <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/16/25 01:02, Suren Baghdasaryan wrote:
> > While rare, memory allocation profiling can contain inaccurate counters
> > if slab object extension vector allocation fails. That allocation might
> > succeed later but prior to that, slab allocations that would have used
> > that object extension vector will not be accounted for. To indicate
> > incorrect counters, "accurate:no" marker is appended to the call site
> > line in the /proc/allocinfo output.
> > Bump up /proc/allocinfo version to reflect the change in the file forma=
t
> > and update documentation.
> >
> > Example output with invalid counters:
> > allocinfo - version: 2.0
> >            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_=
data_nodes
> >            0        0 arch/x86/kernel/alternative.c:2090 func:alternati=
ves_smp_module_add
> >            0        0 arch/x86/kernel/alternative.c:127 func:__its_allo=
c accurate:no
> >            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_=
set
> >            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_re=
alloc
> >            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_en=
able_hybrid_capacity_scale
> >            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:=
init_amd_l3_attrs
> >        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_devi=
ce_create accurate:no
> >        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_ge=
n_pool_create
> >            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thres=
hold_create_device
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Usama Arif <usamaarif642@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> With this format you could instead print the accumulated size of allocati=
ons
> that could not allocate their objext (for the given tag). It should be th=
en
> an upper bound of the actual error, because obviously we cannot recognize
> moments where these allocations are freed - so we don't know for which ta=
g
> to decrement. Maybe it could be more useful output than the yes/no
> information, although of course require more storage in struct codetag, s=
o I
> don't know if it's worth it.

Yeah, I'm reluctant to add more fields to the codetag and increase the
overhead until we have a usecases. If that happens and with the new
format we can add something like error_size:<value> to indicate the
amount of the error.

>
> Maybe a global counter of sum size for all these missed objexts could be
> also maintained, and that wouldn't be an upper bound but an actual curren=
t
> error, that is if we can precisely determine that when freeing an object,=
 we
> don't have a tag to decrement because objext allocation had failed on it =
and
> thus that allocation had incremented this global error counter and it's
> correct to decrement it.

That's a good idea and should be doable without too much overhead. Thanks!
For the UAPI... I think for this case IOCTL would work and the use
scenario would be that the user sees the "accurate:no" mark and issues
ioctl command to retrieve this global counter value.
Usama, since you initiated this feature request, do you think such a
counter would be useful?

>
> > ---
> > Changes since v1[1]:
> > - Changed the marker from asterisk to accurate:no pair, per Andrew Mort=
on
> > - Documented /proc/allocinfo v2 format
> > - Update the changelog
> > - Added Acked-by from v2 since the functionality is the same,
> > per Shakeel Butt, Usama Arif and Johannes Weiner
> >
> > [1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@google.=
com/
> >
> >  Documentation/filesystems/proc.rst |  4 ++++
> >  include/linux/alloc_tag.h          | 12 ++++++++++++
> >  include/linux/codetag.h            |  5 ++++-
> >  lib/alloc_tag.c                    |  4 +++-
> >  mm/slub.c                          |  2 ++
> >  5 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 915a3e44bc12..1776a06571c2 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable mo=
dule) and the function calling
> >  the allocation. The number of bytes allocated and number of calls at e=
ach
> >  location are reported. The first line indicates the version of the fil=
e, the
> >  second line is the header listing fields in the file.
> > +If file version is 2.0 or higher then each line may contain additional
> > +<key>:<value> pairs representing extra information about the call site=
.
> > +For example if the counters are not accurate, the line will be appende=
d with
> > +"accurate:no" pair.
> >
> >  Example output.
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
> > index 79891528e7b6..12ff80bbbd22 100644
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
> > @@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, st=
ruct codetag *ct)
> >
> >       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> >       codetag_to_text(out, ct);
> > +     if (unlikely(alloc_tag_is_inaccurate(tag)))
> > +             seq_buf_printf(out, " accurate:no");
> >       seq_buf_putc(out, ' ');
> >       seq_buf_putc(out, '\n');
> >  }
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
>

