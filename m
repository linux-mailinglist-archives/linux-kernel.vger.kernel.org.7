Return-Path: <linux-kernel+bounces-854821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B5BDF7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D24FAC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D332A3E1;
	Wed, 15 Oct 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="LUBcs/XH"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAC30505F;
	Wed, 15 Oct 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543351; cv=none; b=sXm/+Z9tPbjQa65CT0LPT/glFcnk1nEf6chOWVjfiteBcJLK93ffuKZKYJwKI6Wvy/6Jhou+4WodycAsa5e4NBuXfPC4Xm1XOeKgGOQAbZdxN2oiDnGYzh/xXqGsGpn7AT5FH38FUoigB98fFnfZua6Pjo8JsLOjPgz51IU+t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543351; c=relaxed/simple;
	bh=VkCVqergx42FW7AC8yii+46h19LrNzFVp0tRz0lY3rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqWeb93MnqbjXMJQdfOzReBQGzXvFN5lYZ5iGuVK1RnR/kItZkwWX2RHJYYkRGKTyz5r+GGSKGN6mkcaSUSusRDh5UI8SGGV/Rj+vAhCUTR66fwkxBXU95QyJaw4UtL03u5dYf/yLmP1xo/Ra1zur0+zjP+ExO4X8dHP/vunA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=LUBcs/XH; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.10.11.39] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id CBF9D2FC0048;
	Wed, 15 Oct 2025 17:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1760543338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fZ2PwIo5vV3UoKsUqdGTr+H+RIuygzvlm26PtR8E5w=;
	b=LUBcs/XHt7OrPWt0MCsiM64jr38dd6KgcGskYDRNzIxz5zMUctCaOKK36z9UvdeOmlbrFQ
	KkFPMTKGONLgalfWKBuZCwjYxEWt6sglGrOLrMqgAxL4BMHhSzmVIRbf4kbYsC6QvPVFyo
	oGeBUa9h19IXjyg+/Q4ip2yc0n8cpN4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <c541f079-5b86-4193-8109-4fa2008ffd96@tuxedocomputers.com>
Date: Wed, 15 Oct 2025 17:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb/core/quirks: Add Huawei ME906S to wakeup quirk.
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tim Guttzeit <t.guttzeit@tuxedocomputers.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014153049.91722-1-wse@tuxedocomputers.com>
 <8ef4550b-a958-4fa4-88df-89b3d4b1117d@rowland.harvard.edu>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <8ef4550b-a958-4fa4-88df-89b3d4b1117d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 15.10.25 um 16:21 schrieb Alan Stern:
> On Tue, Oct 14, 2025 at 05:30:05PM +0200, Werner Sembach wrote:
>> From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
>>
>> The list of Huawei LTE modules needing the quirk fixing spurious wakeups
>> was missing the IDs of the Huawei ME906S module, therefore suspend did not
>> work.
>>
>> Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   drivers/usb/core/quirks.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>> index f5bc538753301..39fbbc31e9a41 100644
>> --- a/drivers/usb/core/quirks.c
>> +++ b/drivers/usb/core/quirks.c
>> @@ -469,6 +469,8 @@ static const struct usb_device_id usb_quirk_list[] = {
>>   			USB_QUIRK_DISCONNECT_SUSPEND },
>>   	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
>>   			USB_QUIRK_DISCONNECT_SUSPEND },
>> +	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
>> +			USB_QUIRK_DISCONNECT_SUSPEND },
> Please pay attention to the comment at the start of the array's
> definition.  Entries should be sorted by vendor ID and product ID.

Sorry for missing that, v2 incoming.

Best regards,

Werner

>
> Alan Stern

