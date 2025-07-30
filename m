Return-Path: <linux-kernel+bounces-751322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74141B167B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AA216F9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2821FF23;
	Wed, 30 Jul 2025 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFrQ6aFV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3301D54EE;
	Wed, 30 Jul 2025 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907924; cv=none; b=RWr874mLDV24dj8D7up1oTQdBAPCbYRAgXc9YhzZFy+u/6ZstjlMwEXM9LpNAM0DK0YFI5CVgrW8MwOq0xaxQthMWIcOJDmINO83/ZeNedlRDOdO7mqPCQBWuXWulIO7PwH7H5DXydURTVtjQDFa9PsYfDL2pjxqw1TdkrQgna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907924; c=relaxed/simple;
	bh=kfkv1wZ+Pc1jy15de7WzAlnIqJkaVmE39OmHnnoo/Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYynOzxLc+ci+8AZ+5ErnEfpnjnTDh1fiUNVTQVqVlVE8/pFmR4zy/lBlzBJQTVZQRL5KXyb5Ylq6fJInOjOMVpqyZyzUmbLeFuzX204ZMG6YPLDmeLojRGMiZBJkl2tOIRoQORnv50fBSRHdzjTWKxCLjsHy6c7CkXfPdrLh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFrQ6aFV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so1227235e9.0;
        Wed, 30 Jul 2025 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753907921; x=1754512721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8Afm5kY+OgAWjgm6x2CIfrrEQg5mJMOKBZYCANj5hg=;
        b=FFrQ6aFV1i5e4Ui+NaHb+qUq3oOT4MuvT9Q8a2qaQ70dakL8bCEPsLiiasIsT9lYHH
         A2Wn7mX2l6pNHNnDYHNlj5OBMRKcLttSGkHCEd1X1dCGiNRin/jiaSCKRj/q7nwi63+5
         /0pzclHN+DuEQogdR4BgsczRD3cuGboNH6exElypvXSW96Nk+aHpVMb2BMO576OzxcQO
         ZpLcrF+G8tAni5xXre9mDcUoWj6gRJSfZY/pEhzSCzVMYh6UXMRx3TSk2yLerWJ2uhcz
         uYjmp5M69aptv0aZW6QqjFJjJ5WAzvRp0FDNzFrNj07lfujblbVlYpFYJC/CzfYaT21h
         Fzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753907921; x=1754512721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8Afm5kY+OgAWjgm6x2CIfrrEQg5mJMOKBZYCANj5hg=;
        b=Q3wFnxOzgqIR+fuDtqKCgXzvbNw3NHvHiQscJgOl1XaWFd+6sM/aX+3YDSVWjNhnBr
         yPiYawBK5H9P871JDQuqfcgUQfhlyHYIhwrYUCdOBywvOVTgTqXwiAJSzW8rBVa1cUbt
         lub6fRTDtTXJUQtkXewfh+anIHI9cLnyUN8xwwb4kCMxDAbRtwPjTTTPhq0ouop4Ggv/
         wqZ8BRCiCS2HWJRx3sKfdBy8IDv+a9WT3mEn+cuSicdMgQD8AiWh6LSThWng9eFTXgzM
         bd006kNUigM4SLDW4cS0/Hgqy/43D2ScMbJVuGqC1EiOBltsj2gtonTJi8VOKPXe2YV5
         9Qng==
X-Forwarded-Encrypted: i=1; AJvYcCVqovmHTdqxJYBOTg1pAqCbrQlvGFRbncX6omimg2hAdRQkhm/riem58sYYFwVRu5oK3qcCqYUjnCR5@vger.kernel.org, AJvYcCWh8m8takszqMMjT4iNuLuvjI2RPA0MVPP2U1HdkVMsB5fIAB+IKy/i1pdXi/GeZAW6wUwfZqsxf+S99h66@vger.kernel.org
X-Gm-Message-State: AOJu0YybKhYzIydrH/XiUTcFN0j3w7N2myb7o/mGUKWp4TVtKR0h40CH
	QrMzypMy5+cxmRJDxhrGS0RxHR1+gM++6Xq9580ZQrgW39ZpVXIVnXq3+KDqsYNleYpnk771oyI
	ykI+3SYu/7DKXAs81Yk4ESiVCSck5CA==
X-Gm-Gg: ASbGnctW5TJKu6ooA8SuSZN3gxhLhQ4UNOjQ5ujvZTtDWPQvB3aZ+yZO99YYSxqu3ym
	agDXv+72T/luPzdEMy8piH9i9M2xUKHz6BBCMWY5WiRaAfk29zu6nHGOuVUXotdLJFr0ZRcmGcp
	E8pdNAORJOHvuU6XFklRXO9dF334XNWhgcy6cclzRuZHDJxktVA/D7R68AEA0pdRKTrykcSlPQz
	icwXII=
X-Google-Smtp-Source: AGHT+IF71tNBC+tWZFByXJpnEJB/lxS/QinOOCOXcHd7IWr/NovKj6aZybOP+4ABU2G9GfQ69trGOH4ZFy9NYgrGbXo=
X-Received: by 2002:a05:600c:a103:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-45891b17431mr34509625e9.1.1753907920608; Wed, 30 Jul 2025
 13:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
 <20250727165846.38186-4-alex.vinarskis@gmail.com> <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Date: Wed, 30 Jul 2025 22:38:28 +0200
X-Gm-Features: Ac12FXwM4HeHJZZlcXMgpjN9-RQpaNQ_Bsz2F6A2gi95crriPvDr8wjeZ9Wk22E
Message-ID: <CAMcHhXp47zmpoNYLCVRWWBk4HcYepgWX=3kWWzW8c8+a=2kE6A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel-edp: Add BOE NV140WUM-N64
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 17:50, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Jul 27, 2025 at 9:58=E2=80=AFAM Aleksandrs Vinarskis
> <alex.vinarskis@gmail.com> wrote:
> >
> > Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
> > eg. Asus Zenbook A14 UX3407QA.
> >
> > The raw edid of the panel is:
> > 00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
> > 10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
> > 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
> > 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> > 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> > 4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> > 00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8
> >
> > 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> > 88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
> > 5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
> > 2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
> > 00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
> > 40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
> > 00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> > 01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90
> >
> > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 9a56e208cbdd..b334926e96ed 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT1=
40FHM-N47"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Un=
known"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT=
116WHM-N44"),
> > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e50_p2e80=
, "NV140WUM-N64"),
>
> Since this is a "guess" timing without any datasheet, I'd be more
> comfortable picking the most conservative of the "cousin" timings. Can
> you re-send with "delay_200_500_e200" instead?

Sure.

Do I understand correctly that more conservative delay_200_500_e200
will for sure not make it worse, since its more conservative? In that
case can re-spin right away. Otherwise I would prefer to re-test it
first, may take a few days as I do not own the hardware so need to
propagate the change and get some feedback.

Thanks,
Alex

>
> -Doug

