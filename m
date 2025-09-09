Return-Path: <linux-kernel+bounces-806947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F462B49DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25F616D717
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2F1A2547;
	Tue,  9 Sep 2025 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLNPmpea"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C54176FB1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377053; cv=none; b=hd2seBEiyAG8NKVeahM37TnVlVsMN27RRvcRbKZCD74mS3+CWl/kCEp09kXlY+XN9zz5Dv2Nxu4RyEOjuD2JI6OT23b/+vPOK7xANip0vQzssEIlHfnzm+dIL84S5nXWarpp4LZwyuJ8fhJGWKO2omGKhbQd+L41Zvm903a7Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377053; c=relaxed/simple;
	bh=h02bOFxDFgJmQeKihLSo/y66DpzgMwtwVlGwYce/CsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssify8teKscko1XyFTkJPcoUlWF2Pbm2azT0ek1J52qxCP9/5Y9EddQDj0ipbLIZsLDJtyglbMVrKulxQje0uXYCpeVAO8d8n2Tkmqv7RqSXDDn9+FNj2OIA7PWljCMuVe4CQlfSgJypIN3M+3z/j2b72qVA7U5v+VABAZ+AIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLNPmpea; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-31d75b4d485so2915628fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757377051; x=1757981851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itx043SjSdQPk+Kw357GK+7TP95N+sBwyskpiXa86jc=;
        b=gLNPmpeaU9cm/nI9GOYRQX1NgsFOGer8tuoG2weyjzOXY/NVkbU9CeuGjOO+UNOncO
         vW5I0W/mSxAuOjDK2WqBF/dOg0/VltdZgchCl4eGusxl8YMP4tzNvDl339w1xo403XBr
         PZz8VMD/9XGp65gsLHBf5uZaLxWO4TAAZ7wcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757377051; x=1757981851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itx043SjSdQPk+Kw357GK+7TP95N+sBwyskpiXa86jc=;
        b=N2b/KNAwGYxoWb0gT8mdpfPavMjvJVngY0cdlYK9QHIBtu4YJtwxIM9Jz3nEK74pE4
         LXLT4WtwHlYrjMLOvmhkxaLr4nyIcHVRk7buCwpO08NIRg+F+1jboWQXOXtOHRenzGjR
         OnKETPf2APxyKe3GcIZ14CD4e7yKzaQqZahi7BYPTsnxiBC84nfqA7XV4ElSMonMPazb
         cu6M47RII7EllBKiRM7tKYD07HZioiOq6uYAHLK2XbLWkEYqHTfXvjbLatABZggsw59J
         HtT4wNuTewom67yypjGBRXAktVYU4dMBphmXKTYV3MhJuzAo7x5Xd5tIerbcqpqfuvI/
         OxjA==
X-Forwarded-Encrypted: i=1; AJvYcCV8QIdI0L6jFMt+e6kjeLdS/qdvUCT2d7kZH2qy3PijDKsJ+QejJ/xpsJaxOKurhJSpGVjKf5OpSGoY140=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLE/lFNESr2goI+dLdUp9xGEYuP0V9QQ/9/QbWl7gAg2Acnpv6
	yzM98BIJWdVUo1uZOjrL6wXkCwX1FmDpuSyf7UmV8Ub+XO6xuSUIeiNZXGz45x5thFqnY0plVdh
	O61I=
X-Gm-Gg: ASbGncv1U9cDiCocdy7kWRzxNn9qeZX9h2V8f9AMB3+14rQ6gQgSDCuBi0+k0emdpox
	NXclX8OQ3n4i4NtUIEGT7x+Vb3l73Hs8n2KJarDUq90lvd2riRt1uJZ5bp0md4H/WZpDbRmaDJV
	bQQYlMMPi4uwLMOHUNCIRWJsbJE+zViyveU9xEyjkl9ZXQUvOsNyCnRCuCJbAaKZpDe5piKGZHv
	ymF4HUDEJ8Ueo2Fuurv5LZlRwtBSZmP+T5+7yT/IVuiUOBihi3utYkfKC5RFs5EfrDpEJmmzivc
	5U6814jXr6qUCSUp8RoG1SFFgEiEmMyVxjxKfg9bSM0AuK6l74BnJJVA0qUIUmv6eQJs0yJDOIi
	2kGuxzcaQ7sL9/4lGokeOtSVrnrO2XUI2C3NzVuDcL/NlnBcWpCyhdn8YCABJzA==
