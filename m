Return-Path: <linux-kernel+bounces-794071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C21B3DC67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56821898B92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B92F83CB;
	Mon,  1 Sep 2025 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSRePt/F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E342F6181
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715539; cv=none; b=N+ZKaxj46Vmi9aixoNln2JmNY84sOH+AED4fFZrtUhtLkAIP7uCwbuhLFJb/lOCx9BeinZsQTGL9gzQh0rlYwQu7N6s5/XpovHrI+iRJ9svpMvazp6DqgsG48RpQ+iDgkpgq9kLaDTPNtpdkqE0JjanzKzmkq4LByTsyGwDD0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715539; c=relaxed/simple;
	bh=JMrOSellq7qQjVijaWBctdHizyXXPko559CI1hz/svU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCzaTowgrzfRBeSg31mrhFW6KgfNfsdeC9dovCbQx+PxYl78nZcYTYlMwqnlNhKieuX5JUIqqdCkmMumKxaRzbKjO32ed52XUPz/JFBWm3oijmxqqhel9tlpZkahBFn1UQA7ClSw+SUNcquJVjvrO/KAEhFHwCoubcUksZkL6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSRePt/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b9B2xf90wwGP2Dk53DRRs4uSfHtCfs/QAaO9nORyKHA=;
	b=KSRePt/FL4SS6kFHMCxF0e9s5fg0f1iADjakiUEqsGEVM+X/2vzzZtEkVu15Sf63FeDqs1
	/VNBiffcySEXGw1p8B1RBTgn4OX+iMHXtAi6UHVGjIVeuydbQWfjcDeykjGuQM+5WvvE1y
	nmAmBUl97NCdCJoqHigrChsBF/bBXxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-YSDkQVAONbu_QwhveJh_pg-1; Mon, 01 Sep 2025 04:32:14 -0400
X-MC-Unique: YSDkQVAONbu_QwhveJh_pg-1
X-Mimecast-MFC-AGG-ID: YSDkQVAONbu_QwhveJh_pg_1756715533
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso1754107f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715533; x=1757320333;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9B2xf90wwGP2Dk53DRRs4uSfHtCfs/QAaO9nORyKHA=;
        b=gud8r7nIwNPG6xxI87HWYWLIkIxF00OyEGa+oJvWfBF9HAIFuGyl6iJSEORi/mnxyJ
         6f2ZdulkF5PRXhOxs4CyNZhkcSsj7J0nng154l7+z+SoEDYPLyF7YDDH5sL+vpNauHTe
         ky28LSCi62u1tDZuI415qbekTecHKR39l9rZHvnJ7LVrNPiXsU9/XMdOCumYryX/LEJR
         /2R4Bz47BtyBV1Zm9Ue9NCI5iz4fNAvn4bCilmOkQZ1sBYxcHfZ6pyOaAKc1RO+aYiiE
         l43RB6AhQA26I+oKyLEQzHp579N/0RjJLzK1rGR5HcWw+56OexTQPI4MF+XaPo1Lm7Z/
         /ZZA==
X-Forwarded-Encrypted: i=1; AJvYcCUMFZF/HF8+NNTtn+ZEEgtfH3IdZLw0Cs2y2AY8I9sSNGa4vthuqEx1W+nen6shv/Ev4LjNJ2zC6P8UczY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIob2NogrD62a+C1o8OvnaRVJzgJP9hdDPSb4Gjhj07X3iB2p
	xF7NomUKHVW+oW1c0WhecEmsjn76pIIx9QIUcE/IWCfuOMr9YmHTSg8cHxxF+Qkt8tnyIqR7siy
	zopnleC3t+G8Ld2HJ2o8bJGI2ASS7wZqF1hYVjLdn3OYZBiB4XGcYidk/rPtfnHia1Q==
X-Gm-Gg: ASbGncuuw72PoLKA4/AiTf4fVf/AcRc64Ff1eAIxAVdZa0TwRFWXp5C0VsCI6Q0C9kd
	zQ1gVT7c2udJQtkP4Pgmfoiyhog4F2ibo1nBW9chuc3wa9eSmdDDLJqMv62g/DNF+zUj5Cye/En
	oFMGL26838K1hjj0afRhh2sT/fBPKPwj+0ork8N2bWn0aIc66dmafvZDVvJ0YPA1QlXFOso4BeX
	Unu4d3NwUpCeX24adtb2Dns8OrllELZ+5lTuLXX3oNa0MP/PLDouMx4f4oC2+KxMz9ey1Y8iuaR
	LMFWb5gwGu2LqhZCSCAesUn3RZT6GIUnwK4BqeNiiWALIRlymqpaRS8EUxCzMt5UolxNOREB69c
	BRVShIXGSXAbFBQWuGasI+5DWlbifeT834Eei+aCFly+ZXhFv8aDja9AS056Udi6lbTk=
X-Received: by 2002:a05:6000:310b:b0:3c2:95c8:b71a with SMTP id ffacd0b85a97d-3d1af84bc3dmr6311135f8f.5.1756715532976;
        Mon, 01 Sep 2025 01:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdrBvNiH5PR6NpvOde6rWaUaJ2VLDdnRhL58x+5KKINZTciAqBs6qVfgGv6QLhWspy0QcSIA==
