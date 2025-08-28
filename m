Return-Path: <linux-kernel+bounces-789851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2BB39B87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993DB7B7457
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85230E82B;
	Thu, 28 Aug 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbAvnjVq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54630E0C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380464; cv=none; b=qotERBIlJkDFksfn6c+LfKKW3Qp+d0UKxrGXjaGQDV95NdU+iTWxXQTPOPd94MieXPt4RMUEBlO370N7+upTkEXqtIS1SvUQANCEMO9I9geyg0uy+LNVeZrApDiV0LCr0B0nHD46SPNrdQt+rY0wX90wJVoezKgpXRJr9YrpodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380464; c=relaxed/simple;
	bh=oNp9jEq5BmEbVN/b4Js6rQrq8Xst+4tcgv3iZC7SxfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cr0GZdrz63mjCqFg27wfNRnyB0mJilEisDpX59mqeLDwGHdXi9iWAN7383DS3Mm+bczMvB6YpQsyOzZw3YGGp6aTeI+FshrRq2b1L5zLVmugsZqPdQLWxWbs4mQNbmen04wTr4sOx9hcVtFXmfYOD8RIm9Dz71Hxa0iDMRp6ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbAvnjVq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756380461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvseKhbRe99z0CmdjuhWgWGyOBPn+zwz/tfo7V9gT6k=;
	b=EbAvnjVqwWx/V+9jK1kW3hu2vlqfcU/yc9tkuwfkMD+JEqCHMRnaLrc/gsJ5fipTtH8juX
	STdzAR66SKqBi0bj6sBsVB++HlQ/SutB/+r59mEauj0C2A6F0y1zTOA0eUDTlEGVDqzK0y
	CkiYDb+hjxDnklubZ6gXQrDwpoOWhjE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-YQhykFjFM_2TPozkE0gkuQ-1; Thu, 28 Aug 2025 07:27:40 -0400
X-MC-Unique: YQhykFjFM_2TPozkE0gkuQ-1
X-Mimecast-MFC-AGG-ID: YQhykFjFM_2TPozkE0gkuQ_1756380459
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71ff6edcfe9so10584257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756380459; x=1756985259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvseKhbRe99z0CmdjuhWgWGyOBPn+zwz/tfo7V9gT6k=;
        b=T/TANlvW85Vc3UYtkHJDtsDucDGLMTQh+dhcFfMcOVPFaQAT87il0YDrpHM/w5tYW/
         zTRTcy0NrpBeNVMOH9N+nhGullKbL+ZGdBeJU0m3g/PQvZzinRd0VDI6akSjx2x8H1no
         UyjQDk9/PzicekllOBowXGoBj81ImoZR3yeIdlCBmv9wxlie0scTPE5gtYDACTbY44Gi
         nMvKD9oa484xxCvRPACYm4zPeEoY6Cuxch0GQ+U2zuHVlGvzQx6ANoT40FF7aN1pUi1J
         uGoDL2PYdj2N4zL39qvIlRT4SSeAuzq3oc5qM4SdVBBhFyLbHXlV9gzras9p/a1vd+sY
         W0jA==
X-Forwarded-Encrypted: i=1; AJvYcCW5JiF8C4vjMl56D5IoniYWmke7H0AzOTg1ESZm3oF2ztDycI/Cu24tmh+UvCDVF/mhemQFOLiY6eEPdC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7cFHmeUrBGeY0GLYyRCHjCWJDkKKVTrn+g6FsKz8P9Ge0ICK
	VBAs8w1nl5KSnSCsEu0X3YsjBa/2w/8yvTXVXrSFd6dwkEGJZpYeFN9HjzHBXvbzFb9/lj0a3cA
	ROjWg2g/iJ5aFZEAWn5uXZmnc8RVdSrAnMqQ7u4HgbJ1TX6XsKD/6ugOR2oBmnio4Gg==
X-Gm-Gg: ASbGncuv7WYKZw9FG+uDJqPGXxh+l89T/nXq1mGX4H69ySZKR6ADC8mT8PaJ1pr5TkR
	1ywzdMyuXnIWbDJoVt5mCPO9gU4dAcP56pbIYL6drADguLgX4BaRZFclpIcEhaGxc79IgF+KPnJ
	mHARnIWjWgmThaJkjeqlOsffYokM6lV5TTsWkJbHS6chcJgASCsRXUoPLKZ3/yM2NMV96M5yJFK
	uKLO5ZQbVtiNge1IBQkHmLUThn1FMTWMRnVlTMhWGjIKsyDqpgLl3RiVm3391+UYz/lWfTpkpiN
	GT8ejv7HhUjx/faftI7mFFA62gs9F/atyXvaeAE=
X-Received: by 2002:a05:690c:67c6:b0:720:58fd:6433 with SMTP id 00721157ae682-72058fd6980mr196110257b3.35.1756380459403;
        Thu, 28 Aug 2025 04:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs1gMfCshj+EI8bjuXG0ZlCYFlPKnwKuax5qtq3eiiOcfsRu4MQD8QtE8fsNsRs28xOi1lEA==
X-Received: by 2002:a05:690c:67c6:b0:720:58fd:6433 with SMTP id 00721157ae682-72058fd6980mr196109997b3.35.1756380458909;
        Thu, 28 Aug 2025 04:27:38 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff173cd93sm38418157b3.22.2025.08.28.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 04:27:38 -0700 (PDT)
