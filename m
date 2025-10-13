Return-Path: <linux-kernel+bounces-850547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A3BD324E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932803B2F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCF2EC0BF;
	Mon, 13 Oct 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5TltcKy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28A4C6E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361092; cv=none; b=MRuZ41ElikODrmAHn6DSeDPBWfx68HO+F1FbZICNhTlgLM2wShOKAD3R0+Q+wihpOgiOLSvze1tHbeXQEnAMSBH8QgfMGNvSfzUI/OOhcY4fW5F0xbxoJUjvsqiiTlAtRbF8omMdipSE8goCW/UoJ/o1OhqTcPQ5DYAkyawlqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361092; c=relaxed/simple;
	bh=yO770fg8v1L9brfmp/aqyVdfQh4cbsbUAh96pBTmpns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ2IbcPgSiy+LNcg3NgQPBQb3vtWINnrpnDhZLX+cVDWxH8n+X3P2eFtrUc0lxUKLryx98fcWWIi1rAUNWFY3FQD1oOMhX61eKEiCQ/+IXygK8P8I9sKdo8Pm5Pyx/N8k2kjBziwAkBsSli/5oAWn8cI4D+xd7Hv31C6Lb4ut5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5TltcKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760361089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RBdgSo6WOTx4EEG5eBWjfkr5h883eL8iwmBSlBrlRfI=;
	b=Y5TltcKyMPY49cwZ/G2nTl7Gn6oZRtBJG15Aw2+m/BepMiGy6lc5IgPiO+foMT8WaRey6F
	D6CiMYYMtaoZxxp6Omo0+lhy/ofXiJpi9d9CGKmxY1DzFMgl4uZDctsBryuhnuSTQ6FDsv
	ozRrG3tWbOPsiUcCNft4QbaG/pE9Fmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-oN_pDuaePkKVj-OLIcxyyw-1; Mon, 13 Oct 2025 09:11:25 -0400
X-MC-Unique: oN_pDuaePkKVj-OLIcxyyw-1
X-Mimecast-MFC-AGG-ID: oN_pDuaePkKVj-OLIcxyyw_1760361084
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efa77de998so4342339f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361084; x=1760965884;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBdgSo6WOTx4EEG5eBWjfkr5h883eL8iwmBSlBrlRfI=;
        b=A4P8xD7WRcqQ1eq7fWVvsLfkjZpbp2d6r+zygYRpBs/gfzeizPDi24XZnwSKlC/Kiu
         Bdk5RXkhXPSm7QAGtaK0TfqlPA7QWaCNsDzgBIJ8rAXA/P9XzrQ63gavQLJKi8AhyVG1
         i9bJIOuPbxrsFtz153j5mNnHGGEf/2vI3/bXqFrZNVIHkQaoaZPDNx608f4YFL/Txv14
         Y/spYBTFuEEmrRAg1QkgTWSelZdliW5p3eAEy2/YKPsvJQeenpCm1tx7lQdB2t8PmC4C
         +CIuVckcidPxciQ2CqDj/uUR5O0goNVfsKUZVkGjxwOJxjKHbVcyywc56/IpEofsbXqy
         L1gw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFYq0QgZ2mVml95y4e/sJ+6lVZlR3sGtrK/04YqmTVsncRPGLJ1MtVIAXP6t3sfn6I6bs59wHT09s7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghSxPGudRSe5KUCqxAYmve6hYKRGnHDq1AymZxBRyLkC1iqUU
	J+cYyC+7AmzAPaqmCtPuf8OiCZhT6ntg+5hYXShPFAkc2UxwcoobNmpW2hBLaNXuUGH0lzZ8btR
	R1sS1eI1LQqAGxto2/1S5no0+q/lzoqaoCcaJYiCaUHGMHe2tl1zLwlau8Db3DtRd8g==
