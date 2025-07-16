Return-Path: <linux-kernel+bounces-733881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1BB07A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2226916EE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AD28643D;
	Wed, 16 Jul 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKPaqyih"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D7266580
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680700; cv=none; b=lp45DteiC9nL3YvqlGVi8PmW5iCj6/iuTh8YSJQdw3VXFv7IT7YxrnomDvOgvhRcUebX6ZO6ghFuomTGAebqhjumnvvNAW+QQCs3l7gWScDXtWdYwBzNZv+AhXTtbrLdqW9jq5KtWccxOhXpRsLI7ZY/xm7eIBM/sHQRZ1PPzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680700; c=relaxed/simple;
	bh=KHuG0uBwyD85bBBOzexQzokycLa49THR+WfTgHz8N6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcYv/ZQmJR9z4IvN4G+y1rK1Dr7ncYhuq8QZSMVt0McxeRJ3U+JrSGuSPqcjxGHfPerBd8DKTbNK1lx2n80pIth90aeri+j1QqsMO7x9/MZE2P5ioLvlUbfi70tpjTq128psk3+KW+wChGYvEVwo2sFD3UAhjqCKFey7/ZOkJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gKPaqyih; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso72936b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752680695; x=1753285495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ03/tmk7tAhzukHNKvzFIC/0i1vTpRRPNMxQZoMDXk=;
        b=gKPaqyihXuS9yFbKJzIZ6V/UHdODSbziHrceWMsP32kQbK8h/CuZntbc61jmbb7Jyn
         cQtINTi+/BlrlNsCVWw5WqcSTjdjUw6pEP/kbRWsJvrMSgCqGpCiBMsRte1r46yHvLTK
         3N/BMbTR7iZ9oc+ztavToM8jaSyR56jGd7GPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680695; x=1753285495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ03/tmk7tAhzukHNKvzFIC/0i1vTpRRPNMxQZoMDXk=;
        b=nsISnmR86BdRjVxcNzkU5kDPJQJvZfQ0JESPpI60M9UyY/9s8XwQFaA7j+Q7UkZ3JM
         63GnwhCKfkrUx0eSK8O08ogM7MSQFYBNQQmCSmk/wbdDyHaaLhO0AN5+9Uy4JgJg0frF
         pvACjdzF9PwF761oMKuofbSLCnjpuKyGwIv0ZaT14xJ9agEV5aOoUsNYIwTP2Zq1dhCe
         4/fMkVKtw+XuAA5gfnCQnw+Z5S8ovFaoQDl/aZ/nh68Bh4rMJDOn1Tcj8IRyfSlg0pKD
         0EWuj29USvU+0pCjmJe6kgmeKoafz/xAMhprG+4EapV727iglDuH4dgDsNmsI+BMVyWU
         iUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3a6cQeXqoG21YRfTiexANroyiLQ3k6AXwzrBR6gkQtmI9u1D3jPok18CQ5uf++Cl/TEPz64Q71QXOKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysmzqqesJY0hpYSfcOuxtm8G+Zbf1HuwLa/O7grTNWLKbpFIU3
	enk9Y+eUcNLMx2U8MYzKL+6v5Bx1JAox1Y75sPn5yVSp4g/NOX4ViCGLJRi4ccMy9ajSyeBoben
	q4i4=
X-Gm-Gg: ASbGncsnm0tsgzLj26Xbw1Zv0QiKTS2P9CfcVNBKi9583P363TTQLnT58ILoG6DL73y
	sj7oigxdJshgufsqVlemB6OvRKCd2zBWSM5JXA42E2617laUH8kVvlIfv6MZmNs/hgFWlW+dXh8
	fX1FO9FCHzyPSq9H5jKL8tQeqK7NVu+SrmIuuE7uwmxd/ZBd/3UcXMv5BjYx/A5TKRDMRAw5Zrd
	uh0cPen+X/gS+iNrrSjjXXN6V1rS//AdzV92ug2OiZGUYDSho/O7Wi1A65FqSwGymH8l7iAd9GH
	DqUHQ2MFLDbrnmzHevHsLVSnslR0f9/OjrRIMGHGQcodJi0hsIO9ZH7rIzhmDYYXog83c9a/WQA
	iLkcZM4Dq/goKWQIzEfeRq/im/kDpYS93Lu99P0y6tDWhnvvppu1AQBOQjrbBuA==
