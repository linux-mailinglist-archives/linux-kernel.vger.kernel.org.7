Return-Path: <linux-kernel+bounces-776689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8D7B2D080
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B31895C48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055926A1C9;
	Tue, 19 Aug 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSKmX+V/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E722D4DD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647524; cv=none; b=s8gBPmZOKOk80kNlrtk1OoYZTT5khFuHxAtfeYB+9S842UvtPyEwx7acXBo0z3oL4cFMRZCy8SRhkVaVSOxSpoB+FHwKU3D5KUXhBxq25xeO04a8laD0jInzwGSdXmqD35Pzp5EYmUI99nNnkSUrhIxv86hTg+vTzZeYzzZDgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647524; c=relaxed/simple;
	bh=tCbjBamqBRJAyRNUkdkIturfGMlxJnS5+BZA+9SZi04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=invR2ef5e8Xt6A1Em1PCRJlE4/VUK3h3aJeFglEctD944Z9cQCTRuZMe49IT925avWU1oe2cULcG78Z9Ouhk1PqKXmybHCRJj3VwToKY1xqlcwQ/1P8sX8JrNa7786jm8Y9dL6YPBtDLis+DTI+m8jsYL9qRiNx2P+5bZcl7Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSKmX+V/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5f620dso6566506a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755647521; x=1756252321; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwii5vDRk2HqFHoEzFvdXjLh8+HDGIvx8Kia2Hy7yd4=;
        b=OSKmX+V/jDvVkI+5wPNDqRdhWzKtnpKVz6PmhnWJpnUn1RKU12VtKPeiK/mYamZ3gY
         teX6GTcE+ajONqXjPkUmHVmx8OPy+s0ySihXJuLVsdPrR0vv19y/kFxUzpjNpk5sE+D1
         rKRSzWOmSKr7nH14phYbo1WiRuuNQiEoZQ10p4RevbGuElsxUy0qBh7GGekDMFpIFrhc
         FwiLKJOA6Uabd3ov+OdekO0zE6tTNKC1K/XVbThd9CjHDf7RfxeE19xVhTik9wmjOIjX
         7l3oIQKRxNtKndvxhC+EXFAd3CKP6cBR+NMRU6UNd0Ev/760db5doh+mJl8ycL8xsNGK
         IjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647521; x=1756252321;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hwii5vDRk2HqFHoEzFvdXjLh8+HDGIvx8Kia2Hy7yd4=;
        b=iuaw9FoUzC0OLxjVMX8A06T7SE8YrBDJcP/NiIK2qG4vM8p6RDF4OOquflCQG6f5dj
         qRsWC8ptJOVP+ZPOpGIm4gy1YI+CC6A3LT5QQGUNJBbJSheGkhe7gdt5pZfESs8TlFQZ
         sIbqYfY3/ZQhMm5KTlHvb6OHGHCpE9ujWWFDyT36JIcIG+nn7yEHpjjalcBmtmC79vG+
         pIgaBrZf1yrRsq58SYTv7OrzdA7fKQH6SRICxPt//LFpCLdVX0As47GVE0pJqwXTJhMD
         kCGeZ3Yw1jDp6zEOuJJL++qUFgw9eNGcKxcka3dPEbuXgBpchcEc4kir7q8NE1ZHWfu8
         YpOw==
X-Forwarded-Encrypted: i=1; AJvYcCXOa29DfwdifcxWkF2JXAKmpNSBhlAm9nXf60enP5ebfwH4xNFWbO4rPpFxtUDWsvkiclf00hZAi0VJ3Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOeCL30uD+Rd1OLzWgwuPgl9nFT5cNlhZZgigz2eRJTvo3OzW
	9CveXWbvq+7XSiMjrPiaPQGMEBm8F+j+rlfyZfXq+AZYe+jXWUMEs6vV
X-Gm-Gg: ASbGncuAe5jKUdOVV1U1BtsJb0gsaLKkr1qfP/qw1JZiuNub3omF0RFqzxON09FvH5/
	NWLnD7aWH/xUK73WBOxLRCsnWnCFbwSKWl1lGe9SHBFRWdwvnTW7Kn8qg5Eu6Gj5J/xzIio6VbG
	f5Pu59DF5rAszucsK6t2RFaF7SafxTkMuD8s7pgruhUEQJHkBvjoqmRcYLplISH+p/VpkpCbq0w
	IzOiW5k4P0HhbAxJ7lNfhV4E8YJPTBiQiXkAc+7Iuyv2YJV2ES9ca0ZD2wmYcfg8/RA1yPaaebL
	bDtZtb6hDx3XFZOke5bYbxEbrSpayVcbOR3FvL3CQGsZBi5XHdpjtDCBZy9O6ERkk0mBjjfIDS2
	4LbJYPxssSRVUfpCF2R7+hg==
