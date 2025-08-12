Return-Path: <linux-kernel+bounces-764864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E4B22811
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47943A13CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8B10E0;
	Tue, 12 Aug 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/lBfge9"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492C25949A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004191; cv=none; b=K3A8kdQFVczcg6rfCMAV8/4bU5wBK+RbXk/yuWS28i/WGM1ErTQS+VBXNfkPCcQueCYICNPPTbd2nhFSULr7L3Lx0g7WBMs1clE6SIlVzFWtXJcmHyKfKLSCXG22p94Sd8Ru7sRI9xqeaSpM7ZDvpbJQmd8upHuk1yU6B2IPyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004191; c=relaxed/simple;
	bh=H2kUbyZmueOz45xzGfE8A8+RM7sa09kDey8Eu1tb0tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EveHK7rx6rs19n7bRNLKNoQ/kEyY/3rsED/PifdZnQx7GBFXYIBfJ2pLBGqNQI/qtX8e7hZruRhoGiSOplNzaz6rHSI7ynHcTPzK+XxUIlr2vbfnRmN7kMgcZuTCiocMZdECBJvMlUU5kfHS3zFpRHv4elzF0b+oSCiZCu97hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/lBfge9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88109d54abdso194825939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004188; x=1755608988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCTldDZR7k6dRE1AzEZefc9AHLCcWRZn215S8tzP9HE=;
        b=W/lBfge9zJvUk6cIWMwyuY3awIJfcB5vbLK0JWjNnwiHWwLOD9A35j/0GghZQ2kPpx
         I0wdi/yrnaQR6YF/ecYAfs84osG3fuZ7o8H0CYmm/pNGYtcdQsAQZAxNnEIVEedEhZqn
         jX4BksMv7TX2KV+R+WJhIGrj6pSB2gr4IQyvyGT1xRM5FjOL4FpH7T5Cvv0sBDQEmAJF
         JTZ6PrcUV9yCojxtX1ND967Q8zTtv8eYcMK7AXTRTeA2zd12Vbs9Pu3w4TgFBSQY0lMN
         QvF8LyfjcIo+unhODduEs+eGyxlEpOWXB570UO6UnJy8Nkx7bA/y05ZLXYOUPGsiS74z
         XUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004188; x=1755608988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCTldDZR7k6dRE1AzEZefc9AHLCcWRZn215S8tzP9HE=;
        b=ucPYv9QrQjbpTyei1DsCLo7uzRvzAh2LTXQ3icyHHPvgCH08IHU8DAe1XOOxBfUfDw
         3LMqYj5yShYemJjvLBSlRpjq6EaITAhqj7Z657abFs8YxwOZfg8tCSx1Oyo19izPsV3s
         hXCKmZztyXXeF6poIShEcOKgC2p32FddI2Mr/wZJDvvAZcThY5+jBhe4JIM694OunVGS
         fZWL7wMI4thbl49LLa1NnfYCnlOng6cp9+2//BFNWoTWZppirOGcMhjPe7PcifJsSjB7
         vpB3VnRI2MR/ZmMVWLrzpq7LgIwjboSz1bANx8RuXq6QbQExydsNaLmk1FI/xnerkau5
         94+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUawhcpOKLd5oE691iEyelbiXeZxOY0MEO3XwemhFVmiYWZR7mu85FXYy2rWchCYfgGSBvSC8oQ3iKzlX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhDdwnxj8SBwsjAWUyhs7eQZE8IaRYEEP2jIEOX3D3/5ikO2o
	MMHTTQPrejByfCpFzeuuBWt7LhuJfFoQf33QK2cF3jp7ORp54NElhQ6VSOvWTheGkq0wk+uACdq
	04lE7kmm9DGs7X6IR7xOjBsWz7aDCsUo=
X-Gm-Gg: ASbGncsMFKs5Q8riJkxLJK9jgy93XSJO1p8g+VDM+fsHpBygMCLxHRvcbdR55RwNP0W
	BqzoATeNJMJRVC5wG81BQ+AkRPXzyntZUBz7XOoJo98qaTsyRrRu8HjlCVoQsU3vT7u9hVOWfRt
	/Qd60aSlGpj+Df9PPLhmw4+OzByAbzRyM33N4D8BC7IZDwGzjXL/8AQg1YLGOUiLFX5Tc7mYdu/
	EimfA==