X-Google-Smtp-Source: AGHT+IGCcOSJ5f83mjz/T4/0+BGv/35v0IIUXANqJt7kgTkYvi1zCih9cUz2fbLsftZ19iyRREV+Ag==
X-Received: by 2002:a05:6a00:1795:b0:74e:aba0:6dfd with SMTP id d2e1a72fcca58-75723165609mr3732083b3a.10.1752680694320;
        Wed, 16 Jul 2025 08:44:54 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ec3bd0bcesm11807718b3a.26.2025.07.16.08.44.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:44:48 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313f68bc519so77291a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+PBsGz+zkhZGRlhNRZZEJshwsOV5XngrPocjF5qo7HIgu5kZLVwAOPWzD8Hgf4+lwxH/Guc7e1Gpfmoc=@vger.kernel.org
X-Received: by 2002:a17:90b:2dc4:b0:311:c939:c848 with SMTP id
 98e67ed59e1d1-31c9f36e8e1mr4567738a91.0.1752680685236; Wed, 16 Jul 2025
 08:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708073901.90027-1-me@brighamcampbell.com>
 <20250708073901.90027-2-me@brighamcampbell.com> <CAD=FV=UaNsMRqv_ncr-Xr9pVQGAxUtwwQPmv7h=xqv6RtDUvmg@mail.gmail.com>
 <DBD8F7HINUHO.2487OZTDLKOWQ@brighamcampbell.com>
