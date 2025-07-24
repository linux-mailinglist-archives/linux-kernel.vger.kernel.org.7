Return-Path: <linux-kernel+bounces-745024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D0B113D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030037BBF69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644B22B8AB;
	Thu, 24 Jul 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVMjbcHI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A51E9906
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395521; cv=none; b=Cd1p4YtFo0ixlzoIBQqfCf6nDOMPiJ+ZvVkV6bB4TqjWzhEMnTAu2QD517npI8jZPQ3tCTlFukAYV6xGD3DZJ93JFMLk/dkSr+FsEmBxk4w0raKiGQrxWByMNKMfjEpiHlCX5aPP7tKIdEhn7OJcGtF8JoSGDutDVzNLZ91ZoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395521; c=relaxed/simple;
	bh=0QvT3CUkJ6EXgG4xBXsmRtKHHlBw+oanIFcCij4kAHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r6zLt+8HvxgxBABTMnQLpFzr6N09cAZ9qD6a5aBYGfiVNuzZ2Ey40YvuHkTxpDdCK8AVnGwg4Bej57DXkZs6njOWE+5Jr0gfIacWZoZA7HY4WnfADd+8kB6FZrOR2Gb//ipBILj7rREmSjUVuzIZPfmuJFHW3AagbeWluY1c0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVMjbcHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753395517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o3Ts71k9kWEbm+9MEFacjDKvVlaJ/u4GBTuIh+m8AWw=;
	b=CVMjbcHIvH8197HtUdst0jw4c3e03WMbrG5PsNj205xdtiSHcusE3iWPIyg2TcEYtLni1T
	cI0GA1ogDWpJV3Rjcm7mUA+f30QJBGA7lHug854+j/RylRbL/VBGFe1RU6eUIfqTCYggW1
	tGYxUbWZCJy+ZIBIoWqGk0GooLYq/XE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-tbCPZwXCPgGS9HEs5Qui3Q-1; Thu, 24 Jul 2025 18:18:36 -0400
X-MC-Unique: tbCPZwXCPgGS9HEs5Qui3Q-1
X-Mimecast-MFC-AGG-ID: tbCPZwXCPgGS9HEs5Qui3Q_1753395515
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso908977f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395515; x=1754000315;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3Ts71k9kWEbm+9MEFacjDKvVlaJ/u4GBTuIh+m8AWw=;
        b=eDeSjyI2yZp4TvOM7Ev+3yT3YEf7x1eGQfqiA0KW4wPjxB7AhqgkwTgdQfN1T7oqgn
         +jEcG9UjtjmGHF6Q8D8jx8pRzMnkMV6yZ+lgV3NLeADGySTqIyXzVVcKhs8hXfOjG8Cd
         95qAjfLKrOkJRtJ+a1ZmQpIQxWnzWTyBarKganEcoJQeZgozoiRZlPXsLbczKaWplxUx
         nMnTSKOFWOBkP3j27M4qfOfxAb87hFkpBlsibMSdcXHD5VJtpO7uZ4IpS5IhyhAb9mvc
         p95Gsffkoy9xaPNCZT8pyPwvytGvNviOHNOwGp+F6AdgPs1rRksQSd6v150XSxiRYSrx
         phfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn22Ou1i1Ip9GHDCwrrdivyLE4VAxlDW0SwV6cPXg8brQK9ycrD2b8kIgNBBjslPHQbXTQ2rdA6y1zNEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxnhVdCQqPISNSJz6Xw8u+pShFouhT36WZ61usP5M1BFBqmmy
	aG0sjFPzY3hspeYmsVawlR3aCRgH/Qj3JkARF6kT07rOaG+i9GyQgvC9HAbOv37SgKwc4DvS/Hg
	k6g97hSwYT3wsg9XV55rMcHmAO3q5yzl957ME0YP+NeGR16rGmWKu6JenxVMLaL4QPg==
