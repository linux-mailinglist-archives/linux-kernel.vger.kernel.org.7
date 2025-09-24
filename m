Return-Path: <linux-kernel+bounces-829936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9EB9845E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A754C2E77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE51A9FB4;
	Wed, 24 Sep 2025 05:19:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1963B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691175; cv=none; b=ibRGag6O3nYBJhaU+b7DhXTviQMw4tUatvTWQw/g1JdOuzQBgUXpK1H+sojD2HM6X5Fs2tQxmfJiOOoiL/nxwT6gjD3LshTYJKwYskOr0qX8YjCM5e4mQohVlyAtGh8M/pm4q3IP0c75CJovoOvc0/XUbHJzr37pnD/B+hNMJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691175; c=relaxed/simple;
	bh=U/J7jXqv3Ab3qmOcItDtpRy/djY7zWnITegDHSMWYL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0CYUgIFl6+o7CvuUr0lfIhph/QMcNAKA6rfKplsWruTuWHieEFJD964PHym0Xo0rnKEjljkVp/P2TcFGgc9cS1TEJ+EWvtFt84Mn/j6JLyZ+szQEXMrYgU2bIA4QQ0Ul27yWin8zrbGeFFCy7udV0G4EEqJ6sAOofGB3l1NN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3968106F;
	Tue, 23 Sep 2025 22:19:23 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B54F3F694;
	Tue, 23 Sep 2025 22:19:27 -0700 (PDT)
Message-ID: <9a4f1846-06fd-414e-ae5f-43d3d5270380@arm.com>
Date: Wed, 24 Sep 2025 10:49:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm: clean up is_guard_pte_marker()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: richard.weiyang@gmail.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, david@redhat.com, hughd@google.com,
 ioworker0@gmail.com, kasong@tencent.com, kirill@shutemov.name,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com
References: <20250924045830.3817-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250924045830.3817-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/09/25 10:28 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Let's simplify the implementation. The current code is redundant as it
> effectively expands to:
>
>    is_swap_pte(pte) &&
>    is_pte_marker_entry(...) && // from is_pte_marker()
>    is_pte_marker_entry(...)    // from is_guard_swp_entry()
>
> While a modern compiler could likely optimize this away, let's have clean
> code and not rely on it.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


