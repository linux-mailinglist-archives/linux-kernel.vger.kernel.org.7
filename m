Return-Path: <linux-kernel+bounces-759348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F1B1DC70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8652E727CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4039273814;
	Thu,  7 Aug 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBODp8UC"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563B26FA5A;
	Thu,  7 Aug 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587674; cv=none; b=AIgPiPYiKWgNdRT0aABx+houUrIA6rx9dAtPnLdTWGxeiH7FwnCVLwfpfHVgpjtmN+ipEGGhlH48ezoPeQcvXpBS1YcFpxMD3Op9b1R8KFmalwR1qSZkoKIuFGycd4RA30/Ntj/svqS1PvdeIRAULKMD7T2+Plqyl9gGgP0Ci6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587674; c=relaxed/simple;
	bh=7Ti1jtrebaoU8atK+mJs/TbwUFs4rxqXlbWFzZoSDcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLXcDNOdVJ552z69fWnWJ22Mi0uBBXFxhKIldH1wpW48HvjTjavLxduCqOghhF3mGXly09dyc1kZEKFgH1p1bvXDxKDAaM0pA36aJsnOm3xQa9aOoHYWC13UXnPXd1B7ApYbw0lNulTN/vyjB1tmBnhETwISKzevtXc+frDpTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBODp8UC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-75383880278so110603b3a.2;
        Thu, 07 Aug 2025 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587672; x=1755192472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lax76jE2DJSyE5EIksf8PdxFyUdMGh0dYHkUiB9beWA=;
        b=ZBODp8UCSDhhk+kRFpMCHf4iR8P/45WpygjkB1h4clfVX638++c67I7Fl9xNxzdG9e
         QXxS5zAjDgZ15m6FNtXVJyRvPM41WZKITd2rTHC0lxh7edrW/AGAM8Ge3KxOsSOG/jOi
         QSz0MyC931LCm+GzNU8NaOV1qKP/GrdGqXL4A9dgVgzLrPe7bmW7QeCYogPOwufQXt7j
         JlZwoBsc1nieg/iUPpurOZ8lk0UfMKaa3s0WCMqKx4RL5ZmvLMVYLiLA+7K0b/6cdU2f
         bmqmc3beidkPJRnLwCSP4kPmr9Qaig/4VsMk072Dx0rEzdsN6g9zcJSX9ZvAiqzR4zSK
         CZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587672; x=1755192472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lax76jE2DJSyE5EIksf8PdxFyUdMGh0dYHkUiB9beWA=;
        b=FKx3mRDHBIKcZagoaSVwTsG0rqqjeqGUZVRjZVLUg2V8pJXT2f/0oFDP/wcEX61iFa
         SJEKws3Z8qvaGf6dDo2XnGflYs5rMYDd//w8hp1R0bcwY5FMGNXS6RzdeVKCgbW18uV9
         ygpi/47FowDAJVzdX9mhvWRmIg5Fwzfeu2CvrucXv0CpvXhtPI2hVtGedJiMA1uIwFRG
         NtXs2OEacIGzVFR2eqWa7hXLiY8YuHNzXF2edHH5TZ/Ne//zfjNbWQ7J2BKWAE/xoM7i
         V6h49INL0ZPax/qrtnLvgD6hyleu8kfajtL5XkXmxpcRMqohVhUBE9mdIQ8MNzu9oBnU
         yOVw==
X-Forwarded-Encrypted: i=1; AJvYcCUk9Yct5jrLQW56PMhfjFCXORLruDbx8KVYFprAfULC3R1ds2aatNw2WBVU4KimWcmeUTyoCRjsc/WOH3A=@vger.kernel.org, AJvYcCVT5jfrcjd1bIEmPhNGQA6TFh1As0g9aKYP1AYHwQm18GPNHOvxmKZLNGFL++7/tSILbeEeLwE37ZmW@vger.kernel.org
X-Gm-Message-State: AOJu0YylmeY7MfU7LM5mV8IGDiFwZpcPekoIqQ12dmFLRGsmPGFdKTAG
	4qIgxcdbi/RjLfkjn4EOuwMrARrMuruF7gTESRXDuRPSi1tjiRWmaAnf
X-Gm-Gg: ASbGnct/TdqnGz1QZdz0kh/259/lOcR7SucfDfFQl+ZVnFSccasvR4sUJyBZwWzcaHc
	yhwuMqnYBf8YoyJSLYCwvqpsgk3dvp0yFWGb7ET+Dhd+pPybprWogejuU6CwUv+MrxsydWqn9e7
	cZAy2xJO5cIe+kZKqeS/CSenAHdRRV+xrrD5QLB3CTsI2tjf31L7ECKIa5ZiBEELMh57XPm3v0i
	tMVh66poNzZmRXgzcNR25NTLzE0GThHCN2M0PBmw8dr3iqEta/ZBZNaYfCdskB8CbpnBGnNdRw3
	R5kwmrAbbWFov8kKikYu+IEauC4FiWguYGdQe+m3o9v/bUZEyr/lvkUDk37N8LWU5x7jwEw7c70
	S5RpRjQU3G9hZv+CQ0X7jsWKkT8MFmeRh
X-Google-Smtp-Source: AGHT+IFxz0Rfqa1SaDwWPfGGPBjkcsiIcY+H7h4tgNPbpzlaHa7K9hsBDf8UpOeW2yyMjyIHfcqlwg==
X-Received: by 2002:a05:6a00:2194:b0:76b:efa5:2ace with SMTP id d2e1a72fcca58-76c2a4da25bmr4203559b3a.5.1754587672013;
        Thu, 07 Aug 2025 10:27:52 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.83.193])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa10sm18452188b3a.52.2025.08.07.10.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:27:51 -0700 (PDT)
Message-ID: <58ac9a75-6b0d-4b13-9be4-89a46b8e4136@gmail.com>
Date: Fri, 8 Aug 2025 00:27:45 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add SIMCom 8230C compositions
To: "xiaowei.li" <xiaowei.li@simcom.com>, Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250807075215.300961-1-xiaowei.li@simcom.com>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20250807075215.300961-1-xiaowei.li@simcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-07 14:52, xiaowei.li wrote:
> Add the following SIMCom 8230C compositions:
> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet

snip

> ---
>   drivers/usb/serial/option.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e5cd33093423..8c4d28dfd64e 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
>   	  .driver_info = RSVD(7) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
> +	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
> +	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE(0x1e0e, 0x9071),
> +	  .driver_info = RSVD(3) | RSVD(4) },
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>   	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),

Hi,
you are blacklisting interfaces 4 and 5 which are not present in your 
usb-devices listings and which are also not included in your interface 
function description.
You need to state the interface function which you can do as  .....tty 
(AT) + rmnet + {ADB} and also explain why the interface is hidden in
your usb-devices listings.

thanks
Lars




