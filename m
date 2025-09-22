Return-Path: <linux-kernel+bounces-827643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CADB924A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C081E17C21C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FA19C556;
	Mon, 22 Sep 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFlKDUEd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB394214807
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559573; cv=none; b=NUql0IKUODwMXhITiqKy6ozt6KLAdDrVoHTyUmivfponmRcZdT5Q143jopfD4cC/fHub8V56GmapbRQvq4gHdN5WwRhAT+tElcO3blmFHy9wmvIXYz0ND+NTDLwKKQYMCoY510XArLdMGugNc9WJazJemssu/pvas+ZLYT1YFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559573; c=relaxed/simple;
	bh=bi31v8BFQzghDRm2SZnxNsKr0ymJw6MVL1akA3//X7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq3+hCjcrGamRnlykInpdlnVJ/8wfrBrXOSrNwQQ3We7s4RB517WdhyjrQOpH9PtdeAEC53xRbyY25+R6BlIusK/Ni4q46TSctfGv+fs9Yk68I3r48O9ouC6seUVrqCq7jUsoSW9QX9yIDbtWDR0hW1zJ3xQxlcLt7oTpfGYKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cFlKDUEd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so30812195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758559570; x=1759164370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DmEFxgmAVEtk875jgss2XO8XYozo00AgTRJPnU2LJXM=;
        b=cFlKDUEd0jk/bgCCCruth+ekDIAPLrf1LBah7WXaPz1qnzkfmx93V+hsjyNwSsEGX6
         6wQYeeVwVJGiqmN4W+ce8MTpL62kNUgSXLVtJHSGTb69ik76VGbfff1+GSiJwkf6kxLU
         q1zAm9OAWmO+0EORnFkR7bH0t4SX2FwG57EuDIMY92AuMKZRCfBtjP85Xvts/mSCu1U0
         Xp4xRxOZrurp+2ELnKIFXiWsWC/uVeAh1oQklUmkGOYM8HcEOgD1iByU1sch0Joh0tA1
         6ZubJg2O9ZJBEk2jBKTjUPV4qM25pGf46NZ14gSReeEWqNlISxuZ7fvHdKeLDVTYO9Ya
         0kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559570; x=1759164370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmEFxgmAVEtk875jgss2XO8XYozo00AgTRJPnU2LJXM=;
        b=BAmRa6N88YtSwEhG6WNsCd8OhxvYv6sNXDyGCogcEQqvBBxql4jEa7BDnQkXwKqigW
         JGr/n4j8vt+Kp2N8bYZ5bvuQ3GHzq/XbYzj06jj10W4l7Xn9qKMH8Stj8jNlseoKHmEb
         uKy6f2F0tCelhBTn4/JghYALtbZRm7C+k/Hodu5Fx5cZDiFyadE3BBuw9p+ISO+lI5mT
         Bz8h/HyX+6+Qf35ajuxlemdlLG+7cSJ4zC1xuy2nzgzFRB+y/Elf9MpYD73lLRGuaLx5
         yfWs3LD2QuL9q0n/xA3vgyPuGToxerGbdcje42frMTe1ZHMkal+Brrby66uI7DGovS3V
         82vw==
X-Forwarded-Encrypted: i=1; AJvYcCWGeIWAXHk72a5bs4SxFWwcymzgyznsyjQNF6XQROpWPbxWeCokHkrFaHj9Kwg+IZrwNVpcRlXBrGBKlU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjXMatW5QXsg06fI04QKtRSmXcSFZVny+PDFLNOiuvPz+5ADUF
	e5WHQx5xiYOp3gGl0anddyWDEoHB3rYC9D8AN98fUB2qG7n8+pd6yS9ReVFWNnAz8Mo=
