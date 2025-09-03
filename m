Return-Path: <linux-kernel+bounces-798029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA9B41894
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AF21BA4553
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435A2ECD1B;
	Wed,  3 Sep 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ninE1jTs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6D2ECD12
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888209; cv=none; b=Ng4Rr9DiRsjSsd6/4xeT/GEv1G01LPZjpUulGBPp9RxL3DIH9Ee04g61Gc6PwXIbiwWMfkkfqRV1rZJ3kDI7wC0pPjTcMaeemzgxKXDwm+aoRZBXQ7PsxWdV7zpljAvHokLjtyXWRmpMdmZZksKdRXeXvjj0EIv3h9mA6urZkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888209; c=relaxed/simple;
	bh=QGyM2ee4IqoO4ff80h/Voxy6HQf2P3UnK9F4mMnDIs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plIXVnVVVUJR9jCQGx4X5s+fzqoeoiBKbZZV/esZMk+wbi3LF84Uqo9hp5PfG4A86zNW2N6r09418rZ8pXC4WYHjdchlyl4DnyaWg5pVfe1g7naJc7JztOqec557e0RxzKldSsFL7Hz4csxiqKuRHRalBL4N3puIewYjB0aEaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ninE1jTs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso9059803a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756888206; x=1757493006; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToHQA/WO9OU5kjyFTVmAcoyB7U+gWWYrhmpVg6h2BSY=;
        b=ninE1jTsvv/oNMErgMlm2Q7Pm8bTkbu85q+rXyfoIEoBnbuq7o9d01y/5NmoiH0qcR
         8EQjKlmDVQaJ3kFeUNnWtZwelQkx4HrMf+uunNirYHkrYsSaLa3fPGL5CO7BiLByIaOU
         FE/LF3eeqjByrmPNhOcRG8qGrp90oiyYg/8ioFVNHW3loT2rkOoer672WBUHLLRUzhm2
         IbkNGrSDdOmAVwSFuh7J6jTCsJD4AYnIWDa4EAGp4O21RfIvZ4xn5lYn6aU/fOOfDi18
         NvWSkHUu9jJU7rsHvpJMAVhlMWyfPKfa0/pha2Ez88nHD1iPRcuqTY3dIS8yYuzmhl0u
         yl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888206; x=1757493006;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ToHQA/WO9OU5kjyFTVmAcoyB7U+gWWYrhmpVg6h2BSY=;
        b=v1tamtns/m71gMVudzxMohBzcwWrKmGw8uXBZz4Y1l/vRBzhNh6egHMEmFLdrIVf7L
         wSsCJ/xVf7u1Cq6vbQlIMIpENrw9GIEmSYm63fE825yCgtYoHP0S6E5GLetGL1vbKd9n
         /J0YYcBVocnPUoirqc+75p+7HgmnpETf8xq+RwgD2ItHNrkrEfDT/L4AqPdZh1WuAU/R
         EMW5k7XjUNgZJRar1SA8H2nMIivZpg81jqD7IiDLs2zVGsp0rmutVyG/9JJOhudT9eoj
         6t2vHAOpCpAM5n3sNeIwfYlAG692PdzWfR0lD4uUgtoxQHiSi/VSnVhfRbZJJrsRMDsr
         abFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6lA0906/3bknVlaZf1OianjyxmIizObIIR4F82IZXUCcR4uZmoSvkCAXf7X2ko28zH4Ru1JPIGGSBInA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDnWolQextyTOiJwxPEZU+UEMttQcpdqbwSzJgRYrobEZAPK1
	hlbgkwSAqhW7UbPXetM/CulxS2bX2iwZHSE6A05gEg2NpasllQIBhSM3
