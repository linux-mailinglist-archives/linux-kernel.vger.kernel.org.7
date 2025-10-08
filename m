Return-Path: <linux-kernel+bounces-845223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21910BC4092
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8901D3526DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98922309B9;
	Wed,  8 Oct 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwWsZbb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE258632B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914021; cv=none; b=rDKg35suT3QtAZCqFZWU7gOSWkyhJ/6Yux1rjqeGm7CpnaHgXvlcTYyDpSFaHGTtbPH3122zkOl5m4nNpCa31ky06fK4RtOhg040UFNNPsUxjqk9l/JWgSJ9eBDOngFbNp21gOOR80uolYCicH2hlmjKUDF/YEF8whGYImwzhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914021; c=relaxed/simple;
	bh=jxLMcX1Ra+xbVOI7n/I+MEAnub2QWF8EmVkfQLkDPR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7DeBHWUI9ImXFt4DJm3/BQ94CGSI2gpOUr+85YpT3Y5bKSRmmBDTPjTId3yZBrFSOMOahhydX1mbei8GjOQ6MoNJonzz2I/sYUx6seAXlGt/+VdQ5LUCWlCyZp6HTAJmmKqAx0B8aQzS37JylqoQAFBe0Z1Cjii/N4ZuoG1Rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwWsZbb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759914018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bNb165tATUdzEB7JEIVixwqTS/ioT+20Th0ZR/SpPvM=;
	b=BwWsZbb8AZFk0ZbUAOC+mh3AlcEfGreD3MYi933HAMa5xNpRRw1V02m1K0SpwZcWbmRgcT
	OkiQSzsWlDMlvDYiATzH3fEChDwXYLI15pzzG5enofsYQ77pqkypVEBPfcwUEGBpd9kpam
	f9D/KTIv7jo/4qAZ7sIdTmO+fMKemYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-6DhFLUfJNEyYm-iFD0XgMg-1; Wed, 08 Oct 2025 05:00:17 -0400
X-MC-Unique: 6DhFLUfJNEyYm-iFD0XgMg-1
X-Mimecast-MFC-AGG-ID: 6DhFLUfJNEyYm-iFD0XgMg_1759914016
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3af78819so32292415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914016; x=1760518816;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNb165tATUdzEB7JEIVixwqTS/ioT+20Th0ZR/SpPvM=;
        b=J71UwwC02K53G2rphX8WDS+d8gTP7ZzlYqxyFs7tuzKsUe2WexxcCnpPIlY2PPPSx2
         b2s2x5YQFdoVBrR7gCbYeCl62xuYvZbuy3I2lwW6Bg79uz909bU4QaKX/00pbIM/l5bn
         XhwsYjWYpORiVZr7FSiG3Tl0i3hBeTNHTqAreaO9O9BhfaUDQ9q1iaajf/NjVjqUtlf1
         8MB8XsyBl7Vy8IQIBXllIfuCJtbznAFDVwva2EJZmTdv0eS3eue7lUJrfSEOkP9yn2lr
         KqUjZ/5LWoiKdjoDYJEFF2rtAt10KUgJYMDOnreZEeMpoFSJ305yJsYnoGJwHHPF/SdR
         Y/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXduika11lXwKDyLdCaoBordFqp0iVtGCCQVjcOwmOaG+IGuU+oGYSE3RLd5OqTq8JDHj2C2YY5pi4Xd48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6/0aLWigmfNsRxGuYLyjT2cs2Vm7tmktiYzSgFaTHldmZvEX
	VErDAl8cH8eXfAsfoq2LJNgTOqzD+xlnQ5ohPC0wEd52ucIWyzRAQ/4C3XkDBcrLgSan5AwIPt5
	zXipO+PwEVHnRtgAdCL0qNu/t7pWRO5kYghNgTZ0QTvN+yydMXiOvesTIAWYPYoIKcg==
X-Gm-Gg: ASbGnctnLOCVDZ/0olv+XWpqbtFfx+/vvfmUT4CBrGZxRYpNbpd4qvPOAZGbC9s0SVq
	eJAiC7T30LBPlF5HnIeyp1IVSZYhzWqkfT2vkT6btXzD6rb7uEa7PB0crmnP1+PaNOuf5W88Mmx
	t1kWSwTzEwCN9UR2Igfwu7Dw5RXpH6S5q9ieurXxCznVIVqIij3VzE8dgwmelXeEbBrTUOaryrj
	qym+s1cZ8gEQCXGzFcdDN/52/0OK+1OHYiEvW7w191T9aHpH/abC3SRvsMLIk+0g71z1WQZlJJq
	hp4iW3KkEF6qZQ89oqDtTwlpy+8MrONarbnjFQce+PhcJJdaYL7WqPpEYM6gs/yWeXc19TrkLY0
	fxYF8v9W2
X-Received: by 2002:a05:600c:474d:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46fa9af81d5mr18773305e9.24.1759914015782;
        Wed, 08 Oct 2025 02:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj5sfOcndDzAGeB9+llIRFsdMQVfmW8QZxnb1MAChDDnGTI6DfgD3G8B8EpgzHWOlxYFknRA==
X-Received: by 2002:a05:600c:474d:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46fa9af81d5mr18773025e9.24.1759914015233;
        Wed, 08 Oct 2025 02:00:15 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8295sm28492525e9.3.2025.10.08.02.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:00:14 -0700 (PDT)
Message-ID: <1c2fae79-69ad-45c2-8da7-31b3cd6dcda0@redhat.com>
Date: Wed, 8 Oct 2025 11:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
 <20251005010511.ysek2nqojebqngf3@master>
 <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
 <09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com>
 <29742109-13c2-4fa6-a3a1-d12b14641404@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <29742109-13c2-4fa6-a3a1-d12b14641404@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Second, as Wei pointed out[3], we may have a chance to get a non-swap
> entry, since we will drop and re-acquire the mmap lock before
> __collapse_huge_page_swapin(). To handle this, we also add a
> non_swap_entry() check there.
> 
> Note that we can unlock later what we really need, and not account it
> towards max_swap_ptes.
> 
> [1]
> https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
> [2]
> https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
> [3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master
> ```
> 

I replied to the new version.

> I also think it makes sense to fold the change that adds the
> non_swap_entry() check in __collapse_huge_page_swapin() into
> this patch, rather than creating a new patch just for that :)
> 
> Hmmm... one thing I'm not sure about: regarding the uffd-wp
> race you mentioned, is the pte_swp_uffd_wp() check needed
> after non_swap_entry()? It seems like it might not be ...
> 

If we check non_swap_entry(), there is no need to check for other 
markers, agreed.

-- 
Cheers

David / dhildenb


