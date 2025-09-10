Return-Path: <linux-kernel+bounces-811014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42337B522F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7988B58721B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530BC2F6181;
	Wed, 10 Sep 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UFoXCpJY"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926B2F546E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537326; cv=none; b=Qt3BrTdO8/Z/H3GSWEhwpl/W3v6nFCJBrtOKzukAoLBLns4W3YGWUx/7oeF9aKo3hD61Q5AxWvwrEEliin5nVDu9I+tiGVndlN+QjyDz5e2KG3n1coASnP3/twZEIQfcJ8lbml7uyC0FZR2yODxataLnWzid8LQvXHj1BQRX2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537326; c=relaxed/simple;
	bh=jLmALDdGeFk7jrQ93WBTn8GQyLiy8uLwVinGTlqT50w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2o+iAyEiQRr0uQ1HHtWDqcKj0hz9vr47HhsaJYcXAFPeHQ4Jv0pbwbwmdsvs+JTLivGSbdJK0yrjeiINrZfJ2hdjTESkxpKd1amfaJ4s3Is8Vy7EyV7/BXfRn5phWGxG8BLSRzowME74eRNGKiAN/+SbjlvcQ+AuVyx/HdCVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UFoXCpJY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47052620a6so813691a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757537320; x=1758142120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT8JQ5MwN/AoQ1SPOJ05aLQv7X9XnNCuIU1qg5EIKK4=;
        b=UFoXCpJYXxTxpkftI/kSOsx5HPKWXs2INEV2oH4lqelGjV0x7P3ECEREGwc6WnmboO
         oDXr3cfraPvFoIYoqYLc0e5hCsdlSCDSF8ctoLbSXlrwp5/t8hx8rAVo6Yh8xUu3GLZJ
         a+9PIbMt3QPTm2bdcZ/yoQno4zB4UPYRR+HQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537320; x=1758142120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT8JQ5MwN/AoQ1SPOJ05aLQv7X9XnNCuIU1qg5EIKK4=;
        b=fe05GiQ9R4WAbC3h8qUuo312pG/gJW7HOmAAYA+/LZdQBNV5AiC3+gUhnlNr5o1dZJ
         OaPmriLeOpCAro+RiIowPEEZlUM23odI9zcRxNX3/3C8IF0tr+hbxIii1jC4tfFLj36O
         XuwYfUNN00rakRtkL5YoWKNDCkT8N/i826e8PRCJrzedu1iJdR+asaAhDyN5jqlJypD4
         nPTj/91mPzSP/oWWF6RQbfvPkpgpRBI0OZVojlPg1PBhpB1H77vJ2YFM1ufaLt8Ck8cw
         YhKUy+P4zKp6LkJNwMUMRctwx4fLTeG1ZZzUXoKhUXimtJgtYH54wWHmEE04HaUY5pgz
         Pl5g==
X-Forwarded-Encrypted: i=1; AJvYcCWNX+lwUsAUkoVHHn/XVZbgRdEkR4HzUkbdvP/j5teM8ZHC2Lun2n76gnIJte9vZlUI0hFHBURJYJiQ3R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQEfrZ/u3lAd+BovyNiWn2+B+XmXUHu9tLushUd+CZXozSpO5
	2vKEd/51UbVbLlW4N2bzZ1UynSjQ/qnWNP7VrQ1P3p0Y8YmZboRpnlvCGz0vGUvIamGt/pPhYa2
	D4b0=
X-Gm-Gg: ASbGncucHCBvSPjie7bZrGNT5aD3qmDdI+1eipDUpX7sNCvwBBDZ9+vVtD1Azaxgk0R
	rYysT57JFbIl5pL9BjGf90Lj3+9KqppCJcgMqEU8Edn+drmCkEPUhq/Juo2L0vj84V6reXVMKfR
	CRzLpx1mgFbkctYilHtjuMOeS+WvlHkl7jvv29xTjvxRfopJnSnaFXnnu6KzKo97R9tOc0lcirM
	I7Li4yUsTySgbTZaHa7Gx+PEDxDnrBsqhv01V8aqEYTg6SYNiqJd1ER3JICQ7ekjCh+tPGSukjO
	kWJ8EPeAwWobRXCI5Y6a0ik3be1zvqkiSaRDWhI0r9CK90fjIQIcSUZTzr6LSZM7qOYiqJAHXwW
	h5WTFhXNGdD/nB2edoYhohot3vuXjbIKWX/yqyNAUNpB2ddKOsshjnXXcp99AoRudLQ==