X-Gm-Gg: ASbGncsg/qwO/jJ3cDs8hYYcFj3tNYS5k1xx4Mwbt1lzXC3pnYhtmbvSeB3xfoRn7Mb
	oEfsoy/o6DzGk5k2btRJfwtXA/4h1fySqxlFBZRRS+b4piABANRWUBDJtuK2QzUiGfYK5aEit0O
	6q3ogtRdUTPygrSC55RQ5FAKsgS29s5hR+SKJpD73V4jFAJ12q0ObM0f25HmGtgFXxW5szPw7ek
	vAdDQDitH5rpIDVFyz5Nb0CeJzSRyMklVLaaBNUpIPHi0QbSQAjBR40TakeFPFmoOV/7zDKoBl4
	CxGtzmwJuNLiZXPEoIezkmCel+cGxsUh7y5yGgjgrrVk64k0GoeQ5IjL/9ZF5XVAsR5y4utCcDY
	6OJ3MSc2AIoOFKFfdL9b1nsc/N0MDnjZO
X-Google-Smtp-Source: AGHT+IE14D5RfFWl+3oDwrEhrCSGb1LSkUa2XB++wA+FYelbyDuYa/J5IyH+Xp5w/aqOs5vNNITGdw==
X-Received: by 2002:a05:600c:314f:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-467ee305903mr111154085e9.1.1758559569503;
        Mon, 22 Sep 2025 09:46:09 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ae58:9ec8:1ac6:e1a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325cec0fsm145956135e9.4.2025.09.22.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:46:08 -0700 (PDT)
Date: Mon, 22 Sep 2025 18:46:04 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm: Fix refcnt underflow in error path
Message-ID: <aNF9TGkEfYqfegrR@linaro.org>
References: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
 <20250723190852.18394-2-robin.clark@oss.qualcomm.com>
 <aNF6N8u1VIFSTaRM@linaro.org>
 <CACSVV033oJodLUS2cwTVeMc9Y3o4np3UgDyX=T8caspRk3--4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV033oJodLUS2cwTVeMc9Y3o4np3UgDyX=T8caspRk3--4g@mail.gmail.com>

