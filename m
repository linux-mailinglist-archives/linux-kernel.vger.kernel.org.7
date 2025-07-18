Return-Path: <linux-kernel+bounces-737108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EFB0A7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D620A1C8118E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF042E03E4;
	Fri, 18 Jul 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="bcxSDZbE"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3D1AC88B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853155; cv=none; b=C+0gsLj+SggxgWUXeaPV2vqi4PWe/EKIFkIxhbuUiPl6P7IIB91WL2XhMl+M8iQgEVRhMJw3Etemj7Bb+7FAzhZi2NQIJNHbYa1dXgnnqppffcMW8DzkJyKtsOLyrGr3G9JlpAOTloti6E+BdBpobIn08VC1y5TE9bCg+Az+aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853155; c=relaxed/simple;
	bh=u4Z5nfLBl5Cw1vGWXxC6jsaRMg1+lFreKjphkST/lR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhq7q3p+t/0xUP4VmOxHPhdcGUQupUOmrf78NFMFYcq7LA8jGHFPhWMbQvTsw4wf+iADlu3j//lFO2T8867znBzXtuF4jy29J+MRTmsVzz0oHgdXqFwLpr+tgqh/fx7mTF+Kg73vVkK7hP9MHjT2lNA29R2Nb5nnUQTtXudESeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=bcxSDZbE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e75f30452so15216987b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1752853152; x=1753457952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygjySUgNqi8YpdKC1VWD+1MlKg3EqliUtfUJFmwdHo8=;
        b=bcxSDZbEUJ/jVKlOXbUz9GeS2w0SCHCzLnR4+4yo+7QydR5hHXbbAA4yqlVHX0v4XW
         nZxS8T9dUDV8dB0PYYNvQuIXGYAboRcWWTQyk3FXK162MYs1DoDRG/WjELSb/Rl+4mTC
         bZ8eMRRjh0F2eI8kCTlVLDJzSKUyAlBqxs98KgIup2UiKbPTfc8o0SDUJCDQWynw9DgY
         +IBbXr3OUc8UqnvMfnDR+cHa/8R37eBiPTE+QlgHZrCTrntM8nHiOaUjVY/PDBOlPK36
         QTZBebdklhUO8/bYvPRXWjgB1zoC5PNIlaDEbrdw8ZozGGhTROdf7LSEen8nhpeMGLN1
         AnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853152; x=1753457952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygjySUgNqi8YpdKC1VWD+1MlKg3EqliUtfUJFmwdHo8=;
        b=mYBzWqPCAMbW9e9J7HhaA9BDx6v/HsfDXOn1EXTnBSpATeibZ7DJDlpGIlKPRabAQU
         QJiIjbFV0+1WXjEV5HjOdocyKd1gbDFSWxUrNZEPEurSTu0m3I9xGrX2Q2IYXOKAc/aF
         6ENox+UqUoc8jpho5FrYD5fdqsBQg3BoOFmknlcVoTxUVBihsa6BZ0G3ZfzThZj8erlg
         /TKWKwvn9VzhzqhDCax+OL2RcD20ynONF2fiUtT7/qmGS/DmGytlDAR9+EW3fu6z7Ov2
         Ba9zJ+equjp7XbNO1+fnoFFh1vFww3nG12jVfZPVuPO0K0WJYJMM9cW/KZuw9ZuYR7dT
         QxXA==
X-Gm-Message-State: AOJu0YxsdWhouypDQESi4kJw2lN7nwoQ2fZr6wsqDzFty33f2TAWPKPa
	uNmRogiyNUVFM5Q19b5N4IdSrODv7y8VtFjK6jIsn+6brFKniiDmB+Iq655lixYP84C+0DuHX5Z
	8DjwfPzizjkqZpNQ8mANTHxg6fdO2MUy0ghtgIbX3MA==
X-Gm-Gg: ASbGnctzmka4NJpr75EZvrz5hfXEdSF0khKz5FYGdyBPD0F3WBTo8DmEECwhecL2YuV
	8zLq8a8rD+B/MqiBiRcXsJczzKC6AdlWSGnJPnd968QdNyEik8N64DRFLR3jKbB8+8HSb5ti/Mx
	mdiO/Qt3eH/DAMktVTNL1tnohz7u49UzmF9lbHNOOpSdb2ZaoINWuyuxigPvYZQYc/NKlU2IxXb
	Nx6zYdAWJEqE4oSLJMf+G8=
X-Google-Smtp-Source: AGHT+IELQx2l2Rl3OV1bHE4qjeFwoDUK8cpeFZAYu8esFCvSpzIsy6ROy69M5cDYLPeqgmYq/lHCWrosdKNFPOvRKI4=
X-Received: by 2002:a05:690c:64c3:b0:70f:88e2:c4ae with SMTP id
 00721157ae682-7183517be47mr168923957b3.37.1752853152390; Fri, 18 Jul 2025
 08:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143332.264997-1-matt@readmodwrite.com> <20250714163850.e58dd109d4c9e0d191995405@linux-foundation.org>
In-Reply-To: <20250714163850.e58dd109d4c9e0d191995405@linux-foundation.org>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 18 Jul 2025 16:39:01 +0100
X-Gm-Features: Ac12FXzXa-btt11E7ckBN6SXwEjcspFxLoZyLjMVbnSiIAx6OF9WtcwG7CsGwTU
Message-ID: <CAENh_SSDNyGcuE=yL9GEt9gTWY+2BepVj1s+x60CthD7-HGp2g@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: Make max number of pools boot-time configurable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:38=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
>
> Geeze that was all quite the mouthful.  Can't we just do this?
>
> --- a/lib/stackdepot.c~a
> +++ a/lib/stackdepot.c
> @@ -36,13 +36,11 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>
> -#define DEPOT_POOLS_CAP 8192
> -/* The pool_index is offset by 1 so the first record does not have a 0 h=
andle. */
> -#define DEPOT_MAX_POOLS \
> -       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> -        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> -
> -static unsigned int stack_max_pools =3D DEPOT_MAX_POOLS;
> +/*
> + * The pool_index is offset by 1 so the first record does not have a 0 h=
andle.
> + */
> +static unsigned int stack_max_pools __read_mostly =3D
> +       MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
>
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata =3D IS_ENABLED=
(CONFIG_STACKDEPOT_ALWAYS_INIT);
> _
>
> (please add this to the next version)

Nice. Will do.

> (but why do we do this min() at all?  Why not simply use (1<<DEPOT_POOL_I=
NDEX_BITS)?)
>
> (shouldn't that 8192 be 8191?  Seems oddly inconsistent)

Yeah, I don't have a good answer here. I was hoping Marco or Alexander
would chime in.

> If user hits this they're going to tear hair figuring out the actual
> limit.  So how about "stack_depot_max_pools exceeds %d, using default
> of %d".

Good point. Will fix.

