Return-Path: <linux-kernel+bounces-810567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9DB51C79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D2161F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC0327A19;
	Wed, 10 Sep 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="MQ1jVJwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="biG+FHOs"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235B1A2C0B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519530; cv=none; b=av5X5Xd1/iUzpFK86Ovsbn0rr2hVv7qYa5ZusK2ZVa+EMNpU7d8B1joZIHYTZ10x6DumJKCGJe4ql/xawWhMpYwvVrMhv0IrpxBLZ6xFUiFb7XIDmD1XfF5TLxuBPWWnbZG/C6S/sU3F8iMo7D6N8eD+cAIIT9bTCqP6Cm33B5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519530; c=relaxed/simple;
	bh=DU5u50LviqOpNOHb+nJj7OHxRaLw1n7ssupT8NJfOD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUCZtoSg7W9MtCN0WLD6sbKM6mrz9YWEhsUrDaXPZe1n/fm3vCJrN9sGSvmhEIgQkJWT/QMPliCV15oosw9eU6vGP5UP0MHMJvf35sX5lAODfvS5W9s2g9Kw3ar1YppIFa6YJ3Lm/jgBRqnNJM9DgUkB+UTLAmKjpHrMTPRbe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com; spf=pass smtp.mailfrom=yadavpratyush.com; dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b=MQ1jVJwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=biG+FHOs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 71AE6EC0456;
	Wed, 10 Sep 2025 11:52:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757519527;
	 x=1757605927; bh=TisYwmvR90ER1jazweHvbvoeDDNC29k3gBI9kEQjEok=; b=
	MQ1jVJwOLKEK4TRtKuCZUWuuAQageX7JSvcKV/AAQjDLP1FOkBUGIxQeArtXOyvw
	RiCJOOQLE8dwH2yBZAmJUOZUH2cS8m0H8hQ0tq8RmBLEJ98dlLW+VO5WzwfTEiEp
	ZcHcL0j4TRgHRbzBPMVoXIN/TgUBSUkl0EwJIqNRU7bOY8hHPzRUQp5tomfYSYM4
	aaRy1m76V6CftjP7Er2hbHpueVeKDrzxiDB6gIEceqSRYYK3MlhkOMyHKszxkfLi
	RUbQ8ocKfpbnjZs4bPUh+x0Cqc6aVNmdHryM8Awp3jeJeLtIUlbZWLsONvCvHPyW
	mZCD/zorvOHIoYCH40mnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757519527; x=1757605927; bh=TisYwmvR90ER1jazweHvbvoeDDNC29k3gBI
	9kEQjEok=; b=biG+FHOsup8r5uP8IEey1OrJpI5629ob7gPzDpQqOAtxnhL3Zr0
	lAYHLmLmOnkk/ZFWAy4flV1Zywb3xJ/C9lu8b58qrFjRd1jGE0FnuxDKv1eLqzEC
	LdNQpk67UX6aieSLbuXzA1Vg/QFxHGWYD0Ncs9fWOg5ffSWPr+e2foIt7hOvmQzy
	iLlzxsge5Wr1zuVQhZZPD8cgQf80LhnC8Hn+wf2wU+wIA3OsFlc8DTwywa9Wv8MO
	sEfliZTWg+RaFEbiBvoEfwFRHJ48CPhT4kQMt6cZzi73U66cwxwe/KmU+RdG2VXD
	ivj6MGO/UgwX/gij06eXHRG+djGwjM9eu7A==
X-ME-Sender: <xms:pp7BaKOFqY52w3lZOybWzINO3ENFBHOBl4cBomOTthhrWe4PrdUqzQ>
    <xme:pp7BaHfg7LePI0HEfWmF70EegQxkrN3FIH16nDhz1Qs3U6sgN8W0Qp7GkMEZZEBcj
    yWK80xxSLGCsqAdFlU>
X-ME-Received: <xmr:pp7BaMy7WN_9-GXpOn0pRXi8Q9lVHX5GEN0I4gRAYoByjs7OssS_3SPKgmZPxv2wyT4IYbQ_d0nVYjLqZuQ-oN4ZEFZM_2LMeoJyu6JvhNyhs7e0IjPCTdEhtDBDylClO-gMWbLx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefrrhgrthihuhhs
    hhcujggruggrvhcuoehmvgeshigruggrvhhprhgrthihuhhshhdrtghomheqnecuggftrf
    grthhtvghrnhepleejgfdufeffuefhiefghfdugeegieejudelgedthfeuudffheeugfel
    hfevvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgvseihrggurghvphhrrghthihushhhrdgtohhmpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrd
    horhhgpdhrtghpthhtohepkhgvgigvtgeslhhishhtshdrihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjrghsohhnmhhiuhesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheptghhrhhishhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehprghshhgrrdhtrghtrghshhhinhesshholhgvvghn
    rdgtohhmpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:pp7BaE3RDLytsa2QtWwRt9RRI1nVOsBEmidFKrSV6h3zaLVCSt-7Iw>
    <xmx:pp7BaLfLXI8An1b0AqP9N5_8fMLlNdqhMGYiu_I6fX6GdOZu6vb0Cw>
    <xmx:pp7BaBW4-CrB3M9I16AqpIjPSXOniBsClKfdNAAulDJcszXWj21hbA>
    <xmx:pp7BaL9T2jEtjmUP7XxYzydsA-Me-77SLflDvRcsv8WP84tmxnRDrw>
    <xmx:p57BaIxU2zpoDgcYwn06gdAIZWSihVls11YMgzeC1z3eF4bswK9AsSHl>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:52:05 -0400 (EDT)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Chris Li <chrisl@kernel.org>,  Jason Miu
 <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <aMGc-ExhkqwAyY_C@casper.infradead.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
Date: Wed, 10 Sep 2025 17:52:04 +0200
Message-ID: <mafs08qimjoez.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025, Matthew Wilcox wrote:

> On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> +
>> +/*
>> + * KHO uses page->private, which is an unsigned long, to store page metadata.
>> + * Use it to store both the magic and the order.
>> + */
>> +union kho_page_info {
>> +	unsigned long page_private;
>> +	struct {
>> +		unsigned int order;
>> +		unsigned int magic;
>> +	};
>
> KHO is only supported on 64-bit?

Yes. Currently only x86_64 and ARM64. It is mainly for hypervisor live
update so there isn't much reason to support it on 32-bit platforms.

>
>> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>>  struct folio *kho_restore_folio(phys_addr_t phys)
>>  {
>>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> -	unsigned long order;
>> +	union kho_page_info info;
>>  
>>  	if (!page)
>>  		return NULL;
>>  
>> -	order = page->private;
>> -	if (order > MAX_PAGE_ORDER)
>> +	info.page_private = page->private;
>> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>>  		return NULL;
>>  
>> -	kho_restore_page(page, order);
>> +	kho_restore_page(page, info.order);
>>  	return page_folio(page);
>
> This all looks very confused.  Before your patch as well as after it.
> I don't see anything in the current KHO code that requires the
> phys_addr_t to be order-aligned.

Right, good point. I can send that as a follow up patch. But I think
this patch stands on its own without that fix too.

-- 
Regards,
Pratyush Yadav

