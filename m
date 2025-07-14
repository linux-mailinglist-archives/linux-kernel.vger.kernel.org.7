Return-Path: <linux-kernel+bounces-729298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2AEB0348E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DC93B1D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20F1DC985;
	Mon, 14 Jul 2025 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P2F7vEPi"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4117262A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460768; cv=none; b=FNIxd6SGZcvPXA34upr5U/wmRGB7romLYdoWAxK4H0MZAIrDwEkj+GyD+pjrZsbJ0g2VYv2E+Oj8J5ayLUMxbxlZe5B7fxIyKVjw4ZqXSxDGufyIjSN+KuLIWq28Z7/7ZpB5thlMUJ0o1vvLBAnjse2oyNlu2OVKm9pZ9G21ANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460768; c=relaxed/simple;
	bh=ni5zcuqRoksJ5tvFWSNpfWmWVVf9OmDJhWVtruuK2K4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tH4KtAIbE9L2u8rjFLTSNVIh9iLuXoQt86Qi4rMnlFqClV882rQkujlFkv4nTBFbKQ2ur0cT2AMf5+wUcOg22pFtJ9ecLE4UvcmqqEyTrSR183w/ha9ztmSUHoNJzpQvX2fdooQew0qWrVygTIwCbNsZmlYczjZVKPdx0RdFY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P2F7vEPi; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752460757; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jIfioZUBHoGFsP7FKsRJDuXJU5OENyKeKcZrcXTzBD4=;
	b=P2F7vEPi0x+hBetsOLDd+mFQTbBGbLpMNBh0beDLOkwwsqVuIl8DWsr5B+02eaQs0SERssMUPQ+o9oKbRAT+uvJErl+QygDMo91IyegxLOZoWsqaedHAWCoqDbAKYPSuh1x8rq4ghOmVhHdcYo6CJLh7fcAN7b+DWCtShHe7NKU=
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WioG7Og_1752460754 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 10:39:15 +0800
Message-ID: <d12fbf3f-3389-429a-b636-849ce611f5a3@linux.alibaba.com>
Date: Mon, 14 Jul 2025 10:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] mm/shmem, swap: rework swap entry and index
 calculation for large swapin
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-8-ryncsn@gmail.com>
 <6d6feb41-5cdd-4591-8e19-d9c247e16fcb@linux.alibaba.com>
In-Reply-To: <6d6feb41-5cdd-4591-8e19-d9c247e16fcb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/11 14:36, Baolin Wang wrote:
> 
> 
> On 2025/7/10 11:37, Kairui Song wrote:
>> From: Kairui Song <kasong@tencent.com>
>>
>> Instead of calculating the swap entry differently in different swapin
>> paths, calculate it early before the swap cache lookup and use that
>> for the lookup and later swapin. And after swapin have brought a folio,
>> simply round it down against the size of the folio.
>>
>> This is simple and effective enough to verify the swap value. A folio's
>> swap entry is always aligned by its size. Any kind of parallel split or
>> race is acceptable because the final shmem_add_to_page_cache ensures
>> that all entries covered by the folio are correct, and thus there
>> will be no data corruption.
>>
>> This also prevents false positive cache lookup. If a shmem read
>> request's index points to the middle of a large swap entry,
>> previously, shmem will try the swap cache lookup using the large swap
>> entry's starting value (which is the first sub swap entry of this
>> large entry). This will lead to false positive lookup results if only
>> the first few swap entries are cached but the actual requested swap
>> entry pointed by the index is uncached. This is not a rare event,
>> as swap readahead always tries to cache order 0 folios when possible.
>>
>> And this shouldn't cause any increased repeated faults. Instead, no
>> matter how the shmem mapping is split in parallel, as long as the
>> mapping still contains the right entries, the swapin will succeed.
>>
>> The final object size and stack usage are also reduced due to
>> simplified code:
>>
>> ./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
>> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-233 (-233)
>> Function                                     old     new   delta
>> shmem_swapin_folio                          4040    3807    -233
>> Total: Before=33152, After=32919, chg -0.70%
>>
>> Stack usage (Before vs After):
>> mm/shmem.c:2277:12:shmem_swapin_folio   264     static
>> mm/shmem.c:2277:12:shmem_swapin_folio   256     static
>>
>> And while at it, round down the index too if swap entry is round down.
>> The index is used either for folio reallocation or confirming the
>> mapping content. In either case, it should be aligned with the swap
>> folio.
>>
>> Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> Overall, I don't see any obvious issues, but please give me some time to 
> run some tests and then get back to you. Thanks.

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>


