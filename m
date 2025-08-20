Return-Path: <linux-kernel+bounces-777702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B3B2DCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A263B5934
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9B311978;
	Wed, 20 Aug 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0uEwwL3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D1308F05
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693740; cv=none; b=lawLW3182tWc9+xoR/WM/GFKj914X1MJut85bto3zi2BkCowGJngmuMGwVkUTLgLlaUjrnJGb+/E/xUKC+hGwMxZL9KlSUdN0fxOcUQ2RSW2r4LieCWfAQVrR/v4nR8yf5DdA+HL1anZDcAkId/C/lV8Hx1PoY+PDxVu2ayK0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693740; c=relaxed/simple;
	bh=wfUj5GVqJdy8Gzu7HZkb5EvyfjAxA67sUfDfZ4Afc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPhfPy8u98WxQwNwA0MMX6LKlBjQKg+/yzSoUq4qh+t81o9fKUdDhFjTC/5wnpTLhXa62T0ts5ppq7/DNrRk6klE/OlwD83RmXoZvIPiNd/Rg8EeDdUR9mJOrduWKlv78NVvQ67YOroThrW9yWCkH62AJ6ckmV/u1HBpFmfsMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0uEwwL3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61a1663bd7dso5932425a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755693736; x=1756298536; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIg9W/3Kh0nknE9bg10iXxQ5gJtP6ZAIJOJFszr9STA=;
        b=d0uEwwL31dnXDvO9LsAqgGV/MLoxmBWlhq6M/foaxyzT/6rHYN+wLlnHVpXNZs0x+A
         WCdUnc1TqCnQ4f6h6Dmh7Ohc4a5vmthAOmRvBKuvli+dp2b9ogST5UJN9A+AarPAqYq9
         dRHjTpATwqOH2/N5X8aYnzseiQ7Rs7AFPh/Dtm6GwODe5Cy1oR6vj27CuncWYQc+8IPP
         UkSE3KjXtXflwK5R0nOJ0kodg6VEwvr5HwmzsW/cLLKqRbHsVRe9pyoF/w4450N8Qesh
         D8Jzam3iDcFMNacp3aHmW+uDWCc8L4IMwhbU8NzEFYSKZQs93iMi1yzkWBLiCEMM6D82
         QlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693736; x=1756298536;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIg9W/3Kh0nknE9bg10iXxQ5gJtP6ZAIJOJFszr9STA=;
        b=i1rPfIsv8XEicRZWwcZ/iu+kGfh2XhSCI6sxu7CerxWZpGHf4bU6ABwRQGNJulyfjB
         /yBbYrbh8jh/khfNYWo9WqfiBfH4cmtyPA2cSXGlY3B2eTQNtwCos9KE/tAfbTSfL+sW
         6myDs20y7Nvylv6AfjWtV8FX8b20cvsYyPvpUADckKg+8I9Z7ZeLLkpJwqPnxbuz0Np/
         p4j7QIXqmzBWO87kLAqY96c5aO9rgSx60jVmKyM5BdsyTQd/DmEaHlvpCh9XV0/06qY9
         QQ+mDe9e6WKtfuxk972z/H7EFBG/3Zh9pVrqKt0+qONmzMbSV+fDXcxVezKCHklNSjMQ
         GrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdMWVgu6BJhmg/Sx0M2eNliPJIsAh/6iDC2UAangSdf+B+zhadl8EAs9cOqfgTIr1B0QqS7Bg4kI1Y8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtVv9TSze3CmU2letBdlUn9VWdsx1c+S1RF61cXWob9aA5NWA
	02rLDK6CONioSPxH6Fv0/4Ie4w4oeEB46Vr2kmH8BhxcdFhaOpxdKcoTCAlMcA==
X-Gm-Gg: ASbGncuRUyurC4Lj3DygnzYrShzsf58PUnjMBnlBiF1PZBOB3CiGk0l+79tRAEjOZ/7
	Pf+RYhqsFOnk93+wppvKE3sz6v+5Ph1hV5saqSSLNE2JnT2svPdhHkRF3twFIAT0UMfKM+YGm0r
	gOxVL8BbuKhth5uIRk3vZvXDRltGTBIGNV1ekMiTXmyW/1pIaP8G3fJdCfsZHuwUJqOs527SOW1
	QskDV/aaUCY3R34jK+xbo1Y3ApAtE8EKigj3RopYJs6IilOd3Zw9JR6KxTS1qXMVFQfMPt5xRe0
	GmHrAB2fFjb+7UqSvOYgzQH//oiThFnSF9cJ+ZZqF12o3KgWyM3lbKzj8w5S3S39t98NKXejZwB
	sKnkkhpPZs+GZHOVD6YW01VuE3cKlBREk3+4f
