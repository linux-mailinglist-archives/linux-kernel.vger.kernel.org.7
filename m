Return-Path: <linux-kernel+bounces-827758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6840B92A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1F3AB907
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617B31A07D;
	Mon, 22 Sep 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1VFKcAr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAB4315A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566984; cv=none; b=X2zFL2Jb+XLiRAc6ULTQJZPJCNMpCOD3uJmoMCTCQVd6scY6rrfqnFJzIRbDx8C1bJ6jhFjwEHjCvcsHKC5a+aoCoWhhqDAszHvsX7gWtpvSSNJubtCb3C3Sp5Xx7y9XWVMydHqMo4KiyTeKRw3yuZyexHID7JBNauS4S/GcDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566984; c=relaxed/simple;
	bh=8MOVDgcHHOJOiA/FpSOn5ZoTVvgdyGEWgy5FHiCnOhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD5w3jYM3wlAuK/DS+JWgzo8u5DcbPQqy3zO5eYVR9s2Qf6HI8KXGjVHDPPnQdwMnZfafK0iuzqpx4pvOAcAwMzocPuHybDCpO1RQdDeBxYwGx7MAshJ/Cqs9W4MimSI4cWEk7PWr8S6FwXaWiECl3XPQ+/qrN2HoCumpVvJaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x1VFKcAr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fd0d29e2bso4875595a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758566981; x=1759171781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0Xo4OfJDsJ2tCQThJXl8urjBhN3ZJWclDiVLqpDNZM=;
        b=x1VFKcArRyh5AcoOBBLJxzrXhiO+26cUHXMKw6VImT9QPLxSz6V7jP8eRLu9AzoG4A
         r3xrkNY8Lt/CM3ROdWemhecb5ANBVyic5Dwb6Q5aoZQa44ClnYUGx/NiW0BgSYraX17j
         14B21MZNDrknif666N+rcpfGN3gQnl3ERW0JVAajen2Fo55X6XgqMclkvAncXlMTjxPp
         kB1rzt0Wcg6hdn7ZU31hZe1aUM3TFOoO8tOKkvxicHbukl5LSMqYNvw3dOBHfZoa+tEy
         r5Xi6+EffE/L+ujVnurHTl54z82sBZGMdcPJw6HZp1yxvNcZwgSYje85Cbw4Ra+viJDr
         UXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566981; x=1759171781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0Xo4OfJDsJ2tCQThJXl8urjBhN3ZJWclDiVLqpDNZM=;
        b=TT87ZsIOiSzIw7t5ixXynXslHMsaUC81uzs5VQR2IGtCzkmwRH+tQ+ZnwHe++sbGsC
         BbOkOfXuhrmTxsCpCdJiAsvqkYImhsAkCMoBgjFGEtBkM8wMeCaLo5R+Fpx12y9hq95d
         0bztJXjWA3lfsvDsLw+FO9O777SShj3DztfBThNHSyB4Y1r6T/Gx+yABTKH3ApZPfnc5
         SQUSzIAMqIUt0dRLLV1BjoMqhYlIRalcIuZG5VsTh5qGC3Rwvc3WAqxaNCDuN8D1w01l
         FbqqvJ+EyAU/kJWblEZUdQgPeKpNFNIQqxiXlgVbQpT0aGZKrNyx0Cr8WW5xB3h90XdR
         eKgg==
X-Forwarded-Encrypted: i=1; AJvYcCW0aPPV7FcfWkGCrPW7sdp4PcjGIcvJZxlL/StBtocOvJL01ainsBGaW7u1LAaXUkK/w8q3paaBYNgaRMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEWTl3v0XkRyu76zovFm77J1Y/tXvoZPNrO/fn78mk7tKS9/S
	dkok81malAX+i4jkMt/NnmEchNWF1oY9ZnIWMxAvwu0FR3E7f2bH7yPgTidWST83bO8=
X-Gm-Gg: ASbGncuFYCb5jWJyyGIg8AILvXkfYwbMay6v1J5eju2yAnblrciBjunujilE6z3/ayG
	tAnDvdpSy5OJNMvwpnczwfc7EKNKd43cNNykyckmT+C9LxajTrzFf14YOxTfhdb4jFloO8+NQi8
	C+iPehK5zotMg95oCR5/IBawhcpAJTIGc2UmCtGu5SjZsZhQ4NuuNcoN9ZYHvJtSVOi9WHW6ReJ
	15yfPoO7ijIvmh/dCEg5VZbIQEjAa6FtLyLly3t0XYeG6o0p5lpDsGJCBk5XSjBSb9yZvStUb/5
	ANAmIjXm+mhVc0DTPuu+jmQ0GX4lfO2zgVMuaOdJozN6cOPdVEyySHM7ven0kPmbowUtSIwnQQo
	/Fm0VJxqCbX/1Av7m+I2PvP9BNvMAFJi3
