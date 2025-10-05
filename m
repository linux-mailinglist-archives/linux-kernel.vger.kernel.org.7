Return-Path: <linux-kernel+bounces-842207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D8BB9381
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 04:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D9834E205B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53B78F36;
	Sun,  5 Oct 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JOFLrU8G"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFFEEC0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759631754; cv=none; b=ACS+CLcUudCOsW+MHrgWAtFYpHF+HdYZgPGmPw7dpiCkeE2H+uUOcfvdE1jJZMkKucXzt/TYX5y/IbOo+zVXPPqGCtgtUYuqjyhPmeJQ5fiJipI4FdF6+agof8gvzZIlBS3FxSqZwE4UD9NAS+bWu+EQE0apWis4fcoepjcT7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759631754; c=relaxed/simple;
	bh=UAjfhomNYUc4r9ouzjRkutrkr79DTndY//Wz3v8FrSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXBX8tq/S6v6KgOL3o5M+yqmOCUls7EHEaFuDyNxGXbqR+9pzUuQr5U7tNT0vnqFtM8r1CsS+jn6my/CRZgokhMVXk0kTXJ4WhmxbiR9UZjqc+cAIcwGd5ZQd3ZDkPSGRKKF6BDL0gDHxC5QvvgM7LgfCIeiJoSu3yyBnf2QSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOFLrU8G; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <054ca3f1-b219-49dc-9c4a-6f648b9df7f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759631749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzegS9FRnJ2j9ah3b1IUHaBCWuWvwbJb5MYOfqPsxeI=;
	b=JOFLrU8G99lkQF3OoatNpr66U50Pfg1ZU/7dq5EBnDcJgt4aEWA316Jrgw5CizIXFRoihi
	0NBV3vaWX2cGINyeNUZ1qsEUDP1P71ltkzyl/GVVuis5iKIA0s4rIm1eFTzFNdvM++Xzk1
	YH9zzU0ITLVrl7d0EsspbGMgK6RsLco=
Date: Sun, 5 Oct 2025 10:35:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <20251004094217.bah5q2zxczrqontm@master>
 <f235a557-d031-4fcd-8c68-81d9ab7b54e0@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f235a557-d031-4fcd-8c68-81d9ab7b54e0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 21:11, Dev Jain wrote:
> 
> On 04/10/25 3:12 pm, Wei Yang wrote:
>> On Fri, Oct 03, 2025 at 10:35:12PM +0530, Dev Jain wrote:
>>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>>
>>>> This patch cleans things up by moving all the common PTE checking logic
>>>> into a new shared helper, thp_collapse_check_pte().
>>>>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
>> This is true for the first loop, but we will unlock/lock mmap and 
>> revalidate
>> vma before isolation.
>>
>>> an anonymous vma, is it even possible to hit if (! 
>>> folio_test_anon(folio))?
>>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>>> till the folio_maybe_mapped_shared() block?
>> But it looks still valid, since hugepage_vma_revalidate() will check 
>> the vma
>> is still anonymous vma after grab the mmap lock again.
>>
>> My concern is would VM_BUG_ON_FOLIO() be too heavy? How about warn on and
>> return?
> 
> Frankly I do not have much opinion on the BUG_ON/WARN_ON debate since I 
> haven't
> properly understood that, but this BUG_ON is under CONFIG_DEBUG_VM 
> anways. But

Yeah, VM_BUG_ON_FOLIO() is under CONFIG_DEBUG_VM, so it won't affect
production kernels.

> if you want to change this to WARN then you can do it at both places.

It should flag such an impossible condition there during development.
So, I'd prefer to stick with VM_BUG_ON_FOLIO().

@Wei please let me know if you feel strongly otherwise :)

