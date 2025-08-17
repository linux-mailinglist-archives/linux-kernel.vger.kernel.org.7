Return-Path: <linux-kernel+bounces-772392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E681CB29221
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6E57A5AB2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4320ADEE;
	Sun, 17 Aug 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/+Q7SxO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D121EB9F2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755417904; cv=none; b=Hb9WzS2G86ThOzTYTRdEtVzW+BfI79PHfC74HhIDA5aN7+zPmSh+PyXgCbUA+Tc7N27g0qMxqDYfm7Aa/qfoyqAxnyIawwcUurlQvsNEjVw6XTTcfYX5Ph+xoYVs3Nz+hzYR8vefyHQU9IUNeCctJOmtsf5E8Y98mRkg5JNoL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755417904; c=relaxed/simple;
	bh=bLx+Qdqzq0Jxexm/z9IL+UYwk5bMMm9ESEl391k+G6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/cIdpUDKaPZCdGg7t+bJ9Dt+cPZtC/wV2+ydES5mn2bPnHhJMqlWqrxrZjnuj7vwhNhz+7FzYfYYJeGGHaE1zwCrJaamIi1RzPyXdfaI5VTxPKw/KLFPirw4QHAOblKu/E4SJPAvWkmpdv1jqkqdIgfWtvesQaDMKWlcpJaXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/+Q7SxO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755417901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OiISDgpsB+3V2GnY80rZDNzM1k3Hmwc7yt5I/jAodoI=;
	b=K/+Q7SxOZHo7cuTmcGipO4ywbcJqZellUyeFQp1NSJ+BOTweeDTz6O9AV5B+8DF1FMUZ7F
	Z0yh1c2iEvu7L6SBo0a3BBdMnA/Ioyzw1oT/nzlnOpv4O+QTFr98m6CAwMV1N9OdTGmMS6
	Qos/AhXNcsFfv3E8mhwKBgC0FGKHiz4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-hwA3tdIlOray2IafdaXEqg-1; Sun, 17 Aug 2025 04:04:59 -0400
X-MC-Unique: hwA3tdIlOray2IafdaXEqg-1
X-Mimecast-MFC-AGG-ID: hwA3tdIlOray2IafdaXEqg_1755417898
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso2251527f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755417898; x=1756022698;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiISDgpsB+3V2GnY80rZDNzM1k3Hmwc7yt5I/jAodoI=;
        b=D4dDfo7sNsG5Qbz/Mols9+Jc0fzvDCqR9fvKLddvEiQMo9+sSWIeiSwbZmMr1i7hOr
         i8zJ8FwYsoEhhmmvvUdDeHZg3qD3J4R5M3ljByyNZPv8+OLT9oWb2WnV2yj3oAtUwge4
         uQzl4N/4DafC7ExocmAyaIvdS5LXaI3u2ufIOHE8R9UeXD20oWu4ovJyo4/WKFGm88vu
         4AntSbqbxVM2y2r02DctFgKPCYKhELapj2jVOKfY9fiOpsukH9YtyGr/6z/eIl6iqAe9
         /v5o+BiuyDrzgj8THiMlm7Jywy6AF3h6mW3bFLH01o6uqjFeqTySzKsRi6XRe8KUWYMM
         SwYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSjAF4sdT8/SnFqA1mo+pCmZrQmgds1RSBEeOch/OcI80WVWreTTnMP/It8JMKQMf9OdFM4mu7zf/0w6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YycriTbC/3IWVW916eMGReIao8nCOQZ82pX10eOoPS1DBWtoTfT
	YxCCnt7LcL+SkUYCuKDxbc5LhHP7Ex5N3FGXjZE7xs890u77tdq1EVRUy3KLc8UUG/vv00EqeOo
	uRGoVEmf1Tgc0HZzDxA3TNcVgXSJs9blpPAtTEZQXf0fLwN6gPRG6bGE6ZfX3HdQ3zf7SolO2Ig
	==
