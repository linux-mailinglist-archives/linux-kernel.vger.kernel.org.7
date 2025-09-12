Return-Path: <linux-kernel+bounces-813346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4AB543E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463987B21B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56D2C235A;
	Fri, 12 Sep 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPJ+rlWO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5B1917F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662273; cv=none; b=o8AeQYplG8c+DQelD7d7Wz2fmO7sqaVWO7PzaMkdCuqePA4yf9B9iat0KyqdTHUXruBd9b0eQ5ehNaSpjz7ksiG0vTVsavp/eIFboA49VLpNtWyHKgVthEgctEMdjO0mBefmLCqm77X0AGPgu3eWy/CatZ7BsxzbjxHrOX7t7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662273; c=relaxed/simple;
	bh=g3ugLp8l5qE98drOmhyhZPvroBrO64iXPa87r4UZPuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hxk8mV0XtOtDoiqQxdYiSm9TiiFlpaZYyQaZ7e19t8UZPwTDwABZtdk0U3yfoSLVemhfhT935CoCXnnCgKdKXFzDQ6zDdv8a7J64Fw87Q5To8d92pS1bRVuWrORVfZWii6df9IyutKCA56UnxLyXTMeRdXPXgH/nmukyetU1ml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPJ+rlWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757662269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmiBqy0L2WUHv+kOIrvdhPLSX42K2Mcyiy9ePRV90Tg=;
	b=XPJ+rlWO6TvKTU+lzNlPF00TRxhdv4rUjNnjcO1xbBvXtwoe0J3PD1KSa+EnJOBJrX5O+q
	M9qvbUkcxVckGDomnYMfGnvqkRWH3sW1f31+53ZVSQ4Yyc4Eaj5IcYeEbLoxZVs1YwVdck
	ZpfmhKSCVNukc1/gQc5WoopDlCpU2nQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-X_npmFWJNeaI1uNJZ_NW1A-1; Fri, 12 Sep 2025 03:31:07 -0400
X-MC-Unique: X_npmFWJNeaI1uNJZ_NW1A-1
X-Mimecast-MFC-AGG-ID: X_npmFWJNeaI1uNJZ_NW1A_1757662266
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e61deaf253so891515f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662266; x=1758267066;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmiBqy0L2WUHv+kOIrvdhPLSX42K2Mcyiy9ePRV90Tg=;
        b=eeE29nzYW7m4Z2Nf2nOSURLqWNFH3HTeDj524SrMP3144tmfaSLSV4M3q9eVAhHMI6
         TtjIOqHvaqdAwN25jWjeF1O89Tq7n25pDEBM0OBt7IpgBSCLAam4qKHGGx1l1sA8Nf+7
         WpgzTTs+dKQMRe5QrpYS/SW9V6oyiL7z2hNzQlbkt6RwsNFfRXV9aqWsAjANSbB5A60q
         sin8tQvgtF+V3bz6XjFpwv3ktE9jybJQoBqFQLvqa9MSe3HC+ickTEK6PwZGjQF8dYmR
         WE38gQRlWqvzsuAy5hPwE2TX64gSoQc3hP1faL4OSrpj9tUOClmOnEGgV6DehV5CtUSt
         hOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCoGqxKiOqMwQQ4O4/aRH2Z7pquoWzfLopjy10dM1TioUWCdV+iz5UyCnhgZJOdS1H1JSzaCgxym03/r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36xHFmdbHelS03n0UHEddL7rYRUGXy6X1D/XMUZQPfqAppfNp
	L3si6qgTDMT/H6Qf0KTSQMinjtbVQJhiEOaMxD5SD1PhCgws6Tk6yKGoe3ew2rSsh4xXeZks+tf
	mx5KHYEzOS3sBhx2R/hd5p0yQ47l1or2Dlx20bQIRNgpyKv/wz0cD9EcJrshDtB3IHw==
X-Gm-Gg: ASbGnctUsU9qKbUUsAcsSsZHYIKJ9D9o1GKVgGwrcahIbhJJlzQ7zx1UEUbNRr6WZ2y
	dYxTgQhNGs9hTaF8pwq4Af4F6bmSDNFuFORsPe/6YQQ5gI9F/YK5xv9zyR5YmknHEhRAU2CEKIu
	/x2eCkmi/jSlBdwrsTo09Gc62SSowq+PUmAdI5Pj6kx0kxArz+1v1pi73rbqjSNyVQ0BCiz1E3i
	g/3sSpGpU8IcLniCrh+by126mGyRfL2EPqjlRL4EXt6eUfpHbLa7XHVVbPsuiaXT+qPY7dgTggJ
	P6MiA9/3uWHQdTJwzBgyfcxE0f59wq8yE/fGZzUZi/c1TheS+79AM0ldw9vlnEv1FeXHeMkMuUJ
	Rr77CA8goEFHF6gKvHgP04ahVt149e+qRILiMwfSqqmLXAM7yvzgIdZ0FbR1dj3uQch0=
X-Received: by 2002:a5d:5d02:0:b0:3e7:5e19:5ec3 with SMTP id ffacd0b85a97d-3e765a2dd2amr1433344f8f.41.1757662266427;
        Fri, 12 Sep 2025 00:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvNIXBKO3q6si7Ysd4vKlJR6P6Qcpb2+dcH0QDR1TDVJzzqtFB6D3wBWW/HUyK+eg3VSV32A==
X-Received: by 2002:a5d:5d02:0:b0:3e7:5e19:5ec3 with SMTP id ffacd0b85a97d-3e765a2dd2amr1433313f8f.41.1757662265971;
        Fri, 12 Sep 2025 00:31:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm5412795f8f.8.2025.09.12.00.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 00:31:05 -0700 (PDT)
Message-ID: <eb6e18c0-533f-4e77-a56f-60ab8cacc369@redhat.com>
Date: Fri, 12 Sep 2025 09:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: jane.chu@oracle.com, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909184357.569259-1-jane.chu@oracle.com>
 <e9b34151-0879-4900-af9f-2ce0dbb678a6@redhat.com>
 <2fa7aa11-6521-40f3-9934-aba275154ca2@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2fa7aa11-6521-40f3-9934-aba275154ca2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.09.25 21:54, jane.chu@oracle.com wrote:
> 
> On 9/9/2025 11:45 PM, David Hildenbrand wrote:
> [..]
>>> -        /*
>>> -         * If the pagetables are shared don't copy or take references.
>>> -         *
>>> -         * dst_pte == src_pte is the common case of src/dest sharing.
>>> -         * However, src could have 'unshared' and dst shares with
>>> -         * another vma. So page_count of ptep page is checked instead
>>> -         * to reliably determine whether pte is shared.
>>> -         */
>>> -        if (page_count(virt_to_page(dst_pte)) > 1) {
>>> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>>> +        /* If the pagetables are shared don't copy or take
>>> references. */
>>
>> Why remove so much of the original comment?
> 
> Because, this part of checking has already advanced from the "dst_pte ==
> src_pte" to "page_count() > 1" to ->pt_share_count > 0, it seems cleaner
> to just keep an one liner comment.
> That said, if you feel the comments should be kept, I'd be happy to
> restore them with a bit revision.

Well, the comment explains why checking the pte pointers is insufficient 
and why there is a corner case where the pointers differ but we still 
want to unshare. :)

But yeah, I agree that reading the code it's clear: if dst is already 
shared, just don't do anything.

I would probably rephrase the comment to something simpler like

"/* If the pagetables are shared, there is nothing to do. */

If you resend, please add a comment to the patch description like "While 
at it, simplify the comment, the details are not actually relevant anymore".

-- 
Cheers

David / dhildenb


