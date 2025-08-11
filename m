Return-Path: <linux-kernel+bounces-762987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7544B20D41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BAA1884E24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BF2DFA38;
	Mon, 11 Aug 2025 15:13:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D72242D78
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925205; cv=none; b=ozjT641mdRLWVWJ8vwFa59DUS/J3uDZ2BrPTLcoIxfOzSgMBuch/URls2E8o8xLX4uND53lI57KHS6H9/s23ADYKuxwrYjb/sZEaoDB/F4Ked+mWjYiLd9UvmdOaPAKYQHEH+BqOgOL5oYH5DYDYItaSogosRFu9w49K5XTqKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925205; c=relaxed/simple;
	bh=4W/11+sc8YtcMjDi019XSwNvM1W68tMUjZsPFTj3LTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLftYN6Q9KYz4Ii1oh5efhOM3na3mkIHUDG0XDWG8mrM2FNP1qjhE547l93MLXO3tUsroUmAAHC2hY1qj5HmYOWox0IzbWnVbrCLDgDju1JcdkjymiBJ3VFudPFS22gPgQ+9mcuaOAlkFYmbcNTyXCrWXrLV8tlt1d5j7QGdBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E58C2661;
	Mon, 11 Aug 2025 08:13:14 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7C43F63F;
	Mon, 11 Aug 2025 08:13:22 -0700 (PDT)
Message-ID: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
Date: Mon, 11 Aug 2025 10:13:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org,
 bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de,
 nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Lameter <cl@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250808025533.6422-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/7/25 9:55 PM, Huang Shijie wrote:
> In the server, if some workload which will create lot of
> tasks, and will have many task migrations, we can get better
> performance when we enable the CONFIG_SCHED_CLUSTER.
> 
> For example, the Specjbb may have better performance:
>      Critical-jops : 26%
>      Max-jops      : 7%
> 
> So enable it by default.

 From what I've seen, SCHED_CLUSTER seems to be a bit of give and take 
depending on benchmark and machine. I'm not sure if it should be default 
enabled or not, but it would really be nice to have at least a larger 
sweep of benchmarks/machines in order to be sure of the decision.


Thanks,


> 
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 58f87d09366c..054c96ea2235 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -82,6 +82,7 @@ CONFIG_ARCH_VISCONTI=y
>   CONFIG_ARCH_XGENE=y
>   CONFIG_ARCH_ZYNQMP=y
>   CONFIG_SCHED_MC=y
> +CONFIG_SCHED_CLUSTER=y
>   CONFIG_SCHED_SMT=y
>   CONFIG_NUMA=y
>   CONFIG_XEN=y


