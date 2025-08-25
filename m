Return-Path: <linux-kernel+bounces-784240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964EB3387F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B45E17D92E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8D29B795;
	Mon, 25 Aug 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jZTcCQqM"
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8F29B793;
	Mon, 25 Aug 2025 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109482; cv=none; b=hAJTQtGhcHUXZ+d0epsJZ5P2gPLWcunKgQumYhwNc/VQ+U6PZIM31DASQj9ljNj4Xv+18+5RQqKOwGOtMd1BUrg6Y8YU6Ct5u/k/NPg5oMjVkW04I+MljMdPg8p5mogZVgzLMNhmcm2xWBkwakag6piRFFKGpkSOSmPGY4NHSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109482; c=relaxed/simple;
	bh=NGv79DTk6F7a87cvl4FUlWH3mVBfPqdnx9mJIeeHa5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rjw2y891k4GLhCthBeJ3KWvpzrT3tItSjBrQ/5esRl3vTfHBBIHDYUCVSVpXEjAxnO2YF8BxwD1B5j6lkLudgAJ9ycBj58RNtHjT69aG6K9OH6j8UzGHjwyeANFYy3mFB9urd955JcuO5x7ZqakGhCVTvbAyiw8s07YV3UQn0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jZTcCQqM; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.33.94] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20740ab50;
	Mon, 25 Aug 2025 11:35:11 +0800 (GMT+08:00)
Message-ID: <5252b43d-a7ee-42b5-932e-6c6eadd04543@rock-chips.com>
Date: Mon, 25 Aug 2025 11:35:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_hid: Fix zero length packet transfer
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, Chris.Wulff@biamp.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com,
 yue.long@rock-chips.com
References: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>
 <c09f21ee-be83-4880-841b-70e1e5c036f0@rowland.harvard.edu>
From: William Wu <william.wu@rock-chips.com>
In-Reply-To: <c09f21ee-be83-4880-841b-70e1e5c036f0@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98df4b4d9709d4kunm3b6efc731b10cc1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4YGVZJSk5OS0wfSh0ZSENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=jZTcCQqM5yrjKOFSAtYk0EnwukWfQDkymkU92Bs/8bgdkoPL4iFiWgwJQ0RWrLDRT0s05dijmxWi39X56bJypBnDZJPRelZpNaRs6nQiCRqooJycG19YKE9GFZan4yvA4KXRKygdrWj8BKp8qrjw1L2zGaovhMjvOgSZYCkCrg0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=G4TTjMMxsEMVdyTYcmWj7mnrO5XKGcr4tlqnkm4eDc8=;
	h=date:mime-version:subject:message-id:from;



On 8/22/2025 9:56 PM, Alan Stern wrote:
> On Fri, Aug 22, 2025 at 10:01:58AM +0800, William Wu wrote:
>> If the hid transfer with size divisible to EPs max packet
>> size, it needs to set the req->zero to true, then the usb
>> controller can transfer a zero length packet at the end
>> according to the USB 2.0 spec.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>>   drivers/usb/gadget/function/f_hid.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
>> index 8e1d1e8..8021af3 100644
>> --- a/drivers/usb/gadget/function/f_hid.c
>> +++ b/drivers/usb/gadget/function/f_hid.c
>> @@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
>>   	}
>>   
>>   	req->status   = 0;
>> -	req->zero     = 0;
>> +	req->zero     = ((count % hidg->in_ep->maxpacket) == 0);
> 
> Here and below, there is no need to check whether count is divisible by
> the maxpacket length.  The UDC driver does this for you automatically.
> (See the kerneldoc for struct usb_request.)  Simply set req->zero to 1.
> 
> Alan Stern
Good idea，I checked the UDC drivers (drivers/usb/gadget/udc and 
dwc2/dwc3), they test if zlp is actually needed if req->zero to 1.>
>>   	req->length   = count;
>>   	req->complete = f_hidg_req_complete;
>>   	req->context  = hidg;
>> @@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
>>   	return -EOPNOTSUPP;
>>   
>>   respond:
>> -	req->zero = 0;
>> +	req->zero = ((length % cdev->gadget->ep0->maxpacket) == 0);
>>   	req->length = length;
>>   	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
>>   	if (status < 0)
>> -- 
>> 2.0.0
> 
> 
> 


