Return-Path: <linux-kernel+bounces-823095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3057B857C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647CE4A6DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B930CB4B;
	Thu, 18 Sep 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxYPa52l"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C84307AEB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208232; cv=none; b=WSCbaeREWv66epaZEwY1GlbPxRUDHmuwAdoLiw3VBrUq+e7/3i7XoBwGg8tIfxqaSqEMiqX+st7BVE1Qk//EcA7GCiRR926LaSl3Ttttjot3JKHztAboXDPKz1VxvTs4sjZwlk+zL9ejUjZj3ktpv4PlGbjBH9M7ouY2PKfRDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208232; c=relaxed/simple;
	bh=txPGmNOQINtIpOVk70+D9nn1R5b6qd6P75Nrg6zSvzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlpI6NioAhp6U4yCz2ZNMWFW665OQekNkH3EP+5WSyAwC/hCq1nctjflO9bzNkE3T4BdaROEyINEmv3c3N3CIiYhOmWeZ4s1rZI4KVfkOMcTLMKPxVAgFYRD7dB4YJ770z544fGPic3meRMjJ0hEQtieFwyFWAh3/mTIgOmjXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxYPa52l; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-752f88e0b59so798950a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758208230; x=1758813030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJCD/GWaEbE7CpfeMPeup88gbNCvyKDHt8+xdjkZdx0=;
        b=NxYPa52luMa8WH7cGZ2CaeSIMZNEnSkYSsLBc52UtibnplXXWwKiCv+PZXvKKzbxgo
         AnM5o6kwJNIKxj8vVIH4PUWDrdF8tO8u5WE9UJxm69gPQGkkyDYwVghooQpCaloDAO1v
         Wm1cM+LookbNDVlwaxcqke++0D/iKZd+1B7dBz24e949f2ncq39fxW4TSmt/ZAtDOTbX
         nf+Kr+Zk9HJ/qsLrrSFYaScQtCekd7eFoQTpIwGMXU3G1x7x890dSUSyp/DVMr2XcFZA
         49d0zFpCRKRxMaD+I/awnfXLLsXqyOrNDTK2zuBqB+KL6rAwqWfKEi7OivyoCkqYKIpC
         pCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208230; x=1758813030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJCD/GWaEbE7CpfeMPeup88gbNCvyKDHt8+xdjkZdx0=;
        b=LNn5mNAhchsNpXw3pTxd2ht4ygQSXpgelniY+ukkXzOHwGg+iX4ft1yIz5C7zzrxn6
         8hSkmOBNDBuLXW9ciTGFt4cjfObeuddgjE/GvMTkRuYN+tgJ6sSmI9qdRsFjI2kE9QsE
         VNSZYZwsteP53KZI7S9JmC1248n4/MKmDyE4btp4dDqePJ1LdyN/HE8ejhceMedvN8T+
         DqZGbp1F6Bxk++5uV5Kzl2hE3pPODlzY1aAfUM7sL5ybLeFfvsWJzrPXEoAyi1Ti/6hD
         MN7aMjuJ1xDbrrgbxDoszi3cFleYnIffl8l0ycXjGAHy1R4IzwwFO4EPJUzKFwsY8pBm
         lLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVe4kbJnU6E9WJ25lEeFI7qkzydr0aP0wp5fZDPFuarmkkGVNVuCETuUmrPmba29kIRcutNe6D2j1YrW7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jGKikgGGVgc8Reu+Tx5Y54+cw589j3wI3dmbSObYCYlm9k+0
	HyC14PxANmxXApKBNvbdm8TmSOBKU/SGDfuTbuHyaICe9Wns00MjM0679clIOnbw82qlWW3DiZs
	01j4QS+782LAnw4MPeroVE3K2OvKffVM=
X-Gm-Gg: ASbGnctBympbm/C7h/jypfgiRyiegxx3osbiGMsfESiyA9B2eepktZfugqUXhD/JVw5
	tya4zb9+0ImK8DCPVWhwhzyzQl/UptR4cO5o3Tg6zvRsdAn4lZCeYMb/Odi4to+zvQmKQOgmMu6
	f4qGXGKqKDdNkPoe49L7Kms7kL6mSyevbyKYLWCrtGpFFBjnU4+P2ePswX8LrTi8U8UFULhPk8M
	5CP25KQyDaqTWkmDKsfdFsn
