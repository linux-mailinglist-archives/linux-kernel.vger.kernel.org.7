Return-Path: <linux-kernel+bounces-814687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7EB55752
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2071B7C84D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97892BCF6A;
	Fri, 12 Sep 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAlYo7jh"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191618FC97
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707391; cv=none; b=LAbOHxEWD8LgJ8LlPbUXZhLy2rL8MBHkOwade/GFOPHmRPL+VbWRqIwPmzon8IcFjGWAxkzWT1O5VkTtvn0CIXcQtqmf7PD0A29n6cVASTBrPqlYT96rMQjIxJYEnLUa0mIwEjDjFVtYj6/wzjccFx8RdXt0JEeXO38Oy/7brjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707391; c=relaxed/simple;
	bh=SA1r3HJwL11UUUG5TAwjOAxQwWHC3nzFcZ0sxC8QGqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNrNes+EKE4Z5WWkUJXD9BFqOw07IadBxKE2g6dnTfMjKmvTlgY1nmigKkL4Q+xAy2kqXeV2upUQ6Vi+AYyh8N57Ng/Bj97v866uAPGcD4zeBOmqMeReUKpKUd1QLS2Xd+I8psAWOmsmcR271HYcmMiwEBiynfHg/gzV4H1hjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAlYo7jh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1724980a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757707388; x=1758312188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNPhp+ipV6YHy8ygdz2BuL9Dch2oYXGoWglyuscHFeY=;
        b=CAlYo7jhTi6/NSthotveAzUruOucONxP4fcey6jPuWrHCXoVglvXM0mBgj80PbBhuF
         SJi//Fjp+YXi22CGo4j+tAY6Aej64vYJh2DVUlr0k1VKNRQCPo62Oj4UbHz5BCVfBZ/d
         oBTBu6AFE7SqMaK6TWdv6FklippcO5raJhLco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707388; x=1758312188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNPhp+ipV6YHy8ygdz2BuL9Dch2oYXGoWglyuscHFeY=;
        b=MVoqbSCtosGJ5xUfqrd9oMRAOilOKHilp4cUH6R0Aoi5Bo+D/ZRGFka6t1dgMMTYy2
         IfX/BHUYBOzudTMxCgwS4GuTF2J+M463lbfE/vfZntXhhFumBBFavRQW7KUz5PUp3MUe
         /Z78Ycrn0FunStzTnTSx+uUHUxA8WYS4raQWJCmJ4BP+DrVru0zmYqcdOvPmxIgGE1DC
         eNmB/gTGQStQ5YCLbWnPfCE9Q6xjXrzTgSgmIPLzRh0Va9/TlC7d6WyFkjuaURwwzIrB
         hh9iox7pK4Yhd2WS04CeeIsA9Fybkwh5zAW3NXzjkPGFP+3TqDDT2BzEdCWZNUwo+CZF
         ODTw==
X-Forwarded-Encrypted: i=1; AJvYcCWXjpcV+Usv8/RjuHq1w9P6F6/FsyLBIUg+iiHDjF91j/F1Wu32V/VzjOUI1fUhDuqjSNZoecgJEL7NJGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ccSD8rv2zB3K4I3QcyYsBZeQvxdYsiePyMOFKsuSnESDVM8r
	o+Cs+80AuW6fe8BdgOzI53AROD+PBfnf46Y4il32YkwweCwvrUZf7OoPo97cD9sdfc1vmj0w+QS
	Iq8Q=
X-Gm-Gg: ASbGncsHSfuGqwFJFLJi4F7Abu5stAAIgHRiBAtYRLnMh8lgw1is4a8ZZXkefzzyT0c
	mF/5Ck2bt75FKja+TXDJA+WTdhUG/cNE+EIPLrnH6pATUGfNKBcpalhQJX2v6VNmVR3QH68tNLa
	YHSLFj00EiLlTYMPpOF7xcyquXF8gFqjTUaFMlj0H6MMp6ylibgZlP//Ia2u7dth2XA/0sVXl+1
	Lc23ALhJgPyUf+lltFZFXeo32vOEE+tMJ96+6GZysOj5cu8a2XKl7AEY5RogKy9f3/aywnOJByl
	wutUFP8xV4adL/jEMNc4qtsaUbO9AKMPr4C++rZqZ7pLxMQW+VL6DwaVcmxY7XIK1OSRdR9eIT7
	m4HJOT8r6LuEkCyjMLHTk2K2+E7DpSXJh/JfbMVM3buvrVKuf0sQf0NBLF+wH5tHKcg==
