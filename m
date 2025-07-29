Return-Path: <linux-kernel+bounces-749678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1DB1516F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A349543CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45F298990;
	Tue, 29 Jul 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgpbh1hA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6E226D0D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806944; cv=none; b=VltaqA4gy18QxfeCZxr4rDEiltU9x92l+IMQ2NtzQKRo4Z5bJr72/c0mUe79++Gcr/6K0wBTwW567Sf5uC7e8cAdIcHUWuGY4mCHS0TjFtXXbwo3TqDCDHjqb4zDDE8Ar3EtPIFlHJ+RPuiBW1xPYf6EICKMF/f/1SPifnruWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806944; c=relaxed/simple;
	bh=SrD+ELxtKF/irqOE/vB9xss3CyguaXFR7lrG2Tt5ODc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbmySfHDdhOM9/wU6YoL5tbDs4b9yPQ1O2PVBYpIaQbPdaL6CN2r+NXvvGiu0wk55YMjIKME7VMFDU9QFY2zTH/g0a5YtokBD19lFEdwqF7lLbKSe37ZSW+MRjshZn0+Yg3oDxuVa7xjkqlbtCdGHzyu48aPSk+y+T8lfDV+KFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgpbh1hA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso12698a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753806940; x=1754411740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv40Dlr5B9TIJUCPEQGZxzFejkaL+qCdmU+tMwtTk64=;
        b=tgpbh1hAlfLthYLDGF0qJihCB7mBcr+jkVC76FnHnGK21PUULDgA9iYcqi3KTf1KWC
         rIQuR3aF6wSc0xUGNq5KaIcBRb6gIdavfi9RVE5HlBZARYPpMTYNnZLBdg1Cn1cYA/mO
         A4kuebii8h3z5HTYNonS7kHUu3iUZbW3N9bkSCLGKPWr7DDWVp7YwIpZ7LajMbKxSJGA
         livWMC452LLc3WF5Xz0oAho+OJ0e8ACxwJTIpQFtnaleYfx1ogbpYpgRRqlYJwsjYZy0
         EBoelEn67CeLpPJxZ1BIijqwW4OATYz+FGmE0rxLoaQqW4cGgtn0W3cHtwbOxJhevKv0
         CwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806940; x=1754411740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv40Dlr5B9TIJUCPEQGZxzFejkaL+qCdmU+tMwtTk64=;
        b=LqDpSEKQ+iRjRdHvm3nyIVeSlTcQrvs3k1g4niC/dwQeIzq6yrY858ytrLX/XD54Gl
         Mof3wtFPjKlEUvOdt7VTED/MmdsY0nbRg2R6GSW+8JS0/uFJmZjHrsTGL0DbW9mQU6kq
         vN8V6CaqQEM9IwidrrmknPck+d8G6oWQxeYXqGjhYRaD4Ouwb3PUyy73c3PuXhNduVtE
         Eqi2SDRUOJvaPhbqgzm0RD3bacdtsABs6b5wV4LQXnl1fu6M5B/whmnfoDVKCu0BUK11
         Kxh4lmAz3E3SCgCrwL0Gw2TVEGXGEIOI27VRXThOGsioCg3OLurvVdRQ9q5WeiLkv0YG
         9gVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi1eLK5ncQ3uN7fMI7tqc2wxtE9UbeJ2Ju3fiGO+W1q1Es0H8LIiNhDAoeRObGsbH7Q5YSLtQqnd8Rj+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1Adj1bUAUAsxDSqHV1BCLX6xGl8pdeb73r/K52ban2+HsxO7
	IyNip1y5nMS96XpjbRAAj32DHGAiBxOWqIeLFCAwDo01t+Z476EySPyK2Wth/s4HBEM6FHiqGyu
	o3oY29il/4zsJA6vJYe419X4RrOYFG1efwKasZ6RK
