Return-Path: <linux-kernel+bounces-639377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243FAAF699
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A293A3FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEB1FBEB1;
	Thu,  8 May 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhHaDHqq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777592F43
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695925; cv=none; b=hIhQ8mmDOySPkx+E+CZyywjlR39W2uUnemlVAg3ZAra80OiIKhMQpCYIS6oOR9RI6AIsjT2Atef80oChk1evhTfXY/dS0NDXx308kidVTk8/3/Dg5TpCxkR5ljv4tvTjzHgGVcWFU51rFkm0sCQmokjWAZX5ycoDUxn0oxva6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695925; c=relaxed/simple;
	bh=sikAlgATF65Z4eaB+wsbXt5b9DkW1EKxC+8u948auFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFe1KgX8l4gUizWV90TiP+Q8SqJ6P7iEVxCKrEJOjkoODqmh/2zats3LxuFhPxTlOawjbahXIiI5U3qX/qK3hK9FmkfhbyF9KIYZCc+vPoWEOvShgEmuyN1Cquv2RN9AVpAVyxJQHPytRUaJyrejK0sQM4UWbOrCAhw8ouJLrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhHaDHqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746695921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q/bQkIRK9ZKRyg78Ju0Otf09QNDehCOJMrkpy+HHCD0=;
	b=RhHaDHqq7eaEpT+l7aFucf/VixfmANRIc2j2xE1ac6ZTnu+CYH+VGyEurTimNC49HWaFBg
	USUN9uqCKGUunB6LCkcMJ9s3NWpuh6VydJvsba0d2CHSJLVk5APdcDpVVq5TYU8HUyz9hg
	eBrQptPWhs8qBEmJAyXV6+2XrQUjcrs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-UMxbBFYAPQGvsMmPBNwOIw-1; Thu, 08 May 2025 05:18:39 -0400
X-MC-Unique: UMxbBFYAPQGvsMmPBNwOIw-1
X-Mimecast-MFC-AGG-ID: UMxbBFYAPQGvsMmPBNwOIw_1746695918
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso3534385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 02:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695918; x=1747300718;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/bQkIRK9ZKRyg78Ju0Otf09QNDehCOJMrkpy+HHCD0=;
        b=dgG4UJCeTsWKn15zY2leBdJ1GADfwPf6Hb+cjSDIwLJS7+LJdhcIoQ/H5e9XLE79/k
         EY/7FfzLaNYmpg715eeOtzCEkgt+SR5DR0ti5wcmcI1pPx8qNJOMYq6DpIsJytYL5Szq
         tCdXduOURLFXLLryoEFK2Nxva55iPwqzqXy6g7JHlW3ehG0GFRlO7c4Z3RGy8oa/u61z
         U8miIev3ZzVVoasSbfz1UgNbIjLmwSGQMSzoTJh76rjXRLaKbrt4eAt05ewT2t0eamzI
         qljOnIjFzetqiQsTiFgKwk/9UXb7RmtmFQijKtSgOgSQlwAFQ2xPcPpWgDlWoeFz83FJ
         RxNA==
X-Forwarded-Encrypted: i=1; AJvYcCWpnafEZwUmUxAiqofFAHRUDYdWRXqhGc+zmYudbTbbXtaGictyZ2/c35hM/SEA9D+Oh/M/5HD9WV17Grs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllmDJNP6cggcJx/MXdxOz6GAcaKoG7JibtGOsqlTOu4wJMUe5
	IPNHG9X42zdbdJJa71H88CW3W9eDYAhkVM37F3AVXOcvGspZthgAH71cWJX1inC9HO9vRfqP7k+
	msbKvW5Z4RJnISc5v3J+QBoKzdVnQ0jF4bWpcMrbn4/gDtixXKXUYnqDBowzMmg==
X-Gm-Gg: ASbGncsyRfLfrVpeYR90E8Vi3LyUOf194P0+a5wrRwf2SfXyl8hCTzy3AQecax6AxwJ
	5hW/HQQm5S0iI1rBI6YV4pf3k7crNXMngO7W9NagG5jsOxnXjM9svxcT0tl+NSiJ7rivSJP9QxR
	iP8U/bNA5T8zCWmu7qyIUuqZJo4jM9NO1wNM3+jzJCDHQWkPEF/UdZom/jkF8rh7NR7DLgbSIRi
	KK9+Ypu/BeGAWcRW4xAtoEgmggAwWo4tIHtOvEC9I9xRntNkZE+FM4ZtOTO+x776tKynCnaXo6y
	X18orrJDno9JuteNMlJxNl9nfs0n9sTFLho397KUZalhNbxyYabjoI0yyPZab+6LKYoZSuffxcf
	XGlOG9rElbNXkM8ZTyqKOSPCSp3s/vYqkGq4AKSo=
X-Received: by 2002:a05:600c:3b1a:b0:441:bf4e:89c8 with SMTP id 5b1f17b1804b1-441d44bccd8mr54615455e9.3.1746695918031;
        Thu, 08 May 2025 02:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs5bDDstx/m5Y2nAdHRq9wyHQx/HkqmzL0gepDlm39R0wZJJSkOGDDZ1AzbPWrStupGgAosg==
