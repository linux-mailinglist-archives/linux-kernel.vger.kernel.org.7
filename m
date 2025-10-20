Return-Path: <linux-kernel+bounces-861719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC2BF3784
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9E74E55DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E22DCC04;
	Mon, 20 Oct 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et6AkaMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251F1A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992718; cv=none; b=YDKLCZRWwfyD/71nufQP5G+ti0IuqTiyNIlAFlneh1oASWuPD3qgP/TPyrXVVj+qZyUy230QOC98I9gpnQ8qjJiQRn0RlxVZ1sBDFKB4XXvhj097pJnaJX0+kvLeJi2NqUVbOxeQ/qJ7g1G8WaYNeq2julFPE8tWTsIMPpWd7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992718; c=relaxed/simple;
	bh=hqLjg0U8CxCwmMBBkdc4VJNm7jZjrr93JpYI4N8fJ1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ecofa0nhYhI5xdXWElEnW51tJU2sgo36aXKVbvDZuZDIDreaPCeMLm1oPtJhbpfoupBc43l4ErHLE1gJ1jVEUt3naPHlZ1qc/dPwKcJ1FJvhOrlE3NkFyeALdbaI3HQNKWS42bT7rty+U9gJEb3F4Sgg8KpJYg9vbKE/bVaXdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et6AkaMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760992714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D5jtgiNQKtt7bQjGv+ROHYK7+SN6WSehX7RjoGcdUeA=;
	b=et6AkaMUSvSDt6PmFF8x3eerOU25NElS0CZiSJeu63//3sXew/BXjFNZM3rq4qR/6Gk0Xq
	3eU4wFoOz4pT4WnhLohkfuZWWrMO/61NNhtkXT/8T+Uogg4Wkfgwn7Yp+2s45NgBxxztKc
	+atW+kKl5iZd8YnJGVsbb2BjJggM9Dc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-ZIqoGOKqM2ieY8WL3qrUaQ-1; Mon, 20 Oct 2025 16:38:31 -0400
X-MC-Unique: ZIqoGOKqM2ieY8WL3qrUaQ-1
X-Mimecast-MFC-AGG-ID: ZIqoGOKqM2ieY8WL3qrUaQ_1760992710
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso37393835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992710; x=1761597510;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5jtgiNQKtt7bQjGv+ROHYK7+SN6WSehX7RjoGcdUeA=;
        b=K7jXq+2HLCkQfCGxGU2uzPcVpqmhxEiCzVpWQN1Hl3PsGYHPVqz18RPeQfv2vSRTib
         6+LFkU0LXPfRjlP86niyr3vBgt/Qlvv/dDQ7LR1mSNLkIOcJP74zFr5wpqy9fcbdKcwO
         1s6p0hSiRw836EUYH3ljqZieBNeasOYtEg1xgjT78oFaH6giDsiiythU++x2e4On2s9B
         5nKSg7mZJbYNPkOgsJZVzTk6qKgJeiLei0peLIIcSEFdWMzTsGMPOoHF/m8Sp+ksBITu
         WXP/dGJ7EheBL35FQhrsQ63xNRL1XhbmZlYrCxwCHj2ijAt0iU/NdFbKJO0p9yUXFAQI
         2S8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3Cb45FR6+dRalbzzBIFSTkpxm80p2uXxTnuN1QpSCpJyOlncubHm/SKxkBkC3UUrF+TPcUBwELDkEkD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Sa2igwq3B9AFnRidwLc/nFVzRS6EvQRMQ3I/GJtLoO9xvhyu
	j6MeL1cgG5fIuDQNX/SHo7HEvszDeeXv/GLBqey7nwOSEumyihrHx0StTpGkUdF21DK246NstjM
	ZoRV+Y/v5tT3QB2q6vHVY0E+G7ve7S3lrjzc43Hhvj5D3jRUmFNdK/sR81SEJJi9Obw==
X-Gm-Gg: ASbGnctUwJ+tczaBV8VEc0SoH1cVgiwkhEOqgFWjQErbJpP81FsaL/BWeFvUatoaGAD
	wRNrjW+09reQ/CkxlXYMk57Qt9OTsiYAtY354rzaaEYgkg6nGIbn/3JIE9LYn5oEVgQm5j4mgcp
	uohbKqpbPUFMenrgkX/kuYF6xqw11RAYn3d2cJb7qTNEn0Sulha0ZL3oido5reMDkgg3KwURb1b
	C+3Sm4Ic0Ph2pe0iri/31yDt+1SGYBIL2g22jQwXYFglVDe5NAmm2/kQ9enHo3VSnGX2UlNw6ot
	uQA/i+EZGl7GASF4mqTvWI4KLPWb3zo4TxJFg0namN2ygYxmjZ9rKUkT3Qr7YzZEJQfyZSoejWS
	1xCFocuxLuqUIgzf1Kw6QLlxHT7xutcM6wDLv6SBMj1Wyi7mH6FcyseYXlK/RXKCQyZuxshLamZ
	9WWiTW0Px0TZxm7lW6kcepWm1X51Q=
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr95395725e9.14.1760992709994;
        Mon, 20 Oct 2025 13:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnEWMc3NmP1WJ5DHbx6j4Xc0PLLV0NUCeNENs0xEpvXat4apazl6zieh1n1aWJhgADZRpngA==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr95395605e9.14.1760992709624;
        Mon, 20 Oct 2025 13:38:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm17086818f8f.21.2025.10.20.13.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:38:29 -0700 (PDT)
Message-ID: <57b5ee51-db68-4106-9e3c-cb2518457e5d@redhat.com>
Date: Mon, 20 Oct 2025 22:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
 <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
 <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>
 <aPaUZm0ZfIEW3gUr@gourry-fedora-PF4VCD3F>
 <451b72a3-8052-4dfb-84e7-1e97c3388db0@redhat.com>
 <aPabPH_6FxPgPKM5@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPabPH_6FxPgPKM5@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 22:27, Gregory Price wrote:
> On Mon, Oct 20, 2025 at 10:17:42PM +0200, David Hildenbrand wrote:
>> Yes, it's completely racy.
>>
>> I was primarily concerned about us calling functions that will VM_WARN_ON()
>> etc due to the races; not that they would make us accept/jump over a range
>> although we shouldn't.
>>
>> Of course, regarding the latter, we want to try as good as possible to avoid
>> jumping over ranges that we can actually handle.
>>
> 
> I'll go ahead and add a snapshot_page.

I'd say it's probably good enough initially to just use compound_head() 
and filter out crazy values.

-- 
Cheers

David / dhildenb