X-Gm-Gg: ASbGncse3+Ez1eTyv/sPOm4AnUZZJELRTlpHU5FOXCXwD1SWsX8HpdKsOYAzw65o9Yw
	cd/0pduurjKurpDNL5/jrXsjfHLZ5JDREC+R3XTAsOuTZq0y+/zmNRwnUklFseggEQC6ISFUQUK
	6LrjoIYrtbQJZodZZ/GziK076y4TSFHvGPELR3/0eSr7f1iS4BSvwCTeGUapifHHkkv5T7M9tro
	Yr8MPa/EjZn1uwEnPSKaslgdbFTxIQBakBPtloqqossEw==
X-Google-Smtp-Source: AGHT+IFKv7YMKivBIj1BCg5i5urE/qc2uvAwLaB9UK66R72frDrbfA5Hbtvm74CaGOUjlmywh+U1wO9wezcqBXBbsmA=
X-Received: by 2002:a50:8a97:0:b0:612:ce4f:3c5 with SMTP id
 4fb4d7f45d1cf-6156680c26cmr111335a12.0.1753806939698; Tue, 29 Jul 2025
 09:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-kasan-tsbrcu-noquarantine-test-v1-1-fa24d9ab7f41@google.com>
 <6aeb9c5d-7c3f-4c0c-989f-df309267ffbe@suse.cz>
In-Reply-To: <6aeb9c5d-7c3f-4c0c-989f-df309267ffbe@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Jul 2025 18:35:03 +0200
X-Gm-Features: Ac12FXw25dvpS-KcFMgDsvvBnkOQEQZAMrlZ9kHerHD3IUA1WAAg7ptbMtRjVbY
Message-ID: <CAG48ez2O4OvhKjdy=Y6fzuK0Qf79JQXCXV=uQV2ED08fS1RNpA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine skipping
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 6:14=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/28/25 17:25, Jann Horn wrote:
> > Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU s=
labs
> > if CONFIG_SLUB_RCU_DEBUG is off.
> >
> > Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Feel free to either take this as a separate commit or squash it into th=
e
> > preceding "[PATCH] kasan: skip quarantine if object is still accessible
> > under RCU".
> >
> > I tested this by running KASAN kunit tests for x86-64 with KASAN
> > and tracing manually enabled; there are two failing tests but those
> > seem unrelated (kasan_memchr is unexpectedly not detecting some
> > accesses, and kasan_strings is also failing).
> > ---
> >  mm/kasan/kasan_test_c.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index 5f922dd38ffa..15d3d82041bf 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -1073,6 +1073,41 @@ static void kmem_cache_rcu_uaf(struct kunit *tes=
t)
> >       kmem_cache_destroy(cache);
> >  }
> >
> > +/*
> > + * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
> > + * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
> > + */
> > +static void kmem_cache_rcu_reuse(struct kunit *test)
> > +{
> > +     char *p, *p2;
> > +     struct kmem_cache *cache;
> > +
> > +     KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
> > +
> > +     cache =3D kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_BY=
_RCU,
> > +                               NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
>
> Hmm is there anything inherent in kunit that keeps the test pinned to the
> same cpu? Otherwise I think you'll need here
>
> migrate_disable();

Oops, right, good point.

> > +     p =3D kmem_cache_alloc(cache, GFP_KERNEL);
> > +     if (!p) {
> > +             kunit_err(test, "Allocation failed: %s\n", __func__);
> > +             kmem_cache_destroy(cache);
> > +             return;
> > +     }
> > +
> > +     kmem_cache_free(cache, p);
> > +     p2 =3D kmem_cache_alloc(cache, GFP_KERNEL);
>
> and here (or later)
>
> migrate_enable();
>
> > +     if (!p2) {
> > +             kunit_err(test, "Allocation failed: %s\n", __func__);
> > +             kmem_cache_destroy(cache);
> > +             return;
> > +     }
> > +     KUNIT_ASSERT_PTR_EQ(test, p, p2);
>
> Otherwise the cpu slab caching of SLUB and a migration could mean this wo=
n't
> hold as you'll get object from another slab.

Yeah...

