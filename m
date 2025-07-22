Return-Path: <linux-kernel+bounces-740073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C6B0CF47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648281C21A60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BF1B4F08;
	Tue, 22 Jul 2025 01:47:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C551DDA3E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148862; cv=none; b=gQXCP6zQqYuz70gDyUJL6y13EW7RUV4SDcjU1sHEL/eDPwLcTCEzhq2voYj/YyHI3Px2+vggBRw+ap/pjfFj+n+gPRosZdeIoZE48Q+6phUHJ9jn6CYaXvBdvDqG+d/NUJ0/a+omudu4rBZcv4oK7lg2Lk0TGr2WGJvrRMchF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148862; c=relaxed/simple;
	bh=oI8lChqLMTPlFSYYmRKPwGhNfQDFW/EmvyD6oTzAjv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MMezmGFnJPMCnzMxk5fmq8u3Lnf+WrDffU4KDe8LhC04pjJDSTLty9jv7ciqTfzlt4jgX5Pgmjj0Yk89XEveftLaRgEmGsAYym3C/9l+bHtV4H3ThwuP1rZiZ4ywU03n2/vsgF/roVNG0RzWPKTTZI6C7A/xxi28We/eyMxpais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bmKpY56Yjz2FbQq;
	Tue, 22 Jul 2025 09:45:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D62E71A0191;
	Tue, 22 Jul 2025 09:47:36 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 09:47:31 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 09:47:30 +0800
Message-ID: <1b17f637-ecba-43cc-8ca6-e4bb73bd152e@huawei.com>
Date: Tue, 22 Jul 2025 09:47:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] SCTLR_EL1.TIDCP toggling for performance
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>
CC: <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <sashal@kernel.org>,
	<yangjiangshui@h-partners.com>, <zouyipeng@huawei.com>, <justin.he@arm.com>,
	<zengheng4@huawei.com>, <yangyicong@hisilicon.com>, ruanjinjie
	<ruanjinjie@huawei.com>
References: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
 <4b010cc5-9244-450d-9a03-4ff6bf5c9a20@arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <4b010cc5-9244-450d-9a03-4ff6bf5c9a20@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200011.china.huawei.com (7.202.195.155)



在 2025/7/19 1:28, Kristina Martšenko 写道:
> Hi Chang,
> 
> On 18/07/2025 03:32, Liao, Chang wrote:
>> Hi, Kristina
>>
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
>>
>> Thanks
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/Yrw3NWkH6D0CgRsF@sirena.org.uk/T/#m5cfdb27b48d9d7e30db73e991fc6c232ba8a7349
> 
> I don't have any plans to add support for toggling it. You could try sending a
> patch for a Kconfig option or kernel command-line parameter. I'm not really

Kristina, I am going to send a patch for command-line paramter as Catalin suggested.

Thanks.

> sure what the maintainers' view on supporting IMP-DEF features is.
> 
> Thanks,
> Kristina
> 
> 

-- 
BR
Liao, Chang


