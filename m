Return-Path: <linux-kernel+bounces-641352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14504AB1061
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FA51888628
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F928D82F;
	Fri,  9 May 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXV3WeeK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7E226D04
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785944; cv=none; b=e6wJ0nXpg4LiXE9rfOeUlHgvOIpWVbnDhK1nj/2LqME66DNE571qWLBbiSIL16Ds1eK+kCD3rNRiVJXyrWxGax/T8CaPXExT7GXMITkcb0GaxM847k/5U/9JtblkScDNqWqVln3awbK9vCEE9/z44swlhgAAsqBUn4KI0wokHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785944; c=relaxed/simple;
	bh=jqxYVU6GJTi9RMs4b+s1yk10X+ILJvKnfqth/cu5hZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMsKgitEZdMlIPwbBBdYXE4UoQ0vCiUiYZDHz/eEIQn5lZ7Fp8oxZlFukmxInWZhH+8tuwNEWkYRCoqdloUlqemufmAIJA06NMlRB+7XuuH5mir3A+4Bc+ExE0gmy5r48SXNJVK3sbQmb9ZFtHQuWllSxwneg36owj4pY2oKqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXV3WeeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746785940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XftaH5FzyM09S5RzjEe09GkGUeEVV3zeck5+IqSohtk=;
	b=XXV3WeeKE80zcQ+sb1rhMEXPmEwRL5ly4dZzK4wtcrxhISggrYrtZit8RA7aAPVvzzjni2
	/JkfuzIaqcnNVJ+khhrJLOuQMucwdOC562Wq+1o/uFEFi6PEmFwLy+9oU/nPnZlEVKq6qv
	97OX8c2ivGmM5IrUaEyVd7/GqJCvDxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-23F_yfHkOSKrfFDdpw5gdA-1; Fri, 09 May 2025 06:18:54 -0400
X-MC-Unique: 23F_yfHkOSKrfFDdpw5gdA-1
X-Mimecast-MFC-AGG-ID: 23F_yfHkOSKrfFDdpw5gdA_1746785933
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so8095965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 03:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746785933; x=1747390733;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XftaH5FzyM09S5RzjEe09GkGUeEVV3zeck5+IqSohtk=;
        b=AMT49JIjQT7nOzW1nidM4CaQFpsHHckmefnoG2r0RkJ/wjWt5BV8bgFtJTZWzK4bWr
         awJOKHMbre3SKKQ/k7k2wXXCAFJzRqepDP3V+bC/9/VMUeHvpqayI9ErI7lwriCtv8g8
         Vplr0sFerfpwY5nXlDuxSpG2YKX6/Px6NRoyTya7xEce0zbffxla7KnNHUluVDzfm1EU
         EzU/wZqvPP3mtL+CdOlw820nxE9ELfMIX71JQ6+yeCjpUNfU4uxerV6WvvJu9XJ19goC
         IEyawXixOv3NFMXJqgestrOOAuN6BIdJat6Na4BaGuv6DyGgl71OmPDh5bmcjmfy2umA
         X3KQ==
X-Gm-Message-State: AOJu0YyCfO6K7h7FfLWGJqLdTJzjR4sBdCueKJnpL+A82AmUVMiNU/IZ
	5FGHi5XLQ+zbEjUGmIrqvWC02dHYtIkKkT66ThEvDeLHxZR0Bbpn1dehHo6xo7//mYKXNRs683F
	jM9y5+J/gR4DmP6UVEgPwJ4+3YnNldSuII1ByY7CGyewPjJ/1+XPljl07qtebag==
X-Gm-Gg: ASbGnctHDFmxf4HT082Lj1txmHUggvBQYLxiliZU2V4F60gie1E8p5eGTRJ0ZzbzhPM
	q/lg/3zqjAMd0Mt3mdm7Vj8tjMhn/2MpqtIZv+i1X36DNTenqyuWQchJLzmbFIL1CMkLWK9JtbJ
	DaqMsEbicP3W4lH7dEyqpoWQKerIhZVIcQFu+sNO5Vc0WJdynkF+f6RA3iEsS3qWyU3c/nbOFav
	O2h7Y1BoBwe6lxKpVw+l1RZFQYCWsvXImEoIh2u88R6wbEjjdkmBdAWS6Q0VNmU1Egs+HyEINdR
	DcFhj2ykOozOTTjMKU9NZgKsHwdHMGRecL1Gowg3/2FPF5tzqslqK7B9WRTyvMzYLkIUoZoO4la
	CIuxIihM2SEJlNV4b1Usvc6PuU4ex6w00MPohpCg=
