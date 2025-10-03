Return-Path: <linux-kernel+bounces-841604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5BBB7CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 193B74EE0CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDB2DAFD8;
	Fri,  3 Oct 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSba/HIc"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD32D0619
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513900; cv=none; b=f0up10cOw5Zq9ojU3SU1yq/zHdV75tb6bXZbmInz369AVAe6laI9ODEs7Fa4i3TtHuQohO43RjVlgY9UJWCaACo+1BitrbkpgeNetGQICM6MwxbWGAbXTpHzd8aKS2nQDhTWisCvmdq/FFdvMCaJUAyoKo9ooMPQXAABbIrYQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513900; c=relaxed/simple;
	bh=mxIPjbnJtjAvJhjqu0RPpD7E2GA8VibHOhngXsknw68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMQ6ZTSYo4G5zt5vsUhxVo2xR7pSHDcqlTX9cwF/3aAmA6cD+QEPz25AV7PQXcrFbzOwUl2lZb/HYwCo0m3vIWBjshXmgIC8BqTevkg3on3qKcdZkmZnNTWJcW2nGt/u6PL8MpPImZMi/f9ayu78PfJD9lZH9IjohJULxizEjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSba/HIc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-887764c2868so240414239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513897; x=1760118697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iybLh8+L4TkpxzlAmZmGQVw8GbTyDtpsUZyNN32bmfc=;
        b=aSba/HIcGIEi6QVlWBtPswmbzc2nnG+vlCORhsZa5iFeeggzsi4fsEprm4bCTVSdTF
         Pr96qgDQt5eypfmFwHg/gmq5rt1GXB8D3dh+79Vp+Nc7ZIcrWXtFwvM3P6V2NynZERX3
         4jVd1UB+0Pj7xLoJe11166pmEnj6/PKn0JNYULfQUtyZCGMFSpHP5C4oZLzYqT+QE4N5
         ea22L16S6/wU8DZuBoPBA+G7XmxYlbhA2h5MtNvgblYJ4JkP4MQgN2M0vKPEGBs4FKCT
         ncJ3pxDSbn0PD12f4bJTMcnukoNjr4LTMG87GptfdsZIFtDk97hYTDl0uiB4V7Sf6wLy
         Ti7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513897; x=1760118697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iybLh8+L4TkpxzlAmZmGQVw8GbTyDtpsUZyNN32bmfc=;
        b=gx61bOlxenIRa5WR9IJxC472myLsPe3V9zMyFYHY5KK5WSd9Xl+wI/MMoJzlcx4rOf
         mcUpPlZpAJZvjjshJGKOQhaRSTRH20Evf/HNNIwGWPCkZBrKhDMQ4n5YQ3tAgPKj2nbq
         QR8Fs9eLkyAypCE/8EOLL71AjGZqde/GGoG0i73XBJXYzToXyn9IumTss+IsYSQ9n2dr
         ZEtt/vs8UEpBcadakbYi59/lhkEkw7YENpEgb9xD0aNuheBNfu/YdONr8SRQe1Ju4LxW
         ZzBip1eCHM9W0xfaJbSN0SfvfnD50K77eJi+vD4AOLwpoORtf0yD3Uob35tnfgH9uyC1
         xiug==
X-Forwarded-Encrypted: i=1; AJvYcCVQn5/2wni47t3UeuTGGwSr86AEiX0xbEbly1qmMxhGKbZKxshXCjBVpvbTFvXdNCeE9QVpgA+rd+NKl3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOlCzvZMEudEnUzIhYIPoqSbL3vXTiFen+6oJNaPzVSulKItV
	czTt6TQajn1XN0iVwKIJBwWOFAIaBfo7pomsEQEkxxcuZ7mjJV1dF30T5jCv8IxZS/AETCFJbe3
	lHYZ6iiQKUJ+8+Dr0l2qL/QMtY6uUB2cfTIL2m14=