X-Google-Smtp-Source: AGHT+IHHRa/Wjm92m9kTtxGRWzJ7agHg8ZuSbyEGNlj7C81CaI3UVA8ffbMZiBB1+byaZJtVfu6Ixw==
X-Received: by 2002:a05:6402:4306:b0:618:aed3:38a with SMTP id 4fb4d7f45d1cf-61a9782d02cmr2281770a12.31.1755693735970;
        Wed, 20 Aug 2025 05:42:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758bff1csm3633444a12.56.2025.08.20.05.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Aug 2025 05:42:15 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:42:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/4] mm/mm_init: use deferred_init_memmap_chunk() in
 deferred_grow_zone()
Message-ID: <20250820124215.igq7ug4juiomjyng@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
 <20250819095223.ckjdsii4gc6u4nec@master>
 <aKRX9iIe8h9fFi9v@kernel.org>
 <20250819235158.mgei7l4yraheech4@master>
 <aKWTSq-JcTviuGlU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKWTSq-JcTviuGlU@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 20, 2025 at 12:20:10PM +0300, Mike Rapoport wrote:
>On Tue, Aug 19, 2025 at 11:51:58PM +0000, Wei Yang wrote:
>> On Tue, Aug 19, 2025 at 01:54:46PM +0300, Mike Rapoport wrote:
>> >On Tue, Aug 19, 2025 at 09:52:23AM +0000, Wei Yang wrote:
>> >> Hi, Mike
>> >> 
>> >> After going through the code again, I have some trivial thoughts to discuss
>> >> with you. If not right, please let me know.
>> >> 
>> >> On Mon, Aug 18, 2025 at 09:46:12AM +0300, Mike Rapoport wrote:
>> >> 
>> >> In the file above this line, there is a compare between first_deferred_pfn and
>> >> its original value after grab pgdat_resize_lock.
>> >
>> >Do you mean this one:
>> >
>> >	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
>> >		pgdat_resize_unlock(pgdat, &flags);
>> >		return true;
>> >	}
>> > 
>> 
>> Yes.
>> 
>> I am thinking something like this:
>> 
>>  	if (first_deferred_pfn != pgdat->first_deferred_pfn || 
>> 	    first_deferred_pfn == ULONG_MAX)
>> 
>> This means
>> 
>>   * someone else has grow zone before we grab the lock
>>   * or the whole zone has already been initialized
>
>deferred_grow_zone() can be called only before deferred_init_memmap(), so
>it's very unlikely that a zone will be completely initialized here. We
>start with at least one section with each deferred zone and every call to
>deferred_grow_zone() adds a section.
>
>And even if that was a case and first_deferred_pfn is ULONG_MAX, the loop
>below will end immediately, so I don't think additional condition here
>would be helpful.
> 

I think you are right.

>> >> I am thinking to compare first_deferred_pfn with ULONG_MAX, as it compared in
>> >> deferred_init_memmap(). This indicate this zone has already been initialized
>> >> totally.
>> >
>> >It may be another CPU ran deferred_grow_zone() and won the race for resize
>> >lock. Then pgdat->first_deferred_pfn will be larger than
>> >first_deferred_pfn, but still not entire zone would be initialized.
>> > 
>> >> Current code guard this by spfn < zone_end_pfn(zone). Maybe a check ahead
>> >> would be more clear?
>> >
>> >Not sure I follow you here. The check that we don't pass zone_end_pfn is
>> >inside the loop for every section we initialize.
>> > 
>> 
>> In case the zone has been initialized totally, first_deferred_pfn = ULONG_MAX.
>> 
>> Then we come to the loop with initial state:
>> 
>>     spfn = ULONG_MAX
>>     epfn = 0 (which is wrap around)
>> 
>> And loop condition check (spfn < zone_end_pfn(zone)) is false, so the loop is
>> skipped. This is how we handle a fully initialized zone now.
>> 
>> Would this be a little un-common?
>
>Why? The important thing is (spfn < zone_end_pfn(zone)) is false, and I
>think that's good enough.
> 

Well, no more else.

>> >> > 
>> >> >-	/* If the zone is empty somebody else may have cleared out the zone */
>> >> >-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>> >> >-						 first_deferred_pfn)) {
>> >> >-		pgdat->first_deferred_pfn = ULONG_MAX;
>> >> >-		pgdat_resize_unlock(pgdat, &flags);
>> >> >-		/* Retry only once. */
>> >> >-		return first_deferred_pfn != ULONG_MAX;
>> >> >+	/*
>> >> >+	 * Initialize at least nr_pages_needed in section chunks.
>> >> >+	 * If a section has less free memory than nr_pages_needed, the next
>> >> >+	 * section will be also initalized.
>> 
>> Nit, one typo here. s/initalized/initialized/
>
>Thanks, will fix.
> 
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

