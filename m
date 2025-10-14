Return-Path: <linux-kernel+bounces-853025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A85BDA794
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1C4A354CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8AF3002B9;
	Tue, 14 Oct 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaG4Qskw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD032F90C4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456891; cv=none; b=rFcc9PUtL9yq3nKtJSbkjDoXGSgQ/TvhQPvLahtlDshe3HgZveNJVw847OWDIb+Kk8KC+IZBuyc6/0SjcsAdxWBmASWS/yhI8j9gUQFR1rKXqmHq1UVvMXija0PmH+D8MG7iNLkTAGOKuj/+TRLupNB8dIowimAM7rMMGOFKHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456891; c=relaxed/simple;
	bh=3W9fbxB/OAotzZ3iGb6I/PmhAIYa78rg2+9myGLg9A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBb3pMBy48RXVHLqy9rdVQSGkN7ldObEah5+7lKx9yR4h0Bv7gmX6yCAEFUJUoXUs5POJ9Elvm5OFyJkjmUDTTtqfnSQj/K2o2xzUEW30mC7jkLJKCIFhOILfX5UhI2syLYuraUnZvLBOXzO73qcIi4mRnH74oXuOul/yic3Mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaG4Qskw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Djb4neGqN7bdJt3lIbmkhjCyJV1zYm6kD6UrWD9JbA=;
	b=WaG4QskwyWZygHTqXpfQP5v10t6AGcZgb7UFxIf3R460WivDuqJgyiSkTqJHk2BB09I6zS
	uBKekfF+R86fj5h1jIoV5W2LzFS1pCV6KlFvFo6QIxraYbV463gquiUjKUXLy0Y4/G6GVG
	d89R98WkCsaU5C6naDfrCsNAv8mEv/w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-rVJRRwlDNb-h7CTuzPXX6Q-1; Tue, 14 Oct 2025 11:48:07 -0400
X-MC-Unique: rVJRRwlDNb-h7CTuzPXX6Q-1
X-Mimecast-MFC-AGG-ID: rVJRRwlDNb-h7CTuzPXX6Q_1760456887
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso4717072f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456886; x=1761061686;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Djb4neGqN7bdJt3lIbmkhjCyJV1zYm6kD6UrWD9JbA=;
        b=V1j1E/kjN5F6ANqoI3+icug5lFWe+cPlzV06Lasfb2ftepzE1B+iNzdvUnx8pDt0eY
         L5Yz2kVBfxlCTJbApIj4Kxq1DwBUCJPudcAjLkXzGVj/Hy1VJniWi8NzelNKcglfwmzx
         ajK8re1y5aPG8ioYDCsaPQUWw59FafhQLemjnL/9/Gex3U/Cb8NPgu/OmIhExe3eSqw9
         gHgh0ZHe+F6G23nsnSq9FioJiBUgW9QhRlM+hEn14bcEaAr7wGmIWeX+H8+nRptEOkk8
         ql4m/1+T/jlqCbhqBMgKFwrDVF1RuOAkRIggLVqk0/8cACPFdK8PV21XZh2SIrCLNh4Y
         YreA==
X-Forwarded-Encrypted: i=1; AJvYcCVaETWC15e0n9s4/B3Yi+XWudHhCJZi2Gv0gGkNsKujtMB6/SC0IF38Fj86BvCWasj26+N0Gk47JDtmgiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+elr2Nse8BOXqGNDs7wSHzlWMjfkaAmFNT498pXbXplS00bc
	37mMOUnWPM8SAlh4Q3ivI4h8fYxyhTMVCAo4SLbfjwFBaPnoFNj29co4mSMZ3Ryf0uq7SorOdKR
	hYT/6S7s5Hl13mxNRESwBVyLArFGvhPwKZvJWGdr37RPFXsqedfoLR9u4Z5ItH25vlQ==
X-Gm-Gg: ASbGnct8Qp31SH7/6bitE+Ki54zM0kZ1Vhsh4KYCb14YmFJF2cp08q2wnNd4/igfqeT
	6V4+6WXdUxoQ3nn+4zDTWIokzjEMPuS8Kj4c2iWXt7aMDKoGqYSeWCUqFZnxLeJuTy9OAjozGoQ
	7foMNhHxsG9SIQaG3A7eVnmBK6jIkbq2uhr/BUSGxhi3FRw0HchoD7FX5x8zSd7E3LVLPCpDxey
	gjjdBnzmVLmihBkwxvalSMyDPDmE9wBLl/Cga7H61XC18jrEfIXtlhPXqb96fyy55SW/EIEjRR4
	CBZOglPk1aXg310D5hrRhj3h+jCFp69fn10bG9gWhHmBV6SRvgs3/TEpFplEbAzazyKCUrJnXQ=
	=
X-Received: by 2002:a05:6000:2dc5:b0:425:72cd:8363 with SMTP id ffacd0b85a97d-4266e8e8190mr15447423f8f.57.1760456886654;
        Tue, 14 Oct 2025 08:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlooUl0jhUu6+zOkTx9Jkcb/unTNqnce5dFnPPyX4WIFWplBpxgrTnJwI9DXJb+Jk5kPYErQ==
X-Received: by 2002:a05:6000:2dc5:b0:425:72cd:8363 with SMTP id ffacd0b85a97d-4266e8e8190mr15447401f8f.57.1760456886215;
        Tue, 14 Oct 2025 08:48:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm24315396f8f.30.2025.10.14.08.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:48:05 -0700 (PDT)
Message-ID: <89d1f871-54e3-4c66-bd93-e8a08ff640d3@redhat.com>
Date: Tue, 14 Oct 2025 17:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
 ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <d2e5b099-94bd-444d-9946-182807443539@linux.dev>
 <c44e198d-7d46-491e-adc1-86cc306c27db@redhat.com>
 <b35b649d-5566-4467-8222-e358439b4f84@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b35b649d-5566-4467-8222-e358439b4f84@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 17:41, Lorenzo Stoakes wrote:
> On Tue, Oct 14, 2025 at 05:12:18PM +0200, David Hildenbrand wrote:
>> Can we please take a step back and make sure we are not starting to do stuff
>> differently than elswehere in the kernel, please?
> 
> The code already had the is_swap_pte() check in it, so this is not changing
> anything, it's just avoiding confusion.

Well, in hpage_collapse_scan_pmd(), in __collapse_huge_page_isolate() no :)

And then it's called SCAN_PTE_NON_PRESENT and it all starts being a mess 
TBH.

But as raised offline, I don't have the time+energy for that today, so I 
don't care enough.

-- 
Cheers

David / dhildenb