X-Received: by 2002:a05:600c:5344:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442d0312e08mr49366255e9.12.1746785933140;
        Fri, 09 May 2025 03:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqSJEKsdFSiAMvPUrkU1iyZ1YBftQM/bXhK6JeyEYDfVJdYz7LYXx6vbUhXVTAL2+Dc5eQTQ==
X-Received: by 2002:a05:600c:5344:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442d0312e08mr49365945e9.12.1746785932599;
        Fri, 09 May 2025 03:18:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ee33bsm24482785e9.20.2025.05.09.03.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 03:18:52 -0700 (PDT)
Message-ID: <4efa9948-a523-4597-baa4-c36d18a658b0@redhat.com>
Date: Fri, 9 May 2025 12:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20250508222041.1647645-1-david@redhat.com>
 <8c94faf4-9af9-4d43-a597-6b06dd21be95@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8c94faf4-9af9-4d43-a597-6b06dd21be95@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.25 11:49, Lorenzo Stoakes wrote:
> On Fri, May 09, 2025 at 12:20:41AM +0200, David Hildenbrand wrote:
>> Let's test some basic functionality using /dev/mem. These tests will
>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
> 
> Ah this is really nice thanks for this!

Thanks for your review!

> 
>> 	ok 14 mprotect(PROT_NONE)
>> 	ok 15 SIGSEGV expected
>> 	ok 16 mprotect(PROT_READ)
>> 	ok 17 SIGSEGV not expected
>> 	ok 18 fork()
>> 	ok 19 SIGSEGV in child not expected
>> 	# Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> It'd be good to assert that merging doesn't work for VM_PFNMAP, though hm
> one could argue that's not hugely useful as it's trivially implemented.
> 
> But I guess anything like that should live in merge.c.

I assume we'd need is_range_mapped() from mremap_tests.c.

Something for another day :)

[...]

>> +static void signal_handler(int sig)
>> +{
>> +	if (sig == SIGSEGV)
>> +		siglongjmp(env, 1);
>> +	siglongjmp(env, 2);
>> +}
> 
> Hm, wouldn't it be better to only catch these only if you specifically
> meant to catch a signal?

I had that, but got tired about the repeated register + unregister, 
after all I really don't want to spend a lot more time on this.

> You can see what I did in guard-regions.c for an example (sorry, I'm sure
> you know exactly how the thing works, just I mean for an easy reminder :P)
> 

Again, time is the limit. But let me see if I can get something done in 
a reasonable timeframe.

>> +
>> +static void sense_support(void)
>> +{
> 
> See below comment about the kselftest_harness, but with that you can
> literally declare fixture setups/teardowns very nicely :) You can also
> mmap() these 2 pages and munmap() them afterwards straightforwardly.
> 
>> +	char *addr, tmp;
>> +	int ret;
>> +
>> +	dev_mem_fd = open("/dev/mem", O_RDONLY);
>> +	if (dev_mem_fd < 0)
>> +		ksft_exit_skip("Cannot open '/dev/mem': %s\n", strerror(errno));
> 
> Hm skip, or failure? Skip implies it's expected right? I suppose it's
> possible a system might be setup without this...

Try as non-root or on a lockdowned system :)

> 
>> +
>> +	/* We'll require the first two pages throughout our tests ... */
>> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_skip("Cannot mmap '/dev/mem'");
>> +
>> +	/* ... and want to be able to read from them. */
>> +	ret = sigsetjmp(env, 1);
>> +	if (!ret) {
>> +		tmp = *addr + *(addr + pagesize);
>> +		asm volatile("" : "+r" (tmp));
> 
> Is this not pretty much equivalent to a volatile read where you're forcing
> the compiler to not optimise this unused thing away? In guard-regions I set:
> 
> #define FORCE_READ(x) (*(volatile typeof(x) *)x)
> 
> For this purpose, which would make this:
> 
> FORCE_READ(addr);
> FORCE_READ(&addr[pagesize]);

Hmmm, a compiler might be allowed to optimize out a volatile read.

> 
>> +	}
>> +	if (ret)
>> +		ksft_exit_skip("Cannot read-access mmap'ed '/dev/mem'");
> 
> Why are we returning 1 or 2 if we don't differentiate it here?

