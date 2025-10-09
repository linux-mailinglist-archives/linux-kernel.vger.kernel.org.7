Return-Path: <linux-kernel+bounces-846136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB3BC7207
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D064E5676
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681CE1581EE;
	Thu,  9 Oct 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOEckLtO"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAA4A06
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759974569; cv=none; b=YLZhhnXmVsWUDBTVPSHJTvDU2U8cP+V6XTidaqBGq28+e4KTDD0M4pX7xi2lCoXyXs0vdk3KL3gBSS1MDPuDbZmqVjFi2toU58+aP940oEa0oN9HQ7ajPLvTgkAyYAdvS96pkAd/8Q9S3/G39IIutSrxX9AqT33JMYT57Kfcr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759974569; c=relaxed/simple;
	bh=lDCRAYq2GAvTSXdImxsuJg6Oxwc90jpMIyIeWEWwW1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrUzyOxPt54Qv275Eqh4gjv2RLHW7TXNgoRNARMu1Z3a29coS2OZicGhPIWBlUhWqPZI/szDkz0YZZYUUHGYGA4YW1qk3IZFvzdFumyeztX7y3HhDck9I3GhVxmavmBYKaXiWB8Af95BVT1N4JXqUfAUF5uIWxQmwRXt8NTVPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOEckLtO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ddaaf80-f16d-44be-9032-974f7e501e36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759974557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmbfo1v3pnUVofferszWtiV8RrDISxuLm2FSoyEqKmM=;
	b=kOEckLtOeUsZQWf1SUasgVpDk7DgTsgPid27oYpunbvpT54dOsfvmrNhbfM4b9yPwfFKf2
	ffL0R1SkMSQ1DAezJ60yzZiDpJ210td/RTCNjeNq0c1t/jnxRv+uuGzrGqOGlgDOjizX1H
	ptlJVp+AMz3Oq+SkjxsEDD0F2sPWByA=
Date: Thu, 9 Oct 2025 09:49:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-4-lance.yang@linux.dev>
 <20251008180744.008424134fbc29e9616899ad@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251008180744.008424134fbc29e9616899ad@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/9 09:07, Andrew Morton wrote:
> On Wed,  8 Oct 2025 12:37:48 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
>> +		if (!cc->is_khugepaged ||
>> +		    *unmapped <= khugepaged_max_ptes_swap) {
>> +			/*
>> +			 * Always be strict with uffd-wp enabled swap
>> +			 * entries. Please see comment below for
>> +			 * pte_uffd_wp().
>> +			 */
>> +			if (pte_swp_uffd_wp(pte)) {
>> +				*scan_result = SCAN_PTE_UFFD_WP;
>> +				return PTE_CHECK_FAIL;
>> +			}
>> +			return PTE_CHECK_CONTINUE;
>> +		} else {
>> +			*scan_result = SCAN_EXCEED_SWAP_PTE;
>> +			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>> +			return PTE_CHECK_FAIL;
>> +		}
> 
> I'm inclined to agree with checkpatch here.

Thanks!

> 
> WARNING: else is not generally useful after a break or return
> #81: FILE: mm/khugepaged.c:574:
> +			return PTE_CHECK_CONTINUE;
> +		} else {
> 
> did you see this and disagree or did you forget to run checkpatch?

Yes, I saw the warning. I kept the original style because this is just a 
code move ...

> 
> --- a/mm/khugepaged.c~mm-khugepaged-merge-pte-scanning-logic-into-a-new-helper-checkpatch-fixes
> +++ a/mm/khugepaged.c
> @@ -571,11 +571,10 @@ static inline int thp_collapse_check_pte
>   		    (!cc->is_khugepaged ||
>   		     *none_or_zero <= khugepaged_max_ptes_none)) {
>   			return PTE_CHECK_CONTINUE;
> -		} else {
> -			*scan_result = SCAN_EXCEED_NONE_PTE;
> -			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -			return PTE_CHECK_FAIL;
>   		}
> +		*scan_result = SCAN_EXCEED_NONE_PTE;
> +		count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +		return PTE_CHECK_FAIL;
>   	} else if (!pte_present(pte)) {
>   		if (!unmapped) {
>   			*scan_result = SCAN_PTE_NON_PRESENT;
> @@ -600,11 +599,10 @@ static inline int thp_collapse_check_pte
>   				return PTE_CHECK_FAIL;
>   			}
>   			return PTE_CHECK_CONTINUE;
> -		} else {
> -			*scan_result = SCAN_EXCEED_SWAP_PTE;
> -			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> -			return PTE_CHECK_FAIL;
>   		}
> +		*scan_result = SCAN_EXCEED_SWAP_PTE;
> +		count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> +		return PTE_CHECK_FAIL;
>   	} else if (pte_uffd_wp(pte)) {
>   		/*
>   		 * Don't collapse the page if any of the small PTEs are
> _
> 


