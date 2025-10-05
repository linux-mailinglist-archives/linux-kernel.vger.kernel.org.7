Return-Path: <linux-kernel+bounces-842202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7BBB935E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C112D3A51B7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 01:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C71527B4;
	Sun,  5 Oct 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgFc7RHK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729735963
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759626316; cv=none; b=CGD520ZXKYRy98PgX5H/LmTYGXZzRBbn7RT6M+963hMypq6x8jb5MtMTn+GYQF973uAPJI1mmEFJIaqnbucEkdaVYj5h6CYipUryr29rQszrGhQ/rolcBx4EgwTH8cUNgYBPP7UMVXKJtHYir0816BGhVCWKf3QmqEbQlZbEmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759626316; c=relaxed/simple;
	bh=xaGPLxHO60K3uqiewy7ePzmU5lzkODzUUgz1CREMDZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qat0w+ZUlS//LO1z7fu28+D3vEUJGZLyvAT7/+yKmhZ9IVFyPeCnzz0Lj1lObIoS/f73UkU2aHfAQZ0G/dgEY4vlB1nYvvhSDKAXoNRphRXKZ4IYIfxo/wK4XVSTilbhXXN+HQS+ighXUkecAlxtHoObvOKlJdgb6Fs3byfYjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgFc7RHK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so4718678a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759626313; x=1760231113; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxmchDTPhZsqpU6gIxr0BxrKIvUH4UuMs0rK+gl2l/I=;
        b=EgFc7RHK12FcmQqtWn5QeqHCJrVNTftZ6LY14jlnWlhABmgIqOXNeJXBu0WKuHdutv
         Bbeg316zsr0L/1F985tj0z51T4jlP9zGGfW4gU528EFIkSRUtIKoPhOQolzud9xgNDmB
         MP8w568tJMk6JPTePC3FoI7gfi9gIQLRN+UK1v/8g8HSSehEEDk2z0D9hLXkBofL7MFz
         oCR/WzTDTfrpsH4toce+uuDAx00WuZRaZpLCEmmwH1xokjgghbj88EER82hEd8ZHfomc
         mXdwmUA97fT4Kqw8j5d5nzYUJFbzn/cSCbrVpuOoMlGE7lMHTFi09THlM8UCnku3qHy3
         Oy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759626313; x=1760231113;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxmchDTPhZsqpU6gIxr0BxrKIvUH4UuMs0rK+gl2l/I=;
        b=xCcY5GHcBTxS5pJU+CjwF5g13RNqvZ/yXKMrnCY+MNEjnVHF7m2/dmQDSym66zp8pc
         OvYfKJwYdlO0o0OLG0G1NFzODU/nCxPOA8HlUQsJorwBm3+bGN/c4Su5oSzo2IuLtIk4
         rMzDrWts9xviw7Yh4QoESWdxPscuwbCl4UVUFykeiQqmTfxoZzZSlRa0+vGnUCID7nmX
         QNaXfGjJd/LPtwBVR0HSmW/iuuQMKZQrP1RnfvGsUCzbyTH+zsdr9lMN2QVzN2WPFqGi
         soA1TdN/i3uyqfZIiYwKXKtsXkCijGMz6OIX0lbvUIzyPiShvduKFEXaPIiLgOksjMvc
         gyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HbhnxGrQhAgVY1Eco/6cJBmI7BBDViewKJ7iTkMdJA9bdbhmtBkfRITRc2F8hYC1EkPF4pyFb6s1MzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMSxFuyniAPCjn1e5DNaUkZfwtLbFE1KF6MyKBbfSvsx+6WZ9
	yvL96Rlg8NwJgO6xt4pd/UQUTlzEdikBFjXU1IYS4WdxxJlJbdrUznQu
X-Gm-Gg: ASbGncviHx+e2f+RRNstVz2w/u1pP2LZ1hxoasa9wfJA74TzVjiP47miZ6VedW+fk/M
	6nZauc9JpqZPNRcGc44tcqt0r2JXmocOreHhotS570mEeczfgcqSRSEtE/36/z96qfyReF1EGnp
	xsyZakwUieh+C74EYzQAyLwuag+7934YIBDNmzU6tWLWUSH1drjSuHYAghCu3dkjrYKrU7+m6u+
	SsmyhZ+lmODqUVoqsb4h72imxjvHoECD+yOh4cLNz05clkKpyGAF4GurYoJnva4q/nF3z1/gBmB
	WLhnqb2J5SI0WKffWSccZ8UXuJ2ogCa6vAHSPwn2WPgrFAHfM+5oPa+0uVwmmpxm9sJCSi11HVi
	BM8NMOz/7JXhPX+kGSic9UBNfgrO2OeHt1gdJ8Z3PlMDBKcxRcgcpyHdvI7jrRdmDQzE=
X-Google-Smtp-Source: AGHT+IEJ+DV6wCXDb2a3k9uAeEgMCr1cVjIoxxlb4UYBMuoIs2Zd0lJV3rJ10CH8141p7yP2iS38cA==
X-Received: by 2002:a17:907:2da6:b0:b2b:59b5:ae38 with SMTP id a640c23a62f3a-b49c2761ad2mr1100209266b.40.1759626312428;
        Sat, 04 Oct 2025 18:05:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm794414466b.63.2025.10.04.18.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Oct 2025 18:05:11 -0700 (PDT)
Date: Sun, 5 Oct 2025 01:05:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
	ioworker0@gmail.com, kirill@shutemov.name,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
	ziy@nvidia.com
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <20251005010511.ysek2nqojebqngf3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 01, 2025 at 06:05:57PM +0800, Lance Yang wrote:
>
>
>On 2025/10/1 16:54, Wei Yang wrote:
>> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>> > From: Lance Yang <lance.yang@linux.dev>
>> > 
>> > Currently, special non-swap entries (like migration, hwpoison, or PTE
>> > markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> > failures deep in the swap-in logic.
>> > 
>> > hpage_collapse_scan_pmd()
>> > `- collapse_huge_page()
>> >      `- __collapse_huge_page_swapin() -> fails!
>> > 
>> > As David suggested[1], this patch skips any such non-swap entries
>> > early. If any one is found, the scan is aborted immediately with the
>> > SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> > work.
>> > 
>> > [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>> > [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>> > 
>> > Suggested-by: David Hildenbrand <david@redhat.com>
>> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> > ---
>> > v1 -> v2:
>> > - Skip all non-present entries except swap entries (per David) thanks!
>> > - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>> > 
>> > mm/khugepaged.c | 32 ++++++++++++++++++--------------
>> > 1 file changed, 18 insertions(+), 14 deletions(-)
>> > 
>> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > index 7ab2d1a42df3..d0957648db19 100644
>> > --- a/mm/khugepaged.c
>> > +++ b/mm/khugepaged.c
>> > @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> > 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>> > 	     _pte++, addr += PAGE_SIZE) {
>> > 		pte_t pteval = ptep_get(_pte);
>> > -		if (is_swap_pte(pteval)) {
>> 
>> It looks is_swap_pte() is mis-leading?
>
>Hmm.. not to me, IMO. is_swap_pte() just means:
>
>!pte_none(pte) && !pte_present(pte)
>

Maybe it has some reason.

I took another look into __collapse_huge_page_swapin(), which just check
is_swap_pte() before do_swap_page().

We have filtered non-swap entries in hpage_collapse_scan_pmd(), but we drop
mmap lock before isolation. This looks we may have a chance to get non-swap
entry.

Do you think it is reasonable to add a non_swap_entry() check before
do_swap_page()?

-- 
Wei Yang
Help you, Help me

