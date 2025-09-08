Return-Path: <linux-kernel+bounces-805049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBCAB48377
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEA654E1528
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E4221F03;
	Mon,  8 Sep 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VF5FLcDO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760491C54A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307402; cv=none; b=rWvhjhntR0XStXKBJU1SdmgGnOilrH2c1ogOwH3V1iWzX9leg8Cs8zOpP1C3Aza5PhPrQsxXc3cjSart2QA/M+V3i0A32MJf7WD1jv6ME/6YxUgkV2H36kiR51ZQjSfXvuCiE6ohUvzmWy+ktmiLqH0WnliqZHSWJzhJr2dtUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307402; c=relaxed/simple;
	bh=G790SWKrMS2Spa5lQ//0xp8+Nr4ojk2QTeGItf6Z/ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNqBemALZnZ6IREOibrgNYOyOTjp5AIIdbxqws9l37M0Ks8aFY7t37eM5Q7wEGOAnP13AiqdOTwtBAOViRju7YvshdXWtczuiwur3YEyKbATJwNF++Gm3F9B84Efgv9lsE/Ghd2dM3nGDPH+GHKxTjW+S0bj2VPtHUyqPMPZ2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VF5FLcDO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-621c6ae39b5so10901a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757307399; x=1757912199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G790SWKrMS2Spa5lQ//0xp8+Nr4ojk2QTeGItf6Z/ZI=;
        b=VF5FLcDOG3KkJvHXl7p7VehFjWOhTLCua1K2jvb/m4oZuobJqOMJPWyLQ7cV1958NL
         yjZroA5zWPYNtecvYToE7xj1kLyyZ9aEOzDynyglmtwGb8pnvQ0EZEdJc384oF1v0DkI
         a2/gfG9pLMuhpE4kLV6Kq80Haf4KUWxO6lTR0xwqYFVQMGPA7Lw9l2iGmF0ltwDctGQU
         QFdWUCIBGHrCwIXX5GK3V5aldkuN6BJMF8SXnjcPLAKprm1WoVbTmqdy2ObLhd4VmxBM
         ymbk0iGJrGSwEOHv9oRVNnea0b8Y84wo55nEwCIT9nUqQ/f8ACrz3eiRUN8AE6J/DhYq
         SJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757307399; x=1757912199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G790SWKrMS2Spa5lQ//0xp8+Nr4ojk2QTeGItf6Z/ZI=;
        b=ieIYVECHuy91CkyPuF/bM7Sm/+JyU9H8ybJvKBjZuj2K4EPv7ygUF5W4M0PYeojTKI
         h7o0iX1RewXAIinQb5FkxFrSmihWONNoXMba4kG/GwQaGtj+9UJkhzn637RWsp7+56TN
         IOZSnjkTMPkivMvyYqFlRllx/KWr7VgqBv/sSEOu46JXHEl91MDz3QffHFDtMtbml2x3
         zgwO2S8nHqD8EX76Ih09J74rKVPOtHU+BIaZAYqUWZmsqWfh0nNUu2RNWPYcnZzIGzsB
         keyOBZ608zqzGrdvFHRS5Ca3WcA5bdlBcB/YADE5fda9A/xciKBcwNGW4rP3IVUAHynA
         DH8w==
X-Forwarded-Encrypted: i=1; AJvYcCWa+DfrGf8adWqUlkRFMypk7Y1kGFeC/ev9TDvD5MI96WwToq8S8s0Cu6hpMwWT4QMw05d6PSXql6rxyNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZKHqUWe5VpnsQnXzWywLbA2JdeAuK5yLQz4odS008sQrfxCJ
	8hR/AcT0U54VTmCHnMI2P+QTZ0lcrLrpTLnqwob2lw2VVLtMjaStKPboIe62O/yqqW/mRVWJNo8
	HJwwNIXam1fFtxuwkK/zX7FS394WQX1AFPGrlJsNP
X-Gm-Gg: ASbGncu1ZSIiAOyhX+aMlt6qtrvPxDtlLc3nYLTlSBjpsrRyRxUZaef+33sh3LIJAGJ
	hLECvH2/+6fqcPaniqY8mmbnHiQL/L4woEtcZmHlc1DemwGLdvSRMI4Uu9hUtls0MsnVjDyna35
	bwoAAHxY/bvBq4EGwpuL+0N6+OEuJ4e7R4oX/G/B5sgh87HmjbrqLCWzU8u2FVJjyzfjD+yafVB
	3rgRzlh3Wt2LVjqStDD559917561ubC43/jQ3Lk/HOVReXMEnb0c9twPA==
X-Google-Smtp-Source: AGHT+IEfZcQKWymUsTqqOHgiy81N82VSvnJqKcYZvNDzmsCtUqE3l9TNTQbgDZ9aaqLldDgztdzRQMKqVYJRylhPQfU=
X-Received: by 2002:a05:6402:2346:b0:61c:b5f0:7ddb with SMTP id
 4fb4d7f45d1cf-6235d1a4bb2mr2464a12.6.1757307398564; Sun, 07 Sep 2025 21:56:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com> <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
 <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
 <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com> <e6b12ef9-1808-45a3-9d64-5c7fd1904b5b@lucifer.local>
 <CA+EESO5FnraOUV=CzcD6t_e086pC7rDZuVv4w2ng==7KacA=Pg@mail.gmail.com>
 <d61b173f-ed58-4d60-b1a1-b93678371576@redhat.com> <CA+EESO42EqQps7C7P1HfMJ07ioRnkktKGXO42VU0fHT_1xvC8A@mail.gmail.com>
In-Reply-To: <CA+EESO42EqQps7C7P1HfMJ07ioRnkktKGXO42VU0fHT_1xvC8A@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sun, 7 Sep 2025 21:56:26 -0700
X-Gm-Features: Ac12FXz21g3aZY8pBxInKDKKJwg-ZQSv234aSGthQCUMDFh06_0DIrztZfN_DM8
Message-ID: <CA+EESO4iBZu0qcqWrSP166OYRp1Mqr2i0Z5ei1sjd1g6+bT6Ow@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:04=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Tue, Sep 2, 2025 at 12:01=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 02.09.25 20:59, Lokesh Gidra wrote:
> > > On Fri, Aug 29, 2025 at 2:04=E2=80=AFAM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > >>
> > >> On Fri, Aug 29, 2025 at 10:42:45AM +0200, David Hildenbrand wrote:
> > >>>>>
> > >>>>> I do wonder if we can identify this case and handle things differ=
ently.
> > >>>>>
> > >>>>> Perhaps even saying 'try and get the rmap lock, but if there's "t=
oo much"
> > >>>>> contention, grab the folio lock.
> > >>>>
> > >>>> Can you please elaborate what you mean? Where do you mean we can
> > >>>> possibly do something like this?
> > >>>>
> > >>>> UFFD move only works on PageAnonExclusive folios. So, would it hel=
p
> > >>>> (in terms of avoiding contention) if we were to change the conditi=
on:
> > >>>
> > >>> I think we shouldn't be using PAE here. Once could consider using
> > >>> folio_maybe_mapped_shared(), and assume contention on the folio loc=
k if it
> > >>> is maybe mapped shared.
> > >>
> > >> Interesting!
> > >>
> > >>>
> > >>> But the real question is with whom we would be contending for the f=
olio
> > >>> lock.
> > >>>
> > >>> Is it really other processes mapping that folio? I'm not so sure.
> > >>
> > >> Yeah, I might go off and do some research myself on this, actually. =
Nail down
> > >> wehre this might actually happen.
> > >>
> > >> Generally I'm softening on this and maybe we're good with the propos=
ed change.
> > >>
> > >> But still want to be super careful here... :)
> > >>
> > > Anxiously waiting for your assessment. Fingers crossed :)
> >
> > I'd suggest you prepare an RFC patch where you neatly summarize all we
> > learned so far. :)
> >
Sent the patches:
https://lore.kernel.org/all/20250908044950.311548-1-lokeshgidra@google.com/

> Sounds good. Will do. Thanks.
> > --
> > Cheers
> >
> > David / dhildenb
> >