X-Gm-Gg: ASbGncsxLDYbkjNXrMYB5i0ifkNUf7gmeWg2iQUhdG5PUmk6zpu0ZwxBDO32qn8C1Ef
	vNcHx9U7Bprg/Ci9oBzKycqmjiJdDmqGUcUxgQyWKv5+lCOCWKlKAbuwrRrqLz6r5CCTGWy5qFh
	ehLZroknfE0Z5m9Xm1LqE0Tz3cK9Bqese/fXat8GbRH+I8xr9pdxco+D3yq3F7GI1IiXpVpPTYw
	Y2LYxfNKjdzs5kYevqusQekw4Qacipn0zgY/P8yxYVKGTjUB3S5+ykNTQ1b83Cv0F6LS+s7pybY
	rEZlWyS6WmUxL+f5RaVfr8rm5uzrXL5w+rSiJlxGdTJT1cn6CL4jQpLgJfkpR5c1bTSG5BNmpZA
	0y2sWVHyjMDW+ch/bM9ufEhp0ODH50PRf04Sj
X-Google-Smtp-Source: AGHT+IHhZWH7PNZnwpRWoAG/J8OSiBEeiWXq7khV4x7jT3qB2TXGk+eD0qqF3bgluLXGBMowItPzWw==
X-Received: by 2002:a17:906:9f86:b0:af9:414d:9c2 with SMTP id a640c23a62f3a-b01d8a26689mr1364322766b.3.1756888205639;
        Wed, 03 Sep 2025 01:30:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040d44c9adsm949821466b.9.2025.09.03.01.30.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Sep 2025 01:30:05 -0700 (PDT)
Date: Wed, 3 Sep 2025 08:30:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>,
	akpm@linux-foundation.org, kas@kernel.org, willy@infradead.org,
	hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <20250903083004.rywppm5bvqskmuq4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
 <759bff7a-3918-41ac-a184-8c07ec414bb2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <759bff7a-3918-41ac-a184-8c07ec414bb2@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 03, 2025 at 10:13:35AM +0200, David Hildenbrand wrote:
>On 03.09.25 10:08, Wei Yang wrote:
>> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>> > Currently khugepaged does not collapse a region which does not have a
>> > single writable page. This is wasteful since non-writable VMAs mapped by
>> > the application won't benefit from THP collapse. Therefore, remove this
>> > restriction and allow khugepaged to collapse a VMA with arbitrary
>> > protections.
>> > 
>> > Along with this, currently MADV_COLLAPSE does not perform a collapse on a
>> > non-writable VMA, and this restriction is nowhere to be found on the
>> > manpage - the restriction itself sounds wrong to me since the user knows
>> > the protection of the memory it has mapped, so collapsing read-only
>> > memory via madvise() should be a choice of the user which shouldn't
>> > be overriden by the kernel.
>> > 
>> > On an arm64 machine, an average of 5% improvement is seen on some mmtests
>> > benchmarks, particularly hackbench, with a maximum improvement of 12%.
>> > 
>> > Signed-off-by: Dev Jain <dev.jain@arm.com>
>> > ---
>> [...]
>> > mm/khugepaged.c | 9 ++-------
>> > 1 file changed, 2 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > index 4ec324a4c1fe..a0f1df2a7ae6 100644
>> > --- a/mm/khugepaged.c
>> > +++ b/mm/khugepaged.c
>> > @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>> > 			writable = true;
>> > 	}
>> > 
>> > -	if (unlikely(!writable)) {
>> > -		result = SCAN_PAGE_RO;
>> > -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
>> 
>> Would this cause more memory usage in system?
>> 
>> For example, one application would fork itself many times. It executable area
>> is read only, so all of them share one copy in memory.
>> 
>> Now we may collapse the range and create one copy for each process.
>> 
>> Ok, we have max_ptes_shared, while if some ptes are none, could it still do
>> collapse?
>
>The max_ptes_shared check should handle that, so I don't immediately see a
>problem with that.
>

It seems reasonable, so

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>When I thought about the "why is this writable check there" in the past, I
>thought that maybe it was "smarter" to use THP where people are actually
>using that memory for writing (writing heap etc).
>
>But I can understand that some pure r/o users exists that can benefit as
>well.
>
>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

