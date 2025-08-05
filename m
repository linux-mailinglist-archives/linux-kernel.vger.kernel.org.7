Return-Path: <linux-kernel+bounces-756965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41334B1BB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ABB17E7A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65E222562;
	Tue,  5 Aug 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTn6mdnm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB012E7F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427957; cv=none; b=Ac4AXQ6+qt3GzTb5hvyiqdbHgL29Bm0IVVsCba5/Okj9bMh1M4Ca8TuZLv5yLuVCNcpkF9Kl7niXvLlZpOgipgh/R3n/X1GSF0ZaGDW46nNI3TM6DeBn/wfwzCPUuo2TVs3txfO8JTfFQHskKlH6jei0Q02zO4/bFTok3W0iC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427957; c=relaxed/simple;
	bh=9e/lP0asTGntqiEPgqegzLOtEtQILHHgJTMM5RKj8Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU/RSEIDyCZk1OZZ7L/dYhiQ7Gg6vwgYmzlBXUUf+d7DXpcgfCRoytOhRuPQo1LA/kvO9s9iHrHsvw3f1Z/jezMP4cnJKO5s6yZaww8O+qv+13+nDhNFUOTC/EhpG/UCNTBXt4k+O6mRb6191ll/FoxmBdvOSOWhA5OSPktClF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTn6mdnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754427954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kqRftw6bnCaiUsG4UzgVQFaWyDy/FQcqP1mg9FWcAs8=;
	b=eTn6mdnmQZX7geTCdKAUh91bnQNbJTNLUPCCBjI7OcCB7qxqIlDGm1QjHKFKsVVGbS90dz
	lzq2LmFkWYDnBXsJ5D1NH8+e5u7a4dVYQVAVpWFp1FIJ84x/W0I0BYkKqIIjLRYaULIFFi
	VBkH2PoaIaL8l7ftJJf3vOPI3SP3hCE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-eVFersZYN9-rP8xGKDubZA-1; Tue, 05 Aug 2025 17:05:53 -0400
X-MC-Unique: eVFersZYN9-rP8xGKDubZA-1
X-Mimecast-MFC-AGG-ID: eVFersZYN9-rP8xGKDubZA_1754427952
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7da3647so16807535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 14:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754427952; x=1755032752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kqRftw6bnCaiUsG4UzgVQFaWyDy/FQcqP1mg9FWcAs8=;
        b=bq7ffKTrg7q1PfNstJCRlQm+SfdUYzFkJjdokXJIcMa+0tM9aNuPZ5UnNIdpSSWxB8
         vaUbTld12GRwEM/J+DB6KuOxtAUV0aPTkddZ+ax7WnytnltAetpx4vwVUI4JnNBsYv5h
         qfjGUvh5zPLR8y/7wyehkAOajLEBDfsV8fkXihXSx0LASdj0AgztrcRo87FqMshX50kd
         Bjc1gwDvAbmc60H2h+1/6nTuSFPurZGQs79gBHWdJTcF9eyxVohv0m/pSe+JXvERJNPm
         CXZPyIFLzuM0R0g5jp2LQEJGUV5byQA3vWYDMFsUAz0yjLfAS+lv1YvqHsAP3imWZqfg
         mAbA==
X-Forwarded-Encrypted: i=1; AJvYcCXj2f6iAGTaK3axldhPYO7BErgvhi1JIJFiVMK7YJMtf+8QjTsuvmq9BqzxTXMJunAZ1Q9r5Jf9yKiTU8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWi4V0LxluQCraZhzSvLpkzAfb9MYxd6Kr4SX3ipQXiDpZnSgd
	1zjxk2kH7EBUy6x03GB81N6RT6/E5QJQtHN6GX1MWLZtK6XZYHa0kTZPYkg0lAwOmvFoF8TCMbJ
	pDjxcBs3ofyjJ+K+TKM9KQZqX2ITPeh+lcUlcDAp6/vYkSkvT5oxMLwLBWz6dhJwrSg==
X-Gm-Gg: ASbGncuUUSoitokX87a3QQQQ7PCU8MOnj4Gugt1DPcW38uY36eKphWjRsihvVyDRSOQ
	utUR1+LkyeFSUwYbJKEb867qqMLPFPHY3jfiEokwz3KIGWBuxFUTX61IVx4NnC/Kwg9Ngqmy/Ed
	GbUORItOwAPQbE4S88SRhpyZUMov0FIgVKgm6atMrFc2oSUPxSHoMFZZWeR36GqE7v8jigR5hWG
	HVhHsCvGYduyy43n/5Nn1bb2jbfOc41nUmm/ugAoff4QdtMuqVXUNFKYuB/iBDzXAMwFDDupd+m
	GoM7BMAa1gyagiKDzGXmg7AzlB+9Fotz9876xCO2yXwrKTtT5zByl2Vlc7vY19Li9fk7uiMwj6/
	+UvEuTyyFWjacsFzdHDoMAWB9JcPdTAk5zlqNRHyYgxB31iqIxq8AghTFVCOZXNhlvJk=
X-Received: by 2002:a05:600c:1546:b0:459:e165:2661 with SMTP id 5b1f17b1804b1-459e746f7aemr793725e9.23.1754427951909;
        Tue, 05 Aug 2025 14:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ovmpQA6VuHrG0lBxw9kWz1GZEQp6ylYtVCMl9eYwZWu5JTPAOqCzL2hWks9vBLR4tNTzEA==
X-Received: by 2002:a05:600c:1546:b0:459:e165:2661 with SMTP id 5b1f17b1804b1-459e746f7aemr793515e9.23.1754427951433;
        Tue, 05 Aug 2025 14:05:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4b:5100:3004:3864:4049:722e? (p200300d82f4b5100300438644049722e.dip0.t-ipconnect.de. [2003:d8:2f4b:5100:3004:3864:4049:722e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469093sm20686698f8f.51.2025.08.05.14.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 14:05:50 -0700 (PDT)
Message-ID: <9cfb5b1b-f565-4129-a3e3-fd16a38997da@redhat.com>
Date: Tue, 5 Aug 2025 23:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
To: Zi Yan <ziy@nvidia.com>, wang lian <lianux.mm@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Wei Yang <richard.weiyang@gmail.com>, Christian Brauner
 <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250805175140.241656-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 19:51, Zi Yan wrote:
> FORCE_READ() converts input value x to its pointer type then reads from
> address x. This is wrong. If x is a non-pointer, it would be caught it
> easily. But all FORCE_READ() callers are trying to read from a pointer and
> FORCE_READ() basically reads a pointer to a pointer instead of the original
> typed pointer. Almost no access violation was found, except the one from
> split_huge_page_test.
> 
> Fix it by implementing a simplified READ_ONCE() instead.
> 
> Fixes: 3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Ouch, thank!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