X-Gm-Gg: ASbGncuGsNKawfJd63rGr828X5omiOsAzPe1tX7W7xsy6xsAZtktC6DmSLuV+9oY85O
	VsYEDm5n6xTCB/i4S5u/gWKr1YW8CXVO0gECc8l8Aahv38XLKmpfPxbMRqjg+9hDXSBcxSzZCjO
	+bHQLmPBYZo8brXj9YiFQy2tINGS62Ewnc/SBeMDNuxpN6Ld812XqOr36EB2VGYPiVIPSILvLcE
	LC4wcY+EYtldZGZu63KK9JWUYKbDChmmIfIj3thaUQJQnyBw+hq3sCml5xNaD/FAPOEshENmMR/
	jV435XzNjGKOofNu6qnUINjb8+cXSVLTC/8x+ljU4N7GGuGRKu53wQtoKV7ahFwwIpRwXOpbS/3
	iP94yWOiIvj+s/20v75AGV6R9RfwZdEKfvdFMfkKY2cvIT6UaVwlsVbV/0SuiuLtYBIw=
X-Received: by 2002:a05:6000:4382:b0:3b7:5985:51f with SMTP id ffacd0b85a97d-3b768f060d3mr7168776f8f.44.1753395514939;
        Thu, 24 Jul 2025 15:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW9Oz0ofFy+ZXrphC7SrO746cspr60p4D8s06ek8+rLNxlA04Z1UWxrgzuJqYYf4J4/s1SJQ==
X-Received: by 2002:a05:6000:4382:b0:3b7:5985:51f with SMTP id ffacd0b85a97d-3b768f060d3mr7168766f8f.44.1753395514391;
        Thu, 24 Jul 2025 15:18:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705684a8sm32671285e9.26.2025.07.24.15.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:18:32 -0700 (PDT)
Message-ID: <1bc456a4-30ac-4e6b-8830-e7c86f113f9f@redhat.com>
Date: Fri, 25 Jul 2025 00:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
From: David Hildenbrand <david@redhat.com>
To: Jeff Xu <jeffxu@chromium.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
 <ab45d2f2-a34e-4ec7-8a49-03d166e6215a@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <ab45d2f2-a34e-4ec7-8a49-03d166e6215a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 20:56, David Hildenbrand wrote:
>>
>> To summarize all the discussion points so far:
>> 1. It's questionable behavior for madvise to allow destructive
>> behavior for read-only anonymous mappings, regardless of mseal state.
>   > 2. We could potentially fix point 1 within madvise itself, without>
> involving mseal, as Linus desires.
> 
> IIUC: disallow madvise(MADV_DONTNEED) without PROT_WRITE.
> 
> I am 99.99999% sure that that would break user case, unfortunately.
> 
>> 3. Android userspace uses destructive madvise to free up RAM, but I
>> need to take a closer look at the patterns and usage to understand why
>> they do that.
> 
> I am shocked that you question why they would use MADV_DONTNEED instead
> of ...
> 
>   > 4. We could ask applications to switch to non-destructive madvise,>
> like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
>> switch the kernel to use non-destructive madvise implicitly for
>> destructive madvise in suitable situations.
> 
> ... MADV_COLD / MADV_PAGEOUT.
> 
> I am also shocked that you think asking apps to switch would not make us
> break user space.
 > >> 5. We could investigate more based on vma->anon_vma
> 
> Or we do what sealing is supposed to do.

Sorry for the rather hard replies, I was not understanding at all what 
you were getting at really.

> 
> With the hope that this sealing fix here would not break user space.

Is your concern that something (in Chrome?) would be relying on 
MADV_DONTNEED working in case we had a MAP_PRIVATE R/O file mapping?

Again, disallowing that completely (even without mseal()) would break 
user space, I am very sure.

Whether we should allow zapping *anonymous folios* in MAP_PRIVATE R/O 
file mapping is a good  question, hard to tell if that would break anything.

For zapping *anonymous folios* in MAP_PRIVATE R/O anon mappings, I am 
sure there are use cases around userfaultfd, I'm afraid ...

-- 
Cheers,

David / dhildenb


