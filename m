Return-Path: <linux-kernel+bounces-841562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2536ABB7A66
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D564EE4D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB22D77F7;
	Fri,  3 Oct 2025 17:05:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3C2D738B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511125; cv=none; b=kp0zhiwvebNRpa2T+wPMrd5GSmKnzYaj3MThn7XrNIRZuRdkpBvSvbHPfhOnz2FDt5V3SYXJchDRhN4wW1i1c0gxaqjR2MA9+kTdWGmH/fYkPrg1Ts2mDAGeLN4ZDTN3gsVpkXwATojOhzUzXBAUFzK/ginxBePuMIvxGZaAzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511125; c=relaxed/simple;
	bh=wAIBxaYGeVIBBgmlPnc939RMsjNGdAwoCTnXwDGYtpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUzHsmGyRahqdgARcOx4Ngs9nzi/BSlQJyDSw3UQ7qxPO14pxPYVO3jh4hl4Dgf+tUtH7S/9ZmE9KUTQFjV+WQ8CkbmXw+ysLcyHYKGwokKYRfr/ATGCqf8DDRR8UVH2of3eb9tfgutoECYgdoEhPilAfrbWdqke/nZqXnpjaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 967C21655;
	Fri,  3 Oct 2025 10:05:14 -0700 (PDT)
Received: from [10.163.65.114] (unknown [10.163.65.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DECF73F66E;
	Fri,  3 Oct 2025 10:05:16 -0700 (PDT)
Message-ID: <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
Date: Fri, 3 Oct 2025 22:35:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251002073255.14867-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/10/25 1:02 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
> and __collapse_huge_page_isolate() was almost duplicated.
>
> This patch cleans things up by moving all the common PTE checking logic
> into a new shared helper, thp_collapse_check_pte().
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   

In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
an anonymous vma, is it even possible to hit if (!folio_test_anon(folio))?
In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
till the folio_maybe_mapped_shared() block?