X-Google-Smtp-Source: AGHT+IEOSfm52Z4OtaffuSqqXC5cdTELTowYo46bMLRhUhciT+GTZfk4E0MhVzGKb69LqaJiHUqYiQ==
X-Received: by 2002:a05:6402:a0cb:b0:62f:67bb:d399 with SMTP id 4fb4d7f45d1cf-62fc0a6c2a6mr11919155a12.29.1758566981201;
        Mon, 22 Sep 2025 11:49:41 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ea75:1d3c:40d3:4271])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fb10537d1sm8410113a12.24.2025.09.22.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:49:40 -0700 (PDT)
Date: Mon, 22 Sep 2025 20:49:36 +0200
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
Message-ID: <aNGaQI1Z4ZvLr17u@linaro.org>
References: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
 <20250723190852.18394-2-robin.clark@oss.qualcomm.com>
 <aNF6N8u1VIFSTaRM@linaro.org>
 <CACSVV033oJodLUS2cwTVeMc9Y3o4np3UgDyX=T8caspRk3--4g@mail.gmail.com>
 <aNF9TGkEfYqfegrR@linaro.org>
 <CACSVV015U3=KpZqxzH7ySO=ok8k-0ff_-Yzc33SK_Smj1c-4-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV015U3=KpZqxzH7ySO=ok8k-0ff_-Yzc33SK_Smj1c-4-A@mail.gmail.com>

