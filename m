Return-Path: <linux-kernel+bounces-771751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02970B28B29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F881CC71CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97C21C161;
	Sat, 16 Aug 2025 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkfFOXav"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23861C5D55
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326446; cv=none; b=Fm5d350h+/I/57FEsZpFA439BZqEgEadhbucIFRGPmDq3r5BsNPHMNYY9D7AbSEHozjuAYQuSwuYs+3kz5AGsu1wEzffN0Ae+U+QkzntWJTfbg8HTr6tesSjTyuhDXLzndSoRIV2BUyPSn720aFy8aV0XdTrOnnfCaswmJa4hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326446; c=relaxed/simple;
	bh=8819TNuNd8r7bptkuhT35C6lvo1jQWJLHOSTX4hEAkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCTXyFQlARhm7X3qncj5e879TdcIxb/gj8MC/y2hJjYGxKdYBgxbECD0tH/6uwVp1CTwsI9jZ4mtheRYMZ4e3xX0bJ7+htblO8LU0EAUbmOFfIwQYBfOuLfD4PRonGr6ofTBrF1v/i+HaxIP6gxU6ZEMWqMVxZY0tiWpgp85bMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkfFOXav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755326443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jpRMVDaaLqCDMC4grBCrsBXEgRiflpzfM+Z/fw5Kj/s=;
	b=MkfFOXavwjY4PreLhz3s2ESeaBCw0MRbdnv5fo7Nmt1gWouxJYfzGqQSSmlU9A8Gv4wg+e
	K0rb2lCNyTleqZIPgIKCo4wEQ3nVi7tK+YhxpAVUQVqxiWmWZfELlmvDgzFCl5vAUjrX9u
	I/xDwGjD1aLwQ65nn1Q1InBavlKTcMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-PjGbqk2KOLOA8qKvJ6T3PA-1; Sat, 16 Aug 2025 02:40:41 -0400
X-MC-Unique: PjGbqk2KOLOA8qKvJ6T3PA-1
X-Mimecast-MFC-AGG-ID: PjGbqk2KOLOA8qKvJ6T3PA_1755326441
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso17786945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755326440; x=1755931240;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpRMVDaaLqCDMC4grBCrsBXEgRiflpzfM+Z/fw5Kj/s=;
        b=uaTVmMXRYsSCtVvjRN1xRZz1clql+BkfAdR0G4996jwmP5NQ1tCV6q//GKleVkZh22
         wviZrMwnSJei6J2FCpaiwzqmHKA50Dp47F2se2OSnIfXsPpOOBPCT40HkpXssil3yHft
         uSZ78vQ6PZKIAlsXT+jArR/6IdhtfXGpZ84Orc48tp66YQ8AcIakmB50xU7Nl393J228
         fGkty7Z9NIvrpLIwepx6FeoEXXBbLBDme2m3KGMA87BxCkaUwUFzvj9zLKfeJomFEFIB
         PDzkhBeatvnVlqXdQ4LhmgPFXYbNHFDWylWrvW4pLImEIs3MH/BONHggu7opaL++A23q
         IjuA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qe0jvIRW7ywd+Hs274MP+GC9M7kvD6x7KM+3LVh56cyYxZZaUcWm3cL9aBab83OSVlO6ygwwc+EUiHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjiZMe6fURQM1J/TwcHKxpnb/IGYG4y0EW4FRwtXebQwagV5/
	+LjO95emrKAv1+X6PV4iiz7YS/ww3sipjuFqHpIwTzPES0by2lHul2nOaFSrCRIVVsrm1WqEa2H
	nyiVTfE3PcElAkKSHntSE66uif93SkWFr+ay/VOEljHy/SddZb1cbRDX8aXVuWHLTFA==
X-Gm-Gg: ASbGnctnU9/f/8Mh/TL9vCRYoialtqJv+t/sPAfrExxpDiJWAM5DFG5cZjE3YeIWlKz
	t4/5Wdwo+Bx5ZBf7VjQilldyPk2ewtYka7G0OEDo3lz6T3lnJJLxYygGTHXS2ph5P8MbJy43YDf
	rpFuwJyfM2odLPbD4UORLjMnp6YtqQ+/s1sGNDG+/VQRMMvFOAHHvTBWVn+sxf1sB4rDnX4TdxG
	RujlsV2HZCBh5FiDb4FYcGBd9IHulQKnwumGjlJx+yN8SaBn9+KkYcNNzM72POKgn49idOfPdnV
	b578NisozYwUVal7Kl+lbuzKUB1rYXwZhMK7BP/mVzkPoBPtnW1jp/Fu+UTX3fMbJyIk3Yk2MDs
	+AcRlCf2jh4cANXz3w9xsmrGK22unqEyXbyPCrp0VlvoQGEbTPZSkFHPAlBLgjfYDsjM=
