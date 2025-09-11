Return-Path: <linux-kernel+bounces-812616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B62B53A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCF4AA6F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE035A2B4;
	Thu, 11 Sep 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="CrUEZlR8"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F88F4A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612258; cv=none; b=Mr2wJTHzausi458RkfEazNcVq6Sh7tZcGHUM7GalOjj6/2KVUxHEBnoSlKTGiL2kt6cZedvG1DxkPupUAxdKdgpfGPNPnLL0If8yMOOZGoDSxyhK2EeiQzo2EKdo4mfsMWKSU44rbbJw5+xUkHbd8JqtmGFb1is4n9Vb8HbzJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612258; c=relaxed/simple;
	bh=YD5Ps9mAavMCBc7eOcpJO3m0kvQZGZv6zw+COUPfHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1gj62EgmX8aVOgFXEkHm5H15QO8xMJmfU/E2j0VA8I6K/Kt8CKQDeu/MfcCG+sljNXfv26y0gCzt0zui2g/NaM1VJQ8hAxG4SEzq0IRIZTWr/TnkCm+/Uu93EJ+DnjKRXYJ1aQaPhay9VOjDqy9Lo4udyfFxTDktQHgL6DTTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=CrUEZlR8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea00ea11152so620794276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1757612256; x=1758217056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jVZWNLKcKM8wCphzFXQ/l/QW+Jhy7EgAiQZsEXF9kc=;
        b=CrUEZlR8iTlJZRAXJb+f2TsaPUfL6n1cGLeTsC2NCyeOdlqGKnl7qTC9ZXa9O1dBTy
         7bCL9VPSfHDijYejPNzEDIcUlZ1Xlz5yvr6kUpnUlwYX3bO++Cpw8/rMsIfbNXnXgufM
         WY240XCDhjjdKNI0aRIDhvGGD5vljbOStaW78DPmqGtEg7T69cO89SWd8iop+X00jYGL
         6w5sQxuOEoBGyawozvgLE5BaaXO0zIQtRECy1Wu+arCEXKg5+9OFvo0JFtHnDrMI6AjZ
         KvVG3PPD2esaEOtuBxVhpBUw2WdaFjGb9ssk/J8WFloMUQLNtUuE40BS5tGbg/ucu5kP
         315Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612256; x=1758217056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jVZWNLKcKM8wCphzFXQ/l/QW+Jhy7EgAiQZsEXF9kc=;
        b=LzZVFI/+9BwLDeCHkSsszOl0CFeSA0NOIDPNt1iWkUzaUrMSEYSf3MjQANn03xaspF
         R+SoxJ1c8oET64gES6X5H2NZhSajgrtqhc73bR5GyTnPi61KDk0uHy0mkCvEspbQ9TuR
         1gkyDUGBxiVqTWCfmerU2QSV6mA6G4sR5fB+3svy4WBDeQufzYM21JjZ1U54Whc6SJAD
         HA6J5qUbTTDDl6wfy9abt0ZPNO68i6HdAH3trIcKAwIxaGQoow8stJcM+SE+6xvw1wnj
         mXk9EeTtzhBzyeQX8ZKWISn5l6cSSRTmbcB2afqywDQBwOw6ya8Wfe4kXEiAahgR8RnU
         Segg==
X-Forwarded-Encrypted: i=1; AJvYcCX+moPV7bjOfz5MINR+cle6XvUnHjFx8qgmXq2QUzsD3U/YfdgxPqLKXrSKlEjwBuFkSsTLRXyUfMxeDF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOArU4r/ajW/mySwGfI6NxB+qj3Mn6QNd4NNNsnORAJ05Kw7F
	K0uYtrEaoinHeB+VBYPe9QmbhTCmS6LUvFu0/P7DjUMWYhT27uSkVmktdEdirU5iFS588bp5sci
	toOw5B+HN+KORmGiamGzh5DvkMvv97htTWTl96EXGVg==
X-Gm-Gg: ASbGncvE8EraZ9YlRpdwER7lCISUUa6zpjDc/QsbEOrFlltqbW+x4C1s3iWix2Toizb
	m50/Hg47HOA9dMnY8YdGSZY1gmlIqPBvTJv4sKLZNP9XItNY/Frva5SxhAt4is/FJPwXXM+RZwJ
	P+EmLatgqKIIQd15uu+C/KM7Fzi3zy6tKhLM7++/rI/h+ZJvE6r1/V6h+pS08Gmggwc5GOTq0uW
	JCoesK1gaXz+UbA6CIQWVAPzmincCQy6hTLRnmnuevEZq7C4A==
X-Google-Smtp-Source: AGHT+IHg3z78/B6fI9f1AMjPO5oxiQby/zjwNbzluvzX55f2ZzdxIU/duCJf16X+pSWshaOiz1nVxZsPH9u3Xi8SEBU=
X-Received: by 2002:a05:6902:6c0b:b0:e95:325e:4b8 with SMTP id
 3f1490d57ef6-ea3d99ef88amr56711276.9.1757612255720; Thu, 11 Sep 2025 10:37:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
 <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr>
 <bmbu6dfhr4i37fxlqo7ltalkzz6bocb5whuv34x437k3crie5j@ndtqjrv64n5j> <CAPY8ntD-q6nZcVJmo5OG_6U5cxdOVdwKLJChsQZd_ZFjCRuGZQ@mail.gmail.com>
In-Reply-To: <CAPY8ntD-q6nZcVJmo5OG_6U5cxdOVdwKLJChsQZd_ZFjCRuGZQ@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 11 Sep 2025 18:37:18 +0100
X-Gm-Features: Ac12FXyNwgL-u4JnPwi9yRAYSOfR42S_UZmT1-j1hRuLUlLyzC6xzIVWqjaTRcQ
Message-ID: <CAPY8ntAspTdWB6nNXrkNpZ9TYUtbkxJc_QB3ZmF5iGC31_U33Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 15:21, Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Dmitry
>
> On Fri, 5 Sept 2025 at 17:51, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Fri, Aug 15, 2025 at 06:11:57PM +0300, Dmitry Baryshkov wrote:
> > > On Sat, Jul 05, 2025 at 01:05:13PM +0300, Dmitry Baryshkov wrote:
> > > > Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> > > > registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> > > > now.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > > > This is a part of the HDMI CEC rework, posting separately to let it be
> > > > tested by the maintainers.
> > > > ---
> > > > Changes in v7:
> > > > - Dropped all applied patches, keeping just VC4
> > > > - Link to v6: https://lore.kernel.org/r/20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com
> > > >
> > >
> > > Can I please get Tested-by for this patch? It has been R-B'ed, but I
> > > totally don't think it should be applied without testing on the actual
> > > hardware...
> >
> > And another ping to get it tested by...
>
> Apologies - I'll find a display or AVR that supports CEC tomorrow to test.

I've only got a Sony soundbar here that supports CEC, but I can
control the volume and mute status of that from the Pi, read the
status back, and monitor mode is reporting power on/off events.

A colleague is going to give it more of a test via Kodi when he gets a
chance, but I'm happy to give it a:

Tested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Sorry for the delay in doing that testing.

  Dave

