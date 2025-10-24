Return-Path: <linux-kernel+bounces-867956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0EC0401D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99B6A356FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A61991C9;
	Fri, 24 Oct 2025 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoEYFrtX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB8E552
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268655; cv=none; b=JCmGOOBi0ZoBzRL1AMovkorweHb/VA96AO3CW0TU8yiKYW7yfhRcHxSTuOSn3gkPLf6LjdzziS+hVHD0ZFhPe+lwJ5acRlL9Fco2zL8yAwBvzbAgxgCy4y6w155ZzpC6uWiEW8VarT/gz7jgB4W5JCGZ1KRrRHTN+Wm/WiblKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268655; c=relaxed/simple;
	bh=a0eLVz5DdfDDVdslpuWUypLvHU9Cp6odGdhglIOpmKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX//CUBsP23Ej1MQcMonuh6UGj1chZ0XS7vetzkeIUML5ArfUn7IymGJEX3FdzkALgjAOK8iCBIJBgTaqueldMK89EQCSwCl1pCkrouwjnmmuHZFMta/16HzihAL7Wr+5EsLwTDfpaqEU9+OmXuRZVyzTzusXCGdzVZHVtXjD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoEYFrtX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427091cd4fdso878321f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761268651; x=1761873451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3zHmHY0wWNmA7YX6JIwCze7iW5GE1jfUcaWfSkBPyQ=;
        b=IoEYFrtXtydqk1UFsLMTIsJ7oh9T0vhZJNs1t/PHLFTVFmZPZzWOXtPhis8Tq80VMW
         eNOD7fyiOgrMtt0BaL+MX6hf0Tx/a7R1vpuOR3BqMLGwBSHv+h0AGZ5mS0YO6C0rR+gc
         ALzeVedfVpu1G2RnSCsKYG2lzL8UWKW2nZL1QvQSPd3+UDSqMfZa91y2YAM/eFTdHa+u
         S4GLV7Xz3Qf9Mx0LERMsXOsmEwp5Ux7c8xaECuRn+qxJIYLv6Ra+HIqXhjKLCLrbpSOt
         dow42P0H2BFU9lbLND1hqTxDC0i+Lt9LiB25zgUnKxh7jh6v+5X3rjsVj9r2Qlr25Keg
         yo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761268651; x=1761873451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3zHmHY0wWNmA7YX6JIwCze7iW5GE1jfUcaWfSkBPyQ=;
        b=rP2VwNJCBELuJPdthJUw1W8Bv341qEuDwv1fl6aGybjVL6aHJ8dogy3FmoazDKkN71
         oR4P49Oq4N0BioHsKOcZ0P7Gkw4my8Uwx/VHhMkcxVJuAE/jg7amGp9gcy+eXfBrnKNu
         vXXoOfgAHMaXCnjitunoLQUYTr6zs+zH1uXPJhr4lYVSLdWmZvnLsQY52Wmzj/KwYVH+
         1vMG0XlZl8ME7/XRUdg8dsqI6B7Dk2j5otrRPEpAXiy+ZHs33R8sNY/chyDnlh5NWsQg
         QKiIKchiGyEevnWDrfuQ4ZiBgcndM/kOaCtIFEZ2Onhc2hRiqNrmolenXuHAHztfdHaz
         wpmg==
X-Forwarded-Encrypted: i=1; AJvYcCXgYDi5K7D5lb4VzcuHKg4dQhuDwcsgPN63zPl6M5eJw6o4AtNiZ6G5qR3gukwvMv2mUnTDnFkFikpVsFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWaltuaFMVaoJMlSwCw5cXqV9Zs27wkydxn9OZc/36eGYxolg
	8NbrZ5x0aVhHX0myLYKQyKvDAtLC8ImjGVbQIkZ4VFe+HG552GcSLnPh2/XrVmVZUx4W4Yyimic
	KiCfE5di2T8VSLioz2QbRERB6uD8qStE=
X-Gm-Gg: ASbGncunBe3aj2LrRogBIV8ZvmeiDlcaqy7oLdomkVra4EMnByvv44Z8mvWWCXfFejZ
	VKvw3ipK+dIXO3U3TXqL47Mq7TGB130kXqGEtfo/i30pZswP84pwOBLysF5KrtIz88ysJXxemQD
	vnKW3G8j1nzhArfEm5R1jdEifyJ/uky0smnMmC8Z5u82DrIT+KgQGL9MGrZewFxyr/YslQznJ9+
	cne+Es6MALFEygnmXZM3qr4V05mbLB183wihV5mvvPwyzfZIuyKqWwRWMZme1mrV/5k/XIX2Ttd
	R5mMie8GT8Wzuj124CvThlo8KWVw
