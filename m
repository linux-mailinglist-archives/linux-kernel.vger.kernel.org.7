Return-Path: <linux-kernel+bounces-886724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C88C36680
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF293BF789
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091793358DE;
	Wed,  5 Nov 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ITcjlvg3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1311331A78
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355839; cv=none; b=jT+wGhqCKn/hwpwqYr7/kOXfzyXTkOxOdIAGyPSS7IbNVqM6NdCxyLhOlHiEoUl3MHANTENORyOq+Br5l0XvEY6BI3/VHrszRrXpOcs8HRn4fdKopmXu3I47vpifpva6ZLjaPmhYp41tMpOZNs5ZJgvOimdU5vpOhI8cnVU7G98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355839; c=relaxed/simple;
	bh=zZzByG2QsQ86mK1EJIoxgkBQTkLUXkXInuoJel54TmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR/ylVlaaqEieVsOh4UHIa2fco5CPtfx4C9OE8MUuOYwCajXhk2xXXfuzuHROdmM/f0x793S/8NSw9WPwbmxfdtEjB9NfCKjXOvvkTPBW6aa3rKyhpCC3JU2goom8wQWs37uLsjSwEov4a/OWhqCHFKrP6ezfB5ky4p4VNQhuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ITcjlvg3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4736e043f9so310309566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762355834; x=1762960634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VMJYEHv13rgpz0q3SiXAsQqdkKrsEqxXnatakO1sW8=;
        b=ITcjlvg3sDnzk4n5LG36YsMlrm02YYHghNbZ2FtP7/j/AwkJSutQy203zRcjqMB6ue
         sf080ysE2j42+XH8GMOkFo5yZGehSkrFSggPMDnhXhj7HS4wdb6sahbYcuMkf7uBh9h6
         H0Cam4sJaJjsB0WHItm97A1+v8qEDlL9i9UStalLOUwrG9x/EhHrBLfZSQdVtVjWdbw8
         6F8gTiev9R28DsW4Y/+Ti42GxrBevhzW49VeHgiH/yFcxqT4bbBAYcAGawMoik4pOe1w
         Xsad6lDfh8kvtgBTAmArpgVmcsQqM8blwqVkZeHlWkfXqTjk7BRgwcp9/eHdrtHo5bmV
         nXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355834; x=1762960634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VMJYEHv13rgpz0q3SiXAsQqdkKrsEqxXnatakO1sW8=;
        b=srU9Dh+4wTZHujnDpwmkFP9fMJ1kH531hzHB9Q/orGY5K17vDkCx4tdp3ztLhWtpPd
         HPbnKUlVC+c7IWUNjOoGcMyRi1OsLILKNc4crkZSogW1gcvkyJHJqnhlNVwG1/pynwL4
         nr0eFWa+8Zjh00wKAxqT4iomnjDf0ybb7M8QiW0C6jlUxtw+luilUYYGaEwAGFjAQanS
         3g1yY93ogRYK7qTuKbBD2vaiwYobAzankBTwxvulXF5KjquUeggefgN1goNPi9tJs4Wd
         /8pe+ONUObIlTvOaTwhHrjSGpzrBJCHyIr09aJ0H+tuD7yRGYDDQbdnv5ViakQxm4Nbl
         ajGA==
X-Forwarded-Encrypted: i=1; AJvYcCW0JUAc6GNYKnXUuVBhJRKiMQnTpg1w4apWURY5CDh280BxnZbfoDjJio22f6ljbcPqP4+lBY/L9jJtx1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C1aGXPBlrVeWsojwJF1J/MSUB4svIvLwyT/x24a2qs1GWUME
	G8KhlkbdCR+8VXcQ/GhDdJae5kzfer2DZwiEysBIL400FYNN6rjEmCh6fSkc0Kr6d4/vezKTsMv
	GL4PRYE+ZNPmZ+3Skb6rhMbx24X04Nwq7iMinWyCdkQ==
