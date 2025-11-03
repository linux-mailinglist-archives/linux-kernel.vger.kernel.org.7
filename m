Return-Path: <linux-kernel+bounces-883349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC6C2D304
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B37C4209E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B24316198;
	Mon,  3 Nov 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIG//177"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C027FB0E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187339; cv=none; b=neyEEVNVBgW0dETNsq+NVmypZNxgEMaG8x6avzkU77QBX4VP4E3Op4CPaUKKEz4qssnA2DWjXiayXJhkwAeTvF9ONFVtZWlBJXX2rgGMrVNgU5gIVunkCW3kHEmMgDrkM3WMuyLv3Dh1iqgqefXHhivq5idQKXo+ufbNETP4gVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187339; c=relaxed/simple;
	bh=P9RttLRFNBDXEMSCvfrmjQGTk+zQ0uUQRP4pZWzITOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYY9a1LacVWnACxv0lf88n1FPYj8l1zM2gYsLo55BrSkSpeLvO9J8q+Yz0vmLtBSCdxDyDMPAg1jY1pELwGA80isqwcKYvSSQlwYTFWev8lxbRTspZl2amw22rNwbfxohegf4rdKsq/7alLPfCro519pLATDdOu/jKk5FZvTzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIG//177; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C845FC4CEFD;
	Mon,  3 Nov 2025 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187339;
	bh=P9RttLRFNBDXEMSCvfrmjQGTk+zQ0uUQRP4pZWzITOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gIG//1776XlFbSJmn0IYGp8V19rOTHgGDsYR3POeI10oN+a9WlnZjrXrfVSt0zJoK
	 C21UdwoXw90gjW5cJfsr6NLU1O/+V6jYUZxLPF4l25JMtjmoIwT9VpcD/7bna57/pK
	 JrqXJHAUYw6a87M2SiqUCwgfUw9VQ0Hk97a1LeTg07gh7BlWeXhrC7AMMFRhnDcpNm
	 G+Ys+kf6FVUgHPSvPXgJxVuQUHZvfc/t5AptVpUcZUmZlPxOGtJRqW6GXIsB20fWxF
	 LcVuCze517OKaS9EP3/jXzBe/uUL5v7pjXj9PVARwFZpcqjsoEDhExutFQwb5aQeLs
	 7PEz8G9++1RfA==
Message-ID: <cbee126b-5a3b-4f03-a049-2d8b86b4e5f9@kernel.org>
Date: Mon, 3 Nov 2025 17:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/hugetlb: extract sysfs into hugetlb_sysfs.c
To: Hui Zhu <hui.zhu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Geliang Tang <geliang@kernel.org>, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1762156954.git.zhuhui@kylinos.cn>
 <fa0fee2b8c2e54cb2437db44579475492c19e94d.1762156954.git.zhuhui@kylinos.cn>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <fa0fee2b8c2e54cb2437db44579475492c19e94d.1762156954.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.11.25 09:22, Hui Zhu wrote:
> From: Geliang Tang <geliang@kernel.org>
> 
> Currently, hugetlb.c contains both core management logic and sysfs
> interface implementations, making it difficult to maintain. This patch
> extracts the sysfs-related code into a dedicated file to improve code
> organization.
> 
> The following components are moved to mm/hugetlb_sysfs.c:
> - hugetlb page demote functions (demote_free_hugetlb_folios,
>    demote_pool_huge_page)
> - sysfs attribute definitions and handlers
> - sysfs kobject management functions
> - NUMA per-node hstate attribute registration
> 
> Several inline helper functions and macros are moved to
> mm/hugetlb_internal.h:
> - hstate_is_gigantic_no_runtime()
> - next_node_allowed()
> - get_valid_node_allowed()
> - hstate_next_node_to_alloc()
> - hstate_next_node_to_free()
> - for_each_node_mask_to_alloc/to_free macros
> 
> To support code sharing, these functions are changed from static to
> exported symbols:
> - remove_hugetlb_folio()
> - add_hugetlb_folio()
> - init_new_hugetlb_folio()
> - prep_and_add_allocated_folios()
> - __nr_hugepages_store_common()
> 
> The Makefile is updated to compile hugetlb_sysfs.o when
> CONFIG_HUGETLBFS is enabled. This maintains all existing functionality
> while improving maintainability by separating concerns.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---


[...]

> index 000000000000..63ab13cfb072
> --- /dev/null
> +++ b/mm/hugetlb_internal.h
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Internal HugeTLB definitions.
> + *
> + * Copyright (C) 2025 KylinSoft Corporation.
> + * Author: Geliang Tang <geliang@kernel.org>
> + */

So, you move some code and suddenly have copyright and authored that code.

Especially given the cove letter says "The code is moved
as-is, with only minor formatting adjustments for code style
consistency."

?

-- 
Cheers

David

