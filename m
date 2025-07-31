Return-Path: <linux-kernel+bounces-751591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA7B16B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3208545D90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A923B619;
	Thu, 31 Jul 2025 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ/PMgAV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E8539A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936389; cv=none; b=cxLarSxp2Br3pBC0HLoiKV1du3l+72uu6lDbYrD0pbhrKt2s0G11inbXLKattCdXMgQEY4HuxPbELi4cGSlQEH5qtvNbYo2aCIxcag4T897bdCH8boOYuYhfRKMEFoKqzyiYI5Xz3PUyLneDS2Q57HPwecFA1R32QwG72H1EzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936389; c=relaxed/simple;
	bh=3JSKm0nEKJAPwalaqeATZOhehjz4nhElR0L2lw2f1iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qov6rXP8CLvc8BzGThdMZNyets7GWwDCRFmu3IQWUjjtbXcKrC8lAXhBg36aOL/GYR1SHq8f6q8at+6MSEyMXQ/6F3nZgknHacyTsKpD3lJ2zeROQgqdLOQNnsMVkU5uQiuZQ7Sz1N5tYOVHMtug/ell/yfNIHqQAXmUpGA43/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ/PMgAV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso93496566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753936386; x=1754541186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JSKm0nEKJAPwalaqeATZOhehjz4nhElR0L2lw2f1iM=;
        b=RJ/PMgAVzUsl6ribpk2JIbQ3C03kV2kGIV60JSjJhGlNKQTDaOTogW21VP+eC0vLlV
         kKsvrWJgYVTuURWZLbNd6GPk1QSVHQrIo6ijSKSroQP0nxocyHaC9M5rCNeKMHhs1WH3
         fYonuRBUGQeSxpSR6YTqU6bCPWgrDF8uOUggh0zpiTWf+mXqD9qA6mOhjn6mVLmcqaS/
         VEKAle1TGZMC1Qtx00PDNFMw8xAfeKDzwNNT4NqsYDHyVnTBkZoft5rLl+e7iYGtwhh/
         e+dtA9hUupXe3RR60yylQQcsn0CJEn2/QhF/8cFYbwIgY1rrbIq2G99KoH/bvC0D9d7H
         Cobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936386; x=1754541186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JSKm0nEKJAPwalaqeATZOhehjz4nhElR0L2lw2f1iM=;
        b=AaZYNr1DThEHYQPr5GX7gelMjSOqjxOgZC+pDRTpS+XtgulASUryv1QtrnNzdwKb8K
         xnhCGz0rvGLHwLT1VHEKMBvVGrEmmeJriEg0mTqA7P8BiIy67uqaLS8CMAobS/1sTGxn
         tA2jRDYjxh7+FdC8RRAg7fXHiite08yRDs7PUL4wPY7LK7tyGzKw1dOdIUwSzAd5g7lj
         fmLSuWzCo9+yG+pVUWPIW/cnWa5a18odYp62yy9S2/a4wVpFqFVR2/PwFT1ReLlgxrf9
         bhotkGOHlGlQe+tGYVP0+W2lEKUjS1kXAdEa6/4meK7EzkC8XOA21v/k2al6slpL8hMT
         SNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnWIbzLgxLZuv4I5cY70b2QGk2Kma67D5+6SUlF+xaC6DhWgs9NfwAmTk4JIfQeWDZG5N5ySuFojGRvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42QP4emUy6OJ9Q4KtrFbjm2lE4VD0tbvrv7nWOeGP7jDrngIl
	aS7LSswjsdn11WZ83VcQPaZ9Mpixp85EZ9CvtxIOm95Y8+giFeF6kBdLMhF6pOtcIvWiLizqyz4
	dcpniYTlue7XJEcJyGd1eZBom+swbnAg=
X-Gm-Gg: ASbGnctAuAqmvXxLtCBWcD/Hfhb3LSry72gHCF6epm4UXvtUo4yIXq+gHYyZGXNV4ki
	4nOsLpEwYAa5UaujO2niWqyzSas8v5lssZzgtC3aLwrayUHdR9X91qCue0h6TC6rzX1S3ke0POD
	byC1fdSbcuamwy1GyHyRh8V6boewzrgFm4vynjKidoZi/U4gb7emuPExQktwLNjxu24oWd66aje
	STI8g==
X-Google-Smtp-Source: AGHT+IFR294yFMaR7jpG795FUdiCyJUFOSMzzfyfSWWRkIQbJmZBB1Npd/gZaUqeCtoQlf4i7AudhewhVV5fIXbIyWA=
X-Received: by 2002:a17:907:d7cb:b0:af2:42e8:ad92 with SMTP id
 a640c23a62f3a-af8fdabab00mr688262466b.61.1753936385865; Wed, 30 Jul 2025
 21:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com> <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
In-Reply-To: <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 14:32:54 +1000
X-Gm-Features: Ac12FXxApAHcU8vrdpewkW56zUfDSRJSjiaR2iaLbGXiegB6RNJj9CqjC3-xjDU
Message-ID: <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 14:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Jul 2025 at 21:21, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Okay I don't have an rx580, but I have an rx480 which is pretty close,
> > but it is booting fine with your tree at least, DP and HDMI connected,
> > so it's not widespread AMD breakage, anything in journalctl/dmesg?
>
> The machine doesn't come up far enough to mount a filesystem - my
> disks are all encrypted, I never even get to the "type your password"
> thing.
>
> So no logs.
>
> The good news is that it's bisecting without any ambiguity. So nowhere
> near as painful as last merge window.
>

You can boot with modprobe.blacklist=amdgpu and then modprobe amdgpu
once it boots and see if dmesg

But hopefully bisect lands somewhere good,

Just seeing if there's been any NULL ptrs on old GPU reported.

Dave.

