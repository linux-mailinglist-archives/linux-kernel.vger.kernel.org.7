Return-Path: <linux-kernel+bounces-787501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A348EB37739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D9F3ADE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848CE223DF9;
	Wed, 27 Aug 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWOsm4rx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A122423A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258783; cv=none; b=Nk2OqbPvf5fpyJeRvLAhx8+oTUmsQST2atnJoYxtGBZShv1tAkLBzXFSXHHxfkBQmbucmONoASi7aJjblzJJprCWMPd3BasH/TZxfWV9iOXWtQfQ9gxQFgHCxsGwtAiEjacybwq5hdAZgkHXI+s2vKxFzIJs5KvziaU+CuVBL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258783; c=relaxed/simple;
	bh=jeXU9Xe2Dmb1wP26RAr3Ldy7ZqHCVmQ+ybFc53+N3no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh7o7nYEJGZAR9TztkCFJErZ61iismWZBVMLxUqtfNZNcSvBQrj31JgVaMY3b6qUDyqqrw8TdV5eD9i6p+tdmPy3OT4wiWNhqU1H9OKKRHp3iqHxEh+npVcXaAM2H1YzzwwvprxL3mbkn3T7hCuBQEhfgbeEKL7QUbFUdKUYG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWOsm4rx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756258780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQY2nkDeqTs8gqhNvNe1w77H/ik2M+Mc0ECiwRbonJM=;
	b=LWOsm4rx0iTzYMka7YwfkZBFL6l1LxIaJMg8SAlGdm/TcnV9B0K5pPE1RORyB3zHAciYQK
	qRUEQaN63d108HdewpVmX8oP10liDswLkBEAd6f5pAisk/vOM5xa0wrI+usjEBHrxymt74
	omFQLjs+nmMPUq7UCIU5cYpDm4wHHI4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-jJtM7twyN_ix-RwCroEO5Q-1; Tue, 26 Aug 2025 21:39:38 -0400
X-MC-Unique: jJtM7twyN_ix-RwCroEO5Q-1
X-Mimecast-MFC-AGG-ID: jJtM7twyN_ix-RwCroEO5Q_1756258778
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-72009b20933so41725367b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258778; x=1756863578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQY2nkDeqTs8gqhNvNe1w77H/ik2M+Mc0ECiwRbonJM=;
        b=VtmfcMmRbyyv2UCZl5EPUMgbMUogZHH8nvIdryN10i4vab4+JLXmvv6/vObhvDWqez
         5xYZkKY22q4JcRccEJ7d6kPFuwz7OB4JmAiquQUhEJRuV+X8gUwDPD448u1ocXUZe0ot
         JQ9hHfvlGlMSUFYwZWVF4XHxnENCtJfg4o3FwxnskA7WxQlyLWGl6rOolOlSe858+XWd
         SvTwZASIGOoX84BMFAK+VasimeAhg1QFR+dmBTQ9uODqKNbnOfXfYL1n3R/M5dTTxwEA
         a9StrEOzEXnjJ/H0vsKYU4XeDjKL32xZXqFegeyCOvw+GhCf+mFaH8pzd9Z6EmrC4kWN
         fCBw==
X-Forwarded-Encrypted: i=1; AJvYcCXfGlI+Zrymrxf+8P+yu3ymha9+wOYqC5KFCy6WlJ59TWAPqnIb4Txvn/uW+PGW2llUxB917Ed2+frEDPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPfh5QPp+Nd9hiK+Kz0G6s4OvhVd2O8eMewztjMoe6qtZB8Rr
	ME8Dqu6KSJr07wDp2VrmsKzKp56AFMvSsFSqzhVWV928ujFquDFm5yHdx+jxukBN8E4UqGbMJps
	Uu+EI2JuSoXXPWGIQY508lNmdSpI7pwnhvhd2vj38Ty4xAwvOK6xOwMKxL4/tHsPWtg==
X-Gm-Gg: ASbGncuFVyjrVRSAhXp2wPA7BIY6D0cBWnrpFqCnD4+qU8nNCs9sYLpLnIwcTPhWGiT
	V5tqy2DONoV3A4groIh+FWh/Jrp3gPcxAfuaLyKSdRNUMS49WeAKOwyKzY5nhNJ/NG2JspsWxEH
	iornEx/xvT9bDD5dJ7axUZtYLX+JMnVRdeBsan4rpSW8h1Tsqv7NIAyXE9FjNJ70eIM4j7kajtb
	0E2fvy6TJh5oHLKA+1U7zLqdHxubY2a1JZyHM98I2JCKUfOov1DnP4hyL6+oVUEfcHaK5/6Zzsn
	tIEt1NsDxmp418oUxjHvrmEonmBy0XSonWJVDAQ=
