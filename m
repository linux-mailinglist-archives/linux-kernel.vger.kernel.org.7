Return-Path: <linux-kernel+bounces-813440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88FB5456D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC291C865DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D826F287;
	Fri, 12 Sep 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f63grGhq"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F3261B78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665905; cv=none; b=U5+0jV8Yt7fbT+jdbvaWCV4J+J4c92ajvlyfJyHouSh+hWChNs3s4cUvfo6w1airkM1kXOL2zEjsFu36TeDeHBUhWx1u6AgV8OnsJM2MQfC31/cTm1FL1ImnxQtmj85IeDxjxPI9Hi2zyaENeBo3GTOMw1d8pleAldYOkD4BQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665905; c=relaxed/simple;
	bh=5JbqWg1axoJ581BLlJR0mOjt/6rCmckQNPsbvJTC7pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faxWm27NJVOL+dOD8YWEUEYxj4O46jF9/iGLDokU9LQpRR4cdvtXoDSt4ut/x1E2L4n1XQa0lnr3voUBPntVQCd2KeZjQR0gRzE+OiEx99MlHEo9zOTe1ATBwb6fcxcodpPf8TZzOaovCDydpO6mYA6qzZkUgj7AfB4Rf2gy/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f63grGhq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757665901; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GyIjnXxgpEHBZ+jHUO6LD6T+lct8c3N/yDNLEXQZh0U=;
	b=f63grGhqA+2/ulYFKDt+DeFlRRksVfwTIFv2nTz1VL+xWgQegezbmUpJXUc1W5d8JYrgrTcoG5YffW5sfdWcmm8cjVlHT2hYHGPXNPh9/nLwHpuq+aNGZzqyts74dnnMTlX2UKIdBKMAhkULGuRY+SV1XFVMANPBrk/ZxI7U1GY=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnqVd-r_1757665899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 16:31:39 +0800
Message-ID: <b6fa0add-e739-499d-9fbf-32454b5e137a@linux.alibaba.com>
Date: Fri, 12 Sep 2025 16:31:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
 <94cfb423-1dc5-43e1-bd1f-75b8d43fdc1a@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <94cfb423-1dc5-43e1-bd1f-75b8d43fdc1a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/12 16:24, David Hildenbrand wrote:
> On 12.09.25 10:24, David Hildenbrand wrote:
>> On 12.09.25 05:45, Baolin Wang wrote:
>>> Currently, we no longer attempt to write back filesystem folios in 
>>> pageout(),
>>> and only tmpfs/shmem folios and anonymous swapcache folios can be 
>>> written back.
>>
>> Can you point me at the code where that is fenced off?

Please see the following check in pageout():

if (!shmem_mapping(mapping) && !folio_test_anon(folio))
	return PAGE_ACTIVATE;

>> I can spot a folio_is_file_lru() check before we call it, but the
>> description tells me that there are indeed ways we could still pass that
>> check for file-lru folios if we are kswapd.

Yes, but this also needs further cleanup, as kswapd also cannot reclaim 
filesystem dirty folios in pageout(). I plan to continue optimizing 
dirty file folios in isolate_lru_folios() to avoid some unnecessary scans.

>>> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private 
>>> flag,
>>> which means no fs-private private data is used. Therefore, we can 
>>> remove the
>>> redundant folio_test_private() checks and related buffer_head release 
>>> logic.
>>
>> If that's indeed the case, do we still need the folio_test_private()
>> check in is_page_cache_freeable()?
> 
> Ah, that's patch #2 :)
> 


