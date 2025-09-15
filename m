Return-Path: <linux-kernel+bounces-817555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD3B583B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D0C1AA3F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65527979A;
	Mon, 15 Sep 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GN4dHKeL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07802245023
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957601; cv=none; b=l3X2LSOXD54ErcH48bxmJKg8VyPAT3GP4ntxfMVNgkOKAvhDRYEsnwVbUROTL5wBwOEYvkcS1iIqQXzA80EaxMIpvNGO+xUF+V52NPcr4ByVxylzRjM84rBTGrcYrlZJkBdS+loVOjY8Idja69hDklja+n+NUvj0if9WSzS0tVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957601; c=relaxed/simple;
	bh=QVr1CDJ7R7GLfF/ZloVhfM5IyPT8jqNaiGLqnI5SlxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhJrqARLX+QHKlJZWZEnc8ho78hXfxDGbMCzcO8U8g0wDUklAnpWdjR3xR3l+VrTBVNPOrG+eYnbpnXiHNz15SP6T8AqepyNVTsNAt0YPBizTEr6+7+lsA/uvYL4Axfqn1QBO7/hs3fQzIisBTHeaBs/wbidn2do2rj2lM5DSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GN4dHKeL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e1c68d806so1405395a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757957595; x=1758562395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV61ttDYdkC8rDeXwENJv1WcBg+55bTMtOKecEsDHFk=;
        b=GN4dHKeLA6vwyIeUnxIK0+CEB6UPvKSLXcn3dKWaj+u1bxt2qHARvT6oTX+3sKEdKm
         X3oAV2r4f9dV0IhoRQrfAewxGS/7WqhJomJcujg6NYVOQhdXJVPI3OYDfGlycrl13M6G
         gKSpvt5cFfXtIRdu5FKa0fhPHLItZjpDmg4iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757957595; x=1758562395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV61ttDYdkC8rDeXwENJv1WcBg+55bTMtOKecEsDHFk=;
        b=B4rzyNSFU51ywpBebMLHx1YkqtiuofuJ6kXYRcRIm1F2ofiZWx8lfS+14cdq/1unZt
         Wix8WZClXRyOcB/lew5e7W80YE8s/tJ/orif3YD5QoGqUGkdU8T6JP+7onG6sL7x4Oa3
         2+cKFWzEriKgouU1SggK2WakF0wojY/vqo9WN+PyIYPBmKWdG0rW73swhtGraUxTxUuO
         42HBI/uKEqRl24swC+IOqpZX2fKPK5APWdnKNriC961Ju3xmd9EspX9TRnwttlJtVBME
         U4ZsZHQOmuIOiukFshDe9mg0Pbuw5j0+Newn9S+v/d0yM4rNobNWywTuhwLSgJaO3fex
         S57w==
X-Forwarded-Encrypted: i=1; AJvYcCWD+6STWu0k0nLKc7XNuMyFYM3UAKEHCtJwjwlvLHP+LC3lPLQqqOT9aifaHLIZv5GoD41NezwaOJ4gNfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZNBse+t/K5EM18thD82ouiVfyiNaDvT7/VVS+VuMZzj33S0g
	zGdrfzC2ej4s1wA8UdMfmuRUiXfbfTEyMTzMx07ts1nRinJGfaBRoNtsPKJ3ob5/v8PV4RfcsxH
	G4IQ=
X-Gm-Gg: ASbGncsg4d9QekBILssJzt0lS8ghC6DOivgxVyilcm+4rh0uEBLHi2MNf19RaKFgohN
	kztoyMhroMPpacphDeWGMKhZ9oe9A2EPJ3g49JRZx67ClF+Y+SGkqNmsz7IWGr0AsqhAly8hcHx
	1XqluIE8fe4UgbJEbuYqrr5qJ0mpoIF13m08XRfRBxgHan3HmmLRTmXmt9JnBJ6DcttYJ1zq+e6
	AnH/LCYcdr5/r862q1U/pBtOpggbOex7Jnqj+od0vTTq5sWYJ2GAGhOdibMERgVW+PbH3OHwaul
	Be+un/Ejd2Lt43SoTe8KmHhxpGwA8gnCh32xEbIwKt2XCrG0CzsFUnqU9hLLt7zQQKrsVgZ1Kx2
	Xl41hC3gEGfiubg31qKP5Tiy+u9ry+xe7wvW6i9CbZNclWPsOwPDfOsaVH0O0t6clgfSk4NqVVe
	Mr
