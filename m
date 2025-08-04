Return-Path: <linux-kernel+bounces-755159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92028B1A255
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8237B17789F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD294238C36;
	Mon,  4 Aug 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1l/1bIo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99645212D83
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311868; cv=none; b=EBZTsRfurbdS5iYWtMBP7dmGBaROQu7oQ03nzDlBFYokUloG6e1JV4IzUIaV/q78JKORjGFeMWIRsw3jjeTwESiuL4gHOaI0ghRYHFrjuTKyUcWKb7BNESlnLWdJ9nmtZpRAlpD8TnEaf11a3WWJM4xfvPveYN4M8cIHIDnHyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311868; c=relaxed/simple;
	bh=QrZ/VJcwRA8tZCkld1LRzh5hnQix6prJIhvLAdHSt4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCBI9SZBaF6YiWKrn7U60TFvfFiX8BieW649+0RAmFXDIyexcrHejBhS/Amyb6g79dHHiXC5bkrDXNwC0iXgW06dLfU1ESSXdG72HgSxezM9Kx+MaW2EScxTvPwAFUjwDQNkirD1YXdFlzn+ndmB1fE8e800UE7YU15yK/GcA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1l/1bIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754311865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zBRal4xsaOEmUS6ItHYz2leZIyIcjbTf23K2YmGrEKk=;
	b=S1l/1bIoGPDAhrMiIWzVH3X8cG3Icp9I8fyktt2WbSMfBd6H7Ue/PWTiSqNMQYdCbC2N8w
	71wWN838qBljTZsvS3MOyia8qiLVE6zMOEd2SYK6B7Gs5lkE5C1LBSivEQWn7TXOdqit+/
	rfLebtB5VIxE9spZxnSZXVhDSbgwk+0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-Y4VW_m8SOfOjKbTfqRMKiQ-1; Mon, 04 Aug 2025 08:51:04 -0400
X-MC-Unique: Y4VW_m8SOfOjKbTfqRMKiQ-1
X-Mimecast-MFC-AGG-ID: Y4VW_m8SOfOjKbTfqRMKiQ_1754311863
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458c0845b34so8066745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311863; x=1754916663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zBRal4xsaOEmUS6ItHYz2leZIyIcjbTf23K2YmGrEKk=;
        b=QQdF2VofnJxYe32rlHbTStUD04wGSgeW9jkAZAOf7b4hz61Ml+fJr/GQ8sTW/5dv2D
         sRNaabqCXaFWsiavvHYPEETbMa7kWlcMKHlnAsmirDaU7ze7wdrhlWer4KwiPhqy49aq
         nRVzq7XQ+PSWFO7yrfdC/QoRFVM2HDyXGjSz4skBsLHzc+OnZaMoXRSRcZDz01h7d0VI
         Xp68JylxFF6OQgih+cMw4/hzvl0EjH32q6GhYxCRMq3UR25NiGlm+BobWrnEn2dIczkk
         BncSnM56//1DnlkX2n2w+/SMDavKaKBYuprXbpN5jv8XXTyOSGMrKXmjd3TwnHwKpiaf
         +Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCVePMnb6aDv9t6kkn9lo8yk59VFPndMhw1MJwEOznTb7kKJPtNVI+n38pyRPYo74fGZANh0Th0s9Mj3XRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFM8ggD2ftoZIUBb85a7+uuWwCk2qgSF6p5rdcdxhAPeou+RCj
	tCmX2xJyAUyyTsKqXSGy2YNcF2yjVJe1WDuuYZgZFfm9dDQxa7hjCkySEZoHq07+F3HNOPJkTqe
	kQcrTnkZpPivZBV4BnqzX5lLPTMfhm70Tw61uuG045ECoLqUakFCpzBrY08uZHIbDpw==
X-Gm-Gg: ASbGnct4P5i8SPL0uA8dmrdCIaOkXhSHpW9CyY7Ub1FGeKtihrsqousAfiouLn9o7yB
	zOvnju6LEf0H1chl2Q/SJ52XY6vAbiiNoKgNTzZJtRcoultCqiYa0WNdC8nNOqyJe/K/wGf8XuA
	CJc5G+HII2Z2GFaxtPtRQI20UZ6oQK+VkicLQ9Y0m6lNM6rknsIKirGKYMfXSib78aoXtlJ78Ir
	0BbgP7Sb2gwZXBzDk/wYtnhsG55dQUCiMdRREIA4fyoMPb+sWL0Equ4w8zZ/R7Dev/KjmFNpLJr
	jQvCpfsJVFJI/nslj9cKklRy/YLsL+7Q/NZlNUrF8SbVrZp/vqUXTPgWNAcq1wvRyLNbQEzE2UB
	pHlHmtC+FB9KXtE03FRnrN9uoRDSeRb2xrSon5pao7yYOpNEeOk4hnxJf4AgVd3LbYms=
X-Received: by 2002:a05:600c:4f09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-459dbb53b86mr21230815e9.19.1754311862850;
        Mon, 04 Aug 2025 05:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDwnvqBfRM2yRafjOhR501WHdQ2r5zqZ1KQJbaHPA2Nh5YiknfB5iBnnN61Wrk91/G2qbSTg==
X-Received: by 2002:a05:600c:4f09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-459dbb53b86mr21230675e9.19.1754311862436;
        Mon, 04 Aug 2025 05:51:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458be70c5f7sm80911985e9.26.2025.08.04.05.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:51:01 -0700 (PDT)
Message-ID: <c441e6ee-3118-4603-8c77-c5b2ef40982b@redhat.com>
Date: Mon, 4 Aug 2025 14:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
To: Li Qiang <liqiang01@kylinos.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804123923.296230-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 14:39, Li Qiang wrote:
> This change converts several critical page table zapping functions from
> `inline` to `__always_inline`, resulting in measurable performance
> improvements in process spawning workloads.
> 
> Performance Impact (Intel Xeon Gold 6430 2.1GHz):
> - UnixBench 'context1' test shows ~6% improvement (single-core)
> - UnixBench  shows ~0.6% improvement (single-core)
> - mm/memory.o size reduced by 2.49% (70190 -> 68445 bytes)
> - Net code reduction of 1745 bytes (add/remove: 211/166)
> 
> The modified functions form a hot path during process teardown:
> 1. zap_present_ptes()
> 2. do_zap_pte_range()
> 3. zap_pte_range()
> 4. zap_pmd_range()
> 
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---

What's the object file size change?

-- 
Cheers,

David / dhildenb


