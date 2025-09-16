Return-Path: <linux-kernel+bounces-819055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCEB59AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C787AC58E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4234321C;
	Tue, 16 Sep 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJn67JMC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E532F754
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033975; cv=none; b=R5DaVyRF7TmiX1FM2ic/EO7qKyOg+FsKSTuVndJPoF4eFsPH99TS766+fIly64atuF7r4i3IC2bCg1Klxhepe5IigZpeI72qh7ojOIJmG7GCvDN3DcxSaemvnDHBN3cE73DZeRu0i6gxchtuNX6Dr8fvHNHTRAsZJg6i0T7MS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033975; c=relaxed/simple;
	bh=Xgb7+bT7mEhDS6nxwAefKg+y+uOoDtiQicdSXTirrgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWepuL1SuS5ZaG+6FUyW09e53q+pTIoQajn38AGC00eXkPEHs0pA6JNE2ujDAptVDjfSEE+h1//YAMUbDPUN+gUWpFEOZU3Tfn1oI3iBgHgItgYAUSIxl3/Z1Uc78OhmqNavdU6GeC/qBDC7d7S0VwObUiiy8K0YUBXUOhaUFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PJn67JMC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e372c413aso1928761a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758033973; x=1758638773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inmx6dNf4InTlZUGwu0BdN5CX9UhUArnuNUQoDKHWD0=;
        b=PJn67JMCTrueNon6nKNz1dB79IJSRZAP7tYzTPBZ9EP/FnL9mRw+nAueTPN7m+MdL+
         Ouut0HMzESQH1uGeCOn3O3OojqSracbpsTUFNtW1eAgIZiWbrcjyL1hfhtYQ77Kr90ph
         y9ZrqxFDOb8Bu1Y+Ubm9GTHuXPygD5q3hWAhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033973; x=1758638773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inmx6dNf4InTlZUGwu0BdN5CX9UhUArnuNUQoDKHWD0=;
        b=pYvZffkYn43FDX+c5Pb/6nk3/9Zg1iDmHDM2CnkX2iVNy8IrUVmHfMZz2hIVCHpl0W
         ng/Us9a2Edjyv95pdl2oFe510AwLTvXw4d+kUmZgVXi9JC8LWFAl6gOrPmpuhG8664Jt
         Pz+id8bKmt7t6PNlQb/ne2G6epw9jv0gLQMHwikJF8t3sm0GANBxjdotiKSU73Vj2tNj
         OUmxTUCIHc4xEw/V5pyIB90SI8fxGdw8uM7BrCwTDgtbHVjjxrF1YJ31Yu7KtLGVwtpT
         nxMAezzM19tvjD/T3+OfBLxDRjAUUP3xwf5BDpM4tRSGN+4aVIxwRXxeqvcDiUy4yTaZ
         7esQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkJYKv+x1H9hX0aWttcIOKtdHhl3JoQjpVL/DsMN1VWoSEt7eyR2MNU+Lt4N2pqraDCCm1MFJVttUmfiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflDUAVactZEmvW7YyIrBkVlczXOx+W9iDWGwhLJlDtbMqMywY
	pUqkCk15WlLP4dXCFTI+g/5WaYoIKZ2zw0VSWj5ECel9yqRQIL2LvNcKQAkv2u9ANNs/I6NXcbM
	z7r8=
X-Gm-Gg: ASbGnct9MXyNA0h9kQsZYURYbWb00mKLO9kvJKZ/TJWzM1MKGaeE8piPORDI9U2jKik
	jBZUIvlv2YioakBhXbadh2QN7UA8KEeiQyyk+xpbyLQp0pGHNH9HmOsXBATVp/SAIGPsynMtWnb
	Rn2DE5P3VZkzkO+jfrYCvNPDplSmCvW5xZ7rj08UFgv9+inExdP3v9o+OLvkt17xEk1k3LmNYaA
	LlMQEgnQaVP5Ka80CrFYm/91tLmoE2P6DGxek8O+b1HIPxGiU5iyPOA9Z4aTmP5+V6/M03flhs7
	Ijxfc98aa5MFpcCC7UAUjW4vPPTmAtiJh4Hx+m0AChc+49ztajBiELElvHZ2h8xpdOmtzjlQC9D
	n08MFGVK1pV25a+tc/pHw++czww7DUaLynVQjDRlWdSuqBfEjlC2nCnoQdF2BZxJwWQ==
X-Google-Smtp-Source: AGHT+IFZUYxWK4/A7bhK+U/5XnffCY5PnhdfoaAeKUX7tD+eIKY/26ZkNe3UgHbk1LC5iUdH7AqiXA==
X-Received: by 2002:a17:90b:49:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-32e528c62abmr11615894a91.24.1758033972947;
        Tue, 16 Sep 2025 07:46:12 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df5e31da6sm12371723a91.26.2025.09.16.07.46.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:46:12 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267dff524d1so4540005ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaUvzFV/uiTfQNliiaNHGNf6UEHfXjjQUmNnXvsIJo1Dwmi7w7GJLQ0OU2CmrwkkL3CrPTgKCLPO2Ayjs=@vger.kernel.org
X-Received: by 2002:a17:903:1b66:b0:249:37ad:ad03 with SMTP id
 d9443c01a7336-25d26079287mr167604515ad.34.1758033971727; Tue, 16 Sep 2025
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916142047.3582018-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20250916142047.3582018-1-ghidoliemanuele@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 16 Sep 2025 07:45:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uftrv=x6CuG7edLCSAi16Kv=ka7qxPViuLM=BEG8pC3Q@mail.gmail.com>
X-Gm-Features: AS18NWCjwmqu4t22vUwtzmrXP4GFZo312uz90IvKcUJ0ZtK-nxts3dyYnOQvG3c
Message-ID: <CAD=FV=Uftrv=x6CuG7edLCSAi16Kv=ka7qxPViuLM=BEG8pC3Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Transition to LP mode on
 every video line
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jayesh Choudhary <j-choudhary@ti.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 16, 2025 at 7:22=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> The component datasheet recommends, to reduce power consumption,
> transitioning to LP mode on every video line.
>
> Enable the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
> flags so that the bridge can enter LP mode during the horizontal front
> porch and back porch periods.
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Jayesh Choudhary <j-choudhary@ti.com>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I put this on a sc7180-trogdor based Chromebook and the display no
longer comes up. I don't personally know the MIPI side of the spec too
well so I have no idea why that would be.

-Doug

