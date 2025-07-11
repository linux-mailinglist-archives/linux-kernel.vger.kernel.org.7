Return-Path: <linux-kernel+bounces-727005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3EB013D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834571C40769
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18851A08A3;
	Fri, 11 Jul 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CaaJbyoP"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FF1D7E4A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216118; cv=none; b=awTogRY+3PJU7hfjp0jqdWr0IbcoMLc08a8nMjuoZgbm6KvJlwfq0IbvSp2gwbf8NOikt/elwuOegrqHVRRcjQEFHOzhGw2S3VAY6X8Ad5yWKM4zLj4CjNk7oAwCBCZ21470ZKDbwf5n7cgUqW9qawq9vHqLckMbdA73BdHKj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216118; c=relaxed/simple;
	bh=TR4a22Aec0arZqdoKInZqVExLxMv7JPP1babqcNrkQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urLyJXRqvV7+NJ+2xg8fIPv8AIxYpPBdKJLGEg0aCazefWv8fSgvdjF1F92GB85sLEvIMM6R2TzlaKPB783SFERRjT4r/wuMpjrU9c3B+dcVy6Mhz5x9hPQNMJMsQbAeegWZ+8BIMI+jGxSpVGg6GEcQEC379c16KEHoSSZdw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CaaJbyoP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752216112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RC+FmMVj7xVlpmIjHs3ZqgR59n3WvScw9naDpqXWnbg=;
	b=CaaJbyoP4Fr6g8fTKAXpX1t98Em++VdgyzH/KqYuEdoGWSfos1NEUW5441WfcbJP66Ykxztfx3z/atHGrg//nw44XR2gBhAZEN8WPs3p0Q2ihXTHHggPBY4EiJRuGic60a+StufLoSQ/fip/0a0WW+9WxX/oeuP3niPpLw8Upi8=
Received: from 30.74.144.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wifun88_1752215794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 14:36:34 +0800
Message-ID: <6d6feb41-5cdd-4591-8e19-d9c247e16fcb@linux.alibaba.com>
Date: Fri, 11 Jul 2025 14:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] mm/shmem, swap: rework swap entry and index
 calculation for large swapin
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-8-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250710033706.71042-8-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/10 11:37, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Instead of calculating the swap entry differently in different swapin
> paths, calculate it early before the swap cache lookup and use that
> for the lookup and later swapin. And after swapin have brought a folio,
> simply round it down against the size of the folio.
> 
> This is simple and effective enough to verify the swap value. A folio's
> swap entry is always aligned by its size. Any kind of parallel split or
> race is acceptable because the final shmem_add_to_page_cache ensures
> that all entries covered by the folio are correct, and thus there
> will be no data corruption.
> 
> This also prevents false positive cache lookup. If a shmem read
> request's index points to the middle of a large swap entry,
> previously, shmem will try the swap cache lookup using the large swap
> entry's starting value (which is the first sub swap entry of this
> large entry). This will lead to false positive lookup results if only
> the first few swap entries are cached but the actual requested swap
> entry pointed by the index is uncached. This is not a rare event,
> as swap readahead always tries to cache order 0 folios when possible.
> 
> And this shouldn't cause any increased repeated faults. Instead, no
> matter how the shmem mapping is split in parallel, as long as the
> mapping still contains the right entries, the swapin will succeed.
> 
> The final object size and stack usage are also reduced due to
> simplified code:
> 
> ./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-233 (-233)
> Function                                     old     new   delta
> shmem_swapin_folio                          4040    3807    -233
> Total: Before=33152, After=32919, chg -0.70%
> 
> Stack usage (Before vs After):
> mm/shmem.c:2277:12:shmem_swapin_folio   264     static
> mm/shmem.c:2277:12:shmem_swapin_folio   256     static
> 
> And while at it, round down the index too if swap entry is round down.
> The index is used either for folio reallocation or confirming the
> mapping content. In either case, it should be aligned with the swap
> folio.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Overall, I don't see any obvious issues, but please give me some time to 
run some tests and then get back to you. Thanks.