X-Google-Smtp-Source: AGHT+IGaCVAN30v8oUC6k3D0axrGZD4ceqkUUCjR54VGI6JUzof2ZcIwvXzYDlz9f+JwTiW6Yd2M0Obi9b8I3ofR9zo=
X-Received: by 2002:a05:6830:26c:b0:745:a3b2:9add with SMTP id
 46e09a7af769-7690184d707mr1696329a34.10.1758208229750; Thu, 18 Sep 2025
 08:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812101119.2506-1-rk0006818@gmail.com> <aJshoswGslcYQFLI@e110455-lin.cambridge.arm.com>
In-Reply-To: <aJshoswGslcYQFLI@e110455-lin.cambridge.arm.com>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Thu, 18 Sep 2025 20:40:17 +0530
X-Gm-Features: AS18NWC8-yp8H_ihIxT83iefQZgDeQeGh3iJwG5rYwAT5K09s35lEtBeLklSxbk
Message-ID: <CAKY2RyZr8XCR+nYt_eG49uJiAhc6nesac8hs6AQ8eEy+o9hyvg@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

On Tue, Aug 12, 2025 at 4:42=E2=80=AFPM Liviu Dudau <liviu.dudau@arm.com> w=
rote:
>
> On Tue, Aug 12, 2025 at 03:41:19PM +0530, Rahul Kumar wrote:
> > Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO()
> > calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
> > corresponding drm_err(), drm_warn(), and drm_info() helpers.
> >
> > The new drm_*() logging functions take a struct drm_device * as the
> > first argument. This allows the DRM core to prefix log messages with
> > the specific DRM device name and instance, which is essential for
> > distinguishing logs when multiple GPUs or display controllers are prese=
nt.
> >
> > This change aligns komeda with the DRM TODO item: "Convert logging to
> > drm_* functions with drm_device parameter".
> >
> > Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>

I just wanted to check if there=E2=80=99s anything else I should do for thi=
s
patch, or if it=E2=80=99s already queued for merging.

Thanks,
Rahul

