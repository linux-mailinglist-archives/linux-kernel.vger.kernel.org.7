Return-Path: <linux-kernel+bounces-797115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D761B40C00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1B564007
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4834320D;
	Tue,  2 Sep 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FB3fEbGx"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD1341667
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834025; cv=none; b=gTu4aTUCgUvNPEukmgrEk8xmSwN0boJ+44XcD3JBd/kXbHtuGww6Nl5X9MiPnwDE+/EWp4izjFHUkEoKCAxLv6V6erwK98zVdvC8q+cTocdf82eCOFgv5OS/ei1+7wO5y84Hb9BsMtBj9vGVVDniLZdxGAovzIICRvBe0Pd6rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834025; c=relaxed/simple;
	bh=R+vzI8/XRAisFFEKfXyULKg1mw6j6BVTtSv7WOtjwOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyv6Cldocg7iELhvq7CAZTxJrqI93PUIuu1t//wVLsmEo493dHL2aKaPmi5YIMFiD6q6c7bWSU3Y7F27GpxyIdvqhBeVWjNP3WNMDEO6xQxRnRBSfNsQ3GEIilFLUW3AWRqZolT9u1gwbV47UEZFWp3rfcGRis/KEsqO0WItzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FB3fEbGx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7724df82cabso2893781b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756834022; x=1757438822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+vzI8/XRAisFFEKfXyULKg1mw6j6BVTtSv7WOtjwOo=;
        b=FB3fEbGxxAPV0b8G/55KOhqhbucDtDEQDw6RSiM1zlPPyNPwGKhDYyovIu3SY61kA3
         1/ZB1y+GSgClAwNtPuoasG5swE4rN/+xctL4q17B8jqiYTx2yr5Xjm+tYeBLgAax4Ci9
         EAOpqPnyUjH7ffUWce74sEf769pe2ieLf9QZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834022; x=1757438822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+vzI8/XRAisFFEKfXyULKg1mw6j6BVTtSv7WOtjwOo=;
        b=RaKazvcgKPhFEsCQovcaoMF3xaU/2XaXdP77YjY3xlFHRHNaI8DYbCpkQwCFwuhhsM
         kphGbR5TlV52BRmWN2mi4VWUptyR8DQwaeLu+GLisK1pOBjmDmYqxisPMxSCz/75PNww
         McXSPhq3IiX90DHbd/9Hcwa3hpRYNXx/aMufEMi4VNFkKQ9tglnBB7YSFJOei43nTMgf
         uuDG6ejOD71pGvpM4rkus7CSVrrkLIKVZYs3S7Dp0pgLgefq7w7MeXAuodjmFIZUt4wP
         Bzipm5s6mf15IEmGfhvwDQc9keUDCWODVEKfaXl9LRsMAQm54jIqR/VTtk/wBf3Ox6RY
         fJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVXn08JTPTba4x1VulfRc4yc0+nj6p5P193kXFX8HiTgx5oi6ZGG6ShRY1j3rtvzN2T3pSD0xHgj4qvqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtrw8QJpkWFjdMZqcvIFe7ipwvu6oudu1ETSzAS4teB3w+7VD
	vBHr9nd3N8vuV1OlbJ66ID0LOe8IZTpNc3181+oKbik367rbVd7iU4wXV2hX1pyk1li2A+1Wzsq
	x7uA=
X-Gm-Gg: ASbGncu9xpPf2LGZBaM41JJiZG3PLE+3VIMkfjbXtGGwxgMi1qBuxoe//fy48wQnPbw
	2wylVgQIoTPjZN4E7YKcUYuCq8cbFb5UUP5Exb8gu69UfXtJo9LTdlMQELedSfsNCS+RbAszPrs
	rcAquqswxabNba1AXGCO6z+Fhqxj1PtNsHpJjYNUNEFWyCrnuINsBsSe30qypQDydBI4UEcW4/G
	QtQHpZlOVHg0NA+izGYNUnOkYJLoV0nm2goFbQtaewH3+BLundvgTOPEmPuKtPsa4n8U3nbJoqc
	wWo7bSlxRn69Woo8TPziTKLxT74gZ+StnGueEQIlVJgU13MaG+uOCEojTJLS3TkBGki+Tt3vfDr
	nYx2OrYC4hLCHOfllWqPQF3C3rKiqkQagykZILtYHY4dv7VCbyOSWf6Q5fMjbfgyZcw==
