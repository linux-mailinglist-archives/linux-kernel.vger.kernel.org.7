Return-Path: <linux-kernel+bounces-896683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CDC50F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8151881DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820C2405E7;
	Wed, 12 Nov 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="PSUSQVUA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADC2D8DA9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933103; cv=none; b=Cs6qK8Nkx4CbcJQ5o3d6yjW4VazTnMw6jXNBS8HL8R7pVdD2NTAv1puhojVYgqiuEr10L6GhAXr0rDzj36cLPglmbEfkGlOarC3kpDPEu2e/5WnO267cksgbwrABxtDwlkmFtgalXKGIzF7Zc/1Zd5pnarKBNraE9pa9Ydvp+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933103; c=relaxed/simple;
	bh=7lU6RIYvEldi+DX6R17U3hQdUIjl8nePtD49a33zyHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZZ2VGEsxebVXkjn64GXbnjKs9v6Aa4U5+lE71o6MlYRfJdwSfU3iu6Z0+926tp5SIwBwE5qXMkJ+XOHpHdlBa2RzAsqRpVxmFNPShmHxqbR+sL8WO53d8ssra2aCBAflNT7HZdcA0O2aIQDfrDW8dmMlPk1mt2FgNcyseEiIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=PSUSQVUA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so55721b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762933101; x=1763537901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip1JZVKbkU4YZglnKwXhZ0t4rGJ6h2ex2G3eHcz4PB0=;
        b=PSUSQVUAkv97ixXn5IYJqiIM2zTiOCSPBvheL96W5BARkiVcPlq/6g7C68a/6sTanS
         HAZ9Y4gN0XIb2UneCLyen+U0AMGlHJqsCKELMO80x9xPrXlWJl0CH8wr8/rrjAYUhY41
         Xzlmvxk5avZH4OBIvz/liKcmpYq2IVkydI0WqDBZc1DEwh/7g5Shxymp8XKRLWvUpTHs
         BMWFIOL//+Dfu0OK3XZcywV2kt0P6rqWoOAVydQ2lcZ6hZ8Y2lyCi+Pq0fsZzyPYmKBk
         bjD1byDw23Jvb80e1qeOM/3L3Arv7Hm2YuLhMNXLoBMgsljAy+FMn8JUTuPCHySiGih1
         p5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933101; x=1763537901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip1JZVKbkU4YZglnKwXhZ0t4rGJ6h2ex2G3eHcz4PB0=;
        b=h+8PNkU9i2ZVdAsWKcCktRUe2fh41ZKzUrihlSp8qid1pkzb2aIrUl4PceEla4sGzV
         fCvCxPaqUdcqBX8scjdyA19UGNCle0HnevF95/05FfJV/K0cM+ltQTImd3uCW7rvBRli
         /n2BCj3qyoqeTcvnBCbbfdprGL88+P4Ag5YBcSQ1Hvd1WaF7tpxuBMcDqcZaxj8eooNl
         5UWUiSMbPIcUaE0GmM3f3RflKSwFMBQdm0pdtRvFOvkuD2MVio3csINRPjPhNfISebdi
         qhvbsb7HPEpjHh8yliTmofXV/TlJ8b1151d6maNCFbLi02LhMLiZOn6g+M6AbDPxQyGq
         z28g==
X-Forwarded-Encrypted: i=1; AJvYcCVjtR0dV+N87elRpUQjd7ULFFRpx299gKmHWa4QvuZdA0tSXQtbRTItxuR0qveSLzKce5/TlvFTZ7bP8zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9FQpOHjg+80nv9jn9GY3hLKjgUzyIXftn5+/npknYQnCGPnD
	RKduv/jjmG86N4c6h99doAfocwk30u5Ew+U/Kpz0SSCokDLY9x/V32LENtl5oCKA0DCc
