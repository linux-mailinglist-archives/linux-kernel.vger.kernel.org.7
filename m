Return-Path: <linux-kernel+bounces-850864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDFBD492E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 846EE507CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973A313285;
	Mon, 13 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpR+g3ts"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196830B509
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368684; cv=none; b=IjgZhgGV6Kg0P7AzOGpR5iXJopJhN46benylBZp13ThzyxxY2jQhUlBbyTTq1LkZ4AOpDKFrFmGXEaUohP7+mTndAB/f9jliCdv9z8ZpzJZD3qjvtFfjurQfcdNqESIGmMjhhD1ETxMtoXkLPaCdwT1/3zM43gKD4AMqDDS69+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368684; c=relaxed/simple;
	bh=GKDt9Cy63SIH0ydSh05e90s42lYzKQxYbaamFtHh6x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AD5UBAHXhwZCbHAVuR3AmLYZrnIdmIN7USViB04skNrEUDyNTM9LuQr/xpGvtTXE+8LAG8/xqYlBiI2HuZh36JjyPYihw4mRWuwjbzbKjN+YB0CyacnIV4/X82iWOCjGN8MYXcn3hJqklDn6WzQrdMgk+pUcM2bNoaH/Oihazx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpR+g3ts; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7b4f7a856acso1654545a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368681; x=1760973481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRyxDCkcYD7AvR0IsDzdq/NHUyHn7rIuXPCX9S/Pl6E=;
        b=EpR+g3tsdENA9yvs9plnwyEliJFztQftLgwzISa3eAlu+amrvJWui/jVXf+1lgfH+T
         gXHuBQCZyYg0lWIfkeGmGYDUfcO2KZ9mq9GgCx3FcLL7deIQMcDc1yMn2moXmi2ceEIH
         jZ87iKlfBiXJFSdpNiLQeORq6yvHv05ADrYLAbSFQpSBZi61PoD0fvvAkxxu+56PSxhY
         YdbaDM2Xztp08rfQFmHTaz27cnE+aXO1Q4Avv5Nxp3ql+8tI0T9QI1SCysV6dnDxWzjd
         CzHXBT/xcs8kZ1FvuzKvM+f5X/08IJ1elexW2ACJweXcEbHv1DS+K00NHrtigGrJ4Kkw
         h8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368681; x=1760973481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRyxDCkcYD7AvR0IsDzdq/NHUyHn7rIuXPCX9S/Pl6E=;
        b=kPr/z+OrA3zsh6JxPemdQMI//z096fX5MzwpGIYA4AloiFkUd3qEMhymWOO8mzgodQ
         qqL9toVT4yudA9i+Uxwt/10yTYwSZ9FSNx4L7yfT+hDbTGLJ9O9DeRLvBKfFgsf1fhaR
         YMIjXkx17AuRj1xfuwtU0uO/Re8eh/w8/qXVPfB5MtzrqeGxXhjSFEkq8ZPwiWzyG+aQ
         D8Fo5Gcd5hpohWd6d3dU+isW1KjX/Ty03dITwvAZtDKujYeLPxe2MNoYuUnBsKQ1lGBb
         gdntaD3E3CL7tNFOQLt1SND2ZFputb+dlCyLxTi7zURfWVr1TChR+XASeaS1dF5RV73y
         EzOw==
X-Forwarded-Encrypted: i=1; AJvYcCW0/Dz+eiVt4dbcg333+/pTrK3DsvF55FOabC9oQDktHk8tbJOItlGDPQWnzBTgPpodX7Eb5TCeajGsATE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uY2EbO5QRbl68UFxWjNN49vh6t3fePHENoHnrv2vlSBoA7uc
	npQf90Ub1EPSxea2iE4KQtO7jfxYPJxGS/bGkLCPwbDEiC4LEPpTa6pQ
