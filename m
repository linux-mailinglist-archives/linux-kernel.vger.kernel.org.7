Return-Path: <linux-kernel+bounces-775335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF699B2BE13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401E54E3661
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67231AF21;
	Tue, 19 Aug 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAeRz1RR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0A31CA66
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597147; cv=none; b=byIj9w0uHBavbUI38vnncVoGUxzentuOaaC7n4qggCOOYG3yhfMCzJF5X+hD5vsN8jeRzOaNDdq9Uq8Ts+nk04yVZU0kBo/EPl5n1gvVifPwiGLUYaPgqdvc7mNtCp43G4l+ybUwqyKyAMgQm+keXpOsefJx5Aej+AMn0m9FYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597147; c=relaxed/simple;
	bh=qAs0XcBYhHLYErfDfebFruRjYp1XDjaXf1ddxitMbfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5FkToq4qz1ozj7HU3J1QsJV6I0TiF5NzjY0z+RpuVekoQbxGhXuLARWzrPgA0GgEIoOeHRiRoEBZppbsc7NeGc1WpUxubaEcNAbNntEhZldP8fbOPMhjRxgqKbh2GXHYdv7MZDC/Wr+tZhrOPsfEV8rCvqNQ7rRrE1bdbhymCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAeRz1RR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so6939743a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755597144; x=1756201944; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGKilKkH6ulJbbdDF/XnTU/jMrrNQ/OZzlvjuNWjrx4=;
        b=RAeRz1RRXVlgHEL13ziNxvQsSXOG0AnlTsckNT5OJ6qximyLSIScsbKKYy0JTPMXT1
         7BSgxQyE9V05MLl+Vjal7BJwwR5X5aytEsqwt4HeSQ670HWo10YowG2rXOQMQh29jSX8
         MZOX7/nVQPJg5kjozYEw6BNp3lUzxlvbvwad0K/9lQ+h1WdZBh+2A3NjjiQQLJ1SC6qO
         BOXQQa1xGRDhy8YNo9JmBXLhxJBKRwY0vGEUsls9t9059Vy1MsTCvc0WajiZ1f3mE6eD
         bVeN5NuThTxHHXVGeHseQPqfALyUSl+Goh1xVfXUlUqdJ8KjpUMEAkMdnwtQbiTFtHB+
         QNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597144; x=1756201944;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGKilKkH6ulJbbdDF/XnTU/jMrrNQ/OZzlvjuNWjrx4=;
        b=dSPg9knwaKgS6vJogLADG/0DRlnKz5gh0nd5xyGcMyF/P5tpeEEMfIhSdSNaqJ0pZb
         CZReIKHinngWBUtbcCOMV7MglhSC7P7vuj1CknbQd0J+KU2KXlsG0a/T7GyPzkJDeScM
         SW8R0A2Jx1sGIO5gfJ44XZ8VDTiMIAsbKVMrHiloSs4FOsPS7A9hZR2Hbb4rkmx/KJFX
         H5RNU/swvXuQ6YmAH8sI2GdPVUH3zfs3RCZx87CWJbttQrwOtXkqFkJqdRJoTqZ/G+cc
         4y/tYnGw66XalGwZWyRUwQbrd9jgpHA3I2jVmL3CexornmW+dHsOLBCcNq74F2V//4oC
         LSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQDd7WlioaA8QiPrBQSums4obmtNAGd49D8DIlE4MuDKBl5iD2HPAeKq4zVrZwNiDoDP68A9KawcEoDc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxFezZ84MgI+eOdqHnolAPsQIvNYcdmyelgSknzgVC56Bz/5a
	sxJ41i7+qQDScgEvqEozIB+GkQ6eKObZ6HjB9z/EIXk7/uNmti/PXIvr
X-Gm-Gg: ASbGncvDGziV3slS3qe9QMrEdxT2CcEjIFGeeLfXuRTTZ1SB8wDkpeB9RBBJLkry84d
	+ixo944qkQs0qVX/sdiG8lreV4VgGCJnpCi2eTJC3lkr4W4A7Mynn4OW4kc28ZY57oXSQrtuZWA
	7iprHYAeQ6xyeI6gUxrqYRd4v0UizId5QvvoKbdmguPTFT9gidCt1Wm5sGzGIuzzaX1YjtQO0lQ
	8QmuBYZRTtmcnyeE0ECXQTQqUB8WfS0vdRkwVwO6VD6LBiH3KCNApGQmcRUKWf9/iyBnx5Dps71
	0EuZKuTdVTiRRa3ssLJOBor1MtlFnFtB+Y0+cLGYQwVjqliUPxkSJe5ZPmvCsITLToTFQ3WtGCd
	XxFuaQnlMWQ15UWs2XuuzUw==
