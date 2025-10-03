Return-Path: <linux-kernel+bounces-840907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6ABB5B05
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E16A3BF952
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7D1C4A0A;
	Fri,  3 Oct 2025 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtGD5UUJ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B941B4F09
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452831; cv=none; b=tSCi1ZIZnuRTBsl0UKurlx9N2tBgtgTFvmQ834u82tBhElcxUJEnsvMDmR5HFQHp9rkQpIWKA7BODpbTdBxy3lls6xuPrOjPMcWEXx23ejZJdZSt2AtJiFNaCBou/qAP8Qu7oQ7TCQYPEr+3CpDWnXsUvkuidAElUWkbVfz9yKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452831; c=relaxed/simple;
	bh=qZpdUj16BCejTHKsOOW/dPiTbIkZGYldC2/13Q6Sxvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+K8a5SGfe7FOHax65KQFlOAEvY4aqy6GH19HI3ty2N28tlyRwVFkMB3nnWCrYlLjH4LZfImXPnw+tYLEANgIwcPeSG00DOxd4NBCRVBpra45grALy7vZ0Xfy7P4mZPOIHghfTyKY0XF6Xe8kWLteSYK/OJkIXe4grIHQcqwTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtGD5UUJ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603a269cso18494527b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452825; x=1760057625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIjyu4CrKVxFW8+yt9bV88mlzHIu8EXyBfp0u4n9wkI=;
        b=dtGD5UUJUIySDvgIySMlxZTjL07mWjDvn+jnQ5u2tJBIKxeJnWooYa7+vu/VZBLDBU
         hUdPiHnyu7zBCrnaopiOwFvfwB4m8gzDjpDZfU5GgKGuXW1IaS4NhEpZjKEi6SIkBdXv
         fvJ+iEyQ6V6S369cppZDaV0FO7Zpq64hH+shI8hUkUOPpBj7qMyBVOek9O+yMFJkxmR8
         C3ZO09x6YgtOOysN7/a2GRUbAAOhQwBV9DlFirqql+qoF/Aa1au/eoOJH0V57FVliBXt
         bDMtOZhemyXnI2Y5VsC6dvNGsRY+JdgE32FkLRsnIofOjghgzdUSZNPPOqZdNSCTzHTS
         +ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452825; x=1760057625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIjyu4CrKVxFW8+yt9bV88mlzHIu8EXyBfp0u4n9wkI=;
        b=KROZ2Vdl/xT+3EVjZ9ffPcfQJHh/8Rt8pYEgqDSTEI4uKku1Ig6K5T+DyYGGK0SHZX
         oQvA5vtC0NFrWg1TC2svUItrE8/f7urZdmMKE4kZmhT9ud3uviobRPmEog/iFBwOUhO+
         /1rxSbEIYDfFWxiYRdICQExaQj5YUXHmPZOZe1AcdR/tydwowPDdjR9dryp+U0cI9UH/
         rSjnUsZdApU5XLHjjmB/b+3CoddpTjcejWC2fNtcuAhcJ9XuOeBZPZpU3xVgtxIpI3pL
         8fsqouq/lt3xY7YkH4XJctT48Bj6iOVAXwcLoIxNBaIcEJ3WG1eEz1Wd6S5pA0s2ki0r
         mE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpfZh6nVZZdmNng+TDC3TUvLJjo6BYrNxbNpC2B41aFEyJO2MHU8Cj0B0ZCzFfhsnSttXRC0LGZMygj9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPrzj4nDhUtqi+PIticDNaxbifXsOJnc94HusBErA8LSE14nL
	1e52+uz0jxpKBNH+c0TyhuKJ4VPLVq6gKu4EnCidLbmCgwjwNoICSufOBoQctPqm/8oLAlKnahN
	N4uqjE7W9V2nAO15u851PvCuZvjnPOYc=
X-Gm-Gg: ASbGncvkLYGaU9eQWbmj2C6xqlwShFfNaMuPOjWMENixF09Fae6nULqSFbQVm7xkIK2
	OsZnVvC7hz3tTF/BK0LCIr3eRiMe4fDPUGuWWu4DTKEyX3cXcn+ABoxmw7IRGOewrhpVw3grcab
	zIZb3o/ciVzgiPjuisS/XEmi0GH22j8CNgoYTQ/LGRMxE9j6PERQPa/DU3nuatfCOmSUfmDuYSC
	hSKHn1bQUgVtHddIPrLjqk+/I9Oc8TBmzD0Ii8IUi2BT83cIPgolyjhZHTwdEul1fOlNDNLotpZ
	WDRaZVdVCmawl+V/D4T1
X-Google-Smtp-Source: AGHT+IHdqvyiXZIG2OFdfIS5se4cN2dqc9rVIfSmO3bgaMv9f7oUgu2QkiOcy9N9WlxLlxEKZMv7ZFtncLqKJpUd6es=
X-Received: by 2002:a53:d151:0:b0:636:d3c3:67e2 with SMTP id
 956f58d0204a3-63b9a07cb33mr1112628d50.21.1759452825478; Thu, 02 Oct 2025
 17:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916200751.3999354-1-olvaffe@gmail.com> <cf530254-b5f2-44b6-b49e-9144898d75a7@arm.com>
In-Reply-To: <cf530254-b5f2-44b6-b49e-9144898d75a7@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 2 Oct 2025 17:53:34 -0700
X-Gm-Features: AS18NWAMUQsGVX85ALNwXjhcZfVyXxJqw58XEv-fAwlcGZnD9yFUHyWgXLbTPQA
Message-ID: <CAPaKu7RK2dW4LYbCj7ksbNJVst+Yn5aetKhJG0N=EyTY8BhYfw@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: add query for calibrated timstamp info
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	marcin.slusarz@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:41=E2=80=AFAM Lukas Zapolskas <lukas.zapolskas@ar=
m.com> wrote:
>
> Hello Chia-I,
>
[...]
> > +     switch (out->cpu_clockid) {
> > +     case CLOCK_MONOTONIC:
> > +             cpu_timestamp =3D ktime_get_ns;
> > +             break;
> > +     case CLOCK_MONOTONIC_RAW:
> > +             cpu_timestamp =3D ktime_get_raw_ns;
> > +             break;
> > +     case CLOCK_REALTIME:
> > +             cpu_timestamp =3D ktime_get_real_ns;
> > +             break;
> > +     case CLOCK_BOOTTIME:
> > +             cpu_timestamp =3D ktime_get_boottime_ns;
> > +             break;
> > +     case CLOCK_TAI:
> > +             cpu_timestamp =3D ktime_get_clocktai_ns;
> > +             break;
>
> Out of interest, what is the use-case for the REALTIME, BOOTTIME and TAI =
clocks? Looking at
> VK_KHR_calibrated_timestamps, it seems that only MONOTONIC and MONOTONIC_=
RAW are exposed directly.
> I worry that providing the other clocks may make it easier for accidental=
ly querying timestamps that
> can't be correlated with driver state. A recent Mesa change aligned PanVK=
 Perfetto instrumentation on
> MONOTONIC_RAW [1], and the performance counter patches I've proposed also=
 use MONOTONIC_RAW
> as the only clock source.
I followed drm_xe_query_engine_cycles without giving much thought. As
long as we leave room for future extension, we can certainly only
allow those required by vulkan.