X-Received: by 2002:a05:6000:310b:b0:3c2:95c8:b71a with SMTP id ffacd0b85a97d-3d1af84bc3dmr6311091f8f.5.1756715532440;
        Mon, 01 Sep 2025 01:32:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm222458785e9.18.2025.09.01.01.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:32:11 -0700 (PDT)
Message-ID: <620f01b4-8a6c-4dac-bcdd-7c48f5cd87f2@redhat.com>
Date: Mon, 1 Sep 2025 10:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, kas@kernel.org,
 willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250901074817.73012-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901074817.73012-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 09:48, Dev Jain wrote:
> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since, apart from any non-writable
> memory mapped by the application, there are a lot of non-writable VMAs
> which will benefit from collapsing - the VMAs of the executable, those
> of the glibc, vvar and vdso, which won't be unmapped during the lifetime
> of the process, as opposed to other VMAs which maybe unmapped.

Are these anonymous folios? ("VMAs of the executable"), or is you description
misleading?

> Therefore,
> remove this restriction and allow khugepaged to collapse a VMA with
> arbitrary protections.
> 
> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user knows
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
> 
> I dug into the history of this and couldn't find any concrete reason of
> the current behaviour - [1] is the v1 of the original khugepaged patch
> which required all ptes to be writable. [2] is the v1 of the patch which
> changed this behaviour to require at least one pte to be writable. The
> closest thing I could find was: in response to [2], Kirill says in [3] -
> "As a side effect it will effectively allow collapse in PROT_READ vmas,
> right? I'm not convinced it's a good idea." (Although Kirill realizes in
> [4] that this was not the intention of the patch).
> 
> I can see performance improvements on mmtests run on an arm64 machine
> comparing with 6.17-rc2. (I) denotes statistically significant improvement,
> (R) denotes statistically significant regression (Please ignore the
> numbers in the middle column):

I once dug into that myself as well as part of

commit 1bafe96e89f056cb6e25d47451fb16aee2c7c4d0
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Apr 24 14:26:30 2024 +0200

     mm/khugepaged: replace page_mapcount() check by folio_likely_mapped_shared()

where I noted:

     Interestingly, khugepaged will only collapse an anonymous THP if at least
     one PTE is writable.  After fork(), that means that something (usually a
     page fault) populated at least a single exclusive anonymous THP in that
     PMD range.
     
The problem I was concerned with (also documented in that patch) should no
longer apply ever since we changed how folio_maybe_mapped_shared() operates.

So yes, I don't see a good reason to fail on R/O PTEs