X-Google-Smtp-Source: AGHT+IHkKQOGCLbMHybfQKBkxqcINzE2O3K+lCpAx3AgLtF7rKSQbLhP5tOq9odIDCHYVxOE8mSnPg==
X-Received: by 2002:a05:6870:ec8f:b0:2d5:ba2d:80e4 with SMTP id 586e51a60fabf-3226480ece1mr4510255fac.24.1757377050625;
        Mon, 08 Sep 2025 17:17:30 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b60b8c90sm6892552fac.31.2025.09.08.17.17.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 17:17:30 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-32170a988a1so2662026fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:17:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUsJ3X7h48He9lEuB36ejH3Ljfn7I8s1KysRvWXP4u13XL0zV+O5Bayp5HdFLWthlKJnTa1Yr+LHONs4M=@vger.kernel.org
X-Received: by 2002:a17:902:d482:b0:248:e3fb:4dc8 with SMTP id
 d9443c01a7336-25173118fb5mr124363715ad.39.1757376673765; Mon, 08 Sep 2025
 17:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=WiORm+rawNZoinXFZWdt_yqKQfTFWCiBcJFyJKXj4spQ@mail.gmail.com>
 <20250908203627.3750794-1-john.ripple@keysight.com>
In-Reply-To: <20250908203627.3750794-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Sep 2025 17:11:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWhDtFWegUUeACxcrSTFh7kbmwVFy3sioboh2fgk3Evw@mail.gmail.com>
X-Gm-Features: Ac12FXxgUiei5XfyMjceUTcGSF-nx0Z4PTKi6M9_GZuINaaxVjXQ9SGSjiI2sNs
Message-ID: <CAD=FV=XWhDtFWegUUeACxcrSTFh7kbmwVFy3sioboh2fgk3Evw@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org, 
	jernej.skrabec@gmail.com, jonas@kwiboo.se, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch, 
	tzimmermann@suse.de, blake.vermeer@keysight.com, matt_laubhan@keysight.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 8, 2025 at 1:37=E2=80=AFPM John Ripple <john.ripple@keysight.co=
m> wrote:
>
> Add support for DisplayPort to the bridge, which entails the following:
> - Get and use an interrupt for HPD;
> - Properly clear all status bits in the interrupt handler;
>
> Signed-off-by: John Ripple <john.ripple@keysight.com>
> ---
> V1 -> V2: Cleaned up coding style and addressed review comments
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 93 +++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index ae0d08e5e960..ad0393212279 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -106,10 +106,24 @@
>  #define SN_PWM_EN_INV_REG                      0xA5
>  #define  SN_PWM_INV_MASK                       BIT(0)
>  #define  SN_PWM_EN_MASK                                BIT(1)
> +
> +#define SN_IRQ_EN_REG                          0xE0
> +#define  IRQ_EN                                        BIT(0)
> +
> +#define SN_IRQ_EVENTS_EN_REG                   0xE6
> +#define  IRQ_HPD_EN                            BIT(0)
> +#define  HPD_INSERTION_EN                      BIT(1)
> +#define  HPD_REMOVAL_EN                                BIT(2)
> +#define  HPD_REPLUG_EN                         BIT(3)
> +#define  PLL_UNLOCK_EN                         BIT(5)
> +
>  #define SN_AUX_CMD_STATUS_REG                  0xF4
>  #define  AUX_IRQ_STATUS_AUX_RPLY_TOUT          BIT(3)
>  #define  AUX_IRQ_STATUS_AUX_SHORT              BIT(5)
>  #define  AUX_IRQ_STATUS_NAT_I2C_FAIL           BIT(6)
> +#define SN_IRQ_STATUS_REG                      0xF5
> +#define  HPD_REMOVAL_STATUS                    BIT(2)
> +#define  HPD_INSERTION_STATUS                  BIT(1)
>
>  #define MIN_DSI_CLK_FREQ_MHZ   40
>
> @@ -221,6 +235,19 @@ static const struct regmap_config ti_sn65dsi86_regma=
p_config =3D {
>         .max_register =3D 0xFF,
>  };
>
> +static int ti_sn65dsi86_read(struct ti_sn65dsi86 *pdata, unsigned int re=
g,
> +                            unsigned int *val)

This is reading a byte, right? So "val" should be an "u8 *". Yeah,
that means you need a local variable to adjust for the generic regmap
call, but it makes a cleaner and more obvious API to the users in this
file.


> +{
> +       int ret;
> +
> +       ret =3D regmap_read(pdata->regmap, reg, val);
> +       if (ret)
> +               dev_err(pdata->dev, "fail to read raw reg %x: %d\n",
> +                       reg, ret);

nit: use %#x so that the 0x is included.


> @@ -1219,12 +1246,28 @@ static void ti_sn_bridge_hpd_enable(struct drm_br=
idge *bridge)
>          */
>
>         pm_runtime_get_sync(pdata->dev);
> +
> +       /* Enable HPD and PLL events. */
> +       regmap_write(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
> +                    PLL_UNLOCK_EN |
> +                    HPD_REPLUG_EN |
> +                    HPD_REMOVAL_EN |
> +                    HPD_INSERTION_EN |
> +                    IRQ_HPD_EN);

* Shouldn't this be `regmap_update_bits()` to just update the bits
related to HPD?

* why enable "PLL_UNLOCK_EN" when you don't handle it?

* I also don't think your IRQ handler handles "replug" and "irq_hpd",
right? So you shouldn't enable those either?

Also: should the above only be if the IRQ is enabled? AKA obtain a
pointer to the i2c_client and check `client->irq`?


> +
> +       regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, IRQ_EN,
> +                          IRQ_EN);

I guess this is OK to be here if you want, but I would maybe consider
putting it in `ti_sn65dsi86_resume()` if `client->irq` is set. Then if
we ever enable more interrupts it'll already be in the correct place.


> @@ -1309,6 +1352,32 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
n65dsi86 *pdata)
>         return 0;
>  }
>
> +static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
> +{
> +       struct ti_sn65dsi86 *pdata =3D private;
> +       struct drm_device *dev =3D pdata->bridge.dev;

I'm unsure if accessing "dev" here without any sort of locking is
safe... It feels like, in theory, "detach" could be called and race
with the IRQ handler? Maybe you need a spinlock to be sure?


> +       u32 status =3D 0;
> +       bool hpd_event =3D false;
> +       int ret =3D 0;

Don't initialize variables unless they're needed. In this case it's
obvious that both `hpd_event` and `ret` don't need to be initialized.
Maybe you could argue that `status` should be initialized since it's
passed by reference, but even that's iffy...


> +
> +       ret =3D ti_sn65dsi86_read(pdata, SN_IRQ_STATUS_REG, &status);
> +       if (ret)
> +               return ret;

The return for this function is not an error code but an
`irqreturn_t`. You need to account for that.


> +       hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS=
);
> +       if (status) {
> +               drm_dbg(dev, "(SN_IRQ_STATUS_REG =3D %#x)\n", status);
> +               ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, st=
atus);
> +               if (ret)
> +                       return ret;

Same--you can't just return an error code.


> +       }
> +
> +       /* Only send the HPD event if we are bound with a device. */
> +       if (dev && hpd_event)
> +               drm_kms_helper_hotplug_event(dev);
> +
> +       return IRQ_HANDLED;

If "status" gives back 0 (which would be weird), you probably want to
return IRQ_NONE, right?


> +}
> +
>  static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>                               const struct auxiliary_device_id *id)
>  {
> @@ -1971,6 +2040,30 @@ static int ti_sn65dsi86_probe(struct i2c_client *c=
lient)
>         if (strncmp(id_buf, "68ISD   ", ARRAY_SIZE(id_buf)))
>                 return dev_err_probe(dev, -EOPNOTSUPP, "unsupported devic=
e id\n");
>
> +       if (client->irq) {
> +               enum drm_connector_status status;
> +
> +               ret =3D devm_request_threaded_irq(pdata->dev, client->irq=
, NULL,
> +                                               ti_sn_bridge_interrupt,
> +                                               IRQF_TRIGGER_RISING |
> +                                               IRQF_TRIGGER_FALLING |
> +                                               IRQF_ONESHOT,
> +                                               "ti_sn65dsi86", pdata);
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
occurs

nit: s/occurs/occur


> +                */
> +               ret =3D ti_sn65dsi86_read(pdata, SN_IRQ_STATUS_REG, &stat=
us);
> +               ret |=3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, s=
tatus);
> +               if (ret)
> +                       pr_warn("Failed to clear IRQ initial state: %d\n"=
, ret);

Do you even need to read? Can't you just write all possible bits and
that should be safe?