X-Gm-Gg: ASbGnctSy62pcseo33gJzZlQEy9ZrdIua5vew0eZElWVy49SM1GW1PYqBbO0HDyxrNR
	CUjFriSJ/bvCoeudcp7TmoMiiYYD58ans4iABhtzg8eD+eUecvxj1TK7HAgwb0pkXwO6u+A7CzP
	KH6SlmvBLQp+RWvZsh7GbA5HpDOKrTXi+E4b58+luatwj+jMvwwmcEAYUkZFFSL1NuOaNPjZLVI
	YGKDBdQ1RGDiGcH3Af1hdWduqXCITuWqTn8/1l+JNX6tPZ/v2CInYJj3pP9Gtaew5dIfw9h2uJd
	8xOvPTN4aPcVHLxDPTzA3X9wCWA8gN+Gg4AI3ms8wAfWhXqUBKe63D61C1UFlveOJ0wEFkPGUWM
	lZ6KDUxIMIQCOaIJqJKRFW8q8DcRWDmICXEy8QPi0vU3M8nQxZQ4U03L8dwRc
X-Google-Smtp-Source: AGHT+IEkrznDh4+3D54wepyKCf/cc4wUix4O6ndVbxKTC1xPd3qKc/8TLhlu/0Z+mNUdZL8/GbbEig==
X-Received: by 2002:a05:6808:1903:b0:438:8c9:5f4 with SMTP id 5614622812f47-4417b2f4fa7mr9071701b6e.19.1760368681028;
        Mon, 13 Oct 2025 08:18:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1010? ([2603:8081:c640:1::1010])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441987494ccsm2530511b6e.0.2025.10.13.08.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:18:00 -0700 (PDT)
Message-ID: <0f4b8ddc-489b-49c4-b1f6-44fd6492c310@gmail.com>
Date: Mon, 13 Oct 2025 10:17:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Enable clean shutdown for root partition with
 MSHV
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 anbelski@linux.microsoft.com
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <20251009160501.6356-3-prapal@linux.microsoft.com>
 <f0291b64-693c-49f4-bc71-d260a670e636@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <f0291b64-693c-49f4-bc71-d260a670e636@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2025 12:30 PM, Easwar Hariharan wrote:
> On 10/9/2025 8:58 AM, Praveen K Paladugu wrote:
>> This commit enables the root partition to perform a clean shutdown when
>> running with MSHV hypervisor.
> 
> No "This commit..." please
> 
>>
>> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
>> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c      |   7 ++
>>   drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
>>   include/asm-generic/mshyperv.h |   1 +
>>   3 files changed, 126 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index afdbda2dd7b7..57bd96671ead 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -510,6 +510,13 @@ void __init hyperv_init(void)
>>   		memunmap(src);
>>   
>>   		hv_remap_tsc_clocksource();
>> +		/*
>> +		 * The notifier registration might fail at various hops.
>> +		 * Corresponding error messages will land in dmesg. There is
>> +		 * otherwise nothing that can be specifically done to handle
>> +		 * failures here.
>> +		 */
>> +		(void)hv_sleep_notifiers_register();
>>   	} else {
>>   		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>>   		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index e109a620c83f..c5165deb5278 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -837,3 +837,121 @@ const char *hv_result_to_string(u64 status)
>>   	return "Unknown";
>>   }
>>   EXPORT_SYMBOL_GPL(hv_result_to_string);
>> +
>> +/*
>> + * Corresponding sleep states have to be initialized, in order for a subsequent
>> + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
>> + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
>> + *
>> + * ACPI should be initialized and should support S5 sleep state when this method
>> + * is called, so that, it can extract correct PM values and pass them to hv.
> 
> Nit: No need for this   ^ comma, i.e. "...when this method is called, so that it can..."
> 
>> + */
>> +static int hv_initialize_sleep_states(void)
>> +{
>> +	u64 status;
>> +	unsigned long flags;
>> +	struct hv_input_set_system_property *in;
>> +	acpi_status acpi_status;
>> +	u8 sleep_type_a, sleep_type_b;
>> +
>> +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
>> +		pr_err("%s: S5 sleep state not supported.\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5,
>> +						&sleep_type_a, &sleep_type_b);
>> +	if (ACPI_FAILURE(acpi_status))
>> +		return -ENODEV;
>> +
>> +	local_irq_save(flags);
>> +	in = (struct hv_input_set_system_property *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
> 
> Other users don't have these casts, why is it necessary here?
> I didn't really need these casts. I will drop them in the next version.
>> +
>> +	in->property_id = HV_SYSTEM_PROPERTY_SLEEP_STATE;
>> +	in->set_sleep_state_info.sleep_state = HV_SLEEP_STATE_S5;
>> +	in->set_sleep_state_info.pm1a_slp_typ = sleep_type_a;
>> +	in->set_sleep_state_info.pm1b_slp_typ = sleep_type_b;
>> +
>> +	status = hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
>> +	local_irq_restore(flags);
>> +
>> +	if (!hv_result_success(status)) {
>> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
>> +		return hv_result_to_errno(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hv_call_enter_sleep_state(u32 sleep_state)
>> +{
>> +	u64 status;
>> +	int ret;
>> +	unsigned long flags;
>> +	struct hv_input_enter_sleep_state *in;
>> +
>> +	ret = hv_initialize_sleep_states();
>> +	if (ret)
>> +		return ret;
>> +
>> +	local_irq_save(flags);
>> +	in = (struct hv_input_enter_sleep_state *)
>> +			(*this_cpu_ptr(hyperv_pcpu_input_arg));
>> +	in->sleep_state = (enum hv_sleep_state)sleep_state;
>> +
> 
> More casts...
> 
>> +	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
>> +	local_irq_restore(flags);
>> +
>> +	if (!hv_result_success(status)) {
>> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
>> +		return hv_result_to_errno(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hv_reboot_notifier_handler(struct notifier_block *this,
>> +				      unsigned long code, void *another)
>> +{
>> +	int ret = 0;
>> +
>> +	if (SYS_HALT == code || SYS_POWER_OFF == code)
> 
> Usually the variable is on the left of the comparison with the constant
> 
>> +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
>> +
>> +	return ret ? NOTIFY_DONE : NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block hv_reboot_notifier = {
>> +	.notifier_call  = hv_reboot_notifier_handler,
>> +};
>> +
>> +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_cnt)
>> +{
>> +	int ret = 0;
>> +
>> +	if (sleep_state == ACPI_STATE_S5)
>> +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
>> +
>> +	return ret == 0 ? 1 : -1;
>> +}
>> +
>> +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32 val_b)
>> +{
>> +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
>> +}
>> +
>> +int hv_sleep_notifiers_register(void)
>> +{
>> +	int ret;
>> +
>> +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
>> +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
>> +
>> +	ret = register_reboot_notifier(&hv_reboot_notifier);
>> +	if (ret)
>> +		pr_err("%s: cannot register reboot notifier %d\n",
>> +			__func__, ret);
>> +
>> +	return ret;
>> +}
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 64ba6bc807d9..903d089aba82 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -339,6 +339,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
>>   void hyperv_cleanup(void);
>>   bool hv_query_ext_cap(u64 cap_query);
>>   void hv_setup_dma_ops(struct device *dev, bool coherent);
>> +int hv_sleep_notifiers_register(void);

> 
> Does this still work when CONFIG_HYPERV = n, i.e. do we need a stub below? Also, this looks
> like it's only implemented for x86, so perhaps this declaration should be in arch/x86/include/asm/mshyperv.h
> instead of asm-generic?
As this sleep state data is configured using hypercalls, this code
does not work with CONFIG_HYPERV=n. I will investigate the correct 
header to use here and report back.

> 
>>   #else /* CONFIG_HYPERV */
>>   static inline void hv_identify_partition_type(void) {}
>>   static inline bool hv_is_hyperv_initialized(void) { return false; }
> 
> 
Thanks for the feedback. I will address all the nits along with above 
comments in next update.
-- 
Regards,
Praveen K Paladugu