In-Reply-To: <DBD8F7HINUHO.2487OZTDLKOWQ@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 08:44:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFSN8rnKb4kjhKDhsHv6m+Dxak+rDzrb7VmZ=V096CQg@mail.gmail.com>
X-Gm-Features: Ac12FXzPnC4cUet5LMD_CFhCnn4SKvN-fuGdz2dppJaNkiQ_4gGl1AfqjppU-f4
Message-ID: <CAD=FV=XFSN8rnKb4kjhKDhsHv6m+Dxak+rDzrb7VmZ=V096CQg@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 10:32=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> On Mon Jul 14, 2025 at 3:46 PM MDT, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jul 8, 2025 at 12:39=E2=80=AFAM Brigham Campbell <me@brighamcam=
pbell.com> wrote:
> >>
> >> Update jdi-lpm102a188a panel driver to use the "multi" variant of MIPI
> >> functions in order to facilitate improved error handling and remove th=
e
> >> panel's dependency on deprecated MIPI functions.
> >>
> >> This patch's usage of the mipi_dsi_multi_context struct is not
> >> idiomatic. Rightfully, the struct wasn't designed to cater to the need=
s
> >> of panels with multiple MIPI DSI interfaces. This panel is an oddity
> >> which requires swapping the dsi pointer between MIPI function calls in
> >> order to preserve the exact behavior implemented using the non-multi
> >> variant of the macro.
> >
> > Right. We dealt with this before with "novatek-nt36523"...
> >
> >
> >> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> >> ---
> >>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 160 +++++++----------=
-
> >>  1 file changed, 59 insertions(+), 101 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/g=
pu/drm/panel/panel-jdi-lpm102a188a.c
> >> index 5b5082efb282..5001bea1798f 100644
> >> --- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> >> +++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> >> @@ -81,25 +81,20 @@ static int jdi_panel_disable(struct drm_panel *pan=
el)
> >>  static int jdi_panel_unprepare(struct drm_panel *panel)
> >>  {
> >>         struct jdi_panel *jdi =3D to_panel_jdi(panel);
> >> -       int ret;
> >> +       struct mipi_dsi_multi_context dsi_ctx;
> >>
> >> -       ret =3D mipi_dsi_dcs_set_display_off(jdi->link1);
> >> -       if (ret < 0)
> >> -               dev_err(panel->dev, "failed to set display off: %d\n",=
 ret);
> >> -
> >> -       ret =3D mipi_dsi_dcs_set_display_off(jdi->link2);
> >> -       if (ret < 0)
> >> -               dev_err(panel->dev, "failed to set display off: %d\n",=
 ret);
> >> +       dsi_ctx.dsi =3D jdi->link1;
> >> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> >> +       dsi_ctx.dsi =3D jdi->link2;
> >> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> >>
> >>         /* Specified by JDI @ 50ms, subject to change */
> >>         msleep(50);
> >
> > Needs to be mipi_dsi_msleep() to avoid the sleep in case the above
> > commands caused an error.
> >
> >
> >> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
> >> -       if (ret < 0)
> >> -               dev_err(panel->dev, "failed to enter sleep mode: %d\n"=
, ret);
> >> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
> >> -       if (ret < 0)
> >> -               dev_err(panel->dev, "failed to enter sleep mode: %d\n"=
, ret);
> >> +       dsi_ctx.dsi =3D jdi->link1;
> >> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> >> +       dsi_ctx.dsi =3D jdi->link2;
> >> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> >
> > I think you need this here:
> >
> > if (dsi_ctx.accum_err)
> >   return dsi_ctx.accum_err;
> >
> > ...otherwise the code will do the sleeps, GPIO calls, and regulator
> > calls even in the case of an error. You don't want that. Then at the
> > end of the function you'd just have "return 0;"
> >
> >
>
> Regarding these two suggestions, I prepared this patch with the intent
> to change the drivers actual behavior as little as possible. It looks
> like the original driver will happily msleep and try to continue
> initialization even after an error has occurred. Of course, using the
> _multi variants of mipi dbi functions kind of implies that we want to
> stop communicating with a display after an error has occurred. And
> because all _multi functions are effectively no-ops after an error has
> occurred, it doesn't make sense to perform the other half of the
> initialization sequence while anything involving mipi is dutifully
> skipped.
>
> I'll make these changes in the next patch revision.

Hmmmm. You're right that the old driver was indeed plowing forward
when it got errors. It checks them and does a printout, but then it
throws away the error code and continues executing the rest of the
functions.

Oh! ...but looking at this with fresh eyes, perhaps what the old code
was doing was more correct specifically because this is _unprepare_
and we want to power off even if there were errors. To be explicit:

1. Just because MIPI commands are failing on one link doesn't mean
that they are failing on both links.

2. Even though trying to send "enter sleep mode" after a failed
"display off" will probably fail, it doesn't seem like it would hurt
to try it.

3. You definitely still want all the GPIO / regulator calls even if
the MIP commands failed.

4. Given all the above, I guess one could argue that the sleeps should
all be executed in this case even if the MIPI commands fail.

Maybe something like this would make sense?

/*
* One context per panel since we'll continue trying to shut down
* the other panel even if one isn't responding.
*/
struct mipi_dsi_multi_context dsi_ctx1 =3D { .dsi =3D jdi->link1 };
struct mipi_dsi_multi_context dsi_ctx2 =3D { .dsi =3D jdi->link2 };

mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
mipi_dsi_dcs_set_display_off_multi(&dsi_ctx2);

msleep(50);

/* Doesn't hurt to try sleep mode even if display off fails */
dsi_ctx1.accum_err =3D dsi_ctx2.accum_err =3D 0;
mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx2);

msleep(150);

...
...

/* We powered off; return no error even if MIPI cmds failed */
return 0;

What do you think? This is still a small functionality change since
the old code would have returned an error if the second
mipi_dsi_dcs_enter_sleep_mode() returned an error code, but that feels
like it was a bug. That should probably be mentioned in the commit
message.


