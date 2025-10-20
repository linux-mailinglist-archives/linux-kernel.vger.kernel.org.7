Return-Path: <linux-kernel+bounces-861536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1534BF2FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60BC54E887C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7E1C3314;
	Mon, 20 Oct 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUAn9MlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B004414;
	Mon, 20 Oct 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985943; cv=none; b=ROvHPalKoEF2Ma39+3w6S6/ooGPtoTrC79vWg2fQfpT0LkSIVDzA76hN/nv8PUYJYqgspbuFYKAwY6FII0FRcX6KFiJOkJdyO8uz2wMR+tXFneI9p0mZb8C/ublYJff1Ga8mFybrLNT/Pl1M1o6OstIeNAgICZdvv4XusSua1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985943; c=relaxed/simple;
	bh=PlJqYRapyM/Po8fRrY46JKCp2CnjNetyMEFPB9qIBNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/s3e5I+9lNX7hGM8F/xpjPZAVjRxkj78kF0dLcMNHqqteRTtTdne7reI4D+FiQFfh4aoPXZDFEIYExLsdSk/0Kt5kUGTehNE84/JD+dCuu56wEPSEqK2tH0UqzF6BgpxBLBflzlazW9+jJPh59yPf5bqe0lQrtuLoxruURRot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUAn9MlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3741CC113D0;
	Mon, 20 Oct 2025 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760985943;
	bh=PlJqYRapyM/Po8fRrY46JKCp2CnjNetyMEFPB9qIBNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tUAn9MlYM5ISpQZIIBt+LDQhlqjD/furu07rLhUFStas0k9duBtsIVFtTF/kUJ/qX
	 dlyu6e/bFTo1ihjHBpkeFl6zHQD1DRyyiFkQEuDqXRouFlzAL02FYZ6+5a6eTubhhw
	 LPevXZOYsKG1w7IPMg11I9QdcfKBErBkyXJElAUhMgcJLAb/Y7TIzO/mOqbUeXS9wr
	 EkkrIWTPzJOJHEDw38hQmeZBr80dozToeoYUUO+ml6KGce23k3O4DbCQu/9PGG0pcP
	 HQKlTsXXpjW3m6jfyOXPH6X+WgguLIhwU+EZi7eeazM2QZ/WcmQP2yeS//BZToZQik
	 v7kiSr6vGiF8w==
Message-ID: <4578af8b-848a-43a3-8091-d038202edfa3@kernel.org>
Date: Mon, 20 Oct 2025 13:45:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/9] platform/x86: asus-armoury: add core count
 control
To: Denis Benato <benato.denis96@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, "Luke D . Jones"
 <luke@ljones.dev>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
 <20251015014736.1402045-6-benato.denis96@gmail.com>
 <25bd0c90-2de0-ef66-c18d-661180b71fd4@linux.intel.com>
 <13b9890e-d1b7-446a-9e93-2034c60a0a88@gmail.com>
 <f3a69b7e-a698-2dd5-731a-f7db0eabd8f3@linux.intel.com>
 <c5952867-c38d-49cf-922f-0bb03b956348@gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <c5952867-c38d-49cf-922f-0bb03b956348@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 12:37 PM, Denis Benato wrote:
