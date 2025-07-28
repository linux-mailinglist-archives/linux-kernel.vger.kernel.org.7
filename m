Return-Path: <linux-kernel+bounces-747801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47317B13884
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E23188CC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924424678A;
	Mon, 28 Jul 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LHAOC+qK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0B218ABD;
	Mon, 28 Jul 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697028; cv=none; b=ZmxNegxVDohUedfYoM3oGM+Mq0Jdv64FdFvykoHC3QE2fy3KAfY/1Ovxx6o5YCXf9TQkITXp/JLe6d/Hl0005xGnkbU3OyjbJZhvbnu1uGt8lyffcSkfOVR6ipXu3+tTRm7nQmy3MbN+o3EGphBGPdZoWcrj/KezRBKAr87sTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697028; c=relaxed/simple;
	bh=OJvZOtZWtP5T0PzzfgXr4dA4B4uqn6dYb9pB37Og+Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWZ8Tk3FlzN5KHAFckwDyKZhiizz6wG6aO+u+w5iH48XKvJvavvViog9O26H1BnqjifrS9H7nNWT2KrVvP4ujNojjjXdmVd3dFEuVtRt1iqOx75h97Jo16swKNkjjwzQTiMiG8XDlvwN3gTbGA57PcN3actnuYI8zpoF28rfnYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LHAOC+qK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753697024;
	bh=OJvZOtZWtP5T0PzzfgXr4dA4B4uqn6dYb9pB37Og+Qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHAOC+qK+AWMxcwoV72yYP6zs6wX8/phcBzKqr6naiqpjjGTPAyxxRTE/tI5OTeC3
	 QIZWZLvIhjZED6w9aexgk5syMZAh5fbAiUmcJV+oXknfY1l03rSDeQXwC0f3X4O64Q
	 ZMK96/KhYxU4SUmTCKQL/S+pX0GDFrfnHYfuIrx3R5njbP7qvo2WuunUzfr4MoThzV
	 cGgpJ2x1/rfTL3wdJWezoTPE+HxUiUvppVqQ+ItE+YgErt8rTW4O+yMnwgb8Z9Gtg3
	 Uffl4aAgx0NVZP9n7qFmg7mtV+zIRBIxjrd5gKr9tCIpYruEvKgAZXG9uIyGmk7c4N
	 lVa6F7R6sPHBw==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC6F317E0F3F;
	Mon, 28 Jul 2025 12:03:43 +0200 (CEST)
Message-ID: <c7c76b11-f7db-4cfd-81ac-c43d8c540472@collabora.com>
Date: Mon, 28 Jul 2025 13:03:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] usb: vhci-hcd: Prevent suspending virtually
 attached devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
 <20250726-vhci-hcd-suspend-fix-v2-1-189266dfdfaa@collabora.com>
 <2025072637-google-referable-dc99@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025072637-google-referable-dc99@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/25 10:06 AM, Greg Kroah-Hartman wrote:
> On Sat, Jul 26, 2025 at 01:08:03AM +0300, Cristian Ciocaltea wrote:
>> The VHCI platform driver aims to forbid entering system suspend when at
>> least one of the virtual USB ports are bound to an active USB/IP
>> connection.
>>
>> However, in some cases, the detection logic doesn't work reliably, i.e.
>> when all devices attached to the virtual root hub have been already
>> suspended, leading to a broken suspend state, with unrecoverable resume.
>>
>> Ensure the virtually attached devices do not enter suspend by setting
>> the syscore PM flag.  Note this is currently limited to the client side
>> only, since the server side doesn't implement system suspend prevention.
>>
>> Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/usb/usbip/vhci_hcd.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..b4b0ed5d64966214636b157968478600e2e4178a 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -765,6 +765,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>  				 ctrlreq->wValue, vdev->rhport);
>>  
>>  			vdev->udev = usb_get_dev(urb->dev);
>> +			/*
>> +			 * FIXME: A similar operation has been done via
>> +			 * USB_REQ_GET_DESCRIPTOR handler below, which is
>> +			 * supposed to always precede USB_REQ_SET_ADDRESS.
> 
> When is this FIXME going to be addressed and by whom?

Actually I should have probably used a NOTE or something similar as this is
only about the possibility to drop some redundant code, rather then fixing
something broken.

>> +			 *
>> +			 * It's not entirely clear if operating on a different
>> +			 * usb_device instance here is a real possibility,
>> +			 * otherwise this call and vdev->udev assignment above
>> +			 * should be dropped.
> 
> What is going to need to happen to figure this out?

I could only do some limited testing on my side, which is definitely not
enough to confirm it's safe to move on with the code removal, hence I'd very
much like to get some other opinions on the matter.  Regardless, I think
it's useful to keep this documented.

Thanks,
Cristian


