Return-Path: <linux-kernel+bounces-747909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80306B13A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE14618964D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6B261586;
	Mon, 28 Jul 2025 11:56:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A73218858;
	Mon, 28 Jul 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703811; cv=none; b=jxNigmJliiHlgxnP+qF2INfX6xtZ0iz2JxhjV4g5ZKh//FJgNsCeUJbakvThm0FjOOQ/fFhbvNng9MCFD9FZpp9i6nmPWsYjN9t0GBBhXzrr4JR1ASl90BnZ5TsPSQ0MM3G8exVOoDfqbPvcMKXtMgRMaCZJaZiFI9vJBCxZy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703811; c=relaxed/simple;
	bh=hD+7Qbb0wCO0WpIt+M1jPQrrUXraENzKaaAqhP95GaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRHjGsQl03izcHgzVgr/Pm3nSR689WxBoYgextwnpDCyqwntz7t0Ixt6s6aB6UHJNQ4YYqvKSne/daFb4/55MgyGOwNRZ41tIyt4CViQdT/M2MPmikd20DHj0qvuLpMYsQAxDOgzPqDEgmmE59hwyhzOayh4LIkOVYRoexQ2ovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57CD152B;
	Mon, 28 Jul 2025 04:56:40 -0700 (PDT)
Received: from [10.57.87.40] (unknown [10.57.87.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543033F673;
	Mon, 28 Jul 2025 04:56:46 -0700 (PDT)
Message-ID: <ad29f800-34e3-45c4-afd6-3661b9cfaec3@arm.com>
Date: Mon, 28 Jul 2025 12:56:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Fix use-after-free due to race between memory
 hotunplug and ptdump
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, maz@kernel.org, stable@vger.kernel.org
References: <20250728103137.94726-1-dev.jain@arm.com>
 <f0e12d1e-110d-4a56-9f77-8fe2d664b0d1@arm.com>
 <ebbd54a7-1d84-4a47-8a66-394bdcb53d65@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ebbd54a7-1d84-4a47-8a66-394bdcb53d65@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/07/2025 12:31, Dev Jain wrote:
> 
> On 28/07/25 4:43 pm, Ryan Roberts wrote:
>> On 28/07/2025 11:31, Dev Jain wrote:
>>> Memory hotunplug is done under the hotplug lock and ptdump walk is done
>>> under the init_mm.mmap_lock. Therefore, ptdump and hotunplug can run
>>> simultaneously without any synchronization. During hotunplug,
>>> free_empty_tables() is ultimately called to free up the pagetables.
>>> The following race can happen, where x denotes the level of the pagetable:
>>>
>>> CPU1                    CPU2
>>> free_empty_pxd_table
>>>                     ptdump_walk_pgd()
>>>                     Get p(x+1)d table from pxd entry
>>> pxd_clear
>>> free_hotplug_pgtable_page(p(x+1)dp)
>>>                     Still using the p(x+1)d table
>>>
>>> which leads to a user-after-free.
>> I'm not sure I understand this. ptdump_show() protects against this with
>> get_online_mems()/put_online_mems(), doesn't it? There are 2 paths that call
>> ptdump_walk_pgd(). This protects one of them. The other is ptdump_check_wx(); I
>> thought you (or Anshuman?) had a patch in flight to fix that with
>> [get|put]_online_mems() too?
>>
>> Sorry if my memory is failing me here...
> 
> Nope, I think I just had a use-after-free in my memory so I came up with this
> patch :)
> Because of the recent work with ptdump, I was so concentrated on
> ptdump_walk_pgd() that I
> didn't even bother looking up the call chain. And I even forgot we had these
> [get|put]_online_mems()
> patches recently.

I just checked; Anshuman's fix is in mm-stable, so I guess it'll be in v6.17-rc1.

That's the patch:
https://lore.kernel.org/linux-arm-kernel/20250620052427.2092093-1-anshuman.khandual@arm.com/

> 
> Sorry for the noise, it must have been incredibly confusing to see this patch :(
> 


