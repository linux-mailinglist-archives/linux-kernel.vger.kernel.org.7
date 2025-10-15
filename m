Return-Path: <linux-kernel+bounces-854654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BB0BDEFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D4485EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C024A074;
	Wed, 15 Oct 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="j7zNdEsk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BF23D7D8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537988; cv=none; b=SZCTqum/q2lY9pYIYzx2DieSfPBJdZNryxyO1jOmsypy+vpV9s3WLPrc0iru6cf/1DwWLsIu7Dv1RFveNXcdwx7kfj4nw5lLCTRs3whSFnwK6YCAY5AApjnIgNOdOj+iMIBRTwHVTzoDkJ9WChCUkloD3UiNMT1TcMuc4C8RjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537988; c=relaxed/simple;
	bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnBpLOyc0MjiZ8QMPcwblSl/3RYDEfaqNGXODUnJ7mKHz7pRAZMRFPvOVZVZFCGIgDzDpGY9pVgjxrZriVaMg8XzjV2SNuIUYnqQufyL150sbKzGg54pnfQCzX0kjk3t7cZfgGD0bY06z3cI8vClNgbOvTYdQcye+DmuHegZ484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=j7zNdEsk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so4633761a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760537985; x=1761142785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
        b=j7zNdEskECDJJH5K3ciuC1zujG7UXNwEsOLmYaie8Kc/8EWsniGZhtIYREoC3ZNxeF
         m/Kmuk+dbR2Ddq1OcDoywHeo09iwS7s5UD4/IiNwC7X7miTxiQylt0mi+hJVTcFt13DH
         rtmhugiBwSpgSszmr8PHZCd770njjL08Ajl7lk4iA2j1IPX8MRlSDhN1RVkimSm7ml0h
         ycC16MyhWEIxSDiMFozFU3gZnpUILtUSwR5sOaEDw8gkS8ssmilcx57AkdwIW+bISsoR
         B/aoBZ0YjLLgZU27FPTxzf5BeSt1ZEDAw1YQMKnEeSHWctnRE7Aqtunj2wOrnfwDyJTo
         ukgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537985; x=1761142785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUApJ/d2jv5ytp4hpBk/UGF4vKaPuPbb12BM57vyuxY=;
        b=IGLLGsC8RpyCpJitpjR2TzmF8uJyD6EDLeQg6yhKsN29ykOJwn71ZYZg6xkIfn0ryh
         F1mA0YrJUF0882woYQc6yIdG6KP7DBcWTabbB0+jr81JG1VTtLRfrc3UghKQrbRi3Z7B
         MeE2mak5mEgJjXflIMOqSmw9pVzsNxy/4NFLkrcTGnY3EjupRDynrTKkjkWKl4O6puPS
         Vn0FXSp1bp6FAvqDiDlEUUAtSP7Kl+ZgtCFftBF/XOdV36/pLkgnKxRgMlc2w/4pTan9
         O9jy5COoQo1TCdVE9J7FuHMXTu0+17Qu9Lx+ZiydL8Di/ycgHHbDLswuyzFA4AMbY6Xd
         XiNA==
X-Forwarded-Encrypted: i=1; AJvYcCU3l41AL4EgeFnxZbSXN5xdTHiVJDbVdO8UNp+KCC9V4LaBcrPLyxIJjua5is8Kd6T5e0UNYvVuJdR6658=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rAyAO5EV26RgUvHAmHk3kow1mClvpSgTVBmHscUh6pLgBeyZ
	ex2MZE8oD75C0FQd92ew3ggg/R2T2wWXDZhlglAdS46aKDj296FLHrCZIvV/l0xa1NjVYQaeUoH
	DGsATh8SyY+WWkEH85zYATGPje0ynsxYuKgmZ6v0yoA==
X-Gm-Gg: ASbGncsL7Q/OZln9J2kXhJE46Xgjh9lsN/N2smajAJbqYpUbt0IBn9NWTlvoeT16HXt
	HWNsFOTeKFuuea+JAzIrk5faEU6rxNeCdK3zpzyZFfzGW5Ln6JQk8hL9YDlZgMtfPIRpBM88Oao
	MfLu6AOzxzvqb8Tl4kVeQCJ8JCrQrKdkNHxiTfCQtgsOCWNJTS9PtSd9+N4ratuvF5sXTS+vju1
	aJ7ozjM+796vkkDWRdf4vsRVWwdWbBTnA==
X-Google-Smtp-Source: AGHT+IFgvnWABvFp2YO4aybRqOy0KXXsuvYtzVtzjFu719w6HusoLk54zzREdfAYZlsXpNluTDl3s5anm94ec20FQEM=
X-Received: by 2002:a05:6402:5244:b0:634:544b:a755 with SMTP id
 4fb4d7f45d1cf-639d5c3294cmr29350078a12.19.1760537985003; Wed, 15 Oct 2025
 07:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
In-Reply-To: <mafs0v7kgjoxq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 10:19:08 -0400
X-Gm-Features: AS18NWBj8W1b8VguIoFufUrvIsQUXiGHkQ32JE7FqsyGBasY6kmjvm5a_9MOZ2k
Message-ID: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> +Cc Marco, Alexander
>
> On Wed, Oct 15 2025, Pasha Tatashin wrote:
>
> > KHO allocates metadata for its preserved memory map using the SLUB
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
>
> At some point, we'd probably want to add support for preserving slab
> objects using KHO. That wouldn't work if the objects can land in scratch
> memory. Right now, the kfence pools are allocated right before KHO goes
> out of scratch-only and memblock frees pages to buddy.

If we do that, most likely we will add a GFP flag that goes with it,
so the slab can use a special pool of pages that are preservable.
Otherwise, we are going to be leaking memory from the old kernel in
the unpreserved parts of the pages. If we do that, kfence can ignore
allocations with that new preservable GFP flag.

Pasha

