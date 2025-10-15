Return-Path: <linux-kernel+bounces-854483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12ABDE7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A6C3BED6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1B17C220;
	Wed, 15 Oct 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCp0b2Of"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA01E515
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531795; cv=none; b=p5+UJLwF74t2GuHNOJip7hKUU5W+bg5bs19bRl5bBJLFwFNzG9rNgm0es4RSckpbaKZ53vzEbsUSEzN0WUX+htqwwQnnkxUTsJBP7PAfwddjam66Inb6Gy/cqGvibqJppcEt9ZnoNAgQaeNLdx/oghyClFGZC4kXHILIm1/W3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531795; c=relaxed/simple;
	bh=R2BzY0fVnRZGl2XvRacDg4GlwkX4i77/cBSJa68F3tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N72tT6yzl/+yVMl+UxOuSCUVCHxRPnMHSYEiU8Lv+jo86aRExPz+2lYqC1j6qb+f8Pob6PtL8LWc0ClDXqc46XHmxu7rd4bcNsJ0KimRwJKAZf+EgnipIFWKAfKYrq2q4cwBcrz1+Y5aMHhZeIKmJmws/WghzdeSHFLcZcloYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCp0b2Of; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ooy0+P+qSQZ9PBAsL6C2FQjAzQTmePqNdX02r+q1V8o=;
	b=dCp0b2OfHF8qMRqrF0Cmt5/65QwmfZ3NzkUkPRt55VmTbwlx8m1hhLEMqUtgnP2HugwRam
	IOELrx+FtPYa00MD6EuDJbd+2LV8O0K5qYsjPUcX36Dii/lGiK3qz2/89XY3fkhn/y3FAS
	ew6n7md+b1U4IxEf9ny+PZ6Lnj8LB3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1jXRMAQ7MziDMdoWtBKctA-1; Wed, 15 Oct 2025 08:36:31 -0400
X-MC-Unique: 1jXRMAQ7MziDMdoWtBKctA-1
X-Mimecast-MFC-AGG-ID: 1jXRMAQ7MziDMdoWtBKctA_1760531790
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so1286483f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531790; x=1761136590;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ooy0+P+qSQZ9PBAsL6C2FQjAzQTmePqNdX02r+q1V8o=;
        b=fbLWZ07YBX0mhB76aTxH+kqG7vhWgeYUwSsfVIytdSQY5X7BBiY3Ofj4N6rlSvvd9x
         1bZYdFAPGmmQC2B8vw2zbEyON3aWDZdB6eI25oNssvtRdKTGKNH40BDCPG2SoixOqw1/
         om4VSi1gzAp4f12HHuoAlserLqJzjrTFmXdL0xx0pJxXlhjzjZFpQrjNUZJW1aVWwpPb
         mCsDwf1t5GFQHQp9YsdFPkh5UDUaP4+ZHoCxwY5CzQqWIzTOme01pM6bMR1S8aa0IgFY
         IYJAugeIm2L4O6034WVZpnEuyKE1j/tM0znCNuIxhxwEArqdM5c/xeRUfy1ACwMIjt9I
         Yl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzQq61YiehaqQ2dPfRvs3/sRUoIeRE4Q/o1VlQRKWnsfbo23vk87LLvubBy7ywrpbWADCZZxucp2tYSUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0d0o6D3pLbcJ0KXKxvKInsK2Isk/OOlLkS5L2lI360vSUQECb
	0i2RlDxWhMMz7VjnYpXcWXT0yY+W++LVMaxeEallu5x1u2N6E0z7WI2k6eemoF2a4h8GdihaL42
	4y518OiI2cS5S4gPw2ezpMeKyzlH7LvaOV0yBIOUpM0L7AC7lVDzvmV/M/AozlJWvSw==
X-Gm-Gg: ASbGncvoxaf9MEM8DQ7AyqSiKbDyPn6R8aMsyddCbzkMnPVjpdCHAWR+qnEU+bDDBhG
	gCYceHwd5MnACVUlaQ78nzpV2W6YTqElK1SBSkTFK8qQbj2XnNvN1k1MPn+wqq9UgDXp9QO+3OJ
	9v0XU/T+nxalFrmQCFt44IlxaKpDqgjK82ACTa4xCGJ1U74kZezrzp676Folk6vt3HDaaxTp3qK
	uYrcUOMIW9DLsNwlpFVVHdbVDS6F1HNpt6OCWj39/6DHrHeYxoMNPHCJWp5o4rZgGs2wvXos+6S
	GI+CUKy7Dwb/zzk+nLnbLco0kFNgNuJJuAC8gzOJxjzvzsdzO3sHuRprvC0KNfg=
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr189549165e9.27.1760531790269;
        Wed, 15 Oct 2025 05:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQEv7n4XLXJaSEJX/SITQ4VMcrjiffoRvPhoDRdJduQpEbyWpYgYfRJYQt1Ld4+uLtEwQ9Ow==
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr189548825e9.27.1760531789835;
        Wed, 15 Oct 2025 05:36:29 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm7689658f8f.0.2025.10.15.05.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:36:29 -0700 (PDT)
Message-ID: <ed99ffc0-4a70-416d-9bf3-58c4a3ebe566@redhat.com>
Date: Wed, 15 Oct 2025 14:36:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drivers/base/node: Fold register_node() into
 register_one_node()
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Dave Jiang <dave.jiang@intel.com>
References: <cover.1760097207.git.donettom@linux.ibm.com>
 <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 17:39, Donet Tom wrote:
> The function register_node() is only called from register_one_node().
> This patch folds register_node() into its only caller and renames
> register_one_node() to register_node().
> 
> This reduces unnecessary indirection and simplifies the code structure.
> No functional changes are introduced.
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
[...]

>   /**
>    * unregister_node - unregister a node device
>    * @node: node going away
> @@ -907,7 +880,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
>   }
>   #endif /* CONFIG_MEMORY_HOTPLUG */
>   
> -int register_one_node(int nid)
> +/**
> + * register_node - Initialize and register the node device.
> + * @nid - Node number to use when creating the device.
>

I assume that should be "@nid: ..." to silence the warning.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