X-Received: by 2002:a05:600c:4ecb:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-45a2677e60amr10342615e9.18.1755326440292;
        Fri, 15 Aug 2025 23:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpfUkhjb1UsDmaY7WU/zF1Z7iPtlNuRIErvYfv3ZUEuiVzH0icWl5g9qcQkZoeYwyzg2Na9Q==
X-Received: by 2002:a05:600c:4ecb:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-45a2677e60amr10342355e9.18.1755326439560;
        Fri, 15 Aug 2025 23:40:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22210ab4sm44725805e9.3.2025.08.15.23.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 23:40:38 -0700 (PDT)
Message-ID: <dfbaa342-632d-4911-a0c5-f1ffe32f9e57@redhat.com>
Date: Sat, 16 Aug 2025 08:40:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] mm: memory: add mTHP support for wp
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 glider@google.com, elver@google.com, dvyukov@google.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, muchun.song@linux.dev,
 osalvador@suse.de, shuah@kernel.org, richardcochran@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250814113813.4533-1-vernon2gm@gmail.com>
 <20250814113813.4533-7-vernon2gm@gmail.com>
 <226e21a5-8a8e-43a0-bf5f-12a761f49a27@redhat.com>
 <aJ9QJ2V0WQ5XneJx@vernon-pc>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aJ9QJ2V0WQ5XneJx@vernon-pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 17:20, Vernon Yang wrote:
> On Thu, Aug 14, 2025 at 01:58:34PM +0200, David Hildenbrand wrote:
>> On 14.08.25 13:38, Vernon Yang wrote:
>>> Currently pagefaults on anonymous pages support mthp, and hardware
>>> features (such as arm64 contpte) can be used to store multiple ptes in
>>> one TLB entry, reducing the probability of TLB misses. However, when the
>>> process is forked and the cow is triggered again, the above optimization
>>> effect is lost, and only 4KB is requested once at a time.
>>>
>>> Therefore, make pagefault write-protect copy support mthp to maintain the
>>> optimization effect of TLB and improve the efficiency of cow pagefault.
>>>
>>> vm-scalability usemem shows a great improvement,
>>> test using: usemem -n 32 --prealloc --prefault 249062617
>>> (result unit is KB/s, bigger is better)
>>>
>>> |    size     | w/o patch | w/ patch  |  delta  |
>>> |-------------|-----------|-----------|---------|
>>> | baseline 4K | 723041.63 | 717643.21 | -0.75%  |
>>> | mthp 16K    | 732871.14 | 799513.18 | +9.09%  |
>>> | mthp 32K    | 746060.91 | 836261.83 | +12.09% |
>>> | mthp 64K    | 747333.18 | 855570.43 | +14.48% |
>>
>> You're missing two of the most important metrics: COW latency and memory
>> waste.
> 
> OK, I will add the above two test later.
> 
>>
>> Just imagine what happens if you have PMD-sized THP.
>>
>> I would suggest you explore why Redis used to recommend to disable THPs
>> (hint: tail latency due to COW of way-too-large chunks before we do what we
>> do today).
> 
> Thanks for the suggestion, I'm not very familiar with Redis indeed. Currently,
> this series supports small granularity sizes, such as 16KB, and I will also
> test redis-benchmark later to see the severity of tail latency.
> 
>>
>> So staring at usemem micro-benchmark results is a bit misleading.
>>
>> As discussed in the past, I would actually suggest to
>>
>> a) Let khugepaged deal with fixing this up later, keeping CoW path
>>     simpler and faster.
>> b) If we really really have to do this during fault time, limit it to
>>     some order (might even be have to be configurable).
> 
> This is a good way to add a similar shmem_enabled knob after if need.
> 
>>
>> I really think we should keep CoW latency low and instead let khugepaged fix
>> that up later. (Nico is working on mTHP collapse support)
>>
>> [are you handling having a mixture of PageAnonExclusive within a folio
>> properly? Only staring at R/O PTEs is usually insufficient to determine
>> whether you can COW or whether you must reuse].
> 
> There is no extra processing on PageAnonExclusive here, only judging by R/O PTEs,
> thank you for pointing it out, and I will look into how to properly handle
> this situation later.

Yes, but as I said: I much prefer to let khugepaged handle that. I am 
not convinced the complexity here is warranted.

Nico's patches should soon be in shape to collapse mthp. (see the list)

-- 
Cheers

David / dhildenb


