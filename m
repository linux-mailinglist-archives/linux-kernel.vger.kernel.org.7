Return-Path: <linux-kernel+bounces-863332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9EBF7931
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A0884ED6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E33451AF;
	Tue, 21 Oct 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vf8MVi/k"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D93341AC1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062730; cv=none; b=qsaXav0o0VaiUf8V5m2+s354Jav10CvHZ9zIfe2BqdlfwqCsH/Dfwstfw8D2qKacUQlcijk4VbGabBw4nwO/eQ4Vsj4DcPW0Y+TOKJeXBafuLjl0UVcZcV6xvRcruz/+2cfMADVwoEyOGixrEsrGudKPAW0IbKOLPLeH7w6I6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062730; c=relaxed/simple;
	bh=bJwV/4fjdh41ZSy3se1KK9PXofaQ/FMRYPJpfMZGJi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW4jSErlW2/TPsKg/+aZOJbqWRoVpp6mUfpbPPz2H7zFmfCgrPD6WNJuCSgLrA/6DdTYV1/6Fv9iYaT2ydRLcPBLDXcP9Fyjlpg9F0wacj8HTpHtYmXE6bTGEYq30XAmoKxVJXFjjCWyEqExMBAo0kUbb1Vg5/Vn9N4Nr7TbAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vf8MVi/k; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so1383621a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761062727; x=1761667527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2rsp273D+5b2xXwhTqrhSGacsVEuhyzYQN7tg2ibaE=;
        b=Vf8MVi/kNZRVVLJsebuJbSgXjUNkFi9YH1o8W2zpOOSwOvMva3qhHOnWL8RPds06wU
         /rpLeEF9LjPkW3oc9IECXO8ATyioAxW4MiuRXHO1pAHnVQzbD3FCM57Tyy2P7+Bj/sqP
         Y2pPW9R17WTQEa1jMNdl7WybPZFyuXlkkvZ2f3PvsLsHx4fH+wSV9FRjeae6sm6a0bQ9
         Rn84igu2jdxabYNWPzs0+kV4QMwN7Dz5QymiCa6oqZHcRwbht8DIINdk5PKnqzhIBHoe
         Z9LwV6KZd1wxPuDb23L56UvX/tEjnNIximHH2UIUISoDN/YUXpor5AZ53hGDu8oxDu10
         O47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062727; x=1761667527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2rsp273D+5b2xXwhTqrhSGacsVEuhyzYQN7tg2ibaE=;
        b=GY98+lIzW6A0EJyed0PBdY30l5D4U9kHkI3nuoDTKDxdghxF2HDizKT+R9b4H+UtyH
         rdrRLGMFafscYnhnKOr999FmCl57FjJCZqUIx4ME/uYxnK3YpfA/wY2WWEZIjAqjgn8D
         ymFLVRvkn8CbLX26UsUaTvW36pGIfGngZdjOAWOrw/vSSg6KMCQaNlup83tYxkjdU7im
         qFYMW6KD2q8Fo+8pJ+R82Hw+E6fmrZ6aRA5nJX+5dapxya7FdaaeAozsIFOMKff1VV7M
         9IB84cqg9PEYhdp0XFSx6IvLNcujevDTZuaFMOEfWAwo0KUIR0ycOlxWZFalICY1WyFI
         OFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWKXsYUwkOrsI7hQzilrxlNQtXXkr7a4Qgah2yzyfN/7HR4p39x4rxDm+2VESCB0FVa3dMwSqlWIw8N61Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMopsiQOMhgcKyG8Im/CwKr27vErSRe4U78OILWknfWRAoU6w
	kFw+UefAft5PIop3p5ImYDZ3Odmexx4dtDFXqIPSkhlhgCOVC3L8vZr54giStCeR49+fntF1iG7
	vLi+IASOskJI5pQbstooQM3d0Hjt28z9DX+EijFwlxHKHWkqHKriF
X-Gm-Gg: ASbGnctErw6vaM69jt0es0/UGXwC4YJyxgEOvf8Pd0OxA/n1+ltRnmZbmeXVIPeh2e5
	M2i8q0aeLcl/GBTyeKsxPUxzWBEqD84q2cqJU1/PFfpTQRksfmEV6F+Dwv7NvgLYPS90b4UF00q
	C6V3AbrRcYgfGHVtOlb6m+lbR5gwjkzWkl6wrJmz/Y6ut6CiQkDR46YZZ7x2O3G+IeiJ5+th3z7
	Vt/5sWc2C5i2ShJr1VFpNTYDPtRhQK/CLmySwqdyzF+kLzoYJZqnBSUlA==
X-Google-Smtp-Source: AGHT+IEeLKgKPa2ao1C+DHLxoNObY+PUJkOnP4atEfZz4NGBJudxoOmpcHAQfeKUlWWXs9tatq7N0kg5qlHh96IaXc4=
X-Received: by 2002:a05:6402:4316:b0:637:ee0d:383d with SMTP id
 4fb4d7f45d1cf-63c1f62cad5mr17942304a12.3.1761062724284; Tue, 21 Oct 2025
 09:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <aPchmxfh4ACM0vY2@kernel.org>
In-Reply-To: <aPchmxfh4ACM0vY2@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 21 Oct 2025 12:04:47 -0400
X-Gm-Features: AS18NWCWk4RBaudjWOtzT3Lj31f5xnWLUFz70tsgIQAGYSdCdW8mVv8zsn8kkEQ
Message-ID: <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:01=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Oct 20, 2025 at 08:08:49PM -0400, Pasha Tatashin wrote:
> > This series fixes a memory corruption bug in KHO that occurs when KFENC=
E
> > is enabled.
> >
> > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > early memblock allocator is restricted to a "scratch area". This forces
> > the KFENCE pool to be allocated within this scratch area, creating a
> > conflict. If KHO metadata is subsequently placed in this pool, it gets
> > corrupted during the next kexec operation.
> >
> > Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
> > that adds checks to detect and fail any operation that attempts to plac=
e
> > KHO metadata or preserved memory within the scratch area. This serves a=
s
> > a validation and diagnostic tool to confirm the problem without
> > affecting production builds.
> >
> > Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used=
.
> >
> > Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
> > directly from the buddy allocator instead of slab. This bypasses the
> > KFENCE interception entirely.
> >
> > Pasha Tatashin (3):
> >   liveupdate: kho: warn and fail on metadata or preserved memory in
> >     scratch area
> >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> >   liveupdate: kho: allocate metadata directly from the buddy allocator
>
> With liveupdate: dropped from the subjects

I noticed "liveupdate: " subject prefix left over only after sending
these patches. Andrew, would you like me to resend them, or could you
remove the prefix from these patches?

> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> >  include/linux/gfp.h              |  3 ++
> >  kernel/Kconfig.kexec             |  9 ++++
> >  kernel/Makefile                  |  1 +
> >  kernel/kexec_handover.c          | 72 ++++++++++++++++++++------------
> >  kernel/kexec_handover_debug.c    | 25 +++++++++++
> >  kernel/kexec_handover_internal.h | 16 +++++++
> >  6 files changed, 100 insertions(+), 26 deletions(-)
> >  create mode 100644 kernel/kexec_handover_debug.c
> >  create mode 100644 kernel/kexec_handover_internal.h
> >
> >
> > base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> > --
> > 2.51.0.869.ge66316f041-goog
> >
>
> --
> Sincerely yours,
> Mike.