X-Google-Smtp-Source: AGHT+IHhz7b9mHrnsEjI07YvBsKqI98BeOhKMoSn5qm0t9Wyd0yWSjbtVpWgECa5bHeDTS8oKGFE6w==
X-Received: by 2002:a17:90b:5845:b0:32d:a1e9:abad with SMTP id 98e67ed59e1d1-32dd1d983c5mr935401a91.15.1757537320311;
        Wed, 10 Sep 2025 13:48:40 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6306edfsm33403a91.18.2025.09.10.13.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:48:39 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7725147ec88so34835b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:48:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNSA8wuWgS6P7aP5wso1Dzclh36tkIn/bZs1MbdyoV2Aoy1J2MJDAaWxwuuzNFZtjmCtZST2PsLFHmUbY=@vger.kernel.org
X-Received: by 2002:a05:6a21:99a9:b0:246:1e3:1f7e with SMTP id
 adf61e73a8af0-25cf5f1d580mr1027298637.5.1757537318041; Wed, 10 Sep 2025
 13:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908203627.3750794-1-john.ripple@keysight.com> <20250910183353.2045339-1-john.ripple@keysight.com>
In-Reply-To: <20250910183353.2045339-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Sep 2025 13:48:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Um5NKHFZJJkC6eC0rnea0xSPeWVpK91PwGcrRjri28NA@mail.gmail.com>
X-Gm-Features: Ac12FXwYIEESDkT-zb7rIJeqLVKJJ9SFgSrURKxbWC5dUsSzlebV9madmjHaYek
Message-ID: <CAD=FV=Um5NKHFZJJkC6eC0rnea0xSPeWVpK91PwGcrRjri28NA@mail.gmail.com>
Subject: Re: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
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

On Wed, Sep 10, 2025 at 11:34=E2=80=AFAM John Ripple <john.ripple@keysight.=
com> wrote:
>
> @@ -221,6 +236,23 @@ static const struct regmap_config ti_sn65dsi86_regma=
p_config =3D {
>         .max_register =3D 0xFF,
>  };
>
> +static int ti_sn65dsi86_read_u8(struct ti_sn65dsi86 *pdata, unsigned int=
 reg,
> +                            u8 *val)

nit: indentation is slightly off. checkpatch --strict yells:

CHECK: Alignment should match open parenthesis
#79: FILE: drivers/gpu/drm/bridge/ti-sn65dsi86.c:240:
+static int ti_sn65dsi86_read_u8(struct ti_sn65dsi86 *pdata, unsigned int r=
eg,
+                            u8 *val)


> @@ -413,6 +446,13 @@ static int __maybe_unused ti_sn65dsi86_resume(struct=
 device *dev)
>         if (pdata->refclk)
>                 ti_sn65dsi86_enable_comms(pdata, NULL);
>
> +       if (client->irq) {
> +               ret =3D regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, =
IRQ_EN,
> +                       IRQ_EN);

nit: checkpatch --strict yells:

CHECK: Alignment should match open parenthesis
#112: FILE: drivers/gpu/drm/bridge/ti-sn65dsi86.c:451:
+               ret =3D regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, IR=
Q_EN,
+                       IRQ_EN);


> @@ -1219,11 +1262,32 @@ static void ti_sn_bridge_hpd_enable(struct drm_br=
idge *bridge)
>          */
>
>         pm_runtime_get_sync(pdata->dev);
> +
> +       mutex_lock(&pdata->hpd_mutex);
> +       if (client->irq) {
> +               /* Enable HPD events. */
> +               val =3D HPD_REMOVAL_EN | HPD_INSERTION_EN;
> +               ret =3D regmap_update_bits(pdata->regmap, SN_IRQ_EVENTS_E=
N_REG, val, val);

nit: regmap_set_bits() ?

...and then you don't need the "val" temporary variable.


> +               if (ret)
> +                       pr_err("Failed to enable HPD events: %d\n", ret);
> +       }
> +       pdata->hpd_enabled =3D true;
> +       mutex_unlock(&pdata->hpd_mutex);

So I _think_ you only need the mutex around the set of "hpd_enabled".
Really the only things you're trying to do are:

* Make sure that by the time ti_sn_bridge_hpd_disable() returns that
no more HPD callback will be made

* Make sure that after ti_sn_bridge_hpd_enable() is called that the
next interrupt will notice the update.

