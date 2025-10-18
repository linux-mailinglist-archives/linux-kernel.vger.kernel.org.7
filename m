Return-Path: <linux-kernel+bounces-858919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E2BEC3E9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05C23352BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920C1E834B;
	Sat, 18 Oct 2025 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbbj4hKM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E0944F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751792; cv=none; b=aPsXE7mngXA5V+aDASZlnd0i7z2lfLz9TvkAMT/ORBOMKvwnzzgByO5FPO24B2Z9mG1H096WMd6PJtJmDyDCbBxBGSXqjyuuNJSHJdyU3E5hwHH6lC6IVhF8dzrdyXTX7xdqR5oC3XwJYXHQ7W6Db25Vp/sSBR4ZX9P+UyhdTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751792; c=relaxed/simple;
	bh=syXUxWhpiJS+fbE8Dy7jGY7/HuW7NxS9dcKIYWk/5dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQWPt2K6finyua7KXxaRFXi0C/Ywyd6hdhmau0Cc4B+jEyIDM383vwYxjMP/Llr3m4KSW373BjYGPhXq80bRvxd09wQsjhcwIAwNi3kco+25Xx87r9pLddA/Cm27INp6mZZkhZayLUse6YViQSKPmz/FlizOCbK2qMNruRkk6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zbbj4hKM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426edfffc66so1755380f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760751789; x=1761356589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkK7fg3TaAX+NpuxYcFhvZFhV9LFdLAGaBVLIazmrZ8=;
        b=Zbbj4hKMtruTyvejJfZh2stkzESaGpLae8be/qnkcgbOV4AXJQcFbln70eomuRkpVb
         9aYYJcO4NYXYSaM4dsj34aG6CXfs6WDu9lKfje7p2O+4Ooig/+APk28ce0npLomOPJR3
         UzgKuZP/h1QiHKc86vzkqhuhxC2UlccGMbaQ7QI3Z4QhZ5zMj1biiX5eaBA6xRSRvq4D
         oIxa1dWa7y/7i9JiTFEZx1gqJVS4F4PdeDXtxmW2ngp5izzbMbKy4HR7Cx7IkD9CoEwd
         OCPS/J5mEWbmY8fX36LhrLTtSyFbxY7dBO1LMElGgSdrUYN2SNLWWJKmfGhAUR5EbbGq
         09TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751789; x=1761356589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkK7fg3TaAX+NpuxYcFhvZFhV9LFdLAGaBVLIazmrZ8=;
        b=J3kPrkAuAYyjqzZS2bOWYjQ1Mi+W5HtnS5raH/QSKF297+Po5XaDrz5T+fUc4tWA44
         YhrDgU5OoBD0ox2a4sJ+HdY/Psnux9VvxzHErnXXwe+VYZ72E9nP3B/RKNnqkrBpOvJE
         8+ny38q6idBNealp6sYLQGAKwGZH92agtduDt66dQwrqd9PnDXgjy74J1MVf3RHX6VqD
         YL+wTkj8KcGHjKf0XIhk/LDwitRAQSH3IdWLK5JxiXP902K5ufnBD53D8GFrIQUQgtGa
         p7NhgUpDFf/elnfaK13d9tceA6CUzAk+KpC3YVsR36O8xPNZFhtzYQ3lWe/KvwJzc/eH
         /eKQ==
X-Gm-Message-State: AOJu0YzFJDuqVdmirr4y2l9gpR/yYW2IY0r68xLWHWl8jnSwKkZ5pIH0
	R2Cf0c8h4gvVvZgjnQP972YMPOXrD9yJDIGWDyOvvdNkIUnRav5jcVJ/
