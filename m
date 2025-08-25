Return-Path: <linux-kernel+bounces-785215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86105B347A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117B1172AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1F301008;
	Mon, 25 Aug 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuQ4VVFn"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC32FE58F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139850; cv=none; b=he4q2+oi6JxdtinPiuhGWa2cU+q9wlXO8LEb8uaZ9v8k1o1r+Cz4eq0zmYRjs12MeCj6OgxBsp4nguOj4unCws7zsgM+w0t3bvYudT9rBq9BztXcNOf4lw4GUUwJrtekXiCmA0CoOLo9MFRzXdJS8RZPIDn+iJk1GsbiYFkK/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139850; c=relaxed/simple;
	bh=QF1rwFGXOpv3/yj99dApQHR7xecK134zyjOuhi0if3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5dsWu5UgwhoO98iiEPemikWqAiD6B3BDYGs/D63qWPy4Mihwqew88ysWw1vXcbSTLheKBqEGxoPXlYOtIrhao+C7Z9HQ0d6DqNCHC4tCPFckwHsU3dbOO5X2rek2uvJKlBIKQJ5GORsjEef13Z+heKmUa9KYQCGYO3jXWCdhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OuQ4VVFn; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e8704e9687so472672485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756139847; x=1756744647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jtHSRITSR2AwU52EE8r+JEB4b68kRsZxs/LuenG8cw=;
        b=OuQ4VVFnaRMhOGUckLeRoe0rFS3XKMkHff3VBCF5Edd7IL72GTp8kJ8DICMGO5dIq0
         +0nT71VmElpGla95iGBCg6P0IQay1stdP/NGnJBwZWS4ii4QR8shKMF9UkTBd2hLaG8o
         I+Ai4WCkyrDq3WFGh3uQd//DmrpZvReU75gIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139847; x=1756744647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jtHSRITSR2AwU52EE8r+JEB4b68kRsZxs/LuenG8cw=;
        b=GiOAFymdD+Nw1TdU61BV750c1CETyLiH7rLnHKWi4ftMoFEzN3NNY2CTvKPk6bosLd
         pVyvUgLFfbdQW0fgp0+PNwqifNe0cFuLi9gxXsybjPh6X9V+NOJ55+8Z4aL1ozc6fZ8r
         F97M7VbJ49m5/63nZghk6IaVaiZ99PLwb1blucJrpDQ6wd9wFaUroBzN4WsSTGwYa1Nt
         eaoz5G2GBE6SKDvxXMxYoUp1as969OeOLJy7NVmQnaBQj8JtHq3FAGrkjmV9ue1cnYsg
         BbY7ZSWepa4IKrrthPL+8lqAbqVp9vTpxzDEdIT6L5n7aS71WUfqpzF/Jpew4jc1Gaxh
         xedg==
X-Forwarded-Encrypted: i=1; AJvYcCWXRjLrQXXQvjl60GCwT5/qb4NzEH9JWXINU8izF3qvi0sZns6Sp/aReEBtrKrYj4wrJIWQ9ZrJqqbcBVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDs05J7pLSGZyybqoraTH9IGVU1qvYgMMCK+ZDKP0cpFsofpFy
	W04l8DC94IColu7B3/0E96vnaHJU0iXNtc5FDMl5lajbD05S/xsKAxUDSSWI4Ggaan4UJBJ8Z6m
	1iiM=
X-Gm-Gg: ASbGnct95iACFBFw5wqQGDjAE6hIhGJZrGJW7NaY7GWuOOJv/vUPbBhDVtQOsllOmE2
	L8DnKXLUPTgpBDABmoz048cYIOM2tnm0euemInWIFF6g45SySeNLtpWjtI2vX3VuyPDcbPzJ3ro
	ZZve/XOvH+DiYfaWhHnBTlhNuHCHp5vZQiWAku7w0w2ir76iuzPUTH/V0vQUvOysq15f6FmLYU9
	6Cf61dgrKpmTz+ZeD+K+y/H2QcobDgn1nsk+cUCdbjpmp5LH9b11mBplsdA5Kf7LU+MUYj3t0rc
	exdil6mtnq3GPht62JaIW5FIiWVpELfdltp62E3SLiZXRtI41RSE39okuJnCgB0iW4T016jtlD/
	UUIb7WB+K9POMTZ8DbqlxEdVkwUSyH8GFp9ojbbBcMlZCu6W39SeiaursNI1m7cYepA==
