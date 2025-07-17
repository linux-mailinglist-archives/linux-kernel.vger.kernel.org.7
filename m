Return-Path: <linux-kernel+bounces-735762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A662AB09381
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883ABA41569
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481362FE32F;
	Thu, 17 Jul 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gr+Ee3Xo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B871DF75B;
	Thu, 17 Jul 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774197; cv=none; b=iRjQohG2helQn3lKNjkXlQ8Eno7/TpyYis+gFDtzV9HR98raNIF7WLzDj6PnKu+CAG1jY2HsG9GiA0W76t+5cVj7urr6QTd56JpiTteJvjYShyIfIAKjHKZQ9qY8iTJH4ccRiMVg/QOX/dsJA6f6AoxB+Tr7Shly1Li0YI6EetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774197; c=relaxed/simple;
	bh=bjERXHcJ+vSU9IZaOq8dr3gD7Y4Shwp+F3PR5jf5mYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwUrgo/U7keTL0jC9eH9dwAbbxk0O5BCizdkM5DIxuraby2CBhNn/09v2kRqLUtEbEzGqzcT5shRsL7mpYc4z3+BwUwfQ0s2l8ZC8eoVwq8xDhzCetUtcZc6xERMEw2w4zd3i/a+C661QESYZVPiOIfzUH7Yi4WSBnEoRbBjKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gr+Ee3Xo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752774194;
	bh=bjERXHcJ+vSU9IZaOq8dr3gD7Y4Shwp+F3PR5jf5mYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gr+Ee3XoOaWz1NUjPb1MmXB0YPNBexLKepDu22rjQ3TluAhq+xwL3BfGka1V9ETD6
	 CpeYwOdXqlfrOCrnr9bA3HVONIZY4CjpgD1JGpQTbDwEUeV/B7ZL/Gm+SMczQzKRUC
	 A3YDfU99XyoLz1q52NIeV1ybhpwggSzZ7ZpXUpBjy0WlMoMf3BlnAP/0ePUm2fGMOY
	 N3R3mtIiB3ny/WbYihi34sYF0dPoW5E5lA/CCgFsR+RIZM5xJyqlNyzPurWNGOUbMx
	 31fKAafsN3bn4edWG4pO2I/jFc3WNszviItqo3Do+h0Pi54zO2DYQQx74wejJCfEw1
	 WLDrDyIbxH2xg==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F18E17E14DD;
	Thu, 17 Jul 2025 19:43:13 +0200 (CEST)
Message-ID: <52a7669a-2c0c-4b2c-af69-c7e56847896e@collabora.com>
Date: Thu, 17 Jul 2025 20:43:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] usb: vhci-hcd: Consistently use __func__
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-8-2b000cd05952@collabora.com>
 <2025071755-vitalize-nineteen-f843@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025071755-vitalize-nineteen-f843@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 7:18 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 06:54:57PM +0300, Cristian Ciocaltea wrote:
>> Replace all explicit function names in string literals with __func__ and
>> silent several checkpatch complaints similar to the following one:
>>
>>   WARNING: Prefer using '"%s...", __func__' to using 'vhci_start', this function's name, in a string
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/usb/usbip/vhci_hcd.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index 841902482fb15d1d86525f23492e4966f35630a0..95034440c84f931bdf47552b499e0fdc6f726e59 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -160,7 +160,7 @@ void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed)
>>  	u32		status;
>>  	unsigned long	flags;
>>  
>> -	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
>> +	usbip_dbg_vhci_rh("%s %d\n", __func__, rhport);
> 
> So now you have __func__ twice in the log (hint, pr_debug() provides you
> the function name.)
> 
> For "trace" debugging lines like this, just remove them, ftrace is
> better to use instead.

I should probably fix the whole logging stuff as part of the pr_*() -> dev_*() 
conversion.

Thanks,
Cristian