On Mon, Sep 22, 2025 at 09:41:07AM -0700, Rob Clark wrote:
> On Mon, Sep 22, 2025 at 9:33 AM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> > On Wed, Jul 23, 2025 at 12:08:49PM -0700, Rob Clark wrote:
> > > If we hit an error path in GEM obj creation before msm_gem_new_handle()
> > > updates obj->resv to point to the gpuvm resv object, then obj->resv
> > > still points to &obj->_resv.  In this case we don't want to decrement
> > > the refcount of the object being freed (since the refcnt is already
> > > zero).  This fixes the following splat:
> > >
> > >    ------------[ cut here ]------------
> > >    refcount_t: underflow; use-after-free.
> > >    WARNING: CPU: 9 PID: 7013 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
> > >    Modules linked in: uinput snd_seq_dummy snd_hrtimer aes_ce_ccm snd_soc_wsa884x regmap_sdw q6prm_clocks q6apm_lpass_da>
> > >     qcom_pil_info i2c_hid drm_kms_helper qcom_common qcom_q6v5 phy_snps_eusb2 qcom_geni_serial drm qcom_sysmon pinctrl_s>
> > >    CPU: 9 UID: 1000 PID: 7013 Comm: deqp-vk Not tainted 6.16.0-rc4-debug+ #25 PREEMPT(voluntary)
> > >    Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN53WW 08/02/2024
> > >    pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > >    pc : refcount_warn_saturate+0xf4/0x148
> > >    lr : refcount_warn_saturate+0xf4/0x148
> > >    sp : ffff8000a2073920
> > >    x29: ffff8000a2073920 x28: 0000000000000010 x27: 0000000000000010
> > >    x26: 0000000000000042 x25: ffff000810e09800 x24: 0000000000000010
> > >    x23: ffff8000a2073b94 x22: ffff000ddb22de00 x21: ffff000ddb22dc00
> > >    x20: ffff000ddb22ddf8 x19: ffff0008024934e0 x18: 000000000000000a
> > >    x17: 0000000000000000 x16: ffff9f8c67d77340 x15: 0000000000000000
> > >    x14: 00000000ffffffff x13: 2e656572662d7265 x12: 7466612d65737520
> > >    x11: 3b776f6c66726564 x10: 00000000ffff7fff x9 : ffff9f8c67506c70
> > >    x8 : ffff9f8c69fa26f0 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
> > >    x5 : ffff000f53e14548 x4 : ffff6082ea2b2000 x3 : ffff0008b86ab080
> > >    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008b86ab080
> > >    Call trace:
> > >     refcount_warn_saturate+0xf4/0x148 (P)
> > >     msm_gem_free_object+0x248/0x260 [msm]
> > >     drm_gem_object_free+0x24/0x40 [drm]
> > >     msm_gem_new+0x1c4/0x1e0 [msm]
> > >     msm_gem_new_handle+0x3c/0x1a0 [msm]
> > >     msm_ioctl_gem_new+0x38/0x70 [msm]
> > >     drm_ioctl_kernel+0xc8/0x138 [drm]
> > >     drm_ioctl+0x2c8/0x618 [drm]
> > >     __arm64_sys_ioctl+0xac/0x108
> > >     invoke_syscall.constprop.0+0x64/0xe8
> > >     el0_svc_common.constprop.0+0x40/0xe8
> > >     do_el0_svc+0x24/0x38
> > >     el0_svc+0x54/0x1d8
> > >     el0t_64_sync_handler+0x10c/0x138
> > >     el0t_64_sync+0x19c/0x1a0
> > >    irq event stamp: 3698694
> > >    hardirqs last  enabled at (3698693): [<ffff9f8c675021dc>] __up_console_sem+0x74/0x90
> > >    hardirqs last disabled at (3698694): [<ffff9f8c68ce8164>] el1_dbg+0x24/0x90
> > >    softirqs last  enabled at (3697578): [<ffff9f8c6744ec5c>] handle_softirqs+0x454/0x4b0
> > >    softirqs last disabled at (3697567): [<ffff9f8c67360244>] __do_softirq+0x1c/0x28
> > >    ---[ end trace 0000000000000000 ]---
> > >
> > > Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_gem.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > > index 33d3354c6102..958bac4e2768 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem.c
> > > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > > @@ -1114,10 +1114,12 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
> > >               put_pages(obj);
> > >       }
> > >
> > > -     if (msm_obj->flags & MSM_BO_NO_SHARE) {
> > > +     if (obj->resv != &obj->_resv) {
> > >               struct drm_gem_object *r_obj =
> > >                       container_of(obj->resv, struct drm_gem_object, _resv);
> > >
> > > +             WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
> > > +
> > >               /* Drop reference we hold to shared resv obj: */
> > >               drm_gem_object_put(r_obj);
> > >       }
> >
> > This patch seems to break something for direct IRIS/video playback using
> > dmabuf. I use a simple GStreamer test pipeline for testing IRIS on X1E
> > (on GNOME, in case that matters):
> >
> >  $ gst-launch-1.0 filesrc location=bbb_sunflower_2160p_60fps_normal.mp4 \
> >    ! qtdemux name=d d.video_0 ! h264parse ! v4l2h264dec \
> >    ! capture-io-mode=dmabuf ! waylandsink
> >
> > The video plays fine, but if I try to exit (CTRL+C) the display hangs
> > for a few seconds and then the console is spammed with pretty much
> > exactly the messages that you tried to fix here. If I revert this patch,
> > everything is fine again. It feels like your patch does exactly the
> > opposite for this use case. :-)
> >
> > It seems to run into the WARN_ON you added.
> 
> Hmm, are we allocating from drm and importing into v4l2, or the other direction?
> 

Is there an easy way to check?

I would need to study the code to be sure, you probably know more about
this than I do. I just run this command and it always worked so far
somehow. :-)

Thanks,
Stephan

