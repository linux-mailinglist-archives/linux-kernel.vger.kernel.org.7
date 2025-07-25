Return-Path: <linux-kernel+bounces-746141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDECDB1239D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995217B754A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCD2EFDAA;
	Fri, 25 Jul 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD+fsDzb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282F2EFDA7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467021; cv=none; b=rj1Feubn2JonbP4L/JYrJmZS5H44c+Bv8al0s2HANLBfilGZZvxWwZ3DBHRFqvcrfNcJUWtcywBcI6RBam0vK02tYEaRT1XMEMXD/dbehXsPV5cyF85KYp3KL2zwChncaTNL0z+pUNF1Ujzcr2uFVhU2OxHrV9jEGzzf7vKWR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467021; c=relaxed/simple;
	bh=28AJ4qy9atvKFUZS1GoNjD2CaS+NZ0Id9OCUgOE1j2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3XV/lEaH5On+ZIye5KsnG3VxZDwxPGLi0pu8VCMgnNNuiPKJQcS7M/VImiAz93APSz9CAH2JrAlFF+SRlr56NeqCjGTwaZMXdxYFmQX7pNS88BCCDkyU2XgqcxvdxNIwWq1vADQCDANxOAiQkkw1KYo2/vvVKLwIyNd0tb/O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD+fsDzb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753467016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fg031g3unP7fXQlD5lCc+gWPnpWQUj0uihyKmlvazOw=;
	b=gD+fsDzbk5TfLnK7iJ29MRLGY/jF1CZb4zodVrMxOX0jhso5LEYltWjOFJjLF5NDtcW24H
	XfdrWW+x2hmfLULwnzr9KXKo0H75SN3rVeGGPrafbQcLZXmK4Mm1iPHhdZ2X76FjhiXeXo
	ENRJERPYV6RDbb/JqZw7fidd+MVmPQI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-QZQ2htzDNmyERgX7A5gXcA-1; Fri, 25 Jul 2025 14:10:14 -0400
X-MC-Unique: QZQ2htzDNmyERgX7A5gXcA-1
X-Mimecast-MFC-AGG-ID: QZQ2htzDNmyERgX7A5gXcA_1753467013
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b5fe97af5fso931750f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467013; x=1754071813;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fg031g3unP7fXQlD5lCc+gWPnpWQUj0uihyKmlvazOw=;
        b=FKUZzu1Aly+Zw8EDh+rrEUWa1OC7+rLInZ9qB0UWiOH1Yib2l7CnOci51jSxqz1IYB
         dmiGjDZ6kegKdvY66rKv/x07YNBCAr97sw3JQVPU8gnV2yB9l4v+XPRtdgl18BmMB6DN
         1pkT1IurvYWeh2BFFQ0gQ0QExTQiZVWhhgUXtYd3o61pwKZgAQmgNB69ON1cOBx3NQ2n
         g0JlWG55No1nN/u49dnBHzm5wZsiwhPCSFDL+0Xo5GKk7g12+se/GkKXJFCzZ0JmQrRp
         5+RsYac0pDp2hV4AmhGWf906lwVwbd7XPaHmd611/jRQ9yEx7f4tyIToM4NqxngUhvLo
         c/uw==
X-Forwarded-Encrypted: i=1; AJvYcCU/b1w9bjKydo6vcL9eyGcNpWvUSAAt3pnhCWlbjAZSr91mMJJZ4H+x4HctY1IyXs9ghvTIwfI+W5Glfp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLm2P+GxFTBepr+OKcKFXjA3YpjXy71suKpNniVKK1Z/f1+RZQ
	IECdS+HNT+bwRn/+lV3y+vctd3VUyaa76YXoSHP9oEvBykZBMSUXxAa+QX5nBSZmjZfVVtCutMG
	/zznZYJsQO2/megddYLN3k3ZMG2+ZYP10de0Iq3ZJbS3BPZw34LPUjH/LnixuEM98MA==
