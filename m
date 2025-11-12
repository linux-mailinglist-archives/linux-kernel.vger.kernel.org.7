Return-Path: <linux-kernel+bounces-896360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE4C50326
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F773B1A47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF2DF72;
	Wed, 12 Nov 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="Ji6Fv/EE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62C2528FD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910524; cv=none; b=fVwRWY02tSmJw1Sx3X9Idpuz+Bi7T0iwFH3NAs/rkp37WT66hueSL3ENAvnGV3OWPLNnRwVEhlgONiz5clgoE/rZSgkxL90YUu5D6Wn3+KlehkrVjmDty/cB+KK1rAy9ZMEf/79ByYVmuC0pUOIu2YYlBtoh9LJSrg6bR6hjCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910524; c=relaxed/simple;
	bh=m69KpRHg7EGDDjePZus9Qh88LM0hyT3PJdRCEEgBrXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEyuda/8XFa0YPd5pL+SLR1u35vsv0eBrOXyKMu2WSt3c0n6NchZMqaccgFkWIqeHcrWDZh9LXQWPDkkQVqLZTxuBPcRivKSNfxReIkWdBNlBlwJ+5XdxAumcjMp89uup4+iOlU0o2XPFOIc8exQR85gUHkFcQiE1HHL8evnLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=Ji6Fv/EE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso321836a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762910517; x=1763515317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBIezAnMYZJY6x8PwDwTS4xVsAS3iTRwUPdVRsb0Orw=;
        b=Ji6Fv/EEHJWSfomNjcoKibd7Y7sNxifqvIXfKU/+ffIZul+SSLcG7Kq6KdUZnF851c
         Q7LWoY7wzntPOWrsBK/X01qarMZcuPX//VmOcfx0AUpKGUNJ7gMuLsImOUCtaqGPMfzJ
         mlU8JvCvu2lr4LHxC5N2TRVTrZ1TDUA6cSWTjzLNLEj/R2X1Qa7Mu9FYqaHT6oS//PiC
         y9Tn25fn1kG8Ym54GI3QI3wZpXyu3Th33KNKv/5wc1oj2J2RJprevTQ9+dvJNimMPzQU
         wtNkv8sp23SFz+CLzGEqPXJc1398KLkUOfMXujsaXBRyVgVeZPrr0Vc9N9E59VcbIbfg
         NzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762910517; x=1763515317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBIezAnMYZJY6x8PwDwTS4xVsAS3iTRwUPdVRsb0Orw=;
        b=ZOEErMR70I2hinyAUzhFmriLL5DdD7SsEOjgSK5u9g1lTyldK5cTAZEhpDH+U28V3m
         0DDOkU9cO/nyflm0E3mc/4G7WYWjzasmvDTFt5gDLH+yEDXt8RGxMTJFpYIoLVW590LA
         7mzqyMfYssabnLS8AGRxi6a1/23ok3bc3S7xztRS3m2G9gvi58i3YW95D1/eAosbVYRS
         7Lkc1jC4hiZOTCD9egDyU27LdPBNfPc1Ok8KAlanbhhXuusq+iNX6WCOJ7Wl8A7ZSrA0
         a4WQCf1qcxGF+Qzd9kHi7JMDkcM//1/zwaz7bwVQMKuTaTwgJy0YSdcxZoUF6KBmRZpY
         vMSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQNxbAOnKRWTE90PX0sosUbPYId/bh7R0Esp90gy/Lh7jCbgqp0aLphYpUl02lA+A/JJpZYdO15JZkw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3h/LinrVCbNrCD+DpNQlgGckKoOUGoSPllza4Qj/jtuhYki+
	0Y2DhV52CElunE0eF+OTbZOU8JelGbBrcaaYYduWJd7YqUmL3veHp14tjDi0byOejJz+