X-Received: by 2002:a05:690c:6001:b0:720:5db:1220 with SMTP id 00721157ae682-72005db1a83mr109613507b3.8.1756258778312;
        Tue, 26 Aug 2025 18:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGONWuDrjLuuLZa+yt5heOLjkeEny8jaPwIVQrhlucUklL7r3XzH06NRj7GhdodnncpmGeeFw==
X-Received: by 2002:a05:690c:6001:b0:720:5db:1220 with SMTP id 00721157ae682-72005db1a83mr109613317b3.8.1756258777908;
        Tue, 26 Aug 2025 18:39:37 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ae99dsm28015687b3.54.2025.08.26.18.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 18:39:37 -0700 (PDT)
Message-ID: <adbc0e8b-199a-42af-a45e-cb3791923554@redhat.com>
Date: Tue, 26 Aug 2025 21:39:35 -0400
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
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <00466c7a41bd4a0120a7798318ac5bba8878ada5.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Srinivas,

On 8/26/25 4:26 PM, srinivas pandruvada wrote:
> Hi David,
> 
> On Tue, 2025-08-26 at 12:43 -0400, David Arcari wrote:
>> Although tpmi_get_power_domain_mask() calls tpmi_domain_is_valid()
>> prior to indexing tpmi_power_domain_mask[],
> Because this an API call so that caller parameter needs to be
> sanitized.
> 
>>   tpmi_cpu_online() does
>> not.
> This is hotplug callback, which should have correct topology
> information.
> 
>>   In the case where a VM creates non-contiguous package ids the
>> result can be memory corruption. This can be prevented by adding
>> the same validation in tpmi_cpu_online().
>>
> 
> This driver is getting loaded means MSR 0x54 is virtualised otherwise
> this driver will not load.

I don't have direct access to the system, but this appears to be the 
case.  The driver is reading MSR 0x54:

drivers/platform/x86/intel/tpmi_power_domains.c:#define 
MSR_PM_LOGICAL_ID       0x54
drivers/platform/x86/intel/tpmi_power_domains.c:        ret = 
rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
drivers/platform/x86/intel/tpmi_power_domains.c:        ret = 
rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);


> Not sure this is an upstream kernel or not.

This was not an upstream kernel, but I don't see anything in the 
upstream driver that would have prevented the access that is occurring.

> 
> Some comments below.
> 
>> Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU
>> mapping")
>>
> Andy already pointed about new line here.
> 
>> Cc: Hans de Goede <hansg@kernel.org>
>> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Dan Carpenter <dan.carpenter@linaro.org>
>> Cc: David Arcari <darcari@redhat.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Tero Kristo <tero.kristo@linux.intel.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: David Arcari <darcari@redhat.com>
>> ---
>>   drivers/platform/x86/intel/tpmi_power_domains.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
>> b/drivers/platform/x86/intel/tpmi_power_domains.c
>> index 9d8247bb9cfa..ae5b58679e29 100644
>> --- a/drivers/platform/x86/intel/tpmi_power_domains.c
>> +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
>> @@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int cpu)
>>   	if (ret)
>>   		return 0;
>>   
> Need some more information.
> 
> The only case this check is required if
> topology_physical_package_id(cpu) is returning greater or equal to
> topology_max_packages(). If this true in this case, please check the
> value of info->pkg_id. If this is bad then then some other places also
> this may have issue. info->punit_domain_id is already checked for valid
> value in tpmi_get_logical_id().

That is correct.  In the case of the crash we have:

crash> p/x __max_logical_packages
$1 = 0x2

static inline unsigned int topology_max_packages(void)
{
	return __max_logical_packages;
}


$2 = {
   hnode = {
     next = 0xffff9651bbc37010,
     pprev = 0xffffffffc0b7a640 <tpmi_cpu_hash>
   },
   linux_cpu = 1,
   pkg_id = 2 '\002',
   punit_thread_id = 0 '\000',
   punit_core_id = 0 '\000',
   punit_domain_id = 0 '\000'
}

The pkg_id of 2 leads to the bad reference.

FWIW this change has been tested and resolves the issue.

Let me know if there is any other information I can provide.  I will be 
out of the office on Wednesday, so response may be delayed.

Best,
-DA

> 
> Thanks,
> Srinivas
> 
>> +	if (!tpmi_domain_is_valid(info))
>> +		return 0;
>> +
>>   	index = info->pkg_id * MAX_POWER_DOMAINS + info-
>>> punit_domain_id;
>>   
>>   	guard(mutex)(&tpmi_lock);
> 
> 


