Return-Path: <linux-kernel+bounces-735920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DCB09541
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FF7AE8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0FB21CA13;
	Thu, 17 Jul 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBn+VloK"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE621ADB9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782119; cv=none; b=GON0d0dPRWGLMFAvjzqgIWcSeP+AUmBveXtPtIWC7Vw2gtUKJUX+Kyc9Xh4skTtlFq3nP8XUNlh7JgmPZCTCBZA+KhvPYVYYpA369tvvLPnEhzYtrLBHTEY29eiCgAZ8aAxasT4R6PT64lEFFzZ+cmW2Y1Cl7ZKV1m2IyNSI5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782119; c=relaxed/simple;
	bh=+Q9RKHTHvCAIkCwob0N05RgnvskVzJ6/1kxlNGU0ULw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxTdIRzpprzoLXErDk92uA9n+6X+BgknyB/ie6xLp4oMm0GgsRA9TM5miH8Cnh2/iUviuvQuCYVLs2kR/Rv3xSrbPyHWY46yQIRohiObfGknWDBd+dyIKZQyf9YpBgFQ88kZVlNWPg6SP/lKtVmxwkqkqVxfW8YjC5yFmEL7TdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBn+VloK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so9846465ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752782116; x=1753386916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnGpwrpCqI1VlGpJfKbQwgcrq4rzy8zYYAzVgnVuWmE=;
        b=hBn+VloKOXCXkhCAfNOYIfCW4KtIquD+TYWdMEwuz84qotlVLB2PkIKFQ8FZuSuzbi
         dfmyE5xCDcYuEBE0rHc6ZcY3LECqhGhYRpCnF8bqoRCdIaBG+jLWTtA7Q4FMNzkpo2i3
         gErw3/8Cm20/kQ7/1TZJo/DHTYgJHYYrial20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782116; x=1753386916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnGpwrpCqI1VlGpJfKbQwgcrq4rzy8zYYAzVgnVuWmE=;
        b=wmg3h9SJw2t9wv6tCuD5QqcqSeaVB/857qhZEl/NqNPI2DPe3FMCqu4o4c9xqtr086
         iGwg27LG/oZZhCqlyi5A8rwAl3JyCVTPVZZLVfMDbW7MAWlTxKEprtSjqpr3S5UHHc7p
         /HflydOVW4HX1qTzlkTMZrdozSupD+ph6AJVkBQCkTFVOP7tUp1dxlSJYvlJYDwWDz45
         1uB9Y97FRUQO48VQDd5d758L1MC/eX/QD99/Sh1jNT3N0F1pr7ZH+/GJB0cEHJx7NXQo
         zeBHrzwbPvGtew7yIO6fFUSowpN+ULhbv13rSl41C2LuKOFwYWRhwZ2hT6SJ+fZQbJ7q
         FzHA==
X-Forwarded-Encrypted: i=1; AJvYcCUtN4IUCNnrSMB52lfJfVw5yCPZYGJdzzuPL3eG8Y3d8xQH811PGQGT+CqrmhJ0iTf+tvY9j+HIlTDujFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeyeXXtMJmk/q/VzJn2MS3ufgCW1zWnljufOANxtzo5IemaTO
	Qo972FXz3ElBHdMpt8MzKe97qzSful8+52Ul5MVUrH9QGayiOOlOeYCKbJzkdwKaasE=
X-Gm-Gg: ASbGncuiO53Cx3ZGD3un+RqRwlgX9RmTOTYnTcT3EgddT9N8sGtGy9pv+oUF+3B5f83
	wJdVkYRzS+aw/Rs64Zi1Ydouu41BQJDCuAu0l6wNlRaxHWCSv02xxj0LzSEZPbV4tj4mb1UGL7T
	Qiri2lSh8unM43WLQObvJkOcz6tkU0Dy6CM+GT93mumvAiCBMwakfmM6U0yB58+KzY/gBjI+Ebo
	aLJ0sjDo/daRZL/hmd4j9rFtQcjOSwUdHkd5mru17qt0TEi1tXik5sRE6WeK+tROD2N8C5Wween
	AM2rYfyi3dMDEH7uFIDkU3DbkVGCpaTwzXZwcWJOG3Tu42257JgLDrGZFeRsAow+EP0s/WMRHsJ
	UFky1Ai2wnmRTCKuQwB2Hfzwc6TvbcDFThQ==