X-Google-Smtp-Source: AGHT+IHtP1vCZ4fVH4U7NSY58hHLZqvZrNpVEhTNUh5qhhVgOTsVfcuFqEnZkKvfiFuvqonT6qKcRw==
X-Received: by 2002:a17:90a:d40c:b0:32b:cb15:5fdc with SMTP id 98e67ed59e1d1-32de4fba102mr15086038a91.30.1757957594473;
        Mon, 15 Sep 2025 10:33:14 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd620a64dsm15816650a91.8.2025.09.15.10.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 10:33:13 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2639bffd354so12032175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:33:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgsexLMQl28dUqDU3KCf2RbUS6ss3QylWzPjwTKxNDo1McVri4QTdYwDtVVhiTiA7zLLNDP9XnbutDs08=@vger.kernel.org
X-Received: by 2002:a17:902:e74c:b0:249:44b5:d5b6 with SMTP id
 d9443c01a7336-25d26b51b96mr161569375ad.40.1757957592247; Mon, 15 Sep 2025
 10:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912210805.2910936-1-john.ripple@keysight.com> <20250915165055.2366020-1-john.ripple@keysight.com>
In-Reply-To: <20250915165055.2366020-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Sep 2025 10:33:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wij7MjyuS0b+4jn65Oq7Ee+2-__+5GjhfURBBk9G3kpQ@mail.gmail.com>
X-Gm-Features: Ac12FXx6NsK6AOefg4Q0kBS_Lj8jjSNLunysKqc5tXmxBH1qNHJVLHe-q4hbDEc
Message-ID: <CAD=FV=Wij7MjyuS0b+4jn65Oq7Ee+2-__+5GjhfURBBk9G3kpQ@mail.gmail.com>
Subject: Re: [PATCH V6] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 9:51=E2=80=AFAM John Ripple <john.ripple@keysight.c=
om> wrote:
>
> @@ -1309,6 +1375,41 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
n65dsi86 *pdata)
>         return 0;
>  }
>
> +static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
> +{
> +       struct ti_sn65dsi86 *pdata =3D private;
> +       struct drm_device *dev =3D pdata->bridge.dev;
> +       u8 status;
> +       int ret;
> +       bool hpd_event;
> +
> +       ret =3D ti_sn65dsi86_read_u8(pdata, SN_IRQ_STATUS_REG, &status);
> +       if (ret) {
> +               dev_err(pdata->dev, "Failed to read IRQ status: %d\n", re=
t);
> +               return IRQ_NONE;
> +       }
> +
> +       hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS=
);
> +
> +       dev_dbg(pdata->dev, "(SN_IRQ_STATUS_REG =3D %#x)\n", status);
> +       ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);
> +       if (ret) {
> +               dev_err(pdata->dev, "Failed to clear IRQ status: %d\n", r=
et);
> +               return IRQ_NONE;
> +       }
> +
> +       if (!status)
> +               return IRQ_NONE;
> +
> +       /* Only send the HPD event if we are bound with a device. */
> +       mutex_lock(&pdata->hpd_mutex);
> +       if (pdata->hpd_enabled && hpd_event)
> +               drm_kms_helper_hotplug_event(dev);
> +       mutex_unlock(&pdata->hpd_mutex);

The order above wasn't quite what I was suggesting. I was suggesting:

ret =3D ti_sn65dsi86_read_u8(...);
if (ret) {
 ...
}
dev_dbg(..., status);
if (!status)
  return IRQ_NONE;

ret =3D regmap_write(..., status);
if (ret) {
 ...
}

/* Only send ... */
hpd_event =3D status & ...;
mutex_lock(...);
...
mutex_unlock(...);

...but it doesn't really matter. I guess it's a little weird that your
current code still writes status even if it's 0, but it shouldn't
really hurt. There's no need to spin with that change unless you feel
like it.

At this point I'm happy with things. Thanks for putting up with the
review process!

Reviewed-by: Douglas Anderson <dianders@chromium.org>


I'll plan to give this a week or so in case anyone else wants to jump
in, then apply it. I'll also try to find some time this week to test
this on a device using ti-sn65dsi86 to make sure nothing breaks,
though I don't expect it to.

-Doug

