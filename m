Return-Path: <linux-kernel+bounces-845994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A1BC6ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD55834F406
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB92C0F6D;
	Wed,  8 Oct 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXkJpkBh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F520487E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958645; cv=none; b=QYFY7je66xoK9iggfj2AqLYVUpj/EHuMNUrh5E7wsoCRU+mEHNiFHbJ/l4ux9fpUrxdnOHvjJxixBU6UqJlI8pAtTht3AFVnDZoiFGAj3v1gfn2p8DmknuFpLqzbliZpy3/ZmkAMA/5WQgFxPXv1C1hWANFTl+fEv6sitZdrXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958645; c=relaxed/simple;
	bh=HEFZfy/bOiUPVmOEzICFEBHZzqvYM+jSBmzbPiW2n0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud51RfE31NmHXOL+oQ4D1Zz1oZwVptN122ehSeZY5nwyT8Ig41Wn5AuJKkCn/YXeVrjct8O02Qx1UJmBUjYJ/uvLnEe6HjCXlL2BWj+bqg6+l2zf/lXcwR+d/q3bb4UhbuKVE9EZiNgB6nszL08oJ+14PMtEtLmqLctOUB02Lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXkJpkBh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b403bb7843eso50693666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759958641; x=1760563441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9YY8RVzKysd/2FBRUq2EA9d+6aVFuf0Slin7qbDg94=;
        b=KXkJpkBhUEUrOPzgoVtou9nJvlyGRrs9AIY2TnrnnwtsDmxNcePIfVtR1k4AJsgZ/A
         JAouZfnxn1oLuCDqxB8a5ocLjTe6dOOq22LM2oGnL8EVZgLvS/LQNlWNgAd/atOys89m
         nZr8pyRPIj0vDmLkq18Zu03S7s9BGiYH+23OYGRWr/cTzJpPrtpFHXXdeytiqydm/26u
         XkPqfBmiXdEcMokX7QWMlO3ZNsDv9eeSEEKiT8aDzBYEBsauVeyVrFC3C3Jzb4EypzxX
         kTBxHIEFDwhLOc39vBeZrmTTBzho6wFCewbEfRTlW4XUvWX3+fd+0QV9On6hN/Gd0CgB
         Algw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958641; x=1760563441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9YY8RVzKysd/2FBRUq2EA9d+6aVFuf0Slin7qbDg94=;
        b=tLT87s1uf+6ZLn1GBW4JJE/fLTCoKlfmBcvgpFHkk42ihOXsyQO6ZFV+bCgPot6ihM
         RDy+CfVSp324TunjEP6P/1FFvdE95dRov5KuYJ9nEiPJ6Cfi9inZY8OFleePDH20eenN
         YlTnSqHDVJF9rn1GSg93eYoOuJnfyWv/wbyCgAI0SBCzisMRATpE9ONSnYk89dV4NUSG
         xMiQPKEm2sr1dU8OwgEeqIEPEJrvs4blDopzLkTMicOQOREBLkIIJgY4yw2ltF+XRmXH
         jEwlGWMwiFRX24cT4XHUegOaxwhB3WN+nmUSGALhmmptvnpKmO+MhzxyGF13bFFXxMmy
         z+fg==
X-Forwarded-Encrypted: i=1; AJvYcCXeNM9LBvmpIwBiZ1L56MJAciRKh1QPCgstrXrKPYJlBwJrq++l/Z+UdK9sMiCGXNmxPcVoKD1yNWqhdKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2oURqZUjNZHbn0ihuNvJIkZqRy4sTldPD7XuUTiylpuI6bUh
	3RRmRqk8RxUfGy5WnZNqLIoKOfutCPhh8Urvm8cIIeaf4KSykbX/QxYyKoXkSPDu29E=
X-Gm-Gg: ASbGncsKrhabd+hnhHqWQUuYPQLa/8ROZCU0+MLZtGih4ggRbtp2gnmYpnyiiEWQG37
	Q7yJDVnBihcde2rG3C87tpW0KgT4OSDHFco2o3Ph1sDagXm9ApI6hXoa8n6j0BRuPLBRUTxut4N
	/ZNSp0GY2gXelwwi+JsoAzsvmrE2gj5c0jOdmm6EXKyKMqrBUNd8/8mrQuBPDaC3U6lwTZgLPrA
	bhG7m3ndmZZTSZUe6TaLK4hCiRc/9KoYszEm2AbnMqB68olod/wPFslCPe6QbppUiCkNQqqai+8
	Qcn7RuvOuZP/6HN2AtS19U3ItYZPK0CpyZlUpOgMj9KWczicoV9SAiN2lTr+r/JHLLa6kFouErD
	1YgbAMJrjR47Qc3qsvQyadkkeXABT+m37Xlx0SCKZ/hHZSkAI2KKV22bC8UtYN3oJMYtymMqO/d
	bThc2us94tyN/RATtShbebmSiR
X-Google-Smtp-Source: AGHT+IEodokj7MVKCM1EevdonpV47bRYAPYiGng+Bgp+oHLQSF8yGoyDw+eU3u/c5A8f7XoLgE2gUg==
X-Received: by 2002:a17:907:6d06:b0:b3d:98fa:b3fa with SMTP id a640c23a62f3a-b50ac5d090dmr530996966b.50.1759958641391;
        Wed, 08 Oct 2025 14:24:01 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f0:5001:bea8:8e43:9eb1:6992? ([2001:a61:13f0:5001:bea8:8e43:9eb1:6992])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652ade6esm1681457266b.18.2025.10.08.14.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:24:01 -0700 (PDT)
Message-ID: <71613c2a-73d5-4f6e-a71b-03a2aa0f7bdf@suse.com>
Date: Wed, 8 Oct 2025 23:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: replace kmalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Rex Nie <rex.nie@jaguarmicro.com>,
 Jann Horn <jannh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250919115654.1011141-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250919115654.1011141-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19.09.25 13:56, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> simplify and improve proc_do_submiturb(). Replace the hard-coded 8 bytes
> with the size of 'struct usb_ctrlrequest'.
> 
> Return early if an error occurs, and avoid manually setting 'ret' and
> using 'goto error'.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/usb/core/devio.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index f6ce6e26e0d4..3bc54a5c59ff 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1670,13 +1670,9 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
>   		/* min 8 byte setup packet */
>   		if (uurb->buffer_length < 8)
>   			return -EINVAL;
> -		dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
> -		if (!dr)
> -			return -ENOMEM;
> -		if (copy_from_user(dr, uurb->buffer, 8)) {
> -			ret = -EFAULT;
> -			goto error;
> -		}
> +		dr = memdup_user(uurb->buffer, sizeof(struct usb_ctrlrequest));

You cannot do this. User space cannot and must not know or care how long
struct usb_ctrlrequest is. It is a data structure internal to the kernel.
For the purpose of this API we copy 8 bytes. That is set in stone.
If the kernel's data structure ever changes length, we will have
to define a new ioctl.

You have to leave the literal 8.

	Regards
		Oliver


