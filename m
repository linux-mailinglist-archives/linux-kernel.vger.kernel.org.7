Return-Path: <linux-kernel+bounces-872739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E7C11EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A27719A1A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9C30BBA0;
	Mon, 27 Oct 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiGOZ90G"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693825CC79
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605804; cv=none; b=JeruAQExvkO3Rsf6f/KevEAhWckgpuj1c9tKAIQNKtw8ILzIcD8V59CRIl59dtGaW5yuvVHIYvvokqMNp10YePAgZxvckBBuIstrA+sNG391sVPqB+4/RaEG1fQ0lhPu2TBGckgXGCZnTORMjyPTDfx1GXIeze2iL4rd4RWRcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605804; c=relaxed/simple;
	bh=QZjELBeTnN8q4ECeowSITrzrZA7EpcWKqPOa1fokjxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX46SbDlsZ9puF29VAsyJfigC2arp+44Ec7+nPnaPyRDrJw1buvm01RMjOVettBGvKlCHwaZJLv5dTRRkTBy8R5oikj6dINsbGnbak1huHzIeaim2+CDflC0rQWwCnynR4iTECIrUSl7KsPEsX1kL3CuRw2gcrvK8gvjJMLqBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiGOZ90G; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db308cddf0so5509648137.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761605802; x=1762210602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPeAjFqslzZO/jSSiFFpijfK5Ylwqu6hbia6gADtquA=;
        b=qiGOZ90GpEPlxbT1WnuOGq2Y+EVicNpZYA1l5dpkBeuWGGJ4WvaLsuPF9Bk8hi7D6q
         lNGXxMMQ83JLuBAFD28N4YXonHF6iDXlT76BXZPJCZnZqD1qEER8KPy2DQ+uXawm9TD4
         AjWSyUsFFbI8GG7rxA1V/PyV8lVAyxMopMwy2rQKEvDuYk/AsRdCKuwI2smsCKKjhpxq
         w+LodQyKmxpa2JgzrRXYfQuRlicx7/D44XDOzl5sUKldoR6pnvZenoSuqNTDH+sraPgL
         rtCY9zl7qLWnnXQMqGhDiBLmHkDgXJ9WGfRcg7EvYR7xOHpJfLt6WO8FymRo5Iyf4jiT
         08rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605802; x=1762210602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPeAjFqslzZO/jSSiFFpijfK5Ylwqu6hbia6gADtquA=;
        b=gT+vuLll3//DVHZys5gZAmgGSBe29K2Hw7hEz9ubcUQkfBDMsyi4Rv7+7Z2q65YfSD
         Spppd7hYqWXr1g79vC6PgBDuKIc9xTjnXu8+1TuZsUWM7oRaS29+8Y+VvZwaxfVlSqMj
         QVi904wlLwOLM+YtugTqCgB9vXUKz7/QuT9+isbrS8gvYm7O6vNRYiNxMe3D3C1n2Rv0
         QmYnuVsAXf01eqUtRo/SmtHr3JlHhqgRxH6uOxOCSz8MZkBi8Wwt3VqB/egBr/C3o8YI
         DxkksdYjHgsWV0O4RokvPi2tx8aBgfN6qGjuThFB5rc62H0POltGkRvp4dxsRaYF/095
         qyRg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAZjopsPfB8ZOfLuuS7KH31oY9+rSgbtUsIh+ex64/ZKGzfPJhm/RlJqKpucMmcR/ltZ9XD9BKPozerg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LBWWmmLwTJXfEwVkGVUIdDTFOBLbj+giHlEHh7a5iDcZsG8L
	w9m6tQAKQwgOM6GICYxEh/t7u7gN5P/M/mJ8iO2pC2LM8jPUH8qsDyZW6WvcTKr/C5IAxgk7Zgs
	pKh0RVBlzusqXTycFDN3tkuLe0pvoEYPqbDumoEbQ
X-Gm-Gg: ASbGncsStlujYeyuemzdo9cgtr6cvEbTprb+UNWbtdm4Wp52AQdzJUr2c+jInaF4xEI
	mj3plJB0WSnGQPkjq3KmwvgCijNRy3ZKtKM/Y5Ji/+rf8yHRwdfUHcfRR2Sf7CzndFI73Vxfvzi
	WL4wAboa2W2asJc71ivtjHPC7bhH8p0WWLe1MeMSANnayUNPwBKic45hyNE2CmiCxHF2Y3XAqUY
	05d1j1+3nUEynq9BmpeeswNvxUc9rpESDXbGJ5xEHNsErs8WeIAx+embrNy
X-Google-Smtp-Source: AGHT+IE3NFl5iYKq1PKDn7984d3rHdCJwN7ZaruqOg19O2RBjeN4yB6Xb2hcCCtJPpgY1XGOlB+vycOpSxjLw3zT+e0=
X-Received: by 2002:a05:6102:dca:b0:5ca:a978:8a with SMTP id
 ada2fe7eead31-5db7cbfa794mr691226137.33.1761605802055; Mon, 27 Oct 2025
 15:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-3-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-3-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 15:56:13 -0700
X-Gm-Features: AWmQ_bkdfG5WJtpo7e9nvseFiej50xxYP8fjah3qsHcyMXn4OpZPKxHD4gTCAdo
Message-ID: <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, si=
ze_t sz)
> +static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
>  {
>         void *res =3D xa_load(xa, index);
>
>         if (res)
>                 return res;
>
> -       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
> +       void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
>
>         if (!elm)
>                 return ERR_PTR(-ENOMEM);
>
> -       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> +       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
>                 return ERR_PTR(-EINVAL);

Reading xa_load_or_alloc() is a bit confusing now.

It seems very generic (returns a void *) but now hard-codes a size
(PAGE_SIZE). You have to look at the caller to see it is allocating
for a struct kho_mem_phys_bits, and then at the definition of struct
kho_mem_phys_bits to see the static_assert() that this struct is
always PAGE_SIZE.

I would either keep letting the caller passing in size (if you think
this code is going to be re-used) or just commit to making
xa_load_or_alloc() specific to kho_mem_phys_bits. e.g. Change the
return type to struct kho_mem_phys_bits * and use sizeof() instead of
PAGE_SIZE.