X-Google-Smtp-Source: AGHT+IGptDM8XPxxprOyVs4kILAhbRPCYCZSt2H7kbObkiEmZYSJLbKxHFVOcoaLqqZdbUSAThJFAA==
X-Received: by 2002:a05:6e02:1a66:b0:3df:3bdc:2e49 with SMTP id e9e14a558f8ab-3e2824ca25amr98433675ab.12.1752782115824;
        Thu, 17 Jul 2025 12:55:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505565324e2sm3596031173.25.2025.07.17.12.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 12:55:15 -0700 (PDT)
Message-ID: <2a87101f-6bee-4bd1-816a-1dfbe7b4a578@linuxfoundation.org>
Date: Thu, 17 Jul 2025 13:55:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] usb: vhci-hcd: Prevent suspending virtually attached
 devices
To: Alan Stern <stern@rowland.harvard.edu>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-1-2b000cd05952@collabora.com>
 <42bcf1e1-1bb2-4b63-9790-61393f780202@rowland.harvard.edu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <42bcf1e1-1bb2-4b63-9790-61393f780202@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 12:26, Alan Stern wrote:
> On Thu, Jul 17, 2025 at 06:54:50PM +0300, Cristian Ciocaltea wrote:
>> The VHCI platform driver aims to forbid entering system suspend when at
>> least one of the virtual USB ports are bound to an active USB/IP
>> connection.
>>
>> However, in some cases, the detection logic doesn't work reliably, i.e.
>> when all devices attached to the virtual root hub have been already
>> suspended, leading to a broken suspend state, with unrecoverable resume.
>>
>> Ensure the attached devices do not enter suspend by setting the syscore
>> PM flag.
>>
>> Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   drivers/usb/usbip/vhci_hcd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..762b60e10a9415e58147cde2f615045da5804a0e 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -765,6 +765,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>   				 ctrlreq->wValue, vdev->rhport);
>>   
>>   			vdev->udev = usb_get_dev(urb->dev);
>> +			dev_pm_syscore_device(&vdev->udev->dev, true);
>>   			usb_put_dev(old);
>>   
>>   			spin_lock(&vdev->ud.lock);
>> @@ -785,6 +786,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>   					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
>>   
>>   			vdev->udev = usb_get_dev(urb->dev);
>> +			dev_pm_syscore_device(&vdev->udev->dev, true);
>>   			usb_put_dev(old);
>>   			goto out;
> 
> This looks very strange indeed.
> 
> First, why is vhci_urb_enqueue() the right place to do this?  I should
> think you would want to do this just once per device, at the time it is
> attached.  Not every time a new URB is enqueued.

Correct. This isn't the right place to do this even if we want to go with
the option to prevent suspend. The possible place to do this would be
from rh_port_connect() in which case you will have access to usb_hcd device.

This has to be undone from rh_port_disconnect(). Also how does this impact
the usbip_host - we still need to handle usbip_host suspend.

> 
> Second, how do these devices ever go back to being regular non-syscore
> things?
> 
> Third, if this change isn't merely a temporary placeholder, it certainly
> needs to have a comment in the code to explain what it does and why.
> 
> Fourth, does calling dev_pm_syscore_device() really prevent the device
> from going into suspend?  What about runtime suspend?  And what good
> does it to do prevent the device from being suspended if the entire
> server gets suspended?
> 
> Fifth, the patch description says the purpose is to prevent the server
> from going into system suspend.  How does marking some devices with
> dev_pm_syscore_device() accomplish this?
> 

We have been discussing suspend/resume and reboot behavior in another thread
that proposed converting vhci_hcd to use faux bus.

In addition to what Alan is asking, To handle suspend/resume cleanly, the
following has to happen at a higher level:

- Let the usbip hots host know client is suspending the connection.
   The physical device isn't suspended on the host.
- suspend the virtual devices and vhci_hcd

Do the reverse to resume.

I would say:

- We don't want vhci_hcd and usbip_host preventing suspend
- It might be cleaner and safer to detach the devices during
   suspend on both ends. This is similar to what happens now when
   usbip host and vhci_hcd are removed.
- Note that usbip_host and vhci_hcd don't fully support suspend and
   resume at the moment.

thanks,
-- Shuah


