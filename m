Return-Path: <linux-kernel+bounces-796626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD056B40462
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E8418884CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62330DD1C;
	Tue,  2 Sep 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqT2HJBm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34253128DE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820009; cv=none; b=eE/lleUHbtS5Ow4REMjJAk7/aNKCvbsbNYMYry+uIa3Ao2FOe/lICxx4kiNgsH6fB8HH4LeGWqtbwN7dS/6fzr3g2PEbr44A3QBEFgfc17w0XLZHO4k7E4EGVWAyqUmqLCwELJgrXB2RZRRODHKhuBPFmKbuwHIhvqa6EuxM9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820009; c=relaxed/simple;
	bh=HEfDbQiH8FY7mPrSH8RphM4zoJ/37YLgYwHPb9Gs+9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR5LQCUegD6wiDcWS9D6o4wlOHa+OvtSwy3AMFIWBDc1vsSA1vP63KZhgH8NNVjOSqGFNxckqHhDrkffJFFJVDWOXuPKYNSPzUK9L5tUmHx9YrY2NRWFr9SCZ9qYWG1CrnV5PM+C8PXMSEfW1scjLKviqQHBGAGy3qKrd6z+XsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqT2HJBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756820006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tYYSmug/4nfDKtRuGU73yXX5tjcKnPDQSahXNdfE4Ko=;
	b=eqT2HJBm1nHkM7gIE/sYBoFM/OUdTqI5HEtQRTBlKTnTS09AkhUw5t2R23khkN/R+zZsu2
	GmNSJUQphimgiNTDLKNwYemDA5qD1zcLANN7/ysdyTpSD3AHCpiLrkhNw/ITs/lCh+IixG
	p8DiPxn9ixHaOuT/N0/7c8Z8augti3g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-NXbo580CMvSlDF2hbnrXyw-1; Tue, 02 Sep 2025 09:33:25 -0400
X-MC-Unique: NXbo580CMvSlDF2hbnrXyw-1
X-Mimecast-MFC-AGG-ID: NXbo580CMvSlDF2hbnrXyw_1756820004
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b869d3572so10805325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756820004; x=1757424804;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYYSmug/4nfDKtRuGU73yXX5tjcKnPDQSahXNdfE4Ko=;
        b=g+RivjolaUg6VOMGEBLFsQS0skcivrQ0X88m1PNpHk0IFIRgxUho/buqC5SljBYCyI
         z2pNYX8+a2f9L03uTN4MEVo4Wpxo0PuJ6n4EODGnMFrEiSqsigCr9e04pA3zFH2D/9Pc
         vZcybbm624tRi4zhZZu2nKV8VkFs4G8KPFeQzSbi+ui78kOFsVkCF/A4wJni2kEr/MIR
         rbQxdZE0JFqbActPEoEsJzD+EaZYBcjmydNqaWSdDC34LLOqvBkhD9m2ii1PxeU12JpR
         GAbscMEpnYzA8R6ZV80UYaNTccHtUaYc2qjzxpuCSPX8Y6NZqtZvAi8odVfuhCIYEnjL
         8fGg==
X-Forwarded-Encrypted: i=1; AJvYcCWEdeeFx+lSsjjdOGpjVPPfSDxrFLqM7nezNMW1NvepyU/Udi8uCZVSQsUGAMS9yIT0rzqC5IDDiUVjLuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMy0P/icwBceb/sLwwRSl+5NkiGdgSRyFApJlR2q4pVDhW3uwk
	Om94FEQhPdWbPPLnZi2bjXawMIOwuX0qzAXCxthkymN+FQ3CklRGRGU7oUJWBeqSeYKFXe5xSBH
	fYJ4l+oRVSy453vk87Ik0hzBVKG+CcULy2gx/InLg3HRKtC+hkmxf8qN7bc4yQzBxIA==
X-Gm-Gg: ASbGncv1hta9v+F06/q+cq7OS4AE4og7UguqfZ5pZyXb91lxIdX3zKuxlIUiHw8sgOc
	CoRfDwtIw4XhvzseJO92anM8dvJniPPO7jl5xpDq9OTzuwHTozmO4Aiu5QTLGFRdN8ogZRuPHMs
	vZzDQo+IUf/i7sg77Wj9gtdOIpOgHesGgLibS0ufmGRNhzN8Sj/rvrZsMzCx1/rLgHCjoBpRsQ5
	uihf0a3pCP81pzxOQFeyrXaWCOpKy7CIJ7fD+Ndxcc7pWCBG2lejDQNGckJdkUQeWv/YbOlyWLX
	1oj5qSIgWOe5U4AaClsk8qRwXFEn0IvMrt4dffkfY8gykDWi0dirsMDdhXeANcpITXVLmkp2RoC
	1orbtGmty8EuOTUdGoSVHx8CzT/a6K8bqUIf+dYkVjRLr8Bz4j3E/Er+9/21+EGDLkdo=
X-Received: by 2002:a05:600c:c1c8:10b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-45b85e42eebmr69024335e9.31.1756820004197;
        Tue, 02 Sep 2025 06:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGMJFAosuw8WDJkQ6aeFhwj8Lu711vhxmhqMDvwp8Dw/LQmdpI2HzCUGWe0+3fI8VcSyWZmw==
X-Received: by 2002:a05:600c:c1c8:10b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-45b85e42eebmr69023895e9.31.1756820003558;
        Tue, 02 Sep 2025 06:33:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6db6sm298998095e9.2.2025.09.02.06.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:33:23 -0700 (PDT)
Message-ID: <39087ce8-6f6a-4998-95e4-813e265318d0@redhat.com>
Date: Tue, 2 Sep 2025 15:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info
 helpers
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-5-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822192023.13477-5-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> swp_swap_info is the most commonly used helper for retrieving swap info.
> It has an internal check that may lead to a NULL return value, but
> almost none of its caller checks the return value, making the internal
> check pointless. In fact, most of these callers already ensured the
> entry is valid and never expect a NULL value.
> 
> Tidy this up and shorten the name.

Shorter != better. But yes, "swp_swap" was a mess.

> If the caller can make sure the
> swap entry/type is valid and the device is pinned, use the new introduced
> swp_info/swp_type_info instead. They have more debug sanity checks and
> lower overhead as they are inlined.
> 
> Callers that may expect a NULL value should use
> swp_get_info/swp_type_get_info instead.

High-level comments:

1) I hate the "swp" vs. "swap". Is that a valuable distinction or could 
we just convert it to "swap" as we touch it?

You're converting swap_type_to_swap_info() to swp_type_to_swap_info(), 
and I am not sure if that is the right direction :)


2) Can we just call it "swap_entry" when we work on a swap entry and 
"swap_type" when we work on a swap type in the function name?

swp_info() is a rather bad function name.


3) I am not sure about "to" -> "get". "to" is much more readable in that 
context and consistent.


4) swp_info[] vs. swap_info() gah.


I would just have done:

swap_type_to_info(int type)
__swap_type_to_info(int type)
swap_entry_to_info(swp_entry_t entry)
__swap_entry_to_info(swp_entry_t entry)

__ are the expert functions where we don't expect NULL.

-- 
Cheers

David / dhildenb


