Return-Path: <linux-kernel+bounces-730376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C1EB043E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B62B1892AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0F25F976;
	Mon, 14 Jul 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgoIzQ/R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF378258CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506663; cv=none; b=Ba8yrbJNB8SPtLVI/2fhCyA06ZFsy2nxDe0CDAJne5hGEMohfmNguiox/Qq6BLVlS3/9PtgrfB/e7pmMn1fnAOag/1XwDw8Q+IjJ/WldzKeo7cKFeArpyCUw6BHnpwxuQ81Q9IkcPPcV9ybeDseYd82mg7+Q99Mt4Rct+KT2yA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506663; c=relaxed/simple;
	bh=jiBzzr77jeGyCV4b2L7YbXGgDgVxt14PZGz5n2OykNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQU4pQO69KOTr9R1FHmtZhi3RPuuYSPFktxK81EIaKNPv9BWd9fMvWxJmRCWqGg/2LRY854SCnoitFwRkkdtCFD+WXtkqsrvlPscjSbNXcPm9YPrmb/igYUE0XmoxuZ1VpRBPOlP9o2citJGbgcKnTa7Cd2aFkB5x0K7+4UgnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgoIzQ/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752506660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hER77dU2efEPR5AO+ai2n3WJMard2PzwSK87xeF4+M=;
	b=VgoIzQ/RScaI/UyTdNy/VkDO2Yynly09FmKSthVf6ylb2GidWo/+n7JzwOuoB6xaT3uZjl
	6zgTlBkR8fNVsnGk6Wp0sP3ZHMNM93B5G6UGe6MZX4qIRzx53wLMKxigZGhmEVifsjhC+X
	+3E1aavMYHsmD5up917e9VJNIrmTANA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-YaV5wMdBPBuorKsyO0KOLA-1; Mon, 14 Jul 2025 11:24:19 -0400
X-MC-Unique: YaV5wMdBPBuorKsyO0KOLA-1
X-Mimecast-MFC-AGG-ID: YaV5wMdBPBuorKsyO0KOLA_1752506658
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2921692f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506658; x=1753111458;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hER77dU2efEPR5AO+ai2n3WJMard2PzwSK87xeF4+M=;
        b=W0ht4KZrRp4p2VGF+kdF6NDD9Kz04OD4NmU24JWVTPUDmmrjm+LPvlmQj3OgfQhdy+
         9OlDCjNDQKLPu0b/21ipC1KzOO00N9F5Ke4JmWc/niwZxdZsehQi90KtqCdayIPky4OE
         jdptgmBPamnzgxWV6OlK1RSD2mVIvsl/s77K5BmyLPQvQwi2Tj+NK1qitycmTtuVf/7e
         u0Q5bP/lN3RQBxdIVIYfTWQDQpRFAxZfzIUvAAxwfTZCQ9Noft9raCt4aZF4DMMTbsxD
         KXmXdgJ+1XXuIlmYYoCGBl/DfS4f7c1+7r7iEbDhVG1xlYPuZwMaa1gu0ITqgg/bE1e9
         /mug==
X-Forwarded-Encrypted: i=1; AJvYcCVk/TOP7ej/Ctex0SsIN4adlUkhn62UcV+kPLu76WYmFaDSKP54Akd35CriD4svzQy5Y44Nx18mxbEwQoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41gLqlWUMqqrU4DVb1sv3pwsEPIy7mtAO5ZHiTBwlFLx2+Lc3
	SIl3hsIH3A+hMe62lOdvFwsZT+0BveHZ+vLZS1RIkIk9mBgHyXTmN2s8lUcoWzqXMfIEngWJdJo
	t47jw28UI0y5EmpX4G7aGmDUyMqIqU2BVhRtMmL0w7FskVYD+Us7dhgz9QpC8Js+Pyw==