X-Google-Smtp-Source: AGHT+IGl4szIJa+BhsJtYd6B7f8e6cbRaIoS3/RZYsKJqrTQ2MNq/q3Jkblc6AIW/S6WMxr98PJw4A==
X-Received: by 2002:a17:907:d26:b0:af9:c31c:eeca with SMTP id a640c23a62f3a-afddd1ead43mr171516166b.48.1755597144172;
        Tue, 19 Aug 2025 02:52:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd04e4d9sm980813666b.113.2025.08.19.02.52.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 02:52:23 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:52:23 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20250819095223.ckjdsii4gc6u4nec@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818064615.505641-2-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi, Mike

After going through the code again, I have some trivial thoughts to discuss
with you. If not right, please let me know.

On Mon, Aug 18, 2025 at 09:46:12AM +0300, Mike Rapoport wrote:
[...]
> bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
> {
>-	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
>+	unsigned long nr_pages_needed = SECTION_ALIGN_UP(1 << order);
> 	pg_data_t *pgdat = zone->zone_pgdat;
> 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
> 	unsigned long spfn, epfn, flags;
> 	unsigned long nr_pages = 0;
>-	u64 i = 0;
> 
> 	/* Only the last zone may have deferred pages */
> 	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
>@@ -2262,37 +2272,26 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
> 		return true;
> 	}

In the file above this line, there is a compare between first_deferred_pfn and
its original value after grab pgdat_resize_lock.

I am thinking to compare first_deferred_pfn with ULONG_MAX, as it compared in
deferred_init_memmap(). This indicate this zone has already been initialized
totally.

Current code guard this by spfn < zone_end_pfn(zone). Maybe a check ahead
would be more clear?

> 
>-	/* If the zone is empty somebody else may have cleared out the zone */
>-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>-						 first_deferred_pfn)) {
>-		pgdat->first_deferred_pfn = ULONG_MAX;
>-		pgdat_resize_unlock(pgdat, &flags);
>-		/* Retry only once. */
>-		return first_deferred_pfn != ULONG_MAX;
>+	/*
>+	 * Initialize at least nr_pages_needed in section chunks.
>+	 * If a section has less free memory than nr_pages_needed, the next
>+	 * section will be also initalized.
>+	 * Note, that it still does not guarantee that allocation of order can
>+	 * be satisfied if the sections are fragmented because of memblock
>+	 * allocations.
>+	 */
>+	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);

I am expecting first_deferred_pfn is section aligned. So epfn += PAGES_PER_SECTION
is fine?

Maybe I missed something.

>+	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
>+	     spfn = epfn, epfn += PAGES_PER_SECTION) {
>+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
> 	}
> 
> 	/*
>-	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so
>-	 * that we can avoid introducing any issues with the buddy
>-	 * allocator.
>+	 * There were no pages to initialize and free which means the zone's
>+	 * memory map is completely initialized.
> 	 */
>-	while (spfn < epfn) {
>-		/* update our first deferred PFN for this section */
>-		first_deferred_pfn = spfn;
>-
>-		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>-		touch_nmi_watchdog();
>-
>-		/* We should only stop along section boundaries */
>-		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
>-			continue;
>-
>-		/* If our quota has been met we can stop here */
>-		if (nr_pages >= nr_pages_needed)
>-			break;
>-	}
>+	pgdat->first_deferred_pfn = nr_pages ? spfn : ULONG_MAX;

If we come here because spfn >= zone_end_pfn(zone), first_deferred_pfn is left
a "valid" value and deferred_init_memmap() will try to do its job. But
actually nothing left to initialize.

For this case, I suggest to set it ULONG_MAX too. But this is really corner
case.

> 
>-	pgdat->first_deferred_pfn = spfn;
> 	pgdat_resize_unlock(pgdat, &flags);
> 
> 	return nr_pages > 0;
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me

