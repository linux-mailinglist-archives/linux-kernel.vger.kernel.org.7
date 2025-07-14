Return-Path: <linux-kernel+bounces-730251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A462B041DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7793B2396
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54525A341;
	Mon, 14 Jul 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K39ZGBs3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C225484B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503810; cv=none; b=cZcw9akM7WdnFvohflkUvNNRP9mCjU5S+yZjLrl6h94AKiyp5H9W+dkYV4hsLVDqq74EHN5HDtUCYHJE4xa2hT9qsKPMuYOk0oC3+B7PXS90QOh+2iSg0vrVMTztS/scK0UoIK/fIignL6mMcQLZZ9TD9LUD1j6ijF5p6QXM55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503810; c=relaxed/simple;
	bh=VuqqMa72HKsGgw63UuN5cHyjaBeUWVPHJvFJII6coOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBlEgsnbVPkGDGWf8TPmQwI19ZC2UhFd41+cTsCvgoZkVmLkBTTClh0e+YPdpXPgOMyqSae6NEdgkjMB/OPyYi4nsfP8eVCWDa5mrjd23+XLAqPYS4PKAnVFL3lpkKuFFJdLYK30Rp+Dm91AbZqQYg7KMnUwMefHkKFKtO0qWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K39ZGBs3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stVCHu6LKp83uxTYBPZjVntnTY6VyQOczeCpnXoPZFg=;
	b=K39ZGBs3DW7er8HSJWu7e6MYjVBVE5qEDjqf0QXV/BeO2f4w/aay76F2hvF2V6u2AYOfo/
	UDjTOD1Vt8uKewCudDKb6S7AXu1IN5Ss924mVTSTNkxPM3jkOy670TKYWwBq0ka9/7jd+j
	vjnhfoR4s6weHdGSJ92/2IQ/D4JiaII=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-youde3NdPlOGC7cUj4i8Dg-1; Mon, 14 Jul 2025 10:36:45 -0400
X-MC-Unique: youde3NdPlOGC7cUj4i8Dg-1
X-Mimecast-MFC-AGG-ID: youde3NdPlOGC7cUj4i8Dg_1752503804
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0b629918eso400848166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503804; x=1753108604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stVCHu6LKp83uxTYBPZjVntnTY6VyQOczeCpnXoPZFg=;
        b=NxqrNJkVdxRfwaXAxyx7UotM3Rywri3GC9E86D70O44HAPuVuJrbWtSzJRgwDrX+7/
         qe7EIcZoj18CHJcJn6WrRAr/V1kVyRyVUJp0B9q82uWo2ZMGUe3a4SvlVlTUil7s7WuJ
         NMdXO8hTMWevc2GQ0sUXsOpdspnqgrAHWgLw5q7Gg5dPsDwzy/nebeA4A8weLfso5dMF
         yFtFCi6enTK7Pdm5uJovrBP4/Bg1lACtpvepg3LGa7Wz0qNfSUgrYsTar2kkVuU/4ZZx
         w/hHAQkIkk2g9qbbx9Fz4QdptN8dYnrcJ8YTc99sdmoSHRFihRwuAQNOren8hEdbFYX9
         M/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Uh9H+ASI8FSeOuh2APM7emg3hw92cDCuMVx8Wx5FcbEuRB4zdFzJ7lCkPS0fzbpW1eLeOgThA0n+r7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhPu0cRG9pqze9PbBrUqb8cKF5DeTmmNH1iZy1eH8alk2GHZG
	dYhnnCPF3kqzsESH/HMqFeHFdyUzbxz7qn5XfPrSvdMiQ54ODYF7Sa6/YBn5/riKPw7VwdKlup4
	63ShF3cHnVljaJsRUIahvENid5LKNhgG5H7en0prqZICFplx/I982hFhn30NxJKq1sA==
X-Gm-Gg: ASbGncu6wcs9yZGa54mA04b1FWvOQ1nvhbwwx19XzL1l7Ab9u2WU84EF1sDxbr2iVTV
	VKk8wAL+42UTftrUZZg2V8RYS/jdVe6lQuKialJWuC/PSy7LJ9IKO0X4Cg9Nl25lXRZwIVvhc33
	iwmlaR8GDm/WpBuw53mQLFPekRtfQaeNh00ves3cqTCLXp65vXVFzDEFqdGoEjdwqfpizYK5WzY
	H3ILaupq3ZhOfjNTJIn7sFv6qdMVvaSujUN//Ida10oBP9rRkrBCtyuah4349C2LaZGemCGniYH
	DhPB3n8Ojb7RaGANL5x5CuEjT9o68e4yfITgmM7JYJyo
X-Received: by 2002:a17:907:8689:b0:ae4:85d:76fc with SMTP id a640c23a62f3a-ae6fcbc35bfmr1263813966b.30.1752503804307;
        Mon, 14 Jul 2025 07:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf9LW2oVjZhF5sLUcvf0WPEAbAeIZPxgH40L/19uJOl41oKRe5Iyk5Y7lPc7HLnpXjTK6irQ==
X-Received: by 2002:a17:907:8689:b0:ae4:85d:76fc with SMTP id a640c23a62f3a-ae6fcbc35bfmr1263810666b.30.1752503803914;
        Mon, 14 Jul 2025 07:36:43 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee47a2sm842823166b.58.2025.07.14.07.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:36:43 -0700 (PDT)
Message-ID: <71d9aa58-e166-419b-9d32-839f5c4ad62c@redhat.com>
Date: Mon, 14 Jul 2025 16:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] media: uvcvideo: Add support for
 V4L2_CID_CAMERA_ORIENTATION
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-8-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250605-uvc-orientation-v2-8-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Jun-25 19:53, Ricardo Ribalda wrote:
> Fetch the orientation from the fwnode and map it into a control.
> 
> The uvc driver does not use the media controller, so we need to create a
> virtual entity, like we previously did with the external gpio.
> 
> We do not re-purpose the external gpio entity because its is planned to
> remove it.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

...

Taking a second look at this I noticed the following:

> @@ -1869,11 +1869,15 @@ static int uvc_scan_device(struct uvc_device *dev)
>  		return -1;
>  	}
>  
> -	/* Add GPIO entity to the first chain. */
> -	if (dev->gpio_unit) {
> +	/* Add virtual entities to the first chain. */
> +	if (dev->gpio_unit || dev->swentity_unit) {
>  		chain = list_first_entry(&dev->chains,
>  					 struct uvc_video_chain, list);
> -		list_add_tail(&dev->gpio_unit->chain, &chain->entities);
> +		if (dev->gpio_unit)
> +			list_add_tail(&dev->gpio_unit->chain, &chain->entities);
> +		if (dev->swentity_unit)
> +			list_add_tail(&dev->swentity_unit->chain,
> +				      &chain->entities);
>  	}
>  
>  	return 0;

The double checking of if (dev->gpio_unit) / if (dev->swentity_unit) looks
unnecessary here list_first_entry() is pretty cheap and this only runs
once at probe() time. So maybe:

	/* Add virtual entities to the first chain. */
	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);

	if (dev->gpio_unit)
		list_add_tail(&dev->gpio_unit->chain, &chain->entities);

	if (dev->swentity_unit)
		list_add_tail(&dev->swentity_unit->chain, &chain->entities);

?

...

Regards,

Hans