X-Gm-Gg: ASbGncuAOEHyHFYS5EC7syGdauY8MtkapJdWA74cpCpf6JwyNNinEQUVpxJ4NWb5bg3
	RkxE5Oti6FvvYuEL3ZREVR3IhbfJ0tSYvR7/GkBkmWv77ADDyLEmZZj2NEI1FZ2EwZs7ruFNzjJ
	s86LQhie4hXThK9ujtdsI7XJQFYQqxKU071swbSHK8aoymgA5gc+i7zHiVTtFjMjBQBkOY6dnaG
	RSaE2sz7EJ5fPrfaB6HzW3GiV7FXHQjf4PzAArXHyVoP6eT5+i1JaRBNVPY6k73qbW5o1JoRQOp
	EJGE/z9Ho2emQgNdfLGAlar7LulUfCVnuZq5ejjkFSa5VqBVlyecKL8lGz/j7MwtIIHWz6JqU15
	7ryuyPJQhVdSkK6RHc1nQEGBspksKZdRMYjqyJwX1PUU/GHT6X9oljeiOzTwjNZQg
X-Received: by 2002:a05:6000:1a87:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3b7765e691fmr2731924f8f.2.1753467013207;
        Fri, 25 Jul 2025 11:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9we9KMsIFAxiMfOlhltS2ypJTdPdaz4UjcyKgj2aegsDd95Nh1ypDaK5ex+xC87RDOsB0fA==
X-Received: by 2002:a05:6000:1a87:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3b7765e691fmr2731899f8f.2.1753467012729;
        Fri, 25 Jul 2025 11:10:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f36:e800:2f2e:cb5:13f6:f884? (p200300d82f36e8002f2e0cb513f6f884.dip0.t-ipconnect.de. [2003:d8:2f36:e800:2f2e:cb5:13f6:f884])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bc7sm528611f8f.22.2025.07.25.11.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 11:10:12 -0700 (PDT)
Message-ID: <f860d082-384d-4230-bb1c-09206c7daf72@redhat.com>
Date: Fri, 25 Jul 2025 20:10:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
 <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.25 19:43, Lorenzo Stoakes wrote:
> On Fri, Jul 25, 2025 at 10:30:08AM -0700, Jeff Xu wrote:
>> Hi Lorenzo,
>>
>> On Fri, Jul 25, 2025 at 1:30 AM Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com> wrote:
>>>
>>> The check_mm_seal() function is doing something general - checking whether
>>> a range contains only VMAs (or rather that it does NOT contain any
>>> unmapped regions).
>>>
>>> So rename this function to range_contains_unmapped().
>>>
>> Thanks for keeping the comments.
> 
> You're welcome.
> 
>>
>> In the prior version of this patch, I requested that we keep the
>> check_mm_seal()  and its comments. And this version keeps the comments
>> but removes the check_mm_seal() name.
> 
> I didn't catch that being your request.
> 
>>
>> As I said, check_mm_seal() with its comments is a contract for
>> entry-check for mseal().  My understanding is that you are going to
>> move range_contains_unmapped() to vma.c. When that happens, mseal()
>> will lose this entry-check contract.
> 
> This is just bizarre.
> 
> Code doesn't stop working if you put it in another function.
> 
> And you're now reviewing me for stuff I haven't done? :P
> 
>>
>> Contact is a great way to hide implementation details. Could you
>> please keep check_mm_seal() in mseal.c and create
>> range_contains_unmapped() in vma.c. Then you can refactor as needed.
> 
> Wait what?

do_mseal() calls range_contains_unmapped(), so I don't see the problem.

We could add a comment above the range_contains_unmapped(), call stating 
*why* we do that, which is much more relevant than some check_XXX function.

/*
  * mseal() is documented to reject ranges that contain unmapped ranges
  * (VMA holes): we can only seal VMAs, so nothing would stop mmap() etc.
  * from succeeding on these unmapped ranged later, and we would not
  * actually be sealing the requested range.
  */

Something like that.

-- 
Cheers,

David / dhildenb


