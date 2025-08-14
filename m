Return-Path: <linux-kernel+bounces-768460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF3B2614A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB98F17AB00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE52F746B;
	Thu, 14 Aug 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMloAvPG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9222F657D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163984; cv=none; b=RAPcz9SLJPwSIywdof9iQ+giE02Z68epPYwsQVRiilBTnwjr70eIz69p80ycxnuEwKbX0W3oEpAArUsdD4IMAO1aoFv3zRJw5hi4YLhYBYFDCLn+VyvFhu5jAWheqJCR5hseVmFzFCLdBumpvtsYFm2glUDwKI0iLWtZpq6PcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163984; c=relaxed/simple;
	bh=8+gaspCBPH2BmqGDMzxvYdQmbbFiqqrZqKksukzIXpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJOjo3hAOYM0LYeEzL3xWOItrpx8OxcvbXbcGjx5bIEhSW2uF2dFss0ippi2lPqQfPuSxbvMASRYrRfwUJ1gs+zG6+p5z5nY4iyfq5xtROGyz5RWlDgmhQk86H7s11kdvVYgkgEAVCqAmIwoMlUcA69JXhkC57n5GYmbaEbEtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMloAvPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755163981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GMzTeLKcWhTf4iVZGggxMfnkQYcpqepRV/VUJ/SbUEw=;
	b=SMloAvPGC3Faiq1x3j2PhRLJtWGcxXJ4heb6vsFEPSJWM1VFjjx045G/KDYDIoSmavu4Sx
	ipFwAsJxcFeyMjl82xfyAnceo0leBiULgRzMCAh44C1i9HEDeKt+0QZKWSr+xRVQkWjtTu
	/Vdn2A6N2uV0wqh25Hwvr1JsZtapJ6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-9X4Xtwj0PyeqeveYybm0Sw-1; Thu, 14 Aug 2025 05:32:59 -0400
X-MC-Unique: 9X4Xtwj0PyeqeveYybm0Sw-1
X-Mimecast-MFC-AGG-ID: 9X4Xtwj0PyeqeveYybm0Sw_1755163979
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c2c7dso285199f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163978; x=1755768778;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMzTeLKcWhTf4iVZGggxMfnkQYcpqepRV/VUJ/SbUEw=;
        b=Lpapm6W6OXaC1b0tY2J2+177IWVZt06zeelpt3+TlFfQzgdBz0xHJG2+1HZYfpeR1p
         nLS/LkDPFBgFI1AEU9+EMuMkIaeK4eRRqAPMmX8X2YsY333D7tWRG0qNtrixd5CsCKFr
         ZJuKG1iSjyYYp1abGvYHmT0ByUO/q+94dwkQ0y4vN1RMV6gsDlU26vuyuePEPQF+AM32
         c1h4LpSL2sngQsHctk9SBro7FSXyStXa2DmF6njdqPU9H+0mDejQBSJwwzj2ry/peVdW
         OIGqIdhX5pxMRFYxC4EQE9peezyRqAWA9Is3F2q7C5VeVzXp8z2f38lA4BVOiONVJqJY
         T4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyqj5bCppn/LLOnfP31af0XOAbFlDU5MAx6YIrfpt5PoBBI7l9o60X7INxtk+uxxtdwQr7xmU7uq2yRvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fRmsnpZqOC+npkgCqgjP1p1ziVwOcy108Ar714xx1qRW10K4
	R/pBv/MvUQ1qrKbHv3uEfPr3hpvvbUw5Z+T0TBxkNNmV9wbo+JtME5rI0HFASp+Z3/zukno8xsD
	u+C9T/GMirFiLZVpcfEvUAQ5/rKssaWhMDX1JBpA2SJyUPpL9ZOWkuvKnCZ/Qzagv+A==
X-Gm-Gg: ASbGncsEH+ZaHm9PE6aV7mEnUX+M6a5GEB+Lx/KhrSx7mM6TDPKTkhjmsGol2WPtxzn
	qBSKnREwOJTOdN+XzfGG9ohtCpNSy14BlyHyNhyp2Q28r1kL37jU5g1RbGoAVYem5rki57/Er7I
	AZyXpityJSH8SY560i05/dy3lmololD25cxT8iIu9b5uAJLm+9EBZ6UBPWaSFKTsFfs5DR4KpcG
	Jyd0c0p3IzBp8rIt6ydr0SAaaYZ/TWdsZCJi2W8wNFT47SKY7xOfg2I1duEuBaUQOpaRJ3fCi8F
	EAp5++rU1xoQGFKWdkvpWl12P8BZAiTuF/QyDHiwBw5EViadBfXW3nrc4TfIDBAxmSlUk8ViGYA
	w2p+K1h7BUKiBYO5O6HyCr0YE8BVeei+HHrRepE81Lv29uKVOkVHj4GpmyxOceFJOqHs=
X-Received: by 2002:a05:6000:4382:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3ba50c8c664mr1617149f8f.10.1755163978341;
        Thu, 14 Aug 2025 02:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2oGshb4DHtBMJX3AYJx6OhSIyaVlvomoFgis897HZlNVBBCVv2Ear2P6hRujX/4qjnEllbA==
X-Received: by 2002:a05:6000:4382:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3ba50c8c664mr1617113f8f.10.1755163977901;
        Thu, 14 Aug 2025 02:32:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3e00:9fca:7d89:a265:56f3? (p200300d82f443e009fca7d89a26556f3.dip0.t-ipconnect.de. [2003:d8:2f44:3e00:9fca:7d89:a265:56f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ba54b6c93fsm688042f8f.12.2025.08.14.02.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:32:57 -0700 (PDT)
Message-ID: <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
Date: Thu, 14 Aug 2025 11:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.25 20:52, Lorenzo Stoakes wrote:
> On Wed, Aug 13, 2025 at 06:24:11PM +0200, David Hildenbrand wrote:
>>>> +
>>>> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>>>> +{
>>>> +	if (!thp_available())
>>>> +		SKIP(return, "Transparent Hugepages not available\n");
>>>> +
>>>> +	self->pmdsize = read_pmd_pagesize();
>>>> +	if (!self->pmdsize)
>>>> +		SKIP(return, "Unable to read PMD size\n");
>>>> +
>>>> +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
>>>> +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
>>>
>>> This should be a test fail I think, as the only ways this could fail are
>>> invalid flags, or failure to obtain an mmap write lock.
>>
>> Running a kernel that does not support it?
> 
> I can't see anything in the kernel to #ifdef it out so I suppose you mean
> running these tests on an older kernel?

Yes.

> 
> But this is an unsupported way of running self-tests, they are tied to the
> kernel version in which they reside, and test that specific version.
> 
> Unless I'm missing something here?

I remember we allow for a bit of flexibility when it is simple to handle.

Is that documented somewhere?

> 
>>
>> We could check the errno to distinguish I guess.
> 
> Which one? manpage says -EINVAL, but can also be due to incorrect invocation,
> which would mean a typo could mean tests pass but your tests do nothing :)

Right, no ENOSYS in that case to distinguish :(

-- 
Cheers

David / dhildenb


