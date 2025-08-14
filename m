Return-Path: <linux-kernel+bounces-769127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6209B26A91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EA25A0E15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309620A5EA;
	Thu, 14 Aug 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcN1g2tw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E6199E94
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183903; cv=none; b=C+kmN6WjrQsWliIx+qZe7IcIipjyAxRB/sgoNCsmd7m/jBMlAdmFnVyftWVJ00f/tlsLQ4CgOw0M2vXjKzDuL4cn7khszpuQLRkvksof45oJiIZDROg2CTlZA6ingfiH9hrpwYlIdRnp3dnAe5GPB6PwTTbgZy3Rj2CpyLNFN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183903; c=relaxed/simple;
	bh=jRHKPd5JxpvNwhlJBPIxE21OnvjOL9nluG7LlRsah6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfxSy/8AOIrSTkWkICLoQckC5C9UYjdSCDtqUY86RQKiA7f8a5WAZsmGKtLn9nfSsV8naRBi4hOPp0zkUIKYzHeSSxhhupVxaOvwmyL5ttW7WRD4gE0ymRBEkJgTRoSkzVnF0YaSjdgXoabpAXQDaGlMASvhiVqYcxum6rppELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcN1g2tw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so9956a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755183900; x=1755788700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHTTqKKdq/5V0+v/JW5V+lqTYrF2enAJRrocEqjtuIQ=;
        b=AcN1g2twlrtoQ8Y3jbvaz0Tke1BGz33Q5X2iv4yfvXGaeFnlP1lXuwVNHzqdVATooX
         QUKnTMDhl5HU1MYGlNRwC+xHAhmIWQHJzN5M4gYOAtCfKGuip0mzD90OqSZpBNbkUTHd
         9pOZ1sKRsgkH9sAIKPslqoEFWCQGG1k3ynIOjxYsD47A99wkJhMfw/oK45EAvUOuu91f
         D2vKsBYGO9qFF+71s8FmypWbZF3OeKdmq/nCIsvZoFKsU+DrtukihJf6zcqVoFV6cO/R
         MkmxcoP5YB/HzpD13Y5sslpEn9mIp8RrVeb3DHGORqWA4n23tOwX1jKra0Vf4I6V927B
         GL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183900; x=1755788700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHTTqKKdq/5V0+v/JW5V+lqTYrF2enAJRrocEqjtuIQ=;
        b=s2PrbraunY1nc7Ssm2AtlQzYDOBBNqsa4UN7tRjq30GCHt1EjnkJf7KSerQZ7QamY7
         g7d1VXXGBbja6KvjC/r8I2jZIZ2p4g/q2ain+33cRc3w0wBdUBs5G8h58JX9jNQ0RjpK
         umsoI486FRtzIsK52/VvkCl2o//CqbCFGHvNvDKQRf+Na+EvR6cU7ROj/trwoPd8Tdag
         oGdtWq+Snu2F302hcpcrKpSjIMO0mpLLyPvJheDkmW8bRoe3TxtFW3zQWt0CnI244j8N
         dMmazSA8v+iPDd8I8KhCwTa2a31jYR0heDclb84olA9JD5rt/N7+yXUWHltU0AXRzHdM
         QE8g==
X-Forwarded-Encrypted: i=1; AJvYcCVpP5pSGl/5teZb0joUfsR6sWRO83sXTH2yQL9ttLIGwMYmG3lR4HAs6sG7Kv3GHQXE0b6AGsnSc10TxBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdnjeOQf18SnGTgiQvN+Tf2BANlqFaTouEWF/xKXd96fTDfXX
	H9ehbDkfYLKnGAyPJOH46g+zIRVI6EVnPxDKtoO4C1xHeyiSk3FCcplM0kiY2LabqO3UmZ13X8N
	FCxVHt8cJu90LGFrt3/SUVhUvAUHBByoXyyUJCmgL