On Mon, Sep 22, 2025 at 10:42:52AM -0700, Rob Clark wrote:
> On Mon, Sep 22, 2025 at 9:46 AM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> >
> > On Mon, Sep 22, 2025 at 09:41:07AM -0700, Rob Clark wrote:
> > > On Mon, Sep 22, 2025 at 9:33 AM Stephan Gerhold
> > > <stephan.gerhold@linaro.org> wrote:
> > > > On Wed, Jul 23, 2025 at 12:08:49PM -0700, Rob Clark wrote:
> > > > > If we hit an error path in GEM obj creation before msm_gem_new_handle()
> > > > > updates obj->resv to point to the gpuvm resv object, then obj->resv
> > > > > still points to &obj->_resv.  In this case we don't want to decrement
> > > > > the refcount of the object being freed (since the refcnt is already
> > > > > zero).  This fixes the following splat:
> > > > >
> > > > >    ------------[ cut here ]------------
> > > > >    refcount_t: underflow; use-after-free.
> > > > >    WARNING: CPU: 9 PID: 7013 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
> > > > >    Modules linked in: uinput snd_seq_dummy snd_hrtimer aes_ce_ccm snd_soc_wsa884x regmap_sdw q6prm_clocks q6apm_lpass_da>
> > > > >     qcom_pil_info i2c_hid drm_kms_helper qcom_common qcom_q6v5 phy_snps_eusb2 qcom_geni_serial drm qcom_sysmon pinctrl_s>
> > > > >    CPU: 9 UID: 1000 PID: 7013 Comm: deqp-vk Not tainted 6.16.0-rc4-debug+ #25 PREEMPT(voluntary)
> > > > >    Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN53WW 08/02/2024
> > > > >    pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > > >    pc : refcount_warn_saturate+0xf4/0x148
> > > > >    lr : refcount_warn_saturate+0xf4/0x148
> > > > >    sp : ffff8000a2073920
> > > > >    x29: ffff8000a2073920 x28: 0000000000000010 x27: 0000000000000010
> > > > >    x26: 0000000000000042 x25: ffff000810e09800 x24: 0000000000000010
> > > > >    x23: ffff8000a2073b94 x22: ffff000ddb22de00 x21: ffff000ddb22dc00
> > > > >    x20: ffff000ddb22ddf8 x19: ffff0008024934e0 x18: 000000000000000a
> > > > >    x17: 0000000000000000 x16: ffff9f8c67d77340 x15: 0000000000000000
> > > > >    x14: 00000000ffffffff x13: 2e656572662d7265 x12: 7466612d65737520
> > > > >    x11: 3b776f6c66726564 x10: 00000000ffff7fff x9 : ffff9f8c67506c70
> > > > >    x8 : ffff9f8c69fa26f0 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
> > > > >    x5 : ffff000f53e14548 x4 : ffff6082ea2b2000 x3 : ffff0008b86ab080
> > > > >    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008b86ab080
> > > > >    Call trace:
> > > > >     refcount_warn_saturate+0xf4/0x148 (P)
> > > > >     msm_gem_free_object+0x248/0x260 [msm]
> > > > >     drm_gem_object_free+0x24/0x40 [drm]
> > > > >     msm_gem_new+0x1c4/0x1e0 [msm]
> > > > >     msm_gem_new_handle+0x3c/0x1a0 [msm]
> > > > >     msm_ioctl_gem_new+0x38/0x70 [msm]
> > > > >     drm_ioctl_kernel+0xc8/0x138 [drm]
> > > > >     drm_ioctl+0x2c8/0x618 [drm]
> > > > >     __arm64_sys_ioctl+0xac/0x108
> > > > >     invoke_syscall.constprop.0+0x64/0xe8
> > > > >     el0_svc_common.constprop.0+0x40/0xe8
> > > > >     do_el0_svc+0x24/0x38
> > > > >     el0_svc+0x54/0x1d8
> > > > >     el0t_64_sync_handler+0x10c/0x138
> > > > >     el0t_64_sync+0x19c/0x1a0
> > > > >    irq event stamp: 3698694
> > > > >    hardirqs last  enabled at (3698693): [<ffff9f8c675021dc>] __up_console_sem+0x74/0x90
> > > > >    hardirqs last disabled at (3698694): [<ffff9f8c68ce8164>] el1_dbg+0x24/0x90
> > > > >    softirqs last  enabled at (3697578): [<ffff9f8c6744ec5c>] handle_softirqs+0x454/0x4b0
> > > > >    softirqs last disabled at (3697567): [<ffff9f8c67360244>] __do_softirq+0x1c/0x28
> > > > >    ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
> > > > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/msm/msm_gem.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > > > > index 33d3354c6102..958bac4e2768 100644
> > > > > --- a/drivers/gpu/drm/msm/msm_gem.c
> > > > > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > > > > @@ -1114,10 +1114,12 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
> > > > >               put_pages(obj);
> > > > >       }
> > > > >
> > > > > -     if (msm_obj->flags & MSM_BO_NO_SHARE) {
> > > > > +     if (obj->resv != &obj->_resv) {
> > > > >               struct drm_gem_object *r_obj =
> > > > >                       container_of(obj->resv, struct drm_gem_object, _resv);
> > > > >
> > > > > +             WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
> > > > > +
> > > > >               /* Drop reference we hold to shared resv obj: */
> > > > >               drm_gem_object_put(r_obj);
> > > > >       }
> > > >
> > > > This patch seems to break something for direct IRIS/video playback using
> > > > dmabuf. I use a simple GStreamer test pipeline for testing IRIS on X1E
> > > > (on GNOME, in case that matters):
> > > >
> > > >  $ gst-launch-1.0 filesrc location=bbb_sunflower_2160p_60fps_normal.mp4 \
> > > >    ! qtdemux name=d d.video_0 ! h264parse ! v4l2h264dec \
> > > >    ! capture-io-mode=dmabuf ! waylandsink
> > > >
> > > > The video plays fine, but if I try to exit (CTRL+C) the display hangs
> > > > for a few seconds and then the console is spammed with pretty much
> > > > exactly the messages that you tried to fix here. If I revert this patch,
> > > > everything is fine again. It feels like your patch does exactly the
> > > > opposite for this use case. :-)
> > > >
> > > > It seems to run into the WARN_ON you added.
> > >
> > > Hmm, are we allocating from drm and importing into v4l2, or the other direction?
> > >
> >
> > Is there an easy way to check?
> 
> Maybe strace?  But, I think this would help, at least if v4l2 is allocating:
> 

I would indeed guess that v4l2 is allocating in this case. I didn't end
up checking with strace, because your proposed change

> - if (obj->resv != &obj->_resv) {
> + if ((msm_obj->flags & MSM_BO_NO_SHARE) && (obj->resv != &obj->_resv)) {
> 

fixes the issue. Thanks! If this makes sense to you, could you submit a
patch?

Thanks,
Stephan

