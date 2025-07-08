Return-Path: <linux-kernel+bounces-721950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D1AFCFE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804981C20BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D152E266F;
	Tue,  8 Jul 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChtANLo6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84A2E336D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990260; cv=none; b=RPNvhPdFU9M2Pe2cEIZJOsVPewOA6H2QkjVWOhhVICMQ9T6rfHdVZ3Tqr9KKBIW7l8RATlOzOMZwtcT5bglL24vF/Aqei1QDQZTm+HwsE8DyWfoUS0uwZ63TmhAgFLQGRFRd+taFHJwgBYoKBABT6IhR5+n4/k/BHuJH3b1YDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990260; c=relaxed/simple;
	bh=3YXcjALQvcsC5zJJ90z/Tt2gqOrb/rdUD3FPzcqMMGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp+MsOOcT3WiV68grbOma1SA8ef5Ek0VGPoQeZ8Ag+1fErqdWutO7VpVimqS2DlpizJ52i2ay9Lt8MmjsYxtFMJGavyV0Lzjn/rboEwXXi6gTxd7Sff7lV50UlrwHsrCAK3IPEvzSvESJ9sA/X2HQ+hxbVU9nOz9CVli0uUtQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChtANLo6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751990257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4RZO/B6cckBZV2TmP8OYCYVRHKXld2Kk5UsEofX/mOs=;
	b=ChtANLo61K2yZonTLdRUFvBjH8hiZjzIbe8WOgazP6CpcikbCJsP5aI2ggArWPUIvNI3fK
	0TFW2mfUtCuHsfj8fiH573kmM7/BQPMEFIImwoO1S0jgFevxPrvWoG/02K+DlASApMgWTw
	uVGRikJ8SHtEPJ6LrvW0JOJxFSv6/xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ESy7NOfOMtOdn_vNW8Jp7g-1; Tue, 08 Jul 2025 11:57:36 -0400
X-MC-Unique: ESy7NOfOMtOdn_vNW8Jp7g-1
X-Mimecast-MFC-AGG-ID: ESy7NOfOMtOdn_vNW8Jp7g_1751990256
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b39cc43f15so2205725f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990255; x=1752595055;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RZO/B6cckBZV2TmP8OYCYVRHKXld2Kk5UsEofX/mOs=;
        b=LGoWSsEJOIP5K71hzARgJ4OOunQcYarK3tcQolQqj3jA1ybvkC8FlWEefubQg4eQmc
         TeGO0zdqHr5wU4bzgAkCxyFmtEYzWaeIL1nKLyp2+Domo9g0HK/TUSSQQthBBb78/Iu9
         gIt/K/867b34FDk7Hi40oXy1TJH7uTcVCTI/kjKp1s6vuWwK/zLqhMPR6JwsCGejij7h
         6w6XnY+Sls4ShiYJ+sN8drcGSfPSjixeP9VobaHsvV0fSkNDfLm8aGFeD85jLlq4Frv2
         uMsvMPkYOQD2Plu9rPWApypw49q6urzp6UAuS9wIERf5H015TVpQSKia+7Rz1s3ysV4H
         AcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNQvDlA3803Wbf0v2Ov5vw6/uvtqmyU5B9Ci9eW9f4gnHe+lOKT3uchPmG7+257L1bGFyHUchQge9UdRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGABsPfYgsLOppMttdZ+6Rnm2svLonBfh05QVCi302sEjd4b36
	0PBbUgNaRVOTTdycHm65DOmzBuJ4gKI2omkxA5QKHcnR6MnaHZ0tY3BI1q5HWRsO1HPSRANWPPJ
	DjWoVa2Dho/z4F1nUijGAtOP684HSJNs38FqzPRTaEJJ7o7EAtn0odAgJDhCvgJhxww==
X-Gm-Gg: ASbGncubX7aer+Cga1Eqi9OR/v1QsBAhBrZ5f9erLYwYLjfz7AOTWPB+wzjdVdKkzIX
	E/zjxEsoBVZg8+WRWLX/cGslXy2UqZq6AJJURf7XFW90fHUAG5Fn59J/u4+Tj6U8YaxDMxk/uEd
	INYn+C0wNSLBT7TFTupskcHS5Z4pQDWex+VxgBVhQTAAng7VHXLv93IiKlZoz7nUAoFZEQgPX3T
	gZIPvI2E4UYO5AuQ914u72mI9gA4MbMq11+wB2/50zMLRGlm035RVXO1BNAO/HU8eUQa+0i0P89
	Efp57Zt6uE2UHP/jlJfay/OII4ollyMo19M7G9k/CeAH43QB2AvXyS31spI9SCvKZ2MNF7Uu+zD
	ijofyCJEtj2CQv1+qQIfiEcRZKFFrZ+IAZZAk8EkXpzD7eO+SgQ==
X-Received: by 2002:a05:6000:41d4:b0:3a6:f30b:2dd6 with SMTP id ffacd0b85a97d-3b4965f6d96mr17901727f8f.26.1751990255379;
        Tue, 08 Jul 2025 08:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcGSrfGZ1BZUugI8BDX663vUiqM3J2TknJLhq+/2BgGK2arLtn/575E++y4wnCR+TyAdpncw==
X-Received: by 2002:a05:6000:41d4:b0:3a6:f30b:2dd6 with SMTP id ffacd0b85a97d-3b4965f6d96mr17901669f8f.26.1751990254893;
        Tue, 08 Jul 2025 08:57:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d3f73sm26143715e9.0.2025.07.08.08.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:57:34 -0700 (PDT)
Message-ID: <e35a4316-f6cb-4f1a-b338-4e62c0974d2c@redhat.com>
Date: Tue, 8 Jul 2025 17:57:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] khugepaged: rename hpage_collapse_* to
 khugepaged_*
To: Dev Jain <dev.jain@arm.com>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-2-npache@redhat.com>
 <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 07:14, Dev Jain wrote:
> 
> On 02/07/25 11:27 am, Nico Pache wrote:
>> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
>> as the function prefix.
>>
>> rename all of them to khugepaged to keep things consistent and slightly
>> shorten the function names.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>    
> 
> You are essentially reverting commit 7d8faaf15545 which adds the
> hpage_collapse_ prefix. Since in the next patch you also unify
> madvise and khugepaged, removing hpage_collapse prefix would
> make sense, but then I tend to agree with Liam that dropping
> the prefix altogether is better. Having all the functions in
> khugepaged.c prefixed with khugepaged_ seems unnecessary work.

Yeah. Or just "collapse_". Anything is better than this "hpage" stuff.

> 
> @David, I forgot where you replied but I remember you saying
> that we should not introduce MADV_COLLAPSE mTHP support for
> now?

Yes, that's what Lorenzo and me discussed. Better to keep it at PMDs for 
now, as that's what the current interface promises.

In theory, we could do something like the following without causing too 
much trouble:

Collapse to the largest THP spanned by the range.

I.e., when collapsing a 2M aligned range, only use a 2M THP.

when collapsing a 64K aligned range, only use a 64K THP.

etc.

Because that would keep existing behavior mostly unchanged.


But I would defer all that for now ...

-- 
Cheers,

David / dhildenb


