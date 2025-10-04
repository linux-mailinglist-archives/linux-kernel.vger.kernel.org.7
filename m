Return-Path: <linux-kernel+bounces-842051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2260BB8D99
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DCC189C73C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607C274B59;
	Sat,  4 Oct 2025 13:11:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC581A4F3C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583519; cv=none; b=hDQGVfT61VPFZXmJYfpRhq9dArZcHS2gOYGMbda85DYVv3y74eqhF/XFNyTRoo+IHLCi0e1I+RcfP3GQ49MQoGWrzkXJaxkl7nD/t/qFEdjUqHBhTTlPVGBfpnV+zmxyoA9rPuRkEX5l+d8toefmGzBxq0fE+TZmdH84lz5GxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583519; c=relaxed/simple;
	bh=GCI8Ngj0uJx3jhwkRo0s71hK0X8UJ3DKSu+pKeMhODU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j43QyLKNxiRjqbI6CIQyVpTn/+v/DiOR6szsMYRCf39UlLejuV6HlVNyMcmm3rXwNTPFyJQzURv88oZ3tbeenuUrkvPVWtEO3Vj+iCYLL1AIncA16QUP51cHEIIGeYqIIG/wzQ3teZGcJgwW3a52t4z93byZlCSwAt99Z1bGA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22263153B;
	Sat,  4 Oct 2025 06:11:49 -0700 (PDT)
Received: from [10.163.66.97] (unknown [10.163.66.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B35F3F66E;
	Sat,  4 Oct 2025 06:11:51 -0700 (PDT)
Message-ID: <f235a557-d031-4fcd-8c68-81d9ab7b54e0@arm.com>
Date: Sat, 4 Oct 2025 18:41:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <20251004094217.bah5q2zxczrqontm@master>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251004094217.bah5q2zxczrqontm@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/10/25 3:12 pm, Wei Yang wrote:
> On Fri, Oct 03, 2025 at 10:35:12PM +0530, Dev Jain wrote:
>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>
>>> This patch cleans things up by moving all the common PTE checking logic
>>> into a new shared helper, thp_collapse_check_pte().
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
> This is true for the first loop, but we will unlock/lock mmap and revalidate
> vma before isolation.
>
>> an anonymous vma, is it even possible to hit if (!folio_test_anon(folio))?
>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>> till the folio_maybe_mapped_shared() block?
> But it looks still valid, since hugepage_vma_revalidate() will check the vma
> is still anonymous vma after grab the mmap lock again.
>
> My concern is would VM_BUG_ON_FOLIO() be too heavy? How about warn on and
> return?

Frankly I do not have much opinion on the BUG_ON/WARN_ON debate since I haven't
properly understood that, but this BUG_ON is under CONFIG_DEBUG_VM anways. But
if you want to change this to WARN then you can do it at both places.

>

