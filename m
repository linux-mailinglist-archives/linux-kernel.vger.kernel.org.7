Return-Path: <linux-kernel+bounces-883266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9ABC2CE68
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C4189107F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B3B315D3B;
	Mon,  3 Nov 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX2+0VA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD13275111
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184290; cv=none; b=k+MHVyHVZR0t8gdEfJpyRvvdodC4JvwiTR3N1SSMqqweO+Oi/zsndY9E9gHEarLdmQugQnPOQ68gdU4zWW6z1PD70DQTzIvrERUv7qOwlSgVkABsOrlDCoCWocMqa2eLacHRvgwlRc1wNS/rmYE46ZurKaHRoYtza4WdpwzbVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184290; c=relaxed/simple;
	bh=1CDUYOsWVIa1CRQEq15QH6kbgshp4nDJDCB9TrYkUp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE9NhcLQ4uJHI6DY9R8blrYhP3PRzurhWheZYwtNHiqaMsx/ReMtILPfDbIHltvFIZiJXdPCk6Nar9I4HIoHCF9WNb4cMr2oj0/zSDrOn6NZHhzY2nBzhbQbQSt0uLKgCV2tfHG8LRKivKw2Ru0vehK5ETNP9yBzQWLmgJUj11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX2+0VA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4ACC113D0;
	Mon,  3 Nov 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184287;
	bh=1CDUYOsWVIa1CRQEq15QH6kbgshp4nDJDCB9TrYkUp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cX2+0VA/Ows4CvgbN3MImYhWPsU6aHq8caEHnyvEwOsbBnTELIxzQL1SE5Bn+wQDg
	 tuBnhESqJVix3PzSlErs9y+UMJNReBhf7Vre6V78TB+oAQg2+vZ/rNiA6DLoVNqYVG
	 H8d+MdnI+UMf4qPYo+sZvPS3V/dakDCr+L0I/kAS8wEy9EbqYgEHcHTxQjMa78nmId
	 Tf3ZcR8OQp0wnm7RApDjW2I/rZvlqg9uBpBJ5i70/itshlrD5xQQcg2dM5b9O6V/T8
	 hLhGjaHDg0wRidX1sk1A7D64kJkV9EE5wAkXfOZ8Sl1AMOIsPyVH+lhPXv+tETT6fD
	 J2e3E1KaibQ5g==
Message-ID: <e5fee14a-4569-49c8-9f42-844839e51e85@kernel.org>
Date: Mon, 3 Nov 2025 16:38:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: mm: Don't sleep in split_kernel_leaf_mapping()
 when in atomic context
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, yang@os.amperecomputing.com, ardb@kernel.org,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251103125738.3073566-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   }
> 
> +static inline bool force_pte_mapping(void)
> +{
> +	bool bbml2 = system_capabilities_finalized() ?
> +		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();

You are only moving this function. Still, there is some room for improvement I want to point out :)

bbml2 could be a const (or a helper function like bbml2_supported).

> +
> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> +			   is_realm_world())) ||
> +		debug_pagealloc_enabled();


I suspect this could be made a bit easier to read.

	if (debug_pagealloc_enabled())
		return true;
	if (bbml2)
		return false;
	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();


> +}
> +
>   static DEFINE_MUTEX(pgtable_split_lock);
> 
>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	if (!system_supports_bbml2_noabort())
>   		return 0;
> 
> +	/*
> +	 * If the region is within a pte-mapped area, there is no need to try to
> +	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> +	 * change permissions from softirq context so for those cases (which are
> +	 * always pte-mapped), we must not go any further because taking the
> +	 * mutex below may sleep.
> +	 */
> +	if (force_pte_mapping() || is_kfence_address((void *)start))
> +		return 0;
> +

We're effectively performing two system_supports_bbml2_noabort() checks, similarly in
arch_kfence_init_pool().

I wonder if there is a clean way to avoid that.

I'm not super up-to-date on that code. Nothing else jumped at me.

-- 
Cheers

David