Message-ID: <67ebb7d5-418c-4eaf-aa94-8ecf76bd44eb@redhat.com>
Date: Thu, 28 Aug 2025 07:27:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel: power-domains validate domain in
 tpmi_cpu_online()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tero Kristo <tero.kristo@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250826164331.1372856-1-darcari@redhat.com>
 <00466c7a41bd4a0120a7798318ac5bba8878ada5.camel@linux.intel.com>
 <adbc0e8b-199a-42af-a45e-cb3791923554@redhat.com>
 <abdd6c22714984782fbbb7dab5a7e1ab0fa4799c.camel@linux.intel.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <abdd6c22714984782fbbb7dab5a7e1ab0fa4799c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/27/25 7:49 AM, srinivas pandruvada wrote:
> On Tue, 2025-08-26 at 21:39 -0400, David Arcari wrote:
>>
>> Hi Srinivas,
>>
>> On 8/26/25 4:26 PM, srinivas pandruvada wrote:
>>> Hi David,
>>>
>>> On Tue, 2025-08-26 at 12:43 -0400, David Arcari wrote:
>>>> Although tpmi_get_power_domain_mask() calls
>>>> tpmi_domain_is_valid()
>>>> prior to indexing tpmi_power_domain_mask[],
>>> Because this an API call so that caller parameter needs to be
>>> sanitized.
>>>
>>>>    tpmi_cpu_online() does
>>>> not.
>>> This is hotplug callback, which should have correct topology
>>> information.
>>>
>>>>    In the case where a VM creates non-contiguous package ids the
>>>> result can be memory corruption. This can be prevented by adding
>>>> the same validation in tpmi_cpu_online().
>>>>
>>>
>>> This driver is getting loaded means MSR 0x54 is virtualised
>>> otherwise
>>> this driver will not load.
>>
>> I don't have direct access to the system, but this appears to be the
>> case.  The driver is reading MSR 0x54:
>>
>> drivers/platform/x86/intel/tpmi_power_domains.c:#define
>> MSR_PM_LOGICAL_ID       0x54
>> drivers/platform/x86/intel/tpmi_power_domains.c:        ret =
>> rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
>> drivers/platform/x86/intel/tpmi_power_domains.c:        ret =
>> rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
>>
>>
>>> Not sure this is an upstream kernel or not.
>>
>> This was not an upstream kernel, but I don't see anything in the
>> upstream driver that would have prevented the access that is
>> occurring.
>>
> The issue here the topology_max_packages() is 2 but cpu 1 package ID is
> also 2. So everywhere topology_max_packages() is used there may be
> issue as you have to verify the package ID is fine.

Correct.  There are two logical packages on this system, but they are 0 
and 2.

> 
> 
> Repost the patch by adding the above root cause in the description, so
> we know why we need this change.

I will do that.

Best,
-DA

> 
> Thanks,
> Srinivas
> 
>>>
>>> Some comments below.
>>>
>>>> Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU
>>>> mapping")
>>>>
>>> Andy already pointed about new line here.
>>>
>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
>>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>> Cc: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Cc: David Arcari <darcari@redhat.com>
>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Cc: Tero Kristo <tero.kristo@linux.intel.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: David Arcari <darcari@redhat.com>
>>>> ---
>>>>    drivers/platform/x86/intel/tpmi_power_domains.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
>>>> b/drivers/platform/x86/intel/tpmi_power_domains.c
>>>> index 9d8247bb9cfa..ae5b58679e29 100644
>>>> --- a/drivers/platform/x86/intel/tpmi_power_domains.c
>>>> +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
>>>> @@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int cpu)
>>>>    	if (ret)
>>>>    		return 0;
>>>>    
>>> Need some more information.
>>>
>>> The only case this check is required if
>>> topology_physical_package_id(cpu) is returning greater or equal to
>>> topology_max_packages(). If this true in this case, please check
>>> the
>>> value of info->pkg_id. If this is bad then then some other places
>>> also
>>> this may have issue. info->punit_domain_id is already checked for
>>> valid
>>> value in tpmi_get_logical_id().
>>
>> That is correct.  In the case of the crash we have:
>>
>> crash> p/x __max_logical_packages
>> $1 = 0x2
>>
>> static inline unsigned int topology_max_packages(void)
>> {
>> 	return __max_logical_packages;
>> }
>>
>>
>> $2 = {
>>     hnode = {
>>       next = 0xffff9651bbc37010,
>>       pprev = 0xffffffffc0b7a640 <tpmi_cpu_hash>
>>     },
>>     linux_cpu = 1,
>>     pkg_id = 2 '\002',
>>     punit_thread_id = 0 '\000',
>>     punit_core_id = 0 '\000',
>>     punit_domain_id = 0 '\000'
>> }
>>
>> The pkg_id of 2 leads to the bad reference.
>>
>> FWIW this change has been tested and resolves the issue.
>>
>> Let me know if there is any other information I can provide.  I will
>> be
>> out of the office on Wednesday, so response may be delayed.
>>
>> Best,
>> -DA
>>
>>>
>>> Thanks,
>>> Srinivas
>>>
>>>> +	if (!tpmi_domain_is_valid(info))
>>>> +		return 0;
>>>> +
>>>>    	index = info->pkg_id * MAX_POWER_DOMAINS + info-
>>>>> punit_domain_id;
>>>>    
>>>>    	guard(mutex)(&tpmi_lock);
>>>
>>>
>>
> 


