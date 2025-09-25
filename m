Return-Path: <linux-kernel+bounces-832895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1530BA0B11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C511C24FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36195296BAB;
	Thu, 25 Sep 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f82ENUAB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5A15B971
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818940; cv=none; b=isJI1Q/+UsI/y1djwzo9FNIkMzty2ksoGx+/89U/aE3PsISWZ8cuTiM1OKzbnAyfag07MnR/KgXVTA8/Dm+hV/t7ppwJHMkIuKWREhm3rWNRW35eRqswhn+TljrgFcxy+bCbierVN8PiGEkHTxtm7GlVv+fZzdPM6MCb9GjO/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818940; c=relaxed/simple;
	bh=7AvOMpZGEPY459IpfqKAhUmTSBixPU2Xq53t7ly/Hqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui6ZIq8kqx53h4M14W5BjP1HDbplwl7cZx1+PyIW3f47iAVhXqajUvF1Qf5roPomOzNIXpxTzsLKHpvmaA/3hgmJ2KGnQE0eDMKsF3dm55+qWSRQ3IbFauLj9IG2AabqT72XEdolOzUGjiUHKMNqx9evwcdgHc9Kf9d4FOJbx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f82ENUAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758818937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MjSvoYHIH2UpZoiBo+l7+GcLMTbURxxIhZVNZignwuw=;
	b=f82ENUAB4pYSD6VRqWvvWQ9Kq5IL4ApGodcpuw5r3runpudV7n1KMPr5/iT/cHxNE/l0Dw
	Cxhm3r4n8KeiymayY0VoC5K6TtHrtzF4/RRQFGJV44LmI4Ei8cW4w8ohZc9f0gXVwnCvVs
	6DV3D1I2OscyxUSgpcEFwUB3PYp7fug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-c3_UDpGUPsm8G0ASOve_Ig-1; Thu, 25 Sep 2025 12:48:55 -0400
X-MC-Unique: c3_UDpGUPsm8G0ASOve_Ig-1
X-Mimecast-MFC-AGG-ID: c3_UDpGUPsm8G0ASOve_Ig_1758818934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f28552927so8944725e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818934; x=1759423734;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjSvoYHIH2UpZoiBo+l7+GcLMTbURxxIhZVNZignwuw=;
        b=ogZzq5Kq0LIs2vTT/agO+iwdKbsOPi7EMmVUcCyo8/3JNZ9FbA2y5UxwEu0jw8vmvh
         jf2cDmaJrazzdsATRonxv405XTJQ6VV9M8z5LJKNsuYxSWu023nk/jZPKUCbpJf7xxEU
         eghnrCh3p1MD1oWOeZB/wx+gCiLmJwjoCt2ORwE+kppwrrX8ndpuNWkfQ8v12tgmZa4p
         QXTW2ImX0KjATB2mtnmWchprQDvYenP0Ag6Q464LycH6B2Ix/zn4DhDssYceD0NRW/bY
         xlvl3TiBfpXhSM9Aqi1JZgILvnN+bxXxHX9+1iCICn+nE3ONCKRJhwFIVMQAfW0cvLPO
         Mqdw==
X-Forwarded-Encrypted: i=1; AJvYcCWmC7AIQ/FDdy5b+h1ZTuWGNciHhRqlgV5ZrrR3jn6+zk4BujAtrs3G8IvS0kaBQsGQL5HOVGua+nUAtKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi74CGnRPTMTalP55foG7xIxMZm1mPRAkmbfNlNu6v55A4LVLx
	IBZ1+b+0k8ShGSeOWcUNvZIneRpxX5z6TkpTFU7sckk9SMRH7RKQe7i2IRW0FvtBf+FytlpQcLe
	Gj4tj3wLqyoztWfV+eO27FnuH4+gdTmwGFZqCqxqGsi4B5Ra20mQxEkyPNWbCTyJPng==
X-Gm-Gg: ASbGncvDssud4ryUFuSHYQdwwZ3wbnuchuDMT4F+VLIWwEKS15mzXlhFsjTlvl0aROE
	UUD/poTZTbo+w8+yRswG5/BWQcRlOHmGoSnu76xWIV81YUckkPAqYsbcvE+foxv1YrbwuVfPuZj
	+lf+lo6sVYpSlJZSuphcaoFuuyFT1RKFssSQi4fhSc7iB9zWjiHgR3upn+84LE8AHB+fCOT0kkE
	wzx4aIDAkPcZTxYAZkunPLC6IZzwcvMQowD8BKFPLBswpCCruw0z9jAD3bAeH3UtKd2ADPOBis1
	/ML+F3vxBPwe5g0DNJQiL87C7FlZrim6mrRVgFn9nmxlz1dYDZUNdcnqqvmgnFfxV38SoxQ+lCj
	SHUqgAF6WVZuNkW9eirTUUBIvYAuZfkMRUGl4+7P9axjMhvw0eR4tkOJtZT7mvj7k4Xtf
