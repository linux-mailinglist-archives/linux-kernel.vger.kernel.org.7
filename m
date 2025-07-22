Return-Path: <linux-kernel+bounces-740469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E4B0D480
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754817AF17C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD32D63F3;
	Tue, 22 Jul 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZeVGVi3w"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D52BEFFD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172714; cv=none; b=YI+13iWdYjYZUpLzMEU9H7SLvOlsdQs73W3cQ4KPQCNuzLTKdE2Ux+cVOKJsSmHmISpkaSrM+7kkxXmjn68h8el3H7JgEVpkWpk0ZHi151YQ+UwUjufXCxwO1TUeVxd9QfFQcTYEn2ZMO+4q4tvZESrZyR6sgQe1AC4TTuFoDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172714; c=relaxed/simple;
	bh=nO+BeWnEKp1sgYrQd063lpitIq0X5eLlYrjNt6bNdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ4p/exhbOxlpx/J3330S3F/3VK4yU+3GoBXs1lvbu4iz33xvhzTHQGCI9Hf0jtXyBKlvBjbpEVmYdfc4OS3fYxrXEZgaGaQQjRWfRK2zpFfmgPB4SYrLayPi0ZjB3VTze9G+Rvyqo47KNjrYvGJ5/IElUd10xLU+uhFYx4H94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZeVGVi3w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0c4945c76so703842166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753172710; x=1753777510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+53udgPBeWp0zX4o9SusXCPtIt70aWgzQmSuLoKDLJ0=;
        b=ZeVGVi3weOtXYN70HCc0Vl0Vc1KvXfZ/obIvIDlOoZ7kZhtBKJrbSzOq8lwQLxfKRJ
         SjPT1PP+TsMl0rr8rsZcwHdyyd5JmroXMrXDlo2YM16KOFGw2DSJ87Ud6enhxNLyyZJi
         kasaPpkCy3boz8A4yot5881kfdiF5+Gc2GNqFD8Q0HEJyR9NCt1lX1EiFpBGw9wqo2bA
         zkTyyDaxlUmLnJqR71V2X/7LNNOcYMlX+Z31eeCs8OUNj2wD4cCoMp1HWZQeUgPhbfk1
         4saNq9BMvzyHn2G21gE7LqGK4DfZ79bJ0sM/mwoGd7xGPwSi3hTRCuxDPPe8mJmAs9G1
         TZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172710; x=1753777510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+53udgPBeWp0zX4o9SusXCPtIt70aWgzQmSuLoKDLJ0=;
        b=iWisePw6E6z0eDhZdbRQdfnEfIDUDTcLm3ae0/5915Zz8j3IGRGuORfl3di8XchgWx
         TePUFWc283toXzlcx4/nc/FXoEWhXlAqGsDO7NhmWt8L63WPZBkqocEJJcZSc3AT6k2m
         z8hNjV0hHQio7FkKCmEnENwTu36cZZU4BKGVrYnR4OekQ6r06OH48z1LsvbPpU0bh22c
         emhEWOBSdqSei5WxaKN/piAMDLgeRAzs4NOgXU/ee+ZXquqLK5QGQANpeXa4uh+q8SZ0
         xDClQIyZSKim3E/7qD0qfxuKi2HliT9FFganw1j1oQ5ILnmWHNAxEDFv2zMFnIKk+JqL
         aUZg==
X-Forwarded-Encrypted: i=1; AJvYcCXv49clHv8gBMrvVV4Wkt7tuBvf21o6/wRhpjGR+gByL3+9Y76mdAcRHKnu5SFTochoK8aDLSxyHtZdIfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3hyHDb4wRlpaHq/xoh8eUtBWJ4eWiRy6bSmVrz5QEXSZWazB
	pSyEWExUKPJBABHSmHt0v9nHOixKizUNqSmfDizyeg/wR2BAIeN4dSARKbqwBttRBc0=
X-Gm-Gg: ASbGncsp6BiA2eR4YvxLnbMiJrgzVfoVusSRmXdUt+2OpVzAu5S9peeftLVb9gJw7Kx
	5lEK4UBfAFHc1FWfGAhS/XmDisLvmzJWSQxqs4RLn4p+jXpJvjzzlW3exWCtYta4x+MOkmXBHBT
	gk8aGvzCcw2k4+9BXI8X4hQqy/26i1cWpqfVER0NMPQBFNnjcAQ6C4Qxu7Jq7xNytIxPUEqCEOQ
	fZhHCwbWOtpcCwt3Fm8irMGKnMfQJuaZZ30aC27420y5C3jVfUiiWEApKxirWee/5h5r3FO2a/E
	5NlzmnggCMQeuwWimlN1rCZpOIXSAcaMRIx9iCgQ898d9J+1/kDneNohp+A08sLzD00ndO4ltV0
	LDYPznwmGZeVV3PPIhp5klB61lBUfc5pSfGk4EB6UELw=
