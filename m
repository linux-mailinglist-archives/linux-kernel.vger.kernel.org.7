Return-Path: <linux-kernel+bounces-722767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D27AFDE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F93A3AE19B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077323ABA9;
	Wed,  9 Jul 2025 03:56:37 +0000 (UTC)
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98253208;
	Wed,  9 Jul 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033397; cv=none; b=Lf5iIci7iGOY/Tp8K4pSTzyG9W2h6P9eTWgSEs4AAwfDhXvO/2ZPd0xgjXCQqtrD3iIU6qKppf3tt/cUj76shAI20YPbeBF+PKcrYuj1gMrUhISvRrRwR5hcdF2/6v42uPSOwq8cpmWfN810scJiOzez9hc7wqLkrmkmlrfR+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033397; c=relaxed/simple;
	bh=RveA50VMS0nRhN0WXHWUO5d1U6heMN6l6azyKBFp9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8BFWba6ZaCTmixymyzHNgJs7M9SVn4C88azTWP6hS0eDy84ztpz2xAIdcTvR0g7b7c0hH0Y8hFr4TZDZLdJ1YqMeT7QuRhpm9JI4keVjwWepTPJxMD+scy0ECQx94tG0YEm/+fcdRjJxSPBg4tKi8Ffqr5ONNwjfaM2bgJa1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from [10.103.165.236] (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f30686de869007-cbe00;
	Wed, 09 Jul 2025 11:56:30 +0800 (CST)
X-RM-TRANSID:2f30686de869007-cbe00
Message-ID: <d43f274b-33fd-4fba-94a1-ba1ca20a9edb@139.com>
Date: Wed, 9 Jul 2025 11:56:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lenovo-wmi-hotkey: Fixed a kernel error report forsome
 Lenovo non-ThinkPad devices
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
References: <20250708094352.26850-1-xy-jackie@139.com>
 <e45af10b-fa26-d7e4-8051-093a6f9ce552@linux.intel.com>
Content-Language: en-US
From: Jackie Dong <xy-jackie@139.com>
In-Reply-To: <e45af10b-fa26-d7e4-8051-093a6f9ce552@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/25 18:07, Ilpo Järvinen wrote:
> On Tue, 8 Jul 2025, Jackie Dong wrote:
> 
>> Not all of Lenovo non-ThinkPad devices support both mic mute LED (on F4)
>> and audio mute LED (on F1). Some of them only support one mute LED, some
>> of them don't have any mute LED. Add a decision to judge this device
>> support mute LED or not. Without this decision, not support both of mic
>> mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
>> Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
>> with error -5.
>>
>> Signed-off-by: Jackie Dong <xy-jackie@139.com>
>> Suggested-by: Hans de Goede <hansg@kernel.org>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Hi Jackie,
> 
> Please don't add Reviewed-by nor Tested-by tags unless they were
> explicitly given to you.
>   
Hi Ilpo,
    I have deleted the Reviewed-by tag in next version patch.
>> ---
>> Changes in v3:
>>   - Reverse orignal logic  (obj && obj->type == ACPI_TYPE_INTEGER)
>>     and add new decision for led_version == 0.
>>   - Optimize the descriptions based on reviewer comments.
>>
>> Changes in v2:
>>   - Add warning message and then return 0 if the device support mute LED
>>     abnormaly, based on Hans suggestion and Armin previous patch.
>>
>>
>>   .../x86/lenovo-wmi-hotkey-utilities.c         | 24 ++++++++++++++-----
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> index 89153afd7015..1850992f2ea8 100644
>> --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> @@ -127,21 +127,30 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>>   	else
>>   		return -EIO;
> 
> The logic was not reversed as requested. Please change this code to:
> 
> 	union acpi_object *obj __free(kfree) = output.pointer;
> 	if (!obj || obj->type != ACPI_TYPE_INTEGER)
> 		return -EIO;
> 
> 	led_version = obj->integer.value;
> 
It's good suggestion, I'll update it.
>> -	wpriv->cdev[led_type].max_brightness = LED_ON;
>> -	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
>> +	/*
>> +	 * Output parameters define: 0 means mute LED is not supported, Non-zero means
>> +	 * mute LED can be supported.
>> +	 */
>> +	if (led_version == 0)
>> +		return 0;
>> +
>>   
>>   	switch (led_type) {
>>   	case MIC_MUTE:
>> -		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
>> -			return -EIO;
>> +		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
>> +			pr_warn("The MIC_MUTE LED of this device isn't supported now.\n");
> 
> Drop "now" (or change it to more precise explanation why).
> 
I have deleted the "now" in next version patch.
>> +			return 0;
>> +		}
>>   
>>   		wpriv->cdev[led_type].name = "platform::micmute";
>>   		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_micmute_led_set;
>>   		wpriv->cdev[led_type].default_trigger = "audio-micmute";
>>   		break;
>>   	case AUDIO_MUTE:
>> -		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
>> -			return -EIO;
>> +		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
>> +			pr_warn("The AUDIO_MUTE LED of this device isn't supported now.\n");
> 
> Ditto.
> 
I have deleted the "now" in next version patch.
>> +			return 0;
>> +		}
>>   
>>   		wpriv->cdev[led_type].name = "platform::mute";
>>   		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_audiomute_led_set;
>> @@ -152,6 +161,9 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>>   		return -EINVAL;
>>   	}
>>   
>> +	wpriv->cdev[led_type].max_brightness = LED_ON;
>> +	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
>> +
>>   	err = devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>>   	if (err < 0) {
>>   		dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
>>
> 
Thanks a lot,
Jackie