X-Gm-Gg: ASbGncujm5+2PZEp3UNrFp/6VCIX/BwVOttAJqm5XrSV6/vTOCF12q8P1oNXl0Xl88S
	CJQ3yEjllqq3jIQevYok80Xte39AqC7uVVOX5ABGmfAo0VyWGErWO9e98l1qHGFSm9D1qSPphxJ
	RotDfzUDdQAbPAVgRUUytMJWu+NgHlAXyg6pSa6ex/XUXECj32Vm7lZWPTqJ70o8DU1haZYRmU0
	1bkU0kIFgJUZSEQAW2NHCWvMByWZjhcxoZxZJq0IQ3QtyPwMZIvJfT7vhyAJU+GdRNZ0oYODaNR
	WhBxjdIeDW0gTlA=
X-Google-Smtp-Source: AGHT+IHWWILPTh6wQLo7BhIyqMWdWcigBfh5bW5d6mXT0L3VqgnnKMCEBmPzvCQne0H9XOH5eLXUyGNFvai/MaYUBnw=
X-Received: by 2002:a17:906:b10a:b0:b72:6935:6bac with SMTP id
 a640c23a62f3a-b72693594ffmr212362966b.49.1762355833625; Wed, 05 Nov 2025
 07:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-vchiq-destage-v3-6-da8d6c83c2c5@ideasonboard.com> <f11dd2de-d8fd-4d8f-ba29-6974ba923b4e@suswa.mountain>
