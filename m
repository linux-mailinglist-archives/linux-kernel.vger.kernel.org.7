Return-Path: <linux-kernel+bounces-789476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EFB3960E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D915A3B504B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB102773E2;
	Thu, 28 Aug 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv9KJvgL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757C1F8AC5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367853; cv=none; b=JcsP+fG7sWbBSAY9NpfuedhpW20lL37fmu2jP9qnnCmqR/9kNCcfEWXqHR3B8SZU4L2MEpgIDkNsX+qhJp1R1SXLyQHeZrK3Ithavcg/4ul6OlfYoYgQzowyRDheDj4A5ozUiC7UAHqXHPv7ycxy2vx8I8zMZMF2dENnT+w8Qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367853; c=relaxed/simple;
	bh=vdeMfA4XgdhKFH4DhC/B07X2MDdjHOQVm8nqKWApLe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCCzbphyZATLxt2+doSHQVLL6zPtfD/GLZK6xc4r26ew820usqNMAERRPqWmSVF8b0ib+tN6q9Qbmxv6dEWbyO8JPozN+ka3oJ9QLUSAfqpM8L3BNiQ/+ByS3qBy6eQKs1g6pubo17Aat6pW0BwbIGMAh4jlzVSctJZAbFuLTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv9KJvgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756367850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UbZY19kla5JanDLGwXleiL+Lbzg8wDPMzsYjknbeE08=;
	b=bv9KJvgLYHEXRQN9Rn9P1fbYdMgelYJev2QuiBo1lUYjyxwoLQgYXKZ4yz/i9p29EMJCmc
	u6b+urrobkURrkoeNRdtDroyJ0jiQy9PL3SiOarQT5S3NLKYwjVscZLH2zs/IL1/cFENfY
	a22iloi3LZoxLzSpNN+12/ZsJqdxaU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Z9f3n1dqNUGk0pAMWMxWNg-1; Thu, 28 Aug 2025 03:57:28 -0400
X-MC-Unique: Z9f3n1dqNUGk0pAMWMxWNg-1
X-Mimecast-MFC-AGG-ID: Z9f3n1dqNUGk0pAMWMxWNg_1756367848
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c6abcfd218so482862f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367848; x=1756972648;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbZY19kla5JanDLGwXleiL+Lbzg8wDPMzsYjknbeE08=;
        b=LC28DSCzd4Mc+8Os+XeVPMMMZVma5TNRjgR5tnl4VLBaITq+5uuhEI5ZPHoRuCUsLs
         eG4ADiwilgRu9p083tRVOA78xBwll2UQYKiygPN8Y3DSJkz4x3E1/z35vGQp0VnuFkyR
         M+gfl7gba8pVYBHNE5VZXGsxHjWwHIlt5ZisBqvgxd3Oe2ztivty7RC/UobQRooTAwgy
         Ai8cZBwfub1hqqSfuF7cxE5QYTsrCe7jCkhgceQ9s8lKps/sovX4EpHKFacHK83pWfvY
         auLiuDowqdaJG1Dv7c1+tAeAkN+EQEMVAaiIXrwkhw5Tkz5J44jPsWn5bSsKKCvoDS/7
         gELw==
X-Forwarded-Encrypted: i=1; AJvYcCXfL3B+g2wkoyP68+8r+UHbYbnQDSo2kWXIumqae/HWwZPFXF8JuNl2qY2jYGhzJemhwYa+T+GsAAqOe3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhHqyeQpXbCl4QfkiyJk9sR8tll3GlxMnv/twB55qQ/BJBHNG
	M/VN/TVuQvqIO+20108kLFcLZG9pzQM4OchLLDKRi3YozH71go4QzYO4JMTTtKNrP1kYGF/vDY/
	LdxAD/Sug12SEBYQRpxEt/YfGkHTvSd700Ee89QugCSx/VB8VFgnGfC8KaZ7a/LY56A==
