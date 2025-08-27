Return-Path: <linux-kernel+bounces-787955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58906B37E09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F69C1BA3FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDA33EAF2;
	Wed, 27 Aug 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eEc25c3x"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCB2F1FE7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284142; cv=none; b=BFtyjMSY8Mwb9qYAniUhIo0UtGoiXmxxSSmFnslXuzVV+o/XAo4OAlOnecjsjEVDvDpKXQhONBHtH1LqIGIyM2bi0D1zIyn8c8dQ7oQaaIrK0TPTZQGCY62swmYzwGwNxlX6S0R82fDZSIYoIMbuvVi3Gj6dxpwG2f5Qba24SLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284142; c=relaxed/simple;
	bh=C3J5F98SUq/XbJdI5mkH/BowXWLNgIYkLopDpGLXpXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VLANtwyjcDy2x45EzxviIcw5OuajuxFpladUewa/yCRZdc9jWUCAy2/hM8rPjAMt2iLDXv3Z5Ctn5n+XH8b9HjqnNfhkIKKjjDFTYSypmrljo672TMV/HzwriHXKvN2U5SE51l70psz5W6u0Nqms4wpZYmzyAlCuLiQOoBR8SV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eEc25c3x; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso7077638a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1756284138; x=1756888938; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru399StOWX0y3ow8u4rjjmb8WPAPqnIEt4F7fasIcxE=;
        b=eEc25c3x5PXcT1AHnb/dd/pK0kjfUbP9sm+mbeau8SUzBSmQAFsDjgICcXFHWkCasF
         CEJRrex62BkT3As7pW65RpznQk6trJexK/QcyJPPoaxomyHKKkjI/PNbOVGnmpfIb8BH
         auofQ2V/WJi55gqWSb06bITRix7V0pbcrxchJES+jYAlAMh7kqyspAC73bam1RKcYucG
         w2IoXhXz6KB27jTSfHXmQjFsBR7lfDjWp+Rgr3EPkrPa1QzLnoYo0DRGdV1Pke367wS9
         VYUFYGGOudjo4onhgVI1wDgcO3esXjZMRoVbSaszfYkj2zM+nQvbOdgN2nGDIl0cavoK
         KEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756284138; x=1756888938;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ru399StOWX0y3ow8u4rjjmb8WPAPqnIEt4F7fasIcxE=;
        b=jGZblgwyRFIBstwKEpUXGRsy2vq2ZrU2BCHrnZtyglwDo/+sh7pH7CYGz3EhmYhANu
         z06IBOtJY+Eg32RW8wzNXFMIfaN39CZXgsP4Sb3VwyUg6c20iN8pjGrLfZMlvRvpoDQY
         0ZMnSWAzbkZAVdmPjNM/Q3nxSXEBdofMgDUMxLwQEDh/2sbGVyuI5cNgcvvZdbXaeSI/
         HxzNADG0QBnhT/1gL/AHu/qhUyHPABSNI3Yt2qoFrVW4NAJcFtz9NkaaI/Ulg3A6YVsJ
         TpmnE4/U3+sgZtvCWwjnbATiuiXDxIXWeXcUa3DxLq+IKLY75Yg6JXyxcGNGuRC5jP7M
         o1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUsgI8havoFhRQsXwxSl2RIxttxz3Y1SKJ3x5snbpWiElLK1I4Hk84Jla0nwbUALm7miMdBR93S0+qMpJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyNiiyh9pvo1omJeSJBXVpUmAtzh4YwpjNVdMZhObRQxJihjT
	jJxM0gCkkl47TpkTbtjDdmvergfSO1x8MwNMlyQsFVF/mEpRbLctwktsZ5eGpF3oVB4=
X-Gm-Gg: ASbGnctlmJIMxbOOH8SYUMy+6tdTtcZ1wgEvfWukCUUtuE+kgeI97OijC3VlrWQuO8G
	2Hj6Ojc8m7MRDIfs/qXOK0JQAD/3uHUeqN7ZMW10s8zyifm53RIwB02uDPJJouOgqXbetKVXx0Z
	wu8Irg2S2jO1ToMR2xWrjcThMQ8DBrQ8/GdAT4i3FwF/pJqjgvk6a0/0JFrlZSfAkVeybNex7Q3
	712nPwwlBn70Ud0G19zoVv9EDxsiYcJ6Y1mX0BAoxj1NVOukiUX0jCELtbiIxcHGDucXp7YD9mW
	vxuN200ixH72ipUD4Tbvw8i9UdMHVsLOdZ42arqHOHaIK45LV10YSmFGSaF1FwJpd8EUaMYSXkY
	bmYl0ShX1EI7tgOmgh0TepMPFYpzV39hT5u2wgWAoLtb4NBQnrrbJHiHM4hY=
