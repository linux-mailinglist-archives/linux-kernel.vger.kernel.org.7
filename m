Return-Path: <linux-kernel+bounces-754980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC08B19F71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D922B1889F32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026B248166;
	Mon,  4 Aug 2025 10:07:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D097246BAD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302052; cv=none; b=ii8cqIEBEmPj63JjOB/alTIrMahTJQOl1R6yqS5Ut5/CZCh07lpzQ2ceb2NaoTP5FIic+izvjmhAhATE7ILIvIHLi/lZJUxiXdaHJ71iL5GswbcFbgsSK4iTIfm6Pf5F1HakyneCC1s33MiUZjKC/6EZ1taR4O+TnhDDT9HaDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302052; c=relaxed/simple;
	bh=+5TZnjax+ulSndP0QXcP7rhAXpoZNrnlI+8q738dCYI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dh63vdZUXzALHaoPcK234DWBM0Lduw0lEL3GH/zd9nhkomWeKetsyxkPBhRLkiOAVlHeI6UA+4tGgEcB8XPBuEVH22dCB3pwFgv0rye1EIyD4TzidlvpF79MSFA5MDFpWQw1GNN3O9wjSy28qe/BIibbhdZIai5XNGT1XbfAJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A60712FC;
	Mon,  4 Aug 2025 03:07:21 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A6A3F738;
	Mon,  4 Aug 2025 03:07:27 -0700 (PDT)
Message-ID: <ac76c5f5-ead1-4d17-9ef0-0f8068cf8d8d@arm.com>
Date: Mon, 4 Aug 2025 11:07:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
 <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
In-Reply-To: <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2025 15:35, Ryan Roberts wrote:

[...]

>> @@ -1366,7 +1648,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  
>>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>  
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping() ||
>> +	    (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()))
> 
> So force_pte_mapping() isn't actually returning what it sounds like it is; it's
> returning whether you would have to force pte mapping based on the current cpu's
> support for bbml2. Perhaps it would be better to implement force_pte_mapping()  as:
> 
> static inline bool force_pte_mapping(void)
> {
> 	bool bbml2 = (system_capabilities_finalized() &&
> 			system_supports_bbml2_noabort()) ||
> 			bbml2_noabort_available();

Sorry that should have been:

	bool bbml2 = system_capabilities_finalized() ?
		system_supports_bbml2_noabort() : bbml2_noabort_available();

> 
> 	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> 			   is_realm_world())) ||
> 		debug_pagealloc_enabled();
> }

