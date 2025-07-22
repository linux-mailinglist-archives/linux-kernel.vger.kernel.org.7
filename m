Return-Path: <linux-kernel+bounces-741460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AAB0E467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D8D1C86699
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B042853F2;
	Tue, 22 Jul 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNpCt08M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E882288D2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213951; cv=none; b=uTHE8LSFce9/Lj82YD0n9gOpfYImF6PZ3BEK4aeUappyaxCvXxd/V2Qn4ZhJTM00p/lSkqSIJbtExlW3AFYomw+WWzJhtDPpaYRDiTX3yTlM8VWclz/a56EhUjz36CFlU9LEY+3TNEs5ExqS/JspuhGXc8nj45SMNzZ6rtd/xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213951; c=relaxed/simple;
	bh=7+pcUyqgjMHQAplOzyoZQFSGbEZWMIEasB3Fc7ZZGnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye1VWe1teQBZYf4XyJFKAmXcXYSCDzBkPvzUDTfhvez+5HwyfQEOvNKV7g1FRP49sVsfz6yde8j2NAAv1H6pIu6Q9Ef6BJaFWuBBqY6nh7+/OX61/MYuDxBv4GSfXgoeM6UOclAOhDfgnovDs3xxboqgUMfdriVB+lEah4DxEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNpCt08M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753213945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tD9jiUjYIe8zYIe4eFuBdSpjTfktPJUQThqoL5NZe28=;
	b=cNpCt08M6BeFY29y+WDJn1avVhXCddG4SvSYwXMmSPbkJCfHJsznXHJKJiehhj+mtHaFjs
	BwVvbJ1xoMyQ4sOKtulh84b15jcJ6Mp1V10UREuECNIk4u8+M+XwjJ1m8yX29oejTwwsee
	lJTqyFHydBwZF3vYQRAU0s8AQQ3ndPE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-hVHqd-_YMtKtvPg78Clvtw-1; Tue, 22 Jul 2025 15:52:23 -0400
X-MC-Unique: hVHqd-_YMtKtvPg78Clvtw-1
X-Mimecast-MFC-AGG-ID: hVHqd-_YMtKtvPg78Clvtw_1753213943
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2266930f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213943; x=1753818743;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tD9jiUjYIe8zYIe4eFuBdSpjTfktPJUQThqoL5NZe28=;
        b=GqKS7rHMOMUUecr/drNZLIBJN916AGGLS+G69hZY5BwgMyt4/aVbY73oP1GeuB2fUp
         fg69ajvPs/i1qe6BiEjhsWvxkoM5ZSI+NZYXyx0g04qe4TFVAyeqF5iofm06Z/nT+9PG
         cKOuKzTLGdL//V8CoygnklGvuPmnzz+gIN0hZNd+4LdItfzOjp3sxRWXScoSB0mCBLfG
         ZAi/1w0OCWxeUHSWTV2QPiF0QMre/j1uPk73vYKuK3sLZCF2Gb0bWL/mBY+k/MWuX9zT
         o6bHorEzTeqjMYvw5ye+B6whHQMytY+o6nueci9FbZoJneW+UkRLrlU0gJiEq0bqoUmI
         a0pw==
X-Forwarded-Encrypted: i=1; AJvYcCWX+latnIqI8xdrPrsIvU+YDr9SnkdQPfdVcvaxxzIFMWU7/PROGDyJupQl1zgQo+OjUJxu45qSiDNAbH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAWHkpqQOc0ZCoUGG9SrPhzzX1jl4qwpSwbdWEOBedwAlr8jb
	CmFbADD7TmUeN0cIPwDGV5j75C08wOXxYmHKzeY4jP+DSIpyH4mBtyYYN2XG42PTzMXy6DkXSQR
	dkIVB0Z32BJc/9ksn2LYj9diOTyGcPk0P5rzLEVMZGCdqTk1TBdJpVTG3qr2cIR5E2Q==
X-Gm-Gg: ASbGnctHqFN27ESRNTIC6xMPADbGzVaLSDr3mXnEs3VfuVr9nYIn3lTXwT1VyeZepEu
	XHobXs1kKSqL2a2YoKAM4+2G5qNM62D2Jd1z72VJ3vt/fBTrtyRFUdeoaC2CNJl7bjHKbH8cVv0
	VfDysMcqKAb4u9WILrOqLJ7Yp+s9De2NFPDD0AcEfooO/Ita6WvqDgbJXql6Lm3te+PkJ4AJ3KU
	BBT3T53Ak2HXapCiTdM5aS/9wvlzxfN2yYUqwFeX4BKtAKT80ZXEIRiv2P4kc7McH2CJ9vW/rwL
	XhsvUhxqgAa+Qr8ARREcEOZ73ivuuXH1gPvY7Zfzbjz1M2vd6fMC0U4jnaIt/1OH+3elsYfUH63
	/o/RZwRojalzEbd4QWxLvr3MdiO+kWIXI4chM6x3wtjIgZ19HYFdvgUqE2xHNB+es3x8=
X-Received: by 2002:a05:6000:2901:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b768ef3c05mr430508f8f.28.1753213942677;
        Tue, 22 Jul 2025 12:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxjPzE6sEuOfFSda8Shbpmks8LbyR4O8i10oMHV+LZdZJzBpZoh5NGpkpHb9XCz+0yB5hopw==
X-Received: by 2002:a05:6000:2901:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b768ef3c05mr430492f8f.28.1753213942208;
        Tue, 22 Jul 2025 12:52:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb80sm14421672f8f.23.2025.07.22.12.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:52:21 -0700 (PDT)
Message-ID: <883296f4-ec25-4961-aafb-b2ccb1607422@redhat.com>
Date: Tue, 22 Jul 2025 21:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move memremap.[ch] to hotplug section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>
References: <20250722172258.143488-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722172258.143488-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 19:22, Lorenzo Stoakes wrote:
> This seems to be the most appropriate place for these files.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..68b8407926a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15729,6 +15729,8 @@ F:	Documentation/admin-guide/mm/memory-hotplug.rst
>   F:	Documentation/core-api/memory-hotplug.rst
>   F:	drivers/base/memory.c
>   F:	include/linux/memory_hotplug.h
> +F:	include/linux/memremap.h
> +F:	mm/memremap.c
>   F:	mm/memory_hotplug.c
>   F:	tools/testing/selftests/memory-hotplug/
>   
> @@ -15747,7 +15749,6 @@ F:	include/linux/memory_hotplug.h
 >   F:	include/linux/memory-tiers.h>   F:	include/linux/mempolicy.h
>   F:	include/linux/mempool.h
> -F:	include/linux/memremap.h
>   F:	include/linux/mmzone.h
>   F:	include/linux/mmu_notifier.h
>   F:	include/linux/pagewalk.h

As discussed, alternatively some ZONE_DEVICE stuff.

But memory hotplug is fine with me as well

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


