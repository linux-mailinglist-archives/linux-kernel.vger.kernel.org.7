Return-Path: <linux-kernel+bounces-794085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C096B3DCA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4313B5F52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E52FB624;
	Mon,  1 Sep 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8StDkOy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57711E00A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715885; cv=none; b=cZF8n57r2T0UoGpyaNuXeXqWLi9rXamTo5SD68Sk/LnxJ8e8mYlcHY+AXknpa7yx9/QWdw3DYwet8Etkoyqq/nyOA1Cocz44MJlfZzEaReigtzYKsQa45puniNyqtcz+cyJ6vQFSX4nzzjdmgwf3ao31k0FoKbtu4ysZ7+cero4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715885; c=relaxed/simple;
	bh=nn+IGU9QQIl0hiOvRctWqa1lMMJEsS99p6zdED23K30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+j61xiK8vQuwIYmhshm9OS4HDqqHmZaWPB0zqwUR+V3wqUkYvJnEEtKQC0RPhqqnAeaavTlQNHbkZ9hCuWpViXs99Xu+YBika4yd/d57p1hsOVCFeuy8adX0LYmaVHqAD7huQ3qvDVAYL4v4PyTjtNZJlMmW/bjQYTALaozOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8StDkOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jrgwOs+scouNVZvyi3e77NdTzgLAbayEdAxxiP49p7Q=;
	b=D8StDkOy2kXHOwxf5s2bep2PAVtMkvaWSsEx9uG7d3NnkAxQA2IFEZ1UVo8T/94dp6DYPE
	CKHaqwgwV5/b0ob5n+dJxAcdYbpfiH2tzWa8ynRvIseYadlvRxcVEmBgsAe+xz/oLpIFtQ
	T/DApYJ49i5uIzSyqzQlmzyuhCqGUWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Hng7TGmsN4anZ3YOs8lO1A-1; Mon, 01 Sep 2025 04:38:00 -0400
X-MC-Unique: Hng7TGmsN4anZ3YOs8lO1A-1
X-Mimecast-MFC-AGG-ID: Hng7TGmsN4anZ3YOs8lO1A_1756715879
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ce059e3b83so1596452f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715879; x=1757320679;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrgwOs+scouNVZvyi3e77NdTzgLAbayEdAxxiP49p7Q=;
        b=Z9ytsq/dHYyFMKj4NGvKxKHKdqjkx/Fbnq8eoEl2yrA8BVI+FMQa+jrD6gZmRdb8dR
         1DDniNmUv6uue7KFdR1DwYLIBZ2/zROwocvrjJvEcEAb7ZT51o6hILs6fZWhszj0TuBZ
         hBVHj+8Uy8iTzCAtJeREq9B3Ec4faCjhGssHqU3gp2OXtBIe4UIFOlHZPtrn0GpiGygn
         +H99SLYyz0jCJ8sDU94W0zvUcEn36G+uA791ua55YQRTGWEFoqWdqHpuyhBP0WkRBT/A
         t5SEWW7pCb8T7AaiDVCAPZDLdN/ejRCPkDvRHyoe9c2VtJsdrV4VlLnrxj0yEz8NcSt7
         Bt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZGsgO5SCQkoP5lLwanKO8MN8cGsYyC+6U5k+ugedA0c55jx+uJl+QmsU3/AEYpQiNTvf0F5v3p1+5L0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8Hreo0U9D86SQM1YprYgRaM15DvcMJydcCk9QNDRvtEVUmK5
	lNSwWJLojDUee6WIpVoPT4LT3f1D+Lf3BnRIznI6pADJpIa2GFPtChGgyd7aawHnIFzm8MlNeNX
	Waj+g1GHQXDwupw5855g/7/5jTV930Ixl5CSKOMNiOzhRdHolWJDV8OiFgSrTRQdEnA==
X-Gm-Gg: ASbGncsrxZph5vWv2wUf33QqwGCdsR+w0eaDCfJ9Drd/VoELdniLg2KGuPJkWl3SvEK
	liRsgUYWtoym7fB7dH4mUzPZ9I7wBu4QlLkZkw/JlddDReROmi0xKyQ0SzSroBomMHPM0ZdKdVB
	smfE+WNm8sD7tKyu7qaZycevL8pUnU+OZA5NDRD0pmcixQiGZeBPEo/hjskwQR9jNRA64SbQ2Uz
	llJOJesei7D088BL7CPp7WqoqNI4h1QA8QyWRMcMVL3KQlZrm3GW5hr8LvO7BJ0kiRJ4tfAq3d4
	nnZmjQTTGVQ4b34Gk1WwZOzkuRBbel4fJoViAwzzmE0r23LQ0e0q8zX7s/1LPpN3oONmvAGUi0C
	oMqiPYxNR8B7RML5I1eOteiVYeQSqgoGnh4EQRmCzwP6dFQ+PaKe4Tz3YiFCa7b3p008=
X-Received: by 2002:a5d:5f53:0:b0:3d7:618b:293c with SMTP id ffacd0b85a97d-3d7618b324fmr1132389f8f.16.1756715879523;
        Mon, 01 Sep 2025 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9nWwOBCAvDBQoLLOnu8h3E49+M0YCTE2ZQwP6KwAdpKdeubmEVeAJTUT/HJf/S1n5/RmPbA==
X-Received: by 2002:a5d:5f53:0:b0:3d7:618b:293c with SMTP id ffacd0b85a97d-3d7618b324fmr1132361f8f.16.1756715879028;
        Mon, 01 Sep 2025 01:37:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm14122840f8f.61.2025.09.01.01.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:37:58 -0700 (PDT)
Message-ID: <38aff9eb-9d7f-4dd7-8ed8-fe29e469d068@redhat.com>
Date: Mon, 1 Sep 2025 10:37:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] memblock: drop
 for_each_free_mem_pfn_range_in_zone_from()
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Bill Wendling <morbo@google.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>, Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250901083423.3061349-1-rppt@kernel.org>
 <20250901083423.3061349-5-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901083423.3061349-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 10:34, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> for_each_free_mem_pfn_range_in_zone_from() and its "backend" implementation
> __next_mem_pfn_range_in_zone() were only used by deferred initialization of
> the memory map.
> 
> Remove them as they are not used anymore.
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Link: https://lore.kernel.org/r/20250818064615.505641-5-rppt@kernel.org
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


