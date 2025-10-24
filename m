Return-Path: <linux-kernel+bounces-867982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7FC04101
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E868188C30D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA281E47A8;
	Fri, 24 Oct 2025 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwbzwW2f"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1D1E47CA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271004; cv=none; b=o7MAHj2ggdPeYiIRMXC9B6RqQLYJlmPW0WI4Eek4yteUGjhT9GqSSje5bi3m70ZO9RVMfWX3Dufuq/aZ8ur+p9mF9WoJzXZjja1PwbOj57XeuupwfGlmJPo7b4XgHq49bqI3oT4ssU0N29blm2v/mKfqXN9ZcSPddEwHfNnhJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271004; c=relaxed/simple;
	bh=Ax8jVriTeOqqfQC9Vr39bqUKOZgnU715FWf5Nl9i0Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYJGaVoRNXIkY4jPvSZUQu9qqMs+nfbtZF3WwhRtIF83qIFArrQnlUkbwB0TGwtyruSritTYFb8WOuU/yEg0pRn9PZFtNUTfmcqiqLLanDrB+3MnPaChXeK74kePsMsYZnpiCOL7gEkc/a111fE7ypm9UmhtoR/KSTBgOz8WyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwbzwW2f; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5db221488bfso1706166137.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271002; x=1761875802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3wXd6gCAHDSdcT184SwaO/DYF8T98vh52YBZMXknyg=;
        b=mwbzwW2fKu4RUEkODlZH/XwKTCfpucRTB4PiiH2Bd2CvzGjAp1ev9hQ/B+En62Xtrp
         Mxn7je6p8WUbzsvMSLxGHscxx5tlsTIfUJXS796QWiUQyyrgEIcj3KftVfAeAEy84dMr
         o+GzmOr3+oRyiFoONJmB/4phEPUIGcQdEKyPfdupnjjwZ4NWQrQwHW7OEvn5TOw4Pv3+
         unFvey1sJ6hwlD2VyO+KYhqHtslz60atCaCfhUa/s5EJeIL5pU95TfJ3PQz8j+ScQEBT
         V/i2bvVDT3JKA2M++vFO8Z4qRTe26F5r5qnAkyMImK9BUZzYJBd3xu1djm/sJpSQ4QNf
         PJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271002; x=1761875802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3wXd6gCAHDSdcT184SwaO/DYF8T98vh52YBZMXknyg=;
        b=MXStw/Fh2Egy4jZpuKo9pw/WF37zIS0JLs7DVbafX9Fk3qtmMk0IngBw4NyjoIwzSr
         EswxDiblLzkZP/0Ozq4vlakVgg1sKVRfRTkvP6gJoD+gXxjKapb3mEnMl7dAAtXK4pvL
         nuiA0ZX/fvzq3CXj9dcs4UPlrFV4gmlYzxQGCbjX1Zqtee1WwSwiUAYAYvCCIS9I1Fc5
         +gpPaz+mDiCx1nz/xVxi+U22+fvJnnqVwb5ZHUDgSPOB5uEhPh3Nw7weDKMLpKiL2Tac
         f7HmNE9Iw5anJY5EQtshmsPovH6ZH2ez+dUmPYwitRuYxfIGlr5DnIuKIPIGdKKubl7V
         8YCw==
X-Forwarded-Encrypted: i=1; AJvYcCVzQMfTE6ULDR8bQe59Sp8rhH0rRPa4CBU6l3GhNSk4HoTkbBWVpq9L7JpSPp/DcfRzdqAQk58N4gRU5Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlZ/kh9lJ/U5OLn0N2ZIsz2cPQ6aKTjuV/MHAcC260H60VKVb
	s3FiG6EIytUXpMeAuMrfdY0gC+mjkflLwa60xc4uNuWsBFaUZUUoMNKfQQgen9we990HBwfWnvJ
	vH9S2ix4OOAKyVGtmdv0MOMdqG6hZKss=