X-Gm-Gg: ASbGncvrujizfnBA0rDq5DB+0BltBKRES2KC0Wef7R+ZxoCnPj1WjHV5WEDq3OY0W48
	H+yA8t3xQcmUdzapXPBdD1jJ0ZQfsA0yiSGOb4RTGdbwc6ea4HDwPaCzsWHNHFmZQ0+x1MQRjDe
	4TtFfl92gcYKApTNB/9QLSSx5hbp4vCNCKwfs+5kzp1YhDPJwcsxHo5Z7pWU143lXrWIfDQLTQd
	GMqIHAxNYTHjKvMnOMf64kG6bzKl/I3QcSQjufK1S781mYpgWV8TQwEKXEv72ArFuD0qsuoLTy9
	MHK4etjOctuMTEISDa06Y7LZvn9DN7PmdlfzBOjFs99C0y34xrSqH1aMXMg61AAR6IvXNW7CwRw
	5TQRtqwaJ/yH9IDmofRhCY05uYDW3qHVXlvUqE8lFMMUCQaJb4Nn9N/Q+jPfrBBmodY0=
X-Received: by 2002:a5d:5d87:0:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3bb69699d3dmr6661013f8f.56.1755417897990;
        Sun, 17 Aug 2025 01:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBEkv1Ybz20WGc1N/fA5RmGzB0ximuuE/rkQhy0zNUcOEcJynqa4kRlx8wDf0604Y/DKALSg==
X-Received: by 2002:a5d:5d87:0:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3bb69699d3dmr6660975f8f.56.1755417897495;
        Sun, 17 Aug 2025 01:04:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0b:a400:87b2:80d2:3e99:1b85? (p200300d82f0ba40087b280d23e991b85.dip0.t-ipconnect.de. [2003:d8:2f0b:a400:87b2:80d2:3e99:1b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64664133sm8525771f8f.12.2025.08.17.01.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 01:04:56 -0700 (PDT)
Message-ID: <3871f0b0-db94-4358-877b-fd5ddb4337dd@redhat.com>
Date: Sun, 17 Aug 2025 10:04:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
 <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
 <aKCwjCJTEhX4Q6wW@casper.infradead.org>
 <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
 <CAAhV-H6csiOVDco=pocC72WSPiafDJV+1+R7P0KvB15dxOjtow@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAhV-H6csiOVDco=pocC72WSPiafDJV+1+R7P0KvB15dxOjtow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.08.25 03:37, Huacai Chen wrote:
> On Sun, Aug 17, 2025 at 1:02 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.08.25 18:23, Matthew Wilcox wrote:
>>> On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
>>>> +++ b/mm/balloon_compaction.c
>>>> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
>>>>    static int __init balloon_init(void)
>>>>    {
>>>> -    movable_ops[MOVABLE_BALLOON] = &balloon_mops;
>>>> -    return 0;
>>>> +    int rc;
>>>> +
>>>> +    rc = register_movable_ops(&balloon_mops, PGTY_offline);
>>>> +    return rc;
>>>
>>> Using 'rc' as the name of this variable is an anti-pattern.  All it
>>> tells you is "this is the return value".  Calling it 'err' is far
>>> better because now we know it's an error number (or zero for success,
>>> of course).
>>
>> I know, we all have our things to complain about. Some about Cc: above
>> --, others about the name of error variables :P
>>
>> $ git grep "int rc" | wc -l
>> 12730
>> $ git grep "int ret" | wc -l
>> 80386
>> $ git grep "int error" | wc -l
>> 4349
>> $ git grep "int err " | wc -l
>> 6117
>>
>>>
>>> It seems to be a particularly IBM derived antipattern ;-)
>>
>> Careful miser :D
>>
>>> Some internal style guide, perhaps?
>>
>> Kernel-internal style guide maybe ;)
>>
>>>
>>>> +void unregister_movable_ops(const struct movable_operations *ops, enum pagetype type)
>>>> +{
>>>> +    switch (type) {
>>>> +    case PGTY_offline:
>>>> +            WARN_ON_ONCE(offline_movable_ops != ops);
>>>> +            offline_movable_ops = NULL;
>>>> +            break;
>>>> +    case PGTY_zsmalloc:
>>>> +            WARN_ON_ONCE(zsmalloc_movable_ops != ops);
>>>> +            zsmalloc_movable_ops = NULL;
>>>> +            break;
>>>
>>> This might be a bit excessive ... just passing the pagetype and not
>>> having the sanity checks should be enough for the tiny number of users
>>> this interface will have.
>>
>> Yeah, no strong opinion, this was a 3 minute hack.
> I have tested your code, everything works well. But if the checking is
> too excessive, can I use a set_movalbe_ops() to replace both
> register_movable_ops() and unregister_movable_ops()? 

Makes sense, given that I don't expect us to have multiple handlers for 
the same type in the near future.

Please do keep a sanity check for replacing valid pointers

if (old_ops && new_ops)
	return -EBUSY;

Thanks!

-- 
Cheers

David / dhildenb


