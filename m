Return-Path: <linux-kernel+bounces-861036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AFBF19DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE8188EFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C431B133;
	Mon, 20 Oct 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V9Di2KDV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12C246768
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968018; cv=none; b=TRzvFmWFiC4wgEryafKA2sXrc5QSnJ4oj8NQB2HutCGpavCCgG5qZY9ee5Et+SmSYT5wOgaskc776uMaMGOoAS/dOwKTdNH6Fg8E8+mWbA2dDWZE+UKO5ZNUOoAvr8t96rgxTgyK/rgEHxNVQZ+fzjnYbNxntgNBPMO1GxEChro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968018; c=relaxed/simple;
	bh=rkP99ZMKvFsrmy+SgFRUq9MsO9iuKwR1g/l732VWIZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCo0IDORqhh2K+OKUlxL7pOeqsVREimV4lydBUP0F4tT3ztgAZqqPUfdwq9lq3vIKbTc7GyU3bwFS39sK3qPG7q+bU/pv0CTv3BtHA7bAfrKjyc651a06T4OwuGdI2jZRWWKm5ZYW+UTH6UvUjFCpZoxnleeV+ffQYm5vv3vRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=V9Di2KDV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so4641669a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760968015; x=1761572815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvZhheMKMZpe9Bqdfjty1jLCUGi3kEK1+Ph1/CM26U0=;
        b=V9Di2KDVQlV8rNTdpN8+HUGL6dPg33CXDxlhG0sH4oZpP04uB6d/giSLmj9k/pMLHL
         5svRI7BG+szjQPhWNro3LVYMzdAQSl2dm5HbZWleaTUzaIzM87Ixu9E4edoDeZJ6cBsp
         WEIkXnM4Nx47c6GJ826Deke7oNLeCH7bYCcA76WrKTcY6uT2+m2jdtHzXV3Ze85I/5dn
         W7+TUolWemwcLtW3WQNHDCXpxbiG67HS9Jxhm2u6vXYudK7p3MB1LQxwQNKxS7ZDSq7K
         9ZoOun/OalC6Py7PeXGl+nDcG8M7FV+Od0G2I04K0edQQ+oU28u9pN3XPhZD8ufzQZZK
         4qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968015; x=1761572815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvZhheMKMZpe9Bqdfjty1jLCUGi3kEK1+Ph1/CM26U0=;
        b=cyX3PdcCUgcE5IqdlbLcwv07z5Wy1nOw+x22i5OE82A/tJ9oLND805QzUsIk2Lhe/m
         yO9xzY3yeYGDM1H1ltBuMxTwOMDVRn5AQf5BHFzastATdfAQn05uI+jOlpa3jFvLFLSC
         NuWNYw4Cr5BHt0C2+DuM24gb173NG/GC/CEZ9q2sHu3W8wEwLop3Vx7QgBKAJjAlNU5u
         WV5gziB66wyQoLtdgFRCTYvRQhnu2kLrW1aR8X6pwEADptNU60/f1XolxEBay2M3gPCc
         +B32FlTsla9/y8WagsBE4PvnG1JtLg21A85sZf8wj53IgKCLhjxOUH7NnZHcNfWuH8BE
         9IpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfubGr/5LE0kTX/z4NXwOQzenjSZi47fq//39qdjt0SkPDYqr3zFcLo/Swt016ZtM+Es5LLz4k4Ds5zU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSreZRov0A1JJzblZpNqKgFWUbYJnb46vgrMlo14jMW/1MoP6
	b9Nd4Cvt3W3Zy8adHMJjzTRhZ1Ykm50hut+ulIt7W7eXSxWoxy3DI6FUqAV/I7iKWmgqPceeHiX
	3v6mgJ3Wp6hKGJpHKnNV29uqFvYRr1JrPIfNgixOzvA==
X-Gm-Gg: ASbGnctXjNI0DmIjiThVGRWY3Y3HaNPX1/p7yd9utZTlfPmLu9gNvcd0ZB4vqUD9hlq
	qbVdQa3y4fvh+ATWAh7gUiPQzc/dD1jYVdLv/NUUqOcQ8gY+oRFniDm85t5RwQtG04hRA7Nn46v
	ado452uXhyqVgPP5I/PWR9jcOEVE0I1dugksowZwro63mFZNG7x09GbmsXAE/THVvOjub2jedGe
	Mnv+U1lCZohs3dnWsVreDBoRMxmq/pKpASW27HjmFsJ2Xh7K5EtBIzAAA==
X-Google-Smtp-Source: AGHT+IGTtXofa3Tuh8IL9I7GRE8Fk7Eo89lAqHP82CDJnTPRhPkL7vp4I1N13r1UMPC1uhalgHforXCkmCNuNpkruuY=
X-Received: by 2002:a05:6402:520a:b0:63c:4819:a781 with SMTP id
 4fb4d7f45d1cf-63c4819ec3dmr8180303a12.11.1760968014329; Mon, 20 Oct 2025
 06:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com> <aPXz-IPDRniMHN0u@kernel.org>
In-Reply-To: <aPXz-IPDRniMHN0u@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 09:46:17 -0400
X-Gm-Features: AS18NWBlWOJhpsHXL5lE0ZnfEqYI5Gk6KDcMcT8UR3vRbPoVwxHnoa0bp6hkqoc
Message-ID: <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users & Fix
 memory corruption
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:34=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Oct 18, 2025 at 01:17:46PM -0400, Pasha Tatashin wrote:
> > This series addresses comments and combines into one the two
> > series [1] and [2], and adds review-bys.
> >
> > This series refactors the KHO framework to better support in-kernel
> > users like the upcoming LUO. The current design, which relies on a
> > notifier chain and debugfs for control, is too restrictive for direct
> > programmatic use.
> >
> > The core of this rework is the removal of the notifier chain in favor o=
f
> > a direct registration API. This decouples clients from the shutdown-tim=
e
> > finalization sequence, allowing them to manage their preserved state
> > more flexibly and at any time.
> >
> > Also, this series fixes a memory corruption bug in KHO that occurs when
> > KFENCE is enabled.
> >
> > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > early memblock allocator is restricted to a "scratch area". This forces
> > the KFENCE pool to be allocated within this scratch area, creating a
> > conflict. If KHO metadata is subsequently placed in this pool, it gets
> > corrupted during the next kexec operation.
> >
> > [1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashin@=
soleen.com
> > [2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatashin=
@soleen.com
> >
> > Mike Rapoport (Microsoft) (1):
> >   kho: drop notifiers
> >
> > Pasha Tatashin (9):
> >   kho: allow to drive kho from within kernel
> >   kho: make debugfs interface optional
> >   kho: add interfaces to unpreserve folios and page ranes
> >   kho: don't unpreserve memory during abort
> >   liveupdate: kho: move to kernel/liveupdate
> >   kho: move kho debugfs directory to liveupdate
> >   liveupdate: kho: warn and fail on metadata or preserved memory in scr=
atch area
> >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> >   liveupdate: kho: allocate metadata directly from the buddy allocator
>
> The fixes should go before the preparation for LUO or even better as a
> separate series.
>
> I've reread the LUO preparation patches and I don't think they are useful
> on their own. They introduce a couple of unused interfaces and I think it=
's
> better to have them along with the rest of LUO patches.

Pulling them out to apply fixes separately feels counterproductive,
especially since we agreed to add the new kexec_handover_debug.c file.
The most straightforward path is to build on what's already in -next.
Let's stick with the current approach.

Thanks,
Pasha

>
> --
> Sincerely yours,
> Mike.

