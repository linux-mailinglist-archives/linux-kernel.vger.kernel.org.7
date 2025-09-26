Return-Path: <linux-kernel+bounces-833527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788ABA2398
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DD14C7CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287B262FED;
	Fri, 26 Sep 2025 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SwSSDbQV"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBC261586
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854195; cv=none; b=E9H5696h7EIXUIqf6DfW7c5/iu0i2nOMstArcPdEBAaXywB3/FqRdlVuVWELJvKUe2TjGs9yl+Mx/9786tCF83w/wwAT2uI7qzxGVEI1G9Masl+NtKAuuq5dQeCcMfqmTcZLXZ5G7Fo5lOqdivWrcQqcxwYwdiABzJtdNdArzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854195; c=relaxed/simple;
	bh=+B2xewilhfMBd4r06QYXlpM5w5SW01cKLh5BqLHk4Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwLCVfa0AcAB9fl5c2aKg+HGC4a2pJ/2jZWNEhyFvMNGPUNjzB7y/5zlBP/cib0WwQewrczcJ32pgTNTXqRmfjm0pPN4kFLbBrx3kFv5Z6O3EJV9X0/gYpd/y6Dm+pR/yWmAHjD8ECRR+05KZUoHIcMt1VuRvtUhlgoduTbk60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SwSSDbQV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3727611c1bso173253466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758854191; x=1759458991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wn8WpDhqyCsisji2lqKvUYr02P6ZlJufwhfxU2CojrM=;
        b=SwSSDbQVQ6B95WGUR5lXiTUxl0L7l5jponID7eN6Nzqvz7VKbUi4t4CPdbFSKOodFA
         nzRbEQkPD/45AEcUdKXsJF5EKTLv9XevjAOhxK8OTnHKiFCUCQqC7US9PWVRe51NBP3o
         6L+G7T8iQSsjU/eSlMIPfKt9QwSh+XV61bipg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758854191; x=1759458991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn8WpDhqyCsisji2lqKvUYr02P6ZlJufwhfxU2CojrM=;
        b=wU+RsrV2inzRlLWAXi4/Pb4dThBE8d1Iwq+/xVIFz3FVJAfnVaQVeG8wX0s4euXNxL
         6M5rSEmM0xo3DYsnRflwhkO51wO1H0ih9J04lNaiKRvWZBw/AluqXVH/iiTIHE6J8Oz7
         2fP1Chx1di44mEKvzSgY5aGoyW5ZjGMZqf6oPVkKqTk7kWht0qVQ0SljEU4V886sF37v
         /Yyv5cAH6tEEP45T7EV3YFUIUjWy+7QyR5brGK5PAjalcdZOx/P0MSmebR1iNoX68rhx
         CYY6X653lnQne5eTXViK5WxGdevb54H36AKS1p8nCM+Mnpg/Z5panty9S872H7vbyXiA
         0yOA==
X-Forwarded-Encrypted: i=1; AJvYcCVTuuIpGex3thqPci8xoDCuDAA82NAUNrpVgsB5BjlACHei7qT2y/effAJwA7SIW4LEAmkUkKljmZg8NBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGfRwVMfqa+l/3vBKccXOessmkGuLkfi8YtzVL5wfuF3PRmJ4
	To2JbkP5u3U+KFNcC7CnVYBdrGIPANl/4NsfAjTGZK8d6n/9EryeTErnq866ejftIglTg2V3gev
	z/lxN5TU=
