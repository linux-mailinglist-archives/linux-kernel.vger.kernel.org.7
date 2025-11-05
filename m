Return-Path: <linux-kernel+bounces-886958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C0C36D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E84FF29F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44196337B8D;
	Wed,  5 Nov 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KU8kDCQA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BA3321B9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361304; cv=none; b=aQrCwaY+iZsdcdMW0RXFBkbN6BrjQmfutk7zoT1Sg1RwaipmvuY4NIV4mtX8ZHER5dVFgofirTTW9ZdyFU34S7tNLveCxQueSZL6hEQ63aiQA6SfwPbNUx3ypaDJSVNKUz04I71AF8wCESlavPwmCINwyTFvz8EETwLd/woZKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361304; c=relaxed/simple;
	bh=613CfTeB04BMDfbYpCzU4r1GHXVyQQQOK+q1bwUH4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCFm9rV/WAuWtjQ+SBQTbESlRTXGZrnvzjJLXBBD/NREjQJRzVQz0Kx2QjNBgKzRoMvrL94SMH4P8w8RHMsBK89ke/BkcVQP0PYj2H5N5GQfE3ncL1dr0O/THZGTAp+1AKG0nkYZb5KmXMcpmytdk1yDjbUErqeXTOvSxXTUFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KU8kDCQA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b70bee93dc4so623966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762361301; x=1762966101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XmFotMcFPtd7mRBsLfVlVk451p+y5nFGd9HEIFSHePA=;
        b=KU8kDCQA5ikAOK3IvKx1wC2In5UnRPwVR0OTRlfE41XQ/P68crh3fX85P0hf6IarXi
         fjX+M68T4ukta8vcVtt2cz2rm4Cu1eu6Vg9eN9fAkGecie3DgtdVPxp4piUQxVgg+oRn
         yHhmiT6bR2468zBXKNa3vRd6fBQINxK23aMVkodgWhaItPSG6OU5FFQXcKDVMWl1SOnt
         7lKPkKL2RS0aVNtQ9u+OsipvzcCFcBg/fBAkiG50ArzqDxp6JOxp0U6y4lULdrQoLZ2r
         v/cuLB9ZTenEHlN7Gesb6LSH4GryX8b1/edTm0eg7tn2zJcUvQDlGKqQVJHMxXNZKTqH
         y7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361301; x=1762966101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmFotMcFPtd7mRBsLfVlVk451p+y5nFGd9HEIFSHePA=;
        b=lBRdiGz/vpSDAdxHmcJ8isf0VUtnYcit3AUYRjGBob/I7teTEEkMUeVXDvXCZQuMQ4
         RhYhk2ezgQ14N0zcVRAk1P0gfj4K+qXbbXKdxWpUHp79cx3JGOJcEGke7pmi4pATLDyt
         UtxcbSVV9t/PioU9RH1fW62FE8tgwhvsWZ3c6S+MUB0idYdmIH3lu8/ngy1vrQ5dE2mS
         UG6oNnyra1EXGE1Au7lqANlsGzkoiIyvI5s3ngPM/hBSzUKz2TkgSvKyR15jMkLf48i7
         mgOgedAUxvfqxiXh8Qpn486qFbmc4oVf2MqB0yB+3MORfCE0ao7Oa3aZyPyB3zJ8VNie
         JTZA==
X-Forwarded-Encrypted: i=1; AJvYcCXqVwEvmvDbk/le+MQhNYlCr2UhLwvxjCDqEslO9g4CZzzm2KIOOuKt+yg5RrMpuSf/sEoXSq2AetFJsm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUtub5+DnouEJMvlOhzLHpgB1d6aJEiXdBLVofhRGEr+uQikE
	VcUW/kblUCki1FkT7+SfAxSiSncTjQkct2fR85dm+nf3g3BtIwh/X+eShUNdexcZY0Y=
