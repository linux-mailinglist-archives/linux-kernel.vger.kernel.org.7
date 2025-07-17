Return-Path: <linux-kernel+bounces-734518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17718B082AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887951AA585B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1E1A4E70;
	Thu, 17 Jul 2025 02:00:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1392E36F3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717657; cv=none; b=NB+bT+f2Uff3ThMS7ayOyNKDVFo1JrsuzfPPznzAqg0aX5vuJxmYiOmkPFf1TwxS7ZsQyRXIYGv/oC7a97RI1w1yh06xYQntbSIp7ry3Q+o3PKl+8LkpfRtJbfyRJW0nTf980xLrmI6oYSsTkoB3FgicfXsFD0Yjqg78rrvegH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717657; c=relaxed/simple;
	bh=kYiRtY0WtLx6HxDc9u68HzXYDf75iIxVrXgDAuu5g5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YwLuC4L5nAGK0pzE5d7iICHenlRmN1Ar5K0qXEzWt+18FXuYKxMdVvxS4IiZjRWeUI6kuhKxWBkgBZxF3YHqntU6fnfp+UfH4CBF3Agt4ArQnR/SeWBYCLKzCrIGZV4tzOTRI3vSxDjX9OEuAgKsrTljdu9x5+w3bdllRJR3KJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bjGHw4xl0zdbwV;
	Thu, 17 Jul 2025 09:56:44 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A02C18007F;
	Thu, 17 Jul 2025 10:00:52 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 10:00:51 +0800
Message-ID: <fa509f25-cbd6-41d5-8f34-bbd45062a8b7@huawei.com>
Date: Thu, 17 Jul 2025 10:00:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG
Content-Language: en-US
To: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Pu Lehui <pulehui@huaweicloud.com>
References: <20250711090443.1688404-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250711090443.1688404-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/7/11 17:04, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> The implement of cmpxchg() in riscv is based on atomic primitives and
> has NMI-safe features, so it can be used safely in the in_nmi context.
> ftrace's ringbuffer relies on NMI-safe cmpxchg() in the NMI context.
> Currently, in_nmi() is true when riscv kprobe is in trap-based mode, so
> this config needs to be selected, otherwise kprobetrace will not be

Gentle ping~

The issue can be reproduced by the following steps:

cd /sys/kernel/debug/tracing/
echo 'p do_nanosleep' > kprobe_events
echo 1 > events/kprobes/enable
sleep 1
cat trace # trace log will not show without this patch

> available.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 36061f4732b7..0e2dfa98338a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>   	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> +	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select ARCH_HAS_BINFMT_FLAT
>   	select ARCH_HAS_CRC32 if RISCV_ISA_ZBC
>   	select ARCH_HAS_CRC64 if 64BIT && RISCV_ISA_ZBC

