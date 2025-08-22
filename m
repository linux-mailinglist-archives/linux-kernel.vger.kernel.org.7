Return-Path: <linux-kernel+bounces-781828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DBB31750
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FABB63328
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F52FC01A;
	Fri, 22 Aug 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VWc6BcnA"
Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com [220.197.32.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7C2FB639;
	Fri, 22 Aug 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864874; cv=none; b=mz1s4NQNd8Eh6RcC/6p5rla0JfBV8Hntk19Dn3cX6hu0loJGNGqRBrdpzJPFvSau8OwK1CYWYSXTBxrZxFPuFDv9LuAlhhBuS7N4PSZs36EWWeUPGKjsvOBRGweL6bmVrPJmmml6HHtIyUrFYbcg5Uh1gPcbs7PsQZiOacwC6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864874; c=relaxed/simple;
	bh=mNQvOcjjLUsjMPK0Ge2NZOtca9480N6MLioMkGl/IUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaFcXnr7vKsB1f8br2zKINsuZkurl3PET9MhFkKTb+W4GZjxN99LOgYCBH0iAUndMszjzFSQOCGUwJGn0qW+tvhxbCWOIZZvA9zEJH7Mxwy8P8cLuyd6q45PIlsGooW1fIkoY5V+fBXiVW5Uz91z13aWa5GhnHLHOWRq1Tsp9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VWc6BcnA; arc=none smtp.client-ip=220.197.32.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.33.175] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204432ef2;
	Fri, 22 Aug 2025 16:45:06 +0800 (GMT+08:00)
Message-ID: <61a7bf20-d9a0-4789-8c44-7630b34615d6@rock-chips.com>
Date: Fri, 22 Aug 2025 16:45:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_hid: Fix zero length packet transfer
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris.Wulff@biamp.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, frank.wang@rock-chips.com,
 jianwei.zheng@rock-chips.com, yue.long@rock-chips.com
References: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>
 <2025082235-fondness-destruct-f8f6@gregkh>
From: wuliangfeng <william.wu@rock-chips.com>
In-Reply-To: <2025082235-fondness-destruct-f8f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98d0f3f96909d4kunm9dfc621616a01b0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9ITFZPTR5DTElLS09DTU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=VWc6BcnAML6KLeYKr7BxS6rPYgvthG5iRlzVui0M6z6a2UFNjAqU365e9aRcVCoqNQrn0sBwx7NVGNk/iE0+TuDaBUUcoJ1dXZqIzX3KYrdrwhQ6yUuJKY8n3PDn1oM7JcsUSRBX3rPs4aqCy1FtxG2tC0n67eF4PDeBkwJEgZU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9h36v6z5jw9feLJK7q2WkHj5YgXyiYTUvmPXIhbXB54=;
	h=date:mime-version:subject:message-id:from;



On 8/22/2025 12:45 PM, Greg KH wrote:
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
> 
> What commit id does this fix?
It seems that the first verison of the f_hid.c had this issue.
commit 71adf1189469 ("USB: gadget: add HID gadget driver")

Best Regards,
William Wu>
> thanks,
> 
> greg k-h
> 
> 
> 