X-Google-Smtp-Source: AGHT+IE7qHCUmyrseOQu74QlBZCIEPNa9QZI/28Loh0vgbPoaePjhaimKbaEW3VRUGcYdoYW86lRtw==
X-Received: by 2002:a05:6402:2554:b0:61c:5d76:3a8b with SMTP id 4fb4d7f45d1cf-61c5d7640b7mr8937360a12.32.1756284137573;
        Wed, 27 Aug 2025 01:42:17 -0700 (PDT)
Received: from localhost ([213.244.170.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61caeb5e77bsm1411780a12.35.2025.08.27.01.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 01:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 10:42:16 +0200
Message-Id: <DCD2RLZO62P6.MNAOWRUWVFHK@fairphone.com>
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Hans de Goede"
 <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
 <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
 <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>

Hi Javier,

On Fri Jul 11, 2025 at 11:21 AM CEST, Javier Martinez Canillas wrote:
> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>
> Hello Luca,
>
>> Hi Javier,
>>
>> On Fri Jun 27, 2025 at 9:51 AM CEST, Javier Martinez Canillas wrote:
>
> [...]
>
>>>> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
>>>> +{
>>>> +	struct device *dev =3D sdev->sysfb.dev.dev;
>>>> +	int ret, count, i;
>>>> +
>>>> +	count =3D of_count_phandle_with_args(dev->of_node, "interconnects",
>>>> +							 "#interconnect-cells");
>>>> +	if (count < 0)
>>>> +		return 0;
>>>> +
>
> You are already checking here the number of interconnects phandlers. IIUC
> this should return -ENOENT if there's no "interconects" property and your
> logic returns success in that case.

We shouldn't error out in case there's no interconnects defined for this
simple-framebuffer though? That'd break all other usages of it?

>
> [...]
>
>>>
>>> You could use dev_err_probe() instead that already handles the -EPROBE_=
DEFER
>>> case and also will get this message in the /sys/kernel/debug/devices_de=
ferred
>>> debugfs entry, as the reason why the probe deferral happened.
>>
>> Not quite sure how to implement dev_err_probe, but I think this should
>> be quite okay?
>>
>
> And of_icc_get_by_index() should only return NULL if CONFIG_INTERCONNECT
> is disabled but you have ifdef guards already for this so it should not
> happen.
>
>> 		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
>
> Then here you could just do a IS_ERR() check and not care about being NUL=
L.

But checking also for NULL shouldn't hurt either, in case the compile
guards get removed in the future or something?

Quote:
> * Return: icc_path pointer on success or ERR_PTR() on error. NULL is retu=
rned
> * when the API is disabled or the "interconnects" DT property is missing.



>
>> 			ret =3D dev_err_probe(dev, PTR_ERR(sdev->icc_paths[i]),
>> 				      "failed to get interconnect path %u\n", i);
>> 			if (ret =3D=3D -EPROBE_DEFER)
>> 				goto err;
>
> Why you only want to put the icc_paths get for the probe deferral case? I
> think that you want to do it for any error?

This is the same logic as e.g. for the regulator code in simpledrm. The
idea seems to be that in case some regulator (or here interconnect)
doesn't probe correctly, we still try anyways. Just for EPROBE_DEFER we
defer and wait until the supplier is available.

So defer -> defer simpledrm probe
So error -> ignore error and continue probe

>
>> 			continue;
>
> I'm not sure why you need this?

For the above behavior.

I guess there were some original design decisions behind handling it
this way, so I don't see a reason to handle it differently for
interconnects.

>
>> 		}
>>
>> That would still keep the current behavior for defer vs permanent error
>> while printing when necessary and having it for devices_deferred for the
>> defer case.
>>
>
> As mentioned I still don't understand why you want the error path to only
> be called for probe deferral. I would had thought that any failure to get
> an interconnect would led to an error and cleanup.

See above.

Regards
Luca

>
>> Not sure what the difference between drm_err and dev_err are, but I
>> trust you on that.
>>
>
> The drm_err() adds DRM specific info but IMO the dev_err_probe() is bette=
r
> to avoid printing errors in case of probe deferral and also to have it in
> the devices_deferred debugfs entry.


