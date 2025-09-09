Return-Path: <linux-kernel+bounces-807570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2494B4A654
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A8A1886511
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1F27586C;
	Tue,  9 Sep 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oOIvQ+nC"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A092765C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408391; cv=none; b=fcn5zNHzfjpbecPqOHjZ3Th3tBN3pIqCLViH32ddgTDYaUBiHpoJDRyFzJBcDT7cSolYM8sdP/q4CThLdHiKetDCw0EYK2Surz0Eubjz+Qg58JfsUeMfE6pYpWE4TYu4z0S+bIpCRtVNb4YKL6wLrRoFnvf1FkvJ9TiZ4UM++4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408391; c=relaxed/simple;
	bh=Qo/cEJ57SA8YXbKVYlk+uYis5uYEPn6EkJIbUyroQJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txV20uE25OeaVJwR1xGnaYk14tp6ZGjtaIhF6eix7j0ZHGYMafsKYkR0TrsFVKPKfSs2cNV2O3NOp+CeHJU6lprNNXD7mTXPfKmhA810vJl/Dy4iagkQbUTzGbunSvxQlrTtLxtjz2/ORGKpvNmH+nW/nOma/4aFf6beTBj2F0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oOIvQ+nC; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e058c588-2fa3-4763-bcc2-06b6fb6eddab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757408386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nodJfdwVRCZvCTwxlV8y8NKQX/2+OTsfIaKMeqB1pag=;
	b=oOIvQ+nCSC2x2F2pS7Jyg0ZIIfLl6aCYpvEkCgZ+duQWJmTwWbXejf/fkr7OuqoNm9Hyk4
	XDMMp/A0pbZVBi4EW7bGZyoQMBsTqRc0gG69MRXIRgmtBM2fClA1F2Q2GNVSwFKoHiaNpP
	nFfIU64TyJK29E6p6s3yn8eBCuShoE8=
Date: Tue, 9 Sep 2025 16:59:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
To: Dev Jain <dev.jain@arm.com>, Hu Song <husong@kylinos.cn>,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909074812.599030-1-husong@kylinos.cn>
 <c880df01-3041-4af0-b4d1-167193e8e6af@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <c880df01-3041-4af0-b4d1-167193e8e6af@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/9 16:46, Dev Jain 写道:
>
> On 09/09/25 1:18 pm, Hu Song wrote:
>> Use folio_nr_pages() helper instead of manual calculation (1 << order)
>> for better code readability and maintainability.
>>
>> Signed-off-by: Hu Song <husong@kylinos.cn>
>> ---
>>   mm/slub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index d257141896c9..eba25461641a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2719,7 +2719,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>>   {
>>       struct folio *folio = slab_folio(slab);
>>       int order = folio_order(folio);
>> -    int pages = 1 << order;
>> +    int pages = folio_nr_pages(folio);
>>         __slab_clear_pfmemalloc(slab);
>>       folio->mapping = NULL;
>
> I don't know, the current version is more readable to me. We literally
> compute the order before, so we do a simple 1 << order. I'll leave it
> to the rest.
>
>
Is the reason for calculating 'order' first because it's needed later.
I suggest using folio_nr_pages to replace the calculation of pages,
unifying the retrieval of pages in the folio and also highlighting
the significance of folio_nr_pages.                                   

-- 
Thanks,
Ye Liu


