Return-Path: <linux-kernel+bounces-772186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9DB28FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8131C2301D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E62ED160;
	Sat, 16 Aug 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeH4NuFI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF842EBDDB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363778; cv=none; b=cLa3L8NYKLnENl9PjwwdU4LsBWl+cuBxMlcAhFPf/eAI9peKVZ7ozMRArbchlpyG16XHZ6cJNm1zRNK2/YcBypslyIQLUw/J4hoe6zlqvC6W3mPb4ynKG3PG4Zj9kRkbQ+ego6rjdwYYpAqbPGxkNeZcE8dPCcWF9O1JFv4CiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363778; c=relaxed/simple;
	bh=sK3AxoPntkuuzAsgqaDk0ZUDWCx8COfE335VmkHhp8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rs68BXlrYI1ZvQ9tPUl/kn3gse5hgqYKO6ZlpktP7W1vBwAC52WAWdJ6qNfz6ny6xjCA4E7VZ4AvDIwc8Mu1ia7LzZEtXl12J/EZW5BXtG/bFPBf4cb3VYUEvd6RoYXjmqU5Y/Z1zTDzNd5Cox7uOhsRUn4uIVmPOBhwegOjB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeH4NuFI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755363774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rFOP4bP93eQhTLAi/4pMwsYYbYyGFzwy8zCXssqgG+s=;
	b=GeH4NuFIhqHNbHXtd2LC1Zqa2lxmM1LQ9cP7Chq9HVL6Onqs+d79hLIACKaIR2n6myBoN0
	9mfA2zSO/tuBDdG6NTN8FlDTtuS2X0Eb26jDmneWRBvRLHX4enm3C9uoEkHQJwdL+EHvDu
	SEp1eUBSZaePdCjO80K12NMU7Ta559I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-0p3ir6SKPMqMWfVOWZA_Mw-1; Sat, 16 Aug 2025 13:02:53 -0400
X-MC-Unique: 0p3ir6SKPMqMWfVOWZA_Mw-1
X-Mimecast-MFC-AGG-ID: 0p3ir6SKPMqMWfVOWZA_Mw_1755363772
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0cfbafso16656375e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755363772; x=1755968572;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFOP4bP93eQhTLAi/4pMwsYYbYyGFzwy8zCXssqgG+s=;
        b=cmpWb2Wft7H4T55si66K8xDJ2fTI1k3aY5/cJXPGcbGqkY7clKf9jT+katgBLrhyu8
         oS4+wSmI62Ydhu+AcH5yx7MPOE+0kEO6jLdrUULxBrRcbCzAfF6DM7ZnK/v7OpwJnYKw
         qSLNSkKJOAK5bhyoRQ/3O+yxHjWOjrOYEpTy8nHhQMpojOmbykj0IWPsaXqPJjAmrDoi
         sYJWHYwYLGpGPozTtXY3/TBMFt/Vfq3y3/MJYFw1KrUUPwqk2MnRAYgx1DInoOjvKdI8
         ERXW/PN+sWCP10lN0rlQbYgGoiIz///z69uucvJhZVLJxHZqLTFPzTiynvkp0UuS3/Vh
         OMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVJRxy5E8EBhmq0iSMcwCBG80SD3RR0IjRQQKvIf9wJTwNuHD1p07FtWBxmS5YBX3E1D6Ag7kjNfkKfGp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwLUVKmpPVrj7mdRU0uRMW70R2Uwqn+MWNx8HHfOUKL/XFRTh
	5x6OJDb51Vpod/6eO+uitHKDtNvPymNWWKYiEgBkgg5ZBdKNUWCj0/zCnadZKjQHu5s2Q451PY1
	sY9wvsS7Z/BxmY2gl90t1qLlmsf3+rvfypVVzY4iSA/iABwaZpeaSQwQjiS5U4Y23/w==
X-Gm-Gg: ASbGncvQVXGhc9EqCUC94Bl85HmCcsy3XqonB/XKm7OOMQ/U0DUcTR+k/IZ6CcD8P6f
	/g9ykoZ/SpQr0EYNdQHA80xl+hyHRrEzHBa7it7g0YXaUZ6j4TTJLRyV9IwkKLAqZbupUg6JRg8
	n2BAvGISGQ3dxBUfSAtRMTzPE1JqaeonEXoyDj0Ujbe9W3DWZDscOzBu/4nWZoJhrBt7Umb9SAa
	jqxF16NdNzOlp1YRevuf2yB0wc6p0lBkKJ/tZqQTCa2gDD8aQQlGStOSdpwf5pSbmJilmJrdVNg
	Z9RadHsUDdaybvyPEKhS+GAxJEbpBXSSrlmnQUXGabN2yaGpwSOxJ/NECfUIXnkld9OODgMlMww
	5eT2k+zDSnEqiI+W4jGjqQe4xNjffaJrYn7f1e8rV0qF8HsQD7Bh/3trBvAYhl95sE9o=
X-Received: by 2002:a05:600c:474e:b0:459:ddd6:1cc7 with SMTP id 5b1f17b1804b1-45a2177eb16mr61148555e9.0.1755363772095;
        Sat, 16 Aug 2025 10:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOyYAkn234G8pFJcO4TueuMIUSgTIyfD8FB92vg7RHPAiraVq7PwNpRBwY9X2yqOnzbai3+A==
X-Received: by 2002:a05:600c:474e:b0:459:ddd6:1cc7 with SMTP id 5b1f17b1804b1-45a2177eb16mr61148305e9.0.1755363771677;
        Sat, 16 Aug 2025 10:02:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758463sm6419268f8f.4.2025.08.16.10.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:02:50 -0700 (PDT)
Message-ID: <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
Date: Sat, 16 Aug 2025 19:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: Matthew Wilcox <willy@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
 <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
 <aKCwjCJTEhX4Q6wW@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aKCwjCJTEhX4Q6wW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 18:23, Matthew Wilcox wrote:
> On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
>> +++ b/mm/balloon_compaction.c
>> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
>>   static int __init balloon_init(void)
>>   {
>> -	movable_ops[MOVABLE_BALLOON] = &balloon_mops;
>> -	return 0;
>> +	int rc;
>> +
>> +	rc = register_movable_ops(&balloon_mops, PGTY_offline);
>> +	return rc;
> 
> Using 'rc' as the name of this variable is an anti-pattern.  All it
> tells you is "this is the return value".  Calling it 'err' is far
> better because now we know it's an error number (or zero for success,
> of course).

I know, we all have our things to complain about. Some about Cc: above 
--, others about the name of error variables :P

$ git grep "int rc" | wc -l
12730
$ git grep "int ret" | wc -l
80386
$ git grep "int error" | wc -l
4349
$ git grep "int err " | wc -l
6117

> 
> It seems to be a particularly IBM derived antipattern ;-)

Careful miser :D

> Some internal style guide, perhaps?

Kernel-internal style guide maybe ;)

> 
>> +void unregister_movable_ops(const struct movable_operations *ops, enum pagetype type)
>> +{
>> +	switch (type) {
>> +	case PGTY_offline:
>> +		WARN_ON_ONCE(offline_movable_ops != ops);
>> +		offline_movable_ops = NULL;
>> +		break;
>> +	case PGTY_zsmalloc:
>> +		WARN_ON_ONCE(zsmalloc_movable_ops != ops);
>> +		zsmalloc_movable_ops = NULL;
>> +		break;
> 
> This might be a bit excessive ... just passing the pagetype and not
> having the sanity checks should be enough for the tiny number of users
> this interface will have.

Yeah, no strong opinion, this was a 3 minute hack.

-- 
Cheers

David / dhildenb


