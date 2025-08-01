Return-Path: <linux-kernel+bounces-753736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE52B1871F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E916B3B07BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184722701C2;
	Fri,  1 Aug 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U40oVmif"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B91DC99C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071478; cv=none; b=jc3KOeCvhjbl5HKYgqxAMP+C1AlJVXWkdEBCYU50KGU4NQ1HyjWWrp5Bvy2k4+SziG1RO7aedIHgC0X819GqFVYanuK8H5g3/1K9b69tsGOL6B+cKpGOQHKeywBwVgW7MbOejnkYLdSP7DGP1WhY/Vx0wuM6ClUBmWXrom3MfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071478; c=relaxed/simple;
	bh=MVN+9Y9WU6rHYz8OKtAYacmxLn3RNiE5FyjN1AK4xmk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kvPsqdvj61BterQptCjL9J4SH2NW/adYXv8aanaUdTUnmFmmutP6g2iiPwLNUFknIBRltDwYCKxj1H946pDsfGn3PW011XrLINa1smQoJqudlbHRr/mMlHG0zmOdDu2peFbI2G3Td1ERTJBI3D5nCKH3RQ7VALaQ+aez2DvPb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U40oVmif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754071473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7/qqI338bQSJTOv+hsVaSllrZbDxraAox8IEpQa7CE=;
	b=U40oVmifcABS8e1krDr1AS/VSyOtCIw/mnBSbq3JGfLsl2KyazFe+rvLdLAGgicwgQ0t8o
	LrnVppK+oZQtpxdd8GYLDl29Xz1GugAT/7CR/+dy0n3qnRu5kPZTNpNtkJI8BW3vniOQK5
	XMZny102IYl1jBLi2uwSFHzYMBI1NAQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-3yDDhatwMn2DCJfaZUDbTQ-1; Fri, 01 Aug 2025 14:04:32 -0400
X-MC-Unique: 3yDDhatwMn2DCJfaZUDbTQ-1
X-Mimecast-MFC-AGG-ID: 3yDDhatwMn2DCJfaZUDbTQ_1754071472
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af0100c03fso22925561cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071472; x=1754676272;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7/qqI338bQSJTOv+hsVaSllrZbDxraAox8IEpQa7CE=;
        b=ccsagXvhySVsTA5ipyKBNSFjjbebRS3uNZ5+Mhm/8Qq6ZOI8WkP0sbU5LwSnBbPdpZ
         LffWVK7UIF5er7DQme4Ndm5n6l7YstKcyecsGNvfTs6hQErCIkTO0mQLpEHXqEyfaKob
         gHPi/m/0P0qxehTOmqMr+Z6t1Dpd+TfB+0+/uh39N3GPQ0trGeVNqoLlKkwkk8Y0G+mj
         oyrdJclhfENroa5pz93itAdxWzAjApAs3abV7/tZ8IXIkUgynurUQ9cxnhKdWkHPVbR5
         zha3JpFiJM6x54gF1Z5xYsf4gI6m10PROwx9F2VlQIjljPhF17qgk/nIWRg6gPQElEV6
         i70w==
X-Gm-Message-State: AOJu0Yz6RH4lyMhWJfP/fLFr6QcemoHFmW6ET38zJvBlO5j0NmCrhADP
	/lTOyoSZJmd8OBTlXLso1HPy9g5yuYIZwR20oItKpcUtrYGT42fFTrYFSOBOy8405CTgkjaE5ek
	YKLyK+GZcngBcl2134nps2qQq7ZsIRnNsTuEUEY4jv2URyw2mwJtjGMNID8E6CC56aQ==
X-Gm-Gg: ASbGnctaD1T/TUjx/E/OVXppm1I8iLGRXSf5ES08kRMnKsnwxB1peN2MzIpfSjEwH8m
	24Fqv9qIhpVf6LIkqz7mRL3aEwGdf6Lp5w6IcIcadSfvNVw0gQA16+lnuNZt3PvFYMiX7sfCDH0
	NP8fh8cSOcIb7OEnCjuY1VS+kNdLw3F/+KQi1Z1grNdXhc927PA/3YJeUOYCD3qmA5TuV74xxBA
	EwjIYsTFBefwGDZxInLch9Zy6PFWQyEVmtdS1NVVomrnjUF2ArtajvWhv2FRb3EADcA6RaAEwON
	iwLr5moOO/H8QhYukBkUQxJkweYCI0LPDEu7uZvTUet2jRqUMMrV0LkFmyO/KCqAWeUKLdNvwiM
	xT7Sp0YA27A==
X-Received: by 2002:a05:622a:105:b0:4ae:6d12:74b4 with SMTP id d75a77b69052e-4af10a789c6mr12000531cf.37.1754071471525;
        Fri, 01 Aug 2025 11:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQVWy+sQWPjp64481dMne3VCzVnxtSoiaEPSPuC4IqtkDwlBG4QKrN7KczcrWZtlJ0EaB9qQ==
