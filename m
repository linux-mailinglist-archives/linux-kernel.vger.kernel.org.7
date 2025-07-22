Return-Path: <linux-kernel+bounces-740658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C848B0D75C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A175D3B3B25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D228C2A2;
	Tue, 22 Jul 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx45qlBE"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B22DFA3A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180164; cv=none; b=tZ6zgQwqliuCud1m0v7kpvrksC78PBAPQ5DT+sTQtGDJObh36qwlraEDQ6P5VEq53T0MUaynpADWx1RrdHFL35sjYFP8c9lM0lG9xRh+p2b71Wqz67tqdyVZ7wZWK2usfTBHD8PQP86HWavCkdCiBDiZg7ihqq7Pr1tGPR+yM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180164; c=relaxed/simple;
	bh=rVhTQfn+06SZjykkCx//yMRYe1F42mvD3bufyn8Eoec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsdvET4Sv3aU0+rSaKtyG2eWEALwAqN+4YLaLxEF68ekxeqjqGUgVL6uuFRbP985Hly7QymZmJROXXqkzXuDJXAJ2Sok9aXaNM0qfHLAi3SrJaKTEqjfA9+M82APHHE0SGoHoSfUSx2tmBdgmSIeeto5EfJwLMoE7HJQl51ARMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx45qlBE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4555f89b236so52726445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753180161; x=1753784961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxZUVGACW46ROFRrurwhfL/bIVT9DSzn+Z7eP3oj7pY=;
        b=mx45qlBEQdz2UyOhX4FOHrNJkrkWcBdmEfKuWVk7rNXGiE614hPDrXXv/eQkUBJZq5
         7Au6NWRkLmySvbhhKYk1Tudml+DhPJfIPPN0Z36U1FvD2tmlUZF9Ymev9xjNsPBlONZW
         Iky9CE9gAzwrBtudz9/dBL+huBPeyDKFg3dXN09Z1bS2bgHhjBK8JWYxRmr/qiC/EZX7
         qh8P1u7v2k37d7vdDrFab7R8fFmUFMF99sZt02spUoR63HUNkIVcJZ1e671cpYRLHRe5
         gRUq1o8aObr3AiDTmUGo1OGqXiqnCgZt7XFtGn6ubSodCwGr3gKyBN9Ao/nkPLgsr3VT
         vcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180161; x=1753784961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxZUVGACW46ROFRrurwhfL/bIVT9DSzn+Z7eP3oj7pY=;
        b=D97qm9CEryWLHdqUfn1oKA4LOY02eOAJSd3pHGm/EIpqtnoTGbvvp+iOo9DqbEUb53
         Yud4iXJ/JMP6uGfrdFm2NtutlmOmSm6XDk3MA2H59xSzCc0sDfr3TDcNfslc5wAzrnbF
         X4jXiNHD9NYVK1WbMdaLg9CEXVGgIkbFQIVSeReHRws42puf8b0DTd1bncBHrZ9yzv1U
         f99zwH6FczcvOFXgk6n8/n/OqGxlY19A0lFP3vcYMj2CQTwG4TAG/qEmZjA8S1cu+DxJ
         FmZ16aAZEey6PUgAeV7T8Hm+HmHxFQJ2li0eZd5zHh459Mt8BxRfU7qUas5OaxSLbifz
         Rz9w==
X-Forwarded-Encrypted: i=1; AJvYcCWaD3sAULK42SdTuSUjS2tTuXpdPldstawL8WwcHlemcGcFxZtr2WdhV/UCz712sYEjHzNG6ZLsRHq/Wh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5faprdieOcCsYN852q22edjW3G7AOm616jDXSeG6l2EZjbh/c
	FcxFBWfbrrLN5B5jn9Ze6qUp1MRr6WKs2LAivW0mU7spf96a8VwITLeUpkX7W1/i
