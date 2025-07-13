Return-Path: <linux-kernel+bounces-729132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E4B0322D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64303BBE41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9E27F183;
	Sun, 13 Jul 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0uB1+QYA"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3654277CBC
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752425284; cv=none; b=SABNYt2mDJ6pWsqjclYiBtmLmFDRLpKTmdiCzjoOPLcAW6qGYvVhn595p3/yZveeYe4BQJNM+Irr8ygi86ZPnw8eK6zaUimotwwKqB4d2LdB8rA14HO8WodvQ1B/smbYwKyWj198s1nDnq4XN3clkQWLZys86MKN6U1OMhs0Zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752425284; c=relaxed/simple;
	bh=hsuDJM5tBq44M2esEaL9NRh8SegTJ0ljozMuP/n6p64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDXioCF/5M+iOBNV0CDLJdim+hZnS75xIK0pLYppoPr947EgeIFBdPT2Lsg+lmGyCedGVfnKwioXekfYPiKmopFd0n9MuBCqyOvgaeQuqY/fLtyJ90oA+WHr6dgfxXb6ar4KIutQjvWuUwGxOYhNtUuU4J34LK71s4oOMVM9q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0uB1+QYA; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so2032881fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752425280; x=1753030080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klnDILl9DT7/vAgjp7ff2b8q2Ve50T0qs6l0XcJXQPk=;
        b=0uB1+QYA2otgjMkoP4ZE+b12bsxpgbjhdq8CNrCyfJBMXPGjZ43brpG9HMyXVfodz4
         uYDOco2v2ZktlQGP+CJ/8YFnxO9TdzJxRDDUnrVsjHno1dAikw3jrUyajTt0ztlkD7Lk
         AGhzGY8IDG9BrVWiiwER7iudgHaNkQEOc30YIDhIUf0E54oNY+F8n0k1CmPHTotDAEVI
         V4cxUc9Lep7o2KWi7Oy/eqmBsjR8oBe1tOUyevgeYTD8DQ0vUCux9z4NXsIG96+F0Icl
         QEAUrYFGVGvNu4zPDIFoPn67HYapWGQ4wdwlDeszP96zANyLNg6pB0ayfxiriYzGAtk5
         YHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752425280; x=1753030080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klnDILl9DT7/vAgjp7ff2b8q2Ve50T0qs6l0XcJXQPk=;
        b=g2aK5FrB7wckzIVTaSouCCwREg1v0S98KU6uy1HjwfUKRcNu60i5C2WK6ZLsYcuLsd
         m48rhkca+T+FWbd6QMWOBkHJMcanQP8EbHgXNZBqfSruCN0FwY5Zh3pOuL+yD8DuZUIs
         QNSa/wpcXVbmJ+Drtv8vPMTmEjoqZcNt94dGkQi0YL1z8IUV5rQaIoRwWWnexdJ1Px3M
         oYOF8SOSktVP7WfqEBi8f1nBme1fg1e704gyVazxpnueiPE9tcEIBJ0eVFguIYCFPBiK
         RYI9PvW24cAyRfQzHEeTriAGJ7gY2Shcep2nWtt7EB+5iECBkTT33yQFSmH85AzoIWaD
         hBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWxDN/N259RoHP2rMLpQhh1wkr1NyWmHQPHLxXOqXF7zy7KB7CpsF4Tp/gUMpmFwiGpIUJ9ooKpasgOTNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0cFEEOmbkPVmC3EcnSOPPebipsBUH0CwESTwC9jGUz4Bwi5o
	NudyP6Kskfzm+br+F7DHaJiT5gHw5uIQTR2kJaKmShEEKrp/ti0u8Ax+zgosZYnbbdw=
X-Gm-Gg: ASbGncuM1iMufP8yoiG4xgj1Gu86LIgOMYz/lT3CMHJH6eE4k6DYZ1ONiOQYH/RfYeb
	ymHd1r5Z7BVVQRd4keCC2kkix7Xp3ShmjC6UJAIsJQQOW0U0gw2vMkwpS57nVR7lqTI+zSg98T4
	R0P97QzEAq1++i+dAsIahloPv2n5xKEpFIWc/dfUAA06U3pONyQhxJxS+oh2YTlcswLFvaMMKoA
	OiqQR3CZTix8admU/4E9JLm+aO9SPMNPivDsXHi8u9u883KMhnJhoUZqrQza+LpuxxElkXL/GI/
	Nl8gxccG5IbS4EFbsu/YKoGVOdg8Bycmbsno0/v+8FNGuVZnGCR2HcpDycsntTOpk7+zpW3etmT
	YoJ8Elr7ayGXAo0wznRwimuBWEGTujbGrKb1CsZPSoNmR0M+PltJdE7DRBJGootrhMmgPzF+87q
	I=
X-Google-Smtp-Source: AGHT+IG9yienyT+BvCs8+5XA27Ba/F/vOq78ZUDrFUpnAOK0uv/NqWP6qp1ugEEG5qLSGkPO8V1v8A==
X-Received: by 2002:a05:6871:2998:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2ff269770e4mr7470930fac.30.1752425279898;
        Sun, 13 Jul 2025 09:47:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9? ([2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11259495sm1598691fac.17.2025.07.13.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 09:47:58 -0700 (PDT)
Message-ID: <c4d143f1-0649-4f64-ac71-419a4b2b0fca@baylibre.com>
Date: Sun, 13 Jul 2025 11:47:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
 <aHE-8VDgQ7WuoA_y@smile.fi.intel.com> <20250713145533.5a3d4336@jic23-huawei>
 <20250713145810.31853bc7@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250713145810.31853bc7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 8:58 AM, Jonathan Cameron wrote:
> On Sun, 13 Jul 2025 14:55:33 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Fri, 11 Jul 2025 19:42:25 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> On Fri, Jul 11, 2025 at 10:47:57AM -0500, David Lechner wrote:  
>>>> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
>>>> in sx9500_trigger_handler(). Since the scan buffer isn't used outside
>>>> of this function, it doesn't need to be in struct sx9500_data.
>>>>
>>>> By always allocating enough space for the maximum number of channels,
>>>> we can avoid having to reallocate the buffer each time buffered reads
>>>> are enabled.    
>>>
>>> Ag ood one!
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>   
>>
>> Applied.
>>
> 
> Actually on second thoughts - why not a more descriptive structure?
> There are only a max of 4 channels and so the timestamp is always
> in the same location.
> 
> Dropped for now.
> 
> Jonathan

I didn't do that on this one since a variable number of scan
elements are used. But if you prefer structs for anything up
to 8 bytes, we can go with that.

