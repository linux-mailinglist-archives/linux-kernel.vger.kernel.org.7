Return-Path: <linux-kernel+bounces-884440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B88C302D8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CC73AD746
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98142BE658;
	Tue,  4 Nov 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM9HRWR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577729B8C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247105; cv=none; b=moHF7tOxRxuyydzpRCUY8rvdpggL+gbKejczONsjVNEs+giJPsrgcW/D2xe307Gb0uBuc57DeVOOYdQHz+CPL2voV+VGoRxKYAeUolYBBCsfYA5NDDLj489rJhibX9SM3NllOMtaTk5ZS72d8Vp+0pWmIGruRGn+LQY1gEC+R0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247105; c=relaxed/simple;
	bh=MvsTRVEUb4pz4cYJ7CqvDk7q15x53H+jVN10gNSeAEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjDSzDn5IALlBYiGblwI0y9p429dH6VtGUOOFhAiPqHEq6Zc5rSo6cEhVwlDr38oKqSrDEhBfOyPRea/sheSppnYBtrOmvpr4Ch4LHB2AiJN9zNDKIxDsQS7O26aNju4fDo/94V72ToWrXoT+JWr2N5FLHPfZXJlL97Pmp9igR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM9HRWR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC3C116B1;
	Tue,  4 Nov 2025 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762247105;
	bh=MvsTRVEUb4pz4cYJ7CqvDk7q15x53H+jVN10gNSeAEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eM9HRWR5JmUWRtndmMk6sdic8Q5cEco9rIlTg+CoNAIALbbMMalNePhWqgTUpAo/6
	 jjEg/vGmtp1kW34Q37eluMKvGmQ7rAcb97hrmzVoQ3iytzTv3KI86RuTkTIJ8yKynm
	 9Eh1uMx4NvDQLdMihRpOZhPuSrmOxX097149ox3HvgkNjxs+cLN/PbL4Um2CnzpO0W
	 Q+gGaCKMRn7VkKqlTJiY8dAC6gcue5fkl/J6/odIG/V3GpXlMONaNv/0Y4WC9YRkls
	 bbosyHWrRexPPhNhQFKDfV9v1Gcn7B01hMsaX5cuPt/l7/Hm9cNQLctcYYQMtiKvPz
	 Tl89hWgesCbuQ==
Message-ID: <02740344-a773-4c04-af72-72d277c7c6e5@kernel.org>
Date: Tue, 4 Nov 2025 10:05:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/hugetlb: extract sysfs into hugetlb_sysfs.c
To: hui.zhu@linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Geliang Tang <geliang@kernel.org>, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1762156954.git.zhuhui@kylinos.cn>
 <fa0fee2b8c2e54cb2437db44579475492c19e94d.1762156954.git.zhuhui@kylinos.cn>
 <cbee126b-5a3b-4f03-a049-2d8b86b4e5f9@kernel.org>
 <1ecbb7b6b6c1cc85e9a52d32d968a2ad987a1922@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <1ecbb7b6b6c1cc85e9a52d32d968a2ad987a1922@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.11.25 03:41, hui.zhu@linux.dev wrote:
> 2025年11月4日 00:28, "David Hildenbrand (Red Hat)" <david@kernel.org mailto:david@kernel.org?to=%22David%20Hildenbrand%20(Red%20Hat)%22%20%3Cdavid%40kernel.org%3E > 写到:
> 
> 
>>
>> On 03.11.25 09:22, Hui Zhu wrote:
>>
>>>
>>> From: Geliang Tang <geliang@kernel.org>
>>>   Currently, hugetlb.c contains both core management logic and sysfs
>>>   interface implementations, making it difficult to maintain. This patch
>>>   extracts the sysfs-related code into a dedicated file to improve code
>>>   organization.
>>>   The following components are moved to mm/hugetlb_sysfs.c:
>>>   - hugetlb page demote functions (demote_free_hugetlb_folios,
>>>   demote_pool_huge_page)
>>>   - sysfs attribute definitions and handlers
>>>   - sysfs kobject management functions
>>>   - NUMA per-node hstate attribute registration
>>>   Several inline helper functions and macros are moved to
>>>   mm/hugetlb_internal.h:
>>>   - hstate_is_gigantic_no_runtime()
>>>   - next_node_allowed()
>>>   - get_valid_node_allowed()
>>>   - hstate_next_node_to_alloc()
>>>   - hstate_next_node_to_free()
>>>   - for_each_node_mask_to_alloc/to_free macros
>>>   To support code sharing, these functions are changed from static to
>>>   exported symbols:
>>>   - remove_hugetlb_folio()
>>>   - add_hugetlb_folio()
>>>   - init_new_hugetlb_folio()
>>>   - prep_and_add_allocated_folios()
>>>   - __nr_hugepages_store_common()
>>>   The Makefile is updated to compile hugetlb_sysfs.o when
>>>   CONFIG_HUGETLBFS is enabled. This maintains all existing functionality
>>>   while improving maintainability by separating concerns.
>>>   Signed-off-by: Geliang Tang <geliang@kernel.org>
>>>   Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>>>   ---
>>>
>> [...]
>>
>>>
>>> index 000000000000..63ab13cfb072
>>>   --- /dev/null
>>>   +++ b/mm/hugetlb_internal.h
>>>   @@ -0,0 +1,110 @@
>>>   +// SPDX-License-Identifier: GPL-2.0-only
>>>   +/*
>>>   + * Internal HugeTLB definitions.
>>>   + *
>>>   + * Copyright (C) 2025 KylinSoft Corporation.
>>>   + * Author: Geliang Tang <geliang@kernel.org>
>>>   + */
>>>
>> So, you move some code and suddenly have copyright and authored that code.
>>
>> Especially given the cove letter says "The code is moved
>> as-is, with only minor formatting adjustments for code style
>> consistency."
>>
>> ?
> 
> Thanks for your remind.
> Remove the wrong copyright according to your comments.

You should keep/use the ones from where you move the code originally. Do 
the same for patch #2, obviously.

-- 
Cheers

David

