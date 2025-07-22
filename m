Return-Path: <linux-kernel+bounces-740071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0FB0CF44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F379C3B2BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5491A8F60;
	Tue, 22 Jul 2025 01:47:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BCBA2E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148849; cv=none; b=VAPNYGac97gZ3Ftfdc3tl/SpzukrKIEK4FUU34a4o7xGn4QMZSEHM1nDKr5+2FipQehlOgJ33jtTzQ7I3yuXC3nDu94adsrEfYwi+nPLvYflY1n5J2KQZCvRO5bseambBHEl3bwPxtHzUu20/TP8tHwBMWOLsBMkQkF8HMcqzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148849; c=relaxed/simple;
	bh=QEf8gRu6CbJlbgIes0s2sFChPCGsXGhPHEpLakDwMqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QbYE/QJSgl6xkPSdp6v9By3cm6KonMDKP/PExBvutiEb6NTdcNAnYtzvPEnZP4uCsHqg4iSoZfmUlJL0rNhcpHEqhuG6e5eXywdVb/d/uKNPpuZ38PaZ4mZ5XdP+Sz0nMA8zIb0x068krfkk+zJAvZ0SM53v0lFervMh1BmUWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bmKlB38Wjz14M4L;
	Tue, 22 Jul 2025 09:42:30 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C4902140275;
	Tue, 22 Jul 2025 09:47:19 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 09:47:19 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 09:47:18 +0800
Message-ID: <d84b1955-3ee5-4c12-ba3c-1a45ac4d3700@huawei.com>
Date: Tue, 22 Jul 2025 09:47:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] SCTLR_EL1.TIDCP toggling for performance
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <kristina.martsenko@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<sashal@kernel.org>, <yangjiangshui@h-partners.com>, <zouyipeng@huawei.com>,
	<justin.he@arm.com>, <zengheng4@huawei.com>, <yangyicong@hisilicon.com>,
	ruanjinjie <ruanjinjie@huawei.com>, <inux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
 <aHqamaqueuk18NyS@arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <aHqamaqueuk18NyS@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200011.china.huawei.com (7.202.195.155)



在 2025/7/19 3:03, Catalin Marinas 写道:
> On Fri, Jul 18, 2025 at 10:32:00AM +0800, Liao, Chang wrote:
>> I've reviewed your patch [1] for FEAT_TIDCP1 support, which by default traps EL0
>> accesses to implementation-defined system registers and instructions at EL1/EL2.
>>
>> Do you have any plans to add support for toggling the SCTLR_EL1.TIDCP1 bit? I'm
>> encountering performance degradation on CPU where certain implementation-defined
>> registers and instructions are designed for EL0 performance use. The trapping
>> overhead is substantial enough to compromise any benefits, and it's even worse
>> in virtualization. Therefore, I'm hoping there's a way to clear the SCTLR_EL1.TIDCP1
>> bit on such platforms, perhaps via a kernel config option or command-line parameter.
>> Alternatively, do you have a better solution for gracefully toggling this bit on
>> and off?
> 
> Given that we don't know what imp def functionality is available, what
> side-effects it has, we should not allow user-space to toggle such bit,
> nor allow the user access to those registers.
> 
> System-wide, passing id_aa64mmfr1.tidcp1=0 on the kernel command line
> may work.

Thanks for the suggestion. I'll prepare a patch to support id_aa64mmfr1.tidcp1=0
on the kernel command line.

> 

-- 
BR
Liao, Chang


