Return-Path: <linux-kernel+bounces-839896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED7BB2AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72533177138
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E82C08CD;
	Thu,  2 Oct 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZrM9fHT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC92BE7BB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389506; cv=none; b=Zhav2WUzjIiwUZ/6DHLBtFrSkRhE92l8vdgi8flM9TPONWRD9gtMKsBFKOPkRjzaf/UNscTepLVM5CSQG7riaXxVKmRiwomxUd0eXEeloTNFqtAHXk4tnzuMRqfk4JayfyVB4rYBhcB+6wKIMnkkCAqbUW9TRk3Z3bvdrFsjueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389506; c=relaxed/simple;
	bh=IXj7hTXwQeyqCunCVwDQ/2Er1BA3q3NLqE9APHCkULg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGmXbK+7BJDaFJi1mkoz4T4OYLP81Josq5kTL5hkp7HJvXP4ziSYGVT7QD8nibvDBZFr3ZIGzkunizB+H6aGYecB3dFxhM/Y+6XOArxn6CAy6rSKDuMX2LrcWVg1Qv4Qrmawsasn5Y+XOkjOPhInYJhJdW2Oio5+lNzT487otBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZrM9fHT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759389503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swyZi6awnmO5RiaAnGAjYKHP2JqeK0Fm7ds6C9onHkE=;
	b=VZrM9fHT2+H/3xVgaTf7OGhBjgh4NL6eAHg35tkKSV/eUccwbG2FBnsdpBm4HSg84W0qM4
	bUb9QITWoct14x/c1RmyWjfFg6yIfkcnwpvrU13qQelqrb030elAxelQz85nbLJq+vq+/f
	8tBtxiJfRQrkLO3bdndoCtdnFT/GTpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-WigOKHuYOiCm0HPsCGtIUQ-1; Thu, 02 Oct 2025 03:18:21 -0400
X-MC-Unique: WigOKHuYOiCm0HPsCGtIUQ-1
X-Mimecast-MFC-AGG-ID: WigOKHuYOiCm0HPsCGtIUQ_1759389500
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso8449095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389500; x=1759994300;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swyZi6awnmO5RiaAnGAjYKHP2JqeK0Fm7ds6C9onHkE=;
        b=ewt4SX5IhgzwCLGUawGkRQ1MBSWkBdfRIpWbqG1gFOWddQQxDbnn7LNNvpqOJC4/lW
         H8HmFnoi+ld4G1+ii+HCv25lqm0f/shXg5ahqsKZh0QStof8c9I4Sf9wNqSRFFsjH3za
         PDBzOsfzYlc13mI+0VwlJNnPbe9QLpvY8a2FmHCKwrVLSZYyasttE1Tr3cq3+5NyR0gj
         7wLpU4kKpZo5ht1cyjRytmXT7EhBoQJwpNunT4Jvfdn6pXvJ/ZDs3KpbEidOIyQmfv16
         KA/hj6q9Gxboyz5EEQKQd1g21q8pyNIfmKX4i1cFnKVAP2iIs/6HQDvNYiNy5lwjTYq+
         +ibA==
X-Forwarded-Encrypted: i=1; AJvYcCWY9Fyrnq0L6/dmASA9wv+FMrSV6LL+p3Ao00mmqDupMgtL5Nzb5ZBYxGVnqIFHzFYuK21FV7HNLlo2bu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkNqN5GraRb4hTBPjPdBB2fxzJtA4xVysjr0GXDR5z3foCooj
	6s8yR0Ucria44fEr3J40FzcvUmbsQX4hDALfwjcXzAO8ciyxEYkCeFTjWzxM60fAH4w9y91he7Q
	D+ezOnioIBtuwI2Mvzypy4E81qtBkpHSwyByiC3znx5DETsR79pRKdjV0ikho6wM43A==
X-Gm-Gg: ASbGncvuAIbxRPDsSg5f0jUt0hE6sMoo4802f4C1QtNjQTPtb9aTWT7tMOhw7RY6KZ+
	81TqqbPSJiXhOdp5LmQM2l6IIa2SZs5puEGENmEX5YIYeeIa1zk1ZLAtYijP99ec74vAFY4E+JP
	QIPK7Vs4W+YfDA7fjpuqnZ8fkmYWSr7mwKnTwRszKfvdJmZAHUkeXyIBFlgTIVqpT8z+Pxb9PBa
	S3Aic+19xma/ydg0bn/EHfX8VzL48cIJ1cp44OKrvlixqWS+VX8PthOlcDWLADvRaiAMpyO03o5
	WOitbcf6F3K01VS9JXCqlzIpLH5agj3ADhD2qwmykw4pDgqC2Y4SmnWDrBfVt3mSnxmgsb/wDEd
	QSt9MxQeAB6o9N6Rfr/dOrUYOhNg7
X-Received: by 2002:a05:600c:4e8e:b0:45d:d97c:235e with SMTP id 5b1f17b1804b1-46e6127a1a2mr51951525e9.12.1759389500340;
        Thu, 02 Oct 2025 00:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHH2bH9y5SpEFzNPxE7t3AzNB2zTXQWFjPSl+9Pu6fOziiwiBNOHN0F39U223H2afps1W7Q==
X-Received: by 2002:a05:600c:4e8e:b0:45d:d97c:235e with SMTP id 5b1f17b1804b1-46e6127a1a2mr51951285e9.12.1759389499798;
        Thu, 02 Oct 2025 00:18:19 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8acc4csm2320435f8f.16.2025.10.02.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:18:19 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Bhanu Seshu Kumar Valluri
 <bhanuseshukumar@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH] drm/ssd130x: Use kmalloc_array to prevent overflow of
 dynamic size calculation
In-Reply-To: <bfc90c7a-4ade-4bf0-88e3-86697e664e35@suse.de>
References: <20251002013312.67015-1-bhanuseshukumar@gmail.com>
 <bfc90c7a-4ade-4bf0-88e3-86697e664e35@suse.de>
Date: Thu, 02 Oct 2025 09:18:17 +0200
Message-ID: <87zfa94vra.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Bhanu and Thomas,

> Hi
>
> Am 02.10.25 um 03:33 schrieb Bhanu Seshu Kumar Valluri:
>> Use kmalloc_array to avoid potential overflow during dynamic size calculation
>> inside kmalloc.
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>> ---

The same patch was posted by another developer a couple of weeks ago
and is now queued already in the drm-misc-next branch:

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=940dd88c5f5bdb1f3e19873a856a677ebada63a9

>>   Note:
>>   Patch compiled successfully.
>>   No functionality change is intended.
>>
>>   drivers/gpu/drm/solomon/ssd130x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
>> index eec43d1a5595..8368f0ffbe1e 100644
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -1498,7 +1498,7 @@ static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
>>   	if (ret)
>>   		return ret;
>>   
>> -	ssd130x_state->data_array = kmalloc(ssd130x->width * pages, GFP_KERNEL);
>> +	ssd130x_state->data_array = kmalloc_array(ssd130x->width, pages, GFP_KERNEL);
>
> The first parameter is the number of elements. The second parameter is 
> the size of an individual element. So the arguments should be swapped. 
> Same for the other changes.
>
> I know it's nitpicking, but who knows what it'll be good for. Fun fact 
> is that even kmalloc_array mixes up both parameters internally.
>

You are right. I didn't notice this subtlety when reviewing mentioned
patch that pushed to drm-misc-next.

> Best regards
> Thomas
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


