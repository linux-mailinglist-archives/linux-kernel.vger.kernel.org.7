Return-Path: <linux-kernel+bounces-731752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D3B05900
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989061899177
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45126AA94;
	Tue, 15 Jul 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fWVVcABg"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31D19CC37
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579489; cv=none; b=AZU/FgORmZ+VKboLVZlbbKlt8m0mJIgyIyhVS01l6VMN1ZJRXdPHJIk772fMElQPMNftJ7SHBiCJ6/OBf0nZYCM4Gi0qAe6HetUgcFcny9YhsQu/TuFayyET3k1SFXPs5jB7AjnshlWhKA4NhWgMRtJlYgY/5Wec141Pft45L0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579489; c=relaxed/simple;
	bh=d2e+1AfbwM8V7xMaHjfjAHW4oTYLAlJH5EMpKSwCC/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8uX27wL1IgeJ2pJvqUDLJ5znWPlbfs0gYVKnO+K3UDbyC4/B8VIr5PGrYbnObwjPNgSvQtFvyJn4Se9AFHFdEEBKxLtdNTenfzObvjv4UM/yqTYxbiBJ/guzsg2shUNRK0ODxvBEwBlJL+16S2hJQxfefi9pcp0jT8MKvlTfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fWVVcABg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 32092207B6;
	Tue, 15 Jul 2025 13:38:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohWm7pHh7jh5; Tue, 15 Jul 2025 13:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752579483; bh=d2e+1AfbwM8V7xMaHjfjAHW4oTYLAlJH5EMpKSwCC/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fWVVcABgKZBpNCbPrDvWaLGMRySibU7tKiVVO61TXU5I04TtAOHw5JNNbqCVnZ1gB
	 h7/UgiSUs6UJtUPaczqTZ0JtpLX0m5YxQ6jtbNlzB0f56yG9UuGOMber9U4DmpBTq6
	 5+SSCSXwrdgPAiWOgYuSRRwqh6hNJVxH11UGkRH61tBOYC21I01ne/2aVh1gNRz2tn
	 IBgXV+C+PSTChASsBr3wF2nXzqU40dxeR/afTem3YHJfpXyiuNYKrtq58Z7gLjgX3h
	 9Fz+faod+9aMhW1NG43B/E44hWN2OjAEVRsFlafybN6GjKKTboz4uUp9QEWqc8Er/+
	 iQ+ELT7ZPmifw==
Message-ID: <af2103a0-f9d0-4980-9ec7-e4ce512ea59a@disroot.org>
Date: Tue, 15 Jul 2025 13:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: power_supply fix alignment
To: Rui Miguel Silva <rmfrfs@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, johan@kernel.org, elder@kernel.org,
 ~lkcamp/patches@lists.sr.ht, koike@igalia.com
References: <20250714135606.41671-1-akhilvarkey@disroot.org>
 <DBBXCAEMM5ZO.GTKVMMR2XDJ7@linaro.com> <2025071540-sepia-amuck-c757@gregkh>
 <DBCIG2AHAZHR.31GUITYRTUZXJ@linaro.com>
Content-Language: en-US
From: Akhil <akhilvarkey@disroot.org>
In-Reply-To: <DBCIG2AHAZHR.31GUITYRTUZXJ@linaro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rui and Greg,

On 15/07/25 11:10, Rui Miguel Silva wrote:
> Hey Greg,
> On Tue Jul 15, 2025 at 9:05 AM WEST, Greg KH wrote:
> 
>> On Mon, Jul 14, 2025 at 05:38:31PM +0100, Rui Miguel Silva wrote:
>>> Hey Akhil,
>>> Thanks for your patch.
>>>
>>> All looks good with the exception of a small nit...
>>>
>>> On Mon Jul 14, 2025 at 2:56 PM WEST, Akhil Varkey wrote:
>>>
>>>> Fix checkpatch check "CHECK:Alignment should match open parenthesis"
>>>>
>>>> Signed-off-by: Akhil Varkey <akhilvarkey@disroot.org>
>>>> ---
>>>>
>>>> Hello, This is my first patch, I appreciate any feedbacks. Thanks!!
>>>
>>> Welcome, and continue...
>>>
>>>> ---
>>>>   drivers/staging/greybus/power_supply.c | 14 +++++++-------
>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
>>>> index 2ef46822f676..a484c0ca058d 100644
>>>> --- a/drivers/staging/greybus/power_supply.c
>>>> +++ b/drivers/staging/greybus/power_supply.c
>>>> @@ -324,7 +324,7 @@ static struct gb_power_supply_prop *get_psy_prop(struct gb_power_supply *gbpsy,
>>>>   }
>>>>   
>>>>   static int is_psy_prop_writeable(struct gb_power_supply *gbpsy,
>>>> -				     enum power_supply_property psp)
>>>> +				 enum power_supply_property psp)
>>>>   {
>>>>   	struct gb_power_supply_prop *prop;
>>>>   
>>>> @@ -493,7 +493,7 @@ static int gb_power_supply_description_get(struct gb_power_supply *gbpsy)
>>>>   	if (!gbpsy->model_name)
>>>>   		return -ENOMEM;
>>>>   	gbpsy->serial_number = kstrndup(resp.serial_number, PROP_MAX,
>>>> -				       GFP_KERNEL);
>>>> +					GFP_KERNEL);
>>>>   	if (!gbpsy->serial_number)
>>>>   		return -ENOMEM;
>>>>   
>>>> @@ -546,7 +546,7 @@ static int gb_power_supply_prop_descriptors_get(struct gb_power_supply *gbpsy)
>>>>   	}
>>>>   
>>>>   	gbpsy->props = kcalloc(gbpsy->properties_count, sizeof(*gbpsy->props),
>>>> -			      GFP_KERNEL);
>>>> +			       GFP_KERNEL);
>>>>   	if (!gbpsy->props) {
>>>>   		ret = -ENOMEM;
>>>>   		goto out_put_operation;
>>>> @@ -634,8 +634,8 @@ static int __gb_power_supply_property_get(struct gb_power_supply *gbpsy,
>>>>   }
>>>>   
>>>>   static int __gb_power_supply_property_strval_get(struct gb_power_supply *gbpsy,
>>>> -						enum power_supply_property psp,
>>>> -						union power_supply_propval *val)
>>>> +						 enum power_supply_property psp,
>>>> +						 union power_supply_propval *val)
>>>
>>> Here you fix the alignment, but the last line goes over column 81, even
>>> though 80 is not really one hard requirement anymore, all code
>>> (strings is ok to go over to be easier to grep for messages) is on that
>>> register.
>>>
>>> So, to be coherent, if you could please send a V2 without this specific change
>>> would be great, Or even better, if you could get rid of all the _ and __
>>> prefixes in functions names that would be great, and will give more
>>> space for function paramethers.
>>> Your call.
>>
>> Nah, this is fine as-is, we can go over the limit to 100 for tiny stuff
>> like this.
>>
>> And the __ prefixes should be there to show no locking, or "internal"
>> functions, right?  So changing the name needs to happen very carefully.
> 
> Yup, we can go either way here. I do not have strong feelings about
> this.
> 
> So, LGTM, Thanks Akhil.
> Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
> 
> Cheers,
>      Rui
> 
>>
>> thanks,
>>
>> greg k-h
> 
> 
> 

Thanks accepting my patches and for the suggestions on what could be 
done better.

Best Regards,
Akhil Varkey