X-Gm-Gg: ASbGncvAkZRao6/bJefKSvj/zW51JWkDBv4/TXwwkOmcapyfUhBoZ7EJjLORR26NolN
	ixw2fTsbyNshBhUNLaF5oKEHZ3BZq8QXOrP61HtP6BOXk8ZkqcnqjcIBFoxEagE25erCbkiIEip
	ndPsgTOrSpgahE2a5XT7OBx0ZCQw1kud/AIfe0n9vADIeE7zXQLk8JFgA32M2+DzJLuiQismN2l
	48ONgHfS96Atmdayu6t9wQbCjMjyT8pPW8A1ng3oXBxH8DimA9L
X-Google-Smtp-Source: AGHT+IFNlA66qRktjZlIhzbxSDgit4AZenfxz8oP467vA566LpdL7jF19DE2WZ1XUSPlup99EPs2+mDOQA3ziH554eQ=
X-Received: by 2002:a05:6402:b66:b0:618:527d:633d with SMTP id
 4fb4d7f45d1cf-618928d3d6amr59340a12.5.1755183899573; Thu, 14 Aug 2025
 08:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
 <CA+fCnZeuewqXSW0ZKCMkL-Cv-0vV6HthJ_sbUFR9ZDU6PmzT-g@mail.gmail.com>
In-Reply-To: <CA+fCnZeuewqXSW0ZKCMkL-Cv-0vV6HthJ_sbUFR9ZDU6PmzT-g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 14 Aug 2025 17:04:23 +0200
X-Gm-Features: Ac12FXwcH9CZHsSNIO3sMGBaN83LZnV8U4fAqWyZL3Muxw72pDBQ5p_7Azu-P6E
Message-ID: <CAG48ez0OnAPbnm73a+22mpBjvGHKFGqYAA8z+XocZEHXJCcQiQ@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine skipping
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:10=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Tue, Jul 29, 2025 at 6:49=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU s=
labs
> > if CONFIG_SLUB_RCU_DEBUG is off.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > changes in v2:
> >  - disable migration to ensure that all SLUB operations use the same
> >    percpu state (vbabka)
> >  - use EXPECT instead of ASSERT for pointer equality check so that
> >    expectation failure doesn't terminate the test with migration still
> >    disabled
> > ---
> >  mm/kasan/kasan_test_c.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index 5f922dd38ffa..0d50402d492c 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -1073,6 +1073,43 @@ static void kmem_cache_rcu_uaf(struct kunit *tes=
t)
> >         kmem_cache_destroy(cache);
> >  }
> >
> > +/*
> > + * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
> > + * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
>
> Would be great to also add an explanation of why we want to test for
> this (or a reference to the related fix commit?).

Okay, I'll add a sentence here, will send v3 in a bit.

> > + */
> > +static void kmem_cache_rcu_reuse(struct kunit *test)
> > +{
> > +       char *p, *p2;
> > +       struct kmem_cache *cache;
> > +
> > +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
> > +
> > +       cache =3D kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_=
BY_RCU,
> > +                                 NULL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> > +
> > +       migrate_disable();
> > +       p =3D kmem_cache_alloc(cache, GFP_KERNEL);
> > +       if (!p) {
> > +               kunit_err(test, "Allocation failed: %s\n", __func__);
> > +               goto out;
> > +       }
> > +
> > +       kmem_cache_free(cache, p);
> > +       p2 =3D kmem_cache_alloc(cache, GFP_KERNEL);
> > +       if (!p2) {
> > +               kunit_err(test, "Allocation failed: %s\n", __func__);
> > +               goto out;
> > +       }
> > +       KUNIT_EXPECT_PTR_EQ(test, p, p2);
>
> I think this might fail for the HW_TAGS mode? The location will be
> reused, but the tag will be different.

No, it's a SLAB_TYPESAFE_BY_RCU cache, so the tag can't really be
different. poison_slab_object() will bail out, and assign_tag() will
reuse the already-assigned tag.