X-Gm-Gg: ASbGncvkWIoYDu1SU0QsEejU2qm6Tzn8vlYVOepTLYcyPz4j9WDgYMJIhnIF8T8HaU4
	MrBoH/JCc30RlL2TUKLgzwcP0lyJ+U5WT+XPdnwutUO4AhsfiYmVpjTbyzKEXxFiewDph9O78Rt
	oztk4rFD3/W1XXZg/3hqh+GJjBfVYbXUt13i3WbnbdJI3d9DSFAg61tK9R/65p7UrDg5RUF2Lzy
	LOpib6aWxLzcNm8cS36zzF3AkzMkbxYnSUElPciCry6ynpoXX78rhD9aWtzcBlPrlIzlicBi90I
	jw7Lf7kQbevAZY8FncOv78XzMy5diUh+GY23t9aCj77Y6qDSNoXMoSZ7e1Syn52LhoGlPqo+ufE
	EAnvfKqD6kg2atHzkHJIXY+nb0lTuROL2wy2j2qTRPhBBPqfj2hi13Ua/45TwWlkY2Eg=
X-Received: by 2002:a05:6000:3105:b0:3ca:43ce:8a68 with SMTP id ffacd0b85a97d-3ca43ce8e89mr8320260f8f.47.1756367847594;
        Thu, 28 Aug 2025 00:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIHY+n/N124O87jCHNAlrsZyduC64z8czEg/qHAbsVW1ouYN3MmeY/U08JPQi5BlvdXgr69Q==
X-Received: by 2002:a05:6000:3105:b0:3ca:43ce:8a68 with SMTP id ffacd0b85a97d-3ca43ce8e89mr8320243f8f.47.1756367847112;
        Thu, 28 Aug 2025 00:57:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c9c9324dc9sm14969370f8f.3.2025.08.28.00.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 00:57:26 -0700 (PDT)
Message-ID: <d048aac6-7b70-44b7-9e92-7277bd49b182@redhat.com>
Date: Thu, 28 Aug 2025 09:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
To: Andrew Morton <akpm@linux-foundation.org>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
 <20250827150330.280399-1-max.kellermann@ionos.com>
 <20250827165309.44e465ff214e45f1a6665b24@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250827165309.44e465ff214e45f1a6665b24@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 01:53, Andrew Morton wrote:
> On Wed, 27 Aug 2025 17:03:30 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:
> 
>> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
>> sense, and a different (theoretical) implementation may dereference
>> the pointer.  But currently, lacking any explicit documentation, this
>> call is possible.
>>
>> But if somebody really passes NULL, the function should not return
>> true - this isn't the huge zero folio after all!  However, if the
>> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
>> is_huge_zero_folio(NULL) just happens to return true, which is a lie.
>>
>> This weird side effect prevented me from reproducing a kernel crash
>> that occurred when the elements of a folio_batch were NULL - since
>> folios_put_refs() skips huge zero folios, this sometimes causes a
>> crash, but sometimes does not.  For debugging, it is better to reveal
>> such bugs reliably and not hide them behind random preconditions like
>> "has the huge zero folio already been created?"
>>
>> To improve detection of such bugs, David Hildenbrand suggested adding
>> a VM_WARN_ON_ONCE().
>>
>> ...
>>
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -2,6 +2,7 @@
>>   #ifndef _LINUX_HUGE_MM_H
>>   #define _LINUX_HUGE_MM_H
>>   
>> +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
>>   #include <linux/mm_types.h>
>>   
>>   #include <linux/fs.h> /* only for vma_is_dax() */
>> @@ -479,6 +480,8 @@ extern unsigned long huge_zero_pfn;
>>   
>>   static inline bool is_huge_zero_folio(const struct folio *folio)
>>   {
>> +	VM_WARN_ON_ONCE(folio == NULL);
>> +
>>   	return READ_ONCE(huge_zero_folio) == folio;
>>   }
> 
> OK, but it remains the case that we have seen code which calls
> is_huge_zero_folio() prior to the initialization of huge_zero_folio.
> 
> Is this a bug?  I think so.  Should we be checking for recurrences of
> this bug?

As answered elsewhere, this is perfectly fine as the huge zero folio is 
allocated on demand only (and only once enabled).

> 
> 
> Also, sigh.  I do dislike seeing VM_WARN_ON_ONCE() in an inline
> function - heaven knows how much bloat that adds.  Defconfig
> mm/huge_memory.o (which has three calls) grows by 80 bytes so I guess
> that's livable with.

Common practice to use VM_WARN_ON_ONCE() and friend in inline functions. 
Just look at page-flags.h.

If someone complains about kernel image size with CONFIG_DEBUG_VM, they 
shopuld reevaluate life choices. :)

-- 
Cheers

David / dhildenb