Copy-and-paste. As we are not registering for SIGBUS, we can just return 1.

> 
>> +
>> +	munmap(addr, pagesize * 2);
>> +}
>> +
>> +static void test_madvise(void)
>> +{
>> +#define INIT_ADVICE(nr) { nr, #nr}
>> +	const struct {
>> +		int nr;
>> +		const char *name;
>> +	} advices[] = {
>> +		INIT_ADVICE(MADV_DONTNEED),
>> +		INIT_ADVICE(MADV_DONTNEED_LOCKED),
>> +		INIT_ADVICE(MADV_FREE),
>> +		INIT_ADVICE(MADV_WIPEONFORK),
>> +		INIT_ADVICE(MADV_COLD),
>> +		INIT_ADVICE(MADV_PAGEOUT),
>> +		INIT_ADVICE(MADV_POPULATE_READ),
>> +		INIT_ADVICE(MADV_POPULATE_WRITE),
>> +	};
>> +	char *addr;
>> +	int ret, i;
>> +
>> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> 
> Nit (same for all mmap() calls) shouldn't this first parameter be NULL, by
> convention? I mean not a big deal obviously :)

Yes.

> 
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* All these advices must be rejected. */
>> +	for (i = 0; i < ARRAY_SIZE(advices); i++) {
>> +		ret = madvise(addr, pagesize, advices[i].nr);
>> +		ksft_test_result(ret && errno == EINVAL,
>> +				 "madvise(%s) should be disallowed\n",
>> +				 advices[i].name);
>> +	}
>> +
>> +	munmap(addr, pagesize);
>> +}
>> +
>> +static void test_munmap_splitting(void)
>> +{
>> +	char *addr1, *addr2;
>> +	int ret;
>> +
>> +	addr1 = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr1 == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* Unmap the first pages. */
> 
> NIT: pages -> page.

Ack.

> 
>> +	ret = munmap(addr1, pagesize);
>> +	ksft_test_result(!ret, "munmap() splitting\n");
>> +
>> +	/* Remap the first page while the second page is still mapped. */
>> +	addr2 = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	ksft_test_result(addr2 != MAP_FAILED, "mmap() after splitting\n");
> 
> Hm not sure what the assertion is here per se, that we can munmap() partial
> bits of the VMA? It'd be pretty weird if we couldn't though?
 > > If it's that we don't get a merge when we remap, we're not really 
checking
> that, but you actually can, as I added an API to vm_util for this using
> PROCMAP_QUERY (very handy tool actually - binary version of /proc/smaps).

I don't care about merging tests (I'll leave that to you :P ).

This is a PAT test for upcoming changes where partial unmap can leave 
the original region reserved. Making sure that re-mapping with the 
pending reservation still works.

>> +
>> +	if (addr2 != MAP_FAILED)
>> +		munmap(addr2, pagesize);
>> +	if (!ret)
>> +		munmap(addr1 + pagesize, pagesize);
>> +	else
>> +		munmap(addr1, pagesize * 2);
> 
> There's no need for this dance, you can just munmap() away, it tolerates
> gaps and multiple VMAs.

Yeah, I know. I was not sure if the ksft_test_result() in between might 
allocate memory and consume that area.