So I'd make the enable case look something like this:

  mutex_lock(&pdata->hpd_mutex);
  pdata->hpd_enabled =3D true;
  mutex_unlock(&pdata->hpd_mutex);

  if (client->irq) {
    /* Enable HPD events. */
    val =3D HPD_REMOVAL_EN | HPD_INSERTION_EN;
    ret =3D regmap_update_bits(pdata->regmap, SN_IRQ_EVENTS_EN_REG, val, va=
l);
    if (ret)
      pr_err("Failed to enable HPD events: %d\n", ret);
  }

...and the disable case:

  if (client->irq) {
    /* Disable HPD events. */
    regmap_write(pdata->regmap, SN_IRQ_EVENTS_EN_REG, 0);
    regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, IRQ_EN, 0);
  }

  mutex_lock(&pdata->hpd_mutex);
  pdata->hpd_enabled =3D false;
  mutex_unlock(&pdata->hpd_mutex);


Does that seem reasonable?


> @@ -1309,6 +1373,44 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
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
> +       mutex_lock(&pdata->hpd_mutex);
> +       if (!pdata->hpd_enabled) {
> +               mutex_unlock(&pdata->hpd_mutex);
> +               return IRQ_HANDLED;
> +       }

I also think you _always_ want to Ack all status interrupts so there's
no way you could end up with an interrupt storm, so you shouldn't do
this early return.


> +       ret =3D ti_sn65dsi86_read_u8(pdata, SN_IRQ_STATUS_REG, &status);
> +       if (ret)
> +               pr_err("Failed to read IRQ status: %d\n", ret);
> +       else
> +               hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTIO=
N_STATUS);
> +
> +       if (status) {
> +               drm_dbg(dev, "(SN_IRQ_STATUS_REG =3D %#x)\n", status);
> +               ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, st=
atus);
> +               if (ret)
> +                       pr_err("Failed to clear IRQ status: %d\n", ret);
> +       } else {
> +               mutex_unlock(&pdata->hpd_mutex);
> +               return IRQ_NONE;
> +       }
> +
> +       /* Only send the HPD event if we are bound with a device. */
> +       if (dev && hpd_event)
> +               drm_kms_helper_hotplug_event(dev);
> +       mutex_unlock(&pdata->hpd_mutex);

I think you only want the mutex to protect your checking of hpd_mutex
and sending the "drm_kms_helper_hotplug_event()". I don't think you
need it for the whole IRQ routine. AKA:

mutex_lock(&pdata->hpd_mutex);
if (hpd_event && pdata->hpd_enabled)
  drm_kms_helper_hotplug_event(dev);
mutex_unlock(&pdata->hpd_mutex);

...and you don't need to check for "dev" being NULL because there's no
way "hpd_enabled" could be true with "dev" being NULL. At least this
is my assumption that the core DRM framework won't detach a bridge
while HPD is enabled. If nothing else, I guess you could call
ti_sn_bridge_hpd_disable() from ti_sn_bridge_detach()


> @@ -1971,6 +2075,28 @@ static int ti_sn65dsi86_probe(struct i2c_client *c=
lient)
>         if (strncmp(id_buf, "68ISD   ", ARRAY_SIZE(id_buf)))
>                 return dev_err_probe(dev, -EOPNOTSUPP, "unsupported devic=
e id\n");
>
> +       if (client->irq) {
> +               ret =3D devm_request_threaded_irq(pdata->dev, client->irq=
, NULL,
> +                                               ti_sn_bridge_interrupt,
> +                                               IRQF_TRIGGER_RISING |
> +                                               IRQF_TRIGGER_FALLING |
> +                                               IRQF_ONESHOT,
> +                                               "ti_sn65dsi86", pdata);
> +
> +               if (ret) {
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to request interrupt=
\n");
> +               }
> +
> +               /*
> +                * Cleaning status register at probe is needed because if=
 the irq is
> +                * already high, the rising/falling condition will never =
occur
> +                */
> +               ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, 0x=
FF);
> +               if (ret)
> +                       pr_warn("Failed to clear IRQ initial state: %d\n"=
, ret);

Actually, wait. Why do you want "rising" and "falling". Isn't this a
level-triggered interrupt? Then you also don't need this bogus clear
of interrupts here...

...and also, I seem to recall it's usually better to not specify a
type here and rely on the type in the device tree. I seem to remember
there being some weird corner cases (maybe around remove / reprobe or
maybe about deferred probes?) if an interrupt type is specified in
both code and device tree and those types don't match...

-Doug

