Return-Path: <linux-kernel+bounces-822894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF0DB84EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C5F7C49B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF46225A38;
	Thu, 18 Sep 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfQMeVPw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F111F12F8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203631; cv=none; b=JFhSNGy84PPrk1saU3HGsKp2iNCgMP0tt2OrPbaPAA5i/euGRFUndz9Qfp3IjO6jX7r+erhF3KBj6B0gg4xmXSmQRfQXVAeQVcpcVzpVoA+Qma7lCoI2gUfqXlIEReIq+AsM1oGKosjoWumnoieyvN5glFn1ey8l3jmE2R1hMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203631; c=relaxed/simple;
	bh=W8d+rtW76hd2LNkPX2+QJLDJy6PBL5cszIE1g/3/9FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFSb2zv7N5Wh3zACHtpTfqUtdHysOVb09ieGQWkzCxJ2abKUxg+8oHkylrGufJjvGm2POJhlBlO/NTdkaEs49+nEHUftLu5bUbCxj7YLNRcurIOr5O5TbpD6IxZpCtMhCQ66UdJdt9IeYGHx8DP6uNVXMbA8A/bsVfH0cjvUzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfQMeVPw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso182592066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758203628; x=1758808428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7efdXg49cd0dO4HNsPgED93u6J0FRsteNdyMBWuRc0=;
        b=cfQMeVPwhlYmpXtRfT5BYz/T64TCrvFJH32cIptJYbfQCQtwjQsSKaALeXPvk33VpH
         arNXDWeQtAB702/agV1Yb32LnvTiUtMqTik2TaYQiQXOKm/pXZfcgDMDgXTbX3k+8A0y
         OaRPcDv3acaWTtrxzqWfSR7KIQ/pWUhzTwypH+zeKkK5pzI7Zjt4xFlqjNNLgyFIMmRT
         40MWju1htAXyxrvY9WduasEk6HQQXXrUbFxklSW+ghU45OQefJky7Yl77X2GMM7RIDRD
         b6hxehcLvwJwR1QDj0FxPKio+SUWdBrDk8SxtjjdvS9IxiLeQCsa5koecQdC1qlQah4D
         ywig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203628; x=1758808428;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7efdXg49cd0dO4HNsPgED93u6J0FRsteNdyMBWuRc0=;
        b=wmXBp5recicBmg2b5wym7S10pvRKCnOcP/Q5b9NicPgXdYg0gx7V2w4iJz71eyxQfd
         cOkIqMTNpwfrALTKeF7x2UShEN+nhu+5vAJDGZT+iZhvfHZpVlh2LCGtLnZM9VoqTME+
         R2tr/6qpJu6GM/pGb0K/H9j1xKh1Nytmbf0sMK7Pd9xUR1Z0moNKw8UB7R/CuD0LVFu9
         3CYC8q4ZOaCd0Fhem+0iQEFwmqeD9O3UiPxUfr630jMLaV+QHJCWyRiFYrrLkZUzdlwQ
         UA2k7pVDdrcEFF2s96NeD5rR6z79ydGXAk/TUdNKSJDa0Oa1Txy9l6VhjnvprWg27ges
         fr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSUgi1tF/IbbBPKFJ8RVQYiFv763JhF6adcEc0h9OVGM2dml6U1qWnI+7OvH6nvrunnu9q9wklSHzXl9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudA/O+rzMr5Un+REOOWhMz2lMpP0gipRTPP0bxmfO9Vx+1g/l
	PEMTlJvVb80XtbgdPxdjiI7L16cQSIvQ1zT7iqbHpZiPKKOWHk+GCFvtJM6mQLx8y40=
X-Gm-Gg: ASbGnctp5MvSc0ZtfVdb49xXZx4dcMPvcXxLXRMjO0cikj40EamaGvZrE8f+jd0u/rU
	iPXHsaJjwvGb3kieHl4BzZt/H8Pb6rQe2U2mvLo0FH3jVqHcwZR6oeM2aDx6UEP6n/Ik8HhpNls
	VleugETR6Tc8CmBZokYtOuh2HDV16/VMsHcn1BbpM/FFMUARhcpy5KghYg7FHJegumE60xVA2x7
	rSZ+vUPSp6EsrASxrZF06qLfUuvDbm0HIcORZaTwAx9ZWzVAPuHXapDrRLuEwmvXoAcr+p6xG00
	HlVmxjWIqsdPdp4xT7cOun/7yGbAS+OElnhQNCw3zPu4TU4+gd2J31wgIhmv6k7yA5qW1bKtONz
	CWWEfKOynfGQsyrGJ7S7EBg/4y2refhWRK8sTaB1G0zNGs/2sJw4=
