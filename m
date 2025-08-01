Return-Path: <linux-kernel+bounces-753590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424EB184FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD717AAFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1822741BC;
	Fri,  1 Aug 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhUwJaMD"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F51B7F4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062260; cv=none; b=e1HlH+cTKBu6dJ3t0OgLEmDgE14IuMSWlX7ZQbqN2xL8A/O9WjjH8w4ipxoSe5tJk141/ow+n1vy9oCrsdXkJIzTi71cCSttWfX4lR6mjq3L4dyad5szOxniZO+bbZv5Q/9N3aElnW8oV7AYSWzj6ySVvEu0xAKdTxbRF/+h76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062260; c=relaxed/simple;
	bh=rlDK9hsGdlPtOD6/q8hfTJsFwoCL3v42DRpy5geh1H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpN7VdCYqNQkJU2sxIrt4zQSCBFeRFbrx6LmLPFg0Ph9NknkZKFUknEOZ63pQpicz5tKrkkiGl9Dnxn6wYTfO2L6SBsv456vwHzN2bV54CenLZFbok9TlJMirw0Ksr5fY2WVZRsQfsLzRQpc1sptmqmFqpPlOV0KFo+GRZeqDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhUwJaMD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso480341cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062258; x=1754667058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWjkM6aVGbDaelGi0ZenR2loBam6dBRshOdGKAXlyS8=;
        b=RhUwJaMDZPlwqqoIkHytciegouwcIuwM/ouG86KqyIVy459b48E6tGFYLhmRUxKmQx
         EQ7pCgNHv2fhYYO5BugICdeog5BDBkqn+nliSGMja5XEx0Wrl9RfxbHJJfNLHG5sDMvS
         k4qGcnZBcGCOoZ8ueh0FczcweuP0j/tVwzo7DxNQfcF/9iQQLn9/VrQ5m+woGOirjQCN
         aSIVarPYDAMChdAjgMO30oCV9xqCnF9I9sfi9TKcGuMtwbYsHWNN+W2orsV4ZaQoESvz
         iUOztmPNMU++xdxXpyKURqnzCmTQTd+x0b8ER76fPpnRgeLQgnWIr96x2+ybhURsXwiX
         gn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062258; x=1754667058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWjkM6aVGbDaelGi0ZenR2loBam6dBRshOdGKAXlyS8=;
        b=IEEywztAfj4N3g+ny7H5CKWUP6XDwXXlujzgWSgsIZ6oBYD8/4O31Qqv1Lyp2MW8wN
         HnEgBmVgQ7i4ZGFhmK7XCr8oZN7z3lUldpoCY+mUjOsaokN8pO2sIVSE6HaZxutFX1+y
         10BKUzvlFKIrq1TuuNcszmmK2D/xwPzXlKYWNHgfHV/XB5L743ACUwdT9e0omLoPTMN1
         VMywRcp7Kvl+0BsWE7erFcElGMoFefwCRizlN5siW8rN8eOQlv+qlIyrQOnH7rtwzt6l
         mCkEsuinSaiCARUB3wgWPiIkBKfmYzlq2yEJiMMOutmUpOB6QTLhLdysciY/uG62EzO7
         O87w==
X-Forwarded-Encrypted: i=1; AJvYcCX11r5W+Tdual0nqZlwtniNcXX67qFg+x+YrPaBMIA+SDFCflXB5IUZIoIAjg6LFt28U1DRISvF074ivKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv21hZOeE0mnpoeUWOav43mA/KzxM15dpjBGmckHv8xuJHnptp
	aIh1VAwSMlYPAlK83DFSuJQoZloAD56GiLiyIfSY+WRwLt/XtFW/sWigTVQ1sbI01GCYI3qoSqb
	Chx+nmQ2DDaa4PhwPWop4XII00qN92rF1WLQgbP9/