X-Gm-Gg: ASbGnctQKLI/3BfTU+anOQsGqpK7HOOovWfCfI/dZ1isLhEAfd/qH2E/n2j70zHy9WV
	Rm+Ocgvu8BOxDdz26OiM9MBC7cktz9DUr1VyY8PYuOFpwtgIqN9sZwldW72NAz9WGw/dsYUkdlX
	h/q1bJw3Rv6F+n+W0pJbGowcVvAaf6DSX44TIgOFs0tgRHM33tcr0cg22lIWRB+yC/0RH6ilcpo
	/TZzjZMfcLj24dvftimMhLRQ61lAIcDBNs8+hVhVp3XK1DlMb0zpV9P8yW1nVZXxrrggeBlukSm
	H1HmGk+y6q+IawisNJLF8jnxRzIQTuqkZ3R18J2kQTzw7YJnzgX1GXYYbo43x6i//0d4WARLoLi
	OXM1RVtBe02WUKzYXlU3Wus0iGUDI0iqFOPXHihlU7TuAht0V8Mdl7MQgKWRdWAppzhUe4bwTKk
	ufbhWNdg==
X-Google-Smtp-Source: AGHT+IGdcDvlJaVGeLfNWDsqkyZqDdJdvWz+LEi8s0P+SzACbOMHNGOxNwknmbXn9UKrt+la78LLiA==
X-Received: by 2002:a17:90b:274a:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-343dddee994mr1508034a91.4.1762910517425;
        Tue, 11 Nov 2025 17:21:57 -0800 (PST)