X-Gm-Gg: ASbGncsS2hMGOm76awBDGaN29eLS2WBXUg1+7UP0kUmYEB+6wAVOL6GYltdMFjWCmq+
	J+38RRybnn9vI72uRiG8sfR1GyhXbDYrAlfaZ75jAELbPvtUFmya6zSoEzKPEJFBFhy24/kMZbQ
	mGV8Kwn9Ki4kVv74xyrBbBGLk3Vj3cB+gtO/SBW520q4uWP1Tcs3jMwd+qsBA+XUfz4GiGwLn7Z
	kdHoCjLLOcGsSenGQW/ggp+Ppc31zJxRFz2OFeI
X-Google-Smtp-Source: AGHT+IFxWCl0H0bEwNJ/yNAdI7wLJSC6u/LbBfSQHxB1RSf9qUdhZbywkYmPtERI6GanAV013KE1aJ3+27znXww1NtI=
X-Received: by 2002:a05:6602:6416:b0:914:9a7:c25b with SMTP id
 ca18e2360f4ac-93b96941af7mr584315739f.4.1759513896580; Fri, 03 Oct 2025
 10:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093008.1949131-1-rk0006818@gmail.com>
In-Reply-To: <20250926093008.1949131-1-rk0006818@gmail.com>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Fri, 3 Oct 2025 23:21:25 +0530
X-Gm-Features: AS18NWBAqDBk-brZQipmIu4JtjsscgcOTEoPvU74Cba7HGt69_ZDe9ZZhSKTIwM
Message-ID: <CAKY2RybMM5jcOzO_mknsdH+m9-T+Qe3yMhRrdpV_VE4paUrAKw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

Just following up to ask if anything more is needed from my side for
this patch, or if you plan to pick it up in this merge window.

Thanks,
Rahul

