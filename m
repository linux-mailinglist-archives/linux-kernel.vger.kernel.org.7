Return-Path: <linux-kernel+bounces-744545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45853B10E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C8E4E72A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5752E973A;
	Thu, 24 Jul 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6NHWnJj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EB255240
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369952; cv=none; b=Qe+yiZrii/QEDKXLaTvwK/DddXlHMY0V58Z9JsglHJuqFkeqjEcSxNfGcPnii28ICRhbyj54xDAhsImHOq9ZgbYkTiP7FY1OpyUzjLSx3s3sjqFkbdrAo4IJdMro9G/vIflfhF99x5+K9MSTO+35V8ln6OsEB5Fh3CaNYhl82Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369952; c=relaxed/simple;
	bh=kqXvn/StDWrS77Y+1IlIaBQTJAyFT2n+pM6JuFAK6gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiUzYSP9dDzDd4PSuGn/ZaKblOHvZIJ6+0a3wpJYdRgh2EcqtzTdr05gxcy7lEPEnEEhUmZj4xv7/ONd68aQqevGULghjymn8idOFuaZ/kh2ACSwYUxo/m3TfL6q89uPKwD5Rm5/OxWmFRnbLT1VTL4XcAewWTkTKD06w9Q60NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6NHWnJj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso10932a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753369949; x=1753974749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqXvn/StDWrS77Y+1IlIaBQTJAyFT2n+pM6JuFAK6gU=;
        b=Z6NHWnJjnwi6TggyJP41L5IVJlOQh2PdOym2BqhARhelfqIvQhH86ulfQpMh6X4iaX
         gpejRnREbb7/YFcF5y+Hsinr02MV71TmtzrcF+0GiUjJ8cLNNQosMNKoO1nX6/6/4CRa
         BoJ002zsToN8+kklri2U4FYSMsy41WKQyoxhf6GUNsGlAT5BweXab5QvQat95jD3lgwD
         esAUr76GK+FaLYNN9uU35slTW+w7UsEjDC9QCqtEAZh5MhI1UMMmPtTa3JedtYAnMblE
         e2qMl9+n7SUGmPBO1uSg0VljFJKWUW5+iDiiWtNGFclWHf6HAQ/wHL3tl8Y7NqaQsq6i
         i2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369949; x=1753974749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqXvn/StDWrS77Y+1IlIaBQTJAyFT2n+pM6JuFAK6gU=;
        b=jtSxBz2sDm3dcgVsTb8FkAkQvUuZ1Ow2J1kZzH2iRQApvRF5BNEjh1WCJAa77TTULz
         GPM4QrMLJElbuGARGkQGgRVxNqTYvyzPcW/fdV0wRdRRvltizz+1RbJG+CFOB6gzHbI/
         tlMpW9q2ct+YzHXS42+WVk6JlKTRwRNkSbHAjSczybG8BFvFUHPiG0W6akoJ7JEclWMV
         1N16hIq8yLkfCl9Y/j+wU/cbucFp+yt+GOSDLZjfuXevSKqZez/6ue5OPs39WDNJjHEI
         ikFVRZGkcHqM34uJWJz08ZSm8shV8wBzjMI6CkVjO9oU3yaZpHBb04p/AsZg6pHKBLU7
         po3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkKumetYFU+Bwc7x2lkwvLM67y+o44OllNBjoj5btukKmSn6LouaOgbIsLRDSTrV3l3HqsO/wVjLkoE9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWeiMZdjIuH2t3labspeqLoPkoYNU0VcRU+Z1mWlWM7LhFEt2
	8K5WsmsJ5gk9Ww5fPGZmkPIt0MNbRk8hc9bfGq4wkywQINF/yISglhZPDPNcxqfj2xXw7QPslLL
	HhsNTIFfFZgDlXn94eGKn9f3I27zLwFHd20+mYVxB
X-Gm-Gg: ASbGncvRwGLYMoXhJTGCMDsETuWp7l1sVIjlmgRccKF3REIsG5v19FL7XJgchU1ORim
	/kQkT9mFB3LMPq3eJPT9pbZcwGsSqVbOQj2mNCUwNwbLZQmkSfO5xhE6lti+g6rH546MLaEfE1v
	n1Xok16Wz/jiP83W46wQkBPifH9BKZBe6gde0Pz3tvBLZ0QRO0hgc6NOu+QZIYQ1WIqODhP2hNS
	wkYsu/fYNv8cY3Ubi/tbs2QFRBetNmc9Q==
X-Google-Smtp-Source: AGHT+IHBGlAlpqkzcDHZbw2sNCslvhmGfaM9b4Nex1wG/5/Ri659NtJD16WWqjDzjVjGRO0jWUwlf3ajnKnPpgKPR/w=
X-Received: by 2002:a50:d7ca:0:b0:612:ef17:7853 with SMTP id
 4fb4d7f45d1cf-614cce4afe5mr78429a12.7.1753369948492; Thu, 24 Jul 2025
 08:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com> <45cd4505-39a0-404d-9840-a0a75fcc707f@suse.cz>
In-Reply-To: <45cd4505-39a0-404d-9840-a0a75fcc707f@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Thu, 24 Jul 2025 17:11:51 +0200
X-Gm-Features: Ac12FXyEpQmBUWM62BqVW--MRdpwMGBL7kBF9xwxQYUchJD8HK0S4n7Iw79CZgM
Message-ID: <CAG48ez0KjPqqDdzejsjhaHSuJG_0Q8zhyi-7rYq9gSZJergVVw@mail.gmail.com>
Subject: Re: [PATCH] kasan: skip quarantine if object is still accessible
 under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> On 7/23/25 16:59, Jann Horn wrote:
> > Currently, enabling KASAN masks bugs where a lockless lookup path gets =
a
> > pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
> > recycled and is insufficiently careful about handling recycled objects:
> > KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarant=
ine
> > queues, even when it can't actually detect UAF in these objects, and th=
e
> > quarantine prevents fast recycling.
> >
> > When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
> > CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
> > after an RCU grace period and put them on the quarantine, while disabli=
ng
> > CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediatel=
y;
> > but that hasn't actually been working.
>
> Was the "allow reuse immediately" not working also before you introduced
> CONFIG_SLUB_RCU_DEBUG, or is it a side-effect of that? IOW should we add =
a
> Fixes: here?

This was already an issue before. I think it got broken by refactoring
in commit b556a462eb8df6b6836c318d23f43409c40a7c7e ("kasan: save free
stack traces for slab mempools"), but I don't think it was necessarily
an intentionally supported feature.

> > I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
> > could only trigger this bug in a KASAN build by disabling
> > CONFIG_SLUB_RCU_DEBUG and applying this patch.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

