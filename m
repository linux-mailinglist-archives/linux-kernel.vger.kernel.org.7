Return-Path: <linux-kernel+bounces-819845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B64B7F8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4AA3B080D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6721B9DA;
	Wed, 17 Sep 2025 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7vHGSvo"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5901C3BF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072235; cv=none; b=SRXdfbzJkMg80VKVM5a41Lrw6/LrbkJNEnT93yy3zmPN7v4961qBSHV7sX6wsTWmtlakOCwCqPqqIod6oVmvFa70tmnI+XEF3ov4lEzLVTjHI3Y9tRcLjqzB60vVpQGMmWeqaoL/b7bY8UxklvDS/fgBGeBtplprwm8Tl9wZ7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072235; c=relaxed/simple;
	bh=QWnsGJ1s/Lz5BUEbCh0/Cw2CBOf39FkecjwzUe77t4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTQjUwbehddehRHVZf3oVB3OSsj6l3M1ir44yuF+RRVEoNr+soVQRhNU2QrP3GBdiuQuA5A0F1Z53NM16SFnuTBzZ1EgsC2hWfF0Br1Z6GgYbd5zmAotpYiwh01gqIsEIer4rWReXRRD7pN1zd4L/YMRBHKRbVV/n9f4BctdYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7vHGSvo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b4bcb9638aso271681cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758072233; x=1758677033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+EiXNx8dtxz/+fZsWvTHPG1d2wMczWl/IjgW9ZTzZA=;
        b=u7vHGSvoq6wgJtFw6LGoPTAlSGw+dVlxAEcWK2pDalxK4WxUDbFfdLt/FVDFOeb0We
         TUCFR1kZ25d4UwjVHw1zTm/p58CBd8jlDceTmuHf9wEph6wWzaBONsJ6HSTHrnx3LAKC
         ZB2RhA76LLXsFqq+jZ3Y2I+qDM8cj0K5KdtnytjvQYVrWJiqqMMhIv6NB5YMB3YKX6os
         QmY7R1BXzJUxGPgw1Igv1Ob2prI4eOJW2RbrmlhjvN7b8pyYY1u9mU9iUysnTf3z3Kp8
         HrWcpuM0WXwOu6v5vWMUVuRLr3KQla4ONed8RCUDUw496sg25524yWQudzFPsZREAzcM
         y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072233; x=1758677033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+EiXNx8dtxz/+fZsWvTHPG1d2wMczWl/IjgW9ZTzZA=;
        b=MnirSJk4JFdmmTvT4WkeaHBbMtJH3zzyaUO0eRXnYbKleVNBJoK2Vl7yd0CUQuylcD
         IGbJ39UEo14hRUVI0ScaenwBSxbVzUDgk5ifV620Guq5bQf9LEQrUuuJnqwKZP/Ln5WE
         z9/8f/46wO3J4Kp3F0lA8kUkPwytPvU5z9oM5LUYcK+ZzNiAUF9/4a3KnD6f/w09zglv
         qbTt+lL9/Xc5VvDk+VyksmXfG3QAkNCzKGiX3ZgvSZ8U/lLaeXM0EYS2MiblOXGWFJ49
         hzJ9pM+K0dEr/VQhGFn0eO7o+Ue4g4cYEhPvLTL/fRyAUxw2lgzBLeZEbGH0ROfMfiHH
         fI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXK973QDjii4OkFK3VXWk6uSk/ymfVFYtP+fFVsaro18cWJcVI18STe0zWeAKMLWcJcvhb4sokS4T0eWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpY0LLX3x9aBDWvHxnl1mzlnAv7ferBW8tVxFHOyozrTyv6yA
	z1ES0w5sd2aCBKHkC4aNzRseULl0tvMWN0Tr9AH8s7yVpqPEzpssOzkVCF3ax1tT4XbXmNuGzj8
	YaVqr+1PFl7mTqDDYDlFq9akMpoFkOaRLJ2o+B8So