> 
>> +}
>> +
>> +static void test_mremap_fixed(void)
>> +{
>> +	char *addr, *new_addr, *ret;
>> +
>> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* Reserve a destination area. */
>> +	new_addr = mmap(0, pagesize * 2, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
>> +	if (new_addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* mremap() over our destination. */
>> +	ret = mremap(addr, pagesize * 2, pagesize * 2,
>> +		     MREMAP_FIXED | MREMAP_MAYMOVE, new_addr);
>> +	ksft_test_result(ret == new_addr, "mremap(MREMAP_FIXED)\n");
>> +	if (ret != new_addr)
>> +		munmap(new_addr, pagesize * 2);
> 
> This could only be an error code, and this will fail right?
> 
> MREMAP_FIXED is 'do or die' at the new address, not hinting. If there's
> anything already mapped there it goes a bye bye.
> 
> So again, we could just have a standard munmap(), and this lends itself
> well to a FIXTURE_SETUP()/FIXTURE_TEARDOWN() :P

I'm afraid I cannot spend much more time on these tests :P But let me 
try for a couple of minutes.

> 
>> +	munmap(addr, pagesize * 2);
>> +}
>> +
>> +static void test_mremap_shrinking(void)
>> +{
>> +	char *addr, *ret;
>> +
>> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* Shrinking is expected to work. */
>> +	ret = mremap(addr, pagesize * 2, pagesize, 0);
>> +	ksft_test_result(ret == addr, "mremap() shrinking\n");
>> +	if (ret != addr)
>> +		munmap(addr, pagesize * 2);
>> +	else
>> +		munmap(addr, pagesize);
> 
> I think we're safe to just munmap() as usual here :) (it's nitty but I'm
> trying to make the case for teardown again of course :P)

Same reasoning as above regarding ksft_test_result().

> 
>> +}
>> +
>> +static void test_mremap_growing(void)
>> +{
>> +	char *addr, *ret;
>> +
>> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* Growing is not expected to work. */
> 
> God imagine if we did allow it... what hell would it be to figure out how
> to do this correctly in all cases :P

:)

> 
>> +	ret = mremap(addr, pagesize, pagesize * 2, MREMAP_MAYMOVE);
>> +	ksft_test_result(ret == MAP_FAILED,
>> +			 "mremap() growing should be disallowed\n");
>> +	if (ret == MAP_FAILED)
>> +		munmap(addr, pagesize);
>> +	else
>> +		munmap(ret, pagesize * 2);
> 
> This is a bit cautious, for a world where we do lose our minds and allow
> this? :)

Yeah, went back and forth with this error cleanup shit.

> 
>> +}
>> +
>> +static void test_mprotect(void)
>> +{
>> +	char *addr, tmp;
>> +	int ret;
>> +
>> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
>> +	if (addr == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
>> +
>> +	/* With PROT_NONE, read access must result in SIGSEGV. */
>> +	ret = mprotect(addr, pagesize, PROT_NONE);
>> +	ksft_test_result(!ret, "mprotect(PROT_NONE)\n");
>> +
>> +	ret = sigsetjmp(env, 1);
>> +	if (!ret) {
>> +		tmp = *addr;
>> +		asm volatile("" : "+r" (tmp));
>> +	}
> 
> This code is duplicated, we definitely want to abstract it.

Probably yes.

> 
>> +	ksft_test_result(ret == 1, "SIGSEGV expected\n");
> 
> Hmm, what exactly are we testing here though? I mean PROT_NONE will be a
> failed access for _any_ kind of memory? Is this really worthwhile? Maybe
> better to mprotect() as PROT_NONE to start then mprotect() to PROT_READ.
 > > But I'm not sure what that really tests? Is it a PAT-specific thing? It
> seems if this is broken then the mapping code is more generally broken
> beyond just VM_PFNMAP mappings right?

Rationale was to test the !vm_normal_folio() code paths that are not 
covered by "ordinary" mprotect (except the shared zeropage). But there 
should indeed only be such a check on the prot_numa code path, so I can 
just drop this test.

[...]

>> +int main(int argc, char **argv)
>> +{
>> +	int err;
>> +
>> +	ksft_print_header();
>> +	ksft_set_plan(19);
> 
> I know it's kind of nitpicky, but I really hate this sort of magic number
> and so on. You don't actually need any of this, the kselftest_harness.h is
> _really_ powerful, and makes for much much more readable and standardised
> test code.
> 
> You can look at guard-regions.c in the test code (though there's some
> complexity there because I use 'variants') or the merge.c test code
> (simpler) for straight-forward examples.
> 
> I won't block this change on this however, I don't want to be a pain and
> you're adding very important tests here, but it'd be really nice if you did
> use that :>)

Yeah, let me explore that real quick, thanks!

-- 
Cheers,

David / dhildenb


