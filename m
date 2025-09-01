Return-Path: <linux-kernel+bounces-794353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33DB3E075
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA374437FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1CC3101A2;
	Mon,  1 Sep 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRQkw9DD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABC1F428F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723213; cv=none; b=sccBVjpsTj301DXsat5X6nWXSxTi2MqWLpwwm+xjpkZTErSh+Mvm2A9lhVsRDXl88XeM44KZ54j4qnKlsaVy3DW3cJmwYdEkS0W7cu1Q6Vy9kAUEeQqjP4IUIkTugaEcz+x2DSquMY3t+BB5xXXpt9gIuWDTKPR63QcYzzz93Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723213; c=relaxed/simple;
	bh=WhwznyOe3NY0nH3ZkDHvn/7ZXTaUVrQ956dRfe5Ke48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCm5Ox4pxV3zD+ueAtpn/GZyyimuEqhizSiaHaq4aQq/C9++ZxQ2NQUMGi1DeXVxotMf29T0Q+nwWJxiCiUfUnQnlTfdwWu0L8YtT6pXX5ElEqGiqJvFqmT+XvGhc33spqk7WGGAKqbqLNLqvHmo3IONyu2YvFs3s+Hgw9Hz2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRQkw9DD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756723210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r4m3vkGAYmIbkGKlu6FXQj2biba1IEBlC5jQB6CtCVg=;
	b=JRQkw9DD7p87JaP4pOEXEjtaU00P/s8ubUyu6dE67TQ+WT1BnFEXS35u1GcjuzJEuxmd20
	RmHadLnhFkuEv0s6t6LAi3TMDpmFSydyZStUwD73wOVV6xYvem5vzBOIzctvs0n6sEgXQZ
	KiVJeoW1TC5p3RwQ06oMGgpa8m5fC0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-zS6gfsE4OFKwr7v8h2H-Nw-1; Mon, 01 Sep 2025 06:40:07 -0400
X-MC-Unique: zS6gfsE4OFKwr7v8h2H-Nw-1
X-Mimecast-MFC-AGG-ID: zS6gfsE4OFKwr7v8h2H-Nw_1756723205
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3d226c3a675so941900f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756723205; x=1757328005;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4m3vkGAYmIbkGKlu6FXQj2biba1IEBlC5jQB6CtCVg=;
        b=fzFDb6YwTwTLil7Abc6+JxcpbRudmmnbFu5+JCTmuVIeGkpkjUn2Fs+saAVZ7vBNwc
         nOfyCDTr0vrqgFuUYbv+7MK6yRoi9Vmo5wChB3c+3fb1rBl/v+gKXPvMJSHohd2c4dgy
         CgIbz/KAbU9PWgsqETSvynTLAZeyaVuPEgPQv7WnqymTNFlcJgXH549Y89YVgdYETt1S
         DIpDc4gKRHpbIpXeR1PU9sxgNAcpCzMx/pQZImOkfopyd3oMVJ/CIUeFaBHETdaHcb2G
         6AqWqiPFtHEBWJIrcZmPTb6dg5GYIQC+issu4KBzH91KQzAfysFxC24OuMxUB00KIqvA
         dQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUNA8a/617QP1nW/uQDHZr5Rn4mCOFsegXS/xoCAG7E+YeGIsx716tn+jrg4wkecwvYZuItG/tuijZfy10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYs1pt1t8wS8msRYR9I/UrZSmiCGvl+U+wHob8XW7P2vUWJ0x
	ioncSuetgY1jCB+mJr7wSXcYWF29BNM7uTwnHlkmysST5maMv/0/uL4orxgljn/ecug1SBAg2qk
	iOmVV9SdldqBx/2dOjX1n7tGqtXBb64vvRrj+IGQxDp6PlBH5oY9TbCPdwKYx/9YvSQ==
X-Gm-Gg: ASbGncs/FkoewGKizfd5RxYdL3zi9cjfTG53XQZbuFGHeA7m0sPG+dPWmC8nvvuxHe5
	1rl0YX7C4ee2T2iBjbo4JGZ4A/a/gEyByZEEISus5GKnB7+CMo+Ffv3Ky1ZKua2UX8m9IzY59Fw
	TKUOf3cabytN6rHb7xn8d1M2JMZfsuafgVMTtZSOe9yhWgHavJj//Rl90wXiuHp9RSD3P+722Z/
	ci5KGl2/grA7V78FQE3gjzn6VhWnp9zzD9TgizPItFsvbhkGAAevEXbtFAOBhOcRoyIkObQ7pr4
	VdbZG28eTyRPbTiFBfZj5RDpxEPTycxQVozcKNtyrJNNCe3wiAauAm8G78cLTXQkV2Q/MWF6Mhc
	jony1GGIZzR+DYLlNWUTKr7LbZc8KNP3j5S8oFa93XapEkrL0se7/sYOKZyMV+8jUraA=
X-Received: by 2002:a05:6000:2586:b0:3cd:c10d:3b6b with SMTP id ffacd0b85a97d-3d1de4b9891mr5454174f8f.27.1756723205300;
        Mon, 01 Sep 2025 03:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeWUI2bNAllxhVdaZfkjclHGCtCO8UyFazhGTx/veXP18IkURiooSoog6cfD7WMkbuE7XxSA==
X-Received: by 2002:a05:6000:2586:b0:3cd:c10d:3b6b with SMTP id ffacd0b85a97d-3d1de4b9891mr5454157f8f.27.1756723204889;
        Mon, 01 Sep 2025 03:40:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d12c90a01bsm12227157f8f.31.2025.09.01.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:40:04 -0700 (PDT)
Message-ID: <2325a092-c810-4ae2-bf71-0a2c6fe361eb@redhat.com>
Date: Mon, 1 Sep 2025 12:40:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
 <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
 <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
 <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com>
 <CAKPOu+8YMLrtqbhhQ0SgfQN2xErVhZCLEoStRL-YJy-SeHE8ng@mail.gmail.com>
 <5636a473-2a0a-4d25-95a4-1db48a1752ec@redhat.com>
 <CAKPOu+8JwdcK4RJDt7amCj9-V0K8Xjmtt=HHWsrET=EEyPBthw@mail.gmail.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <CAKPOu+8JwdcK4RJDt7amCj9-V0K8Xjmtt=HHWsrET=EEyPBthw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 12:36, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 12:07 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 01.09.25 12:00, Max Kellermann wrote:
>>> On Mon, Sep 1, 2025 at 11:53 AM David Hildenbrand <david@redhat.com> wrote:
>>>> I'm sorry, I have no time to argue about the basics of writing a patch
>>>> description. I even proposed a simple example of what we (multiple
>>>> reviewers) would expect as a bare minimum.
>>>
>>> But Lorenzo Stoakes and Mike Rappoport wanted much more than that.
>>
>> Sure, if it's not a simple "test" function as the one I commented on, it
>> might make sense to explain more why it is okay.
> 
> Lorenzo and Mike commented on the very same patch as you (i.e. 01/12).
> 
> I remember that you provided an example, and implementing that would
> have been easy - but it would not have been enough.

It would have been :)

See, Willy's patch made it clear that these are "test" functions. I 
incorporated that in my suggestion by using the term "test function".

For a "test" function (or a getter), it's trivial to see why we would 
want to have it const.

For other functions it's less clear, and might contradict to some plans 
we have (e.g., currently does not modify it but might in the future).

-- 
Cheers

David / dhildenb


