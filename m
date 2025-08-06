Return-Path: <linux-kernel+bounces-757411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8487B1C1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E335189090B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8E220F49;
	Wed,  6 Aug 2025 08:11:27 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6C22068D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467887; cv=none; b=AxdHlOxfIlsfiBA0JzGdETaAxXpV3Iy7mMOufHCs0UkIHkGUxC02dKEvDDRmfFkW6QQxwp9yYWbeifSGtxmn1vpS1QgsW+BJEVotgkkcWDQfbzUPBRy4/yL49rhq2KDqdmEhujHErusCJucLVwVOhxmcsqicEGLDW4Yzb1F1+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467887; c=relaxed/simple;
	bh=cAlHEHY1OKbXWP86uf1+jjE/xWYHd3wLTdajiZOm9Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iYNMwoMmEN9aTP2892AsHH4DX4VZc1ymbcekXrHClq6v+AEjK+qZ18NRoUJTDiaKcFIIYZzhujJWTfRxfI7C6i14pKogd6e4HxHdH8Bgsc3HqsO5Cl20fdWJNKzBbmtjZkaPb8L+pzzu01v0BH4Y+YmfrAicKURqVZafCfwpecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bxjYD0qPnz14ML1;
	Wed,  6 Aug 2025 16:06:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 55C9114022F;
	Wed,  6 Aug 2025 16:11:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 16:11:19 +0800
Message-ID: <94757d00-5a8e-ac6b-f832-030f33ccf771@huawei.com>
Date: Wed, 6 Aug 2025 16:11:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 0/7] arm64: entry: Convert to generic irq entry
Content-Language: en-US
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <puranjay@kernel.org>,
	<broonie@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<akpm@linux-foundation.org>, <chenl311@chinatelecom.cn>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <6bd09b5b-9830-42b4-ad9e-9ad1e153e564@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <6bd09b5b-9830-42b4-ad9e-9ad1e153e564@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/5 23:08, Ada Couprie Diaz wrote:
> Hi Jinjie,
> 
> On 29/07/2025 02:54, Jinjie Ruan wrote:
> 
>> Since commit a70e9f647f50 ("entry: Split generic entry into generic
>> exception and syscall entry") split the generic entry into generic irq
>> entry and generic syscall entry, it is time to convert arm64 to use
>> the generic irq entry. And ARM64 will be completely converted to generic
>> entry in the upcoming patch series.
> Note : I had to manually cherry-pick a70e9f647f50 when pulling the series
> on top of the Linux Arm Kernel for-next/core branch, but there might be
> something I'm missing here.
>>

It seems that it is now in mainline v6.16-rc1 and linux-next but not
Linux Arm Kernel for-next/core branch.

[...]

> I'll spend some time testing the series now, specifically given patch 6's
> changes, but other than that everything I saw made sense and didn't look
> like it would be of concern to me.

Thank you for the test and review.

> 
> Thanks,
> Ada
> 

