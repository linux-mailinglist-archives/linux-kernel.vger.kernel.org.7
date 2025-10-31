Return-Path: <linux-kernel+bounces-879927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2CC24682
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FA014F1FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1F33E350;
	Fri, 31 Oct 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjhSmG07"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B033F38A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905998; cv=none; b=cVQu5Hoag5CExMDI/AHfP4iL9T9PQ3CrVpSVzHTVgq9H0w5qZMSk2ywHWGWj6fciB1bgR9q6ZbDj5YXgjrcT+AfHRwrw5JBFIbdDEaIMZRpXgqyhn9J4jBg/R6fHOhptR+j83lDLLu342U2KPo0uzecgqCi7ogz92kWE4rP66uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905998; c=relaxed/simple;
	bh=Futz9rPqdcpNZR/dNrHDdyBGLoH2jmV0bTLWGdXsz4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWjRnKz0eIkfB/wLU7OoEvgv2Cv/cBVwsXM2yQJZgCB/5C03ASIZW7eJtvOsH9ufyVUlc+CCDQpAQUuMgEV9u0oyFovPBeZecq0Hala1IvmaV6OLcRkfEufeuzKZLOMsuiRIKer0ps/t/FjAlWKGhgYT+IK6E78Dvq3zRPNw0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjhSmG07; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761905996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUhdGI6/kAp9JoyXZrueKpHAebmQrRzAuLyMXHq++7U=;
	b=KjhSmG072+2G7jXf8m+5amgVEH8aIry/bOmDSHpKLPV2Cm6PixfvxZXGCDBBxyTGSWF2q4
	GjGEaSp3xKH/xhE2W0XapuALPgm5XuBu1BuA3bqD5ZVcV17hW1OZU9xVuJd3eVwYem8bxU
	1CJXkQFefkXYS2NwZ8qJHW3p3+rUgf0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-v25N3dLxOfuCY-jMzD58Lw-1; Fri, 31 Oct 2025 06:19:54 -0400
X-MC-Unique: v25N3dLxOfuCY-jMzD58Lw-1
X-Mimecast-MFC-AGG-ID: v25N3dLxOfuCY-jMzD58Lw_1761905993
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42705afbf19so1184652f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905993; x=1762510793;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUhdGI6/kAp9JoyXZrueKpHAebmQrRzAuLyMXHq++7U=;
        b=epN+dosYUhkeWJ1UkN6liKsO1rc+hnWSuFtWpxHVfAH8R6BIZbKYJqqxrygogp87PU
         ObScnn2JGpXeDBWxXKXY6YQ0Dmy7SrTb2Z7OxW8uj9LX2aMGBlEnxWq9d6oTC7Bc/uTH
         SmhdM06EUx/JrwPKGX/1rENbFEghqmGnyPqPyoMr2A/1Nai11/tN+mSfITvPvNuDOlVG
         7fYyrnpj+XZaISZdAdUCGuAcAbJlXWOz/bifqegTCLW+JBeEJ4Am/iO7BhNeD/HV4HrN
         s2Rk2r2wRQu29i/3mVSkOCT9fB4l9z3S/ZnLALiF0MYnWZ4d2qdMDd/2+AjReU9V112t
         TaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV09uykSKRA1+6oviSGMFdvBsXCAVtpvY1joosycSFhZMhs253x+H2QJQbDMuS4beiTCW19FRNZDKeo+M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jzZeKCPAS2L6WHRHscA2DxsbvMpYjUujvU2fhqhXy+rvPdPI
	+50bablQhDRIBf20oCTd3zmSisJm+/XCQlXDHE8Mt01aSdd+a6xRC2okTLRhwlKjCIkTZTSl3H6
	mnNeFHF0H1uqJKTINCdA9ilFKagnq/mI7Uh9lbyK1vs1xF/aT8UP52aLun1Pl0UC7pNMpPBmeRQ
	==
X-Gm-Gg: ASbGncvg7Pfygqd0hgWwdRnwYsZ1docuzvCtELuas0l5m0p2Z7NN1/IJkba1vmUXwTb
	S+FO8v5Z54QJn7OcvtU++JGwG+Adbq+lHJWiIak4VQ6FKiLjkA/AHPoClbtinfZgSgSlgmQx2y8
	b38uMLFiz/WVMChujWR1hAfgtlfpzpLTraS7qlfgzopB5Rk/rsz0z+ELXeZGkaJjENk/XzFmZhK
	ohAY04vLr8knLi5P5nE6PqSRoVg+IHx/IEIr2jCry9pVLHLqaghRXLRztBWZadDcyBPz0neHhGN
	3rHbn4qlzl1d+qcTQZMdskOe3qJqZr3zro3J5LKAZBQOoFGmo3/CAW+N/D8C4XISt0DpA0xw74f
	IXZp7zr29S2AHrGbPIId/MUAM0uUU1EggZWCszteyNz/XB8I586ok8NIzwhKkuubCcHvK4EIKeL
	1FcwPCJDJUehBZyboZhlbyk6P7Y9M=
X-Received: by 2002:a5d:5d85:0:b0:426:dac0:8ee8 with SMTP id ffacd0b85a97d-429bcd05203mr2998219f8f.10.1761905993324;
        Fri, 31 Oct 2025 03:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8jpSFh3hhPp3PzJX0f48uDqqqBw7iyd7GjZkB/l1xZ2kBNbllkQmlUEXSQLnQvjsz9LvTiQ==
X-Received: by 2002:a5d:5d85:0:b0:426:dac0:8ee8 with SMTP id ffacd0b85a97d-429bcd05203mr2998195f8f.10.1761905992898;
        Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0311sm2647741f8f.30.2025.10.31.03.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
Message-ID: <38f0ff98-3dcd-4dc2-87f1-3ea34bb9935a@redhat.com>
Date: Fri, 31 Oct 2025 11:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
To: Mike Rapoport <rppt@kernel.org>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, stable@vger.kernel.org
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev> <aQSIdCpf-2pJLwAF@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aQSIdCpf-2pJLwAF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.25 10:59, Mike Rapoport wrote:
> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The error path in secretmem_fault() frees a folio before restoring its
>> direct map status, which is a race leading to a panic.
> 
> Let's use the issue description from the report:
> 
> When a page fault occurs in a secret memory file created with
> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
> the underlying page as not-present in the direct map, and add it to
> the file mapping.
> 
> If two tasks cause a fault in the same page concurrently, both could
> end up allocating a folio and removing the page from the direct map,
> but only one would succeed in adding the folio to the file
> mapping. The task that failed undoes the effects of its attempt by (a)
> freeing the folio again and (b) putting the page back into the direct
> map. However, by doing these two operations in this order, the page
> becomes available to the allocator again before it is placed back in
> the direct mapping.
> 
> If another task attempts to allocate the page between (a) and (b), and
> the kernel tries to access it via the direct map, it would result in a
> supervisor not-present page fault.
>   
>> Fix the ordering to restore the map before the folio is freed.
> 
> ... restore the direct map
> 
> With these changes
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Fully agreed

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


