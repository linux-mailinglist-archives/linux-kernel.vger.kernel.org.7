Return-Path: <linux-kernel+bounces-807504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4FB4A545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E603BAAF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759C1E5207;
	Tue,  9 Sep 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJXsWSjQ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DE12CDA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406646; cv=none; b=TWxSj/NfixfR5gPKE9sT/CjQsD7glZP0KMC09EViqj2/GgrrK2PTNEaX8VZuE3UEFc+TWfYfJIeMivMgIsil+fUBYcJH9h+fp4iW6nSQuuZQzQR/8xLj0ObmBlRz+uC27VV4FYljvkudFKA1Vhx4AfkSVeHkhzWO08zeEXwqVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406646; c=relaxed/simple;
	bh=JPLDQsmT60bOnD3Qjr7KUuABgQpFakte+CC6435negc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smqwNTsZBF3Kc9/ts7/J2QjsVsuWiDPPVu4VNo1llRo3oPpP1UPXEeuxQrB0rD6dn90T6aZtf/zgBVcoUFAW3ZliD2Rm2+fZ5kncOOF7GUtHfqA2kqULJopTA5CWUKHhR1gUPxpJ9JUk7UaIEMem7V4r9gEF743v3NtQXl41Tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJXsWSjQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a88d32f-b94a-4955-818c-e0848241994d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757406641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io6XUAtRaEqzKt03f6FT8cXm/79xlUlznTttZ8UFs5o=;
	b=iJXsWSjQxOnAFV4/FTwlY3LbSXu5dqSYuGTp9o4932zyIK/o5NvSZVvHs6f9AKf4MhguLw
	MsBZlSpcM6G37WcNnytUaAYfThcNpVp6SCTnqxAaUlVkDXn+YzjdK4dEF2L6KAQKE5e6Lh
	NGBWe+6PKyoyYMkK8elIjoDU3fweJ+8=
Date: Tue, 9 Sep 2025 16:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
To: Oscar Salvador <osalvador@suse.de>, Hu Song <husong@kylinos.cn>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909074812.599030-1-husong@kylinos.cn>
 <aL_emHbGN3xA5i_c@localhost.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aL_emHbGN3xA5i_c@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/9 16:00, Oscar Salvador 写道:
> On Tue, Sep 09, 2025 at 03:48:11PM +0800, Hu Song wrote:
>> Use folio_nr_pages() helper instead of manual calculation (1 << order)
>> for better code readability and maintainability.
>>
>> Signed-off-by: Hu Song <husong@kylinos.cn>
>> ---
>>  mm/slub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index d257141896c9..eba25461641a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2719,7 +2719,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>>  {
>>  	struct folio *folio = slab_folio(slab);
>>  	int order = folio_order(folio);
>> -	int pages = 1 << order;
>> +	int pages = folio_nr_pages(folio);
> Sure nothing might happen, but I find a bit weird that folio_nr_pages()
> returns a 'long' and we store it in an 'int' type.
> And then sure we handle that to mm_account_reclaimed_pages() which gets
> 'unsigned long', but that's another story.
>
>  
Maybe also correct the int->unsigned long conversion.:)
>
-- 
Thanks,
Ye Liu