On Fri, Sep 26, 2025 at 3:00=E2=80=AFPM Rahul Kumar <rk0006818@gmail.com> w=
rote:
>
> Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO()
> calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
> corresponding drm_err(), drm_warn(), and drm_info() helpers.
>
> The new drm_*() logging functions take a struct drm_device * as the
> first argument. This allows the DRM core to prefix log messages with
> the specific DRM device name and instance, which is essential for
> distinguishing logs when multiple GPUs or display controllers are present=
.
>
> This change aligns komeda with the DRM TODO item: "Convert logging to
> drm_* functions with drm_device parameter".
>
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
> Changes since v2:
> - Added Reviewed-by tag from Liviu Dudau
>
> Link to v1:
> https://lore.kernel.org/all/aJshoswGslcYQFLI@e110455-lin.cambridge.arm.co=
m/
> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 31 +++++++++++--------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 2ad33559a33a..5a66948ffd24 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -111,6 +111,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>  static int
>  komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  {
> +       struct drm_device *drm =3D kcrtc->base.dev;
>         struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
>         struct komeda_pipeline *master =3D kcrtc->master;
>         struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(kcrtc->base.st=
ate);
> @@ -128,8 +129,8 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>
>         err =3D mdev->funcs->change_opmode(mdev, new_mode);
>         if (err) {
> -               DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> -                         mdev->dpmode, new_mode);
> +               drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
> +                       mdev->dpmode, new_mode);
>                 goto unlock;
>         }
>
> @@ -142,18 +143,18 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>         if (new_mode !=3D KOMEDA_MODE_DUAL_DISP) {
>                 err =3D clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kcr=
tc_st));
>                 if (err)
> -                       DRM_ERROR("failed to set aclk.\n");
> +                       drm_err(drm, "failed to set aclk.\n");
>                 err =3D clk_prepare_enable(mdev->aclk);
>                 if (err)
> -                       DRM_ERROR("failed to enable aclk.\n");
> +                       drm_err(drm, "failed to enable aclk.\n");
>         }
>
>         err =3D clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
>         if (err)
> -               DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id=
);
> +               drm_err(drm, "failed to set pxlclk for pipe%d\n", master-=
>id);
>         err =3D clk_prepare_enable(master->pxlclk);
>         if (err)
> -               DRM_ERROR("failed to enable pxl clk for pipe%d.\n", maste=
r->id);
> +               drm_err(drm, "failed to enable pxl clk for pipe%d.\n", ma=
ster->id);
>
>  unlock:
>         mutex_unlock(&mdev->lock);
> @@ -164,6 +165,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  static int
>  komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>  {
> +       struct drm_device *drm =3D kcrtc->base.dev;
>         struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
>         struct komeda_pipeline *master =3D kcrtc->master;
>         u32 new_mode;
> @@ -180,8 +182,8 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>
>         err =3D mdev->funcs->change_opmode(mdev, new_mode);
>         if (err) {
> -               DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> -                         mdev->dpmode, new_mode);
> +               drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
> +                       mdev->dpmode, new_mode);
>                 goto unlock;
>         }
>
> @@ -200,6 +202,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
>  void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>                               struct komeda_events *evts)
>  {
> +       struct drm_device *drm =3D kcrtc->base.dev;
>         struct drm_crtc *crtc =3D &kcrtc->base;
>         u32 events =3D evts->pipes[kcrtc->master->id];
>
> @@ -212,7 +215,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>                 if (wb_conn)
>                         drm_writeback_signal_completion(&wb_conn->base, 0=
);
>                 else
> -                       DRM_WARN("CRTC[%d]: EOW happen but no wb_connecto=
r.\n",
> +                       drm_warn(drm, "CRTC[%d]: EOW happen but no wb_con=
nector.\n",
>                                  drm_crtc_index(&kcrtc->base));
>         }
>         /* will handle it together with the write back support */
> @@ -236,7 +239,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>                         crtc->state->event =3D NULL;
>                         drm_crtc_send_vblank_event(crtc, event);
>                 } else {
> -                       DRM_WARN("CRTC[%d]: FLIP happened but no pending =
commit.\n",
> +                       drm_warn(drm, "CRTC[%d]: FLIP happened but no pen=
ding commit.\n",
>                                  drm_crtc_index(&kcrtc->base));
>                 }
>                 spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> @@ -309,7 +312,7 @@ komeda_crtc_flush_and_wait_for_flip_done(struct komed=
a_crtc *kcrtc,
>
>         /* wait the flip take affect.*/
>         if (wait_for_completion_timeout(flip_done, HZ) =3D=3D 0) {
> -               DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->maste=
r->id);
> +               drm_err(drm, "wait pipe%d flip done timeout\n", kcrtc->ma=
ster->id);
>                 if (!input_flip_done) {
>                         unsigned long flags;
>
> @@ -562,6 +565,7 @@ static const struct drm_crtc_funcs komeda_crtc_funcs =
=3D {
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>                            struct komeda_dev *mdev)
>  {
> +       struct drm_device *drm =3D &kms->base;
>         struct komeda_crtc *crtc;
>         struct komeda_pipeline *master;
>         char str[16];
> @@ -581,7 +585,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms=
,
>                 else
>                         sprintf(str, "None");
>
> -               DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> +               drm_info(drm, "CRTC-%d: master(pipe-%d) slave(%s).\n",
>                          kms->n_crtcs, master->id, str);
>
>                 kms->n_crtcs++;
> @@ -613,6 +617,7 @@ static int komeda_attach_bridge(struct device *dev,
>                                 struct komeda_pipeline *pipe,
>                                 struct drm_encoder *encoder)
>  {
> +       struct drm_device *drm =3D encoder->dev;
>         struct drm_bridge *bridge;
>         int err;
>
> @@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev,
>
>         err =3D drm_bridge_attach(encoder, bridge, NULL, 0);
>         if (err)
> -               dev_err(dev, "bridge_attach() failed for pipe: %s\n",
> +               drm_err(drm, "bridge_attach() failed for pipe: %s\n",
>                         of_node_full_name(pipe->of_node));
>
>         return err;
> --
> 2.43.0
>