Received: from sultan-box ([2607:fb91:1dc2:893f:7bed:ad66:737b:260b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e072580dsm456620a91.8.2025.11.11.17.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 17:21:56 -0800 (PST)
Date: Tue, 11 Nov 2025 17:21:52 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aRPhMCwJjpMqAROG@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
 <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
 <aRPH1hV7bEfagPtE@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRPH1hV7bEfagPtE@sultan-box>

On Tue, Nov 11, 2025 at 03:33:42PM -0800, Sultan Alsawaf wrote:
> On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
> > 
> > On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
> > 
> > > On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> > > > Thank you, Sultan, for your time, big effort, and constant support.
> > > > Apologies for my delayed reply for being occupied a little with other
> > > > matters.
> > > > 
> > > > On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > > > > Hi Bin,
> > > > > 
> > > > > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > > > > Hi Bin,
> > > > > > 
> > > > > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > > > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > > > > further about specific changes if you have any questions.
> > > > > > 
> > > > > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > > > > I should send what I've got so far.
> > > > > > 
> > > > > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > > > > protecting the list_del() anymore. I also checked the compiler output when using
> > > > > > guard() versus scoped_guard() in that function and there is no difference:
> > > > > > 
> > > > > >     sha1sum:
> > > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > > > > 
> > > > > > So guard() should be used there again, which I've done in my patch.
> > > > > > 
> > > > > > I also have a few questions:
> > > > > > 
> > > > > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > > > > >      faster to use that than using disable_irq_nosync() to disable the IRQ from
> > > > > >      the CPU's side.
> > > > > > 
> > > > > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > > > > >      beforehand to mask all pending interrupts from the ISP so that there isn't a
> > > > > >      bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > > > > 
> > > > > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > > > > >      when the ISP posts a new response _after_ the kthread determines there are no
> > > > > >      more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > > > > 
> > > > > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > > > > >      there is a mix of several lines wrapped to 80 cols and many lines going
> > > > > >      beyond 80 cols. And there are multiple places where code is wrapped before
> > > > > >      reaching 80 cols even with lots of room left, specifically for cases where it
> > > > > >      wouldn't hurt readability to put more characters onto each line.
> > > > > 
> > > > > I've attached a new, complete patch of changes to apply on top of v5. You may
> > > > > ignore the incomplete patch from my previous email and use the new one instead.
> > > > > 
> > > > > I made many changes and also answered questions 1-3 myself.
> > > > > 
> > > > > Please apply this on top of v5 and let me know if you have any questions.
> > > > > 
> > > > 
> > > > Sure, will review, apply and test your patch accordingly. Your contribution
> > > > is greatly appreciated, will let you know if there is any question or
> > > > problem.
> > > > 
> > > > > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > > > > time you use cheese after using it one time, the video will freeze after 30-60
> > > > > seconds with this message printed to dmesg:
> > > > >     [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > > > > 
> > > > > And the video never unfreezes. I haven't found the cause for the regression yet;
> > > > > can you try to reproduce it?
> > > > > 
> > > > 
> > > > Really weird, we don't see this issue either in dev or QA test. Is it 100%
> > > > reproducible and any other fail or err in the log?
> > > 
> > > Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> > > 
> > > Sometimes there is a stop stream error when I close cheese after it froze:
> > > 
> > >    [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
> > >    [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
> > >    [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> > > 
> > > When I revert to v4 I cannot reproduce it at all. It seems to be something in
> > > v4 -> v5 that is not fixed by any of my changes.
> > > 
> > 
> > Hi Sultan, could you please try following modifications on top of v5 to see
> > if it helps?
> > 
> > diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > index 39c2265121f9..d571b3873edb 100644
> > --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > @@ -97,7 +97,7 @@
> > 
> > #define ADDR_SPACE_TYPE_GPU_VA          4
> > 
> > -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> > +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> > 
> > /*
> >   * standard ISP mipicsi=>isp
> > diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > index 248d10076ae8..acbc80aa709e 100644
> > --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
> > isp4_subdev *isp_subdev)
> >         return 0;
> > }
> > 
> > -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
> > irq_enabled)
> > {
> >         struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> >         unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
> > *isp_subdev)
> >                 return 0;
> >         }
> > 
> > -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > -               disable_irq(isp_subdev->irq[i]);
> > +       if (irq_enabled)
> > +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > +                       disable_irq(isp_subdev->irq[i]);
> > 
> >         isp4sd_stop_resp_proc_threads(isp_subdev);
> >         dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
> > *isp_subdev)
> > 
> >         return 0;
> > err_unlock_and_close:
> > -       isp4sd_pwroff_and_deinit(isp_subdev);
> > +       isp4sd_pwroff_and_deinit(isp_subdev, false);
> >         return -EINVAL;
> > }
> > 
> > @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
> > on)
> >         if (on)
> >                 return isp4sd_pwron_and_init(isp_subdev);
> >         else
> > -               return isp4sd_pwroff_and_deinit(isp_subdev);
> > +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
> > }
> > 
> > static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> 
> No difference sadly; same symptoms as before. FYI, your email client broke the
> patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
> replaced tabs with spaces, and removed leading spaces on each context line, so I
> had to apply it manually. To confirm I applied it correctly, here is my diff:
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> index 39c2265121f9..d571b3873edb 100644
> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> @@ -97,7 +97,7 @@
>  
>  #define ADDR_SPACE_TYPE_GPU_VA          4
>  
> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
>  
>  /*
>   * standard ISP mipicsi=>isp
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index 4bd2ebf0f694..500ef0af8a41 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
>  	return 0;
>  }
>  
> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
>  {
>  	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>  	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> @@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>  		return 0;
>  	}
>  
> -	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> -		disable_irq(isp_subdev->irq[i]);
> +	if (irq_enabled)
> +		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> +			disable_irq(isp_subdev->irq[i]);
>  
>  	isp4sd_stop_resp_proc_threads(isp_subdev);
>  	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> @@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
>  
>  	return 0;
>  err_unlock_and_close:
> -	isp4sd_pwroff_and_deinit(isp_subdev);
> +	isp4sd_pwroff_and_deinit(isp_subdev, false);
>  	return -EINVAL;
>  }
>  
> @@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
>  	if (on)
>  		return isp4sd_pwron_and_init(isp_subdev);
>  	else
> -		return isp4sd_pwroff_and_deinit(isp_subdev);
> +		return isp4sd_pwroff_and_deinit(isp_subdev, true);
>  }
>  
>  static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> 
> > On the other hand, please also add the patch in amdgpu which sets *bo to
> > NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.
> 
> Yep, I have been doing all v5 testing with that patch applied. 
> 
> BTW, I have verified the IRQ changes are not the cause for the regression; I
> tested with IRQs kept enabled all the time and the issue still occurs.
> 
> I did observe that ISP stops sending interrupts when the video stream freezes.
> And, if I replicate the bug enough times, it seems to permanently break FW until
> a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
> the ISP when this happens.
> 
> As an improvement to the driver, can we do a hard reset of ISP on driver probe?
> I am assuming hardware doesn't need too long to settle after hard reset, maybe
> a few hundred milliseconds? This would ensure ISP FW is always in a working
> state when the driver is loaded.
> 
> Thanks,
> Sultan

A small update: I reproduced the issue on v4, but it took several more cycles of
closing/opening cheese and waiting 30s compared to v5.

Right now my best guess is that this is a timing issue with respect to FW that
was exposed by the v5 changes. v5 introduced slight changes in code timing, like
with the mutex locks getting replaced by spin locks.

I'll try to insert mdelays to see if I can expose the issue that way on v4.

Sultan

