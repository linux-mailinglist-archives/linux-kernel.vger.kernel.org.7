Return-Path: <linux-kernel+bounces-865876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7FBFE39A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1AA14F49A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDF2FFDEB;
	Wed, 22 Oct 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjjUyUKR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656252F4A19
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166359; cv=none; b=NlBh1dubkiw8epk9UJ5XgUs7mgex5WsKgPp7XXzTQiQR173i/JH42WmMhi6OabZk0FlzmSXEa1v6+w7mpg8/m308xrX8rqMO9Llmq7Tih6qlnimk5zYkIB2dlxZWjrA/nazajw9Z98c8hLX6yxhRo3TdAkLD1r8g8pEIfbEH6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166359; c=relaxed/simple;
	bh=XWa8RFGHMe7UMv3bi1NlsOsDryuWBRHeWmMuwwHYHuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OP6lmQrAzgoONZobbKeQ8TbWTIZmP5KuSZr0MAh0jxAyjnt2VCElItuF40UA4oHh78GJlw2QLNaDL+BvMmkoCq4vGTnncC2fLFsAqkMn0FxmG6YW3NWKqOcROUTrZW3sygaUrGkFPtolrFaiq8QKS8lcuGhjM0BGtoclybUAhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjjUyUKR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761166356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lu91KQfbH6o8UIzsj3eeA+iO3dbH+krxr074ui3TqEg=;
	b=IjjUyUKRIrrshL3TarsiDEgxg4SGcJkuSATHU67CqdLAnr+BcIUVVlFuE0yTmyUtY1uzX8
	lNmi6KJMK6dlvVBYyJKhGs3WvL6jpil9XeN69LHCB5S+sBXaqSE1V5f11/CPhO72wuvtaC
	leWskoHvJ5N4kn3aocb1CSPdQoMNyaw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-qt9kyaiVMpOwL7vJX5vNAw-1; Wed, 22 Oct 2025 16:52:34 -0400
X-MC-Unique: qt9kyaiVMpOwL7vJX5vNAw-1
X-Mimecast-MFC-AGG-ID: qt9kyaiVMpOwL7vJX5vNAw_1761166354
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429893e2905so38202f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166353; x=1761771153;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu91KQfbH6o8UIzsj3eeA+iO3dbH+krxr074ui3TqEg=;
        b=MSU/xWlHKbT7TMdDF8qMXKAF/KC8n6GntvzvRrkEYPTRteKAOPM8//g9q0mn7we7vE
         e25MGB8Zspscq9DK2IAdSOOoSRdtebzftYgURZEEAh71ssI41mV2uBba7LoWkCSabip9
         Z8UsLK2sgWFj0nMblAfXYMJj6fbQ7Iv3LeXtMadMyLeCsopguVk2ARQ9PAZDQmkFRuu6
         nPyWDHtYRzh0MIPclxWRBT2qSHzyWLNcQWB8a2iG/MWnK9Mu+TV0a/SmRsR6bOOhV4s8
         SIR0cEJG/9vvg+oi2q0vnfBpmtR4Uv38VPl0z/EgKsYdWjtMJsK2rY5HmNRD5xv895Fq
         +jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQKD9h4l+2F2DF5BFOtLHKw7vjmXTkpXtLqGp4fwu8V7hxcmlXm3rW5Va0jOaN5i8n1TgVEldBQaH3l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ+Rh7JLCaxf05X6YAFc3hByNPTU53sGQOoyBfRPEYandesAE
	F46tisOoM2FOC5bBepF9CU6gKPqeyUkwanWgOPDpMtJRwoZkQ/PEG/8MFl+ECbF3lApe0unKWVU
	NA+LC7w0fkhXrG8/lkY8pVGntdNvqavSZcjIlmpuCii3zLpAPXMk3rKkUIL/+97h+jw==
X-Gm-Gg: ASbGncuxMIY0/uJrbGqrk7BhINQjdKQClRsSUbbI5erIN3NRO51KFnq81kgWenjJzW8
	SWln9MWB1Dw8PKOW2BsuLlYFYzH5bp3hDxcwR0wXSIhpc9J5JQYKE2y0j/hjvZD0Lrid1JvDukz
	sNRpk4/8gMD1w+ePw8AqlNB060Vzkunh2V1ktqmkZ70m+TBClBpMy3nO2S1JTn0T5fhjV+Kt5LO
	0IZA7riKr9B7rFTd6lV44b+elK8PYcTjr8P7gLknt2DNqd6LD0CknAeY3w0/MtNborjOm20XEjT
	EmqQFvjlVnEP4oL9xJVJrH+URqY3p1f0b9vHl0uzon07x7GetHVF9FaINbdnXQTM857cnYbenzn
	dSQBHEUcPNh50q06KbtwUaL4HgKVNT7qq5o/S+6g5Vn+4RtpwWNH/DTI8Dx+qZ8YMMcDmzy15D2
	8qkvBy8s8BFKzwYWXFlmS5qQ/UK5g=
X-Received: by 2002:a05:6000:2911:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42704d7e987mr13805941f8f.1.1761166353591;
        Wed, 22 Oct 2025 13:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtGlhiwcEmKqFcMmoXcts+Wi3p5k5dA2NAGuq1jPRsOolnrAZjAXKLJ7CZy7vxZBo7eOAr2Q==
X-Received: by 2002:a05:6000:2911:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42704d7e987mr13805929f8f.1.1761166353138;
        Wed, 22 Oct 2025 13:52:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff371sm339299f8f.21.2025.10.22.13.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:52:32 -0700 (PDT)
Message-ID: <f42b7b67-7de4-4a7b-8074-25ca87a952a6@redhat.com>
Date: Wed, 22 Oct 2025 22:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 craftfever <craftfever@airmail.cc>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251022153059.22763-1-pedrodemargomes@gmail.com>
 <20251022133118.f13f924348e8cdc6d49ef268@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022133118.f13f924348e8cdc6d49ef268@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 22:31, Andrew Morton wrote:
> On Wed, 22 Oct 2025 12:30:59 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
>>
> 
> Thanks.  It would be helpful of the changelog were to tell people how
> significant this change is for our users.
> 
>> Reported-by: craftfever <craftfever@airmail.cc>
>> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> 
> Buried in here is a claim that large amount of CPU are being used, but
> nothing quantitative.
> 
> So is there something we can tell people who are looking at this patch
> in Feb 2026 and wondering "hm, should I add that to our kernel"?
> 
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Co-developed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
> 
> If the observed runtime problem is bad enough then a cc:stable might be
> justified.  But a description of that observed runtime behavior would
> be needed for that, please.

Agreed.

With the following simple program

#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

/* 32 TiB */
const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;

int main() {
         char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
                           MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);

         if (area == MAP_FAILED) {
                 perror("mmap() failed\n");
                 return -1;
         }

         /* Populate a single page such that we get an anon_vma. */
         *area = 0;

         /* Enable KSM. */
         madvise(area, size, MADV_MERGEABLE);
         pause();
         return 0;
}

$ ./ksm-sparse  &
$ echo 1 > /sys/kernel/mm/ksm/run

ksmd goes to 100% for quite a long time.

Now imagine if a cloud user spins up a couple of these programs.

KSM in the system is essentially deadlocked not able to deduplicate
anything of value.

@Pedro, can you incorporate all that in the patch description?

-- 
Cheers

David / dhildenb


