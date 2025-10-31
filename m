Return-Path: <linux-kernel+bounces-880045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD7C24BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9C9B350A68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C120345CCD;
	Fri, 31 Oct 2025 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkWowHVv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09440347FC0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909166; cv=none; b=Ry5Hkv3FkuIZJDTxJeeQou32m/NZ0h6/s7uBPafoUNWbokPBhdJrbQExhfPHUfM0Z3fSJttPTW6Ha7GYVd8OIESkKxJ+O9ArO/FhnVIMbFp5iZ4eR4K78CBEprdLerjzCAs7KmNW264uHLy6t9klZXGuseP76+3eb60S2jb6eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909166; c=relaxed/simple;
	bh=0EAliAOpquzyO8hLsPo633zWXa1oesFLgMxZvmoxy6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0QMRRPlGCBWx0UMlpkIqUgtIdkVuouhBjrPgasWRIFPmUN+dwZO+fpR5Z2mT9DRJpbESzlHQ3+GfWsSf3gyyUE1P7+DUtzLJV/WUpE/XXSgHAKzQh0/PC/H9D3DlxvbmSnhYkDIVhjxKYMjNUaEzL/p1aI94ZkwAETcLErpO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkWowHVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761909163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJMjuxukAWEbjLCeYadmdpTDIoQW4n3g3hPUHczSukU=;
	b=PkWowHVveBO/GYNi6JV/zBbziOiDUMrlcp3wKVzHoKwPX3NRhsoDabIQxix9QH/JDmfZ7Z
	GXyt7bxJaq7XgDcd3PWvSYJFFcpIQ3ZQE5MlzunJfh2xmRVBODFkm46YvGe5rTJqASSRCG
	hpyfmJdRkLfJQr5vurQ0LphgXkqMydE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-TQsPhOYlNJ2WnbepwjfYtQ-1; Fri, 31 Oct 2025 07:12:42 -0400
X-MC-Unique: TQsPhOYlNJ2WnbepwjfYtQ-1
X-Mimecast-MFC-AGG-ID: TQsPhOYlNJ2WnbepwjfYtQ_1761909161
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475dc22db7eso17771455e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909161; x=1762513961;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJMjuxukAWEbjLCeYadmdpTDIoQW4n3g3hPUHczSukU=;
        b=fHTnPYjIm7cUjJSLk2zCRerZ+65tV7m7KVJIm7jBaOS3iUrrqK660ctxLt4VFOxvDX
         PNSSilTsg4af8eacoVxx8ZQD/dJWY4gzC2dpcE2eXsiKeMseER23UBxVO4fEdG1CJMSi
         otXoQrZhsqIKKsilbBE9agRkoL1mNs+fZzhFEN/4js9ih1mOP8nKJceCgRI4x2TjLKMq
         ty/13qdKtCq4PC1C0Pzq1kOkTy/HS6cKIxiIqK7XSOjKmKzIdvHDFdMzFSVNBRkKmwJM
         e22htr8u2EXc+LvGZU6l3aGqN7iKoMe6ja1O+aKG6UbnbyaWKk3hf33c2vu4zql5cdZ5
         X4uw==
X-Forwarded-Encrypted: i=1; AJvYcCUy9bvZdU69ZjzDOHvYM8e9QMt84qI3AKXEf/rd/UAt6u5WELo9HhkrZWuKW7cl05rQEf+rldjvUeajg68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxzoqT6fjm7lCsz11rI2B+YjKwoCpEqjZnQo8dkAR70AoUpin
	2H7Nbm1BhgU39tDrVQKfl3GqhubKHlufG62EsHHnugy7pDjdDre4pee7XEKry/ZCZTuX9m+fX6q
	9ZehEbK1C69/qK/7Hep3JKZ7DF+Iyra8MAH0V3hkgl/bObskLGDgvbxlHkWsWJ9NpZA==
X-Gm-Gg: ASbGnctOiFy5RjS9LTMp0RASzf1ZV40Optzqr5e2symNXEtu+sQtUdrJDjUaHdM6gcG
	Y34sCKbj7dm2BYqsyN/ZQksrAbySW1TMUeDN1DJSFOPGDUpMbqYi5i+Lu8yD91O+YSUjyrhUQqi
	Sllowm5o4/v5TFUNP75jkIDsWgY1P2k66+F6y+hLyxqgl+zKQXyNVHLHE+N/nB4/23MozwTyYNX
	wByLBuZGdPdvtH0zfFQGQJeY4enYK4HtSlgDbwjv7ph74Cvtl0zeUjvwkojwAA/sVP+FyzfiQxa
	/X0s7OkMtWADBcIH/zpuk3cvPZjP9nnETTqIMZenpem2DvJYxZEmBrfparq8gWTHR7JxcLUKLFZ
	Tpnsy5Is+CHDMw3VfGGb7HKNCPlr1VipwGSK5mODbI+6Veyve1jhQjPhOrTTX6VirgOlmzdTnC5
	bGwYcUsYpNB7IYZUPhz8LFrU82AtE=
X-Received: by 2002:a05:600c:4e43:b0:477:e66:406e with SMTP id 5b1f17b1804b1-4773088be60mr33550705e9.29.1761909161097;
        Fri, 31 Oct 2025 04:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA2tXUGCsDUMR6vFGWGQZdO96drmXylly2cBlXXBXlMiJWZFIq3SyIZffRE2pcpjTww5hO5A==
X-Received: by 2002:a05:600c:4e43:b0:477:e66:406e with SMTP id 5b1f17b1804b1-4773088be60mr33549935e9.29.1761909160613;
        Fri, 31 Oct 2025 04:12:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdf0sm87665605e9.3.2025.10.31.04.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:12:40 -0700 (PDT)
Message-ID: <1c0c89d3-0f72-4631-b1fc-41e1426c8bed@redhat.com>
Date: Fri, 31 Oct 2025 12:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
 <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com>
 <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



>>>> "eagerness" would not be like swappiness, and we will really have to be
>>>> careful here. I don't know yet when I will have time to look into that.
>>>
>>> I guess I missed this part of the converastion, what do you mean?
>>
>> Johannes raised issues with that on the list and afterwards we had an
>> offline discussion about some of the details and why something unpredictable
>> is not good.
> 
> Could we get these details on-list so we can discuss them? This doesn't have to
> be urgent, but I would like to have a say in this or at least be part of the
> converastion please.

Sorry, I only found now time to reply on this point. Johannes raised the 
point in [1], and afterwards we went a bit into detail in a off-list 
discussion.

In essence, I think he is right that is something we have to be very 
careful about. So it turned out as something that will take a lot more 
time+effort on my side than I originally thought, turning it not 
feasible in the short term given how I already lack behind on so many 
other things.

So I concluded that it's probably best to have such and effort be 
independent of this series. And in some way it is either way, because 
max_ptes_none is just a horrible interface given the values are 
architecture dependent.

I'll be happy if we can focus in this series on the bare minimum initial 
support, and avoid any magic (scaling / capping) as it all turned out to 
be much more tricky (interaction with the deferred shrinker ...) than 
most of us initially thought.

But I think we're already on the same page here, just wanted to share a 
bit more details on the max_ptes_none vs. eagerness idea.

[1] https://lkml.kernel.org/r/20250915134359.GA827803@cmpxchg.org

-- 
Cheers

David / dhildenb


