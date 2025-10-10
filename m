Return-Path: <linux-kernel+bounces-848124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C8BCC95A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2151E4EC958
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3596283144;
	Fri, 10 Oct 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cslbs//z"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBB1B4F0A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092945; cv=none; b=Fen3qgbQubZ3WRanngqw8rJcO3aOHNHvH+I8JCaWP7LRH5oDMWurwyGkD+n2D4o8eqnEvPXFiYROMmQNQFsbrOL1G4kCg5rZpmHsLX1K0CPKoTz4Fmisf0GEsOK2wvu3p3fSnlDqTaQmir40V1+Nnax8tG7XIredgZUr/BoD8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092945; c=relaxed/simple;
	bh=lS0LeNdQo78bDhZSXrwZOByTYx9OfKfj+hv78w8WymA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFNepqBrovii+/BcwkSxfjDMk/YlEGL7rEE1kRFc/u/M0MQwRsFmPyG89IXseN+3Gy5NL8NwT7hlcerSde+kGZA8lqF8rQJHhFtGTl9GbYHdIic351QmsB1kiZkaRMNdUYTczjsDYlAawSImH1vQMEoRDKNyTBgezS+muohkuX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cslbs//z; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6eee7e44-cdf6-45c6-8114-b62c57a2a4e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760092940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/2MWyCrDxrhI4+1rtpNAxA+OW+hGmrTRFH+Isw9N58=;
	b=Cslbs//z93t0gMKiCEWHXID71xt7lvfMI0M3fFC5xhYuiQsVeF3TJ0NUp9y/b43gWcDphY
	MW0ggVSJrMRxCNTvfmHKPrhNOzBTr8zt4tqd/760Z3641Xyg60wpZgYKSC0hfaHYxISH7o
	UPpkXfhV/UFG75lh0+GHaWreE282Xvk=
Date: Fri, 10 Oct 2025 18:42:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, david@redhat.com, richard.weiyang@gmail.com,
 lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-4-lance.yang@linux.dev>
 <ce95ab8a-70dc-4159-b38b-dd9f3ffc9aa1@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ce95ab8a-70dc-4159-b38b-dd9f3ffc9aa1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/10 17:10, Dev Jain wrote:
> 
> On 08/10/25 10:07 am, Lance Yang wrote:
>>   	}
>>   }
>>   
>> +/*
>> + * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
>> + * @pte:           The PTE to check
>> + * @vma:           The VMA the PTE belongs to
>> + * @addr:          The virtual address corresponding to this PTE
>> + * @foliop:        On success, used to return a pointer to the folio
>> + *                 Must be non-NULL
>> + * @none_or_zero:  Counter for none/zero PTEs. Must be non-NULL
>> + * @unmapped:      Counter for swap PTEs. Can be NULL if not scanning swaps
>> + * @shared:        Counter for shared pages. Must be non-NULL
>> + * @scan_result:   Used to return the failure reason (SCAN_*) on a
>> + *                 PTE_CHECK_FAIL return. Must be non-NULL
>> + * @cc:            Collapse control settings
>> + *
>> + * Returns:
>> + *   PTE_CHECK_SUCCEED  - PTE is suitable, proceed with further checks
>> + *   PTE_CHECK_CONTINUE - Skip this PTE and continue scanning
>> + *   PTE_CHECK_FAIL     - Abort collapse scan
>> + */
>> +static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
>> +		unsigned long addr, struct folio **foliop, int *none_or_zero,
>> +		int *unmapped, int *shared, int *scan_result,
>> +		struct collapse_control *cc)
>> +{
>> +	struct folio *folio = NULL;
> 
> I think initialization is not needed here?Otherwise, LGTM. Reviewed-by: Dev Jain <dev.jain@arm.com>

Yep. It's a minor thing, so I'll fold that in if a new version is 
needed. Thanks!

