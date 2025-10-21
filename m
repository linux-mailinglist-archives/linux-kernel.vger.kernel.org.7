Return-Path: <linux-kernel+bounces-862492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBEBF5748
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985D4467E35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E32ABFD;
	Tue, 21 Oct 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHY8n5gv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6A329C54
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038087; cv=none; b=QD98LGAv0+jxLVmtkD+3gKHCRXOsoJSxMUskG0lp25XwioFCBpTkuaT4+fC60GEG+9WI/iYEKDsoSP+G2NfsM3az6Yz3aJxYEqaCu46sPwYxoaDYiRDhtj/qIQret1AW1a5rMdGjyucjpafrGfNlK6J5OqUHFQr5zv3ISYAWDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038087; c=relaxed/simple;
	bh=kJ+e2CoejHpCt76aNhaFcNnodSw5gyp4/sICV+z8gQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRXNGlMDiKQM0igwk9ZGQvCmNFR8C3LyNFNv13LXAIHDsuQ8zmL41DRksZ31ZEoop7RN5EDOPdd2QLYE3XMARQNSCOkMroonVBHOVA3hx6ukH0wzO1mf0cIzA6o8o7p4OenEhZGogJW2t6HxTjC1uJ1E8k61Yi5rOMVtwIWRPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHY8n5gv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b463f986f80so1032245766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038084; x=1761642884; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jucTygVBOurdtHPEkVo9cYmOwKMehtOeQ9jBrxiOFXs=;
        b=MHY8n5gvoYUecy8syDRM4gjQ2/pb7GIVza8Tdu7i4A0ULw2EDCqIAYUhWMfah/DaCc
         e9xJcGCcvxASis4bTobl0A+q6f7g7uCHST+ubt2+pmyqhTf2BtNcQQJBStM1BZQdsm3Y
         6UPF0eexYCG2MRtx2/ruWRFUtLu2YONQTBVe9eNb9xy0g7W3nh9Ftp2Ly8Yotbsxv6bn
         DmjljclYpIT2nAfM5GebAKtvCM0p1/z1YX/l0ACYTPSnaHkAhFgCS3lTzwLEQbbsTRoU
         f+1uxSbC4BkmloaITlHNec4oELOpqbzuPn/0hO5CdmijRWkTwr2ORg+53X6yNlodE69o
         6LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038084; x=1761642884;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jucTygVBOurdtHPEkVo9cYmOwKMehtOeQ9jBrxiOFXs=;
        b=a0K2ieSTxhW/tvwSI8a43yvQNwdtFoNTc/sRGmlDvN67Zi3X3pMD0k+/uJuKIpJu9T
         1bKeORqUhxIgAgdOMIJvvRHQ5TVQXbLbIkwFfAsYstJvstrBeZTCNxMMKXtyLn2UDI68
         ZnBs0Mzp4DchU8pI3ACQgXT/2f3i75u7fmFsH7nE9nzNQADw+uGMlkuJeDwpbJ80DwLW
         +EsqimeOc0BkN/JKfoihar1NRZHUdywERhC6xPHQw4j3Nq1UXZxpaKFbY8Axfq85juZt
         L3mlbwqcoUo57pk29NsCvyqI0o/NWw7BiGk98MMkT0hg4dC6VBpYuYN9iA86fDT7lBRP
         WB4A==
X-Forwarded-Encrypted: i=1; AJvYcCXqGyvGFK+YWGtHid84uQShixYgI5PehNlFRthvVJhJLb5dZX6Ja2vplvhzNL/yluxO7ZC9xSJjXC7Utl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq359UEfx+Cv2T/WeSB6JNqfcvZ4pHkmXKLn90qnq9sVNmSD0n
	9upvXuAos2gNsDPYV0ZqVrohGBM4u5iNSrJY+N6DjSRmw9x1WiX2l/M/
