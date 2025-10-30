Return-Path: <linux-kernel+bounces-878509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F72C20DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A971A268DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9B328624;
	Thu, 30 Oct 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1QOds3t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B9327208
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837045; cv=none; b=EXaT2PU73547/Ffgf5t6gjXRz1hY0/8S3heVVj+/FZVGiMPGWLI1FrQclsQ8lnKx+CNU9YKPy9vk9BOOpLIxFcdBMLAu7ZvSaCxu6pBKt1Kk4qBDD2Jru4fCHhcvWLgwiqwFGBMEEIniIjiKmnuI3hvENIsKd/OahGCtxoS8eFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837045; c=relaxed/simple;
	bh=iDmEJBVp46fcT0CkdrnVmOa5uOg5MoMhiqO85juqzGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCX+BSzkICm6oqqBrZIXezMT/WZgOWVZ1DdKpoUTylQN78KNTlVf5MHwHJ99Fz3E0urGlXcm8Ew4SwckHYNPLX91El5I/jS+Z4206WmVjqlDa5UlWVzPIHFj+qDgnA5HOxcmQVsg9k6LG14Gj5KBo4rrP0ewnmjFTukLgPUuwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1QOds3t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761837040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pDCQK9hlLE+TETBGIIHqM4Q6IjU8KzujqNQtOJ112xA=;
	b=N1QOds3t5J3TKBZ/SfCUpWiFnRxLhr85AGvfZRFXVrCuhGTN3zaAdeOK6DXJcA4h28x4Em
	rkFIz2+ogxHu3eSmgzuvQa9gdZwmNmv5/jGtkPFHVXiCC4SxLTyiuBnMXVw00Fcsq1Za17
	HEAKWoYjO1DkiDxz5nWCTNQUmPru9GQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-KR53n9QeN-aMkV-0O5K6OA-1; Thu, 30 Oct 2025 11:10:37 -0400
X-MC-Unique: KR53n9QeN-aMkV-0O5K6OA-1
X-Mimecast-MFC-AGG-ID: KR53n9QeN-aMkV-0O5K6OA_1761837036
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475dd9906e1so7184515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837036; x=1762441836;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDCQK9hlLE+TETBGIIHqM4Q6IjU8KzujqNQtOJ112xA=;
        b=dzb6BxzKiCkiM9D6gIF2Lq/1gsxuKi/TI5cRJgDzh0a0jKjyIJgAfqJrQDc+T48XvT
         LgLZVLlQ1pqiSltiGWGK42CXyeoClNfEUZRIZQSaJTBz82TIKaxYDa7Rj1SynwluWYmQ
         LDSK18GSSLa8vteSJRGX7pC8l6HtYZoIrY3MRpi6zFmZH+n5y8i3C7y0BKi6CDBEeX+1
         95m5AwvczdZQxumogg5kP7r2iQsNgwiIWMQALlHaA8/fZXsezu+LYYDIjUcLPXk4zirR
         HLQp+N9HFGxqCPOYNj8M+vMNr1wbSsEccjmQ47bfl6aEtEJFc038CSeRIUkIWS8DaugL
         onrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqEv5Bo+ZLT+kJ3iZXs7iaNDpkUy4AjsLVLeSwD1cNu4/6hbo4AhRY9upjdcqFMS+cYxcd+rvSIjTg26k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/b3I3EurHRiuzcxOz0t8la8+CXEDYXlJSg8eDI+cC0vZUbFnn
	ggDH8Ft9W0oBHUMwPYg1C1SRwxf3MfZMxUhjLHx+XWdOR24puAjvdCvzOKeXWRbwX7jswJ73p/U
	H8RyL+U0kW+h12wC+0iwIlW3uBxEKGc+13U0X5K+yzO7Iey01BhBWyeZpoUJctI27Mw==
X-Gm-Gg: ASbGnctFJowtpiXA9fCzj66pb8iRxVmwuj5THdxBSp5slla076zoKykifs7Zw4+wZoi
	ZQw2a7AH+MbLlqab5xe3Emz6FgK0H7MyeeZ0HOyT3Wd7a74UaFxXik426HGdqOvpNop9tGaEdjh
	8Ci+nGE9T2yqKsAIPdbIzjCIR0qyRDYe+tHkoWKw53gDNn1+OIldByKgxrcaAiw3qUpPW4Y2dHD
	7YtkCydQjVIBOKQOxQVGxPnzL/vKSP6L4VyR2hWLVa2CXRiZYPPGuxwRYT3oJAYVXxo0TSjvZP7
	g/Xuwv6xqL4QpPY2rXTHMZDRws7io8Kq7+kKdz9YSIXzWkGcOuByYBtk8ncMwSem9FPsA4xFqrg
	gGF4rVArRn4uF4krr505Br/aJ3/1t+JxRYHJ6wEmVw9e8mysjLu2kd1R4J2z9dgWXpx6za7wxgA
	H5qiJw4tTr0EJH0EBvIHL35cMKDOM=
X-Received: by 2002:a05:600c:6389:b0:477:da4:364c with SMTP id 5b1f17b1804b1-47730797bcamr672115e9.4.1761837035740;
        Thu, 30 Oct 2025 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KUGeZbzNKm7MNGtt8D6Fso8lLniBFswbKsZjSsZ0KgGlb6Xh2MXwXuc5z8HUy7nMGWyBeQ==
X-Received: by 2002:a05:600c:6389:b0:477:da4:364c with SMTP id 5b1f17b1804b1-47730797bcamr671735e9.4.1761837035238;
        Thu, 30 Oct 2025 08:10:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429bb752b49sm1353322f8f.9.2025.10.30.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:10:34 -0700 (PDT)
Message-ID: <4f68e609-a40c-4844-ad40-9ed31c88adb4@redhat.com>
Date: Thu, 30 Oct 2025 16:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
To: Heiko Carstens <hca@linux.ibm.com>, Luiz Capitulino <luizcap@redhat.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, osalvador@suse.de,
 aneesh.kumar@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251030145505.2764038-1-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.25 15:55, Heiko Carstens wrote:
> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
> 
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
> 
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
> 
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
> 
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