> >>  static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
> >>                                        struct mipi_dsi_device *right,
> >>                                        const struct drm_display_mode *=
mode)
> >>  {
> >> -       int err;
> >> +       struct mipi_dsi_multi_context dsi_ctx;
> >
> > I think you should actually pass in the "dsi_ctx" to this function
> > since the caller already has one. Then you can change it to a "void"
> > function...
> >
> >
> >>  static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
> >>  {
> >
> > I think you want to pass the context into this function too and make
> > it "void". Then the caller doesn't need to check for the error before
> > calling it...
> >
> > Then the "msleep(150)" after calling this function can change to a
> > `mipi_dsi_msleep()` and you don't need to check the error until right
> > before the LPM flag is cleared...
> >
> >
>
> About the suggestion, "you don't need to check the error until right
> before the LPM flag is cleared...", if I change
> jdi_setup_symmetrical_split to accept a mipi_dsi_multi_context pointer,
> the driver will output "failed to set up symmetrical split" even if the
> error was encountered well before setting up the symmetrical split
> (meaning the driver doesn't even try to set up symmetrical split at all).
>
> The appropriate solution will be to either maintain the error checks in
> the driver, or remove the print statements. For the next revision, I'll
> simply go ahead and remove the error print statements because:
>   - the mipi _multi functions should handle error printing well enough
>     to facilitate tracking down the particular mipi sequence which
>     caused an error during probe/unprepare.
>   - less logic in this driver makes it easier to maintain

Right. You'd remove the "failed to set up symmetrical split" error
since all sources of the error would already be reported.


> >> +       struct mipi_dsi_multi_context dsi_ctx;
> >> +
> >>         /* Clear the manufacturer command access protection */
> >> -       mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
> >> +       dsi_ctx.dsi =3D jdi->link1;
> >> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
> >>                                    MCS_CMD_ACS_PROT_OFF);
> >> -       mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
> >> +       dsi_ctx.dsi =3D jdi->link2;
> >> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
> >>                                    MCS_CMD_ACS_PROT_OFF);
> >
> > All the duplication is annoying. In "novatek-nt36523" I guess we only
> > needed to send _some_ of the commands to both panels and so we ended
> > up with a macro in just that C file just for
> > mipi_dsi_dual_dcs_write_seq_multi(). ...but here you seem to be
> > needing it for lots of functions.
> >
> > Maybe the solution is to add something like this to "drm_mipi_dsi.h":
> >
> > #define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, _args...) \
> >   do { \
> >     (_ctx)->dsi =3D (_dsi1); \
> >     (_func)((_ctx), _args); \
> >     (_ctx)->dsi =3D (_dsi2); \
> >     (_func)((_ctx), _args); \
> >   } while (0)
> >
> > Then you could have statements like:
> >
> > mipi_dsi_dual(mipi_dsi_generic_write_seq_multi, jdi->link1,
> > jdi->link2, &dsi_ctx, ...);
> >
> > I _think_ that will work? I at least prototyped it up with some simple
> > test code and it seemed to work... What do others think of that?
>
> In my opinion, this change is absolutely worth making, but the creation
> of a new macro like mipi_dsi_dual in drm_mipi_dsi.h is beyond the scope
> of this patch series because it has implications for panels like
> novatek-nt36523 and others. It looks like you've already effectively
> completed the work of implementing the macro, but I'm happy to address
> the adoption of the macro in lpm102a188a and other drivers as a part of
> a later patch series. Besides, there is no more duplication in this
> driver after applying my patch than there was before.
>
> Of course, maybe that's just me being pedantic. I'm happy to include
> mipi_dsi_dual in this series if you insist.

I would prefer if you had a patch #1 introducing mipi_dsi_dual() and
then used it in patch #2. IMO there's no need for you to go back and
re-cleanup "novatek-nt36523". I think the panel you're dealing with is
the second one to have run into this issue during the "multi"
conversion and it's better to get the cleaner solution landed before
others copy.

That being said, I won't insist. You're right that the duplication
isn't any worse with your patch.

-Doug

