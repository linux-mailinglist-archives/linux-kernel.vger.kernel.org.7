Return-Path: <linux-kernel+bounces-727274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF79B01783
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ECC1C2701A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B792279910;
	Fri, 11 Jul 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS2N7LnD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE3279903
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225701; cv=none; b=V8a4WAzlMSgrk4xbUJMI6uo3MeARTQdNJhqX4V06YDRL2UJLq51vJ1WuDmAghgkq6EiirEbLcxjnuWJiFcaxuoTOFfCerZr1wUh2P3ayM/fY95sfbfTCUr1uAb8gtTI+g00tHqNB9lWisZb8PQrNXyGggdS9KroWZ3iKYuONstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225701; c=relaxed/simple;
	bh=J1+gY7OYN0kPR3TnuQRjcQzBegXWzAAyK2wtVtceRZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QuELGE0EZd73D8VtF/cwiYidPnhB9Zc0d35QdQuJcxXw040i87P/sTu790qibgR+7kUyTajyTazrvyuv2b8/dmvhzsznPHLYlhkTt10EBJMCqUSvauiSyUgH6xCBxlLpXG+3QKwH2J7tqh9C0MXpCiZxd+/Pfx9pHB5ACan6jU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS2N7LnD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752225695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0JDyIunfR5DTlK8KTu+Yf5amiLX77lLqYYzQS582qg=;
	b=BS2N7LnDhASZgSnr7mMYdwEs2oOI83ZHrCJsdOZkN0EXSX4MUfwtZ2lj1AUtPBDBy97yzl
	ojgyKiFYaApT4Bi0C5pIU9mmoOb83MOG+NLN9Y/lf7z9IoI2wVs9RlCNzbK19XNff8jpKP
	rAe1QX2AgwwoQ6j/ug0csQtKt3362RE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-WQ0h60lgMBWT3U68MOXloQ-1; Fri, 11 Jul 2025 05:21:31 -0400
X-MC-Unique: WQ0h60lgMBWT3U68MOXloQ-1
X-Mimecast-MFC-AGG-ID: WQ0h60lgMBWT3U68MOXloQ_1752225691
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455eda09c57so1282625e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752225690; x=1752830490;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0JDyIunfR5DTlK8KTu+Yf5amiLX77lLqYYzQS582qg=;
        b=f0h4c0NS/zCYYcV5Mn9Q7qFTXIVFDOoTMsh+Y55UlekilKTY2NpGg0X6ZeZPjxb+44
         dog/PE7wD2t+iazHliYhd7rg3WiSrwmRzdDpxdeq8GBKvP3FQeinHUOfZrBv4wb3iICO
         aNcWyyPq+GbGzo6EYz4JnfxH8fEPgbaB3/4zPn4Vn2Ihg3GioAv2FsX/dLWcMCwXJ9S6
         KOcrJIpIbDpSXphUgVwYeZ817nCKYwaV91hUul1v9b6sLQGjY021z0UwOSw3yqMvst1o
         vvCoTS1o3MFtdIWGFG1e1QGG4n/ZrkSG+bYGVbTqe56AG93DBjXtNChu2VM4hUcQqe4Z
         Dd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrB/4MMhdQJMffUvH+SkSlrEJqJszOQ18jUOzSrqHdIYCZ9x/ZXIBvj4fVOqe+edcJDMzXrCb9DJOgR2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfHWKOrhPc6IclGGSXzRdX3I8gFzoidwMtvJjPNFnDtfZQU1O
	geHL6MJwqtJ2y1dhfM0qMUCNHQna2+8eo+qTHsPtkGwDlwzuAIV8V3Z4WKJmahq6PtUuJwherGe
	tWsDqOiK8QJnqkI5kEdCgm8YV9ImVVhUGf942EOY++Z0IGQb1JVe/CbiI5gZeMCRUCQ==
X-Gm-Gg: ASbGnctvscBrPLWHTl6ur6jpS2bs8htWz+/UHczh3MXAIgWFjzFPO0fO+JMy8/kTyeJ
	DqtzyiMpoxHmiBT2WUNt9v325F+7ITogevSdhC7U5STJbAycTnVozjatrDdp6aCkRIfcFqLr4Mp
	j4iTzCARP5WCsTxn09KhUdYcNH3/Oic83B7S6mH2XMf/jxmoAl85zavJjwwjv2i4PZtyOw36bSN
	lvEgSQlXL8pUQxaPnY3sK9B0hqTPx+jt44I79MfMiJ1B0aK5yZCLPexLOW7GzCZZdrcH6T/475r
	VInMMAqeg7npojPLqxNETTPj1aXYCDFidIP/vSxaQYD0MF5dgr8Uqn51yPT126hsMUUJOknnm79
	SbWyU/RPiVdn+MTCWByFKgQ==
X-Received: by 2002:a05:600c:4fc7:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454ec14848amr22904665e9.14.1752225690315;
        Fri, 11 Jul 2025 02:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopr/bZIg6PNEafq2nN27RiUQenQ7qTkGeKlIozsRqo7Tj0VZVvTn0sX8s4NUjyeT3MpW78Q==
X-Received: by 2002:a05:600c:4fc7:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454ec14848amr22904355e9.14.1752225689892;
        Fri, 11 Jul 2025 02:21:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537d12sm41439605e9.24.2025.07.11.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:21:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
In-Reply-To: <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
 <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
Date: Fri, 11 Jul 2025 11:21:28 +0200
Message-ID: <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Luca Weiss" <luca.weiss@fairphone.com> writes:

Hello Luca,

> Hi Javier,
>
> On Fri Jun 27, 2025 at 9:51 AM CEST, Javier Martinez Canillas wrote:

[...]

>>> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
>>> +{
>>> +	struct device *dev = sdev->sysfb.dev.dev;
>>> +	int ret, count, i;
>>> +
>>> +	count = of_count_phandle_with_args(dev->of_node, "interconnects",
>>> +							 "#interconnect-cells");
>>> +	if (count < 0)
>>> +		return 0;
>>> +

You are already checking here the number of interconnects phandlers. IIUC
this should return -ENOENT if there's no "interconects" property and your
logic returns success in that case.

[...]

>>
>> You could use dev_err_probe() instead that already handles the -EPROBE_DEFER
>> case and also will get this message in the /sys/kernel/debug/devices_deferred
>> debugfs entry, as the reason why the probe deferral happened.
>
> Not quite sure how to implement dev_err_probe, but I think this should
> be quite okay?
>

And of_icc_get_by_index() should only return NULL if CONFIG_INTERCONNECT
is disabled but you have ifdef guards already for this so it should not
happen.

> 		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {

Then here you could just do a IS_ERR() check and not care about being NULL.

> 			ret = dev_err_probe(dev, PTR_ERR(sdev->icc_paths[i]),
> 				      "failed to get interconnect path %u\n", i);
> 			if (ret == -EPROBE_DEFER)
> 				goto err;

Why you only want to put the icc_paths get for the probe deferral case? I
think that you want to do it for any error?

> 			continue;

I'm not sure why you need this?

> 		}
>
> That would still keep the current behavior for defer vs permanent error
> while printing when necessary and having it for devices_deferred for the
> defer case.
>

As mentioned I still don't understand why you want the error path to only
be called for probe deferral. I would had thought that any failure to get
an interconnect would led to an error and cleanup.

> Not sure what the difference between drm_err and dev_err are, but I
> trust you on that.
>

The drm_err() adds DRM specific info but IMO the dev_err_probe() is better
to avoid printing errors in case of probe deferral and also to have it in
the devices_deferred debugfs entry.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