X-Gm-Gg: ASbGncuqG7t84OaDWIwmxnbfU3gTtScB/uBEnXEjgSW5i/GstWgaq147PSNms3xL4Ci
	kCOAlI0Tyuz4evs0cOlVXqzFn4a9VHR1Jcw95M4BnxmXJ2tAo9HGg3KrUzegN5Sx/RSOGFOeWjH
	NI2XjgNvZle/1nS+qcT7orQdzgPX6g7iGENKt9Cwa8mY+nWA9OL7HluYCMRUr/x1LogqizH2crB
	SWeZhVCFbHteZv+MGNFJ8rLfojEoLVzyjyxzzPv0cSbbflrpw0XTmyOfugEvoG71Fw1NPlnHUAM
	nN9GoOKwl2Z17uS9/O33LMKTkNUw7Qvo+4ATbV5WPI4Rw5JwzeRobigaDOoGgsK1lB4CzxsUQAe
	RfZNJM8gcpOLZ7WeKgiSglU3u1zmUfl3sY2vAdgHSFBWwmJlaSBKWEX3Z5gIxH0h3ngEl+5RHRO
	n5vsZPu574RgPP
X-Google-Smtp-Source: AGHT+IGm3Wa56XUydCTKudmGMentGaT4iUui9wuImfhosfZAtqWdEBdlJW8tn8ToaWyI3p+ndFALWA==
X-Received: by 2002:a17:907:3e0b:b0:b70:b3cb:3b30 with SMTP id a640c23a62f3a-b726567fa67mr356526566b.59.1762361300655;
        Wed, 05 Nov 2025 08:48:20 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893cbc72sm3380366b.29.2025.11.05.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:48:20 -0800 (PST)
Date: Wed, 5 Nov 2025 19:48:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Phil Elwell <phil@raspberrypi.com>
Cc: oe-kbuild@lists.linux.dev, Jai Luthra <jai.luthra@ideasonboard.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Umang Jain <uajain@igalia.com>
Subject: Re: [PATCH v3 6/7] platform/raspberrypi: Destage VCHIQ interface
Message-ID: <99c95bb6-6595-4b68-afa7-1614f619a20f@suswa.mountain>
References: <20251029-vchiq-destage-v3-6-da8d6c83c2c5@ideasonboard.com>
 <f11dd2de-d8fd-4d8f-ba29-6974ba923b4e@suswa.mountain>
 <CAMEGJJ1Rsjsa9CGB4Hv6ukf=xi41TTDRNf7nkrX4nQniEp+8zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMEGJJ1Rsjsa9CGB4Hv6ukf=xi41TTDRNf7nkrX4nQniEp+8zw@mail.gmail.com>

On Wed, Nov 05, 2025 at 03:17:01PM +0000, Phil Elwell wrote:
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  583  static long
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  584  vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  585  {
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  586   struct vchiq_instance *instance = file->private_data;
> > 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Umang Jain       2022-12-23  587   int status = 0;
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  588   struct vchiq_service *service = NULL;
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  589   long ret = 0;
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  590   int i, rc;
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  591
> > 96622d58f50b8f drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Thomas Weißschuh 2025-03-11  592   dev_dbg(instance->state->dev, "arm: instance %p, cmd %s, arg %lx\n", instance,
> > 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Gaston Gonzalez  2021-09-12  593           ((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  594           ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  595
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  596   switch (cmd) {
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  597   case VCHIQ_IOC_SHUTDOWN:
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  598           if (!instance->connected)
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  599                   break;
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  600
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21  601           /* Remove all services */
> > f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c Ojaswin Mujoo    2021-07-21 @602           i = 0;
> >
> > i is not used any more.  Delete.
> 
> No, don't do that. It's passed as an in/out parameter to
> next_service_by_instance - it maintains the iterator position. This is
> a false positive.
> 

Uh...  Crud.  You're right.

I knew this check was generating false positives but I try to filter it
manually.  Which is lazy.  I will fix this false positive.

regards,
dan carpenter