X-Gm-Gg: ASbGnctf2DyudG9EPn1R+r+wjZZ9WFbuPL3El6O3VDHHIHzbKw9AHzziTWoOTQa4JmS
	MadYq1N42547GqM2Ed4kIJe7FAgs5vdBFlaQR3FLxPlZz5LK684pOiQHi2FuZU8d8JL3YGapP/C
	gXB7wGWPzju9H6IZTruv8zu0Iytu/GiY2nhR00NnTWykLMG2uGoIIVjfaNTT8p2GmmeFmtO45eb
	R9zJOeIO6XJUq+PR2dk+ieX0SL8aJSnsxn7qlacWQyTxKHH2/Ek88Nmt+QN+raC0OloTnpOWJOK
	Fn6iu6wvcTdadtdUbZX3Bkl73EKI579LxnF/tPczd4eCYSZ+O0PJKOnahr5Qf05mm4Wa/gA0ssO
	picC3s2M8+gzDvlRWhwsOZ3qo3WuqWY0=
X-Google-Smtp-Source: AGHT+IEHBlNbQ1YPEWSxQJSYPHljQ9UoaZeqhCRzRGrQ0XzA5BTAIrm5I1v2Kds708E89K2m5lCgjg==
X-Received: by 2002:a05:6000:4b17:b0:3a4:e1e1:7779 with SMTP id ffacd0b85a97d-3b60e50ff22mr18202349f8f.32.1753180160588;
        Tue, 22 Jul 2025 03:29:20 -0700 (PDT)
Received: from debian.local ([81.78.104.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm125434925e9.33.2025.07.22.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:29:20 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:29:17 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Satadru Pramanik <satadru@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, airlied@gmail.com, airlied@redhat.com,
	arnd@arndb.de, bskeggs@nvidia.com, bskeggs@redhat.com,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
	simona@ffwll.ch, ttabi@nvidia.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	regressions@lists.linux.dev
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Message-ID: <aH9n_QGMFx2ZbKlw@debian.local>
References: <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>

On Mon, Jul 21, 2025 at 08:22:48AM -0400, Satadru Pramanik wrote:
> Hello all,
> 
> I suspect this commit in 6.16-rc7 has broken acceleration with Mesa's
> nouveau drivers on my machine.
> 
> glxinfo -B reports that I'm using llvmpipe.
> 
> Reverting this in 6.16-rc7 restores nouveau acceleration, and glxinfo
> then reports: "OpenGL renderer string: NVE7"
> 
> inxi -G
> Graphics:
>   Device-1: NVIDIA GK107M [GeForce GT 750M Mac Edition] driver: nouveau
>     v: kernel
>   Display: wayland server: X.Org v: 24.1.8 with: Xwayland v: 24.1.8
>     compositor: gnome-shell v: 48.0 driver: X: loaded: modesetting
>     unloaded: fbdev,vesa dri: nouveau gpu: nouveau resolution: 2880x1800~60Hz
>   API: EGL v: 1.5 drivers: nouveau,swrast
>     platforms: gbm,wayland,x11,surfaceless,device
>   API: OpenGL v: 4.5 compat-v: 4.3 vendor: mesa
>     v: 25.2.0~rc1+git2507191056.03f67b52319~p~mesarc0 renderer: NVE7
>   API: Vulkan v: 1.4.304 drivers: N/A surfaces: xcb,xlib,wayland
>   Info: Tools: api: eglinfo, glxinfo, vulkaninfo x11: xdriinfo, xdpyinfo,
>     xprop, xrandr
> 
> Best,
> Satadru Pramanik

I also bisected an issue to this commit. On my laptop, this commit
results in an intermittent desktop crash (Xorg segfault) when changing
display scale, which can be more reliably reproduced with:

for x in {1..100}; do
  xrandr --output eDP-1 --mode 2560x1600 --scale 0.5 --filter nearest
  xrandr --output eDP-1 --mode 2560x1600 --scale 1 --filter nearest
done

I also see the same glxinfo llvmpipe change that Satadru reported.
Reverting the commit fixes my scale test case, and also the glxinfo
renderer.

#regzbot introduced: e5478166dffb51fa64e76cdbb5c24421f22f2d43 ^
#regzbot title: nouveau hardware acceleration broken