X-Gm-Gg: ASbGncvF1SZ4R0gxrIcND3agpP99Z2ZH5iDVn4845Ay4ndJPP2VnlmXhjuTCzBa/YEF
	3X0f4Vp9pxohaMwfzvqLoW2VwHKsW2cjSwbrHDBNsJo+dTsfOuxr1tEQMOnppyz52wbyjS1/nRz
	0H0b9oDcIQOHrLN8xMQ1yveJcpmkWVw9YqzEgE02v+Q0giJHOQWUOEmZQdrw1+cDjF36wznwU/V
	6jtI4drgZo+o/Y3JrCoccu1NbaBN7ni5zWWykNGK4oKriYaOE85BJEvhTuoVgkwXJunDeKMc6Wn
	PCggSqKJnSV6wficPI8cCMU0VvI00FWBACZ3PeT5YXFfDDYgEvEqAkAt+uJDpgfMnL2D+9nE84n
	VJOtO/RuuRH0qbr+Hvy9dcTi/b1mMejkb3euPcv6clUHDp8B/U8ddSef2ZVNVr3vtGc40LMRUE1
	23wza3cLxSkCILYKvujeAnwWUC
X-Google-Smtp-Source: AGHT+IHuH6fQMAEdH1NxkeNjbbh6ZTtUtZJBeMXhiy4ooutEbp8s5FpNEo5al17EmcWhgmL49xeliQ==
X-Received: by 2002:a05:6000:2308:b0:426:da92:d39d with SMTP id ffacd0b85a97d-42704beea3fmr4154728f8f.24.1760751788737;
        Fri, 17 Oct 2025 18:43:08 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bab52sm2173269f8f.22.2025.10.17.18.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 18:43:08 -0700 (PDT)
Message-ID: <13b9890e-d1b7-446a-9e93-2034c60a0a88@gmail.com>
Date: Sat, 18 Oct 2025 03:43:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/9] platform/x86: asus-armoury: add core count
 control
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, "Luke D . Jones" <luke@ljones.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
 <20251015014736.1402045-6-benato.denis96@gmail.com>
 <25bd0c90-2de0-ef66-c18d-661180b71fd4@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <25bd0c90-2de0-ef66-c18d-661180b71fd4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/17/25 14:48, Ilpo Järvinen wrote:
> On Wed, 15 Oct 2025, Denis Benato wrote:
>
>> From: "Luke D. Jones" <luke@ljones.dev>
>>
>> Implement Intel core enablement under the asus-armoury module using the
>> fw_attributes class.
>>
>> This allows users to enable or disable preformance or efficiency cores
>> depending on their requirements. After change a reboot is required.
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/asus-armoury.c        | 258 ++++++++++++++++++++-
>>  drivers/platform/x86/asus-armoury.h        |  28 +++
>>  include/linux/platform_data/x86/asus-wmi.h |   5 +
>>  3 files changed, 290 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>> index 3b49a27e397d..3d963025d84e 100644
>> --- a/drivers/platform/x86/asus-armoury.c
>> +++ b/drivers/platform/x86/asus-armoury.c
>> @@ -45,13 +45,49 @@
>>  #define ASUS_MINI_LED_2024_STRONG 0x01
>>  #define ASUS_MINI_LED_2024_OFF    0x02
>>  
>> +#define ASUS_POWER_CORE_MASK	GENMASK(15, 8)
>> +#define ASUS_PERF_CORE_MASK		GENMASK(7, 0)
>> +
>> +enum cpu_core_type {
>> +	CPU_CORE_PERF = 0,
>> +	CPU_CORE_POWER,
>> +};
>> +
>> +enum cpu_core_value {
>> +	CPU_CORE_DEFAULT = 0,
> This could be mapped in the sysfs _show function as there's no real 
> backing value for it.
>
>> +	CPU_CORE_MIN,
>> +	CPU_CORE_MAX,
>> +	CPU_CORE_CURRENT,
>> +};
>> +
>> +#define CPU_PERF_CORE_COUNT_MIN 4
>> +#define CPU_POWR_CORE_COUNT_MIN 0
>> +
>> +/* Tunables provided by ASUS for gaming laptops */
>> +struct cpu_cores {
>> +	u32 cur_perf_cores;
>> +	u32 min_perf_cores;
>> +	u32 max_perf_cores;
>> +	u32 cur_power_cores;
>> +	u32 min_power_cores;
>> +	u32 max_power_cores;
>> +};
>> +
>>  static struct asus_armoury_priv {
>>  	struct device *fw_attr_dev;
>>  	struct kset *fw_attr_kset;
>>  
>> +	struct cpu_cores *cpu_cores;
>>  	u32 mini_led_dev_id;
>>  	u32 gpu_mux_dev_id;
>> -} asus_armoury;
>> +	/*
>> +	 * Mutex to prevent big/little core count changes writing to same
>> +	 * endpoint at the same time. Must lock during attr store.
>> +	 */
>> +	struct mutex cpu_core_mutex;
>> +} asus_armoury = {
>> +	.cpu_core_mutex = __MUTEX_INITIALIZER(asus_armoury.cpu_core_mutex)
>> +};
>>  
>>  struct fw_attrs_group {
>>  	bool pending_reboot;
>> @@ -93,6 +129,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
>>  static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
>>  {
>>  	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
>> +	       !strcmp(attr->attr.name, "cores_performance") ||
>> +	       !strcmp(attr->attr.name, "cores_efficiency") ||
>>  	       !strcmp(attr->attr.name, "panel_hd_mode");
>>  }
>>  
>> @@ -171,6 +209,12 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>>  	return sysfs_emit(buf, "enumeration\n");
>>  }
>>  
>> +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +			     char *buf)
>> +{
>> +	return sysfs_emit(buf, "integer\n");
>> +}
>> +
>>  /* Mini-LED mode **************************************************************/
>>  static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
>>  						struct kobj_attribute *attr, char *buf)
>> @@ -474,6 +518,207 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_at
>>  }
>>  ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
>>  
>> +static int init_max_cpu_cores(void)
>> +{
>> +	u32 cores;
>> +	int err;
>> +
>> +	asus_armoury.cpu_cores = kzalloc(sizeof(struct cpu_cores), GFP_KERNEL);
>> +	if (!asus_armoury.cpu_cores)
>> +		return -ENOMEM;
>> +
>> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
>> +	if (err)
>> +		return err;
>> +
>> +	if ((cores & ASUS_WMI_DSTS_PRESENCE_BIT) == 0) {
>> +		pr_err("ACPI does not support CPU core count control\n");
>> +		err = -ENODEV;
>> +		goto init_max_cpu_cores_err;
> Please use __free() and return immediately.
>
> Only assign from local variable to asus_armoury.cpu_cores with 
> no_free_ptr() at the end.
>
>> +	}
>> +
>> +	asus_armoury.cpu_cores->max_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
>> +	asus_armoury.cpu_cores->max_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
>> +
>> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
>> +	if (err) {
>> +		pr_err("Could not get CPU core count: error %d\n", err);
>> +		goto init_max_cpu_cores_err;
>> +	}
>> +
>> +	asus_armoury.cpu_cores->cur_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
>> +	asus_armoury.cpu_cores->cur_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
>> +
>> +	asus_armoury.cpu_cores->min_perf_cores = CPU_PERF_CORE_COUNT_MIN;
>> +	asus_armoury.cpu_cores->min_power_cores = CPU_POWR_CORE_COUNT_MIN;
> Should these be bounds checked with max?
>
>> +	return 0;
>> +
>> +init_max_cpu_cores_err:
>> +	kfree(asus_armoury.cpu_cores);
>> +	return err;
>> +}
>> +
>> +static ssize_t cores_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf,
>> +				enum cpu_core_type core_type, enum cpu_core_value core_value)
>> +{
>> +	u32 cores;
>> +
>> +	switch (core_value) {
>> +	case CPU_CORE_DEFAULT:
>> +	case CPU_CORE_MAX:
>> +		if (core_type == CPU_CORE_PERF)
>> +			return sysfs_emit(buf, "%u\n",
>> +					  asus_armoury.cpu_cores->max_perf_cores);
>> +		else
>> +			return sysfs_emit(buf, "%u\n",
>> +					  asus_armoury.cpu_cores->max_power_cores);
>> +	case CPU_CORE_MIN:
>> +		if (core_type == CPU_CORE_PERF)
>> +			return sysfs_emit(buf, "%u\n",
>> +					  asus_armoury.cpu_cores->min_perf_cores);
>> +		else
>> +			return sysfs_emit(buf, "%u\n",
>> +					  asus_armoury.cpu_cores->min_power_cores);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (core_type == CPU_CORE_PERF)
>> +		cores = asus_armoury.cpu_cores->cur_perf_cores;
>> +	else
>> +		cores = asus_armoury.cpu_cores->cur_power_cores;
> Why isn't this inside the switch?? The logic in this function looks very 
> mixed up.
>
> If I'd be you, I'd consider converting the asus_armoury.cpu_cores to a 
> multi-dimensional array. It would make this just bounds checks and one 
> line to get the data.
Please note that this interface has the potential to brick in an irreversible
way laptops and it has happened.

Of all the code CPU core handling it the most delicate code of all since
a wrong value here means permanent irreversible damage.

I am more than happy making changes that can be easily verified,
but others more complex changes will put (at least) my own hardware
at risk.

If you think benefit outweighs risks I will try my best.
>> +	return sysfs_emit(buf, "%u\n", cores);
>> +}
>> +
>> +static ssize_t cores_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
>> +					 const char *buf, enum cpu_core_type core_type)
>> +{
>> +	u32 new_cores, perf_cores, power_cores, out_val, min, max;
>> +	int result, err;
>> +
>> +	result = kstrtou32(buf, 10, &new_cores);
>> +	if (result)
>> +		return result;
>> +
>> +	scoped_guard(mutex, &asus_armoury.cpu_core_mutex) {
>> +		if (core_type == CPU_CORE_PERF) {
>> +			perf_cores = new_cores;
>> +			power_cores = asus_armoury.cpu_cores->cur_power_cores;
>> +			min = asus_armoury.cpu_cores->min_perf_cores;
>> +			max = asus_armoury.cpu_cores->max_perf_cores;
>> +		} else {
>> +			perf_cores = asus_armoury.cpu_cores->cur_perf_cores;
>> +			power_cores = new_cores;
>> +			min = asus_armoury.cpu_cores->min_power_cores;
>> +			max = asus_armoury.cpu_cores->max_power_cores;
>> +		}
>> +
>> +		if (new_cores < min || new_cores > max)
>> +			return -EINVAL;
>> +
>> +		out_val = FIELD_PREP(ASUS_PERF_CORE_MASK, perf_cores) |
>> +			FIELD_PREP(ASUS_POWER_CORE_MASK, power_cores);
>> +
>> +		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, out_val, &result);
>> +		if (err) {
>> +			pr_warn("Failed to set CPU core count: %d\n", err);
>> +			return err;
>> +		}
>> +
>> +		if (result > 1) {
>> +			pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
>> +			return -EIO;
>> +		}
>> +	}
>> +
>> +	pr_info("CPU core count changed, reboot required\n");
> This interface has a problematic behavior. If user wants to adjust both 
> core counts one after another (without reboot in between), the new value 
> of the first core count will be overwritten on the second store.
>
> You might have to store also the value that will be used after the next 
> boot to solve it but how the divergence should be presented to user is 
> another question to which I don't have a good answer.
Given what I have written above I am thinking more along the lines of allowing
only one change at the time, giving absolute priority to the ability to demonstrate
not all P-cores can be disabled all at once, or after a reboot hardware will be
irreversibly lost. It cannot be recovered the same way as I did with APU mem.

To summarize I am more inclined in allowing only small changes,
or to postpone this patch entirely while we think to a better, safer solution.
> This seems a more general problem, that is, how to represent values which 
> are only enacted after booting (current vs to-be-current) as it doesn't 
> fit to the current, min, max, possible_values, type model.
>
Enabling eGPU on a laptop with a dGPU that is active makes the PCI-e
spam PCI AER uncorrectable errors and renders both GPUs unusable.

I have gone with storing the value at driver load time and treating it
as the boot value for 2/9 (eGPU), but I am very open to suggestions!

Thanks for your time,
Denis