X-Received: by 2002:a05:600c:3b1a:b0:441:bf4e:89c8 with SMTP id 5b1f17b1804b1-441d44bccd8mr54615245e9.3.1746695917668;
        Thu, 08 May 2025 02:18:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3e:5900:27aa:5f4a:b65c:3d3c? (p200300d82f3e590027aa5f4ab65c3d3c.dip0.t-ipconnect.de. [2003:d8:2f3e:5900:27aa:5f4a:b65c:3d3c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7f18sm31317155e9.40.2025.05.08.02.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 02:18:37 -0700 (PDT)
Message-ID: <78bc6a1b-164e-4925-a624-a271a4499364@redhat.com>
Date: Thu, 8 May 2025 11:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] driver/base: Optimize memory block registration to
 reduce boot time
To: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>, Donet Tom <donettom@linux.ibm.com>,
 Zi Yan <ziy@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, rafael@kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <b49ed289096643ff5b5fbedcf1d1c1be42845a74.1746250339.git.donettom@linux.ibm.com>
 <aBdK2EIMYYRmmEwA@kernel.org>
 <a1e0cddc-ed38-4f48-b028-f3ab5025c157@linux.ibm.com>
 <188fbfba-afb4-4db7-bbba-7689a96be931@redhat.com>
 <aBhoqpC4Jy-c-74p@localhost.localdomain>
 <74c500dd-8d1c-4177-96c7-ddd51ca77306@redhat.com>
 <aBhuZWpZ7ltMuOe0@kernel.org>
 <8180a50d-eebe-4f9b-9ce8-d886654a992d@redhat.com>
 <aBi8Iqp27jXLUWfs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aBi8Iqp27jXLUWfs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.05.25 15:24, Mike Rapoport wrote:
> On Mon, May 05, 2025 at 10:18:43AM +0200, David Hildenbrand wrote:
>> On 05.05.25 09:53, Mike Rapoport wrote:
>>> On Mon, May 05, 2025 at 09:38:43AM +0200, David Hildenbrand wrote:
>>>> On 05.05.25 09:28, Oscar Salvador wrote:
>>>>> On Mon, May 05, 2025 at 09:16:48AM +0200, David Hildenbrand wrote:
>>>>>> memory hotplug code never calls register_one_node(), unless I am missing
>>>>>> something.
>>>>>>
>>>>>> During add_memory_resource(), we call __try_online_node(nid, false), meaning
>>>>>> we skip register_one_node().
>>>>>>
>>>>>> The only caller of __try_online_node(nid, true) is try_online_node(), called
>>>>>> from CPU hotplug code, and I *guess* that is not required.
>>>>>
>>>>> Well, I guess this is because we need to link the cpus to the node.
>>>>> register_one_node() has two jobs: 1) register cpus belonging to the node
>>>>> and 2) register memory-blocks belonging to the node (if any).
>>>>
>>>> Ah, via __register_one_node() ...
>>>>
>>>> I would assume that an offline node
>>>>
>>>> (1) has no memory
>>>> (2) has no CPUs
>>>>
>>>> When we *hotplug* either memory or CPUs, and we first online the node, there
>>>> is nothing to register. Because if there would be something, the node would
>>>> already be online.
>>>>
>>>> In particular, try_offline_node() will only offline a node if
>>>>
>>>> (A) No present pages: No pages are spanned anymore. This includes
>>>>       offline memory blocks.
>>>> (B) No present CPUs.
>>>>
>>>> But maybe there is some case that I am missing ...
>>>
>>> I actually hoped you and Oscar know how that stuff works :)
>>
>> Well, I know how the memory side works, but the CPU side is giving me a hard
>> time :)
>>
>>>
>>> I tried to figure what is going on there and it all looks really convoluted.
>>
>> Jap ...
>>
>>>
>>> So, on boot we have
>>> 	cpu_up() ->
>>> 		try_online_node() ->
>>>    			bails out because all nodes are online (at least on
>>> 			x86 AFAIU, see 1ca75fa7f19d ("arch/x86/mm/numa: Do
>>>                           not initialize nodes twice"))
>>> 	node_dev_init()i ->
>>> 		register_one_node() ->
>>> 			this one can use __register_one_node() and loop
>>> 			over memblock regions.
>>>
>>> And for the hotplug/unplug path, it seems that
>>> register_memory_blocks_under_node(MEMINIT_EARLY) is superfluous, because if
>>> a node had memory it wouldn't get offlined, and if we are hotplugging an
>>> node with memory and cpus, memory hotplug anyway calls
>>> register_memory_blocks_under_node_hotplug().
>>>
>>> So, IMHO, register_one_node() should not call
>>> register_memory_blocks_under_node() at all, but again, I might have missed
>>> something :)
>>
>> Hm, but someone has to create these links for the memory blocks.
> 
> My understanding that the links for the memory blocks during hotplug are created in
> 
> add_memory_resource()
>    register_memory_blocks_under_node()

Yes, during hotplug it's exactly that, after registering the node + 
setting it online.

> 
> So register_one_node() only calls register_memory_blocks_under_node() when
> there are no actual memory resources under that node, isn't it?

Except in early boot. That's why register_one_node() has:

	register_memory_blocks_under_node(nid, start_pfn, end_pfn,
					  MEMINIT_EARLY);

						^ early :)
And that is triggered by

	node_dev_init()->register_one_node()


> 
> Then we can drop the call to register_memory_blocks_under_node() from
> register_one_node() and add creation of memory blocks to node_dev_init(),
> i.e.
> 
> node_dev_init()
>    for_each_node(nid)
>      __register_one_node(nid)
>        for_each_mem_region()
>          /* create memory block if node matches */

Yes exactly, that makes sense.

-- 
Cheers,

David / dhildenb