X-Google-Smtp-Source: AGHT+IFIRmIqZbm2KYpMbMYJpVYgLj2IzSoXsffEetc+PhnndZMk9crUskR8nfGZP0w+lX/mUMHqxQ==
X-Received: by 2002:a17:906:fd84:b0:ae0:d1f3:f7f4 with SMTP id a640c23a62f3a-ae9cdde7478mr1959729066b.13.1753172710463;
        Tue, 22 Jul 2025 01:25:10 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cd11sm818728566b.16.2025.07.22.01.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:25:10 -0700 (PDT)
Message-ID: <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
Date: Tue, 22 Jul 2025 10:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
To: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
 <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
 <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 5:08 AM, Wang Jinchao wrote:
> On 7/21/25 22:40, Petr Pavlu wrote:
>> On 7/21/25 6:52 AM, Wang Jinchao wrote:
>>> When there is no version information, modprobe and insmod only
>>> report "invalid format".
>>> Print the actual cause to make it easier to diagnose the issue.
>>> This helps developers quickly identify version-related module
>>> loading failures.
>>> Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
>>> ---
>>>   kernel/module/version.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>> index 2beefeba82d9..bc28c697ff3a 100644
>>> --- a/kernel/module/version.c
>>> +++ b/kernel/module/version.c
>>> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>>>       }
>>>         /* No versions at all?  modprobe --force does this. */
>>> -    if (versindex == 0)
>>> +    if (versindex == 0) {
>>> +        pr_debug("No version info for module %s\n", info->name);
>>>           return try_to_force_load(mod, symname) == 0;
>>> +    }
>>>         versions = (void *)sechdrs[versindex].sh_addr;
>>>       num_versions = sechdrs[versindex].sh_size
>>
>> I think it would be better to instead improve the behavior of
>> try_to_force_load(). The function should print the error reason prior to
>> returning -ENOEXEC. This would also help its two other callers,
>> check_modinfo() and check_export_symbol_versions().
>>
>> Additionally, I suggest moving the check to ensure version information
>> is available for imported symbols earlier in the loading process.
>> A suitable place might be check_modstruct_version(). This way the check
>> is performed only once per module.
>>
>> The following is a prototype patch:
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c2c08007029d..c1ccd343e8c3 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1053,6 +1053,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>>       add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>       return 0;
>>   #else
>> +    pr_err("%s: %s\n", mod->name, reason);
>>       return -ENOEXEC;
>>   #endif
>>   }
>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>> index 2beefeba82d9..4d9ebf0834de 100644
>> --- a/kernel/module/version.c
>> +++ b/kernel/module/version.c
>> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>>           return 1;
>>       }
>>   -    /* No versions at all?  modprobe --force does this. */
>> +    /* No versions? Ok, already tainted in check_modstruct_version(). */
>>       if (versindex == 0)
>> -        return try_to_force_load(mod, symname) == 0;
>> +        return 1;
>>         versions = (void *)sechdrs[versindex].sh_addr;
>>       num_versions = sechdrs[versindex].sh_size
>> @@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
>>           have_symbol = find_symbol(&fsa);
>>       BUG_ON(!have_symbol);
>>   +    /* No versions at all?  modprobe --force does this. */
>> +    if (!info->index.vers && !info->index.vers_ext_crc)
>> +        return try_to_force_load(
>> +                   mod, "no versions for imported symbols") == 0;
>> +
>>       return check_version(info, "module_layout", mod, fsa.crc);
>>   }
>>  
>> As a side note, I'm confused why with CONFIG_MODULE_FORCE_LOAD=y, the
>> code treats missing modversions for imported symbols as ok, even without
>> MODULE_INIT_IGNORE_MODVERSIONS. This is at least consistent with the
>> handling of missing vermagic, but it seems this behavior should be
>> stricter.
>>
> When debugging syzkaller, I noticed that the insmod command always reports errors. However, to get the exact information, I need to trace the kernel, so I casually submitted this patch.
> 
> Based on your response, I also feel that the meaning of force_load here is somewhat unclear. It would be better to create a mask or a clear list to indicate which fields can be forced and which cannot. Once this is clear, we can create a function named may_force_check().

I cannot find an explicit reason in the Git history why a missing
vermagic is treated as if the module was loaded with
MODULE_INIT_IGNORE_VERMAGIC, and similarly why missing modversions data
is treated as if the module was loaded with
MODULE_INIT_IGNORE_MODVERSIONS.

I would argue that a more sensible behavior would be to consider
a missing vermagic as an error and allow loading the module only if
MODULE_INIT_IGNORE_VERMAGIC is explicitly specified. And analogously for
missing modversions and MODULE_INIT_IGNORE_MODVERSIONS.

Nonetheless, if I understand correctly, this should be mostly separate
from your issue.

> 
> In addition, check_modstruct_version also calls check_version to handle tainting. So there's a minor issue with the logic in your example patch.
> 

I'm not sure I follow here. My example lifts the try_to_force_load()
call from check_version() to check_modstruct_version(), and should still
result in tainting the kernel.

-- 
Thanks,
Petr

