Return-Path: <linux-kernel+bounces-757185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD882B1BECC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8074A1898D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF25BAF0;
	Wed,  6 Aug 2025 02:31:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A62F56
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754447518; cv=none; b=X0jSa92onZcGCfQJE0G1OlOWPBZHYY9BlY8fBJTfrXz8J3pfcfS/UwD3/e09SGifLbT0+rnKBfxy3BlWUWzUu8DoLq4XiaUyeeXKD2T+x2qPTw4sI3K013RjOEVtuqfzPlum42ur9FR0Eaq/Dr4e41/krHHqHGOOqfa22nEVEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754447518; c=relaxed/simple;
	bh=2RTUAeTKmcQfuCegpbfhDHWI/muhKo8tFLXj212Bs4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fwAPy2i4gA72ZHUx/5Pkytw+VNbNd/vzBAimg5saNeufZBDx4RlqEFoDdr4QLokkyTIG3veNpiA/DE8+7hGeX3kOhN8aCel88OZCf8TUudipHAMcBZjpfrR7eJvNMyqPVoUHOVNPaQ43tNucrLUV38KPpgjsm1Ge3mm5P0Y4ZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bxZ3V1z9wz13N1Z;
	Wed,  6 Aug 2025 10:28:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C3F3140146;
	Wed,  6 Aug 2025 10:31:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 10:31:51 +0800
Message-ID: <36bd2bb2-31c8-e38f-e420-407742ccc3cc@huawei.com>
Date: Wed, 6 Aug 2025 10:31:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 1/7] arm64: ptrace: Replace interrupts_enabled()
 with regs_irqs_disabled()
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
 <20250729015456.3411143-2-ruanjinjie@huawei.com>
 <beb7e8f2-39f8-499f-a173-b8bf2d3296ea@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <beb7e8f2-39f8-499f-a173-b8bf2d3296ea@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/5 23:05, Ada Couprie Diaz wrote:
> On 29/07/2025 02:54, Jinjie Ruan wrote:
> 
>> The generic entry code expects architecture code to provide
>> regs_irqs_disabled(regs) function, but arm64 does not have this and
>> provides inerrupts_enabled(regs), which has the opposite polarity.
> Nit: "interrupts_enabled(regs)"

Good catch! thank you for the review.

>> In preparation for moving arm64 over to the generic entry code,
>> relace arm64's interrupts_enabled() with regs_irqs_disabled() and
>> update its callers under arch/arm64.
>>
>> For the moment, a definition of interrupts_enabled() is provided for
>> the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
>> can be removed.
>>
>> Delete the fast_interrupts_enabled() macro as it is unused and we
>> don't want any new users to show up.
>>
>> No functional changes.
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
> Otherwise looks good to me !
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 

