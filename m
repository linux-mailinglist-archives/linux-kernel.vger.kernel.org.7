Return-Path: <linux-kernel+bounces-850419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C1BD2BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14368189C988
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FA26A087;
	Mon, 13 Oct 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmXWQZ57"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56871F4703
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354021; cv=none; b=nKYgq9HnK3gKAC6AHegaQyFcjsRPNAOGpljm83wItXWuR7MefYt++KDItpK+5jANmLTLPvXH2H56HdekyCRrsfAKdYuZq9hJucq5Zs7pzDtC1Ju/ADugxx4be6+ovyONfNYQqQ1i+uDJCZlh9IW68Tt5EO3VTCRC91XH18UJtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354021; c=relaxed/simple;
	bh=Doc/mhW3vxGF/OJ4NSj2X4N40t33yLViycJnmgIYcaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwWbzIXk8ksvfYXQD1vLVPYHhzypOKtsXVezdAlidp/gpXN2UyM7ygqUmg7SKfz911wFMgnRaVHryrRGpmOs7ZCpX4wh9CdMgRPW5nUxMg2fKX/+I7lVj/tcxOanXhrzfEfhlv4RzziVeUz/sgapSAtsRMtY+OIKOE78fmAAPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmXWQZ57; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760354018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUk2T2O1JALynkNTDXVgTlfmJ0m3TsHCHf1HTqOjalU=;
	b=AmXWQZ57lz0u1hgBTlvaMBlCwRQtKWL/sUafosMyDj4TG6zx2pIQx3JU0Gjd2H4dNS6Mf8
	6v5Ao7GFzN/pwA5KJKZpOb5Ad0KHQdE5V1EdZSjA5n6La1zC/3I2rwshD1eAoa9f/bXTlH
	MjuLTr2KHcuRv8e+l8k1wUHl/smgezE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-ez1bMp9BOMutuFBbEVSaBQ-1; Mon, 13 Oct 2025 07:13:37 -0400
X-MC-Unique: ez1bMp9BOMutuFBbEVSaBQ-1
X-Mimecast-MFC-AGG-ID: ez1bMp9BOMutuFBbEVSaBQ_1760354016
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so2614353f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760354016; x=1760958816;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUk2T2O1JALynkNTDXVgTlfmJ0m3TsHCHf1HTqOjalU=;
        b=hHbIwhqNCvG8U6YPbCD7UMkSRKZd0go28BkFI64ZvfNScyopHbOvmLyWpXvXevyuSU
         xlWMpeUxhU5r9BprSaY5pH9AVKzKTU25CKvzLoDJj6s38l1+EcVTbiRGcS7ZnoarjYCb
         Dlx/cDqVZVKomqXXgCBVg7QbW1/0uIgyveozZOB7M26v1v0ZsWAb2edZly4L+OtSIgge
         Vo3Kis04jwUcDw1/MjB6VTBHubXLjp9WUtinOoOukRLOwvODhLAiOq24S5oNXgFM/i1F
         vgPmODvOOvqna0ASTPPI3YNsMa9W9siYF0wY0a5qTpGYW65mivm1Tum0axThN985L7ws
         8/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ81HyKTsJbtVg3jhNpM9+cSWIWMID7NNbHekr36ODlXs3thF1d6dQ/Azowag7KlYvCOleQnrY/7piH+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEaVxnzZiER6gxFPX1G1R8eNxts5if5eBNgsWHxC1u8fBqHfW
	1t6EYRaUr97aJhrjfb+qLM8A1y4yGAPF9wLtvisdkwQuRN7/pQD20KgU5U5QEW17UqG4I4yNnwH
	157IIE3XnkCwWgzAJYYhdPKGkhs2xZtamGdFtehsLVy2ehRLvSMXEE1ywEeKH4PY5Ew==
X-Gm-Gg: ASbGnctXyfJqHExq52JuTi9TOx7AzeJoswJb1zYtHcVFNwtMn8OF8GL1uP2hy/cC0Jn
	OWtrgiOMoOut0sYyJnb2dIEslh4C9T1IQ9mbbswzD0fADPUWDuSS9nHPUSvMu5Qrj8LHatLZ19f
	g+b2LRVH2Ri7wfVfxevAg8r3ekveqIhWCIG6RdRTTYrDGkkdt8LY2mMiiGpJ21bBNPVQOSiUV8M
	UBB5dy165Euf3oFi8Eefi68DB+ws21JwLkaZoH3yIBS7I8JQoozE+/sCZlu5gYYl8/9iCb7U105
	speUQcM/BFeJcHrXLfYiYjhtkmAn0jR9mlusET7wo4lB2/SHG+dx57pdv6oDHF07gk9Se6XD1CR
	UPzo=