X-Google-Smtp-Source: AGHT+IHnDWpjM1umgSyHsR6OREF3QxVVNfm6x8W+jII5XcXDsJKZeNe+EM7x++buErDbKkF9QmRQfw==
X-Received: by 2002:a17:907:7e93:b0:b02:a093:eac9 with SMTP id a640c23a62f3a-b1bc1169518mr637192866b.53.1758203628349;
        Thu, 18 Sep 2025 06:53:48 -0700 (PDT)
Received: from [172.20.10.3] ([109.166.131.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44bbcsm203026466b.5.2025.09.18.06.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:53:47 -0700 (PDT)
Message-ID: <c3ab4a21-183f-495a-b3b5-cc74b392eebc@linaro.org>
Date: Thu, 18 Sep 2025 16:53:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
To: Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand
 <david@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-10-eugen.hristev@linaro.org> <87cy7q9k8y.ffs@tglx>
 <87a52u9jyl.ffs@tglx> <8df2cf28-c15e-4692-a127-6a5c966a965e@linaro.org>
 <2bd45749-e483-45ea-9c55-74c5ba15b012@redhat.com> <87v7lh891c.ffs@tglx>
 <95ff36c2-284a-46ba-984b-a3286402ebf8@redhat.com>
 <24d6a51d-f5f8-44d7-94cb-58b71ebf473a@linaro.org>
 <7f4aa4c6-7b77-422b-9f7a-d01530c54bff@redhat.com> <87segk9az5.ffs@tglx>
 <f8d3c2d4-8399-4169-8527-3c87922f2ef1@redhat.com> <87jz1w88zq.ffs@tglx>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87jz1w88zq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 11:23, Thomas Gleixner wrote:
> On Wed, Sep 17 2025 at 21:03, David Hildenbrand wrote:
>>> As this is specific for the compiled kernel version you can define an
>>> extensible struct format for the table.
>>>
>>> struct inspect_entry {
>>> 	unsigned long	properties;
>>>          unsigned int	type;
>>>          unsigned int	id;
>>>          const char	name[$MAX_NAME_LEN];
>>> 	unsigned long	address;
>>>          unsigned long	length;
>>>          ....
>>> };
>>>
>>> @type
>>>         refers either to a table with type information, which describes
>>>         the struct in some way or just generate a detached compile time
>>>         description.
>>>
>>> @id
>>>         a unique id created at compile time or via registration at
>>>         runtime. Might not be required
>>
>> We discussed that maybe one would want some kind of a "class" 
>> description. For example we might have to register one pgdat area per 
>> node. Giving each one a unique name might be impractical / unreasonable.
>>
>> Still, someone would want to select / filter out all entries of the same 
>> "class".
>>
>> Just a thought.
> 
> Right. As I said this was mostly a insta brain dump to start a
> discussion. Seems it worked :)
> 
>>> @properties:
>>>
>>>          A "bitfield", which allows to mark this entry as (in)valid for a
>>>          particular consumer.
>>>
>>>          That obviously requires to modify these properties when the
>>>          requirements of a consumer change, new consumers arrive or new
>>>          producers are added, but I think it's easier to do that at the
>>>          producer side than maintaining filters on all consumer ends
>>>          forever.
>>
>> Question would be if that is not up to a consumer to decide ("allowlist" 
>> / filter) by class or id, stored elsewhere.
> 
> Yes, I looked at it the wrong way round. We should leave the filtering
> to the consumers. If you use allow lists, then a newly introduced class
> won't be automatically exposed everywhere.
> 
> Thanks,
> 
>         tglx


So, one direction to follow from this discussion is to have the
inspection entry and inspection table for all these entries.
Now, one burning question open for debate, is, should this reside into mm ?
mm/inspect.h would have to define the inspection entry struct, and some
macros to help everyone add an inspection entry.
E.g. INSPECTION_ENTRY(my ptr, my size);
and this would be used all over the kernel wherever folks want to
register something.
Now the second part is, where to keep all the inspection drivers ?
Would it make sense to have mm/inspection/inspection_helpers.h which
would keep the table start/end, some macros to traverse the tables, and
this would be included by the inspection drivers.
inspection drivers would then probe via any mechanism, and tap into the
inspection table.
I am thinking that my model with a single backend can be enhanced by
allowing any inspection driver to access it. And further on, each
inspection driver would register a notifier to be called when an entry
is being created or not. This would mean N possible drivers connected to
the table at the same time. ( if that would make sense...)
Would it make sense for pstore to have an inspection driver that would
be connected here to get different kinds of stuff ?
Would it make sense to have some debugfs driver that would just expose
to user space different regions ? Perhaps something similar with
/proc/kcore but not the whole kernel memory rather only the exposed
inspection entries.
Now, for the dynamic memory, e.g. memblock_alloc and friends ,
would it be interesting to have a flag e.g. MEMBLOCK_INSPECT, that would
be used when calling it, and in the background, this would request an
inspection_entry being created ? Or it makes more sense to call some
function like inspect_register as a different call directly at the
allocation point ?

Feel free to throw your opinion at each of the above.
Thanks for helping out !