X-Gm-Gg: ASbGncsRBgHNjvd0jgJTdMZFawHzcVOY+WUJZi1B4x3y1bf7lhLmKa/c+aK8YdTYXzf
	Ed93+/C+rW2eKeepTHy3ktLR4RHiWTw3r9lyqWLLC9Tl8EwmeF/6Zx0ldVcKvRIFfOoy+C5Zb9R
	odSaDGJRN8jQhrtsSJSS/VemCH3EeZbSIciZs2eEWz+vpsQ3RNIt10LOrBmlpaa/bZgFKenopAf
	A66gSJHWZXwMAi1jdPn9GefhIQ1Xv9wASSedq94V51PVFRTPG9s2/ePDof36rQZlJ158/Dicue+
	8aKH6avD110+bmUKps3GFzpG1/5T681JMpDdJGZlqYEtKnt0j8hn87Ho9ei6q+k4XVs2lI678Z/
	+V21rSjooDeOfQ5VL7h/8yeS611wxJbnehlAWunzCPNHCgidDuRSMfWl87SZfm4rz8jywMubJ
X-Google-Smtp-Source: AGHT+IE8fSBDlMsnUOhpkDxqUI8+5vkg2e02eqSm8olvd2Csjx2N/7MqYEqMzYS6OhIWWyl3SRhgsg==
X-Received: by 2002:a17:907:9485:b0:afe:cbfc:377a with SMTP id a640c23a62f3a-b34b7dc9e51mr656888166b.27.1758854191231;
        Thu, 25 Sep 2025 19:36:31 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm285492066b.6.2025.09.25.19.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 19:36:30 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b33d785db6fso320959566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:36:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMDFugd7DcQeL38w7TsvuvqTOGRlger/Y6gYgYD/WHq1uEnZzbB8TYfLQNuUdkhLCmIe9/GpN+wShU/u4=@vger.kernel.org
X-Received: by 2002:a17:906:c113:b0:b2a:5fe5:87c7 with SMTP id
 a640c23a62f3a-b34b69423famr694527366b.12.1758854190139; Thu, 25 Sep 2025
 19:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758806023.git.alx@kernel.org> <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook> <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
In-Reply-To: <202509251823.1B974C7@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Sep 2025 19:36:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
X-Gm-Features: AS18NWCFKT7nakMjesHcuKen7L_Dmu3G5hpuJdo5u5EUHPZnVJWpcNfULKdl3xc
Message-ID: <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alejandro Colomar <alx@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 18:31, Kees Cook <kees@kernel.org> wrote:
>
> I can have an opinion about the relative safety of holding pointers that
> can't be safely dereferenced, though. :) But yes, I've long since lost
> the argument that C should avoid these kinds of past-the-end tokens.

The thing is, the "start+len" model is actually *safer* than the
"start+len-1" model.

It's safer because it's simpler and doesn't involve the whole
"subtract one" (and then when you have the "past the end" it's also
easy to calculate "how much is left").

So it's simpler, and it's explicitly supported by the standard.

It's also more strictly correct, because "start+len-1" is technically
not a valid pointer at all. The C standard makes the "past the end"
case explicitly valid, but not the "before the beginning".

Now, I'm the last person to say that the C standard is always correct
- there's a lot of garbage in there, but in this case it also happens
to match the notion of "this works".

Because the "pointer to the last byte" model DOES NOT WORK.

In C, NULL is actually a valid pointer for zero-sized elements.

Yes, really.

The C standard says that "malloc(0)" can return NULL, without it being
an error. So the tuple "NULL, 0" is actually a perfectly valid
"pointer and length" pair, and one that you may actually get thanks to
how malloc() works.

Obviously you cannot dereference a zero-sized object, but zero-sized
objects aren't "wrong" per se.

Now, I happen to believe that the "return NULL for zero sized
allocations" it's not a great model (it also makes error checking more
complicated). So the kernel kmalloc() function actually returns a
different pointer that cannot be dereferenced (grep for
ZERO_SIZE_PTR).

But my point is that "ptr+len" actually *works* for that case.

The "ptr+len-1" loop thing you gave as an example not only is invalid
C for zero-sized cases, it simply does not even work at all for the
NULL case.

Your example loop of how things should work IS WRONG.

Yes, it happens to work as long as you never have zero-sized things,
but it really is a bad pattern.

This is not "opinion". This is just a plain fact about how C works.
"start+len" is well-defined. "start+len-1" is NOT.

               Linus

