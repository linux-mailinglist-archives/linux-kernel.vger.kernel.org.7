Return-Path: <linux-kernel+bounces-887689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDF7C38E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE97189A9F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0F1D9A5F;
	Thu,  6 Nov 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1MIfbSH"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C981724
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396448; cv=none; b=ek3wQkOkOXz6x+I8WbEaDAk4zcbUHQ1/uFARZD/9CiIHI8wMFgWleyZxcWEWyzIAaGzd9XhPWOHGvkfddAIKqZjSDV5hPUqharH9WfkPHOWNGhSm7p2NUhRGslp9DZ3y6eRfHOImms3qrQmXjFXGQQSq74aoiuQv977OfW6EoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396448; c=relaxed/simple;
	bh=eT7eRw9/5ISp15CGBzCrhGE2pmdJMgXW2DzUMkcebuc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jc7WH/aCOp+jedvrQ4hXeKLaWyTB32PYSlygQptdY45J4EwNENSM3sDrYPxjpJFGo6gtV0Y3oIBkLoWw+WzbApdGmR7IxYZDWSiKd3aClLsFjhvpm5UrCkVSvF+4kEGIiheek6XNADrxM+cfecuG4quh15HM3D5dydVBzyuV+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1MIfbSH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b22a30986fso42899785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396446; x=1763001246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eT7eRw9/5ISp15CGBzCrhGE2pmdJMgXW2DzUMkcebuc=;
        b=I1MIfbSHEtWLt92WYselyG3enw0lCbWGm5zVo3bqZZRprmNAT/an1j88ePAk6vTeuG
         roE510a5MLDMuD+RoPQuValtciB/8RAA+GObkbLLe25UhJ6WS5NyVcElES9dNRfRA8LS
         3gEUxUxaODKOgG7uuMXDHIfiHmgBR0TyvcZ5CIL5E1vYqmbp0QhGUGysRRjZ4Ka0daJu
         UoyNhWca63euH59vc92+wW+ZWY1A3dp3nAeckODGm+g8JReAO8g7BdYi/dYN3lJ2RZDx
         nxos06fmkrBOJZfsWIPWko76AicNnxILkl9/kMisbLWgZQuyDVPUeUUvG/2H8vj+aLFH
         X9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396446; x=1763001246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eT7eRw9/5ISp15CGBzCrhGE2pmdJMgXW2DzUMkcebuc=;
        b=X5yOSgdT2bdGOo45droqhyYlQR5+zGbbr3Vk9dMwGMfZQ6lEv8Yd/oZOjtrWcImsGy
         66J8ymsgSQHcpWVZkZjIyHaqk2TlrgS6QxRskdVXE3L0XH3hN63Pyov0f3E8v46DBIpv
         j0kZDv4wAFdk31gqR71TUWYmv4nABMN5f2ZmfYZ5oA61x4Oa/+PVROA9Ir+XiYLxjvBU
         WX7yexQAfRQ9pzk3cRMFcdKM9spimGnAMdpT+I9ZEN66I5COrh9d6Bat9RpUw7j0F2cD
         h02R0jKvoPwhWjdCBd9gS1cxP136Nywk30F9jQKxzjiOKK42LC7vU4HchGqK01+J+6Y/
         PHaA==
X-Forwarded-Encrypted: i=1; AJvYcCWmmHd9+29mJXPGvN4iaHCs4wcZvgIvHSZsuiDbyJX6KRnpdv9k5mVMtqk7GFIjNPZoRKbmpT5qqLtMkoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPMUdRsFgeqr1Cq5LlLlWVoitjEGxsQuOeuO21enuk8rSBhDk
	xgSxZV3AqaYGYPHaO6Q+dwC40sugNfohr/QXFuUKp4NuqGjRmTCs7ctUk+X//xt2Gz8f4+uBLa/
	rmrWoRmKK4kVT0NAdVG/J1tRJMfP2aio=
X-Gm-Gg: ASbGnctMCbUwXtXfZU5dkquMekd8urfDtx17MnjQqqUnxwSBFfhIbArk3c/ACPa5ryw
	3qjFK5Uy0uGi5e0rqrx2uyLEQJ67MdGYdohHQR1C0mZNitrWczPL6dA7k4uD4SxeS83a9QA0OHI
	g5G2Y1fOpNQN1BfXjiwyBUWfJhnuSN2h9Y7FS0rOjAl6GVsKU2qZ1hu8NtvKldm4VLsXVaeVnbw
	+JNHX+qtvGuso09HMVGVY4tgMlNQw0Y5mu4wNBSS87Zzq6Q3YPQrAgvtskrqMvdgU+oUHs=
X-Google-Smtp-Source: AGHT+IH2ISUQbjAz5ENjJq/uEOXvU62m10as471BmbjyWcmy6OOBDzk9WNfXvUmmHlsJmOVTi0GMIAjSy9tbtMgo0v0=
X-Received: by 2002:a05:620a:2892:b0:86e:ff4e:d55e with SMTP id
 af79cd13be357-8b220add1a4mr678564185a.39.1762396446056; Wed, 05 Nov 2025
 18:34:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 18:34:05 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 18:34:05 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <1043551.1761844832@turing-police> <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police> <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
Date: Wed, 5 Nov 2025 18:34:05 -0800
X-Gm-Features: AWmQ_bmTHJ5o4ky7tugyGqg4q6fbF3cBYHNJw35f2J6kkB6wRtQdQHP2gUMWv7g
Message-ID: <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, 
	Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 10:27:54AM +0100, Timur Krist=C3=B3f wrote:
> Hello Valdis,
>
> I use Fedora and I developed that patch on Fedora, using the same GCC
> version. It did not give me an error or warning when I wrote the patch. I=
t
> is still not giving me an error or warning about that code now.
>
> I am working with the amd-staging-drm-next branch.
>
> What do I need to do to trigger the warning?
>
I have the same problem.

linux-next on Arch Linux
GCC : 15.2.1 20250813


Steps to reproduce the error
- make mrproper
- make allmodconfig
- make drivers/gpu/drm/amd/amdgpu/

Turns out its due to randconfig, See [1]

Setting RANDSTRUCT_NONE=3Dy seems to stop the error.

[1] https://lore.kernel.org/all/2025062439-tamer-diner-68e9@gregkh/

- Amit

> Thanks & best regards,
> Timur
>
> Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=91po=
nt: 2025. nov.
> 2., Vas 1:59):
>
> > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> >
> > > Can you say how to reproduce that?
> > > I use the same version of GCC but it hasn't given me any warning or
> > > error for that patch.
> >
> > Upon further testing,
> >
> > [/usr/src/linux-next] make
> >
> > is sufficient on my system. Turns out that it errors out even without W=
=3D1.
> > My
> > next guess was that it had to do with -Werror, which would cause warnin=
gs
> > to
> > be treated as errors, but my .config has
> >
> > # CONFIG_WERROR is not set
> > # CONFIG_DRM_WERROR is not set
> > # CONFIG_DRM_AMDGPU_WERROR is not set
> >
> > Do you perhaps have patches in your tree that aren't in next-20251029?
> >
> > I wonder if Fedora's build of gcc 15.2.1 is different somehow from the
> > build you're using....
> >
> >
> >
> >