X-Gm-Gg: ASbGncsYMKzs85ZOWAbKhrw1KPdMj6GafBp/7lRz2pd6/nzI/Yhv6SpIC5ox09Q7Uqv
	OjMmkWBybCRlbAsTSTA4AHTog+L8E4Uzfi6NNKiX5I8KfQMBOFB3Oqd9XQKJ1u9XdllrBHppEcs
	4QJuote/99T3HQJYlu4gAL6rg9xhoPYXZsxlrJ22CQ/lfPVdzRw9PJhTsZ5qAwV3m2kfeTzf6Lg
	yILDM4H03eNPkBmU6/3z32oJ8+hPlQi1e/gEBQLjiTy
X-Google-Smtp-Source: AGHT+IEGfbNLdY9Zz9j0iuWs6cvtGYaYD+/KMgA+FTecFBbknYC9JaklpTiRGCZw+lM+O/GtymNn4cMAIVCqy8k2pLo=
X-Received: by 2002:a05:622a:24a:b0:4b7:a203:259f with SMTP id
 d75a77b69052e-4b9d8d7db1fmr3405451cf.6.1758072232605; Tue, 16 Sep 2025
 18:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160110.266190-1-surenb@google.com> <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
 <20250916175639.2368772636d5e543faa5b13b@linux-foundation.org>
In-Reply-To: <20250916175639.2368772636d5e543faa5b13b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 18:23:41 -0700
X-Gm-Features: AS18NWD0xD4IiCMhfB84LnzUSUy3Z4XU6JKVgWEYvfvpM7oqam2VIITG9wpTel4
Message-ID: <CAJuCfpHQMcGJBu=qjN6Qy0XqmLikqeWfm6SW+S9orOPk=m21Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:56=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 16 Sep 2025 21:50:51 +0100 Usama Arif <usamaarif642@gmail.com> wr=
ote:
>
> >
> >
> > On 16/09/2025 17:01, Suren Baghdasaryan wrote:
> > > Document new "accurate:no" marker.
> > >
> > > Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters =
in /proc/allocinfo output")
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > > Based on mm-new
> > >
> > >  Documentation/filesystems/proc.rst | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/files=
ystems/proc.rst
> > > index 1776a06571c2..17668f82ff1c 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each lin=
e may contain additional
> > >  For example if the counters are not accurate, the line will be appen=
ded with
> > >  "accurate:no" pair.
> > >
> > > +Supported markers in v2:
> > > +accurate:no
> > > +              Absolute values of the counters in this line are not
> >
> > s/values/value/ maybe? :)
>
> That's OK as-is.
>
> > +              accurate because of the failure to allocate storage requ=
ired
> >
> > s/storage required/memory/
>
> Sure.
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: alloc_tag-mark-inaccurate-allocation-counters-in-proc-allocinfo-=
output-fix-fix
> Date: Tue Sep 16 05:53:33 PM PDT 2025
>
> simplification per Usama, reflow text
>
> Cc: David Rientjes <rientjes@google.com>
> Cc: David Wang <00107082@163.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Sourav Panda <souravpanda@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Perfect, Thanks!

> ---
>
>  Documentation/filesystems/proc.rst |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- a/Documentation/filesystems/proc.rst~alloc_tag-mark-inaccurate-alloca=
tion-counters-in-proc-allocinfo-output-fix-fix
> +++ a/Documentation/filesystems/proc.rst
> @@ -1016,11 +1016,11 @@ For example if the counters are not accu
>
>  Supported markers in v2:
>  accurate:no
> -              Absolute values of the counters in this line are not
> -              accurate because of the failure to allocate storage requir=
ed
> -              to track some of the allocations made at this location.
> -              Deltas in these counters are accurate, therefore counters
> -              can be used to track allocation size and count changes.
> +              Absolute values of the counters in this line are not accur=
ate
> +              because of the failure to allocate memory to track some of=
 the
> +              allocations made at this location.  Deltas in these counte=
rs are
> +              accurate, therefore counters can be used to track allocati=
on size
> +              and count changes.
>
>  Example output.
>
> _
>