> For future patches, when you make changes, please generate them with
>
> git patch -v<version>
>
> and include a change log so that reviewers can quickly figure out what
> has changed between emails without having to go back and forth.
>
> Best regards,
> Liviu
>
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++++--------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 2ad33559a33a..e4cc1fb34e94 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -111,6 +111,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
> >  static int
> >  komeda_crtc_prepare(struct komeda_crtc *kcrtc)
> >  {
> > +     struct drm_device *drm =3D kcrtc->base.dev;
> >       struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
> >       struct komeda_pipeline *master =3D kcrtc->master;
> >       struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(kcrtc->base.st=
ate);
> > @@ -128,7 +129,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
> >
> >       err =3D mdev->funcs->change_opmode(mdev, new_mode);
> >       if (err) {
> > -             DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> > +             drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
> >                         mdev->dpmode, new_mode);
> >               goto unlock;
> >       }
> > @@ -142,18 +143,18 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
> >       if (new_mode !=3D KOMEDA_MODE_DUAL_DISP) {
> >               err =3D clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kcr=
tc_st));
> >               if (err)
> > -                     DRM_ERROR("failed to set aclk.\n");
> > +                     drm_err(drm, "failed to set aclk.\n");
> >               err =3D clk_prepare_enable(mdev->aclk);
> >               if (err)
> > -                     DRM_ERROR("failed to enable aclk.\n");
> > +                     drm_err(drm, "failed to enable aclk.\n");
> >       }
> >
> >       err =3D clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
> >       if (err)
> > -             DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id=
);
> > +             drm_err(drm, "failed to set pxlclk for pipe%d\n", master-=
>id);
> >       err =3D clk_prepare_enable(master->pxlclk);
> >       if (err)
> > -             DRM_ERROR("failed to enable pxl clk for pipe%d.\n", maste=
r->id);
> > +             drm_err(drm, "failed to enable pxl clk for pipe%d.\n", ma=
ster->id);
> >
> >  unlock:
> >       mutex_unlock(&mdev->lock);
> > @@ -164,6 +165,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
> >  static int
> >  komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
> >  {
> > +     struct drm_device *drm =3D kcrtc->base.dev;
> >       struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
> >       struct komeda_pipeline *master =3D kcrtc->master;
> >       u32 new_mode;
> > @@ -180,7 +182,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
> >
> >       err =3D mdev->funcs->change_opmode(mdev, new_mode);
> >       if (err) {
> > -             DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
> > +             drm_err(drm, "failed to change opmode: 0x%x -> 0x%x.\n,",
> >                         mdev->dpmode, new_mode);
> >               goto unlock;
> >       }
> > @@ -200,6 +202,7 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
> >  void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
> >                             struct komeda_events *evts)
> >  {
> > +     struct drm_device *drm =3D kcrtc->base.dev;
> >       struct drm_crtc *crtc =3D &kcrtc->base;
> >       u32 events =3D evts->pipes[kcrtc->master->id];
> >
> > @@ -212,7 +215,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   =
*kcrtc,
> >               if (wb_conn)
> >                       drm_writeback_signal_completion(&wb_conn->base, 0=
);
> >               else
> > -                     DRM_WARN("CRTC[%d]: EOW happen but no wb_connecto=
r.\n",
> > +                     drm_warn(drm, "CRTC[%d]: EOW happen but no wb_con=
nector.\n",
> >                                drm_crtc_index(&kcrtc->base));
> >       }
> >       /* will handle it together with the write back support */
> > @@ -236,7 +239,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   =
*kcrtc,
> >                       crtc->state->event =3D NULL;
> >                       drm_crtc_send_vblank_event(crtc, event);
> >               } else {
> > -                     DRM_WARN("CRTC[%d]: FLIP happened but no pending =
commit.\n",
> > +                     drm_warn(drm, "CRTC[%d]: FLIP happened but no pen=
ding commit.\n",
> >                                drm_crtc_index(&kcrtc->base));
> >               }
> >               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> > @@ -309,7 +312,7 @@ komeda_crtc_flush_and_wait_for_flip_done(struct kom=
eda_crtc *kcrtc,
> >
> >       /* wait the flip take affect.*/
> >       if (wait_for_completion_timeout(flip_done, HZ) =3D=3D 0) {
> > -             DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->maste=
r->id);
> > +             drm_err(drm, "wait pipe%d flip done timeout\n", kcrtc->ma=
ster->id);
> >               if (!input_flip_done) {
> >                       unsigned long flags;
> >
> > @@ -562,6 +565,7 @@ static const struct drm_crtc_funcs komeda_crtc_func=
s =3D {
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> >                          struct komeda_dev *mdev)
> >  {
> > +     struct drm_device *drm =3D &kms->base;
> >       struct komeda_crtc *crtc;
> >       struct komeda_pipeline *master;
> >       char str[16];
> > @@ -581,7 +585,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *k=
ms,
> >               else
> >                       sprintf(str, "None");
> >
> > -             DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> > +             drm_info(drm, "CRTC-%d: master(pipe-%d) slave(%s).\n",
> >                        kms->n_crtcs, master->id, str);
> >
> >               kms->n_crtcs++;
> > @@ -613,6 +617,7 @@ static int komeda_attach_bridge(struct device *dev,
> >                               struct komeda_pipeline *pipe,
> >                               struct drm_encoder *encoder)
> >  {
> > +     struct drm_device *drm =3D encoder->dev;
> >       struct drm_bridge *bridge;
> >       int err;
> >
> > @@ -624,7 +629,7 @@ static int komeda_attach_bridge(struct device *dev,
> >
> >       err =3D drm_bridge_attach(encoder, bridge, NULL, 0);
> >       if (err)
> > -             dev_err(dev, "bridge_attach() failed for pipe: %s\n",
> > +             drm_err(drm, "bridge_attach() failed for pipe: %s\n",
> >                       of_node_full_name(pipe->of_node));
> >
> >       return err;
> > --
> > 2.43.0
> >
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF

