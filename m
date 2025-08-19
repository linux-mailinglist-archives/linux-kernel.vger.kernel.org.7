Return-Path: <linux-kernel+bounces-775092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF61B2BB26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1773AEF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300281732;
	Tue, 19 Aug 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8RbYvPp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE630FF30
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590071; cv=none; b=PrO+vI24lOXMPatEkvEqXYyaOoJHsejVBvy9SEVuZ1q3+R2RKkligLhXmpYda1TI0o7ST1/BbhTUE7eHzfKNcmAQPe72mLmj/7yoxkh2+KweFtYX21MM6oDBUyO4hba0idmIuDHmUyLYImoTaFdkUkB4wKG1ygJo6aKg0RvRCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590071; c=relaxed/simple;
	bh=5YqL0ZgT4aBHGX0m80T4NxccIZCR0nYtF5Godthib0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJMKCYZDyRsA8EhpLfk9ykwTwmKPd2qpzYoUmqN49jQdW130kd5a9E5X5AiI+APEN7Hnvr1WIsd5U17K2ZtQpg/c2EGjP6//tp6yijFcy9uRpBNRrBDkjBz5ZbTuodheTceUXCDLSSFaFDPGnBl1NDxyL2pYZJmAtZS5UgkAtHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8RbYvPp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755590068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C9W9Lxnwsqcb0sJAwIsuZAMV48nhSH9Z6F1jCNOWQGw=;
	b=H8RbYvPplxvDr+RMf3ivFS9ZpGIvaSTWv8ZMp6NuUWiNeH1LXS9PQa1AHJaKRWwL+9hUTT
	z/g0chOyVzdH2KLGo9/uN+ICtKJFAyEPSI6bbSZqASjm0mJdopYwW+6ZiPgRs2yV354gzd
	3NtNWG6aIwc4SWSFvdwX/qyLQq9m1Ks=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-jKDT3GryPseFZKOQkViGKA-1; Tue, 19 Aug 2025 03:54:25 -0400
X-MC-Unique: jKDT3GryPseFZKOQkViGKA-1
X-Mimecast-MFC-AGG-ID: jKDT3GryPseFZKOQkViGKA_1755590064
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9a3471121so3079975f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590064; x=1756194864;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9W9Lxnwsqcb0sJAwIsuZAMV48nhSH9Z6F1jCNOWQGw=;
        b=FhL4naN5u+/p5zfhuftMDIks3RCYOriUPhS3XyrQ1vper7NLDvQttb+2IdOYzlcxH7
         wK2inRCt3v9nreMbPA7XOOjep2Te5Z5xvaTSE6QMFTvuZlNdTe89e+hMt8779G7Lu9Li
         AEadoaZuep8QuHg1pivUae9BCNOs8UzSlm+aSl4Uaky0gsgmhbn8bGETJNgThgxiwiJG
         iWNrptvO8QvBCe/2Sazs3fMCtaUiVaEnE07/Y43D5Ob0aJ5/BnqH0qvgGPpzKwFba/Iq
         22v3MOO89N3IsVRsQmxuxW0Q4w75WX5JUJlaRVp/+ZONc9x5K2tUqb7U5v3ICm6itLYv
         1ICg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ukZSAk+rs/yI5CmXTI7gMXxc8v1IJfXWYB5DR3IZ3yXHgGboJ9FSBqlF7CJpvckuKjGdGVg9oHI0+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLg+oE2Sa56hJkB2Omhh0Fl4xXjyUjfOokcLU+GYKsZ+TZXkD6
	ZGCE1O/2cM1s0SLfw7JGxRXBhqqR7ZWCWTwxJ4HzSWvIZ+pwW6aEtN7aqoHG2rWHubHGGo5p7Jc
	HCtz8cClpjMnXoIw+8hBKEfKqDDsQvpjafa4fEIQdOEmdDgrm+R9MHgZNvIYBkw+b2g==
X-Gm-Gg: ASbGncv0mRx6Ud96ErNa8+FFSMkdUIaLl9N1ByldszCoRuZ04d2FcDaDFiKplP7Cw4r
	bHYDPJh2IBjzHtnAEUbNwdC0HUejpchrSzT2pmId3v4/T6Kt+EEvKqM+UQLIuh756I03R7xYLDO
	XnYLh0Ar0BpLm4Zx/KNRKg33Io7tnPdbpNGliVIc4rkGBaztx+dWkL+X/AAIhkQkfZ1DCqs6MTs
	suyzotjGmw8U4JLaEG3f6VCN8ZFnqD5lxJdfqxkxPMVI6gMN5+V5mtVZpu2TMPTYHQf6Jyxtct7
	svU0SicnjCkBGaNRsniI5Z95XFApuzncSf49dIb45+KCf47KLPU9P69EfYvPlWKzKiH1XNrinwB
	uAGP89ctCSPc7U4FUz5TqD3qWWrR3OTYeMQPAScBb8rt85EaqowAie7ot3sYiSUAsC9s=
X-Received: by 2002:a05:6000:2c0e:b0:3b7:76ac:8b9f with SMTP id ffacd0b85a97d-3c14858912fmr1072749f8f.25.1755590064221;
        Tue, 19 Aug 2025 00:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47MQ2FAABjTTxBPmZqsECDlQCU6YLlmvMBefknIf+UtmxQ2Zf3tk6D8BTtfNAIZ8f0BKPFA==
X-Received: by 2002:a05:6000:2c0e:b0:3b7:76ac:8b9f with SMTP id ffacd0b85a97d-3c14858912fmr1072717f8f.25.1755590063759;
        Tue, 19 Aug 2025 00:54:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43bc6sm2574711f8f.25.2025.08.19.00.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:54:23 -0700 (PDT)
Message-ID: <408d7eaa-5aea-4490-9fd0-978c4eb94d32@redhat.com>
Date: Tue, 19 Aug 2025 09:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/mm_init: drop deferred_init_maxorder()
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Bill Wendling <morbo@google.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>, Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-4-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818064615.505641-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> -static unsigned long __init
> -deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> -			   struct zone *zone)
> -{
> -	unsigned long nr_pages = 0;
> -	unsigned long spfn, epfn;
> -	u64 i = 0;
> +		while (spfn < epfn) {
> +			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
> +			unsigned long chunk_end = min(mo_pfn, epfn);
>   
> -	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
> +			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
> +			deferred_free_pages(spfn, chunk_end - spfn);


I assume the expectation is that all PFNs in the start_pfn -> end_pfn 
range will go to this zone, correct?

-- 
Cheers

David / dhildenb


