Return-Path: <linux-kernel+bounces-854392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A30BDE42D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF35C4E94B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A531AF1D;
	Wed, 15 Oct 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y/IowBSL"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9B2D8DD1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527561; cv=none; b=T09UBKhKy/yjCuW4jonaD/SsrI3t0XkV8Gsx8Xnu31+KoHYRpLzftr8rNloA/RzTzIiVHfD6YPP4TkPvX3A6UGKNm1puS9a+iAWBA7D3Lr1C2ah60pOreW2KS7aZDFVbWyg7oOsmFkWDnCd5q5dnOmDS/jasrpQBhKwo9obqHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527561; c=relaxed/simple;
	bh=0NbSaRj9c/IM4GLtjUoI3bltUoz+QAH3eYE3Q4OXx90=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p3YXPEy9j7uZCbYgAHqqO5BINwCEN7izf2ToOjb6Sh2xjnfUYAVoEGb3juA2ItYMQjVLaS1gxqLtiyY6ooALgOlwRQ5VC4BFudDn5fjqzw/SU7bFAyVdCbBy3R7NtvoqmuWxnZDqeiCA1V/xe/YDRZCRYEsDjOUA9FPZCAuo7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y/IowBSL; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c+s5ufsbM4de2ozJVwmJOUwsTUW4s0vdVuHE3vQrGIk=;
	b=Y/IowBSLSq1NO6xzjp4FJbgZWy3bRzxWhz1135maJH5D9nfbyxW+QshoKMYXdTuSwBZPdWIyw
	5QvEtL1EzRpBmce/b4EtbQndkHfMSyNsG5XcbAUxsdT3eRDaqttTCO1QJV8V0jkG+ohU9GZdd/Y
	oJsFdXg3XxXgcAg8jQyOXmY=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cmpfG1K9Dz12LFd;
	Wed, 15 Oct 2025 19:25:10 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 4130D180B72;
	Wed, 15 Oct 2025 19:25:55 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 19:25:54 +0800
Subject: Re: [PATCH] arm64: defconfig: Remove the redundent SCHED_MC/SCHED_SMT
To: Huang Shijie <shijie@os.amperecomputing.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>,
	<patches@amperecomputing.com>, <cl@linux.com>,
	<Shubhang@os.amperecomputing.com>, <linux-arm-kernel@lists.infradead.org>,
	<krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
References: <20251014023158.500932-1-shijie@os.amperecomputing.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8dff1052-d524-5702-6f58-bbe192d80672@huawei.com>
Date: Wed, 15 Oct 2025 19:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251014023158.500932-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/10/14 10:31, Huang Shijie wrote:
> The patch "7bd291abe2d sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig"
> has enabled the SCHED_MC/SCHED_SMT by default for arm64.
> 
> So remove the redundent code in defconfig.

s/redundent/redundant/

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd104..f089ec615b90 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -82,8 +82,6 @@ CONFIG_ARCH_VEXPRESS=y
>  CONFIG_ARCH_VISCONTI=y
>  CONFIG_ARCH_XGENE=y
>  CONFIG_ARCH_ZYNQMP=y
> -CONFIG_SCHED_MC=y
> -CONFIG_SCHED_SMT=y
>  CONFIG_NUMA=y
>  CONFIG_XEN=y
>  CONFIG_COMPAT=y

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui

