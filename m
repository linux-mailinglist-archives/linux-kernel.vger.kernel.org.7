Return-Path: <linux-kernel+bounces-730777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE97B049AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8161A60FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4123AE62;
	Mon, 14 Jul 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOc19xVR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D432190676
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529605; cv=none; b=DY+CB/pok51/+puIlYp/zZM3cM0O9qydQES8e/M7FIpLS74+K4S0Ayha1FxDdLXktSsWerCWpcM/12eHcA3ZZ3A7nuT7MLz+DHFP21gAHtG/7O8fC1aP19v9ITfSVdynGb70ZB92MfJSbqqkuaAT1YeYLBDSdbKPFdD2ZA56dFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529605; c=relaxed/simple;
	bh=SsTayAz/zyih+6HafJMOO48aeh1nB7R+B7s9JLkxcNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHPwyTJijTwf7W2XqMuO/WlM0Tbjx4U8LQJwMay3qtliBLOY8RB7SCRRaCKhmXjJOmzT0t3juIpTB/xaieD0WYfuht+2/siFyqUUZb44HccAo17xhW0ULmV0qS0d/k+rGcNlMAFyRRz5rEp5lEV3QGoRwj7sm8D6q3hZaaWMsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dOc19xVR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234d3261631so38482285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752529602; x=1753134402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf6x+HhC3zd0NIuTq8d9fQYj/uBrB2VbMZ8az8HSz24=;
        b=dOc19xVRqnsQE/AC3S9Z9taHm5prOtClGpmtZrgJhxj072Lc2Yp4Bcd2AsawoqdU3e
         TVoNj4HrmtaERxx2WkPR1eINoZwpG/LM47d6vn5P8oCyeFe8IburcVwEDJOAhMfPSe+s
         T4XfqmrdZlGew4D5UDzC13fQBSo3TxcxASv+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529602; x=1753134402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf6x+HhC3zd0NIuTq8d9fQYj/uBrB2VbMZ8az8HSz24=;
        b=hWe78xhlXvqGOZuI3T4OTGlDBsW8KvrMBj4wria41oPJlicf1C4yNhn8hQCvcdbZ6I
         iHuYf4/v9Rh8uiIq5NYLv9ecDBcvFbhAKrkl1AUwrW3P3k1kTGqfajcd3gTUAhyyqLKH
         x7IZJYbCHTJy58UkR8iYmuzu0zrA6oyfUklROUd6dwBU1keBpacNcbOvhXcUH/y+hX/2
         sEr7xzAfuFO6xAcPwcmPJ7tUuzdJIsNvE4cEI/aEqBKgubLw5p14BQ3nnN1vu+pbSUPY
         ouezxJ/KuSzNz217PqaP68GJS/XnLu2nv8WJW7VGcfVmIenxHkuodBMb0T1026onerh9
         uN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2IH9394NbDEKJqCAi6+VRI9LUNseG34k6jG9trqgq5qDZ7bZc0nIQIJ3+2WQ3xe7f4yV0OtpgfOTLBjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1B5ySK1Mp+Ft+R5OlTeMXmF5R2rHYnsUu0gyMkONhL1Fb456R
	EUooJgk0g33QvTX2zJ+b9sEr/v+PtuzcwcEkh/SkyZe4ovy8ivXPfBlZt5i96sFkfFqHvepf6oA
	1AP0=
X-Gm-Gg: ASbGncvml7SVtA+EcbR56kxJOXqRb+JP+Uvx+8PfiROn3ybiBgi1Z3DNd0XgXh/8VnM
	g9RgJmgNcf4RiCqU1tU2tc+KZ85MG490RYHjBJVhI/llZWqHIYx4+Cmop6hxIGOoSlhTQVc7KxR
	c83QmnX2bYyh/Jeqo8SA06803QKZGStBfGcY/GM2138bDj7hR1czFNQ9wBFyGwP5Ity4pyz73ob
	lRI/vas/qFfhskAE893NlSXL4pNpqzcSdSUG+uevpe0MyOkjOhIMg/Aed2KyZC82I2awFtdCygy
	DC3iMigmbPJrdz1hPh2yuWPm4Vq1ChSXCKZJ6KUUPU2x72igEwd7uB6kKS+euU3U2CL1UnPZCPb
	IQ3vqmmOQNT7xWFz1Rytq73CvBO0X+SGhasiEF6DxTzEGEV44Npeflxlxp16gyTnG+ttFZmODzj
	PJ
X-Google-Smtp-Source: AGHT+IFGHMU+Hh4/kjFOJgceElTIe/ZydrXRST3qE83tEMJhQzp0VYmSKmH57+UaTRYHyRtyitjqVw==
X-Received: by 2002:a17:902:ef03:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-23dedea54f2mr262845645ad.49.1752529602174;
        Mon, 14 Jul 2025 14:46:42 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad9efsm103469835ad.58.2025.07.14.14.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:46:41 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3508961d43so4267748a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2CQBVjHQ+qMYReXLQ0LUxsh+IkraZqTKqWkxyKwdOJmJP+lD3LUcGuZPVJH2He21X2fGXSrKXGKU+A94=@vger.kernel.org
X-Received: by 2002:a17:90b:5844:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-31c4ccceb76mr25097897a91.14.1752529600346; Mon, 14 Jul 2025
 14:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708073901.90027-1-me@brighamcampbell.com> <20250708073901.90027-2-me@brighamcampbell.com>
In-Reply-To: <20250708073901.90027-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 14:46:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaNsMRqv_ncr-Xr9pVQGAxUtwwQPmv7h=xqv6RtDUvmg@mail.gmail.com>
X-Gm-Features: Ac12FXwEXFjZNLsblVCVjjFbPn_m7MCfT9M3S1y3Xdmbs1FX9LqidIJ3hvlhjnw
Message-ID: <CAD=FV=UaNsMRqv_ncr-Xr9pVQGAxUtwwQPmv7h=xqv6RtDUvmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/panel: jdi-lpm102a188a: Update deprecated MIPI
 function calls
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 8, 2025 at 12:39=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Update jdi-lpm102a188a panel driver to use the "multi" variant of MIPI
> functions in order to facilitate improved error handling and remove the
> panel's dependency on deprecated MIPI functions.
>
> This patch's usage of the mipi_dsi_multi_context struct is not
> idiomatic. Rightfully, the struct wasn't designed to cater to the needs
> of panels with multiple MIPI DSI interfaces. This panel is an oddity
> which requires swapping the dsi pointer between MIPI function calls in
> order to preserve the exact behavior implemented using the non-multi
> variant of the macro.

Right. We dealt with this before with "novatek-nt36523"...


> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 160 +++++++-----------
>  1 file changed, 59 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/=
drm/panel/panel-jdi-lpm102a188a.c
> index 5b5082efb282..5001bea1798f 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> @@ -81,25 +81,20 @@ static int jdi_panel_disable(struct drm_panel *panel)
>  static int jdi_panel_unprepare(struct drm_panel *panel)
>  {
>         struct jdi_panel *jdi =3D to_panel_jdi(panel);
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx;
>
> -       ret =3D mipi_dsi_dcs_set_display_off(jdi->link1);
> -       if (ret < 0)
> -               dev_err(panel->dev, "failed to set display off: %d\n", re=
t);
> -
> -       ret =3D mipi_dsi_dcs_set_display_off(jdi->link2);
> -       if (ret < 0)
> -               dev_err(panel->dev, "failed to set display off: %d\n", re=
t);
> +       dsi_ctx.dsi =3D jdi->link1;
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       dsi_ctx.dsi =3D jdi->link2;
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>
>         /* Specified by JDI @ 50ms, subject to change */
>         msleep(50);

Needs to be mipi_dsi_msleep() to avoid the sleep in case the above
commands caused an error.


> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
> -       if (ret < 0)
> -               dev_err(panel->dev, "failed to enter sleep mode: %d\n", r=
et);
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
> -       if (ret < 0)
> -               dev_err(panel->dev, "failed to enter sleep mode: %d\n", r=
et);
> +       dsi_ctx.dsi =3D jdi->link1;
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       dsi_ctx.dsi =3D jdi->link2;
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);

I think you need this here:

if (dsi_ctx.accum_err)
  return dsi_ctx.accum_err;

...otherwise the code will do the sleeps, GPIO calls, and regulator
calls even in the case of an error. You don't want that. Then at the
end of the function you'd just have "return 0;"


>  static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
>                                        struct mipi_dsi_device *right,
>                                        const struct drm_display_mode *mod=
e)
>  {
> -       int err;
> +       struct mipi_dsi_multi_context dsi_ctx;

I think you should actually pass in the "dsi_ctx" to this function
since the caller already has one. Then you can change it to a "void"
function...


>  static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
>  {

I think you want to pass the context into this function too and make
it "void". Then the caller doesn't need to check for the error before
calling it...

Then the "msleep(150)" after calling this function can change to a
`mipi_dsi_msleep()` and you don't need to check the error until right
before the LPM flag is cleared...


> +       struct mipi_dsi_multi_context dsi_ctx;
> +
>         /* Clear the manufacturer command access protection */
> -       mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
> +       dsi_ctx.dsi =3D jdi->link1;
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
>                                    MCS_CMD_ACS_PROT_OFF);
> -       mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
> +       dsi_ctx.dsi =3D jdi->link2;
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
>                                    MCS_CMD_ACS_PROT_OFF);

All the duplication is annoying. In "novatek-nt36523" I guess we only
needed to send _some_ of the commands to both panels and so we ended
up with a macro in just that C file just for
mipi_dsi_dual_dcs_write_seq_multi(). ...but here you seem to be
needing it for lots of functions.

Maybe the solution is to add something like this to "drm_mipi_dsi.h":

#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, _args...) \
  do { \
    (_ctx)->dsi =3D (_dsi1); \
    (_func)((_ctx), _args); \
    (_ctx)->dsi =3D (_dsi2); \
    (_func)((_ctx), _args); \
  } while (0)

Then you could have statements like:

mipi_dsi_dual(mipi_dsi_generic_write_seq_multi, jdi->link1,
jdi->link2, &dsi_ctx, ...);

I _think_ that will work? I at least prototyped it up with some simple
test code and it seemed to work... What do others think of that?

-Doug

