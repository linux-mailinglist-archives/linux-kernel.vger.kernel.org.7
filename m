Return-Path: <linux-kernel+bounces-892078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09CC444C4
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161721887131
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815C21CFF6;
	Sun,  9 Nov 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEtLrUVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F517082F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711250; cv=none; b=BMsVCr9bm0+P6S5Fh3kuKn0s2AGbNH2eq5TFV2a6LdWeJr0yg6sCnPCAJT44+RJI1O3jn8gmjVESR6X+WKlCfcgyLG5FC4MmlQ8Ms+AdhPFO3Y3e523UBDVVogchNcQDfh3q0h7QlFMken4IzhK9gX+S01n9fjvYvlaKuDfhR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711250; c=relaxed/simple;
	bh=ngdJsBUltnXHKi403aGstSmuPBJQqtJoMuxj+Ue+A6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsYRwrdQCToHYPT4DDD7WGKsks72ffjmk9otEV1VC/8ULJh+0rqIet7m+XVkP9H03IWtuoWbNk792OoOU9BulQoj58ZwSZWixQUWdeDvr/O1E0Fs25DOrzvHEUty+ye0pbqMxqyXeYnKuo1f4LsMLuhPc43Hg2aGftqFfV6NjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEtLrUVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AB5C19422
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711247;
	bh=ngdJsBUltnXHKi403aGstSmuPBJQqtJoMuxj+Ue+A6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IEtLrUVtHjEsWm/C8MwdyhFG2iNPErdYRKzlSnY0aHAnuSWvL30RJ8uWSliWKCy66
	 kmVOeRm5P53gNocD/3AlaVK4LGuI/bcPlRdwlIoHuE3g8Xaa2p+e9/zA7IybZwuHlA
	 dt8PPtdUDmJC5fs/SEvsR/cfKqyN+MfLLPpK9+TK22GzFx6cfENsx2DPpsEC9Hyli1
	 iJtrzkI7piY/HfuVhtJcKkoCJCpjNtjY9DO1IUu5UK68f51+vQk3AbZlecPmlD0g5x
	 XVbSaJMl0u/OUqVGzC1NuuuG/zSZTIvkAZVfhsbDZ0dE/n7G2C2iCqjGimUdCV7Gkz
	 sWypYnNvO6ANw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36295d53a10so18152351fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 10:00:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY+I9ZAB8v77Ahp9IrTof2wppaEvmo0ZRKr8vtFVe821HDf2aZ7/8cO2hG1CTTN9PCnPX84I38o7sS7ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCryshe3kMAgQrzV0NwoQ6FoxN2nsVCT7CzIxDpKnQ7FOZACJh
	/rtHuoq51NzxfZkycmbfAgDU9Z8w6CeP8hseeLXpZN80ircQROXOhfBv0DzHFpkoiUkCMC9NgJD
	Xh/DsrJFjnT/eUVcroWjB/hFl+NIiA08=
X-Google-Smtp-Source: AGHT+IGzG8az736Ek/PKuPSVq9csQ+w8E7LVXJkHwNGCRjuZKzNqUTVu8H4LC4w4CqlfLzKUtK6ospJSS6Nc+qrcLqg=
X-Received: by 2002:a05:6512:3b1e:b0:594:4e5f:a224 with SMTP id
 2adb3069b0e04-5945f1dd5eamr1509661e87.39.1762711245529; Sun, 09 Nov 2025
 10:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107164240.2023366-2-ardb+git@google.com> <14ca1b28-df1d-4065-ad7a-97a3ff81a5a4@ursulin.net>
In-Reply-To: <14ca1b28-df1d-4065-ad7a-97a3ff81a5a4@ursulin.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 9 Nov 2025 19:00:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgfykaf9oB4_tuAQqwXDN+NLy_Hb_+RnQmeicVgKt0bA@mail.gmail.com>
X-Gm-Features: AWmQ_bnvXvdUhRjp81oyBi2v9d3FvXVwwo8Xw1qggdpFOcTX930itimlVJwIpKw
Message-ID: <CAMj1kXEgfykaf9oB4_tuAQqwXDN+NLy_Hb_+RnQmeicVgKt0bA@mail.gmail.com>
Subject: Re: [PATCH] drm/i195: Fix format string truncation warning
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Nov 2025 at 01:27, Tvrtko Ursulin <tursulin@ursulin.net> wrote:
>
>
> On 07/11/2025 16:42, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > GCC notices that the 16-byte uabi_name field could theoretically be too
> > small for the formatted string if the instance number exceeds 100.
> >
> > Given that there are apparently ABI concerns here, this is the minimal
> > fix that shuts up the compiler without changing the output or the
> > maximum length for existing values < 100.
>
> What would be those ABI concerns? I don't immediately see any.
> > drivers/gpu/drm/i915/intel_memory_region.c: In function =E2=80=98intel_=
memory_region_create=E2=80=99:
> > drivers/gpu/drm/i915/intel_memory_region.c:273:61: error: =E2=80=98%u=
=E2=80=99 directive output may be truncated writing between 1 and 5 bytes i=
nto a region of size between 3 and 11 [-Werror=3Dformat-truncation=3D]
> >    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u=
",
> >        |                                                             ^~
> > drivers/gpu/drm/i915/intel_memory_region.c:273:58: note: directive argu=
ment in the range [0, 65535]
> >    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u=
",
> >        |                                                          ^~~~~=
~
> > drivers/gpu/drm/i915/intel_memory_region.c:273:9: note: =E2=80=98snprin=
tf=E2=80=99 output between 7 and 19 bytes into a destination of size 16
> >    273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u=
",
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> >    274 |                  intel_memory_type_str(type), instance);
> >        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> >
> > This is unlikely to be the right fix, but sending a wrong patch is
> > usually a better way to elicit a response than just sending a bug
> > report.
> >
> >   drivers/gpu/drm/i915/intel_memory_region.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/d=
rm/i915/intel_memory_region.c
> > index 59bd603e6deb..ad4afcf0c58a 100644
> > --- a/drivers/gpu/drm/i915/intel_memory_region.c
> > +++ b/drivers/gpu/drm/i915/intel_memory_region.c
> > @@ -271,7 +271,7 @@ intel_memory_region_create(struct drm_i915_private =
*i915,
> >       mem->instance =3D instance;
> >
> >       snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
> > -              intel_memory_type_str(type), instance);
> > +              intel_memory_type_str(type), instance % 100);
> It's a theoretical issue only since there is no hardware with a double
> digit number of instances.
>
> But I guess much prettier fix would be to simply grow the buffer.
>

Whatever works for you - I don't really understand this code anyway.

> Also, hm, how come gcc does not find the mem->name vsnprintf from
> intel_memory_region_set_name?
>

The optimizer works in mysterious ways, I guess. I cannot explain why
I am the only one seeing this in the first place, but the warning
seems legit to me.

