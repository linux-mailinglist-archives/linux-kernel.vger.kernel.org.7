Return-Path: <linux-kernel+bounces-811699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD3B52CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A53A1170
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB382E7F3F;
	Thu, 11 Sep 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JHGqwgl"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF72E888C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581798; cv=none; b=IGSj4AfhyQkgpgD8HYNvBgOiK9olc5uv3ZM72m5DvYaNzSWl7R34Ce0Xq9IGsq/E4z1eWrXvJUaDQOmKnfA6+vjPi8BgaK9mwIPdn59lz74MjTD4ctmdEJqcNttssaxYgp0BXjbsyvM8JRnC/wSeBwXiXM+GZDGhFu69Rq2PCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581798; c=relaxed/simple;
	bh=dcE0SznU9PyCabtb+Z2XmvyG0XBdfDSeKArLLjJbTDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bii0fuaT8WPBXILP09DAj0hhk861vYEhXCgyrP0BLbIX3SK3gHMKJEtxL29KhujeCJ+dFSVus6yjAzaiwhVokprY4yqNQLVDTvMu+znY5EZHRrzRe05OTdB1DGHM514Ar6to6zcMFqjB4DV2d1knsCooDEU/WhnGCTul16BxMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3JHGqwgl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-75512f5a75cso4253206d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757581796; x=1758186596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=110hIxZl/DIKAtkNXDUZdekwbiGKdHIJpSsuT6OGVlM=;
        b=3JHGqwglbARDdmktvjjOaElzPmFC9qrBnyeBo+y+X/182Cwg46n9lLm3t4hZcYYLnf
         ykSx6ABN2t5X8ze5j30wdg9VcrVzigYQ4+twy0FzWkK09gyfMpWYfebVFhtOGVOsCV6c
         JMW2v8j4o4NaPP1uyKSoixsOzVvjkPrZFcgKtKKHcNSA181PD0FYDXF5FKX9f01jFeLm
         efPXTaq66bimw33larVkEEXA6RqQMsPnZ1WMC0CvEIyAJsr5nJ43qeG/i7W5CzACP277
         janPKaBcqrEf42iveJJsu3mMMi0d6W7STqg+kxoXJfCkgjMcIfGC9R5+Nk/+i6PY5Frw
         D09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581796; x=1758186596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=110hIxZl/DIKAtkNXDUZdekwbiGKdHIJpSsuT6OGVlM=;
        b=kmkqtNdW2MMEsniafIhvKdaVBwTt21VJ6od6dEUQxlfhKhPtwiDKg9RxAyj4TXA4dZ
         o8dOB9WrZeRdGJsZfiD01EQ2A4mA6rU8ayV5Mt8ScPcBOwjnJI9gfvbhBnRCIwojR9yX
         KFfpIVeYTv3V4YywybNuoFH/DX5QDCaoSqm11JIuHLa/pndXcqckxxe8Ht12wACZV/TE
         p3Mwd3utb88Sxs2FdWoSqzT3RpYjzsbyjawaVrmQWg9WwJNjHArb++wy74AzlTf7TgLg
         zZEfVArWtUSvOA4j3HZY6NdnbVUZQ3YNrsrnUm2Sj5HZRba9gQeJkuK/ZmRcWaWe3VYg
         HjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWv8UMTbopOcji95JU7k16QEnt+0w9KWPHBc+Th3FkC8nOmFKka7kPDhHRXW4nuE3Vj/OeSrNM9PT8kLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvQi2qCVOwZugvzyLo5IdkuKyNteRXpZoqKKr77U9Sduu+BUo
	ILQQ1OhepSv8MQOWa4f8lDpnbHgjz5qJfiZe5ZEUzH3S6WjKSDvA5DEc4Kr5MtTZZQOuhFbh8Oy
	uua/qY2JLPzSpLtvc3jA6RA3851gIKHPcx1uBjh2a
X-Gm-Gg: ASbGncvqa1fYKRKWyVe5aib6RwzWtPDl8ANmFWt5iRg11YarxoZ7qN90/frxB7mYgfF
	ouXyxS7m3ARruGzul2hhqioOZZ56IjPxjIVIa2kz+AlCqZia+Rp+H/guFf9RTN1IrNe4xQUyuKi
	8J58vjAF7MCvjDyYzkfMswZoJXqv/84ZSFUQ9+SJCiSAgngt3M9Nu3zL2jIMDFVW3J3I0dU/TyS
	YLlfcQ9Z+qDorlB0nHEMP+4Ltj4I42nAcYwVLpL5BocUAwLRxFVQ+o=
X-Google-Smtp-Source: AGHT+IHgGWXglu0DsqRQzQThUm92HQPN78KOj9YY4D2b+CMNT6C+6XgOPmNb4DnIeOzj1OW6pcFMvY1Iuj4xjLps2oM=
X-Received: by 2002:ad4:5ba3:0:b0:70d:eb6d:b7ea with SMTP id
 6a1803df08f44-73940411c14mr198047276d6.33.1757581795396; Thu, 11 Sep 2025
 02:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829164500.324329-1-ebiggers@kernel.org> <20250910194921.GA3153735@google.com>
In-Reply-To: <20250910194921.GA3153735@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 11 Sep 2025 11:09:17 +0200
X-Gm-Features: AS18NWCx4E3OdC7mBgPGgVUBUT-xLxLcqqp44Vqxj-OTHUNQdAnrn9pPMhbFdkc
Message-ID: <CAG_fn=W_7o6ANs94GwoYjyjvY5kSFYHB6DwfE+oXM7TP1eP5dw@mail.gmail.com>
Subject: Re: [PATCH] kmsan: Fix out-of-bounds access to shadow memory
To: Eric Biggers <ebiggers@kernel.org>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:49=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Fri, Aug 29, 2025 at 09:45:00AM -0700, Eric Biggers wrote:
> > Running sha224_kunit on a KMSAN-enabled kernel results in a crash in
> > kmsan_internal_set_shadow_origin():
> >
> >     BUG: unable to handle page fault for address: ffffbc3840291000
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 1810067 P4D 1810067 PUD 192d067 PMD 3c17067 PTE 0
> >     Oops: 0000 [#1] SMP NOPTI
> >     CPU: 0 UID: 0 PID: 81 Comm: kunit_try_catch Tainted: G             =
    N  6.17.0-rc3 #10 PREEMPT(voluntary)
> >     Tainted: [N]=3DTEST
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.1=
7.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> >     RIP: 0010:kmsan_internal_set_shadow_origin+0x91/0x100
> >     [...]
> >     Call Trace:
> >     <TASK>
> >     __msan_memset+0xee/0x1a0
> >     sha224_final+0x9e/0x350
> >     test_hash_buffer_overruns+0x46f/0x5f0
> >     ? kmsan_get_shadow_origin_ptr+0x46/0xa0
> >     ? __pfx_test_hash_buffer_overruns+0x10/0x10
> >     kunit_try_run_case+0x198/0xa00
>
> Any thoughts on this patch from the KMSAN folks?  I'd love to add
> CONFIG_KMSAN=3Dy to my crypto subsystem testing, but unfortunately the
> kernel crashes due to this bug :-(
>
> - Eric

Sorry, I was out in August and missed this email when digging through my in=
box.

Curiously, I couldn't find any relevant crashes on the KMSAN syzbot
instance, but the issue is legit.
Thank you so much for fixing this!

Any chance you can add a test case for it to mm/kmsan/kmsan_test.c?


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

