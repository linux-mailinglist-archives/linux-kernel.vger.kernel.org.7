Return-Path: <linux-kernel+bounces-866783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79CC00A28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A5419A51D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493A3043AE;
	Thu, 23 Oct 2025 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdKOa3K6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096930C600
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217739; cv=none; b=Y9joic6S0bHxLN5igZJ9LmIoavsy7TspF1Vt8MZe8GjMvLzSnBe4waVFrnMFPikttovoS41uWtS+5YW48ifGmXe6dIE1dxqw8cd2POoH1boqZokSYxx5Ok5Qw7DPZzdw7nyBmBgp3GYhuSPmL7IXSNBSupRG/N/IuuxYMWu4634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217739; c=relaxed/simple;
	bh=2gtsPC5so8y6JlR/LE6EcnMO20S4+I796HirmIgdDJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/zxuiwkcMpe9yVWlDu2B5Hp32coyxrwFBxQRDEhrUPgYJjVhJ1tfQaqUSAO7DU7KPXl6pB4IqLrtOGjqdKaFIOrGFXy0IYygRHPzhGo6LtX9hv4wVWXwZnvA53HLAmDeGUqsDqcK4lC04XdP3Os9JxZ0oAQTWxtPpxePIOAqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdKOa3K6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e12a55270so989506a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761217735; x=1761822535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjVTzYMRUK9px4tCar1m0xiZ+9sd2t0ODPLBN+ZVn8M=;
        b=KdKOa3K6waUkW0GYhOosJkCYGIJIZqrvpfFr6jzNI1/PdhZGq5ilbKjK2XZEEZbTHc
         Cc/LT/mrSSVDE682cRd4WLqCuN3akDe5iQqKbwAJ1L2zaeISF70Tk+kPlkj8OJjLpHPi
         UlhAu6JxbrhBkYTybov3h2fQOdwaXCkAZbDekUBS4NZHspB6eY98cdZonqd4hUrjFVdl
         wjjTynqdzvJukc+HOztd5Sa9PKEZtPVqhcdu+T0mGvV7VYwOnEKKdVV/j7686rJWiyAU
         o9EXG0fGjrT8BaeG9GrRFkEToJAi6d3WwHFN5+PgQvJA3aUc/MKzwXHlKlHUk7bvulS/
         8nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217735; x=1761822535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjVTzYMRUK9px4tCar1m0xiZ+9sd2t0ODPLBN+ZVn8M=;
        b=dUoZ31BtcG/DbhZjN9O4cQ3qWTSGcrE6FngGpbgab8dfBEEoNZ/l6cl6AapjIAei9l
         8LZvwZXY4FgJo9m/HMKyQ0R1JrQurKSldWHXetorlvLuzJY3bg5MiovaPSqRuRna1pEL
         iR0EyNk3USZP/s66ak4rnN8Hs/5y9SYBuRIHwv52wfgPxnKOfT+13PVUVfhiPlWchUVi
         XmVU3mBZOwCeKRgf/eRd+edvscdPlHcxzT/0M+CTUsSDsTQQXTtoV35VWl7JVUySB699
         cFiuV6FERtl2/i4ZEvGbVnT66/kqnAoIF0mFYmAaNmT5XrY3Y4z1AhVjrjDIGZA/kNP8
         pYtw==
X-Forwarded-Encrypted: i=1; AJvYcCXK8C5afL4IjpwBzuX+NCmAjmwAWV+3Bfzk017ZbDpvu3vpICtMtjXKvXo6Qb/6FgD/P3VfYEI5lGmAzSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXZW+0hH2vrlO47GfClV5/Wnv9ZpGQ4DhONYrE/l5riAZa/7n
	TIC8zTKQhB3vi4ox6NKdbpT7QmMaF34Q3ukwDwvq6aMaR8RzoVVP8pPHMqeTPfcdL8zL5shJD1p
	jAmyc+32S9CDGFGar7mW2rJBhrdr3hVQ=
X-Gm-Gg: ASbGncsXxCVKPHJBuaGlvaQvqyE/ZUk0sqtgxpwklK3AU7Qs/vkU+x5mVvlOuU2Cyxq
	zNyFh6gbJowQtg0FuyiNemrkznnzAipz4xKvQ/52d4qTFcsK/gsOecChW0LucbfQQ2l9KMFz9oE
	nq8rKVj0U/ee0zz+mEQCZAa6O/aVqrPsIWo6EI85E2cfk5hfIqO3L0864SuIfZFMfGT9YxUNt4H
	FlK3wY8ZMuulvR/Us1f2NpXv5dPVm81Jxo6YHsrJyzrarDfe02H/fDa1UojAn6V4kSHCBXmjK/H
	o4SUCxXgyKmrcHOaodytGFCXb35vpw==
X-Google-Smtp-Source: AGHT+IHaZkNWJBzwX+xnT6zDyIsd+FpAB6bVyKjHzY4MeJJT61pxMSaC+0svUKX7j1+JJd4Z5fMUP57lUimsGmTU5qA=
X-Received: by 2002:a05:6402:510b:b0:639:dd3f:f25d with SMTP id
 4fb4d7f45d1cf-63c1f631b53mr22704985a12.7.1761217734817; Thu, 23 Oct 2025
 04:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch> <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
In-Reply-To: <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
From: ally heev <allyheev@gmail.com>
Date: Thu, 23 Oct 2025 16:38:43 +0530
X-Gm-Features: AS18NWALoCjfGGgMJQ1J0KTtA-LIrHjubjnnhPj65_HytxxNdk20M4XgmPj7hPU
Message-ID: <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
To: dan.j.williams@intel.com, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:01=E2=80=AFPM ally heev <allyheev@gmail.com> wrot=
e:
> > I would go futher and suggest that the pattern of:
> >
> >       type foo __free(free_foo) =3D NULL;
> >
> > ...be made into a warning because that easily leads to situations where
> > declaration order is out of sync with allocation order. I.e. can be mad=
e
> > technically correct, but at a level of cleverness that undermines the
> > benefit.
>
> But, does this pattern cause any real issue? I found allocating memory
> later useful in cases like below
>
> arch/powerpc/perf/vpa-dtl.c
> ```
>
>         struct vpa_pmu_buf *buf __free(kfree) =3D NULL;
>         struct page **pglist __free(kfree) =3D NULL;
>
>         /* We need at least one page for this to work. */
>         if (!nr_pages)
>                 return NULL;
>
>         if (cpu =3D=3D -1)
>                 cpu =3D raw_smp_processor_id();
>
>         buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL,
> cpu_to_node(cpu));
> ```
>

I will take this back. Found this in `include/linux/cleanup.h`
```
* Given that the "__free(...) =3D NULL" pattern for variables defined at
* the top of the function poses this potential interdependency problem
* the recommendation is to always define and assign variables in one
* statement and not group variable definitions at the top of the
* function when __free() is used.
```

