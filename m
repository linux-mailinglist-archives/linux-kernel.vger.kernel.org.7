Return-Path: <linux-kernel+bounces-801262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2593B442CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AF43AB3FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAA232785;
	Thu,  4 Sep 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsKC4grD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A71F2C45
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003540; cv=none; b=DxYRuuktCF5HI0P5xT6Wg20vuk3IiNeEHyQwXpTlbBiUqdvOk2Qfrab/9imq8XKAiiJr6UmRdho5GvIIeGJnZ8jyECUMhznQsd4JIT4ShQirrf8JOUwc118tFfaJDOZmrCtULJJzpsUqww/MJO2sxl+UwF/ZF++Ktog0ePbabu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003540; c=relaxed/simple;
	bh=YhtUCG6/iB0uXlEUem9CfAZuRI7iHZvzqtoHxKI24jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNgTmxXrvORMOjqY+DJEod45NqAu9eZ710l83E3YFDlOwkRKCybwWYOTkEFfiSQa8uYdmEggckWfOLjcdnB7+1zUlWyC1FYcF1ed9guIqSpX8qK9kFvpZ2rPEjdJQXndwUbMeSwySXyrNiFN75sGnk3EuFiyS1i97T0PGxUD6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsKC4grD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b2337d1bfso2115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757003538; x=1757608338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvquhskjT65SmB2Nkm7CV4QXCHw4k05+VhhCF0jbgfg=;
        b=RsKC4grDinZm+kJ4OVeZ6Te5eNybPt4RZjiLE5hhFu8FdB3BD8vGSnkCfmdD/DcAZc
         m9OMBUf2JR/ArHwoSuDUmzJlPqJ0uZH8yT96Rk7hoKT4hW8iLvXEoejzPqiQSA821rjM
         rQCZ6lmJm5Y7aaQxV67i8HiYGpl/1V+YEqLhbO6xQv15tWlqAEZRYu7EWgptp7Jpk7gV
         AgTk7r4A18TjdN8dUENrOBPJo8V5xtTPSHwRAPDGgGf3aRzCuayMUER1meECNjeErHFz
         nq32Obq4vK9LOMlsPrWp8cIP46IciFgwOY79l2LBWNaThY/+77uXM1YXcUy1WKkmgiTH
         QAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003538; x=1757608338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvquhskjT65SmB2Nkm7CV4QXCHw4k05+VhhCF0jbgfg=;
        b=jBLoxR6mkrUwbwJLMuakW9lAS7R9wfni59oJCdwtM7jsvwxq5a1nbEHZl4V0hvHJ/e
         I1p/wAipwdufDUGiJhLmQH4BhbYMlGRUWQvZ1jZ8ZUH183bEtqrEFIvY3+UzNwHICYMS
         TOeyFVsj4mY/yUpVZsZf4C5RoRnpicFSjFq5nEYPz5V3rN5orfHiOMLksoPaDEbIPWLl
         MEP9UWH01GMhWXSh+JSUOZyVEZysdru0w5mUEWuYlv6hf6ZTffloulm892vCHxX8ypRs
         2hWeyDO0GnWvK/RDp2/CTZKu8uYFHcXDlUHP8teVwhxGXGmNX9+xgM0+rDoSOtPsUlDa
         3vIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUurGkxiAmv1g7GJl+QbYEKX5R0E0yoSqEkUnwiQRlH0N39J3lS4oAXvLPdsG9aExcurclm7ryKWRJ2GbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4e0+ft2OEsgrYDrjETJUYnLsi9a988mYGKaUsj47Tq3u1Fzo
	uedvVovmhPOHDi90280QwUxFralnj4crovZ8GgBZKrW/c+EgbBWCuta/qmwlazi4jKxUwSyYQrL
	BERnDW3P+sQzhtTr7bORUvaR7fiaWVM9FD23fG7GA
X-Gm-Gg: ASbGncuW5YuOVOWIdGFcd/OEjj3xKIExuwbOQ1UTh1ZfwH9darCiGmkArV8GtfFVbde
	1QdzwcVI87qDKbQoDHT2Yrg3tBbq6yyrn7EHSEWfT4HBIKzxSVvGilBFZERfApauCDFCP7rSZUD
	lHgu/RVIqhxZGHpe0AygxToI5m27I8NHj6HCRVN1nj4jxHp/wVPde32COMHJdG7HwnQzrR9/xEv
	Oei+UDbGclQX7hk/uXdFDa1aT/Fy3MQYmMkK2IMB/d9