X-Google-Smtp-Source: AGHT+IF2+YPFWbs+ScXawTo2xCwYA5Fw/L6Cad4dyFgcjWnr19spciqgWwmfBjrK9eSbDtISA+Nakw==
X-Received: by 2002:a05:620a:7188:b0:7e6:9664:2270 with SMTP id af79cd13be357-7ea10fcf124mr1601036785a.23.1756139846889;
        Mon, 25 Aug 2025 09:37:26 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf33111d3sm521476185a.49.2025.08.25.09.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:37:26 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c59dc9so62492401cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:37:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY/fYeFNgztP6x3HoTjqOWzGrWxfnWYm7uMTrc9I9r05AUNp+xQ8Vo8zWcoZjBdY8nXZQPEtBBNAsUjy0=@vger.kernel.org
X-Received: by 2002:a17:902:d486:b0:246:b46b:1b09 with SMTP id
 d9443c01a7336-246b46b2296mr70233575ad.30.1756139405901; Mon, 25 Aug 2025
 09:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818115015.2909525-1-treapking@chromium.org>
 <20250818115015.2909525-2-treapking@chromium.org> <CAD=FV=WCfFWHAh=XxA_jZpMsS_L0U_k=_g_oj36Nd=4winZ24g@mail.gmail.com>
 <pr01os80-s752-1rqp-782q-65nr8222npq7@xreary.bet>
In-Reply-To: <pr01os80-s752-1rqp-782q-65nr8222npq7@xreary.bet>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Aug 2025 09:29:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi88Az-Uce9eS9iWE7byqXUhPWZUnNzPxb2G00J=xVXg@mail.gmail.com>
X-Gm-Features: Ac12FXy0EZz9bvA-Qu-6WzcG016UETXUzwRyI68kZYgUXuuPbSw64uhWpNOBD3o
Message-ID: <CAD=FV=Wi88Az-Uce9eS9iWE7byqXUhPWZUnNzPxb2G00J=xVXg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] HID: Make elan touch controllers power on after
 panel is enabled
To: Jiri Kosina <jikos@kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 19, 2025 at 1:55=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Mon, 18 Aug 2025, Doug Anderson wrote:
>
> > > Introduce a new HID quirk to indicate that this device has to be enab=
led
> > > after the panel's backlight is enabled, and update the driver data fo=
r
> > > the elan devices to enable this quirk. This cannot be a I2C HID quirk
> > > because the kernel needs to acknowledge this before powering up the
> > > device and read the VID/PID. When this quirk is enabled, register
> > > .panel_enabled()/.panel_disabling() instead for the panel follower.
> > >
> > > Also rename the *panel_prepare* functions into *panel_follower* becau=
se
> > > they could be called in other situations now.
> > >
> > > Fixes: bd3cba00dcc63 ("HID: i2c-hid: elan: Add support for Elan eKTH6=
915 i2c-hid touchscreens")
> > > Fixes: d06651bebf99e ("HID: i2c-hid: elan: Add elan-ekth6a12nay timin=
g")
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Note: cuddled the "Fixes" tags and the "Reviewed-by" tag next to each
other while applying.


> > > ---
> > >
> > > Changes in v3:
> > > - Collect review tag
> > > - Add fixes tags
> > >
> > > Changes in v2:
> > > - Rename *panel_prepare* functions to *panel_follower*
> > > - Replace after_panel_enabled flag with enabled/disabling callbacks
> > >
> > >  drivers/hid/i2c-hid/i2c-hid-core.c    | 46 ++++++++++++++++---------=
--
> > >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 11 ++++++-
> > >  include/linux/hid.h                   |  2 ++
> > >  3 files changed, 40 insertions(+), 19 deletions(-)
> >
> > Re-iterating my response from v2 [1] so it's still seen even if people
> > only look at the latest version. :-) If HID folks don't mind us
> > landing this through drm-misc, feel free to Ack this patch.
>
> Acked-by: Jiri Kosina <jkosina@suse.com>

Pushed to drm-misc-next with Jiri's Ack:

[2/2] HID: i2c-hid: Make elan touch controllers power on after panel is ena=
bled
      commit: cbdd16b818eef876dd2de9d503fe7397a0666cbe

NOTE that I added "i2c-hid" into the subject prefix to make things
more consistent.

-Doug

