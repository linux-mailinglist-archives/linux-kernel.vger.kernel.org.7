Return-Path: <linux-kernel+bounces-735747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE4B09349
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70DF16B8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423D2FE311;
	Thu, 17 Jul 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mDCHvEke"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351221F95C;
	Thu, 17 Jul 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773725; cv=none; b=Cujtd29OI/yYAALgaJJ5rMn6OZ8+g4HenYVCq0co61nlY0oq4Uv/FAfGuIdn8kVKn/uEuGd7rYIakmqC3T8iq8QPRQM80D3rnwN/OY2Vv2GJ7/P3AwOu+1Pq9ql1E6wEQPSpZuRK1KmK1k3N/hKdot7D0snnGL49lRA/YKa7eBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773725; c=relaxed/simple;
	bh=gnhAK40p9NXzzGOPYQ+r2xlTzVBnm3D99hUHeFDiKvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3q/lJJUsMtD44Nx3MVQCFrHzmZdQ4x9qmzMTG52zxaBy6ueI29Qqw1IhDEeSBoGU2zGliNgvjg3zDFv3pZqDyBLo6bjxiksPLxJMvgg25Ix8M6bDDI0Zd2loavFapWIOgYMaieoq5+splH7sz2+Ypdnh7C7Mq2hvHqt345IFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mDCHvEke; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752773721;
	bh=gnhAK40p9NXzzGOPYQ+r2xlTzVBnm3D99hUHeFDiKvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDCHvEkex3g6W2cxbn941o0g2nkcVizXXbgBYtpjpRJS1fOzEF9fWXxw6NEr+BPDT
	 NREQKpeFEOVYzh70JbeVLFcRDemWDONZmk2QpocaH/3IuhVmqdBDONMJIlhsnFMHFm
	 gy3kLNohL0XjNWzOW5hm5qyHPcrL5AJMSPyAyGbkPDN+lKFwx85os9O660YiHvBjJu
	 8GJ1MyCzYgSAbLIXGOej+dAjeedKSOvV61ObnbYN61mfj4LNTNHmMmcUUsWdNO1Lkb
	 kyXftRtKkFBAOvGhh8wmXXfx3CwnrMsHCc/iFQs2HDT/PplnhFW0jeFcQzzGkJEzxA
	 36+EvKF11MPQg==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 13FC017E0C37;
	Thu, 17 Jul 2025 19:35:21 +0200 (CEST)
Message-ID: <581bd772-edb7-44e9-b08f-af4c456ea9f1@collabora.com>
Date: Thu, 17 Jul 2025 20:35:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] usb: vhci-hcd: Do not split quoted strings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-5-2b000cd05952@collabora.com>
 <2025071713-passivism-suggest-436d@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025071713-passivism-suggest-436d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 7:19 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 06:54:54PM +0300, Cristian Ciocaltea wrote:
>> Join the split strings to make checkpatch happy and regain ability to
>> grep for those log messages in the source code:
>>
>>   WARNING: quoted string split across lines
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/usb/usbip/vhci_hcd.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index 3f888455d238b983a6aafa52418fb89a914c32b5..53691d5e77d386b0b0e16fe9d08824baa04c0b1e 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -376,8 +376,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>  		switch (wValue) {
>>  		case USB_PORT_FEAT_SUSPEND:
>>  			if (hcd->speed >= HCD_USB3) {
>> -				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not "
>> -				       "supported for USB 3.0 roothub\n");
>> +				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
> 
> Why the leading " "?

Yeah, not sure if that was on purpose, but I agree it doesn't make much
sense.  Will fix this up. 

> And shouldn't this be dev_err()?

I'll add a separate patch to convert all pr_*() instances, as there are
plenty of them.

>>  				goto error;
>>  			}
>>  
>> @@ -506,8 +505,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>  		case USB_PORT_FEAT_LINK_STATE:
>>  			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
>>  			if (hcd->speed < HCD_USB3) {
>> -				pr_err("USB_PORT_FEAT_LINK_STATE req not "
>> -				       "supported for USB 2.0 roothub\n");
>> +				pr_err("USB_PORT_FEAT_LINK_STATE req not supported for USB 2.0 roothub\n");
> 
> dev_err()?
> 
> Same for the others.
> 
> thanks,
> 
> greg k-h


