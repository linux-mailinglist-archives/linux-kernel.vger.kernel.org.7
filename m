Return-Path: <linux-kernel+bounces-815007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B315B55DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DA458339A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E11C84AB;
	Sat, 13 Sep 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FP/D4P48"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876A3D984
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757732697; cv=none; b=h+YaMYNN19/AE19gxsjWv/Yz+w7X8zT2cm+mZTgPlTBjXtH1JBN0lDTn7nxG0483u4x5cBH0Z+8tMSjkA2jnLhl2/blpOsxF5eZxCmk0Fr+1tR7bRHLAEEL5h2+AMN341wRCl7DmUNdTrABf8iL1l7oxffztRsZPk/XjcjPPiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757732697; c=relaxed/simple;
	bh=JY1aRorbXP0Rsk7zmxl85A5twnjyCRvNmRVQlL/07zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUeFlw/yLV7MV4CFGriOeAQpdhzfEU52EoFyBCxQGsGCwXuwL+mCD6jhUbU/127Dec4wkwBoakiB/eEOAi7BdHiF9l5vgpnRvs39X8U0LN6GO6dOZVI13IRrEl4bfocVoYc1q7TIYl0fHF4L9Em3ZIbQUhyzewoeTNPJP5WhuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FP/D4P48; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757732691; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6oiFjqJ2Qm+dtXW2VEyHJx3EfGVEzVOxZqD8aCepxi8=;
	b=FP/D4P48WXsidbDWSIUnfJdAwix+aYSESt+Lbau08KYFHLjNlEZslSFYNHiuCqm+EFGAtwQZD+vDSm0ybsdmJGU1Aq65Qq52vZ77KhDXO9dUZfSQUz07U0lNb5p70UNyUW7/aee2q4INaJsahJ5fYdTaMjQ4/xIr3zr+9qe8bPc=
Received: from 30.134.50.220(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnsSUij_1757732688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 11:04:49 +0800
Message-ID: <11629632-c652-460e-b617-3ec0c27969f5@linux.alibaba.com>
Date: Sat, 13 Sep 2025 11:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <aMQ6bW-OoMWMVEFF@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aMQ6bW-OoMWMVEFF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/12 23:21, Matthew Wilcox wrote:
> On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
>> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>>   	 * swap_backing_dev_info is bust: it doesn't reflect the
>>   	 * congestion state of the swapdevs.  Easy to fix, if needed.
>>   	 */
>> -	if (!is_page_cache_freeable(folio))
>> +	if (!is_page_cache_freeable(folio) || !mapping)
>>   		return PAGE_KEEP;
> 
> I feel like we need to keep the comment (assuming it's still true ...
> which it probably is, although there's nobody who would think to update
> this comment if it became no longer true).  I would certainly wonder why
> we can have this !mapping test.

I think the !mapping check is still needed here because the tmpfs/shmem 
folios truncation might race with folio reclamation, see shmem_undo_range().

Additionally, the comments here are no longer related to tmpfs/shmem and 
swapcache folios, so I still prefer to remove them.

>> -		/*
>> -		 * Some data journaling orphaned folios can have
>> -		 * folio->mapping == NULL while being dirty with clean buffers.
>> -		 */
> 
> I approve of this simplification, and I think there's more work to be
> done in this area.  Thanks for doing it.

Thanks for taking a look. Yes, I will continue to take a closer look at 
the further work here.

