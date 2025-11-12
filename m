Return-Path: <linux-kernel+bounces-897117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22AC5206F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0780188A2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AD3126D0;
	Wed, 12 Nov 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEwD8B7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205A311592
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947474; cv=none; b=d0zLFBUV5mxzRW6wW1eVq2UtiASiYaVnVTm9IPQnlEExI64dgOd5Een4S4t8TLQ5Tw4AejzCHuS/QazRUhJw/mUtyMNtlrrhbOT+m3CO0vayxQ2vg2getdQ+5fNpZzcfQFfCJtWpNg0PFPhyyy+o7KCVLkzVZ1ueoAKP8RoktVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947474; c=relaxed/simple;
	bh=9eyje3n8F9JrQInIWg9SjS5SLlOCIS9dvxtClXH/S58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXrOlp1+1SxFzXhGsh0PYL6E0Jxw0BRNaZ+1oZbuNNNnvrltLjqAhfDNTNW1y674KNgnH6HAL4CqzyIJBx8wBUDvINdUewyGTfjxboZ87l2Sk0Pv3IdiPFa6cD1yX0ATxTySdb++BPphSjFb5EQ4drOQMLoz7Dr1upekM8ZlOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEwD8B7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8312C4CEF5;
	Wed, 12 Nov 2025 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762947474;
	bh=9eyje3n8F9JrQInIWg9SjS5SLlOCIS9dvxtClXH/S58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uEwD8B7glVH6j11jaKszi38avvOs2oESpjLRTBSIDErI9HiggDfkmqXocjiUnGIjV
	 d2W2FQ5cWoocJsjekXCNKL2CgOE9M3IxlHKC9b2UQxRbFX0F9jcWVk7Sy8riPT1j9d
	 WpQBHfiPHB6Z/gTGkAEhjPuSq5xM1ZE1mtQs/axU+eE+pjjwaMj9sBQUYxg7JLHm8O
	 1jtHqHxYgfRbAnTIGgEogHwHTQ028SRmGO45rRcK9o+pctC4Xg+PoRaOEGVTPlo0sP
	 fiMO8CtVZLmDNaGLGaNgJjaizA+Um/q48vsx7226cuJ/EmEWEKQhKf42x5xVyT/ZuM
	 a6hRoxm1Mz55w==
Message-ID: <4e6286a6-721d-45cd-a4ea-e79e90e14fc7@kernel.org>
Date: Wed, 12 Nov 2025 12:37:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: softleaf device private fixes in
 remove_migration_pmd()
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <20251112044634.963360-2-balbirs@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112044634.963360-2-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.25 05:46, Balbir Singh wrote:
> commit a6ca2ba46390 ("mm: replace pmd_to_swp_entry() with softleaf_from_pmd()")

So should this be squashed into Lorenzo patch, or incorporated in his 
series in case he has to resend?

> does not work with device private THP entries. softleaf_is_migration_young()
> asserts that the entry be a migration entry, but in the current code, the
> entry might already be replaced by a device private entry by the time the
> check is made. The issue exists with commit
> 7385dbdbf841 ("mm/rmap: extend rmap and migration support device-private entries")
> 

Because this confuses me. If it's already a problem in the 
commit-to-go-upstream-first, it should be fixed in that commit?

-- 
Cheers

David

