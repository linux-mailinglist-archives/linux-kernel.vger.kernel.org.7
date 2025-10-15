Return-Path: <linux-kernel+bounces-854681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE54BDF1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4AE3A4008
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21397284B2E;
	Wed, 15 Oct 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB0sj7U1"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0514EC73
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539009; cv=none; b=WR5JtifytKktg9RY3gFsrOMS1KIwGt2jVJ9kh8CFfZwj7OI/+XrllmVTd3dWswitln8xlzq7MjIAYWn/ln+N29ouoR4tKIlt6yvA/xMD0/56bBwWowtXSHHRsAA/0hlQnP8TUAUDglrbbhkWdXpjoXJhxBW2H8jt6Vy4MJ1FJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539009; c=relaxed/simple;
	bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIhU3eD1cvXzgx1u2vTVTooThAt1jbu2bVGJJU1XNZS2qtXqCyCD9iswFJNa/c/mDdss2ISzBAvAcnCj7PTOeAOLehbsugyGx2kC7p3b6RHKhaypCag281xiXxblgGmxTTdaGZD6LjeSXJlOTRY+XGUvBK4NJ0/U1GB4LSdbxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB0sj7U1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so764469a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760539007; x=1761143807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
        b=KB0sj7U1sEtZ2+Apfh4XHfSWy7Jinq6QDPgOz183tpDIy94QEsMIvQ0JceyG2PKTj5
         s88/tCLUJZCupIzO/LmxRo8UYT7DnV4YB/hx9DcekgxxKY3ncebEloLrHg4imtypAEpc
         TKBE9SDU+cx/aUQr3aLje3NOD06vMW77y4D3mwudTmlwfLVHG7i5WaTHX+1D9Huy1xbD
         ggIqI8aAzwicm7LpPZYWaa8WxrzRN3JzZvr3YIkLx3b2evl3unH0zsFOdWN0LsfOF8sT
         AWe8YaMU/LdGTdKc6hsBylpzgdWJvMXSmJXFL44D48nG/DL8bXNLXulGjFnY2nHbgQUB
         tFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539007; x=1761143807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
        b=My4dy+AYPfJp+GPtvtzq1ZUm2SRNhv3fD9KkJ9KEzZheKUQ3ASpapXSkYnuU6xxgcz
         WOmibXqlFLB5Z+o6nGHUiBR7T2/hOXU12S+65HgGSiNoAizpsxnsMs1C3S6B3gBBwmsN
         6JkPa9/+sBpsD7oYfX5D8Z5Fzd7YEbMyZ/zweuzIxe0jWKYe4Jps+ovJoa6uTin3Npiv
         yZR2Q/DPk+qwuqljgszkoXaj/ZwYwzp78KcrbR7hpV2tGlFyney2WUyFcnQPXOBzTWgL
         HPm6CJjDuFCjlbpJCmdIawG+5WoYiLWfJGmV0IPa49SsxrF7R+jDUEYe1cRHQ7MqtPP6
         JMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGoqlPRCwDSoaeYIZ/Yl38BXQ/dToxzpZFvOLtC54FvS9BfoOWLvqj5LJcKIO0jgHKc2EnYHjnT9cPrgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9r/nHbGOld+g9DVcOb7NqxkFZ5X+c3HxaX98OgM0343yNhFQ
	6sVt7IVkRkiE7eKzM2Q3s+b4jBmTiHi/rCfX+dRB0ta7N3zRvRAYpfRFACzSbvgJ8jxO7rpwkmp
	+risrrVQukBZm4FpO88GYWFRowGZfsGcK4X8CJFAH
X-Gm-Gg: ASbGnctRcjlLRbqLXhLHXqiyp0bXHPvZTDZjCe31RlVrkCwmHfARF/P/YCN/oQFfHnX
	1AJ25jzqyf73dH056FhiGlDm7WEJ2knLB4b9N/K7+Pr+voqmcIf9B9pbqDL+VkfIxoqdboKL/9S
	BicCIqdSq8pA1Tbo79GdZs/FfeZ23WwkAz3LcP81EclqcyWT71f5bTOtr62QHAi00enSnAATlJF
	zQOuAPJqgZ4+VE+Pu2SXdM82fqgM7CKBZpE1JY4tuou6L42DhNZ6VKRtJF5GqdrDlms+6OUUw==
X-Google-Smtp-Source: AGHT+IEgJ4Xh7QA5HE+tPAkou2gC/3g0NAsVR8ZhLLf0dUw631bkhU9G1C2LnuWl+YoLKezB9R+Fgv0xDlsaqCPV16w=
X-Received: by 2002:a17:902:ce92:b0:26b:3cb5:a906 with SMTP id
 d9443c01a7336-29091b58552mr3833485ad.16.1760539006951; Wed, 15 Oct 2025
 07:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
In-Reply-To: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 15 Oct 2025 16:36:08 +0200
X-Gm-Features: AS18NWAisQiMzt2QRK50IWgyiwg1QpdPMU2VVQzYd71ezZ8bUqs0a3UMQudZMqg
Message-ID: <CAG_fn=UNOLezyetfBYd3ztWDHmGwht-01yf1_p+O-JXcPu57TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:19=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
> >
> > +Cc Marco, Alexander
> >
> > On Wed, Oct 15 2025, Pasha Tatashin wrote:
> >
> > > KHO allocates metadata for its preserved memory map using the SLUB
> > > allocator via kzalloc(). This metadata is temporary and is used by th=
e
> > > next kernel during early boot to find preserved memory.
> > >
> > > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > > randomly intercepted by kfence_alloc(), which services the allocation
> > > from a dedicated KFENCE memory pool. This pool is allocated early in
> > > boot via memblock.
> >
> > At some point, we'd probably want to add support for preserving slab
> > objects using KHO. That wouldn't work if the objects can land in scratc=
h
> > memory. Right now, the kfence pools are allocated right before KHO goes
> > out of scratch-only and memblock frees pages to buddy.
>
> If we do that, most likely we will add a GFP flag that goes with it,
> so the slab can use a special pool of pages that are preservable.
> Otherwise, we are going to be leaking memory from the old kernel in
> the unpreserved parts of the pages. If we do that, kfence can ignore
> allocations with that new preservable GFP flag.

I think this is the best way forward.
Changing KFENCE to allocate the pool from buddy will make the
allocation size less flexible (goodbye, CONFIG_KFENCE_NUM_OBJECTS)

