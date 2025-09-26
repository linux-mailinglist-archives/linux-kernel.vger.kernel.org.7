Return-Path: <linux-kernel+bounces-833865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F533BA33F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BF81C0372E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991929DB61;
	Fri, 26 Sep 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E6ExbpZo"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3229BDB9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880367; cv=none; b=KJm9srlqC7nPZeLjtUIesupElZuPJSLH+jyfCzB//Odwp7ZmOuFlyW2PNO8kfQpcieP3/Bg47ty0cnSn53X0VUJCQqx6WM6DjCK/LRnMrbcKO57d6E6scp1MjauocQuhOJsDloiIVQAWtdC+HHTtHFWacu/9O98F8gG1YAD8GA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880367; c=relaxed/simple;
	bh=vwhzCeRwPFXWq+5fADiAEM5Wrv2+hu8oq7uVl1AC86Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQpAxX7dTjk7SfcHYigazMcGyJxaNfEA31GuLT9eL2hsE/bpy7xi+0G8c4ZHq8jz8gy29efWD4SxJl+fHXp6hsOGhVU+zXHZCNqQ82/PTIJUOGOMzWw01i1lbED+Uyt2Zd/SSj1e8CQlT3QuH0F6F9mRazBavzInOTsT/FXCUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E6ExbpZo; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 28BBE3FBBF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758880363;
	bh=KjxkHtlh8gdhXK0J3a2nTcQMmVYIomCeNsXStovmAzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=E6ExbpZoCAVe+qocl5QkmKdOno4KQ5PJdM+E6SrduuQ3UmydUf07dsRD714B+hTeP
	 pzQ45E8ry8VPy/h9HODRpYOnJ2B2S/GkQHstn42pwgfKZplWJRaJIbPNUWKoodh7Qr
	 KDtpDoiZZoApzunROgGRy5KXy4dIFQygxxdX++iFmIzWq+FUv/AmknWxJhDwigc9oX
	 hZjfgxBkn6y1Ox2wqSiwrr3cnhZ+Ah+NqMB4PVYwWRSO5Totpr4pjCwgVCXwb09zmD
	 x8Ybdy5sffOC97JATJ99n73Wwup7lcvqu6zIN/ZWJRJrgb+DRzkvRpO9eefWXkd9qT
	 chXS56qoEuZPw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2699ed6d43dso21806735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880361; x=1759485161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjxkHtlh8gdhXK0J3a2nTcQMmVYIomCeNsXStovmAzs=;
        b=cAfUrKWTT7LE0hpeybW60cE2D0WArb8SRHN7CFS/Gx1YV0Yz2831agQUy2kNuYMPzm
         jRvPhDGEuRBFbvmcUeK67jsdVhNNN1YLQNbW/Fd4IdSdLJ/jwxNvdblDATGPKgiXP8VF
         TTDfF6CtS5Wqsa9EY2RZQ4HE/uc1wPhm2wddF03e4yUKnq/Md5qURpnjiX8V4AlishLb
         IpWXLO9Z7/+HLI1VX66bUPHOgFVYLULiosJ4LZgz8J3Ug2eMP7zrofYxOwARXqnt7zpf
         ku5VNA+3Jx1Gk5eCLUzuA5AiuN5+8Q6iFd1/V+xEtAiIT7YdTEGBXOy40Af8ZvNfA2AE
         fYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqboa/Jeiqy0h54UJj3tPwFqbaS3w9TF2MN5qTVr3hbQhL7/pSECe2VM33MccDE1ABdunMKSnXJTFNd9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAODwl5jonOUBDZX3HY5H0lg1tghRRvJns+nWefQs1Znb9QmM
	DiV6WOWF3peRwqU80mybU58igdTVQNdUae2nDoGTs7BiwRl8u/fNwwGAimAykOiLTeuf+piqYri
	rOe5/rZMWdPqciJvJOd1mGoYYzrOhhR3YsIFVsFXM86kKd54CqmJxHEpKkHd39vCN+c0KfdKuce
	7bwrJr91iMO+84qlgpguctohn8jvvLUdJMk/AMAqb/wVtVrlUx1iB6mNLh
