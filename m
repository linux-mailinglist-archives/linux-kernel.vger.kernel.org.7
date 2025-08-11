Return-Path: <linux-kernel+bounces-761778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C9B1FE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564A47A6B83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7A1F1501;
	Mon, 11 Aug 2025 04:30:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F142E36EC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754886649; cv=none; b=VTxh6GGYqaETyJKsLlRrtpReHDqrV+oOJ4ySzZPyrBUjM3FJy7XZfmAmOJfmwvaNvCRdAItVOSGuv3KrRG0mFMuEMOKvNhnXoEYSfzmgD5H9pu9GaHKfR+tU1U/XX6k0G7ZQPw1hw3EigbFXqr2m95W5OgYEMXO4ZTu0L+xUX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754886649; c=relaxed/simple;
	bh=ueQumUwAo5IpzfbQ7R54BLpxcRLOIHECZFnRr0z8Y00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxLzaOB/Ly2RdglFKJDLheiYjoXh5B0B1efvI/DL1yI2iWZz/TvrQtFsRljFen8k92CaLHiy+xluwRrXKxB39E5SgjolpLRcWTBnuUHgtVxsysJ92Q6EwPeiYIWeJVd5CUjwoQEg7c4/UOwJpNeo700sjE9e3K4I4a1am/QwShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1630152B;
	Sun, 10 Aug 2025 21:30:37 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695A93F738;
	Sun, 10 Aug 2025 21:30:42 -0700 (PDT)
Message-ID: <b33b6dfe-8270-4cee-bd66-1940f86b6e09@arm.com>
Date: Mon, 11 Aug 2025 10:00:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove unnecessary pointer variables
To: Xichao Zhao <zhao.xichao@vivo.com>, ryabinin.a.a@gmail.com,
 akpm@linux-foundation.org
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250811034257.154862-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250811034257.154862-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/25 9:12 AM, Xichao Zhao wrote:
> Simplify the code to enhance readability and maintain a consistent
> coding style.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  mm/kasan/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ced6b29fcf76..e5810134813c 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -266,11 +266,9 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  		}
>  
>  		if (pgd_none(*pgd)) {
> -			p4d_t *p;
>  
>  			if (slab_is_available()) {
> -				p = p4d_alloc(&init_mm, pgd, addr);
> -				if (!p)
> +				if (!p4d_alloc(&init_mm, pgd, addr))
>  					return -ENOMEM;
>  			} else {
>  				pgd_populate(&init_mm, pgd,

Agreed that p4d_t pointer here is just redundant.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

