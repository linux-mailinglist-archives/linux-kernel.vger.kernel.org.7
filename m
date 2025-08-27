Return-Path: <linux-kernel+bounces-788029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC1B37EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C09460FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2A343D6C;
	Wed, 27 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfMEX70+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0574342CA2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287339; cv=none; b=cgHOgwNGM+bOfn3F+xj0UE6J1ZF7L8fzvIQ0a3uRKXMOhDWZaPz1yrJFu6lqt5kll2vm3k8+Z8GshnPnbzGRvwXsRZTIzflDoS97z2mDBf8uJxZZSQXzl1UByn04ORkrTwXgWktiLKM638Rzq6k5B2VYWNiolJ4GYw49QOXGDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287339; c=relaxed/simple;
	bh=NZyjlx9JVrTus4PAEiK6hrf7n0f1GWNy3/KoGu3XbaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMMO840R8my0p4ma/zDWEHt4cvXh28jMAckLfEBF008Tjw9dFLwKEHAouXTtjinr6/evf0KLS2DwXR9oSJSO49lbGGKkOPH3/T4uCYz6tSXTfE7zLIz2O2Up9pAh6Z8Nm3N/okAN8xnzQDbXHXCKy9oBpR6CeRyaaBRe5nEY/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfMEX70+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756287336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z5fukYO7kXwNxBLuSBlCYQ0Hv0U0IOhmRPFv+8P4+0E=;
	b=EfMEX70+i9xsqHqNSLH5STbuETnTfDPmelLEEHcMYmI/FM1Xdbroj+rfD/pZBZ+avt4h4d
	64LjevrKlCdwXa7GnmCU9APG5eeMZkvSBav8F74V1Q9NRTZzvR0cBMXKkxSCsMvnIXB59W
	8xDP85KQ2tyWUnVc/YSTR8ZpvXdXTPI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-9KUxZzOGMvuo9WtxVnQOog-1; Wed, 27 Aug 2025 05:35:35 -0400
X-MC-Unique: 9KUxZzOGMvuo9WtxVnQOog-1
X-Mimecast-MFC-AGG-ID: 9KUxZzOGMvuo9WtxVnQOog_1756287335
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70db634fadfso72352786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287335; x=1756892135;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5fukYO7kXwNxBLuSBlCYQ0Hv0U0IOhmRPFv+8P4+0E=;
        b=LTp/1w+n3ZzBBNMOY1pu/BiWlvYjTac5fuOwVW7FmarxlPJ/xiKaSPakHFnKm8C63j
         CXq6eO3Lfyj91JiJ017X5DT5E/EEYvf0x6QES2LLkiOk3hhA3zAU/1WqRJsQnegMqoRN
         ceaWvEa8QUQcU0SFQ5XYdu2fyGQDclE4cG9n0rIZtN/FHqV8mrGe4M928f/zg9kL6lKI
         Bwcy3xMPoJ7x6vtZDGGQ+JCPoCoQrnyzNjn9vYpuIfKCRambmUxVh2Msfllf1vrMOt82
         WKL3aC3it0hEKc4SYGcD9dLhVl/Nx/3u86tjkU8OwuUXXNJ2KXm9OZYHHqMa6kwZMHqz
         ADLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5eVHWYbPaty9LpALlMIe4pPXV/KxbZv4WXa/BzuWhR8b5j65P/Yg05slRmeHFWa3/g0FPVBPXrytvu44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvyhc+9qI2NgM5L0EZj4UQr0Go6XzmVyIwfnc2mFDFUmUQBfAo
	2JCTEUjJz4r9w05uR3pSuHVl5s4ytazUCCJ+Nxn7NStAGg5V+8hap7v8qOx5A4nVTikKQ66KtvZ
	v9QF9pNrUK/YpzbXTdPY4xGEmGm8w7VF3sZoeB5FrcJrAQTSbiU7ULcqBD5nmph9mhw==
X-Gm-Gg: ASbGncsxR0OzJ6SJGAxVLF+J1s1JkRjrngsjzsqmqAYMWMA0r3wHa/li+/GZ/KSpx34
	T2qt2OBd+k8Kr1vWZtohDkOHgrWLwg+oZ1XuENa8yvAmys6C90EKnbFWtOOWYzThFF0rnpzpJAl
	VT/l8NM2nir0qPhZrbUf3qvm9813gN/5PPXl3/hKHAn4jwGmkezwLjgKXolFZyACFApVNvKDJQi
	XhoKlCZ2fphdzfFfHyjpn0Wa+Gh/7xk9Weuk4Kgb+6SgALBmvYYcHM8YOv0MBbHW6YCcgQLbv7j
	M61RYbxGG8MkS8lT8LMArAKV248vRRug+3NFriQ7dTWGo93s90HgB6pIMRxvrw==
X-Received: by 2002:a05:620a:1913:b0:7f1:9a91:1dde with SMTP id af79cd13be357-7f19a9144d8mr989207085a.20.1756287334746;
        Wed, 27 Aug 2025 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2aVIZceEmeuIaXPM4E0OwdyqHE2I9pakBoXeuwOZHcZ1gpwYn5EvPozgzRW+JuFbVfaucVg==
X-Received: by 2002:a05:620a:1913:b0:7f1:9a91:1dde with SMTP id af79cd13be357-7f19a9144d8mr989202885a.20.1756287334240;
        Wed, 27 Aug 2025 02:35:34 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f4eef7101asm266977985a.38.2025.08.27.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:35:33 -0700 (PDT)
Message-ID: <4e148b62-a7c1-4162-a487-1ab0199b774e@redhat.com>
Date: Wed, 27 Aug 2025 11:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return
 false
To: Andrew Morton <akpm@linux-foundation.org>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 03:55, Andrew Morton wrote:
> On Wed, 27 Aug 2025 01:16:24 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:
> 
>> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
>> sense, and a different (theoretical) implementation may dereference
>> the pointer.  But currently, lacking any explicit documentation, this
>> call is legal.
>>
>> But if somebody really passes NULL, the function should not return
>> true - this isn't the huge zero folio after all!  However, if the
>> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
>> is_huge_zero_folio(NULL) just happens to return true, which is a lie.
> 
> Isn't it a bug to call is_huge_zero_folio() before the huge_zero_folio
> has been created?

It's a bug to call a function that expects a folio without a folio.

> 
> Being a simple soul, I'm thinking
> 
> 	VM_BUG_ON(!huge_zero_folio);
> 	VM_BUG_ON(!folio);

We should just do VM_WARN_ON(!folio);

-- 
Cheers

David / dhildenb