> 
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> | mmtests/hackbench                  | process-pipes-1 (seconds)                                |                 0.145 |                   -0.06% |
> |                                    | process-pipes-4 (seconds)                                |                0.4335 |                   -0.27% |
> |                                    | process-pipes-7 (seconds)                                |                 0.823 |              (I) -12.13% |
> |                                    | process-pipes-12 (seconds)                               |    1.3538333333333334 |               (I) -5.32% |
> |                                    | process-pipes-21 (seconds)                               |    1.8971666666666664 |               (I) -2.87% |
> |                                    | process-pipes-30 (seconds)                               |    2.5023333333333335 |               (I) -3.39% |
> |                                    | process-pipes-48 (seconds)                               |                3.4305 |               (I) -5.65% |
> |                                    | process-pipes-79 (seconds)                               |     4.245833333333334 |               (I) -6.74% |
> |                                    | process-pipes-110 (seconds)                              |     5.114833333333333 |               (I) -6.26% |
> |                                    | process-pipes-141 (seconds)                              |                6.1885 |               (I) -4.99% |
> |                                    | process-pipes-172 (seconds)                              |     7.231833333333334 |               (I) -4.45% |
> |                                    | process-pipes-203 (seconds)                              |     8.393166666666668 |               (I) -3.65% |
> |                                    | process-pipes-234 (seconds)                              |     9.487499999999999 |               (I) -3.45% |
> |                                    | process-pipes-256 (seconds)                              |    10.316166666666666 |               (I) -3.47% |
> |                                    | process-sockets-1 (seconds)                              |                 0.289 |                    2.13% |
> |                                    | process-sockets-4 (seconds)                              |    0.7596666666666666 |                    1.02% |
> |                                    | process-sockets-7 (seconds)                              |    1.1663333333333334 |                   -0.26% |
> |                                    | process-sockets-12 (seconds)                             |    1.8641666666666665 |                   -1.24% |
> |                                    | process-sockets-21 (seconds)                             |    3.0773333333333333 |                    0.01% |
> |                                    | process-sockets-30 (seconds)                             |                4.2405 |                   -0.15% |
> |                                    | process-sockets-48 (seconds)                             |     6.459666666666666 |                    0.15% |
> |                                    | process-sockets-79 (seconds)                             |    10.156833333333333 |                    1.45% |
> |                                    | process-sockets-110 (seconds)                            |    14.317833333333333 |                   -1.64% |
> |                                    | process-sockets-141 (seconds)                            |               20.8735 |               (I) -4.27% |
> |                                    | process-sockets-172 (seconds)                            |    26.205333333333332 |                    0.30% |
> |                                    | process-sockets-203 (seconds)                            |    31.298000000000002 |                   -1.71% |
> |                                    | process-sockets-234 (seconds)                            |    36.104000000000006 |                   -1.94% |
> |                                    | process-sockets-256 (seconds)                            |     39.44016666666667 |                   -0.71% |
> |                                    | thread-pipes-1 (seconds)                                 |   0.17550000000000002 |                    0.66% |
> |                                    | thread-pipes-4 (seconds)                                 |   0.44716666666666666 |                    1.66% |
> |                                    | thread-pipes-7 (seconds)                                 |                0.7345 |                   -0.17% |
> |                                    | thread-pipes-12 (seconds)                                |     1.405833333333333 |               (I) -4.12% |
> |                                    | thread-pipes-21 (seconds)                                |    2.0113333333333334 |               (I) -2.13% |
> |                                    | thread-pipes-30 (seconds)                                |    2.6648333333333336 |               (I) -3.78% |
> |                                    | thread-pipes-48 (seconds)                                |    3.6341666666666668 |               (I) -5.77% |
> |                                    | thread-pipes-79 (seconds)                                |                4.4085 |               (I) -5.31% |
> |                                    | thread-pipes-110 (seconds)                               |     5.374666666666666 |               (I) -6.12% |
> |                                    | thread-pipes-141 (seconds)                               |     6.385666666666666 |               (I) -4.00% |
> |                                    | thread-pipes-172 (seconds)                               |     7.403000000000001 |               (I) -3.01% |
> |                                    | thread-pipes-203 (seconds)                               |     8.570333333333332 |               (I) -2.62% |
> |                                    | thread-pipes-234 (seconds)                               |     9.719166666666666 |               (I) -2.00% |
> |                                    | thread-pipes-256 (seconds)                               |    10.552833333333334 |               (I) -2.30% |
> |                                    | thread-sockets-1 (seconds)                               |                0.3065 |                (R) 2.39% |
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> 
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> | mmtests/sysbench-mutex             | sysbenchmutex-1 (usec)                                   |    194.38333333333333 |                   -0.02% |
> |                                    | sysbenchmutex-4 (usec)                                   |               200.875 |                   -0.02% |
> |                                    | sysbenchmutex-7 (usec)                                   |    201.23000000000002 |                    0.00% |
> |                                    | sysbenchmutex-12 (usec)                                  |    201.77666666666664 |                    0.12% |
> |                                    | sysbenchmutex-21 (usec)                                  |                203.03 |                   -0.40% |
> |                                    | sysbenchmutex-30 (usec)                                  |               203.285 |                    0.08% |
> |                                    | sysbenchmutex-48 (usec)                                  |    231.30000000000004 |                    2.59% |
> |                                    | sysbenchmutex-79 (usec)                                  |               362.075 |                   -0.80% |
> |                                    | sysbenchmutex-110 (usec)                                 |     516.8233333333334 |                   -3.87% |
> |                                    | sysbenchmutex-128 (usec)                                 |     593.3533333333334 |               (I) -4.46% |
> +------------------------------------+----------------------------------------------------------+-----------------------+--------------------------+
> 
> No regressions were observed with mm-selftests.
> 
> [1] https://lore.kernel.org/all/679861e2e81b32a0ae08.1264054854@v2.random/
> [2] https://lore.kernel.org/all/1421999256-3881-1-git-send-email-ebru.akagunduz@gmail.com/
> [3] https://lore.kernel.org/all/20150123113701.GB5975@node.dhcp.inet.fi/
> [4] https://lore.kernel.org/all/20150123155802.GA7011@node.dhcp.inet.fi/
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> Based on mm-new.
> 
> Not very sure of the tracing parts which this patch changes. I have kept
> the writable portion for the tracing to maintain backward compat, just
> dropped it as a collapse condition.
> 
>   include/trace/events/huge_memory.h |  2 +-
>   mm/khugepaged.c                    | 11 +++--------
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 2305df6cb485..f2472c1c132a 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -19,7 +19,7 @@
>   	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
>   	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
>   	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
> -	EM( SCAN_PAGE_RO,		"no_writable_page")		\
> +	EM( SCAN_PAGE_RO,		"no_writable_page") /* deprecated */	\
>   	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
>   	EM( SCAN_PAGE_NULL,		"page_null")			\
>   	EM( SCAN_SCAN_ABORT,		"scan_aborted")			\
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..5ef8482597a9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -39,7 +39,7 @@ enum scan_result {
>   	SCAN_PTE_NON_PRESENT,
>   	SCAN_PTE_UFFD_WP,
>   	SCAN_PTE_MAPPED_HUGEPAGE,
> -	SCAN_PAGE_RO,
> +	SCAN_PAGE_RO,	/* deprecated */

Why can't we remove that completely.


-- 
Cheers

David / dhildenb