X-Google-Smtp-Source: AGHT+IF3mqwxEiTre3tido9H+hLq/JrIzZiDRJy2G73iUfs9XxFe0kOzW4n+l88GTvySJ/ftrb8ZMg==
X-Received: by 2002:a17:903:b0b:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-25d2675e964mr48598345ad.39.1757707387597;
        Fri, 12 Sep 2025 13:03:07 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ab4345csm57259815ad.96.2025.09.12.13.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 13:03:06 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1539873a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXor8qxngxyTdVOSHiKa1sQAmdm5rxSMHwanUxIcZTifdbhvigN+23p5LC6o5CCUAWJu0xcqOw7K39oquo=@vger.kernel.org
X-Received: by 2002:a17:902:e890:b0:24c:e372:9ddd with SMTP id
 d9443c01a7336-25d243eff6bmr44065315ad.10.1757707385774; Fri, 12 Sep 2025
 13:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910183353.2045339-1-john.ripple@keysight.com> <20250912192457.2067602-1-john.ripple@keysight.com>
In-Reply-To: <20250912192457.2067602-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 12 Sep 2025 13:02:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X531iXsAkoGMd9Lr=wbzUx2MM9uXV_Azkj-ww6jjLaVw@mail.gmail.com>
X-Gm-Features: Ac12FXwJF6xPZ6MPSlPKll3tMfGq-zDPLP1Lehz4iQdkPaHJnfcDsI0EcPTDY74
Message-ID: <CAD=FV=X531iXsAkoGMd9Lr=wbzUx2MM9uXV_Azkj-ww6jjLaVw@mail.gmail.com>
Subject: Re: [PATCH V4] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
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

On Fri, Sep 12, 2025 at 12:25=E2=80=AFPM John Ripple <john.ripple@keysight.=
com> wrote:
>
> @@ -153,6 +164,8 @@
>   * @ln_polrs:     Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG=
.
>   * @comms_enabled: If true then communication over the aux channel is en=
abled.
>   * @comms_mutex:   Protects modification of comms_enabled.
> + * @hpd_enabled:   If true then HPD events are enabled.
> + * @hpd_mutex:     Protects modification of hpd_enabled.

nit: order should match the order of elements in the struct, so
hpd_enabled should be above comms_mutex.


> @@ -1219,11 +1261,33 @@ static void ti_sn_bridge_hpd_enable(struct drm_br=
idge *bridge)
>          */
>
>         pm_runtime_get_sync(pdata->dev);
> +
> +       if (client->irq) {
> +               /* Enable HPD events. */

nit: the comment probably doesn't buy us too much...


> +               ret =3D regmap_set_bits(pdata->regmap, SN_IRQ_EVENTS_EN_R=
EG,
> +                                     HPD_REMOVAL_EN | HPD_INSERTION_EN);
> +               if (ret)
> +                       pr_err("Failed to enable HPD events: %d\n", ret);
> +       }
> +       mutex_lock(&pdata->hpd_mutex);
> +       pdata->hpd_enabled =3D true;
> +       mutex_unlock(&pdata->hpd_mutex);

For enable, I think you want this _above_ the setting of the bits.
Then if an interrupt fires right off the bat you'll see it. That also
matches the intuition that usually enable and disable should be mirror
images of each other (they should do things in the opposite order).


>  }
>
>  static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
>  {
>         struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +       const struct i2c_client *client =3D to_i2c_client(pdata->dev);
> +
> +       if (client->irq) {
> +               /* Disable HPD events. */
> +               regmap_write(pdata->regmap, SN_IRQ_EVENTS_EN_REG, 0);

To make it symmetric to ti_sn_bridge_hpd_enable(), you should probably
use regmap_clear_bits(). Then if we later enable other interrupt
sources then they'll stay enabled.


> +               regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, IRQ_EN, =
0);

I don't think you need to clear this. It can just stay enabled but no
interrupts will fire since there are no interrupt sources. This will
make things work right if we later enable other interrupt sources.


> @@ -1309,6 +1373,38 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
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
> +       bool hpd_event =3D false;
> +
> +       ret =3D ti_sn65dsi86_read_u8(pdata, SN_IRQ_STATUS_REG, &status);
> +       if (ret)
> +               pr_err("Failed to read IRQ status: %d\n", ret);

You should not only print but return IRQ_NONE here IMO. If there are
constant errors (for whatever reason) the interrupt will eventually
get disabled by the system which is better than storming. It also
means that later code doesn't access a bogus "status".


> +       else
> +               hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTIO=
N_STATUS);
> +
> +       if (status) {
> +               pr_debug("(SN_IRQ_STATUS_REG =3D %#x)\n", status);
> +               ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, st=
atus);
> +               if (ret)
> +                       pr_err("Failed to clear IRQ status: %d\n", ret);
> +       } else {
> +               return IRQ_NONE;
> +       }

FWIW: Linux conventions usually are to handle error cases in the "if"
case to avoid indentation (because you don't need an "else"). AKA:

if (!status)
  return IRQ_NONE;

pr_debug(...)
ret =3D ...
...