In-Reply-To: <f11dd2de-d8fd-4d8f-ba29-6974ba923b4e@suswa.mountain>
From: Phil Elwell <phil@raspberrypi.com>
Date: Wed, 5 Nov 2025 15:17:01 +0000
X-Gm-Features: AWmQ_bnN3lXKloJO_CcCsYJ6HlRIq3eUeG-Srf-bIi6yPA9EoglO3sEKOs5JtdY
Message-ID: <CAMEGJJ1Rsjsa9CGB4Hv6ukf=xi41TTDRNf7nkrX4nQniEp+8zw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] platform/raspberrypi: Destage VCHIQ interface
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Jai Luthra <jai.luthra@ideasonboard.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Umang Jain <uajain@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, 5 Nov 2025 at 15:00, Dan Carpenter <dan.carpenter@linaro.org> wrote=
:
>
> Hi Jai,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jai-Luthra/staging=
-vc04_services-Drop-bcm2835-camera-driver/20251029-184912
> base:   dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> patch link:    https://lore.kernel.org/r/20251029-vchiq-destage-v3-6-da8d=
6c83c2c5%40ideasonboard.com
> patch subject: [PATCH v3 6/7] platform/raspberrypi: Destage VCHIQ interfa=
ce
> config: arm-randconfig-r071-20251102 (https://download.01.org/0day-ci/arc=
hive/20251103/202511031105.3z4Gf3FT-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d=
2625a438020ad35330cda29c3def102c1687b1b)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202511031105.3z4Gf3FT-lkp@intel.com/
>
> smatch warnings:
> drivers/platform/raspberrypi/vchiq-interface/vchiq_dev.c:602 vchiq_ioctl(=
) warn: iterator 'i' not incremented
> drivers/platform/raspberrypi/vchiq-interface/vchiq_dev.c:1250 vchiq_relea=
se() warn: iterator 'i' not incremented
>
> vim +/i +602 drivers/platform/raspberrypi/vchiq-interface/vchiq_dev.c
>
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  583  static long
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  584  vchiq_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  585  {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  586   struct vchiq_instance *instance =3D =
file->private_data;
> 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  587   int status =3D 0;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  588   struct vchiq_service *service =3D NU=
LL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  589   long ret =3D 0;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  590   int i, rc;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  591
> 96622d58f50b8f drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Thomas Wei=C3=9Fschuh 2025-03-11  592   dev_dbg(instance->state->dev, "=
arm: instance %p, cmd %s, arg %lx\n", instance,
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  593           ((_IOC_TYPE(cmd) =3D=3D VCHI=
Q_IOC_MAGIC) && (_IOC_NR(cmd) <=3D VCHIQ_IOC_MAX)) ?
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  594           ioctl_names[_IOC_NR(cmd)] : =
"<invalid>", arg);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  595
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  596   switch (cmd) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  597   case VCHIQ_IOC_SHUTDOWN:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  598           if (!instance->connected)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  599                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  600
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  601           /* Remove all services */
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21 @602           i =3D 0;
>
> i is not used any more.  Delete.

No, don't do that. It's passed as an in/out parameter to
next_service_by_instance - it maintains the iterator position. This is
a false positive.

>
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  603           while ((service =3D next_ser=
vice_by_instance(instance->state,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  604                                       =
               instance, &i))) {
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  605                   status =3D vchiq_rem=
ove_service(instance, service->handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  606                   vchiq_service_put(se=
rvice);
> 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  607                   if (status)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  608                           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  609           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  610           service =3D NULL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  611
> 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  612           if (!status) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  613                   /* Wake the completi=
on thread and ask it to exit */
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  614                   instance->closing =
=3D 1;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  615                   complete(&instance->=
insert_event);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  616           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  617
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  618           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  619
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  620   case VCHIQ_IOC_CONNECT:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  621           if (instance->connected) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  622                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  623                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  624           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  625           rc =3D mutex_lock_killable(&=
instance->state->mutex);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  626           if (rc) {
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  627                   dev_err(instance->st=
ate->dev,
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  628                           "arm: vchiq:=
 connect: could not lock mutex for state %d: %d\n",
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  629                           instance->st=
ate->id, rc);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  630                   ret =3D -EINTR;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  631                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  632           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  633           status =3D vchiq_connect_int=
ernal(instance->state, instance);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  634           mutex_unlock(&instance->stat=
e->mutex);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  635
> 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  636           if (!status)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  637                   instance->connected =
=3D 1;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  638           else
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  639                   dev_err(instance->st=
ate->dev,
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  640                           "arm: vchiq:=
 could not connect: %d\n", status);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  641           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  642
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  643   case VCHIQ_IOC_CREATE_SERVICE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  644           struct vchiq_create_service =
__user *argp;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  645           struct vchiq_create_service =
args;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  646
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  647           argp =3D (void __user *)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  648           if (copy_from_user(&args, ar=
gp, sizeof(args))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  649                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  650                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  651           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  652
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  653           ret =3D vchiq_ioc_create_ser=
vice(instance, &args);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  654           if (ret < 0)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  655                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  656
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  657           if (put_user(args.handle, &a=
rgp->handle)) {
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  658                   vchiq_remove_service=
(instance, args.handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  659                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  660           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  661   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  662
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  663   case VCHIQ_IOC_CLOSE_SERVICE:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  664   case VCHIQ_IOC_REMOVE_SERVICE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  665           unsigned int handle =3D (uns=
igned int)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  666           struct user_service *user_se=
rvice;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  667
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  668           service =3D find_service_for=
_instance(instance, handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  669           if (!service) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  670                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  671                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  672           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  673
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  674           user_service =3D service->ba=
se.userdata;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  675
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  676           /*
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  677            * close_pending is false on=
 first entry, and when the
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  678            * wait in vchiq_close_servi=
ce has been interrupted.
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  679            */
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  680           if (!user_service->close_pen=
ding) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  681                   status =3D (cmd =3D=
=3D VCHIQ_IOC_CLOSE_SERVICE) ?
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  682                            vchiq_close=
_service(instance, service->handle) :
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  683                            vchiq_remov=
e_service(instance, service->handle);
> 3414994ba84042 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  684                   if (status)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  685                           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  686           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  687
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  688           /*
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  689            * close_pending is true onc=
e the underlying service
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  690            * has been closed until the=
 client library calls the
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  691            * CLOSE_DELIVERED ioctl, si=
gnalling close_event.
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  692            */
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  693           if (user_service->close_pend=
ing &&
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  694               wait_for_completion_inte=
rruptible(&user_service->close_event))
> 82a9eb4a3561e1 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  695                   status =3D -EAGAIN;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  696           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  697   }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  698
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  699   case VCHIQ_IOC_USE_SERVICE:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  700   case VCHIQ_IOC_RELEASE_SERVICE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  701           unsigned int handle =3D (uns=
igned int)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  702
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  703           service =3D find_service_for=
_instance(instance, handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  704           if (service) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  705                   ret =3D (cmd =3D=3D =
VCHIQ_IOC_USE_SERVICE) ?
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  706                           vchiq_use_se=
rvice_internal(service) :
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  707                           vchiq_releas=
e_service_internal(service);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  708                   if (ret) {
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  709                           dev_err(inst=
ance->state->dev,
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  710                                   "sus=
pend: cmd %s returned error %ld for service %p4cc:%03d\n",
> e70f17ed997cb7 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  711                                   (cmd=
 =3D=3D VCHIQ_IOC_USE_SERVICE) ?
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  712                                   "VCH=
IQ_IOC_USE_SERVICE" :
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  713                                   "VCH=
IQ_IOC_RELEASE_SERVICE",
> ae094de38e430e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-10-25  714                                   ret,=
 &service->base.fourcc,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  715                                   serv=
ice->client_id);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  716                   }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  717           } else {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  718                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  719           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  720   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  721
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  722   case VCHIQ_IOC_QUEUE_MESSAGE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  723           struct vchiq_queue_message a=
rgs;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  724
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  725           if (copy_from_user(&args, (c=
onst void __user *)arg,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  726                              sizeof(ar=
gs))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  727                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  728                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  729           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  730
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  731           service =3D find_service_for=
_instance(instance, args.handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  732
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  733           if (service && (args.count <=
=3D MAX_ELEMENTS)) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  734                   /* Copy elements int=
o kernel space */
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  735                   struct vchiq_element=
 elements[MAX_ELEMENTS];
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  736
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  737                   if (copy_from_user(e=
lements, args.elements,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  738                                      a=
rgs.count * sizeof(struct vchiq_element)) =3D=3D 0)
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  739                           ret =3D vchi=
q_ioc_queue_message(instance, args.handle, elements,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  740                                       =
                  args.count);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  741                   else
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  742                           ret =3D -EFA=
ULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  743           } else {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  744                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  745           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  746   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  747
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  748   case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  749   case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  750           struct vchiq_queue_bulk_tran=
sfer args;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  751           struct vchiq_queue_bulk_tran=
sfer __user *argp;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  752
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  753           enum vchiq_bulk_dir dir =3D
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  754                   (cmd =3D=3D VCHIQ_IO=
C_QUEUE_BULK_TRANSMIT) ?
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  755                   VCHIQ_BULK_TRANSMIT =
: VCHIQ_BULK_RECEIVE;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  756
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  757           argp =3D (void __user *)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  758           if (copy_from_user(&args, ar=
gp, sizeof(args))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  759                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  760                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  761           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  762
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  763           ret =3D vchiq_irq_queue_bulk=
_tx_rx(instance, &args,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  764                                       =
     dir, &argp->mode);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  765   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  766
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  767   case VCHIQ_IOC_AWAIT_COMPLETION: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  768           struct vchiq_await_completio=
n args;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  769           struct vchiq_await_completio=
n __user *argp;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  770
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  771           argp =3D (void __user *)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  772           if (copy_from_user(&args, ar=
gp, sizeof(args))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  773                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  774                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  775           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  776
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  777           ret =3D vchiq_ioc_await_comp=
letion(instance, &args,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  778                                       =
     &argp->msgbufcount);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  779   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  780
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  781   case VCHIQ_IOC_DEQUEUE_MESSAGE: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  782           struct vchiq_dequeue_message=
 args;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  783
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  784           if (copy_from_user(&args, (c=
onst void __user *)arg,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  785                              sizeof(ar=
gs))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  786                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  787                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  788           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  789
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  790           ret =3D vchiq_ioc_dequeue_me=
ssage(instance, &args);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  791   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  792
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  793   case VCHIQ_IOC_GET_CLIENT_ID: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  794           unsigned int handle =3D (uns=
igned int)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  795
> bad44825fbf5ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  796           ret =3D vchiq_get_client_id(=
instance, handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  797   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  798
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  799   case VCHIQ_IOC_GET_CONFIG: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  800           struct vchiq_get_config args=
;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  801           struct vchiq_config config;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  802
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  803           if (copy_from_user(&args, (c=
onst void __user *)arg,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  804                              sizeof(ar=
gs))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  805                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  806                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  807           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  808           if (args.config_size > sizeo=
f(config)) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  809                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  810                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  811           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  812
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  813           vchiq_get_config(&config);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  814           if (copy_to_user(args.pconfi=
g, &config, args.config_size)) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  815                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  816                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  817           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  818   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  819
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  820   case VCHIQ_IOC_SET_SERVICE_OPTION: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  821           struct vchiq_set_service_opt=
ion args;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  822
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  823           if (copy_from_user(&args, (c=
onst void __user *)arg,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  824                              sizeof(ar=
gs))) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  825                   ret =3D -EFAULT;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  826                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  827           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  828
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  829           service =3D find_service_for=
_instance(instance, args.handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  830           if (!service) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  831                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  832                   break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  833           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  834
> 14780bb174266e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Adrien Thierry   2022-05-18  835           ret =3D vchiq_set_service_op=
tion(instance, args.handle, args.option,
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  836                                       =
   args.value);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  837   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  838
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  839   case VCHIQ_IOC_LIB_VERSION: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  840           unsigned int lib_version =3D=
 (unsigned int)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  841
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  842           if (lib_version < VCHIQ_VERS=
ION_MIN)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  843                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  844           else if (lib_version >=3D VC=
HIQ_VERSION_CLOSE_DELIVERED)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  845                   instance->use_close_=
delivered =3D 1;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  846   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  847
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  848   case VCHIQ_IOC_CLOSE_DELIVERED: {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  849           unsigned int handle =3D (uns=
igned int)arg;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  850
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  851           service =3D find_closed_serv=
ice_for_instance(instance, handle);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  852           if (service) {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  853                   struct user_service =
*user_service =3D
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  854                           (struct user=
_service *)service->base.userdata;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  855                   close_delivered(user=
_service);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  856           } else {
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  857                   ret =3D -EINVAL;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  858           }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  859   } break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  860
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  861   default:
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  862           ret =3D -ENOTTY;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  863           break;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  864   }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  865
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  866   if (service)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  867           vchiq_service_put(service);
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  868
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  869   if (ret =3D=3D 0) {
> ab73dc85328195 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  870           if (status =3D=3D -EINVAL)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  871                   ret =3D -EIO;
> 82a9eb4a3561e1 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2022-12-23  872           else if (status =3D=3D -EAGA=
IN)
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  873                   ret =3D -EINTR;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  874   }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  875
> f67af5940d6d2e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-10-24  876   if (!status && (ret < 0) && (ret !=
=3D -EINTR) && (ret !=3D -EWOULDBLOCK)) {
> 55e23aa95b1073 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  877           dev_dbg(instance->state->dev=
,
> 96622d58f50b8f drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Thomas Wei=C3=9Fschuh 2025-03-11  878                   "arm: ioctl ins=
tance %p, cmd %s -> status %d, %ld\n",
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  879                   instance, (_IOC_NR(c=
md) <=3D VCHIQ_IOC_MAX) ?
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  880                   ioctl_names[_IOC_NR(=
cmd)] : "<invalid>", status, ret);
> f67af5940d6d2e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-10-24  881   } else {
> 078666d7ee6d3c drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-12-05  882           dev_dbg(instance->state->dev=
,
> 96622d58f50b8f drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Thomas Wei=C3=9Fschuh 2025-03-11  883                   "arm: ioctl ins=
tance %p, cmd %s -> status %d\n, %ld\n",
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  884                   instance, (_IOC_NR(c=
md) <=3D VCHIQ_IOC_MAX) ?
> 8757f705d936ad drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Gaston Gonzalez  2021-09-12  885                   ioctl_names[_IOC_NR(=
cmd)] : "<invalid>", status, ret);
> f67af5940d6d2e drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Umang Jain       2023-10-24  886   }
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  887
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  888   return ret;
> f05916281fd75d drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c Ojaswin Mujoo    2021-07-21  889  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

