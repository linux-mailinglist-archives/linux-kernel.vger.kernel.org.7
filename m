Return-Path: <linux-kernel+bounces-839907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A0BB2B32
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5313AF7F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CE2C026D;
	Thu,  2 Oct 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/RWQxIO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1556846F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390509; cv=none; b=MlQKIKjg3DaaRcIi8aTQlNKwBKuMMIWKy1GIoL7Q180ZXxzgp0UJyaQ0zvr+0V5rfv2/xateej2iKzCSkq7EGuZ7pUcLjaLzQqM1DoFmcHaw5aY0ln2isFaThaIh3+E9r8UKValrWFp4qWdrJqWj+ejIP6Gz5zc1CYM7PQRuur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390509; c=relaxed/simple;
	bh=0vWaRenAEZPjMFPP0lf12dqSolnhFF0hMdlM8dVdtrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR0uu7wrdd5sfp8Sn3pjVSKmVggvODk9jtRrKewQP9YAyFeNopD8V1Ec2IhwySPwM8dEoDIO8wtnY05ch+A8Q+3YXJmwzks/blPBViiuZImLT4fvtq1BfT2NbRW3ZQbneL12adj7C3UWQGyVYPfLz1q9yV3JG+KbrsRdq/gGv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/RWQxIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759390506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86Vq5R/AWWxcpYDogfWJwRtuGh+AWS5EijwWmr2aWDI=;
	b=J/RWQxIO7UNYwmTqQAPUiG4CDIEXTsTcVZcSQx9u6ZKrSQ/A3CoD7v5Dos8qQoR63VScQL
	+aWTka/gA6gI8qA8yNooHqpnHmRyidDrVxpP62f1xC8HFTxn0fKz2a4C4IPMS7mGaRSPW3
	hk5OkCal2Jur0Qada1GuParlsMc586k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-EoPhuXmjOHOU_8jnN0VzDw-1; Thu, 02 Oct 2025 03:35:05 -0400
X-MC-Unique: EoPhuXmjOHOU_8jnN0VzDw-1
X-Mimecast-MFC-AGG-ID: EoPhuXmjOHOU_8jnN0VzDw_1759390504
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4335fa87so3183275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390504; x=1759995304;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86Vq5R/AWWxcpYDogfWJwRtuGh+AWS5EijwWmr2aWDI=;
        b=g42RWh1/MnIFQPU6GJx/9RvV/UwTQq1OXfqJYgmIAf3n/iC2jn4qNC69/sRWogPCa/
         fE+UrJtpojUWSh0cXL3TpyAT/gfn92WTPF83CYhhCM/0dqSfGHN8pNuyFef7d8B6/9Et
         cqW/45xyuBrKB81pGDz8zByeyjCl2EOodUCT1vRvxF0ROJ9+BoHErBbjduM713FOOxBF
         OfnVf8hCQgTcEJYjbx3ubcwpouHPiWK6Y01NSep94mb1v1H25prt1HMKqjBNDFbGDyK3
         4NavY35qEce3c9wDc9j3XxAtISrz2nr1sNTmBvsPTvJpjggUppjMZSh9GjrpmdnOdmiS
         0NMw==
X-Forwarded-Encrypted: i=1; AJvYcCUo3Mh283ZYFVmOZs/o1UnikXTmiWWfV/qMMzQjf71xMwr8yCEC03+TtJAXlSSGwTiUQk0vCoHJUxOICgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+Q3I+cE9Qa/hNN5G+8PRM16vAaM/k/7+9L8N72OtnsGDTeEF
	mycKmdetJTHS9JH/02jTTD4/wvh3aieEvOzW692ugEqOu91pQINRXPNCJVlvzy0rZHsjqdapAN3
	ew5mJh+T9EUZUumIFiUyPTlWjV6/47APIaNi9XDihNzExrYaVzqxrLJc5BeFRQzoxaw==
X-Gm-Gg: ASbGncutfko+lCC5qyNBNWVS1drKnFRJ/u9lYgYeV7ucfMqT5O7T901yu39Z6catFLZ
	tYvH3gRu1jjZwjwvqXpWXM9sfRrwIUgNDS4uxQYjQCcb+WvnrgdfC6oXG6xL4h6uPI0A4YcvfDX
	VaBtnKvhWkV4ZLLFm4B1+HIE2I6UY0YXbvD3UeyUnVASyDzFqy9vFJx8xO/ly5sNHBTNz0L6ex8
	Q0VUXk9D+dY+H6eILOoBTT61GThAJPl1rurDurHAiVnaNEDNglYBO0hKQbB3Mp6LsyFFQD+vUJy
	azuKy7EED+H7/EJpgeL49MDu98eyYAjBSdP4Hb47r1ufcyR/E5zIk3bQg1p4FcnAUi8X6rWc0eU
	EJULXv6sl
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr44635635e9.18.1759390504375;
        Thu, 02 Oct 2025 00:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD4HH0nVViWrXg7TeX6u6AgfVrPfMMJghbuLvV3OHL0cr7gLl6gQ1fqpMX6H7hU0Kfl0cLxg==
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr44635235e9.18.1759390503885;
        Thu, 02 Oct 2025 00:35:03 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e611970easm40105015e9.2.2025.10.02.00.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:35:03 -0700 (PDT)
Message-ID: <fc52e463-5704-4713-9c91-1e4fa0d58047@redhat.com>
Date: Thu, 2 Oct 2025 09:34:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] mm: ASI direct map management
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman
 <jackmanb@google.com>, Andy Lutomirski <luto@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
 mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
 derkling@google.com, junaids@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, reijiw@google.com, rientjes@google.com, rppt@kernel.org,
 vbabka@suse.cz, x86@kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <00e7ff5e-fe6c-4edc-9bf8-2352321f74dc@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <00e7ff5e-fe6c-4edc-9bf8-2352321f74dc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.10.25 22:59, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> Why is this the scope of the first series? The objective here is to
>> reach a MVP of ASI that people can actually run, as soon as possible.
> 
> I had to ask ChatGPT what you meant by MVP. Minimum Viable Product?
> 
> So this series just creates a new address space and then ensures that
> sensitive data is not mapped there? To me, that's a proof-of-concept,
> not a bit of valuable functionality that can be merged upstream.
> 
> I'm curious how far the first bit of functionality that would be useful
> to end users is from the end of this series.

There was this mail "[Discuss] First steps for ASI (ASI is fast 
again)"[1] that I also didn't get to fully digest yet, where there was a 
question at the very end

"
Once we have some x86 maintainers saying "yep, it looks like this can 
work and it's something we want", I can start turning my page_alloc RFC 
[3] into a proper patchset (or maybe multiple if I can find a way to 
break things down further).

...

So, x86 folks: Does this feel like "line of sight" to you? If not, what 
would that look like, what experiments should I run?
"

Unless I am missing something, no x86 maintainer replied to that one so 
far and I assume this patch set here is the revival of above mentioned RFC
"

so it might be reasonable to reply there.

[1] 
https://lore.kernel.org/all/20250812173109.295750-1-jackmanb@google.com/T/#u

-- 
Cheers

David / dhildenb