X-Received: by 2002:a05:600c:3b9e:b0:45f:2f0f:6649 with SMTP id 5b1f17b1804b1-46e329d474fmr59697455e9.8.1758818934311;
        Thu, 25 Sep 2025 09:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn7Q4TLnsyQFemXW3TSRUkmiBvcmsqkTzlgD8VuFDl1YltrZigpOKq6nqZMBI5FA7WyVb9NQ==
X-Received: by 2002:a05:600c:3b9e:b0:45f:2f0f:6649 with SMTP id 5b1f17b1804b1-46e329d474fmr59697125e9.8.1758818933864;
        Thu, 25 Sep 2025 09:48:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab62233sm84331395e9.21.2025.09.25.09.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 09:48:53 -0700 (PDT)
Message-ID: <ec108aa2-88ae-42bb-a64d-ef12867526c4@redhat.com>
Date: Thu, 25 Sep 2025 18:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <CAHbLzkrstjnEVUzz2==A2Z+CJToOgU6YU2MasdK49o-0-jW2yw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAHbLzkrstjnEVUzz2==A2Z+CJToOgU6YU2MasdK49o-0-jW2yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.09.25 18:23, Yang Shi wrote:
> On Thu, Sep 25, 2025 at 7:45 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 25 Sep 2025, at 8:02, Pankaj Raghav (Samsung) wrote:
>>
>>>>>>
>>>>>> We might just need (a), since there is no caller of (b) in kernel, except
>>>>>> split_folio_to_order() is used for testing. There might be future uses
>>>>>> when kernel wants to convert from THP to mTHP, but it seems that we are
>>>>>> not there yet.
>>>>>>
>>>>>
>>>>> Even better, then maybe selected interfaces could just fail if the min-order contradicts with the request to split to a non-larger (order-0) folio.
>>>>
>>>> Yep. Let’s hear what Luis and Pankaj will say about this.
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> +Luis and Pankaj for their opinions on how LBS is going to use split folio
>>>>>> to any order.
>>>>>>
>>>>>> Hi Luis and Pankaj,
>>>>>>
>>>>>> It seems that bumping split folio order from 0 to mapping_min_folio_order()
>>>>>> instead of simply failing the split folio call gives surprises to some
>>>>>> callers and causes issues like the one reported by this email. I cannot think
>>>>>> of any situation where failing a folio split does not work. If LBS code
>>>>>> wants to split, it should supply mapping_min_folio_order(), right? Does
>>>>>> such caller exist?
>>>>>>
>>>
>>> I am not aware of any place in the LBS path where we supply the
>>> min_order. truncate_inode_partial_folio() calls try_folio_split(), which
>>> takes care of splitting in min_order chunks. So we embedded the
>>> min_order in the MM functions that performs the split instead of the
>>> caller passing the min_order. Probably, that is why this problem is
>>> being exposed now where people are surprised by seeing a large folio
>>> even though they asked to split folios to order-0.
>>>
>>> As you concluded, we will not be breaking anything wrt LBS as we
>>> just refuse to split if it doesn't match the min_order. The only issue I
>>> see is we might be exacerbating ENOMEM errors as we are not splitting as
>>> many folios with this change. But the solution for that is simple, add
>>> more RAM to the system ;)
>>>
>>> Just for clarity, are we talking about changing the behaviour just the
>>> try_to_split_thp_page() function or all the split functions in huge_mm.h?
>>
>> I want to change all the split functions in huge_mm.h and provide
>> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_folio().
>>
>> Something like below:
>>
>> 1. no split function will change the given order;
>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_order
>> is smaller than mapping_min_folio_order().
>>
>> In this way, for an LBS folio that cannot be split to order 0, split
>> functions will return -EINVAL to tell caller that the folio cannot
>> be split. The caller is supposed to handle the split failure.
> 
> Other than making folio split more reliable, it seems like to me this
> bug report shows memory failure doesn't handle LBS folio properly. For
> example, if the block size <= order-0 page size (this should be always
> true before LBS), memory failure should expect the large folio is
> split to order-0, then the poisoned order-0 page should be discarded
> if it is not dirty. The later access to the block will trigger a major
> fault.

Agreed that larger-folio support would be nice in memory-failure code, 
but I recall some other areas we recently touched that are rather hairy. 
(something around unmap_poisoned_folio()).

The BUG at hand is that we changed splitting semantics without taking 
care of the actual users.

-- 
Cheers

David / dhildenb