X-Received: by 2002:a05:622a:105:b0:4ae:6d12:74b4 with SMTP id d75a77b69052e-4af10a789c6mr12000041cf.37.1754071471096;
        Fri, 01 Aug 2025 11:04:31 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeebdc99asm23506951cf.12.2025.08.01.11.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 11:04:30 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e1c575f-6e09-4f15-8c0f-1c23c6100ed9@redhat.com>
Date: Fri, 1 Aug 2025 14:04:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
To: Gabriele Monaco <gmonaco@redhat.com>, Waiman Long <llong@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-7-gmonaco@redhat.com>
 <a2ef7773-bec6-466f-81b3-e1d8f6cbe7b6@redhat.com>
 <1d12942942150462f77ea87fec8f294f46c87b4f.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <1d12942942150462f77ea87fec8f294f46c87b4f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/25 10:46 AM, Gabriele Monaco wrote:
>
> On Thu, 2025-07-31 at 11:09 -0400, Waiman Long wrote:
>> On 7/30/25 9:11 AM, Gabriele Monaco wrote:
>>> Currently the user can set up isolcpus and nohz_full in such a way
>>> that
>>> leaves no housekeeping CPU (i.e. no CPU that is neither domain
>>> isolated
>>> nor nohz full). This can be a problem for other subsystems (e.g.
>>> the
>>> timer wheel imgration).
>>>
>>> Prevent this configuration by invalidating the last setting in case
>>> the
>>> union of isolcpus and nohz_full covers all CPUs.
>>>
>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> ---
>>>    kernel/sched/isolation.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>>> index 93b038d48900..0019d941de68 100644
>>> --- a/kernel/sched/isolation.c
>>> +++ b/kernel/sched/isolation.c
>>> @@ -165,6 +165,18 @@ static int __init housekeeping_setup(char
>>> *str, unsigned long flags)
>>>    			}
>>>    		}
>>>    
>>> +		/* Check in combination with the previously set
>>> cpumask */
>>> +		type = find_first_bit(&housekeeping.flags,
>>> HK_TYPE_MAX);
>>> +		first_cpu =
>>> cpumask_first_and_and(cpu_present_mask,
>>> +						
>>> housekeeping_staging,
>>> +						
>>> housekeeping.cpumasks[type]);
>>> +		if (first_cpu >= nr_cpu_ids || first_cpu >=
>>> setup_max_cpus) {
>>> +			pr_warn("Housekeeping: must include one
>>> present CPU neither "
>>> +				"in nohz_full= nor in isolcpus=,
>>> ignoring setting %s\n",
>>> +				str);
>>> +			goto free_housekeeping_staging;
>>> +		}
>>> +
>>>    		iter_flags = flags & ~housekeeping.flags;
>>>    
>>>    		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>> I do have a question about this check. Currently isolcpus=domain is
>> bit 0, managed_irq is bit 1 and nohz_full is bit 2. If manage_irq
>> come first followed by nohz_full and then isolcpus=domain. By the
>> time, isolcpus=domain is being set, you are comparing its cpumask
>> with that of manage_irq, not nohz_full.
>>
>> Perhaps you can reuse the non_housekeeping_mask for doing the check,
>> e.g.
>>
>>           cpumask_and(non_housekeeping_mask, cpu_present_mask,
>> housekeeping_staging);
>>           iter_flags = housekeeping.flags & ~flags;
>>           for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>>                   cpumask_and(non_housekeeping_mask,
>> non_housekeeping_mask, housekeeping.cpumasks[type]);
>>           if (cpumask_empty(non_housekeeping_mask)) {
>>                   pr_warn(...
> Mmh right didn't think passing different masks in isocpus was possible.
>
> You mean something like this right?
>
>   isolcpus=managed_irq,0-4 nohz_full=8-15 isolcpus=domain,0-7
>
> Which doesn't block the nohz_full because the first mask (managed_irq)
> leaves spaces.
Yes, that is what I am talking about.
>
> Right now we block assignments like
>
>   isolcpus=managed_irq,0-7 nohz_full=8-15
>
> and
>
>   isolcpus=managed_irq,0-7 -a isolcpus=domain,8-15
>
> although this series doesn't really have problems with it.
> Shouldn't we just ignore these cases and just count domain + nohz_full?

You could, but you have to explicitly exclude managed_irq in your logic.


>
> The solution you propose is to check all housekeeping, so it would also
> prevent the (safe?) assignments above, right?
>
> We could just check against the previously set domain/nohz_full and
> leave other flags alone, couldn't we?

You will have to modify your logic and be explicit that managed_irq is 
currently ignored.

Cheers,
Longman