X-Google-Smtp-Source: AGHT+IEyiNUXbvVqwYVbrRdb/7n8DO7e27n4xYqX8r0AVGzm55ZY/0DlFUByK5lcwmnjkEh0lGGKbzjd+RO/Kf2vkXY=
X-Received: by 2002:a05:6e02:1565:b0:3e5:42ec:137a with SMTP id
 e9e14a558f8ab-3e55af2b456mr54984915ab.4.1755004188435; Tue, 12 Aug 2025
 06:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812101119.2506-1-rk0006818@gmail.com> <aJshoswGslcYQFLI@e110455-lin.cambridge.arm.com>
 <CAKY2RyZX9D6J08S78zT97cHS3dJ7Cf0xURX7EougPmh-rMSMGQ@mail.gmail.com>
In-Reply-To: <CAKY2RyZX9D6J08S78zT97cHS3dJ7Cf0xURX7EougPmh-rMSMGQ@mail.gmail.com>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Tue, 12 Aug 2025 18:39:35 +0530
X-Gm-Features: Ac12FXyHXw4dWp3GJOGwX8qm21Fcd3McvMhOactXfaVPp-awu1HoiIo1XP-izQ4
Message-ID: <CAKY2Ryac_jwvHVXNmPKrNEdQa9CcjM=1aLEDWyRbspgp0bZK-g@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review and feedback, Liviu.
I will follow this for my future patches.

Regards,
Rahul


On Tue, Aug 12, 2025 at 5:50=E2=80=AFPM Rahul Kumar <rk0006818@gmail.com> w=
rote:
>
> Thanks for the review and feedback, Liviu.
> I will follow this for my future patches.
>
> Regards,
> Rahul
>
> On Tue, Aug 12, 2025 at 4:42=E2=80=AFPM Liviu Dudau <liviu.dudau@arm.com>=
 wrote:
>>
>> On Tue, Aug 12, 2025 at 03:41:19PM +0530, Rahul Kumar wrote:
>> > Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO(=
)
>> > calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
>> > corresponding drm_err(), drm_warn(), and drm_info() helpers.
>> >
>> > The new drm_*() logging functions take a struct drm_device * as the
>> > first argument. This allows the DRM core to prefix log messages with
>> > the specific DRM device name and instance, which is essential for
>> > distinguishing logs when multiple GPUs or display controllers are pres=
ent.
>> >
>> > This change aligns komeda with the DRM TODO item: "Convert logging to
>> > drm_* functions with drm_device parameter".
>> >
>> > Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
>>
>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>>
>> For future patches, when you make changes, please generate them with
>>
>> git patch -v<version>
>>
>> and include a change log so that reviewers can quickly figure out what
>> has changed between emails without having to go back and forth.
>>
>> Best regards,
>> Liviu
>>
>> > ---
>> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++++-------=
-
>> >  1 file changed, 16 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_crtc.c
>> > index 2ad33559a33a..e4cc1fb34e94 100644
>> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>> > @@ -111,6 +111,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>> >  static int
>> >  komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>> >  {
>> > +     struct drm_device *drm =3D kcrtc->base.dev;
>> >       struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
>> >       struct komeda_pipeline *master =3D kcrtc->master;
>> >       struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(kcrtc->base.s=
tate);
>> > @@ -128,7 +129,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>> >
>> >       err =3D mdev->funcs->change_opmode(mdev, new_mode);
>> >       if (err) {
>> > -             DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
>> > +             drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,"=
,
>> >                         mdev->dpmode, new_mode);
>> >               goto unlock;
>> >       }
>> > @@ -142,18 +143,18 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>> >       if (new_mode !=3D KOMEDA_MODE_DUAL_DISP) {
>> >               err =3D clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kc=
rtc_st));
>> >               if (err)
>> > -                     DRM_ERROR("failed to set aclk.\n");
>> > +                     drm_err(drm, "failed to set aclk.\n");
>> >               err =3D clk_prepare_enable(mdev->aclk);
>> >               if (err)
>> > -                     DRM_ERROR("failed to enable aclk.\n");
>> > +                     drm_err(drm, "failed to enable aclk.\n");
>> >       }
>> >
>> >       err =3D clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
>> >       if (err)
>> > -             DRM_ERROR("failed to set pxlclk for pipe%d\n", master->i=
d);
>> > +             drm_err(drm, "failed to set pxlclk for pipe%d\n", master=
->id);
>> >       err =3D clk_prepare_enable(master->pxlclk);
>> >       if (err)
>> > -             DRM_ERROR("failed to enable pxl clk for pipe%d.\n", mast=
er->id);
>> > +             drm_err(drm, "failed to enable pxl clk for pipe%d.\n", m=
aster->id);
>> >
>> >  unlock:
>> >       mutex_unlock(&mdev->lock);
>> > @@ -164,6 +165,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>> >  static int
>> >  komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>> >  {
>> > +     struct drm_device *drm =3D kcrtc->base.dev;
>> >       struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
>> >       struct komeda_pipeline *master =3D kcrtc->master;
>> >       u32 new_mode;
>> > @@ -180,7 +182,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>> >
>> >       err =3D mdev->funcs->change_opmode(mdev, new_mode);
>> >       if (err) {
>> > -             DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
>> > +             drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,"=
,
>> >                         mdev->dpmode, new_mode);
>> >               goto unlock;
>> >       }
>> > @@ -200,6 +202,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>> >  void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>> >                             struct komeda_events *evts)
>> >  {
>> > +     struct drm_device *drm =3D kcrtc->base.dev;
>> >       struct drm_crtc *crtc =3D &kcrtc->base;
>> >       u32 events =3D evts->pipes[kcrtc->master->id];
>> >
>> > @@ -212,7 +215,7 @@ void komeda_crtc_handle_event(struct komeda_crtc  =
 *kcrtc,
>> >               if (wb_conn)
>> >                       drm_writeback_signal_completion(&wb_conn->base, =
0);
>> >               else
>> > -                     DRM_WARN("CRTC[%d]: EOW happen but no wb_connect=
or.\n",
>> > +                     drm_warn(drm, "CRTC[%d]: EOW happen but no wb_co=
nnector.\n",
>> >                                drm_crtc_index(&kcrtc->base));
>> >       }
>> >       /* will handle it together with the write back support */
>> > @@ -236,7 +239,7 @@ void komeda_crtc_handle_event(struct komeda_crtc  =
 *kcrtc,
>> >                       crtc->state->event =3D NULL;
>> >                       drm_crtc_send_vblank_event(crtc, event);
>> >               } else {
>> > -                     DRM_WARN("CRTC[%d]: FLIP happened but no pending=
 commit.\n",
>> > +                     drm_warn(drm, "CRTC[%d]: FLIP happened but no pe=
nding commit.\n",
>> >                                drm_crtc_index(&kcrtc->base));
>> >               }
>> >               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>> > @@ -309,7 +312,7 @@ komeda_crtc_flush_and_wait_for_flip_done(struct ko=
meda_crtc *kcrtc,
>> >
>> >       /* wait the flip take affect.*/
>> >       if (wait_for_completion_timeout(flip_done, HZ) =3D=3D 0) {
>> > -             DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->mast=
er->id);
>> > +             drm_err(drm, "wait pipe%d flip done timeout\n", kcrtc->m=
aster->id);
>> >               if (!input_flip_done) {
>> >                       unsigned long flags;
>> >
>> > @@ -562,6 +565,7 @@ static const struct drm_crtc_funcs komeda_crtc_fun=
cs =3D {
>> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>> >                          struct komeda_dev *mdev)
>> >  {
>> > +     struct drm_device *drm =3D &kms->base;
>> >       struct komeda_crtc *crtc;
>> >       struct komeda_pipeline *master;
>> >       char str[16];
>> > @@ -581,7 +585,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *=
kms,
>> >               else
>> >                       sprintf(str, "None");
>> >
>> > -             DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
>> > +             drm_info(drm, "CRTC-%d: master(pipe-%d) slave(%s).\n",
>> >                        kms->n_crtcs, master->id, str);
>> >
>> >               kms->n_crtcs++;
>> > @@ -613,6 +617,7 @@ static int komeda_attach_bridge(struct device *dev=
,
>> >                               struct komeda_pipeline *pipe,
>> >                               struct drm_encoder *encoder)
>> >  {
>> > +     struct drm_device *drm =3D encoder->dev;
>> >       struct drm_bridge *bridge;
>> >       int err;
>> >
>> > @@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev=
,
>> >
>> >       err =3D drm_bridge_attach(encoder, bridge, NULL, 0);
>> >       if (err)
>> > -             dev_err(dev, "bridge_attach() failed for pipe: %s\n",
>> > +             drm_err(drm, "bridge_attach() failed for pipe: %s\n",
>> >                       of_node_full_name(pipe->of_node));
>> >
>> >       return err;
>> > --
>> > 2.43.0
>> >
>>
>> --
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> | I would like to |
>> | fix the world,  |
>> | but they're not |
>> | giving me the   |
>>  \ source code!  /
>>   ---------------
>>     =C2=AF\_(=E3=83=84)_/=C2=AF

