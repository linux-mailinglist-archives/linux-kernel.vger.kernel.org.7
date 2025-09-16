Return-Path: <linux-kernel+bounces-818520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD866B592D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455751BC66A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132E2BEC42;
	Tue, 16 Sep 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0dh7ZFQ"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E72BE7B2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016772; cv=none; b=JNMP87wQlYYstoVFe07BTP/l5HuDmcUQjVMttMb93cOrCsPS92L4lDoV2t0ZZEtuBqD54cwwul5AIA4gz9HZivHvX9UUQPwhrJUttuEWtlK1fRgzk2Zb3ZSc0NX3D1PqTPypD7tey1E3ud+i36GotCiJI/WDCO/vzVDQbFtVCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016772; c=relaxed/simple;
	bh=9c3k3xekqUi8N0YUCZTW+qKYY5ND9Vk3/45+et8JTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HL7R4SLKBQQkPKLSijau/h1R6HpOR7cPd1GDpebV2MhUDJ6b4dGK3anPQV4M4opbm20eMZrC/KmWXxvqUjAZ+owaxum0ODY/TvNEgpiHzm72Aicp/rGB3F/JZu7+5M1FBD0v+lTYHFpJB/WVoz+h+WwvKS40I19WTYJdLN7ksxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0dh7ZFQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e75ba095-8d46-44ec-81d1-fed682ff9ea3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758016767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/74KktArckX7J8R2a2TYA4SkdsC//wm2zUbZ/9vpR8=;
	b=d0dh7ZFQbUyeJZdVf7kyPIooDTe6AsbGuxuvJ9FbHYHYw8obeV7cLaNZ3GZIliZoEIU7Iv
	mkf4NPBSbfm2QryTtKxRtgzgcd66QAgfVI9kdyzQic0by6muvFPPA0Yo5QUiaCQMudOQqH
	XLJwkYoNLmzW3UioiLq1mWq3tQb9YIA=
Date: Tue, 16 Sep 2025 17:59:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kiryl Shutsemau <kirill@shutemov.name>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
 <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
 <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/16 17:39, Lorenzo Stoakes wrote:
> On Tue, Sep 16, 2025 at 10:29:11AM +0100, Kiryl Shutsemau wrote:
>> On Tue, Sep 16, 2025 at 02:21:26PM +0800, Lance Yang wrote:
>>> Users of mlock() expect low and predictable latency. THP collapse is a
>>> heavy operation that introduces exactly the kind of unpredictable delays
>>> they want to avoid. It has to unmap PTEs, copy data from the small folios
>>> to a new THP, and then remap the THP back to the PMD ;)
>>
>> Generally, we allow minor page faults into mlocked VMAs and avoid major.
>> This is minor page fault territory in my view.

Makes sense to me!

> 
> Hm, but we won't be causing minor faults via reclaim right, since they're
> not on any LRU?
> 
>>
>> Also it is very similar to what compaction does and we allow compaction
>> of mlocked VMA by default, unless sysctl vm.compact_unevictable_allowed
>> is set to zero.
> 
> This is a much stronger point.

Ah, indeed, the compaction analogy is quite strong here, thanks!

> 
> I think we are sometimes too vague as to what mlock() means in

Totally agree on too vague ;)

> totality. But given that we default allow compaction it seems sensible to
> keep this behaviour the same.
> 
> Unless you have a specific situation where this is problematic Lance?

Not a specific situation right now that would clearly make this problematic.

Anyway, I will drop this patch from the series.

Thanks again for all the feedback everyone!
Lance


