Return-Path: <linux-kernel+bounces-757752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF786B1C644
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E093AA85A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9461DE89B;
	Wed,  6 Aug 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C39qkzwr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257118035
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484443; cv=none; b=uKnD4jILqfhttY2GI1+LA0UqvIG3DiYJ9p/ohl/td/CW8rVjrGylmqZqqqX5TdMzP2ucaSKJQ0+TP918N/1jOK0sW8blYSab5fk9RWp6Lvnd9M3PhjHOuBMSEIYpTcX8NaFN4I2WGc9nyl7cSyqS4aV5dIjQi/la9+vT2AX8yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484443; c=relaxed/simple;
	bh=ufU2Mu4myF2+yACQiODiRh+3hlp2kMgjerZyfXe7DfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzyHpdZU3haKSpTQBYe/0dD+n7k/lt80FtIe+hWcXeP9vK4h8C8c5VDdeikTla6H9Cb3tlaM1x1T66cdO9l6TA+u16GlbDy2XJjSZApckzr3jF6qx403DmK1JfJkWwDX18yOPVYFqJ9me+gsOpO9Sq1V4o1zX5XGNjLXqPJPx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C39qkzwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=du+uAPV+viA6SIQNfFwbJjlhxucMQkz0DAyZJ6nNc3I=;
	b=C39qkzwr3Z4RaBeOOXpRQqLCyu0l2dNsOA1BSKFC0oLroswOhU5T9/VxY1OUiPbJXtNUfG
	YOZVCupHOmxHgMqmoxf2iO5aWkOzpfNrDSBEv9Iz9Pjh9sGlrymjpvRo/JPa4R2ISvppQr
	LTUY9+r+FgCApC5w0vriOEJDs1gGiGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-TAovk2SRMgij6Burh6CUag-1; Wed, 06 Aug 2025 08:47:16 -0400
X-MC-Unique: TAovk2SRMgij6Burh6CUag-1
X-Mimecast-MFC-AGG-ID: TAovk2SRMgij6Burh6CUag_1754484435
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459e30eeea3so10672545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484435; x=1755089235;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=du+uAPV+viA6SIQNfFwbJjlhxucMQkz0DAyZJ6nNc3I=;
        b=W2NiRFD79Q042HLRQoak6G8yLh7nHJ/iEPFnCcJ/S9Kzs5hWNFvAOxcRNhffu5xGKf
         fhelaRwAuZYEQBrzRStA+NwYnJdZ7lkoj8Rjnrav06Zjp3xXXR1ROlWACoCm97SXi39r
         15ZD/KyASqp5yWK0Wj69XaXP9V/SkmkTVxGy9TYHsF+YmBoZ8jOLFdWFiA6axNue0/6W
         ULnMamHYPXAbqg3B7LCzClt43h/5PsgKy1TT4VA7/Qgr3ZGhM2sSuNwzxQYmsjYl4Di/
         b3CA9lr5zPFmYS/pfU7PV9kwsbLvqhrLNhozQlQSciXxAJBbyWVeqglRjo0eA8o/Xua5
         6+BA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Kv1eB8m6ejKBBcIopsLzu706WdTU7dTsHZK6JNe+LzihU6cfclYHimxQYU7FtTfYteyWAOHbnSvpm58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPyD1tnd7Ip0T9cGhlDwV9E+gnXt6fVXmtBUrX3g1zlaGYRNc
	5GLPahg2+xBCx7UQmKD/k7ezzk4w7XauviUzaFYJeep+HgkF9/zldE69IpqiL9/R2lh1azajJpd
	Z+jSdb0M6mtESVUMoJa2oY9/7o/imZAYV9XiZ+K8EPbHUSl0bRTc0XiJzduFLEANqww==
X-Gm-Gg: ASbGncuDZkzm7yaR10d+Px2xWHD4ASI4KXj8Ks9/XoMrWB5kqTnYJnqTwrGJCtTXPqd
	nudVneGL1VIoX3S8yxRRzcyqcW+iHcvNvURce5PIC+NAYIXORsPbKNx8MAhhVr9lVu61CdncuG4
	xhPNLtv7MczyRJW/iAtoOX3qzqxD48HQge69AA2GPm50gumHZXe6r9TkVc8iuVcbZjjtgEJTV+s
	lpXS3HRGm1BNsFECepny8YK0K9vmcJBNq8LUsIo4ElRwYIi8lG3K9IvIXiHgOCAtPZgws75V01K
	e5o2tLlAaUGAZgiwDx6ZoZvu6RpRTChfIpC4XgndzbFxQCrkCKInTS62e0zfR2m0aCJdTlmqgE4
	o4p7kDF/hr4eccosI2E/Nutvb8QUL4byUsXZQJY9C+d7jPPUxD1yvYGSH07ezUf9K+iQ=
X-Received: by 2002:a05:600c:1550:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-459e7447856mr18428745e9.1.1754484435073;
        Wed, 06 Aug 2025 05:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWLZ8ZHFSzUGM3QUGYEAYSt+YHr4y08dG1ATS1v5CDniPdYt8JEUnU0hkuZRyg5nvDeoR8KA==
X-Received: by 2002:a05:600c:1550:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-459e7447856mr18428415e9.1.1754484434644;
        Wed, 06 Aug 2025 05:47:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm23238259f8f.42.2025.08.06.05.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:47:14 -0700 (PDT)
Message-ID: <60b6c458-e3d0-4123-9815-44e8e8ae0e60@redhat.com>
Date: Wed, 6 Aug 2025 14:47:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/huge_memory: move to next folio after
 folio_split() succeeds.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806022045.342824-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 04:20, Zi Yan wrote:
> Current behavior is to move to next PAGE_SIZE and split, but that makes it
> hard to check after-split folio orders. This is a preparation patch to
> allow more precise split_huge_page_test check in an upcoming commit.
> 
> split_folio_to_order() part is not changed, since split_pte_mapped_thp test
> relies on its current behavior.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

>   
> +		nr_pages = folio_nr_pages(folio);
> +
>   		if (!folio_test_anon(folio)) {
>   			mapping = folio->mapping;
>   			target_order = max(new_order,
> @@ -4385,15 +4388,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		if (!folio_test_anon(folio) && folio->mapping != mapping)
>   			goto unlock;
>   
> -		if (in_folio_offset < 0 ||
> -		    in_folio_offset >= folio_nr_pages(folio)) {
> +		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
>   			if (!split_folio_to_order(folio, target_order))
>   				split++;
>   		} else {
> -			struct page *split_at = folio_page(folio,
> -							   in_folio_offset);
> -			if (!folio_split(folio, target_order, split_at, NULL))
> +			struct page *split_at =
> +				folio_page(folio, in_folio_offset);

Can we add an empty line here, and just have this in a single line, 
please (feel free to exceed 80chars if it makes the code look less ugly).

> +			if (!folio_split(folio, target_order, split_at, NULL)) {
>   				split++;
> +				addr += PAGE_SIZE * nr_pages;

Hm, but won't we do another "addr += PAGE_SIZE" in the for loop?


-- 
Cheers,

David / dhildenb