X-Google-Smtp-Source: AGHT+IEeBGziaJB9oHadvh0/FzyqXNghHw3ReC+VBEqjlbAdsbeZ1QpzoqIvskMkWg8yzLp4wU/6HFBGcP7p0AcBS04=
X-Received: by 2002:a17:903:2f85:b0:24c:b69f:e4d2 with SMTP id
 d9443c01a7336-24cccbfbb0dmr2910515ad.1.1757003537673; Thu, 04 Sep 2025
 09:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
 <CAC_TJvd0SnHpEv0MSwXsF4UFpP0MNvRc033=JS1xTEHAOjQY5A@mail.gmail.com> <7eh332fqbhxak2afcwt6mwzaxu7s3dj2tx4hrtt7ivo3oxovcg@avz6uniwdzpi>
In-Reply-To: <7eh332fqbhxak2afcwt6mwzaxu7s3dj2tx4hrtt7ivo3oxovcg@avz6uniwdzpi>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 09:32:06 -0700
X-Gm-Features: Ac12FXyZMIliyHsJ8oJic4hRcBiiCKHL2ZYkSahpEJ8um3_mw6lFpjZ8RpCGqJs
Message-ID: <CAC_TJveTui6MPBGdB118VtL4pr69dtNt9LTe9J+cahHMdf75xw@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:25=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wro=
te:
>
> On Wed, Sep 03, 2025 at 08:01:50PM -0700, Kalesh Singh wrote:
> > On Wed, Sep 3, 2025 at 4:46=E2=80=AFPM Pedro Falcato <pfalcato@suse.de>=
 wrote:
> > >
> <snip>
> > > >
> > > >       /* Too many mappings? */
> > > > -     if (mm->map_count > sysctl_max_map_count)
> > > > +     if (exceeds_max_map_count(mm, 0))
> > > >               return -ENOMEM;
> > >
> > > If the brk example is incorrect, isn't this also wrong? /me is confus=
ed
> >
> > Ahh you are right, this will also go over by 1 once we return from
> > mmap_region(). I'll batch this with the do_brk_flags() fix.
> >
> > > >
> > > >       /*
> > > > @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapp=
ing(
> > > >  int sysctl_legacy_va_layout;
> > > >  #endif
> > > >
> > > > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_=
COUNT;
> > > > +
> > > > +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_=
vmas)
> > > > +{
> > > > +     if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)=
) {
> > > > +             pr_warn_ratelimited("%s (%d): Map count limit %u exce=
eded\n",
> > > > +                                 current->comm, current->pid,
> > > > +                                 sysctl_max_map_count);
> > >
> > > I'm not entirely sold on the map count warn, even if it's rate limite=
d. It
> > > sounds like something you can hit in nasty edge cases and nevertheles=
s flood
> > > your dmesg (more frustrating if you can't fix the damn program).
> >
> > I don't feel strongly about this, I can drop it in the next revision.
>
> FWIW, I don't feel strongly about it either, and I would not mind if ther=
e's a
> way to shut it up (cmdline, or even sysctl knob?). Let's see if anyone ha=
s a
> stronger opinion.
>
> >
> > >
> > > In any case, if we are to make the checks more strict, we should also=
 add
> > > asserts around the place. Though there's a little case in munmap() we=
 can indeed
> > > go over temporarily, on purpose.
> >
> > To confirm, do you mean we should WARN_ON() checks where map count is
> > being incremented?
>
> Yes, _possibly_ gated off by CONFIG_DEBUG_VM.
>
> >
> > >  Though there's a little case in munmap() we can indeed
> > >  go over temporarily, on purpose.
> >
> > For the 3 way split we need 1 additional VMA after munmap completed as
> > one of the 3 gets unmapped. The check is done in the caller beforehand
> > as __split_vma() explicitly doesn't check map_count. Though if we add
> > asserts we'll need a variant of vma_complete() or the like that
> > doesn't enforce the threshold.
>
> Right, it might get a little hairy, which is partly why I'm not super int=
o
> the idea. But definitely worth considering as a way to help prevent these
> sorts of problems in the future.

Let me take a stab at this to see how it turns out.

Thanks,
Kalesh

>
> --
> Pedro

