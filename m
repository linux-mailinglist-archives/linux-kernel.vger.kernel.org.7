Return-Path: <linux-kernel+bounces-755332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E7B1A50E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327D016F8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E57272E70;
	Mon,  4 Aug 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCX3gOaA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE56272E51
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318043; cv=none; b=Q3KcFlTXZ/YPcAFi1bA5TwLPdv1KY2DGco3jDRhuYW8lh68FkJNfzHxUaQExDLvLMoE/AC9ZtI6Ir4sVc6x5Eft+ZKouYG0XnXzFlBYS1NjKQ4Am0QEK80VdPb2lUy5sgbhHloVxUXc8ebKW6WXxyiRXjuKkXfiezDoj7YyiuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318043; c=relaxed/simple;
	bh=JHX6wnh4Y6JkizkpbmpV4IPl1gfgNXxOHw8DU/5hs/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw7Zt8zKZqsac6dC2xfTY6etUqZIaBoVbVPpi4CBYthI4PGS3Dvqq+BjZ6exxLxyQP+ToA3rmXK9vnDoQ1OfOq8RBY+44Oula6ErHGQ2zebxZ0ufUkSCj9e9ajPmfaiM5+YsgiR9mDMjn0UDtNTlTXFP+DL0YGawZH3kwdZPMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCX3gOaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754318040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qnwjgp1X7LASZtDmn58svtbysI3EXnkYQZBZvIKEyhU=;
	b=ZCX3gOaAgPV989zInz3N+CQ1LJHptb0RyFPLjDjmWtr3rZJ+NaKPsN9BjHIH8fMmbudLwr
	+zLsfxUmyCC2yOrPg3MDZmF306L7puN3m1hHLZlZR5eJZXD8vLDIlGb7zDhh2+1jm+IQX0
	GLw5GF2K3l0NFVV7hJ6OSPsrDCSxmFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-d8mPGsMTND-CPRpY_E5RuQ-1; Mon, 04 Aug 2025 10:33:59 -0400
X-MC-Unique: d8mPGsMTND-CPRpY_E5RuQ-1
X-Mimecast-MFC-AGG-ID: d8mPGsMTND-CPRpY_E5RuQ_1754318035
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458de4731b1so5750035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318035; x=1754922835;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qnwjgp1X7LASZtDmn58svtbysI3EXnkYQZBZvIKEyhU=;
        b=BEf7QS1XVfzaePyCsM7muHQfpdPnsmRyE6TWApji/JxfM77udRD4oEnUa+liYMuFVW
         sekzLDu8OAc5aubUOF+w+B6mmNZkYb/bLZtA6kJ4SYYt0/lp2mdRxlM+X6+zSTMkmSP/
         0isWn2PBPmMKhRWOuzMSXPoc6c65uqaLdcjOiRpEx2F4E6vAF2N/x74H3a8ZPyHuhqBo
         Fz4GZtE4B63dIq5vkX1vRjPUgI79q6MHVFk1Zi6SBu3aFN1wUfR5+Z2yHWSQCCBpjhP4
         VBTl4F0852dyhUR98V/UJ0oltHJPYiRHlkfsOM83BP4lXakQMkYO1OkekzwIKXKOHhHd
         uFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVmbOiZwlFESwbmpeqCnHHaM/PLf9UPg9L1Wbj1DOkdKVjkOTTk3jkt398JvrZ6jzweayhTeB0Cr8zM8/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpK2/lHHEwYBKO8NgS26qfWrW1sZ9k7FPNYJsYQpOb+UnQKYjL
	BYS+Yt9guSMOfJ7gkJfdBALgm2rsXOAG3rrNVhChYs1OqBtpMlCXyGkb0J/ck3j3EvvY0WEEFy4
	VYIud2P3BYKkXIKxiDifsAu3i6FCRNeq0X9ue9ZuBk/gRL0nMhxbZiAybcvYYXVnjnQ==
