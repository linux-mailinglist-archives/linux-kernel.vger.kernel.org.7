Return-Path: <linux-kernel+bounces-739260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CFB0C402
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D225409B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82D2D3754;
	Mon, 21 Jul 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/IBTKKf"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE32C374B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100582; cv=none; b=P6jkXILGiSgrhXWCN+XayV6S5Sxvpv3ZSBu8kH+gaBR9Pfv2G79I7Dn7Id0Wl6xCk4qYxW4lwsjl13BgjOEt1O5co80u1Jcr30ToBbP2LuzhgOXfxgX91t8iN0XQCLX+yXahkeq+NcDotN3ovNu4q78h2gOshfh8v/8OuCjyzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100582; c=relaxed/simple;
	bh=NaC5mme5G/2fgAfAK7Eys5Nx7GQs7eUuEvqiHOpTBZk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WWaUvBwgj7MuXtQIgi+AERlpt4Mm+TPO8BXNNpucEqt0+4eD2PWHT2mgVCvd0Gi3h5IQLghffe1LEhm1XnVMmXarB5+GMiyXiN6Tsu5gXzFXn/QBuCL2YjtjQQBQw0c+krPWnMKEZz7ikc6MsvWru6f98cqx0bjKjzshPInY1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/IBTKKf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70f862dbeaeso38917337b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753100580; x=1753705380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCEGSN3M10MrjOFjG0lLCegL5PcRSqy0h0h9sELILDA=;
        b=l/IBTKKfKvyA0aXN/iD5e3orDYqp7mKDAMAJtz7eTNMRs7R9ewQLY/6IfQRFu/ao7H
         nduvxyKabZmN8ORrwxU/Tlz910h49acLGz+SPHG/pTDU/KgAKfFhcRd3604bkhKJJTKm
         bTbOo1ZcmV6pa6FSVQRTgAKDNODDEfV/9q7bgNLdmq8A+7n+BTU1dRSudx9yOkveG74D
         CTH8BcOb5sTN9xBK/bQonoMKb6Xs7hp1AIbfuBazh67q000zLF0QzpnMZzT5v2Mp0w4Q
         LE0tqG6DuCzVoEJfC2EXWIfnY7uwBEv+4HDSzLp79rRZpEDroCYYRQ0XP6uN284ylnVK
         yPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100580; x=1753705380;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCEGSN3M10MrjOFjG0lLCegL5PcRSqy0h0h9sELILDA=;
        b=TfMfi2NhUKRw2vfe26xI2MhWXjP7r70hiPt8oL9oocyIOIsAlSi1H1YF708QtY+4Qv
         81EPjeYo/Gfp/gnLgndwgS4r52iPs+xOBqRMWHkSXY1hac6KkIi1UOARyaPXKu2QEbG9
         IEI0tvv3mvLdAKgavQKVz0OKolr9TdkzTJMXbh8HLUEb3egzKl5rbCnVYcKVfh9Mrp70
         g7kr1gto/FyyBx2zm0fbZFzpAlfntaeHXACdNITTE2UKoOXAXvNqbKE25T1KkQC/Kcet
         fdikL0koK09GbO8nDDoUx2mw8qG/oSfCb3mVMBvIU9X1FrCDXaLxPxBNYfr8pzKpZg20
         KqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUbOd69g/Lll9mBse5BRUU4q/UACDjfweViLyrY73KbUAlG0jsHDJMKTkqlAJleYYwsN4cDKyrDTGHujvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxis9I8y+Z8/M3DO3xN0XvwuLMdWJtxhzcy/8UBbjvtiK0hyGbJ
	cL2MD8kq3BpOv/2ca3jMzDwYfA6fzhmtrpRp+ZsEcEMAVI6Es3kCubFcMCdigb1GHnDAeBIu7i+
	Z+Cni8EUfEJ9OyN18PQiC9ODDVSxxm4S2SiHD4ME=
X-Gm-Gg: ASbGncvyACPH1i6lUU7ITz7juwxPHN7q3KU0oscdNPvA/5Z/vIfgebNTpCcul2iGYkO
	9MkZQaX4FgAwBI+YFdCyvF6xXRqPb3du6ldYdDa6d28RMsO+HlJFcdD9NPOK+D4ZcAnNsEUHpC/
	ITBVb6ephBCnPqGHIuHlxXQmZWWyEmjRKtW92s8RdtbMrIxWT3wj+4K9iVKDDA/HruT4u9cnrVR
	FgWXw==
X-Google-Smtp-Source: AGHT+IEWB7JrFoMbHrRALXWP1vhD6NN5YpFLPFz8a0z6KxSPI5Oh15vQ4Zsncp+bvRHP3+gphdxUKvzFK9fNg5W9TvY=
X-Received: by 2002:a05:690c:868a:20b0:718:38bd:bb42 with SMTP id
 00721157ae682-71838bdd021mr184209147b3.41.1753100579541; Mon, 21 Jul 2025
 05:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Satadru Pramanik <satadru@gmail.com>
Date: Mon, 21 Jul 2025 08:22:48 -0400
X-Gm-Features: Ac12FXy7wN3KNUOiIVLumsXVvu9VY7MUOOaJsu-IjLq8qTEhzCqLvUhvpKWfvAw
Message-ID: <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
To: Arnd Bergmann <arnd@kernel.org>
Cc: airlied@gmail.com, airlied@redhat.com, arnd@arndb.de, bskeggs@nvidia.com, 
	bskeggs@redhat.com, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>, 
	nouveau@lists.freedesktop.org, simona@ffwll.ch, ttabi@nvidia.com, 
	Thomas Zimmermann <tzimmermann@suse.de>, Satadru Pramanik <satadru@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello all,

I suspect this commit in 6.16-rc7 has broken acceleration with Mesa's
nouveau drivers on my machine.

glxinfo -B reports that I'm using llvmpipe.

Reverting this in 6.16-rc7 restores nouveau acceleration, and glxinfo
then reports: "OpenGL renderer string: NVE7"

inxi -G
Graphics:
  Device-1: NVIDIA GK107M [GeForce GT 750M Mac Edition] driver: nouveau
    v: kernel
  Display: wayland server: X.Org v: 24.1.8 with: Xwayland v: 24.1.8
    compositor: gnome-shell v: 48.0 driver: X: loaded: modesetting
    unloaded: fbdev,vesa dri: nouveau gpu: nouveau resolution: 2880x1800~60Hz
  API: EGL v: 1.5 drivers: nouveau,swrast
    platforms: gbm,wayland,x11,surfaceless,device
  API: OpenGL v: 4.5 compat-v: 4.3 vendor: mesa
    v: 25.2.0~rc1+git2507191056.03f67b52319~p~mesarc0 renderer: NVE7
  API: Vulkan v: 1.4.304 drivers: N/A surfaces: xcb,xlib,wayland
  Info: Tools: api: eglinfo, glxinfo, vulkaninfo x11: xdriinfo, xdpyinfo,
    xprop, xrandr

Best,
Satadru Pramanik

