Return-Path: <linux-kernel+bounces-775266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E7B2BD51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEA1171201
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399032254F;
	Tue, 19 Aug 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B70BivWy"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72631B13E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595379; cv=none; b=GCsnRi03B5HfO9svsJ104MJvTSebpAu6RNOEufKKAS416WAqCT0LsDQ65jRjdnbuVbJ+aTAn6OIafogkiHpe1V+6gDuPNvgtZFVpN4uXWSRgIh56C2yUo6aXhqWqR9J/5zhYLPsH5xdV+tXzwYWTe2IjmQ93y3bJpCrlJMQrAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595379; c=relaxed/simple;
	bh=UXFwtf2p/003AReVcccluZVWMM0ZZ/Y6H3ApM7M7xhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH/aPEJOosfR2pNqdYUKcoYqtbS//iwDQSAwM14LrxoqMeqRGI68QMvytRbHxsQSijju3EqCOxdectkNU9aV/wAT+72s4a66x1FQUXJ6tkAseFMD4S937mXARhiBQVA/y4c0PuIFERBFCPxrekfJ+zIKWtnbrhXj1m+wD5xog+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B70BivWy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso5901039a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755595376; x=1756200176; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PiTmIvcXIWmnCk2bi7fdSkP9CO3hr2liu1TEw3WtOs=;
        b=B70BivWyTX6wtq3DKqUHw1q191QD26jeX8OdZwtRrebogcQ61jXa7MNQ9ezNFnzx/F
         clggljinGE1ZInurAOuM0DsWcfQrXY+f8YAS1qfYToG3i2oslMQXf+J3LyFSYH8ne6Gq
         0efHzU3RDg+VIDwACq3ftkHGuzijE/pFEwGgs2DiPQIHiwvvQf35apZ7HBiqewobJZyW
         UOQ/ZYBKcxQSpltMjOQ6gknOGInBPdcN1zC+2I9KSn1H7sViOLBW1hpGT7IyKbvH34uc
         A0UvipOXKD5iuLohpgqfcRG+5cMUPqFOwgN7xF2kSSeR33ex4UrS2NUCaNfZK2jUCeQA
         Sw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595376; x=1756200176;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PiTmIvcXIWmnCk2bi7fdSkP9CO3hr2liu1TEw3WtOs=;
        b=LJbZnP4UZjtgww/ONWBPo+Mb87+MdRKo7aKLXyPQH6hZoaw+BAv1TMN5HCGUgLzuBM
         8/4uXciCTgM6doJkR3eA4puh1urWZASJMSfr3fJlP7l+Z8pne8vyPrv9I6J9pZueM+rI
         KL4V1bDwGY8FLCZwVyE6LlOEX1rmhdqh1tKWs1Vs7DwJtMttNfPw186NVFYmP8CC9wbl
         6zgMVD7l+8tbSBMvdSgLGuyNIHSPtf4PcilSpzIhoa1CI3OE/OTSBBHwkEmE9imsAjRL
         SbocsYqFBVSGXnKPno03VMc/fxYy+CxL94b1J+I2KOryly+RRiD8/jQYDjtpTcmMjMg8
         pIAw==
X-Forwarded-Encrypted: i=1; AJvYcCW3W+ODy2Yu8NE/VyN8ZXmaWgrQhPFESXBxJySSlTJdChZLkdeWiPRiJ33YFjGdehcjvXRojJyfaGH3LaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgw+EA+e4DjPjB8zRtyUF2BavkaJ07pMyzOZd1+hD890Wh0qYq
	QBqJRJdMSSWDRvxJNaVOBSa6UvurUxc2D3ieTwhS959Q/6gutub3XDvm
X-Gm-Gg: ASbGncuztovOgUlbCLx35yh8MH1szmUPOL6/5jxxaXGk+eh5StgdcNtxaqKXjNhFu8K
	fwgM95sR0g/40i4lIp37XL+CIfRD4Viy/rpYNbY5SnFQABqxaMGsWfeMwo50q3ZilCvccWvI9Jj
	alShr73WYEQ+UlatqiYQr5YMx3hNUMpl5396xTpE7rROeLsqrEVZOpAaM5CebmNUY9isKtWuD1c
	j+I/HhetRhk8HA28cqW+o8rINtveI+zTqDmR/Egg3fHPSTncvo/2UqMIiesCTmr42mY2NgnbI2x
	39XuAvMNFv3GtO5QkGEXZORThFQRanjMkCEn53UdsPKp+5kBxvx+A8S+lx/WDlcJRryfy0QO64J
	pUft/hxc6jYymWBm7J0Z/PA==
X-Google-Smtp-Source: AGHT+IGWpnAEgDV2y4INDQK6XxsdDqFMGmNPUYQ0xXd1Cp2WxE73D3UX/rFS8w2LlQ8JvhzNRZ03EA==
X-Received: by 2002:a05:6402:3494:b0:618:3a9d:53da with SMTP id 4fb4d7f45d1cf-61a7e765e7bmr1296928a12.31.1755595375783;
        Tue, 19 Aug 2025 02:22:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a761f2599sm1333486a12.5.2025.08.19.02.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 02:22:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:22:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/4] mm/mm_init: drop deferred_init_maxorder()
Message-ID: <20250819092254.cddlg6npwl75fvbn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-4-rppt@kernel.org>
 <408d7eaa-5aea-4490-9fd0-978c4eb94d32@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408d7eaa-5aea-4490-9fd0-978c4eb94d32@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 19, 2025 at 09:54:22AM +0200, David Hildenbrand wrote:
>> -static unsigned long __init
>> -deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>> -			   struct zone *zone)
>> -{
>> -	unsigned long nr_pages = 0;
>> -	unsigned long spfn, epfn;
>> -	u64 i = 0;
>> +		while (spfn < epfn) {
>> +			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
>> +			unsigned long chunk_end = min(mo_pfn, epfn);
>> -	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
>> +			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
>> +			deferred_free_pages(spfn, chunk_end - spfn);
>
>
>I assume the expectation is that all PFNs in the start_pfn -> end_pfn range
>will go to this zone, correct?

I think so.

defer_init only apply to the highest zone in one node.

>
>-- 
>Cheers
>
>David / dhildenb
>

-- 
Wei Yang
Help you, Help me

