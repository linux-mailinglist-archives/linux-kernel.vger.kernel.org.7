Return-Path: <linux-kernel+bounces-830185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB9B99015
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F377A6E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A62D0C72;
	Wed, 24 Sep 2025 08:57:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EF2557A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704271; cv=none; b=KLRg279ZHK29FDw/zNKyVOcI3sO8WXUBlAQKFoFdqmVj41l+yQrQpDv3pfY3wUSCcIvO5a3jiR2KoswAkV7fVRmn0wU+kotNxaLvMS/xOFHNi8BkrdHUOHM/P3OsKcutWvCuIspiplZrTVeV6IDjVf1wkPhNvvEIh0Wx8IWmVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704271; c=relaxed/simple;
	bh=cXGV0okpqUEWPwKXCfr2tuHmvSgWqSUR7ptaiibITVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giyuvDN8bVT0hMMOlZrSHwgzS7d9nqa5V+EboSu0Ojq7ZKDhdnufEb+dBOS7GK2Hy835EDI+Umq5Y80xYUDjoo8y7BKAVScL5MaLPWVGWpjQYxRjRxMb8v7TpvtBFV4AoyEbSJFypg6GVrNdBNxgbmXjkVgDMaR5ZRXwZbIvM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC73C106F;
	Wed, 24 Sep 2025 01:57:40 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FBC53F5A1;
	Wed, 24 Sep 2025 01:57:46 -0700 (PDT)
Message-ID: <a751762a-b5ca-45c4-95c6-a5dc63231c66@arm.com>
Date: Wed, 24 Sep 2025 14:27:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20250923140058.2020023-1-david@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23/09/25 7:30 pm, David Hildenbrand wrote:
> In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
> we converted folio_page() into a static inline function. However
> briefly afterwards in commit a847b17009ec ("mm: constify highmem related
> functions for improved const-correctness") we had to add some nasty
> const-away casting to make the compiler happy when checking const
> correctness.
>
> So let's just convert it back to a simple macro so the compiler can
> check const correctness properly. There is the alternative of
> using a _Generic() similar to page_folio(), but there is not a lot of
> benefit compared to just using a simple macro.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


