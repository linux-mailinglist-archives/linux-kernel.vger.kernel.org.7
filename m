Return-Path: <linux-kernel+bounces-872744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E547C11ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63BD3B0816
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB82DAFAC;
	Mon, 27 Oct 2025 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psMW4bpZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FF145B3E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606129; cv=none; b=u2n6758Jjukt1FRFLpvjqP3GdMcn0C3uz7JQdaCf4/CHm9pdAYv8glmvsmRkdqaDlvLKWwTs0dMJ2c15bSB2P15/xIBgxCpajeF0wI0VgFPtVcJIbC03h31pjYkpIgpYxCrskMWSft4eRLpnNrkw6FouZAvtSYAFomYUP2OqYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606129; c=relaxed/simple;
	bh=xcuVr/XJUPvW7oJnUWQelTHjgQSkL9RaZe/Yc8fW13g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVQO5Dr1/zCyweKKpLMbF2YEeZue4rlemUUgbU6Jmtd2iNTUrxi9emKAMdV4iNOOdBO7xmaUhovmiAgZtqFhRfGc1zrYPmB6n2XvIqjIeOYgc7B7YGS/1nA4QeshpquNYf3ZrDoUofu8XIFAgmUeCIKV2by6FyCMW5G63TVhFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psMW4bpZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592fb80c2faso5796153e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606126; x=1762210926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDZ/TlV/FeucZp/wZRQgeCBquQKMH6KaEcJwGGGd3/E=;
        b=psMW4bpZGMhtee5+lUxfVRnwyLy2mQ6KJTt9JTwCWZMgqKoa1w8nnUiX6OFpsiTL4m
         wRzCZ9wdFJ75NVGvE20+ZBf1dr+Y2MENyPvBbOhittyBfW8mkcP4VIB3KylKHL/TA8+K
         siNzM/ujOcaX7+M7cUV7vu55egYT3hLqPooBttluepSQ+kBdiesm3iQo8VqsvWDoY5xJ
         QnH30ok2rkdHHJNrfSdWLqHbeBNlVe0U0CoaHSrx9qP5+rGT6WB9UVuPVu0+U2UZwC72
         K96+6A7ts/KkG9D0q7UerhZFm+x+DX0rFXkzlXWGkRiDYtB/NfCa9V2PqH9U+CUF92Kn
         VCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606126; x=1762210926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDZ/TlV/FeucZp/wZRQgeCBquQKMH6KaEcJwGGGd3/E=;
        b=M3iEq0GOcHd9NlSU2NZonPCzOM8f5/sjXZvUIZWRB7D0apd6Uf3QaHW2ndDrl5cpno
         r+BNtXFaf71kl0xKC8HGrJJaRyaGKS+SG1f5fB0TFepy9HqwtHXmR1ztVHjJ2iAaLlto
         r2GnycXkYxN6zq6IzY5UyK/ZUmvSwNWhSMC4k4vx2vK9u8E+YQYeTHYV59DcLrCl32fp
         nBkF7QyVYu/oaZAaHOMChd0JDRaTZRRWsbjt49GSOMUanHQlIbMJRewtvUgC8Xw1YmUG
         K6Hev0jRyB5kK8Aq9RQp3aW2A3CdEZZn8FanGRCREbN7YVRZoHSntu7S767jU2LzkaSc
         GKyA==
X-Forwarded-Encrypted: i=1; AJvYcCWMroiK8XfKkjjzpziAABRlm+u4iTZqrYgDtX9tlVmB4FEfnow/aZ6y1lSZ3I24DddOfgFqW28LNRAfGas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF2lYHWVHf2ulaHABdNeSq0/8PoSeF6rro81ih8WLQH4J3HFy
	dEj2d4lgYa5AV5jiGX9YzdQGI/RO8KSi8S/iG8qOrWXtr+WnI77gQUg41D56tYAGQ7NDuv7zm3F
	fVI5vH6cb/EHAhYJiY0FkGjZN5tHCY76zmZOgSxTm
X-Gm-Gg: ASbGncv4TmfoO2DRcepcak/Qin896i7T53zY1VUlRP59+/rRNUsc5kvL9RTFxrrAQxk
	w1jg08YoUyG1jII3MRnFOFO0ZOb5+6VXLmibQNjiLUPOQftuAq8S3lWb32AYacgd47T0mAb8o0p
	6PSHJHuHsgzsdrT8EwmfDoTZeYWVRrxgjDNJ6C9yjleZlWxrF/XuFFneJpuIGg3juOaBdSB1ASt
	dcsFHsUP4Fkjc81Gtd4uqzniXl8F6X0G9BQ1yM/MsHoMicfV/rQ8iZnNy1pxRitvJiLhpwCtxi+
	JShtpw==
X-Google-Smtp-Source: AGHT+IH5GGO/QRS3unyVKP+J5rFOnjCyksUkPYUrD/2ThqVKsfIz142MePftEnso0rQ9MPp9qjMcov5TDkuNjuvVb9A=
X-Received: by 2002:a05:6512:350c:b0:593:f7d:31ae with SMTP id
 2adb3069b0e04-5930f7d328bmr191178e87.13.1761606126061; Mon, 27 Oct 2025
 16:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-3-pasha.tatashin@soleen.com> <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
In-Reply-To: <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:01:37 -0700
X-Gm-Features: AWmQ_bksoC09_xtubL3fsrVqg9KgYMffT0YmnVbt95BNOWTR3CmBaoOZ230HE-I
Message-ID: <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 3:56=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>
> > -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, =
size_t sz)
> > +static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
> >  {
> >         void *res =3D xa_load(xa, index);
> >
> >         if (res)
> >                 return res;
> >
> > -       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
> > +       void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> >
> >         if (!elm)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> > +       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
> >                 return ERR_PTR(-EINVAL);
>
> Reading xa_load_or_alloc() is a bit confusing now.
>
> It seems very generic (returns a void *) but now hard-codes a size
> (PAGE_SIZE). You have to look at the caller to see it is allocating
> for a struct kho_mem_phys_bits, and then at the definition of struct
> kho_mem_phys_bits to see the static_assert() that this struct is
> always PAGE_SIZE.
>
> I would either keep letting the caller passing in size (if you think
> this code is going to be re-used) or just commit to making
> xa_load_or_alloc() specific to kho_mem_phys_bits. e.g. Change the
> return type to struct kho_mem_phys_bits * and use sizeof() instead of
> PAGE_SIZE.

I see that you replace kzalloc() with get_zeroed_page() in the next
patch. So the latter option is probably better, and maybe move static
assert down here and use BUILD_BUG_ON()? That way readers can easily
see that we are allocating for struct kho_mem_phys_bits *and* that
that struct is guaranteed to be PAGE_SIZE'd.