X-Gm-Gg: ASbGncuajjjkPkOt6DziwkkW1XANapXen/lawYKRpZGjDAfkAOyaAB8pE1Uf8cJ29bN
	d5v3YU61O4GcV6r0n1bqDmjRf41USL9KdpJwbR0q7aMGbGuJ2ppX5TmgNpFiCkcHmJNz77NCsLk
	2SdvaS75B5o+KVBiucL5oybDAsBRQ9xSAKy/pvgHMIuwUgqWeVqyS15EuekvVxVfbphGqgdfjYi
	XVeoGIfvHCOO7eiNiGFaxk4fV91qXBtqQMyDqMyBQeCZ0enGw0MNI5UjIi05zmmTXKiVV2lNs9j
	BcnjURkpXc6PDZUiw1Sx1ubpo2fmTE1iCeNVchGjaTQdmqbfJciwnjJ96kuyb1MHn1n8QEvfA8+
	PVq/DgTvWhMC+BoGrJdg9z/9yXIo3/T7nhjG9uKVE6cMinj/gH3sNNg57GvWD4pHGJOgUTPit3S
	xaL/I=
X-Google-Smtp-Source: AGHT+IFcnHWK4+WMiNf14t0eEhYbceT12F3a70KNL4K6U5CPo4ubAkHBQnK5W0643U1DMILjjR6UHQ==
X-Received: by 2002:a05:6a20:938e:b0:334:9b5d:388e with SMTP id adf61e73a8af0-35909c71826mr2841376637.26.1762933100527;
        Tue, 11 Nov 2025 23:38:20 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf167e28basm1901195a12.24.2025.11.11.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:38:19 -0800 (PST)
Date: Tue, 11 Nov 2025 23:38:16 -0800
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
Message-ID: <aRQ5aA4Gus4iCVLp@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
 <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
 <aRPH1hV7bEfagPtE@sultan-box>
 <aRPhMCwJjpMqAROG@sultan-box>
 <d9afc6db-fd8a-4069-a8a8-1e2d74c1db3a@amd.com>
 <aRQyAdyiQjhsC11h@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRQyAdyiQjhsC11h@sultan-box>