X-Google-Smtp-Source: AGHT+IHTWjAGjinh9nzHsJKsD5xLXBZISMysB5cDMytuX+CmFt7hFCd0FeBDXqTTZwWuSeECM1i6ww==
X-Received: by 2002:a05:6402:51d4:b0:61a:9385:c781 with SMTP id 4fb4d7f45d1cf-61a975e5b9bmr669786a12.38.1755647520722;
        Tue, 19 Aug 2025 16:52:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758c062bsm2574102a12.55.2025.08.19.16.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 16:51:59 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:51:58 +0000
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
Message-ID: <20250819235158.mgei7l4yraheech4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
 <20250819095223.ckjdsii4gc6u4nec@master>
 <aKRX9iIe8h9fFi9v@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKRX9iIe8h9fFi9v@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 19, 2025 at 01:54:46PM +0300, Mike Rapoport wrote:
>On Tue, Aug 19, 2025 at 09:52:23AM +0000, Wei Yang wrote:
>> Hi, Mike
>> 
>> After going through the code again, I have some trivial thoughts to discuss
>> with you. If not right, please let me know.
>> 
>> On Mon, Aug 18, 2025 at 09:46:12AM +0300, Mike Rapoport wrote:
>> [...]
>> > bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
>> > {
>> >-	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
>> >+	unsigned long nr_pages_needed = SECTION_ALIGN_UP(1 << order);
>> > 	pg_data_t *pgdat = zone->zone_pgdat;
>> > 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
>> > 	unsigned long spfn, epfn, flags;
>> > 	unsigned long nr_pages = 0;
>> >-	u64 i = 0;
>> > 
>> > 	/* Only the last zone may have deferred pages */
>> > 	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
>> >@@ -2262,37 +2272,26 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
>> > 		return true;
>> > 	}
>> 
>> In the file above this line, there is a compare between first_deferred_pfn and
>> its original value after grab pgdat_resize_lock.
>
>Do you mean this one:
>
>	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
>		pgdat_resize_unlock(pgdat, &flags);
>		return true;
>	}
> 

Yes.

I am thinking something like this:

 	if (first_deferred_pfn != pgdat->first_deferred_pfn || 
	    first_deferred_pfn == ULONG_MAX)

This means

  * someone else has grow zone before we grab the lock
  * or the whole zone has already been initialized

>> I am thinking to compare first_deferred_pfn with ULONG_MAX, as it compared in
>> deferred_init_memmap(). This indicate this zone has already been initialized
>> totally.
>
>It may be another CPU ran deferred_grow_zone() and won the race for resize
>lock. Then pgdat->first_deferred_pfn will be larger than
>first_deferred_pfn, but still not entire zone would be initialized.
> 
>> Current code guard this by spfn < zone_end_pfn(zone). Maybe a check ahead
>> would be more clear?
>
>Not sure I follow you here. The check that we don't pass zone_end_pfn is
>inside the loop for every section we initialize.
> 

In case the zone has been initialized totally, first_deferred_pfn = ULONG_MAX.

Then we come to the loop with initial state:

    spfn = ULONG_MAX
    epfn = 0 (which is wrap around)

And loop condition check (spfn < zone_end_pfn(zone)) is false, so the loop is
skipped. This is how we handle a fully initialized zone now.

Would this be a little un-common?

>> > 
>> >-	/* If the zone is empty somebody else may have cleared out the zone */
>> >-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>> >-						 first_deferred_pfn)) {
>> >-		pgdat->first_deferred_pfn = ULONG_MAX;
>> >-		pgdat_resize_unlock(pgdat, &flags);
>> >-		/* Retry only once. */
>> >-		return first_deferred_pfn != ULONG_MAX;
>> >+	/*
>> >+	 * Initialize at least nr_pages_needed in section chunks.
>> >+	 * If a section has less free memory than nr_pages_needed, the next
>> >+	 * section will be also initalized.

Nit, one typo here. s/initalized/initialized/

>> >+	 * Note, that it still does not guarantee that allocation of order can
>> >+	 * be satisfied if the sections are fragmented because of memblock
>> >+	 * allocations.
>> >+	 */
>> >+	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);

-- 
Wei Yang
Help you, Help me

