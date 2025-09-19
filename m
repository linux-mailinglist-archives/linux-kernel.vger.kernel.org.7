Return-Path: <linux-kernel+bounces-824356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3C5B88C27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62851C813D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50642D24BA;
	Fri, 19 Sep 2025 10:08:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041B253351
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276533; cv=none; b=BAeP0ZWQ2Bt0iYKXdwupnKVS1ccjJYTsR4Al7nqmPUmQ4SCDzm315SQ1sNMyAzgr6RE7ZpKOQm7y3IkVMvino3C61ydW3nMpuFwZWaTebcJghdLLZfD1Sr7XG4e7Y9ojhQD9k6uXSwAUrY366OKpCdxDqEWf7Iz6rcxw0r+NCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276533; c=relaxed/simple;
	bh=OFXjUK4nxg8Rf6DBYK58/URNLBfNsLJ8MwVo1pSbRGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy7Nro4/cnJyfgYtqjx7R+HVA3pu19uKrTTsa5YlWBnSzNYmvgO9heXXwZ7yLCmu0PkEljVFAHYT8G17rFngYqZ6hBZmlhovjYioVWStBHlB9/jDMoJ9iBWjteThve7In5EKNLTJW/3myCV3kWCIt9XXGJatceZyUastaanRN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E6D1692;
	Fri, 19 Sep 2025 03:08:43 -0700 (PDT)
Received: from [10.57.95.38] (unknown [10.57.95.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D058D3F673;
	Fri, 19 Sep 2025 03:08:48 -0700 (PDT)
Message-ID: <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
Date: Fri, 19 Sep 2025 11:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ardb@kernel.org, dev.jain@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, Yang Shi <yang@os.amperecomputing.com>
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 22:10, Will Deacon wrote:
> On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
>> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
>> with large blocks, even when rodata=full, and leads to some nice performance
>> improvements.
>>
>> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
>> modes by hacking the BBML2 feature detection code:
>>
>> [...]
> 
> Applied patches 1 and 3 to arm64 (for-next/mm), thanks!
> 
> [1/5] arm64: Enable permission change on arm64 kernel block mappings
>       https://git.kernel.org/arm64/c/a660194dd101
> [3/5] arm64: mm: support large block mapping when rodata=full
>       https://git.kernel.org/arm64/c/a166563e7ec3
> 
> I also picked up the BBML allow-list addition (second patch) on
> for-next/cpufeature.
> 
> The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
> on secondary CPUs") has some really horrible conflicts. These are partly
> due to some of the type cleanups on for-next/mm but I think mainly due
> to Kevin's kpti rework that landed after -rc1.

Thanks Will, although I'm nervous that without this patch, some platforms might
not boot; Wikipedia tells me that there are some Google, Mediatek and Qualcomm
SoCs that pair X4 CPUs (which is on the BBML2_NOABORT allow list) with A720
and/or A520 (which are not). See previous mail at [1].

I'd be happy to rebase it if you can let me know the prefered base SHA/tree?

[1]
https://lore.kernel.org/linux-arm-kernel/11f84d00-8c76-402d-bbad-014a3542992f@arm.com/

Thanks,
Ryan


> 
> So I think the best bet might be to leave that one for next time, if
> that's ok?
> 
> Cheers,


