Return-Path: <linux-kernel+bounces-746136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FFB1238E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A541C257B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924E2BDC21;
	Fri, 25 Jul 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZmifvIKf"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3948CFC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466968; cv=none; b=dVGKPQYSsU1z4DVtsChtIy312p9pCjTjx5MUWpZstIDNnEmxFA3D2+MRSaBxfs8VC1/7gwsWHz5QeQi3Et9GU0EyzOhtNKXKeIhkjTU1E+8PG38A+jSSpJyyPP9KpT9sT8pmiulqKcR87WT9cPjgjRI4iBfSAmxIc3E3JYxhRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466968; c=relaxed/simple;
	bh=8eZ6UfHUUoHbHh2mk6EixOYZeWzXgoiSxJYrI5U/f/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDsvVLpYvnVd9F9eJEitiZ5Fv4zXKm2KlIMtV2mHJ406+f+QVb9NJbuEmWyb3kzcktefcO4ViGDL23y8R3XbNS9QwwgRXFFtY4O8ReicDhOospoS6QjnnxlJAhjNsxiBlQb4HnRHnZCUASJT6jCp7h7J6KkR2WWU6UGd2XDfOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZmifvIKf; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-615c82604a6so51289eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753466966; x=1754071766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB5qtyVLlUSKDoN91u7sYSOkoySeFqXDvwHlEk1kptk=;
        b=ZmifvIKfV+0a+ZVu219l4CxYMF2K6r3UYVUR11ssVJVEOm3TfQsX7UrXLBawrQRs2M
         He1PYKIWW0pj+HYkEttrLY6Jw+LpXTkIvv9N4tGSVVwjle0DULqZTdpgJUErnClyX4kQ
         isfaPASknxT6M6jzIuvJk+Oo1PIskLi8H/WsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466966; x=1754071766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB5qtyVLlUSKDoN91u7sYSOkoySeFqXDvwHlEk1kptk=;
        b=C9P6aqWYR6iChivPwFK9vlyeO8X6REoVmMRVkHfTyztPpjlsxGAdd2712N/E1VG8Ci
         RjSK1xE6A5w2Q//3ttk8q66kEVZHYAOXGYTgmPN46OxV3oRa/6EWiLnz/E0vLb0lJw9O
         drMsztZ2+H2ZuLcEq6ViQQx1ddmNSezePeczgms3pn6QXh6K6ILG6RXHQApncpNpgH/O
         Q00mZud1zCM++lu8tYoLievlOMpVeQElAg3fBiZx26UQ6EBdzkIdHuiO4Yzod34KtG8C
         lDQ1lo2Kq1Mj4UyPVWye+XCulZRkhcSJyn/zUCiU1gr7Ytq7KbWPCDb3XkS3SfhpmIrk
         QuRw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRJToSjnCRNUQuUG4xe82arg+/UuQ5XCSTDAN2eE38sXOL+mO/O+OQhsCmgZ5CrlW4+zawPvYarmd8vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFJSR4NOlUT3O8FjIVQQBaT933AQXxghi761boOuS8WCB4zIN
	ftS2gqvTpxip9q/Ar8W7Z8uH4xnxBtB+7iXMWXkwGIXFYKfG/ddaJ40aZZgIdOTHwKjceM9bCCE
	FFevrvPMpZjHCAB8nXCbyO4MtBBi0v6Nc9UlT24Gh
X-Gm-Gg: ASbGncuyQbf0olUPIOSd9FB+gMZKIT7PXStDq8ocVitUUsZWy82G+67eb6pZ3cx+s9f
	3tOP4n6znbAL6N3XfIINN0Gf+fxlpgbg4JGpwu/IR6wM0hRrB64qpS/pi8Ht9DJphRFiBY0OVgZ
	FSFSJc3MFOr1ncwtyaCSyCc3FXOyu2DamIrV/kY3essqP3M2oQHwR7s7mE9/P9rwMeYh04kp7wH
	nkl0chk7+7Wg0RVEZOiGpCynnyHn+Ni9D1bqy2EMt7EzzWaQsb5xQ==
X-Google-Smtp-Source: AGHT+IEddEi6xdTXJgtiVapbZgFed98zIN2Pph7V9krQ13B7rmRyYRfak8z97schkfqohmFYUh9PuBDiB+EPcKoyGS4=
X-Received: by 2002:a05:6820:250d:b0:619:574:39aa with SMTP id
 006d021491bc7-6190c8f9259mr414821eaf.1.1753466965838; Fri, 25 Jul 2025
 11:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com> <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
In-Reply-To: <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 11:09:13 -0700
X-Gm-Features: Ac12FXzddZD9uWJjnpALakPffhHt86pE7Uh1fvLdscCaUcRVEp6tIBc4NLqA0YM
Message-ID: <CABi2SkVRmuRp459g0RBwyTbd5dACwe6AiHrpxYuPXj41MxHp+A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Fri, Jul 25, 2025 at 10:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Jul 25, 2025 at 10:30:08AM -0700, Jeff Xu wrote:
> > Hi Lorenzo,
> >
> > On Fri, Jul 25, 2025 at 1:30=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > The check_mm_seal() function is doing something general - checking wh=
ether
> > > a range contains only VMAs (or rather that it does NOT contain any
> > > unmapped regions).
> > >
> > > So rename this function to range_contains_unmapped().
> > >
> > Thanks for keeping the comments.
>
> You're welcome.
>
> >
> > In the prior version of this patch, I requested that we keep the
> > check_mm_seal()  and its comments. And this version keeps the comments
> > but removes the check_mm_seal() name.
>
> I didn't catch that being your request.
>
> >
> > As I said, check_mm_seal() with its comments is a contract for
> > entry-check for mseal().  My understanding is that you are going to
> > move range_contains_unmapped() to vma.c. When that happens, mseal()
> > will lose this entry-check contract.
>
> This is just bizarre.
>
> Code doesn't stop working if you put it in another function.
>
> And you're now reviewing me for stuff I haven't done? :P
>
> >
> > Contact is a great way to hide implementation details. Could you
> > please keep check_mm_seal() in mseal.c and create
> > range_contains_unmapped() in vma.c. Then you can refactor as needed.
>
> Wait what?
>
> OK maybe now I see what you mean, you want a function that just wraps
> range_contains_unmapped() with a comment explaining the 'contract'.
>
Yes. You can view it that way from an implementation point of view.

Contract mainly serves as a way to help design and abstract the code.

> range_contains_unmapped() enforces your required contract and the comment=
s
> make it extremely explicit, so this is not a reasonable request, sorry.

Technically, this contract belongs to mseal, but if you have strong
opinions on this, that's fine, as long as range_contains_unmapped()
doesn't accidentally remove those comments in the future, which I'm
sure you won't.

Acked-by: Jeff Xu <jeffxu@chromium.org>

Thanks and regards,
-Jeff

