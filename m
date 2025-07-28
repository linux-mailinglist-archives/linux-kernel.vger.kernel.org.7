Return-Path: <linux-kernel+bounces-747941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F08B13A76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DA3188E4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D026463B;
	Mon, 28 Jul 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K09GPt00"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A8264625
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705657; cv=none; b=r/pH7AdHXLJqcxUAcuz/AsYep+MNVEOlxNcDrN7rfKUltvqeoJ7TthBejKMcY5GuL/qZ3pC2pgrGbXsHMPx1Bx1JRvgJ8sdzK4h/eTIhy/kd+jyYHyG+1uMfqeVFNmzNK27PhtZo6zXxLumJWgU4C5G5LeKJq0FQotFuGu3BkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705657; c=relaxed/simple;
	bh=XAgVDIELi+uc68FVjKmKY9SDX6l+ENxkpx9fvj3ZUwI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sViOONAfAiJgAowkLdJzODUC8sKmcrpot7LZhpfLT/2cJndADvFupV45fdXonEOhuYKP/t0Z0bBp2LJZTRwtD/uthwEUMeHczQC4wuXRgi/g6DgpgTksavuAeBEb2YshWKhPhHcRGpozWmED0sVpcy1E46yUstg3n3CmSixUbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K09GPt00; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753705654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nhndmh/mYDlCWe6LknGjpTmGbUX3l48dYqfaHjSz4Cc=;
	b=K09GPt00qAvZ/y9k3S87y4MQ0T/wzPTCn9y4D1eZfr6mB6gMeuhvk0GxhWeeyhigdjhHKi
	y9aFkQyKyJEv8cNY7Fq4T+32HIUnOArdVICMB/gxjHylqrIM9o3Fimpor4+DfcXndeoX77
	TbFfcjuBPJIQBxfSO/6skIbVTpfJYCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-aZob_J-kO9WsJKbhNLIteA-1; Mon, 28 Jul 2025 08:27:32 -0400
X-MC-Unique: aZob_J-kO9WsJKbhNLIteA-1
X-Mimecast-MFC-AGG-ID: aZob_J-kO9WsJKbhNLIteA_1753705651
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b788d00e26so494254f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705651; x=1754310451;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nhndmh/mYDlCWe6LknGjpTmGbUX3l48dYqfaHjSz4Cc=;
        b=tckjsEbFInXvAnv0c3ZOizH/PWRPLxLlV7tGDkQMHcCoow9k04B5NMhgBsFKEpKjFR
         FmivsA7wxSQU7gyBl3wxbZBTy7Q7SMapBg9lpIWyBF2sxBFuYNcvRNdKO0ofLxs3CO4t
         kXdWGXQwHOAe+P0FCkKxzosVRnRyGV3vmnKkF9IGezzyGtT4AMXI6ncM5xwvvYuKi4rY
         6ou7bT57afbkJN6HboaJ+68VrQWeGxMq2R4FSF5ciK66an7L+XbEg4IXXZ0JDNFbb9B2
         CXINcDCsITXUHL9lkxOj4drTQKjqntGZ1FmoN66q6RH0PkDp0++fwcAzLLsh+ieH3vTl
         Z51Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9vCzsEsJjuY0r6m5LuFRssGuZl5R2CSPtEmUyrocu1GnZXgHBO9x38lBJBzEEfLHC21cHf3s6d9diOvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcn9ozdKpzCaHPKfYXGqU3kh89g1z95+8AlsXBZaucSHa5Wf7
	/ph+FOQmRJR2HFix2bPCWcNv9qWcrm7aM3K9t3I5Y2D9ZY+aQo3pVtTZ1B6SFYS+X32KNA5Gay6
	xml9DXpoAxA4Oc7goCwPBUBG4wetljJ2UVv08MtOZ/P48yQ2BS0p+Q6VHDhAGXdlg0w==
X-Gm-Gg: ASbGnctRZwm3O55YLyD5hmmxMvvojVB5FgQum26KEvizxdMGxvGU/Zi2qo9h4MkXFDK
	lyWW7ixTjFX++jwvSAL6FW5yHBcGiLp946moyi5AOVuVCbJfEWNXKNyMm09sOOKTKL2cxItE3h1
	c7VtKWlKaSiMadQ08u0zfEeF5UYCukU2BnJXGEZEbWgIl95ZkhyZWTT4FDHfDW+nzm4OBwWzxJ6
	ovXRS6734M6UYBg37/DCGdRbodEuUjXlt2+HjeyH6ebdPyu3dXygUIeHxhioKaZi+02KEILu8TQ
	pN/astytBt7tk3/+sPrvtnP7TqCIhn1QjkqJ9BHuK+siJL2b2nqCWPYZvbDVWPMMMgjfh/maiQ7
	fNExBgg9nEDWwe/i8yT/Ef5A9v7ZYFBl8sSWJItLM8C7iXBUb0BM5QqZLEXg+Cwm6TUA=
X-Received: by 2002:a05:6000:4026:b0:3b5:e244:52f9 with SMTP id ffacd0b85a97d-3b776763a56mr6925075f8f.40.1753705651365;
        Mon, 28 Jul 2025 05:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFifIQiKDQs73iiVRO9b2dDYen4CTUw0MtmSxVaPuUV0RwNn2LG58Cy75mVAwqs1jz0/x8p5A==
X-Received: by 2002:a05:6000:4026:b0:3b5:e244:52f9 with SMTP id ffacd0b85a97d-3b776763a56mr6925052f8f.40.1753705650797;
        Mon, 28 Jul 2025 05:27:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b783454d65sm5807523f8f.1.2025.07.28.05.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 05:27:30 -0700 (PDT)
Message-ID: <a06922c2-9dad-4449-991c-913fa7765bc2@redhat.com>
Date: Mon, 28 Jul 2025 14:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
From: David Hildenbrand <david@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <aIdqVNCY-XMNICng@tiehlicka>
 <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 14:27, David Hildenbrand wrote:
> On 28.07.25 14:17, Michal Hocko wrote:
>> On Mon 28-07-25 11:10:44, David Hildenbrand wrote:
>>> On 28.07.25 11:04, Michal Hocko wrote:
>>>> On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
>> [...]
>>>>> daxctl wants to online memory itself. We want to keep that memory offline
>>>>> from a kernel perspective and let daxctl handle it in this case.
>>>>>
>>>>> We have that problem in RHEL where we currently require user space to
>>>>> disable udev rules so daxctl "can win".
>>>>
>>>> ... this is the result. Those shouldn't really race. If udev is suppose
>>>> to see the device then only in its entirity so regular memory block
>>>> based onlining rules shouldn't even see that memory. Or am I completely
>>>> missing the picture?
>>>
>>> We can't break user space, which relies on individual memory blocks.
>>
>> We do have userspace which onlines specific memory blocks and we cannot
>> break that. But do we have any userspace that wants to online CXL like
>> memory (or in general dax like memory) that would need to operate on
>> those memory blocks with that kind of granularity?
> 
> I'm afraid that ship has sailed.
> 
>>
>> In other words what would break if we didn't expose CXL memory through
>> memory blocks in sysfs?
> 
> I think the whole libdaxctl handling for onlining memory is based on that.
> 

Sorry, forgot to add a pointer:

https://github.com/pmem/ndctl/blob/main/daxctl/lib/libdaxctl.c

-- 
Cheers,

David / dhildenb


