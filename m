Return-Path: <linux-kernel+bounces-768363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A0B26062
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E091CC3FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA02F530F;
	Thu, 14 Aug 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsolBCj9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB92ECD3A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162109; cv=none; b=OPKSLnTAHn+7/JpzrxqXgdyV+OL7UKQFMohn5RHh61sZUe1jZhgtGQ0+zEjpEeOyb4qC4bZl0kWmF9sjpE+vzOOnZ77E2+EbaepHLmqBqMwUtLQvIbzsMWOrqbIzKM99b4crxLc2aa1bk4IbCxsNHBnEVzVXIJyHCQ9gsLXbxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162109; c=relaxed/simple;
	bh=VNNMgUbLt90rmiYspgAtvPJj4DowPNXL7m6ChRWZQ3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xf4fyFMSJCqe8haJLXh82j/me8gLBs46JBBRdHeR39Q0UxBclVJdDTDl+8zV8x8Q1OwqJ9Tb+OufO7jp/p21UUcNhrFcvagQlZ0x/vbNHfHAkpXjy+kstNp0QcdqWvLP7nQ3HtUO3/DnHCL6LNo3yG9FvOsErU5IjJZYXvK5Nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsolBCj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755162106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B+XqrzAGC+hGwyzCk1t4HsbUPzoPVcR/dXMTuQ/fZ9U=;
	b=ZsolBCj9uWkrbzH/DAC/y+rsDU6ew3yUORFRF6+fVIqCsVXn0AEBd23LYQIy2okyMr7jkQ
	MU+txveNCR5v2Boo+JD0Il1PIQWujZvwgH5nMw8x61EgwcVg7/fo38PXn72G7ZFux0KO6m
	Auwpp+5sfqVJ0vMXFv8xrOeHv6oezCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-PXyEyMonMtGQFlqLxjrkzQ-1; Thu, 14 Aug 2025 05:01:44 -0400
X-MC-Unique: PXyEyMonMtGQFlqLxjrkzQ-1
X-Mimecast-MFC-AGG-ID: PXyEyMonMtGQFlqLxjrkzQ_1755162103
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso427667f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162103; x=1755766903;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+XqrzAGC+hGwyzCk1t4HsbUPzoPVcR/dXMTuQ/fZ9U=;
        b=ByffI453ijnQfpWcK5jfAFnTxpMXCQAJqZmDtwUbShHBLOSbOos5T5RnIQoPoMdgId
         +ILU53oNUo4qMNqjhwW09gg3I/pbfz5U5MTFliXf9Tbd45hVqXGfq9goF65lBljk/4ur
         hF70t4CYELYa8Js9N5oG1NCODBC+sm5ANNW+L4FFXDNTlWl0/OpYdWmxb5eh8Xyg2gTg
         WeTWq2zWdR7e6RTvzscimdI0C7RdUBRmd1cDQkzBrmlsnDG8Rhplk5Hk0hR9ELy2rDN3
         tuXIJjQaJnu2+QmcZZ2D0fDNJVYogYfe1R2FigBhraRnP2tn9eZbTD3sv+3oZu4FNDrY
         tN6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9+zyAp+DOHRE/1neSC17utmFP4zAWKKUG/BXpsdFzA0Ek5gX/ZbFU7TnYXeW4XshcXSCS3jnHmGQlb+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEP33N2tLv1zkIoOYGoDjWO41SSd8du7Z4NxH+tpuo7TXtmc+
	uplGEwKuvp21PaSUZ1BfemYLJJgxWEczR2IL188kosZHhxgnEuseyi7ASCEWQe3JSG4MoT2mQbj
	7zebVzLm/qsewH0Q/ntwe3/s23aRjz4wkewC/ydnAPH0lGDcevZ0w6ITzPmxtcd9TNA==
X-Gm-Gg: ASbGnctU8UyXsA2V19tZWgeD/EQgLzikp9vCCetCLEyV3eHpYGovyxGFZIbSnkTsvKE
	ps9Kfu49DPiY2KAAprqwUDzHOS5laPZuSprnCpFmc2V9XSTFxxQs7LKwxk25cIG8xHLNW9bgnYy
	WrxCVa8uMVxnGSFfvTSYfXx9LfRQtt1AfXKKKsYlrFoBdHPrmFz64A4cEc9SHQNYTZA5cygLga0
	ssC6Pt1gTYkafewQv27XY7vcQIqep0Y6JBS5u8Z4DGOk2rUmS4YLlTHmodRFlFA9wdiujG9xlkM
	f9Gc3AZC1gtAYyF590Bt+Lohmjdv7kIUz5xpldQ5lwlH3Lwg4Q1yK8xVw44LcY5x5ViOyGut9cz
	DwiMTebP+uKy8EI2N4gj7ARgD27ChmsZF2gnQJ35bYKxaDKTZqMbTgEFUvZw5fQkFJpA=
X-Received: by 2002:a05:6000:2506:b0:3b9:7bea:14da with SMTP id ffacd0b85a97d-3b9edf3982bmr2026569f8f.29.1755162103103;
        Thu, 14 Aug 2025 02:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUssd5jKwre7nRGTkTt8TRJ0LrIp6xYOuOGAuIdLcXxjnPX8rB6/o0npU7Zz3xIpwUImjasA==
X-Received: by 2002:a05:6000:2506:b0:3b9:7bea:14da with SMTP id ffacd0b85a97d-3b9edf3982bmr2026532f8f.29.1755162102686;
        Thu, 14 Aug 2025 02:01:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3e00:9fca:7d89:a265:56f3? (p200300d82f443e009fca7d89a26556f3.dip0.t-ipconnect.de. [2003:d8:2f44:3e00:9fca:7d89:a265:56f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8fc28a7b0sm25886485f8f.63.2025.08.14.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:01:42 -0700 (PDT)
Message-ID: <7e88d01a-10bb-4edb-9010-f9c0bca31a46@redhat.com>
Date: Thu, 14 Aug 2025 11:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: early exit from hugetlb_pages_alloc_boot()
 when max_huge_pages=0
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250814082950.2888-1-lirongqing@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250814082950.2888-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 10:29, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Optimize hugetlb_pages_alloc_boot() to return immediately when
> max_huge_pages is 0, saving cycles when hugepages aren't configured
> in the kernel command line.

Do we really care?

-- 
Cheers

David / dhildenb