X-Gm-Gg: ASbGnctX/+krtm0vE6XCDMlpYW5Ha7gRye4+dlciCglqexZSC/T6Auwjqn6yzdQuZC1
	QkxgEPUS90EZ5g9HC6ljPAPPWCrnj7yh6BizLQ94FyDnWZ8khcjn8kmrIrT250RoFJov+/oQquE
	JK8wowyzfGFeYPXBxb0oYUaZaNTqYj+Y5ulexJeaTPjsjQglDp8KBybhWi9V4uuqppJ4JoUwyNP
	p0AbCGH/kE1RgiHp4rU+TouO4aUYVAR+W+Jgw==
X-Google-Smtp-Source: AGHT+IFP6oWJuEB+t8FqlHu4nrpKTJN8ggoRVw1wyBCG9QSsTFoeUzkMrBL9SWqFRe5Hi7JIvL+AIijCHTWQWxdq+8E=
X-Received: by 2002:a05:622a:93:b0:4a9:e34a:58a1 with SMTP id
 d75a77b69052e-4af0088e8c4mr4626841cf.21.1754062257422; Fri, 01 Aug 2025
 08:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731151919.212829-1-surenb@google.com> <20250731151919.212829-2-surenb@google.com>
 <a58759b9-2847-4ffc-914b-c96336385c81@suse.cz>
In-Reply-To: <a58759b9-2847-4ffc-914b-c96336385c81@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:30:45 -0700
X-Gm-Features: Ac12FXydoPHt9DYmIUpoqeSH4RwHYO1K7tIS4LC4But0n7b4ZrC_qkGPggvaHZo
Message-ID: <CAJuCfpHsdU5e7+f29ezDXus5-W7jT580YCY0LpErTfKJjeo8zQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: change vma_start_read() to drop RCU lock on failure
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/31/25 17:19, Suren Baghdasaryan wrote:
> > vma_start_read() can drop and reacquire RCU lock in certain failure
> > cases. It's not apparent that the RCU session started by the caller of
> > this function might be interrupted when vma_start_read() fails to lock
> > the vma. This might become a source of subtle bugs and to prevent that
> > we change the locking rules for vma_start_read() to drop RCU read lock
> > upon failure. This way it's more obvious that RCU-protected objects are
> > unsafe after vma locking fails.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>
> IIRC you considered it yourself, I just convinced you to try :)
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I thought we didn't need the drop rcu lock for -EAGAIN, but that would ju=
st
> made it more complex for little gain, so this looks good to me.

Yes, we technically don't but this way it's simpler to explain (drop
RCU on any failure).

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit:
>
> > @@ -223,11 +227,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >       MA_STATE(mas, &mm->mm_mt, address, address);
> >       struct vm_area_struct *vma;
> >
> > -     rcu_read_lock();
> >  retry:
> > +     rcu_read_lock();
> >       vma =3D mas_walk(&mas);
> > -     if (!vma)
> > +     if (!vma) {
> > +             rcu_read_unlock();
> >               goto inval;
> > +     }
> >
> >       vma =3D vma_start_read(mm, vma);
> >       if (IS_ERR_OR_NULL(vma)) {
> > @@ -241,6 +247,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >               /* Failed to lock the VMA */
> >               goto inval;
> >       }
> > +
> > +     rcu_read_unlock();
>
> Would it make sense to put this under the comment below?
>
> > +
> >       /*
> >        * At this point, we have a stable reference to a VMA: The VMA is
> >        * locked and we know it hasn't already been isolated.
>
> Give it continues like this:
>
>          * From here on, we can access the VMA without worrying about whi=
ch
>
>          * fields are accessible for RCU readers.

Yep, will change.
Thanks!

>
> > @@ -249,16 +258,14 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >        */
> >
> >       /* Check if the vma we locked is the right one. */
> > -     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> > -             goto inval_end_read;
> > +     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
) {
> > +             vma_end_read(vma);
> > +             goto inval;
> > +     }
> >
> > -     rcu_read_unlock();
> >       return vma;
> >
> > -inval_end_read:
> > -     vma_end_read(vma);
> >  inval:
> > -     rcu_read_unlock();
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }

