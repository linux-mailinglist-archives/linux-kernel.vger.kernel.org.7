Return-Path: <linux-kernel+bounces-872834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5CC1223E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81CB18887BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698495227;
	Tue, 28 Oct 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HqHpw3Ne"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E1A92E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609833; cv=none; b=ihw4sTH9NdldtsG8xicXUm2l+RrXQnuRSqv6fd1AFZ1WEIGMvQYBGK7v40s1MzTSmSm23KRMpFaCyVXZEEe6K+dnyEznrMOBRlLs/5+JOvvicNIptM4J4KYrKcBl+nX41BMQFFdPtQ5iZJK2UWqZnQJG7Yhc+SXYcrbxpwm8hTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609833; c=relaxed/simple;
	bh=1jYIhckYsIG0396E3JQfz5P20qWqblZQBv8T5hjwnTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPi84NzTBbhbNErinSOmg4zGmNKXNtJ9LzAkkVOd2gN6Fsu0DIoNq/iHsiVdx8PLFOwSE/nFHsYbnGkWEdtz7RPNx1CWQnJGHZ4b3G5h5DYP+6QnF1o3+ATwpS3C11+5PrI40BQ2cGyxiLlb348JMiGQTnckg9gzaLL3wJJhiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HqHpw3Ne; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso9744927a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761609830; x=1762214630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIf9RmyxDj8h+YpH5/36r1Zq7AreK8JR3usDRLV8Ek4=;
        b=HqHpw3NelI2mCag9ovG6qv/Tch/ZpLZFtZ+rA0c2AE4Gy0MBYm6mIlyEJnPQX+/Xq+
         8Sej4sc6BgCBJ5okV6+ILBUd9wqlM6aDtUuZiAah5MHAdhLz0ap8xnxa1Ae5JGzhaFuH
         OkIQBDibHaiDm98C3cOf/dRezHZIRz5IY0D1aFRPswylD5QfysnZdc1qinRLeqQstvMQ
         Oywgff+g4QjL24B0GJQBfEMBJbZ1uqi9f4ecUDTdgIa3JYu4eqAIpcZDvyIQS/uV8swu
         loAZYA7FWwDN8PWptrALpYIhwlIOjeMad9NMK0FLQ+3CsWzVlf8h1A14xRPVYpzmtuaU
         22kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609830; x=1762214630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIf9RmyxDj8h+YpH5/36r1Zq7AreK8JR3usDRLV8Ek4=;
        b=Qyiug61MQlf0G0Yi9t6tuEwiboh8QcnRRUE+fMLJC2G+m6oCmtmiJuyPqErc5Ofcam
         FDI7EUYC+EkcSBdu1/xp1A8DFHw7DymxENXEmYQe4LUylG76UfFbKA4wV+2HnUnIEjxN
         zjUvwsKJG5WZSK9nKBRqz0UwLT30TGfR5Rffz9b5g0/cQ7cHTtZiUzpo5c3X/or0cr42
         KKzzZImvnIjqYaPCYTzkDtrWsPh/Z473mTrWrBrQ0STSUEAxKN2Jhy8QDArWm0Vm/3/i
         Vm8hRNaD/3UMSLP3eK6GW0wfkJNwAwm/ViuHtQyB05KYmYw3oH6tyQKZY9hHECOQg4UM
         IC+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9sECNOzKC/Zcp7fszQ5gG/OdtEV04nmBzgRGS7k3Uj24Ft4ILOSBLZi2Ze73j1jYt+oSAXHHYm5cYRUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4biz7lCTbbxv76rQ8PtApytonugnKahamqc+mZ738OW6xnR1p
	xueJo9nZfi9J8hR65Z4zwN/LoRT9CVTtxWzt3zDkzVYOMQdA4eQe/ygpsH5tkPkFJKS5strhElt
	Amp6eiKCcYMRst28IS4CDhC12RAC9YcoKUdpxuHgyow==
X-Gm-Gg: ASbGncvrfbLhgXic3+qQlGWFI23zFiUeg6Vymyz+ayFqHN50rudZCQndqVrfy4HYYwP
	LMVFWTYvNGzx2nt+qn8P/5IjhlzQxDmB6uQUkNRegqhcldzZmIwuBJ7uD0hWrxNtO4CUhJeekTZ
	ycDQS54DsdhbDkKTTpHI+c88gFaoVu1Hvjic3E8ENrHxxfMuiTv7mmblw80qyDT9ReXzXwc0vS8
	aO/3Cj0DmNPi2pOFd7nQqYfd6ZGst3uOQfP0VLB97GyzRAldU14hxpB6A==
X-Google-Smtp-Source: AGHT+IGRw73AgZE0pgL+h9bAcX5qxVKML+YkSwwVXL0+lNAI07sxHdi/1qytUtu817sC0wPtWFmC1YiZiNMsQzgmG+I=
X-Received: by 2002:a05:6402:4313:b0:639:dbe7:37b6 with SMTP id
 4fb4d7f45d1cf-63ed82669a3mr1767152a12.3.1761609830497; Mon, 27 Oct 2025
 17:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-3-pasha.tatashin@soleen.com> <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
 <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
In-Reply-To: <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 27 Oct 2025 20:03:13 -0400
X-Gm-Features: AWmQ_bmun6_TBMsODMO_7WW-_vSEWe2X4Vt2vU_u_Hwqc2ubbYZU9T3vQlpJuDM
Message-ID: <CA+CK2bAKjU8PmfuwGJwwOyj3U5bYaterE_KQa9uVu+mmmLmmew@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: David Matlack <dmatlack@google.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:02=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 27, 2025 at 3:56=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >
> > > -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index=
, size_t sz)
> > > +static void *xa_load_or_alloc(struct xarray *xa, unsigned long index=
)
> > >  {
> > >         void *res =3D xa_load(xa, index);
> > >
> > >         if (res)
> > >                 return res;
> > >
> > > -       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
> > > +       void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > >
> > >         if (!elm)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> > > +       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)=
))
> > >                 return ERR_PTR(-EINVAL);
> >
> > Reading xa_load_or_alloc() is a bit confusing now.
> >
> > It seems very generic (returns a void *) but now hard-codes a size
> > (PAGE_SIZE). You have to look at the caller to see it is allocating
> > for a struct kho_mem_phys_bits, and then at the definition of struct
> > kho_mem_phys_bits to see the static_assert() that this struct is
> > always PAGE_SIZE.
> >
> > I would either keep letting the caller passing in size (if you think
> > this code is going to be re-used) or just commit to making
> > xa_load_or_alloc() specific to kho_mem_phys_bits. e.g. Change the
> > return type to struct kho_mem_phys_bits * and use sizeof() instead of
> > PAGE_SIZE.
>
> I see that you replace kzalloc() with get_zeroed_page() in the next
> patch. So the latter option is probably better, and maybe move static
> assert down here and use BUILD_BUG_ON()? That way readers can easily
> see that we are allocating for struct kho_mem_phys_bits *and* that
> that struct is guaranteed to be PAGE_SIZE'd.

The size is verified at build time via:
+static_assert(sizeof(struct kho_mem_phys_bits) =3D=3D PAGE_SIZE);