X-Gm-Gg: ASbGnctJWI1cHVhg1vFgtS6ksx5DtLmFddFApmLkcdeiHeBh2uETQaPsg2sMjxk/Wr9
	bQBLWTumX637I5wQ8Pr0a+js1ZzHs7UUchY6nhQZ0kLTJdB40THodqZU5BGaDqyt0wQaEoKErmL
	kHV4wdKLLyPmT72AeCxugVchH1eAKdxLp8F+ykCxjlJ29oX+X/Irn1yISX+jfRDggyddQP9C6Ai
	/SwpJv7S6msoALyAGcTMOF86hSJIntGoyIIurLiteFAJvzjQU78YcIb+Tn1cD9evnE6zhTWMESC
	sFdze5l+2w/Mx5qiefbWvykpVQl+SHnpr64VzkXSCeLQ7yy45eNa6f9Tzt1F2vvQwxRNn/4XGZE
	W0jM=
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6413933f8f.63.1760361083919;
        Mon, 13 Oct 2025 06:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb6YozfVgK5IEbuaYmcmf0o016i7X6GI+Ce3y52ZzyWmo1gIg1qS/dRVJW5aUVEBtNQl6juQ==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6413914f8f.63.1760361083554;
        Mon, 13 Oct 2025 06:11:23 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm178750975e9.13.2025.10.13.06.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:11:23 -0700 (PDT)
Message-ID: <8e9d92c8-b2f6-4178-8a76-a6db935589ca@redhat.com>
Date: Mon, 13 Oct 2025 15:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
 <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
 <fa2d7db5-688c-4d04-abcd-a60f79a6bb7a@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <fa2d7db5-688c-4d04-abcd-a60f79a6bb7a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 14:57, Lorenzo Stoakes wrote:
> On Mon, Oct 13, 2025 at 02:31:35PM +0200, David Hildenbrand wrote:
>> On 13.10.25 13:33, Lorenzo Stoakes wrote:
>>> On Mon, Oct 13, 2025 at 01:12:20PM +0200, David Hildenbrand wrote:
>>>> On 13.10.25 13:04, Lorenzo Stoakes wrote:
>>>>> On Sat, Oct 11, 2025 at 05:30:52PM +0800, Ye Liu wrote:
>>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>>
>>>>>> Hello MM maintainers and drgn community,
>>>>>>
>>>>>> This RFC proposes to convert VM_* flags from #define macros to enum
>>>>>> vm_flags. The motivation comes from recent drgn development where we
>>>>>> encountered difficulties in implementing VM flag parsing due to the
>>>>>> current macro-based approach.
>>>>>
>>>>> This isn't going to work sorry, it's not valid to have flag values as an enum
>>>>
>>>> I don't follow, can you elaborate? IIRC, the compiler will use an integer
>>>> type to back the enum that will fit all values.
>>>
>>> switch (flags) {
>>> 	case VAL1:
>>> 	case VAL2:
>>> 	etc.
>>> }
>>>
>>> Is broken (compiler will say you cover all cases when you don't...)
>>
>> I assume you mean theoretically, because there is no such code, right?
> 
> Right, it's a general point about why enum's are not such a great idea for this.
> 
>>
>>>
>>> An enum implies independent values that exhaustively describe all state, however
>>> these flag values are not that - they're intended to be bit fields.
>>>
>>
>> Observe how we use an enum for FOLL_* flags, vm_fault_reason, fault_flag and
>> probably other things.
> 
> FOLL_* flags are an anonymous enum, enum fault_flag is not used as a type
> anywhere, nor is vm_fault_reason. So those are both kinda weird as to why we
> even name the type (they're in effect anonymous).

Well, there are of course more, even in MM.

For these cases, we indeed don't declare a type, but I am not really
sure if it makes a big difference here today.

I agree that once the flags are actually an opaque object (what you are
planning on to work on), it will be a different story.

> 
> But also 'we do X in the kernel' doesn't mean doing X is right :)

Right, but it in general works. It's just nasty here in particular.

-- 
Cheers

David / dhildenb