X-Gm-Gg: ASbGnctj9xCMUWdlBBlJIkFa5dH5IIP0GMpGwHZbwPnfs6gIH8chsdz6kKTsuKVCvMx
	gQ76/pZAHstgPJ7joe0mMTMg1w8IPp6uCtl/RZmRy46HsHuEA+ZAFqVOM0DW4o07GXLUAFODezl
	3dDXjo3KOHi34CMLQ0GACx
X-Received: by 2002:a17:90b:4d06:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-3342a259dc1mr6033330a91.13.1758880361599;
        Fri, 26 Sep 2025 02:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19X6EA1H4jTvN4dWxU7JwY59cVgbi9j3iHNtYFvs9tRTwaozQ+7e2npfpIa6NgiwV+5bpU1kR4Blrn0wvi64=
X-Received: by 2002:a17:90b:4d06:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-3342a259dc1mr6033303a91.13.1758880361055; Fri, 26 Sep 2025
 02:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926085401.2808634-1-aaron.ma@canonical.com>
 <20250926085401.2808634-2-aaron.ma@canonical.com> <DM3PPF208195D8DD3E38CF770DE7A86EFB9E31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF208195D8DD3E38CF770DE7A86EFB9E31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Fri, 26 Sep 2025 17:52:30 +0800
X-Gm-Features: AS18NWC6usbrrUqzksFFGYtVP1qOZ-zX_mvOsIOG8F6S9mHmeRBbjWjSAl71ZfE
Message-ID: <CAJ6xRxU1B0wh9eNO8x62+HH_SS_H-eR-Sco9cAeH9fKrTQ+kMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/i915/backlight: Add get brightness support of
 DPCD via AUX
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"Deak, Imre" <imre.deak@intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:26=E2=80=AFPM Kandpal, Suraj <suraj.kandpal@intel=
.com> wrote:
>
> > Subject: [PATCH 2/2] drm/i915/backlight: Add get brightness support of =
DPCD
> > via AUX
> >
> > Use drm common helper to read brightness from both luminance and AUX
> > mode to support get_brightness from DPCD via AUX.
> >
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  .../drm/i915/display/intel_dp_aux_backlight.c | 20 ++++++-------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index 0a3a3f6a5f9d8..0ee6fd0f41ef0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -454,24 +454,16 @@ static u32 intel_dp_aux_vesa_get_backlight(struct
> > intel_connector *connector, en  {
> >       struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder)=
;
> >       struct intel_panel *panel =3D &connector->panel;
> > -     u8 buf[3];
> > -     u32 val =3D 0;
> > -     int ret;
> >
> > -     if (panel->backlight.edp.vesa.luminance_control_support) {
> > -             ret =3D drm_dp_dpcd_read(&intel_dp->aux,
> > DP_EDP_PANEL_TARGET_LUMINANCE_VALUE, buf,
> > -                                    sizeof(buf));
> > -             if (ret < 0) {
> > -                     drm_err(intel_dp->aux.drm_dev,
> > -                             "[CONNECTOR:%d:%s] Failed to read
> > Luminance from DPCD\n",
> > -                             connector->base.base.id, connector-
> > >base.name);
> > -                     return 0;
> > -             }
> > +     if (!panel->backlight.edp.vesa.info.aux_set) {
> > +             u32 pwm_level =3D panel->backlight.pwm_funcs->get(connect=
or,
> > unused);
> >
> > -             val |=3D buf[0] | buf[1] << 8 | buf[2] << 16;
> > -             return val / 1000;
> > +             return intel_backlight_level_from_pwm(connector,
> > pwm_level);
> >       }
> >
> > +     connector->panel.backlight.level =3D
> > +             drm_edp_backlight_get_level(&intel_dp->aux,
> > +&panel->backlight.edp.vesa.info);
> > +
>
> Just call the intel_dp_aux_vesa_get_backlight here and call the drm_edp_b=
acklight get level in there
>

Do you mean no call of  pwm get?

I thought it should be aligned with set_level when aux_set =3D=3D 0.

Thanks,
Aaron

> Regards,
> Suraj Kandpal
>
>
> >       return connector->panel.backlight.level;  }
> >
> > --
> > 2.43.0
>