X-Google-Smtp-Source: AGHT+IEGRhrEDARsG6SwhCqQZ2ggjkKy6wrPhCyBYBN8Ml1axOYzO61kARTnkCoS/FIkzkx5bn85iTPh6XC8jpxUxTQ=
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id
 ffacd0b85a97d-42704d99f29mr17881918f8f.41.1761268650818; Thu, 23 Oct 2025
 18:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
 <CAADnVQJS_RUTnpCX5etS_qGD=jgHjtY_Mtc5GQqPwvyyTfghdg@mail.gmail.com> <aPrBp_vG_D-8qG_E@hyeyoo>
In-Reply-To: <aPrBp_vG_D-8qG_E@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 18:17:19 -0700
X-Gm-Features: AWmQ_bmNLJKrBBELDDyir78kpvEcRY3Ls9NHMGZzBjMo5Q5IjnMYV8X6iEIDoJE
Message-ID: <CAADnVQK+3GLbq4GjOYO0Q6vhURPyNyy70bZKUUwRpLuK-R8NAA@mail.gmail.com>
Subject: Re: [PATCH v2] slab: fix slab accounting imbalance due to defer_deactivate_slab()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:00=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Thu, Oct 23, 2025 at 04:13:37PM -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 23, 2025 at 5:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
> > > kfree_nolock().") there's a possibility in alloc_single_from_new_slab=
()
> > > that we discard the newly allocated slab if we can't spin and we fail=
 to
> > > trylock. As a result we don't perform inc_slabs_node() later in the
> > > function. Instead we perform a deferred deactivate_slab() which can
> > > either put the unacounted slab on partial list, or discard it
> > > immediately while performing dec_slabs_node(). Either way will cause =
an
> > > accounting imbalance.
> > >
> > > Fix this by not marking the slab as frozen, and using free_slab()
> > > instead of deactivate_slab() for non-frozen slabs in
> > > free_deferred_objects(). For CONFIG_SLUB_TINY, that's the only possib=
le
> > > case. By not using discard_slab() we avoid dec_slabs_node().
> > >
> > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolo=
ck().")
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > > Changes in v2:
> > > - Fix the problem differently. Harry pointed out that we can't move
> > >   inc_slabs_node() outside of list_lock protected regions as that wou=
ld
> > >   reintroduce issues fixed by commit c7323a5ad078
> > > - Link to v1: https://patch.msgid.link/20251022-fix-slab-accounting-v=
1-1-27870ec363ce@suse.cz
> > > ---
> > >  mm/slub.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 23d8f54e9486..87a1d2f9de0d 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3422,7 +3422,6 @@ static void *alloc_single_from_new_slab(struct =
kmem_cache *s, struct slab *slab,
> > >
> > >         if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags=
)) {
> > >                 /* Unlucky, discard newly allocated slab */
> > > -               slab->frozen =3D 1;
> > >                 defer_deactivate_slab(slab, NULL);
> > >                 return NULL;
> > >         }
> > > @@ -6471,9 +6470,12 @@ static void free_deferred_objects(struct irq_w=
ork *work)
> > >                 struct slab *slab =3D container_of(pos, struct slab, =
llnode);
> > >
> > >  #ifdef CONFIG_SLUB_TINY
> > > -               discard_slab(slab->slab_cache, slab);
> > > +               free_slab(slab->slab_cache, slab);
> > >  #else
> > > -               deactivate_slab(slab->slab_cache, slab, slab->flush_f=
reelist);
> > > +               if (slab->frozen)
> > > +                       deactivate_slab(slab->slab_cache, slab, slab-=
>flush_freelist);
> > > +               else
> > > +                       free_slab(slab->slab_cache, slab);
> >
> > A bit odd to use 'frozen' flag as such a signal.
> > I guess I'm worried that truly !frozen slab can come here
> > via ___slab_alloc() -> retry_load_slab: -> defer_deactivate_slab().
> > And things will be much worse than just accounting.
>
> But the cpu slab must have been frozen before it's attached to
> c->slab?

Is it?
the path is
c =3D slub_get_cpu_ptr(s->cpu_slab);
if (unlikely(c->slab)) {
   struct slab *flush_slab =3D c->slab;
   defer_deactivate_slab(flush_slab, ...);

I don't see why it would be frozen.

> > Maybe add
> >   inc_slabs_node(s, nid, slab->objects);
> > right before
> >   defer_deactivate_slab(slab, NULL);
> >   return NULL;
> >
> > I don't quite get why c7323a5ad078 is doing everything under n->list_lo=
ck.
> > It's been 3 years since.
>
> When n->nr_slabs is inconsistent, validate_slab_node() might report an
> error (false positive) when someone wrote '1' to
> /sys/kernel/slab/<cache name>/validate

Ok. I see it now. It's the actual number of elements in n->full
list needs to match n->nr_slabs.

But then how it's not broken already?
I see that
alloc_single_from_new_slab()
unconditionally does inc_slabs_node(), but
slab itself is added either to n->full or n->partial lists.
And validate_slab_node() should be complaining already.

Anyway, I'm not arguing. Just trying to understand.
If you think the fix is fine, then go ahead.