X-Gm-Gg: ASbGncv2+QOEGknu0mZPWHy9hcwFVBxSGaMJs9T+XNc1psrJmwpT23Zh2inkDedLnmx
	PjIbStQ2gYatfHGxGb/jSokJLu9Zl6KJVISGawgYJombw/t6fy7lMwgsNB+8Vgq/+q5HMwzb4Fu
	YokQHpmg52XQz6NxocGDPmyIavoQXasCiJsOiiDluCLL3rwYLTXbiLtBBvq5GDF5TFditnC8NDw
	iVtci7t3hacCvFs51e9vQhfAbNPZNg87nGozLWDzNKj7ac262tdG7S+DASOdv2hLcNeFk9ceA9Q
	+kyaBGZdJeqvOp8ohnjmDRYX6nN4ESDCjdiUJuK/3j4Xmjk8DXv5gQiZmSpmfZ3oqb5jt4N+DwL
	KCZnBWdGwaTIpoYa6STY5WRoC7bZE4RwcAcx/PraedcJ9facMVWYYQizthp38l0nf4fc=
X-Received: by 2002:a05:600c:45d0:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-458b69ef2damr90293065e9.15.1754318034919;
        Mon, 04 Aug 2025 07:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkojQLTR5ipihpzKt5Dlu57CS4vEd/SulHz0nsTGiqo0H36lZUWBrM02TTnUIZ/b9tx/UK7Q==
X-Received: by 2002:a05:600c:45d0:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-458b69ef2damr90292755e9.15.1754318034458;
        Mon, 04 Aug 2025 07:33:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm16049440f8f.24.2025.08.04.07.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:33:53 -0700 (PDT)
Message-ID: <65660d5f-a856-4244-8a81-1359a03f16be@redhat.com>
Date: Mon, 4 Aug 2025 16:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-5-aboorvad@linux.ibm.com>
 <20250804090410.of5xwrlker665bdp@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804090410.of5xwrlker665bdp@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 11:04, Wei Yang wrote:
> On Tue, Jul 29, 2025 at 11:04:00AM +0530, Aboorva Devarajan wrote:
>> From: Donet Tom <donettom@linux.ibm.com>
>>
>> The split_huge_page_test fails on systems with a 64KB base page size.
>> This is because the order of a 2MB huge page is different:
>>
>> On 64KB systems, the order is 5.
>>
>> On 4KB systems, it's 9.
>>
>> The test currently assumes a maximum huge page order of 9, which is only
>> valid for 4KB base page systems. On systems with 64KB pages, attempting
>> to split huge pages beyond their actual order (5) causes the test to fail.
>>
>> In this patch, we calculate the huge page order based on the system's base
>> page size. With this change, the tests now run successfully on both 64KB
>> and 4KB page size systems.
>>
>> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>> .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++-------
>> 1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 05de1fc0005b..718daceb5282 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -36,6 +36,7 @@ uint64_t pmd_pagesize;
>>
>> #define PFN_MASK     ((1UL<<55)-1)
>> #define KPF_THP      (1UL<<22)
>> +#define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>
>> int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
>> {
>> @@ -522,6 +523,9 @@ int main(int argc, char **argv)
>> 	const char *fs_loc;
>> 	bool created_tmp;
>> 	int offset;
>> +	unsigned int max_order;
>> +	unsigned int nr_pages;
>> +	unsigned int tests;
>>
>> 	ksft_print_header();
>>
>> @@ -533,35 +537,38 @@ int main(int argc, char **argv)
>> 	if (argc > 1)
>> 		optional_xfs_path = argv[1];
>>
>> -	ksft_set_plan(1+8+1+9+9+8*4+2);
>> -
>> 	pagesize = getpagesize();
>> 	pageshift = ffs(pagesize) - 1;
>> 	pmd_pagesize = read_pmd_pagesize();
>> 	if (!pmd_pagesize)
>> 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>
>> +	nr_pages = pmd_pagesize / pagesize;
>> +	max_order = GET_ORDER(nr_pages);
> 
> There is a sz2ord() in cow.c and uffd-wp-mremap.c.
> 
> Maybe we can factor it into vm_util.h and use it here.

That sounds reasonable to me.

-- 
Cheers,

David / dhildenb