X-Received: by 2002:a05:6000:1887:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-4266e8de95amr14316193f8f.53.1760354015963;
        Mon, 13 Oct 2025 04:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOQfEm07iQajHN7FC2eGJRchtw05CphEkhJOAUM6D7Zv9mdRxcgX3ICCF5NG9k3hni36NFVg==
X-Received: by 2002:a05:6000:1887:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-4266e8de95amr14316170f8f.53.1760354015545;
        Mon, 13 Oct 2025 04:13:35 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm17852921f8f.54.2025.10.13.04.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 04:13:34 -0700 (PDT)
Message-ID: <356ec45b-6ec9-4eb4-b5db-ca98964d8f3b@redhat.com>
Date: Mon, 13 Oct 2025 13:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
To: Lance Yang <lance.yang@linux.dev>
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, Miaohe Lin <linmiaohe@huawei.com>, qiuxu.zhuo@intel.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
 <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
 <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
 <bd374ac3-05a2-41ae-8043-cc3575fb13c0@linux.dev>
 <3e6500dc-723f-4682-9e37-b28bc78a2bdb@redhat.com>
 <c129e522-853e-45c7-a064-34c25e63e610@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c129e522-853e-45c7-a064-34c25e63e610@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 13:00, Lance Yang wrote:
> 
> 
> On 2025/10/13 17:25, David Hildenbrand wrote:
>> On 13.10.25 11:15, Lance Yang wrote:
>>> @David
>>>
>>> Cc: MM CORE folks
>>>
>>> On 2025/10/13 12:42, Lance Yang wrote:
>>> [...]
>>>
>>> Cool. Hardware error injection with EINJ was the way to go!
>>>
>>> I just ran some tests on the shared zero page (both regular and huge),
>>> and
>>> found a tricky behavior:
>>>
>>> 1) When a hardware error is injected into the zeropage, the process that
>>> attempts to read from a mapping backed by it is correctly killed with a
>>> SIGBUS.
>>>
>>> 2) However, even after the error is detected, the kernel continues to
>>> install
>>> the known-poisoned zeropage for new anonymous mappings ...
>>>
>>>
>>> For the shared zeropage:
>>> ```
>>> [Mon Oct 13 16:29:02 2025] mce: Uncorrected hardware memory error in
>>> user-access at 29b8cf5000
>>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: Sending SIGBUS to
>>> read_zeropage:13767 due to hardware memory corruption
>>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: recovery action
>>> for already poisoned page: Failed
>>> ```
>>> And for the shared huge zeropage:
>>> ```
>>> [Mon Oct 13 16:35:34 2025] mce: Uncorrected hardware memory error in
>>> user-access at 1e1e00000
>>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: Sending SIGBUS to
>>> read_huge_zerop:13891 due to hardware memory corruption
>>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: recovery action for
>>> already poisoned page: Failed
>>> ```
>>>
>>> Since we've identified an uncorrectable hardware error on such a
>>> critical,
>>> singleton page, should we be doing something more?
>>
>> I mean, regarding the shared zeropage, we could try walking all page
>> tables of all processes and replace it be a fresh shared zeropage.
>>
>> But then, the page might also be used for other things (I/O etc), the
>> shared zeropage is allocated by the architecture, we'd have to make
>> is_zero_pfn() succeed on the old+new page etc ...
>>
>> So a lot of work for little benefit I guess? The question is how often
>> we would see that in practice. I'd assume we'd see it happen on random
>> kernel memory more frequently where we can really just bring down the
>> whole machine.
> 
> Thanks for your thoughts!
> 
> I agree, fixing the regular zeropage is a really mess ...
> 
> But for the huge zeropage, what if we just stop installing it once it's
> poisoned? We could just disable it globally. Something like this:

We now have the static huge zero folio that could silently be used for 
I/O without a reference etc.

So I'm afraid this is all just making corner cases slightly better.

-- 
Cheers

David / dhildenb


