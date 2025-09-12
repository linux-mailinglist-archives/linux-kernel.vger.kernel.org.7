Return-Path: <linux-kernel+bounces-814741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEAB55806
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC63A7A25BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5E2C11DD;
	Fri, 12 Sep 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqFLv+Vp"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8B41C63
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711132; cv=none; b=KvqJ/WQto3Cegi45L4yJgns15h5x2fz3Dm4drPZyJnbx35yj9ML8hkKDO0ui900k44JHINJrrsGvUcd9dbb4YEKL8BcL0HeKHF4ZULp5s2wkDUiH5oz+kRzK2DObYct3i5gHZGAUAcVbdQLh+9T5LaBI1DpLtBbQmOVP37VEAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711132; c=relaxed/simple;
	bh=JYX5EldBPy0ZL4Zuzzinq9pqXW3Wh+8F35d8+PWqnLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fabzM5gyuvqhA1icx2gw049u05xJUgmHhxNIOZReaxcqYLxzyZcdooLVnRrEg9ZafR2DbuWzgFZS7yz+l/ISCvHc+QuGyy6YxIi8m72n4Ggmu/TZYvQdqM2ccPY1y12lJNJzWUp3gC1NeJSuuCz9wj2+hZYb4zIM9CHDoFQd3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqFLv+Vp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b350971a2eso11231cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757711130; x=1758315930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS6N8Phvjq9J+fDOffQfqEhS8X+tEPx7m7a32OEvstM=;
        b=wqFLv+Vp2IZXLwXVv6S0HyIBQ/fYnarPJevYqMImOctn8jVAUCm6OEwfD3JTbqi89m
         wYohexE9DeW/kD9uIDbjijh/Y6ZPXapYpuwQgoGhYq+7BdRaGkcN6TrMyGm3aC/RiU9C
         8T1D6HMdvwGhfh/8YnkF2eg3YyhvugYNUo4MmfuGTP6wfHmBY3MDvnQSPVCATlJ8jFIe
         Sa8CQSxG2dS+7QYe284HuaCSdCfxYa7yaymJfyNf0nmyaY+gJ8yXDzgIUvQiZayof0L7
         8AeE4+ldw2hi8iFNyPMH21LaZoZ9nUb7xhgleVSmtR6Y6JbBe0q+RevYLFLpU/EY2TQ/
         x7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711130; x=1758315930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS6N8Phvjq9J+fDOffQfqEhS8X+tEPx7m7a32OEvstM=;
        b=rZ4sPeB0qOZ3KgKJOJf7OKExCUO/LmyW5i7H2JlzZG3nS134v/4YRGnJOJlf3lfQ5j
         SC/wW5c3rVk+FI+GHSh/uSyaoayYLglsrN2KPV9yqYOtkg3zRSpCyuWIFEqa5ugrQ0Vz
         /fZ4nqDbDj9xLfto1bT8XJY2QtOP/NJ1He0evIDzuiN5z3iDN10FHj/+wUOH4qAB+fdC
         I8mnS/nSARcrGCS6QXsYKdJaSocbn7ReRLTavem5LFtP9xoJWKD7gx786b9k/UDbzZF5
         lqKo6rCpVUUGY54S9TGO8bDbsi6H+C2W8zvxVQM0m9bYXeegNeK8s23k4G1BOzPv/3S2
         RUGg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTlnKKTXfkKs/E4/Rh2jrpxtSRuZyqzakgNhWT2RuAdpZtJ1zAllnpV8hHZLuyung2q0kwoPlfGJ1l8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uiTbt7ieeilIijw3YyIqUZxIqa5VIPoxwM537n3Y+CO2E7/T
	YZH7CC4Vb2Ri/ND2dBAnLKIRMqQVijFYsF1CBlhtH2tDP1JwiWSStoRPKR33qGIv3sMevrvwcqa
	sVkWF/oXVOCetZMfd9WOR8El9zIOehF9nm7rDnirw
X-Gm-Gg: ASbGnctJjNzzEkj+2MN5apKie69DhBsDpV5zMhfWy3xUKd80rdMftR0MfI9qQ6sgMnp
	INKq2uyoRQ7uFSCqFBEIuC0bWlILoHg7UEIzLNcbK+nurQRG3qstiqZExyYN1evIXKjk3jYelUQ
	t3HVLTOsA4eA3fVn83RGBxurkbbvTkU4oM6nQuyiTPWH6d+baWtnKkGTkcodb9qZxwWRfnQkRNW
	qxVaJRT2P5uxFgvGd+paZ4=
X-Google-Smtp-Source: AGHT+IHb2K2xXlIpqcAzf1xMj6i87zxQ9C/c1C073ZrqSL1hu65ba+HrjVU/5m45uOUXUsbx8ELp9JxVxwF+qaMRAJs=
X-Received: by 2002:ac8:5910:0:b0:4b3:487e:741b with SMTP id
 d75a77b69052e-4b78c6df940mr338881cf.4.1757711129577; Fri, 12 Sep 2025
 14:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com> <20250909233409.1013367-2-surenb@google.com>
 <c2efc885-8b23-4ef9-8eca-05f17e158fb3@gmail.com>
In-Reply-To: <c2efc885-8b23-4ef9-8eca-05f17e158fb3@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Sep 2025 14:05:18 -0700
X-Gm-Features: AS18NWCOujUdYpmOTJkjMpH1lwHsOYcF8mubnSwHOTjZmB4XICE1Z6kVVsS-ZQ4
Message-ID: <CAJuCfpHf6shxs0A1dmRuYjjU-wU8p=tFD3BO43DTYbZ0U=rFMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] alloc_tag: use release_pages() in the cleanup path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:49=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 10/09/2025 00:34, Suren Baghdasaryan wrote:
> > When bulk-freeing an array of pages use release_pages() instead of free=
ing
> > them page-by-page:
> >
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  lib/alloc_tag.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
>
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index e9b33848700a..95688c4cba7a 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -438,9 +438,10 @@ static int vm_module_tags_populate(void)
> >               if (nr < more_pages ||
> >                   vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHI=
FT), PAGE_KERNEL,
> >                                    next_page, PAGE_SHIFT) < 0) {
> > +                     release_pages_arg arg =3D { .pages =3D next_page =
};
> > +
> >                       /* Clean up and error out */
> > -                     for (int i =3D 0; i < nr; i++)
> > -                             __free_page(next_page[i]);
> > +                     release_pages(arg, nr);
> >                       return -ENOMEM;
> >               }
> >
>
> Maybe this can be done in free_mod_tags_mem as well?

Good point. I think I will respin this patchset with your suggestions
and will include one more fix for an issue that Shakeel just reported
(see https://lore.kernel.org/all/CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE=
8pG0K1uXA@mail.gmail.com/).
Thanks!
Suren.