X-Google-Smtp-Source: AGHT+IHSWqnZuSll688OIPf7F1eJbybak480Ys0iZDlg9FnymwfXIQzfYZTeF0CcPXRJcC18wrr7Cg==
X-Received: by 2002:a05:6a20:6a08:b0:243:9824:26e3 with SMTP id adf61e73a8af0-243d6dfed79mr18442531637.15.1756834022429;
        Tue, 02 Sep 2025 10:27:02 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269f27sm14336371b3a.12.2025.09.02.10.27.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:27:01 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso4172509a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:27:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfi3UlrPUpgqdAPIETGXAinFR/4Bc10pMvz6B002sDtl1HiU7ESDi4s2wAFoS1EsnYUBsPTcnBPSHJtpU=@vger.kernel.org
X-Received: by 2002:a17:903:19e3:b0:245:f002:d67c with SMTP id
 d9443c01a7336-24944b19dbemr145156225ad.30.1756834020690; Tue, 02 Sep 2025
 10:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=VfCWFViDE1a5-_KtH0Pfo2EnCJeo2k8MaWuRHhmMPMMA@mail.gmail.com>
 <20250902162246.4143785-1-john.ripple@keysight.com>
In-Reply-To: <20250902162246.4143785-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 2 Sep 2025 10:26:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XyM0WHB8kpirqfnV2CY2KTrHd14pi5qeS+Sq7mjPphsA@mail.gmail.com>
X-Gm-Features: Ac12FXzoK6a2pOM7UM9T1UG-G9CD1NZjmPlNlNUAg32e3wNBEbg9ufNPfoYnvbs
Message-ID: <CAD=FV=XyM0WHB8kpirqfnV2CY2KTrHd14pi5qeS+Sq7mjPphsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: break probe dependency loop
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org, 
	jernej.skrabec@gmail.com, jonas@kwiboo.se, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 2, 2025 at 9:23=E2=80=AFAM John Ripple <john.ripple@keysight.co=
m> wrote:
>
> Hi,
>
> >Which i2c bridge are you talking about? You mean the one created by
> >i2c_add_adapter() in drm_dp_aux_register()? I guess I'm confused about
> >why the DSI probe routine would even be looking for that adapter.
>
> The i2c bridge I was seeing was created by the drm_bridge_add() function
> in the ti_sn_bridge_probe() function. Without moving the ti_sn_attach_hos=
t()
> function out of the ti_sn_bridge_probe() function I kept getting stuck in=
 a
> loop during boot where the bridge would never come up. It's possible this
> could be a unique interaction with the hardware I'm using and the nwl-dsi
> driver.

Sorry, I still don't really know what i2c bridge you're talking about
here. At this point there are a number of different MIPI hosts that
are using ti-sn65dsi86 and they don't seem to run into this, so
probably digging into your MIPI host to see exactly what it's doing
makes sense. Where exactly is the nwl-dsi driver trying to acquire
this bridge and failing?


> >In any case, I don't _think_ your patch is valid. Specifically, if you
> >notice ti_sn_attach_host() can return "-EPROBE_DEFER". That's a valid
> >error code to return from a probe routine but I don't think it's a
> >valid error code to return from a bridge attach function, is it?
>
> What error code would you suggest?

You can't just change the error code. The problem here is that, in
general, there is no guarantee of the order that devices are probed in
Linux. The general solution for this in Linux is for drivers to find
all the devices that they depend on during their probe routine. If any
are missing then they return -EPROBE_DEFER and the system will try
again once more things are loaded. In the case of ti-sn65dsi86 we need
the MIPI host device so we find it at probe time. If it's not there
then we want to try again later.

The whole "try again" logic for -EPROBE_DEFER is only guaranteed in
certain contexts. Generally it's reserved for probe. ...but that logic
_could_ be extended to other contexts. It's possible it could be
extended to bridge attach, but one would have to make sure it actually
is (I haven't checked) and, as Maxime says, it should be documented.

I suppose it's also possible that when ti_sn_bridge_attach() is
called, it's guaranteed that of_find_mipi_dsi_host_by_node() won't
return NULL. If you can prove this by looking through the DRM code
_then_ you could probably make your change and just change the error
code.


To sum it up

1. Ideally you can fix the nwl-dsi driver to work however everyone
else is working.

2. If you can't then your commit message needs to prove that it's safe
to move the code to the "attach" routine. You either need to prove
that it's guaranteed that of_find_mipi_dsi_host_by_node() won't return
NULL when called from ti_sn_bridge_attach() or you need to prove that
returning -EPROBE_DEFER in this case is safe.

3. In either case, updating the docs that Maxime pointed to would be useful=
.


-Doug