X-Gm-Gg: ASbGnct/KSHtO0OhTUq1SKCL6YPTUDjcrEaB9lb8Wm/UA8a2HWR4ne/FfJLSZFxO3sq
	BqW2jes8fc3m/P3mnraSBct58EQAFy/OoCrfcNvN8Hpu44eU4nShi+ooUgGPmewwwl2SWF/p74H
	rE5a09+yGlEM8F9Cn/Lf3bulKPEqChcb8KVRFMmeQaCHsjXhI2gM+C1CBIeVNxqfH5YdQ8X7Qj6
	4aGoWMncrEia460BrWj7VozpRWtiEfuF1KU1wepKig8hZEOFHuliOWn3gUbHL/+xXe4qE8BxBLs
	CJ1eqRJc0VpxG5UmJmGN/U5FiFGhBFvxR1Iy9Zzc/kTxhX7RoqVIfsXru+iSfVuro2AFLTBbMOh
	ghF7Gc3coGFE4Mq5A2l63dSBCxp6oHYYdgVXvgkJIRMViY3hRNdvJqruYruBHmhOqKdZLu0DuUF
	s=
X-Google-Smtp-Source: AGHT+IFMouRjEsRqn1SVbkPDaqrl+sBgGU6MSu2a+JydYjBrrEpOKFPhPIgQPYv2kKpjyKDWdDlPeQ==
X-Received: by 2002:a17:907:7f8a:b0:b3e:151b:849b with SMTP id a640c23a62f3a-b647493fa43mr2071260566b.33.1761038084113;
        Tue, 21 Oct 2025 02:14:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6aaf93a32asm573319066b.51.2025.10.21.02.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Oct 2025 02:14:43 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:14:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc
Message-ID: <20251021091443.5ggfmvl5jwyknjnv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <20251021012533.56rdl6v76plkw4nl@master>
 <E787AD03-DC67-4B5C-8BF6-C79F3C583D00@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E787AD03-DC67-4B5C-8BF6-C79F3C583D00@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 20, 2025 at 09:28:18PM -0400, Zi Yan wrote:
>On 20 Oct 2025, at 21:25, Wei Yang wrote:
>
>> On Mon, Oct 20, 2025 at 05:08:16PM -0400, Gregory Price wrote:
>>> We presently skip regions with hugepages entirely when trying to do
>>> contiguous page allocation.  Instead, if hugepage migration is enabled,
>>> consider regions with hugepages smaller than the requested allocation.
>>>
>>> Compaction `isolate_migrate_pages_block()` already expects requests
>>
>> isolate_migratepages_block() ?
>>
>>> with hugepages to originate from alloc_contig, and hugetlb code also
>>> does a migratable check when isolating in `folio_isolate_hugetlb()`.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>> ---
>>> mm/page_alloc.c | 15 +++++++++++++--
>>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 600d9e981c23..da2e65bf63e3 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>>> 		if (PageReserved(page))
>>> 			return false;
>>>
>>> -		if (PageHuge(page))
>>> -			return false;
>>> +		if (PageHuge(page)) {
>>> +			unsigned int order;
>>> +
>>> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
>>> +				return false;
>>> +
>>> +			/* Don't consider moving same size/larger pages */
>>> +			page = compound_head(page);
>>> +			order = compound_order(page);
>>
>> How about using folio_large_order(page_folio(page)) ?
>
>See the discussion at https://lore.kernel.org/linux-mm/609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com/ about reading folio order without locking.
>

I took another look at this.

The above code is expanded to:

  page = _compound_head(page);
  order = compound_order(page);
      folio = page;
      test_bit(PG_head, &folio->flags.f);
      return folio_large_order(folio);

If we use

  order = folio_order(page_folio(page))

It is expanded to:

  folio = _compound_head(page);
  folio_test_large(folio)
      folio_test_head(folio)
          test_bit(PG_head, &folio->flags.f)
  return folio_large_order(folio);

These two seems expanded to the same code.

Maybe we can use folio_order() here?

>>
>>> +			if ((order >= MAX_PAGE_ORDER) ||
>>> +			    (nr_pages < (1 << order)))
>>> +				return false;
>>> +		}
>>> 	}
>>> 	return true;
>>> }
>>> -- 
>>> 2.51.0
>>>
>>
>> Generally LGTM
>>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>>
>> -- 
>> Wei Yang
>> Help you, Help me
>
>
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