X-Gm-Gg: ASbGncvvMTDXK7OpqVq5VaT0y16Jv2cnj0XKu+XJ7Pdk7HZUkw2V7d3DMp7rjdsa98c
	Zc69IrIl6wNlpK2QxlcfsdZiIKZGy6wJwjglinKKpXzj1xntwyphFuwCqpwqWbZOWvDBrag6zzo
	eZEQNly8JG57NtkXSfAslTo01skUHnkhXUtcmHHzaKv+oOdncD3tdkJvY/ixpteG/mmw3imsAj6
	UiGRA8UmicnP+FGpdA6h5fx3C0yQ1vwDeRAjJylMkpsTDgZLvUIBnNl6f1R17IStaUIwvQXx0Lq
	jERZ9XdMPi1FNrdBfPJf5zJx+4Mpqw==
X-Google-Smtp-Source: AGHT+IGZqTPH/RBOw7fnpSbszzrTIc2/2WIbGOyXrK2o8Ptsd+0ZdioAaS7bZPfKFwDfzMuMlpO2/ngAh30y/Gx7L/U=
X-Received: by 2002:a05:6102:508f:b0:5d6:12fc:76e1 with SMTP id
 ada2fe7eead31-5db3f8c5d89mr162595137.17.1761271001978; Thu, 23 Oct 2025
 18:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com>
 <aPrLF0OUK651M4dk@hyeyoo> <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
In-Reply-To: <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 03:56:29 +0200
X-Gm-Features: AWmQ_bnZfgWxvUlSV_cSyZkt3ycyNMFflOIinUoHSDKlFI4Ch_9TGgYATVsEHdg
Message-ID: <CA+fCnZdkWnRpp_eXUaRG_HM7HSDm4fLATpsqJhaxT_WGjhOHLg@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Alexander Potapenko <glider@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Feng Tang <feng.79.tang@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:19=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Fri, Oct 24, 2025 at 2:41=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> =
wrote:
> >
> > Adding more details on how I discovered this and why I care:
> >
> > I was developing a feature that uses unused bytes in s->size as the
> > slabobj_ext metadata. Unlike other metadata where slab disables KASAN
> > when accessing it, this should be unpoisoned to avoid adding complexity
> > and overhead when accessing it.
>
> Generally, unpoisoining parts of slabs that should not be accessed by
> non-slab code is undesirable - this would prevent KASAN from detecting
> OOB accesses into that memory.
>
> An alternative to unpoisoning or disabling KASAN could be to add
> helper functions annotated with __no_sanitize_address that do the
> required accesses. And make them inlined when KASAN is disabled to
> avoid the performance hit.
>
> On a side note, you might also need to check whether SW_TAGS KASAN and
> KMSAN would be unhappy with your changes:
>
> - When we do kasan_disable_current() or metadata_access_enable(), we
> also do kasan_reset_tag();
> - In metadata_access_enable(), we disable KMSAN as well.
>
> > This warning is from kasan_unpoison():
> >         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
> >                 return;
> >
> > on x86_64, the address passed to kasan_{poison,unpoison}() should be at
> > least aligned with 8 bytes.
> >
> > After manual investigation it turns out when the SLAB_STORE_USER flag i=
s
> > specified, any metadata after the original kmalloc request size is
> > misaligned.
> >
> > Questions:
> > - Could it cause any issues other than the one described above?
> > - Does KASAN even support architectures that have issues with unaligned
> >   accesses?
>
> Unaligned accesses are handled just fine. It's just that the start of
> any unpoisoned/accessible memory region must be aligned to 8 (or 16
> for SW_TAGS) bytes due to how KASAN encodes shadow memory values.

Misread your question: my response was about whether unaligned
accesses are instrumented/checked correctly on architectures that do
support them.

For architectures that do not: there might indeed be an issue. Though
there's KASAN support for xtensa and I suppose it works (does xtensa
support unaligned accesses?).

>
> > - How come we haven't seen any issues regarding this so far? :/
>
> As you pointed out, we don't unpoison the memory that stores KASAN
> metadata and instead just disable KASAN error reporting. This is done
> deliberately to allow KASAN catching accesses into that memory that
> happen outside of the slab/KASAN code.