X-Gm-Gg: ASbGncuIpVL/jnSRuB0dbVBRnRmOc4OC6s6MAVf60TTFRmJEzXLB3SUJLtDqe4sjaPE
	80p4V103f6gUdr9BnhZT+jx9vkatuSrucmoPoBv47uNi3oZ54Lf6mlompSQfdRAjIq9Kr2T57pb
	HP0iLqhMZV/fXZYyMw9vodhhL6dX3knFfgQNTjA9OUL8nUTrJSc1vSJWOY+zgi2uXdmZY2WiazE
	1W1enVv/T/aBikFOOK7yTUF4uhiXrnqTZ0DwAMOIaMrFLKpHbztbZEeMkdxZlgE6qAS+JsPpKPQ
	fD3zbxfNOSrvKmNt+nRvYYeB+l/vKOJU8UgpUSz9yQvo9b1AsH79cW+w5I0yILi3OHWXjGeXlaS
	3Vw2zjmABYuuNo2WCJWQtOQlQ3mJqi/lEdbmZTI0yMDs7Liv/YSR3S+L2qHWRWE9m
X-Received: by 2002:a05:6000:250c:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b5e7f3b047mr16777142f8f.25.1752506657904;
        Mon, 14 Jul 2025 08:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgw0twrOXJl14XHoT9KdirKpxc0GUYVGI+Vrz9PtEtgVkL77KS9gg06YqYOwBZtiRhE7VT7g==
X-Received: by 2002:a05:6000:250c:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b5e7f3b047mr16777107f8f.25.1752506657390;
        Mon, 14 Jul 2025 08:24:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dc3esm12579651f8f.47.2025.07.14.08.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:24:16 -0700 (PDT)
Message-ID: <0c78bc9b-8aae-47ba-9679-423d862591df@redhat.com>
Date: Mon, 14 Jul 2025 17:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <c57a0048-17dd-445b-8d92-4c8cc6f47d17@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <c57a0048-17dd-445b-8d92-4c8cc6f47d17@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:18, Lorenzo Stoakes wrote:
> On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
>>>> or sth like that would surely clean that up further.
>>>
>>> Well, I plan to make this not a thing soon so I'd rather not.
>>>
>>> The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
>>> preparatory work and next cycle intend to do more on this.
>>>
>>> So I'd rather avoid any config changes on this until I've given this a shot.
>>
>> Sure, if that is in sight.
> 
> Yes :)
> 
>>>>> + * only do so via an appropriate madvise() call.
>>>>> + */
>>>>> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
>>>>> +{
>>>>> +	struct vm_area_struct *vma = madv_behavior->vma;
>>>>> +
>>>>> +	/* If the operation won't discard, we're good. */
>>>>> +	if (!is_discard(madv_behavior->behavior))
>>>>> +		return true;
>>>>
>>>>
>>>> Conceptually, I would do this first and then handle all the discard cases /
>>>> exceptions.
>>>
>>> Hm I'm confused :P we do do this first? I think the idea with this is we can
>>> very cheaply ignore any MADV_ that isn't applicable.
>>>
>>> Did you mean to put this comment under line below?
>>>
>>> I mean it's not exactly a perf hotspot so don't mind moving them around.
>>
>> I was thinking of this (start with sealed, then go into details about
>> discards):
>>
>> /* If the VMA isn't sealed, we're all good. */
>> if (can_modify_vma(vma))
>> 	return true;
>>
>> /* In a sealed VMA, we only care about discard operations. */
>> if (!is_discard(madv_behavior->behavior))
>> 	return true;
>>
>> /* But discards of file-backed mappings are fine. */
>> if (!vma_is_anonymous(vma))
>> 	return true;
> 
> Right yeah.
> 
>>
>> ...
>>
>>
>> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
>> mapping?
> 
> I'm duplicating existing logic here (well updating from the vma->vm_file check
> and a seemingly pointless !vma->vm_file && vma->vm_flags & VM_SHARED check), but
> this is a good point...

Yeah, not blaming you, just scratching my head :)

> 
> For the purposes of the refactoring I guess best to keep the logic ostensibly
> the same given the 'no functional change intended', but we do need to fix this
> yes.


Likely a fix should be pulled in early? Not sure ... but it sure sounds 
broken.

-- 
Cheers,

David / dhildenb


