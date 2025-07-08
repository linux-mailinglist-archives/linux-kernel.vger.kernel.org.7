Return-Path: <linux-kernel+bounces-721300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B781AFC751
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5301A4A827E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B7265CC2;
	Tue,  8 Jul 2025 09:45:23 +0000 (UTC)
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FA2652AE;
	Tue,  8 Jul 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967923; cv=none; b=rAy9QvWgGQ62GIXRf6s//Phn2i4pMHzS9HBpN0A+c6HJhAKzuzVqbhd47I9I+S5MQYECsIrUmv/dtPeL4c36a0ynCm3TS9hZoA72PhlPQWpJO8fPKiAdi219HCzyXS1D+yeUmWeG8YagHIZ+frCFunlhwt0isVTSap0I8czSYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967923; c=relaxed/simple;
	bh=7Bzsdwiz9ACgyuUWbq9kuVCzJIyu+RQIp7OnQ1IEHek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4YuiCTWAQbaxuotA6GjleE3PV7bYuzHwJW8idqJk60rXjgYUmWgAjGtIZbQZx6GtQbpUf5KUEkOI3P8TP4dlW1q/OYVDWNwW2bNeKiWEsF/0MVagf68wPA03GPBeq0ze3ew0yQ/Gz7FSdiwUXySVcic/JVSE3g0SLHqfDCtfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from [10.103.165.236] (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-45-12076 (RichMail) with SMTP id 2f2c686ce7e4d3e-c1a7a;
	Tue, 08 Jul 2025 17:41:59 +0800 (CST)
X-RM-TRANSID:2f2c686ce7e4d3e-c1a7a
Message-ID: <277b444e-5818-47ae-bf92-f31c25538572@139.com>
Date: Tue, 8 Jul 2025 17:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lenovo-wmi-hotkey: Fixed a kernel error report for
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
References: <20250708071138.15602-1-xy-jackie@139.com>
 <78394a09-6ca2-afc4-3b35-de4ea8e998cd@linux.intel.com>
Content-Language: en-US
From: Jackie Dong <xy-jackie@139.com>
In-Reply-To: <78394a09-6ca2-afc4-3b35-de4ea8e998cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,
    Thanks for your comments, I'll update it later.

    Jackie Dong
On 7/8/25 16:07, Ilpo Järvinen wrote:
> On Tue, 8 Jul 2025, Jackie Dong wrote:
> 
> Hi,
> 
> Shortlog in Subject seems incomplete
> 
>> Not all of Lenovo non-ThinkPad devices support both mic mute LED(on F4)
>> and audio mute LED(on F1). Some of them only support one mute LED, some
> 
> Add spaces after (
> 
>> of them don't have any mute LED. Add a decision to judge this device
>> support mute LED or not. Without this decision, not support both of mic
>> mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
>> Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
>> with error -5.
>>
>> Signed-off-by: Jackie Dong <xy-jackie@139.com>
>> Suggested-by: Hans de Goede <hansg@kernel.org>
>>
>> ---
>> Changes in v2:
>>   - Add warning message and then return 0 if the device support mute LED
>>     abnormaly, based on Hans suggestion and Armin previous patch.
>>
>>   .../x86/lenovo-wmi-hotkey-utilities.c         | 30 +++++++++++++------
>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> index 89153afd7015..334c12f2896d 100644
>> --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>> @@ -122,26 +122,35 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>>   		return -EIO;
>>   
>>   	union acpi_object *obj __free(kfree) = output.pointer;
>> -	if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> 
> Could you please reverse this logic and handle errors first.
> 
>>   		led_version = obj->integer.value;
>> -	else
>> -		return -EIO;
>>   
>> -	wpriv->cdev[led_type].max_brightness = LED_ON;
>> -	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
>> +		/*
>> +		 * Output parameters define: 0 means mute LED is not supported, Non-zero means
>> +		 * mute LED can be supported.
>> +		 */
>> +		if (led_version == 0)
>> +			return 0;
>> +	} else {
>> +		return -EIO;
>> +	}
>>   
>>   	switch (led_type) {
>>   	case MIC_MUTE:
>> -		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
>> -			return -EIO;
>> +		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
>> +			pr_warn("This device MIC_MUTE LED doesn't support now.\n");
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
>> +			pr_warn("This device AUDIO_MUTE LED doesn't support now.\n");
> 
> Both of these warnings have the same grammar flaws and need to be
> rephrased.
> 
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



