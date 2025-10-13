Return-Path: <linux-kernel+bounces-850563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52260BD32F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51AD4F2168
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A8274B39;
	Mon, 13 Oct 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1jQutBs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C014C6E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361749; cv=none; b=k7ta3O/28EufqcGAQvQ9CqaVzag1MIFujqts2buHA0k4veidFQorke56rvIq6wXVdNvcVe+yXfmfma1JBIHa28wvUJoqGZIpgdLknLLxxpHmkSyY/1PEJiIo9WN1Abx0oH5SuzBoCeM/vKMAdcTmB+1Bu8vaWGAsqyz0pPS6Wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361749; c=relaxed/simple;
	bh=BySA3tFC1OKx/youvjikTSy1ia6s3hfuIyOoQv4/W+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SckJpavVS8ObIrmGQYRTR45R5ohgA1MGczTnhSLbAoFVl15ZkWYG4wGbKX5cQLWXuwWg3daOpR2pPaiM+ySC3+rlM/91ByrMmHJ2staVGicAMAfglkiRFMnFD6XQ/wGDZ0SvF1dxt21REp6Ob0n9xynr+JjykwKvWC/4MJF9ZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1jQutBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760361746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z0KkflN3MIv6NkWLO58LEoqRVvjmRV/CHPyFSmhS+M8=;
	b=E1jQutBsoolUB0PTnKxLRRm+1ajMW5zb33tkqCG3ftN7RCPqfItPz92Cx9jmZ7TvmG7HmS
	0qYadeD6HAss8RUVM6lyP71qmW96uZEsoX/8pNAf2oqCRvk5yuAm91KcM4I+nBtzJhgdPU
	+zNAuooKVwrXBq86GqhGe+d3eLkapxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-kGuPz-7QMnqREJI74c4ElA-1; Mon, 13 Oct 2025 09:22:23 -0400
X-MC-Unique: kGuPz-7QMnqREJI74c4ElA-1
X-Mimecast-MFC-AGG-ID: kGuPz-7QMnqREJI74c4ElA_1760361742
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so21391325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361742; x=1760966542;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0KkflN3MIv6NkWLO58LEoqRVvjmRV/CHPyFSmhS+M8=;
        b=EVe81/UjDTYebuDw697ER8GfKTm+vLs2SZvtKezN9ZnozryRURY1ihk5Y+K57AJaGX
         ZKcnY5oS5GhS5O7JPgu8j7M8pfvqvF9Xxcm0TELLfpWWaHMObwmI8R6kEXnzgkjaEqVF
         sqWrevPRfEMJ3CDdhOzxAhrNE2oBchb0kyVfbR+YsAG/F0JhBgy7/ADD+VUanx8Z/47Q
         2sNSkI9h9QY9TQcO5e5pPFX0iPmtAoThrG+k06fSKMBjCLbheH+a+LA77atxQo6DKgNV
         w0dj7HFZIK8bUU87/fwc5IJmqtmSmJjX+01H8gyHlFU1j1gIaaK+SIi1wugMJjut/vRg
         QzRg==
X-Forwarded-Encrypted: i=1; AJvYcCUmwu25cWxJp0lgs4k0J0FInzoAzjsmA6K2ZEprKrhaTqiKFrPB/CK3IEovLcJhtSusm9x+uqP6TqAzPSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3s1Lmf80+vpbdEo+X/yG5fwpnRB+WH0IuUxYj2cZgvrHO1SX
	LIbhOL9VbIyOvDzKx2Yb1SjfUHtg13X8DT1FMFAbCOjGGqcuAEzRONelCv3zGPTvwJ3zRyuzgry
	2OwpsVFTBWEgzoS3b9mWUGu7Ohe7SnJOg8xifZlbxulQ6D9Tp5jauDsslT5pVKjO/Ng==
X-Gm-Gg: ASbGncu1jlsZCxA0jnSR71WwHOEB3Ihwn01LzZ8GvMnZ6In0PK4px6O8Qf4UOi6vT8I
	KgIYYs5UhfzoujlcgI1wipi3qfwMuYC4sRt8HEJ6XLdXrOyhxusfu1grqgItwyn5YDkgxoftiJ6
	/3ESHlGXb8sLmY7dB5La4PCzMw3AKh9Dc1uZoi+vpV1nLYUbzv4EprAfuyaXepOlIhC1DElDQRw
	ps0PgoClQTzyRjnVgWdhz1bnC1kLSOV6ES+QlaGweyc0nS5K1k6Kktfk4WlfbInW5LJdpZE3grm
	DpnlYRNj9Xps+yIuJ6D3OjHoMkDsory+khaWUuvPk/ezAhxSC8bsEXSaK2ecj0geqzuHSBHsapy
	7uys=
X-Received: by 2002:a05:600c:c096:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-46fa9b937e1mr97710095e9.0.1760361742508;
        Mon, 13 Oct 2025 06:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5rdzWNSycD4oczVz0gUzgmEZCFNszd1maDs9/YNTUGTmr+LgQ4fp2tcaZl3hCCXTDOyiyJQ==
X-Received: by 2002:a05:600c:c096:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-46fa9b937e1mr97709845e9.0.1760361742038;
        Mon, 13 Oct 2025 06:22:22 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497b8fcsm186059275e9.2.2025.10.13.06.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:22:21 -0700 (PDT)
Message-ID: <1638fe08-b0f4-4dd0-99f9-366796b74ee2@redhat.com>
Date: Mon, 13 Oct 2025 15:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
 <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
 <fa2d7db5-688c-4d04-abcd-a60f79a6bb7a@lucifer.local>
 <71803dce-3fa6-494c-a4b1-55d98fc4aadb@suse.cz>
 <bb9cd331-326f-4ddb-8848-60195e41f012@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bb9cd331-326f-4ddb-8848-60195e41f012@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 15:19, Lorenzo Stoakes wrote:
> On Mon, Oct 13, 2025 at 03:07:18PM +0200, Vlastimil Babka wrote:
>> On 10/13/25 14:57, Lorenzo Stoakes wrote:
>>> FOLL_* flags are an anonymous enum, enum fault_flag is not used as a type
>>> anywhere, nor is vm_fault_reason. So those are both kinda weird as to why we
>>> even name the type (they're in effect anonymous).
>>>
>>> But also 'we do X in the kernel' doesn't mean doing X is right :)
>>
>> I think the example to follow could be GFP flags. Nowadays there's an enum
>> below it, and a layer that adds (__force gfp_t), so you could do similar
>> thing with vm_flags_t.
>>
>> However I'm not sure how compatible is that with Lorenzo's plans.
> 
> That's defining bit values in an anonymous enum so isn't really comparable.
> 
> But what it's doing, ultimately, in broad terms (other than the opaque bitmap
> type I'll be using for VMA flags) is what my changes will do.
> 
> And yeah, trying to do duplicate that is not really a good use of time and will
> conflict with my work.
> 
> Overall I think this change is generally unnecessary given that I'm about to
> radically alter how VMA flags are implemented, and actually will cause me
> problems.
> 
> But as I said before, I'm happy to prioritise the change that specifies the
> flags based on the bit numbers, I actually have it ready more-or-less.

Yeah, let's do that if you expect to have it ready soonish.

-- 
Cheers

David / dhildenb


