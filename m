Return-Path: <linux-kernel+bounces-753509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C964BB183FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896863AA71C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680826CE07;
	Fri,  1 Aug 2025 14:36:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C4246786
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058980; cv=none; b=pvigMTlQk7whH1z1gYFkQwQRg10Fe9GSbGgxQxbDsHPtPS0da4sclgPNCMePTGcEk+Bz2C1ZU+aIAYN1NYvn2LyxKg1a+m7PHnniGAsrST/XNiG0olutYWbVFxIJ35sQ+tjPAR4HlY7bE21lqJZxSD9S1UMzi1Lmb673nJqUT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058980; c=relaxed/simple;
	bh=ejlyUVhre2fZUpK0Dyy7rXpKDrU0As1y7vfdrQGpPrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRVjOcyBUsowAdP/iCnplrIzsJ/Q1TTSuiqyREELYKvjQpfqBaoEUhTpSftc1UcTjJ4BnQiO24QPn+CY6WIhSjnkT6g6YswRp7QsivwzWHHFmKNjPVxc/KEDXe2Rn41KxcJrSmHKoDhYB6jrfemsuM5CQJLisWw2DENxWiCOPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CBD1516;
	Fri,  1 Aug 2025 07:36:09 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C13DA3F673;
	Fri,  1 Aug 2025 07:36:15 -0700 (PDT)
Message-ID: <bb17a56c-00ea-4dcf-906f-e77de212c95f@arm.com>
Date: Fri, 1 Aug 2025 15:36:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: cpufeature: add AmpereOne to BBML2 allow list
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-3-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250724221216.1998696-3-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 23:11, Yang Shi wrote:
> AmpereOne supports BBML2 without conflict abort, add to the allow list.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7a3c404288d5..d2a8a509a58e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2230,6 +2230,8 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
>  	static const struct midr_range supports_bbml2_noabort_list[] = {
>  		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>  		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>  		{}
>  	};
>  