> 
> On 10/20/25 19:15, Ilpo Järvinen wrote:
>> On Sat, 18 Oct 2025, Denis Benato wrote:
>>> On 10/17/25 14:48, Ilpo Järvinen wrote:
>>>> On Wed, 15 Oct 2025, Denis Benato wrote:
>>>>
>>>>> From: "Luke D. Jones" <luke@ljones.dev>
>>>>>
>>>>> Implement Intel core enablement under the asus-armoury module using the
>>>>> fw_attributes class.
>>>>>
>>>>> This allows users to enable or disable preformance or efficiency cores
>>>>> depending on their requirements. After change a reboot is required.
>>>>>
>>>>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>> ---
>>>>>   drivers/platform/x86/asus-armoury.c        | 258 ++++++++++++++++++++-
>>>>>   drivers/platform/x86/asus-armoury.h        |  28 +++
>>>>>   include/linux/platform_data/x86/asus-wmi.h |   5 +
>>>>>   3 files changed, 290 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>>>>> index 3b49a27e397d..3d963025d84e 100644
>>>>> --- a/drivers/platform/x86/asus-armoury.c
>>>>> +++ b/drivers/platform/x86/asus-armoury.c
>>>>> +static ssize_t cores_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf,
>>>>> +				enum cpu_core_type core_type, enum cpu_core_value core_value)
>>>>> +{
>>>>> +	u32 cores;
>>>>> +
>>>>> +	switch (core_value) {
>>>>> +	case CPU_CORE_DEFAULT:
>>>>> +	case CPU_CORE_MAX:
>>>>> +		if (core_type == CPU_CORE_PERF)
>>>>> +			return sysfs_emit(buf, "%u\n",
>>>>> +					  asus_armoury.cpu_cores->max_perf_cores);
>>>>> +		else
>>>>> +			return sysfs_emit(buf, "%u\n",
>>>>> +					  asus_armoury.cpu_cores->max_power_cores);
>>>>> +	case CPU_CORE_MIN:
>>>>> +		if (core_type == CPU_CORE_PERF)
>>>>> +			return sysfs_emit(buf, "%u\n",
>>>>> +					  asus_armoury.cpu_cores->min_perf_cores);
>>>>> +		else
>>>>> +			return sysfs_emit(buf, "%u\n",
>>>>> +					  asus_armoury.cpu_cores->min_power_cores);
>>>>> +	default:
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	if (core_type == CPU_CORE_PERF)
>>>>> +		cores = asus_armoury.cpu_cores->cur_perf_cores;
>>>>> +	else
>>>>> +		cores = asus_armoury.cpu_cores->cur_power_cores;
>>>> Why isn't this inside the switch?? The logic in this function looks very
>>>> mixed up.
>>>>
>>>> If I'd be you, I'd consider converting the asus_armoury.cpu_cores to a
>>>> multi-dimensional array. It would make this just bounds checks and one
>>>> line to get the data.
>>> Please note that this interface has the potential to brick in an irreversible
>>> way laptops and it has happened.
>> This function only prints values held by kernel in its internal storage?
>> How can that brick something?
>>
>>> Of all the code CPU core handling it the most delicate code of all since
>>> a wrong value here means permanent irreversible damage.
>>>
>>> I am more than happy making changes that can be easily verified,
>>> but others more complex changes will put (at least) my own hardware
>>> at risk.
>> Understood.
>>
>>> If you think benefit outweighs risks I will try my best.
>>>>> +	return sysfs_emit(buf, "%u\n", cores);
>>>>> +}
>>>>> +
>>>>> +static ssize_t cores_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
>>>>> +					 const char *buf, enum cpu_core_type core_type)
>>>>> +{
>>>>> +	u32 new_cores, perf_cores, power_cores, out_val, min, max;
>>>>> +	int result, err;
>>>>> +
>>>>> +	result = kstrtou32(buf, 10, &new_cores);
>>>>> +	if (result)
>>>>> +		return result;
>>>>> +
>>>>> +	scoped_guard(mutex, &asus_armoury.cpu_core_mutex) {
>>>>> +		if (core_type == CPU_CORE_PERF) {
>>>>> +			perf_cores = new_cores;
>>>>> +			power_cores = asus_armoury.cpu_cores->cur_power_cores;
>>>>> +			min = asus_armoury.cpu_cores->min_perf_cores;
>>>>> +			max = asus_armoury.cpu_cores->max_perf_cores;
>>>>> +		} else {
>>>>> +			perf_cores = asus_armoury.cpu_cores->cur_perf_cores;
>>>>> +			power_cores = new_cores;
>>>>> +			min = asus_armoury.cpu_cores->min_power_cores;
>>>>> +			max = asus_armoury.cpu_cores->max_power_cores;
>>>>> +		}
>>>>> +
>>>>> +		if (new_cores < min || new_cores > max)
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		out_val = FIELD_PREP(ASUS_PERF_CORE_MASK, perf_cores) |
>>>>> +			FIELD_PREP(ASUS_POWER_CORE_MASK, power_cores);
>>>>> +
>>>>> +		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, out_val, &result);
>>>>> +		if (err) {
>>>>> +			pr_warn("Failed to set CPU core count: %d\n", err);
>>>>> +			return err;
>>>>> +		}
>>>>> +
>>>>> +		if (result > 1) {
>>>>> +			pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
>>>>> +			return -EIO;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	pr_info("CPU core count changed, reboot required\n");
>>>> This interface has a problematic behavior. If user wants to adjust both
>>>> core counts one after another (without reboot in between), the new value
>>>> of the first core count will be overwritten on the second store.
>>>>
>>>> You might have to store also the value that will be used after the next
>>>> boot to solve it but how the divergence should be presented to user is
>>>> another question to which I don't have a good answer.
>>> Given what I have written above I am thinking more along the lines of allowing
>>> only one change at the time, giving absolute priority to the ability to demonstrate
>>> not all P-cores can be disabled all at once, or after a reboot hardware will be
>>> irreversibly lost. It cannot be recovered the same way as I did with APU mem.
>>>
>>> To summarize I am more inclined in allowing only small changes,
>>> or to postpone this patch entirely while we think to a better, safer solution.
>> Fair enough, please mention this as in the changelog as a justification
>> and to warn other messing with the code.
>>
>>>> This seems a more general problem, that is, how to represent values which
>>>> are only enacted after booting (current vs to-be-current) as it doesn't
>>>> fit to the current, min, max, possible_values, type model.
>>>>
>>> Enabling eGPU on a laptop with a dGPU that is active makes the PCI-e
>>> spam PCI AER uncorrectable errors and renders both GPUs unusable.
>>>
>>> I have gone with storing the value at driver load time and treating it
>>> as the boot value for 2/9 (eGPU), but I am very open to suggestions!
>> I'm not entirely sure what you're trying to say here. My point is that
>> there's no way for user to know what value something will be changed to
>> (the "to-be-current" value) except through rebooting the system (when the
>> "to-be-current" value becomes the "current").
>>
> Users do know what the value will be changed to because that is what the
> WMI interface will tell: the issue is in reverse (knowing what settings were
> applied when booting the laptop): one has to infer those looking at
> the current state of things.
> 
> For example it is only possible to know if the next boot will have
> sound or not, not if a sound was emitted at the current boot.
> 
> I haven't seen examples of devstates not returning the future value,
> but I do have seen my ally returning dGPU property presence when
> there is no dGPU in it and it appears to be a no-op, so I had to remove
> (or rather avoid adding) a safeguard against possible PCI bus conflicts
> that I had planned.
> 
> Thanks,
> 
> Denis
> 

There is a concept in the firmware attributes spec 
(sysfs-class-firmware-attributes) for "pending_reboot".

I think setting this to 1 should indicate there are changes that will 
happen on next boot.