On Tue, Nov 11, 2025 at 11:06:41PM -0800, Sultan Alsawaf wrote:
> On Wed, Nov 12, 2025 at 02:32:51PM +0800, Du, Bin wrote:
> > Thanks Sultan for your information.
> > 
> > On 11/12/2025 9:21 AM, Sultan Alsawaf wrote:
> > > On Tue, Nov 11, 2025 at 03:33:42PM -0800, Sultan Alsawaf wrote:
> > > > On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
> > > > > 
> > > > > On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
> > > > > 
> > > > > > On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> > > > > > > Thank you, Sultan, for your time, big effort, and constant support.
> > > > > > > Apologies for my delayed reply for being occupied a little with other
> > > > > > > matters.
> > > > > > > 
> > > > > > > On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > > > > > > > Hi Bin,
> > > > > > > > 
> > > > > > > > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > > > > > > > Hi Bin,
> > > > > > > > > 
> > > > > > > > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > > > > > > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > > > > > > > further about specific changes if you have any questions.
> > > > > > > > > 
> > > > > > > > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > > > > > > > I should send what I've got so far.
> > > > > > > > > 
> > > > > > > > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > > > > > > > protecting the list_del() anymore. I also checked the compiler output when using
> > > > > > > > > guard() versus scoped_guard() in that function and there is no difference:
> > > > > > > > > 
> > > > > > > > >      sha1sum:
> > > > > > > > >      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > > > > > > > >      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > > > > > > > 
> > > > > > > > > So guard() should be used there again, which I've done in my patch.
> > > > > > > > > 
> > > > > > > > > I also have a few questions:
> > > > > > > > > 
> > > > > > > > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > > > > > > > >       faster to use that than using disable_irq_nosync() to disable the IRQ from
> > > > > > > > >       the CPU's side.
> > > > > > > > > 
> > > > > > > > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > > > > > > > >       beforehand to mask all pending interrupts from the ISP so that there isn't a
> > > > > > > > >       bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > > > > > > > 
> > > > > > > > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > > > > > > > >       when the ISP posts a new response _after_ the kthread determines there are no
> > > > > > > > >       more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > > > > > > > 
> > > > > > > > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > > > > > > > >       there is a mix of several lines wrapped to 80 cols and many lines going
> > > > > > > > >       beyond 80 cols. And there are multiple places where code is wrapped before
> > > > > > > > >       reaching 80 cols even with lots of room left, specifically for cases where it
> > > > > > > > >       wouldn't hurt readability to put more characters onto each line.
> > > > > > > > 
> > > > > > > > I've attached a new, complete patch of changes to apply on top of v5. You may
> > > > > > > > ignore the incomplete patch from my previous email and use the new one instead.
> > > > > > > > 
> > > > > > > > I made many changes and also answered questions 1-3 myself.
> > > > > > > > 
> > > > > > > > Please apply this on top of v5 and let me know if you have any questions.
> > > > > > > > 
> > > > > > > 
> > > > > > > Sure, will review, apply and test your patch accordingly. Your contribution
> > > > > > > is greatly appreciated, will let you know if there is any question or
> > > > > > > problem.
> > > > > > > 
> > > > > > > > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > > > > > > > time you use cheese after using it one time, the video will freeze after 30-60
> > > > > > > > seconds with this message printed to dmesg:
> > > > > > > >      [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > > > > > > > 
> > > > > > > > And the video never unfreezes. I haven't found the cause for the regression yet;
> > > > > > > > can you try to reproduce it?
> > > > > > > > 
> > > > > > > 
> > > > > > > Really weird, we don't see this issue either in dev or QA test. Is it 100%
> > > > > > > reproducible and any other fail or err in the log?
> > > > > > 
> > > > > > Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> > > > > > 
> > > > > > Sometimes there is a stop stream error when I close cheese after it froze:
> > > > > > 
> > > > > >     [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
> > > > > >     [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
> > > > > >     [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> > > > > > 
> > > > > > When I revert to v4 I cannot reproduce it at all. It seems to be something in
> > > > > > v4 -> v5 that is not fixed by any of my changes.
> > > > > > 
> > > > > 
> > > > > Hi Sultan, could you please try following modifications on top of v5 to see
> > > > > if it helps?
> > > > > 
> > > > > diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > > b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > > index 39c2265121f9..d571b3873edb 100644
> > > > > --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > > +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > > @@ -97,7 +97,7 @@
> > > > > 
> > > > > #define ADDR_SPACE_TYPE_GPU_VA          4
> > > > > 
> > > > > -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> > > > > +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> > > > > 
> > > > > /*
> > > > >    * standard ISP mipicsi=>isp
> > > > > diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > > b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > > index 248d10076ae8..acbc80aa709e 100644
> > > > > --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > > +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > > @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
> > > > > isp4_subdev *isp_subdev)
> > > > >          return 0;
> > > > > }
> > > > > 
> > > > > -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > > > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
> > > > > irq_enabled)
> > > > > {
> > > > >          struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > > > >          unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > > > > @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
> > > > > *isp_subdev)
> > > > >                  return 0;
> > > > >          }
> > > > > 
> > > > > -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > > -               disable_irq(isp_subdev->irq[i]);
> > > > > +       if (irq_enabled)
> > > > > +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > > +                       disable_irq(isp_subdev->irq[i]);
> > > > > 
> > > > >          isp4sd_stop_resp_proc_threads(isp_subdev);
> > > > >          dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > > > > @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
> > > > > *isp_subdev)
> > > > > 
> > > > >          return 0;
> > > > > err_unlock_and_close:
> > > > > -       isp4sd_pwroff_and_deinit(isp_subdev);
> > > > > +       isp4sd_pwroff_and_deinit(isp_subdev, false);
> > > > >          return -EINVAL;
> > > > > }
> > > > > 
> > > > > @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
> > > > > on)
> > > > >          if (on)
> > > > >                  return isp4sd_pwron_and_init(isp_subdev);
> > > > >          else
> > > > > -               return isp4sd_pwroff_and_deinit(isp_subdev);
> > > > > +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
> > > > > }
> > > > > 
> > > > > static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> > > > 
> > > > No difference sadly; same symptoms as before. FYI, your email client broke the
> > > > patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
> > > > replaced tabs with spaces, and removed leading spaces on each context line, so I
> > > > had to apply it manually. To confirm I applied it correctly, here is my diff:
> > > > 
> > > > diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > index 39c2265121f9..d571b3873edb 100644
> > > > --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > @@ -97,7 +97,7 @@
> > > >   #define ADDR_SPACE_TYPE_GPU_VA          4
> > > > -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> > > > +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> > > >   /*
> > > >    * standard ISP mipicsi=>isp
> > > > diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > index 4bd2ebf0f694..500ef0af8a41 100644
> > > > --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > @@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
> > > >   	return 0;
> > > >   }
> > > > -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
> > > >   {
> > > >   	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > > >   	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > > > @@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > >   		return 0;
> > > >   	}
> > > > -	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > -		disable_irq(isp_subdev->irq[i]);
> > > > +	if (irq_enabled)
> > > > +		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > +			disable_irq(isp_subdev->irq[i]);
> > > >   	isp4sd_stop_resp_proc_threads(isp_subdev);
> > > >   	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > > > @@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
> > > >   	return 0;
> > > >   err_unlock_and_close:
> > > > -	isp4sd_pwroff_and_deinit(isp_subdev);
> > > > +	isp4sd_pwroff_and_deinit(isp_subdev, false);
> > > >   	return -EINVAL;
> > > >   }
> > > > @@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
> > > >   	if (on)
> > > >   		return isp4sd_pwron_and_init(isp_subdev);
> > > >   	else
> > > > -		return isp4sd_pwroff_and_deinit(isp_subdev);
> > > > +		return isp4sd_pwroff_and_deinit(isp_subdev, true);
> > > >   }
> > > >   static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> > > > 
> > > > > On the other hand, please also add the patch in amdgpu which sets *bo to
> > > > > NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.
> > > > 
> > > > Yep, I have been doing all v5 testing with that patch applied.
> > > > 
> > > > BTW, I have verified the IRQ changes are not the cause for the regression; I
> > > > tested with IRQs kept enabled all the time and the issue still occurs.
> > > > 
> > > > I did observe that ISP stops sending interrupts when the video stream freezes.
> > > > And, if I replicate the bug enough times, it seems to permanently break FW until
> > > > a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
> > > > the ISP when this happens.
> > > > 
> > > > As an improvement to the driver, can we do a hard reset of ISP on driver probe?
> > > > I am assuming hardware doesn't need too long to settle after hard reset, maybe
> > > > a few hundred milliseconds? This would ensure ISP FW is always in a working
> > > > state when the driver is loaded.
> > > > 
> > 
> > Actually, each time the camera is activated, the ISP driver powers on the
> > ISP and initiates its firmware from the beginning; when the camera is
> > closed, the ISP is powered off..
> 
> Hmm, well I am able to put the ISP in a completely unusable state that doesn't
> recover when I unload and reload amd_capture. Or maybe it is the sensor that is
> stuck in a broken state?

Here is the log output when I try to start cheese after unloading and reloading
amd_capture, where the ISP is in the broken state that requires rebooting the
laptop (annotated with notes of what I saw/did at each point in time):

==> opened cheese
==> cheese froze after a few seconds
==> closed cheese
  [   34.570823] amd_isp_capture amd_isp_capture: fail to disable stream
  [   35.077503] amd_isp_capture amd_isp_capture: fail to stop steam
  [   35.077525] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
==> unloaded amd_capture
==> loaded amd_capture
==> opened cheese
  [  308.039721] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
  [  308.043961] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
  [  308.044188] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044194] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044196] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044197] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044198] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044198] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044199] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044200] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044200] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044201] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.044202] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.065226] amd_isp_capture amd_isp_capture: power up isp fail -22
  [  308.174814] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
  [  308.177807] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
  [  308.178036] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178043] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178044] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178045] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178046] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178047] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178048] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178048] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178049] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178050] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.178050] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.198776] amd_isp_capture amd_isp_capture: power up isp fail -22
  [  308.306835] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
  [  308.311533] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
  [  308.311723] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311723] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311724] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311725] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311725] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
  [  308.335281] amd_isp_capture amd_isp_capture: power up isp fail -22

> > > > Thanks,
> > > > Sultan
> > > 
> > > A small update: I reproduced the issue on v4, but it took several more cycles of
> > > closing/opening cheese and waiting 30s compared to v5.
> > > 
> > > Right now my best guess is that this is a timing issue with respect to FW that
> > > was exposed by the v5 changes. v5 introduced slight changes in code timing, like
> > > with the mutex locks getting replaced by spin locks.
> > > 
> > > I'll try to insert mdelays to see if I can expose the issue that way on v4.
> > > 
> > 
> > Could you kindly provide the FW used?
> 
>   commit a89515d3ff79f12099f7a51b0f4932b881b7720e
>   Author: Pratap Nirujogi <pratap.nirujogi@amd.com>
>   Date:   Thu Aug 21 15:40:45 2025 -0400
> 
>       amdgpu: Update ISP FW for isp v4.1.1
>       
>       From internal git commit:
>       24557b7326e539183b3bc44cf8e1496c74d383d6
>       
>       Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> 
> Sultan

Sultan

