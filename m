Return-Path: <linux-kernel+bounces-809249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E707B50A92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54183460C55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1122541B;
	Wed, 10 Sep 2025 01:57:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762A2264A3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469430; cv=none; b=C2tEpxckQyiB1t/9dXnkOA2/7+V37EFW5aw8O92eTZBa3oouQnxeFkWQNRgoEHcMQQkJZZWMESLw3nGzYGVTzfPcKfuPbO7NVBqzITitKMaPmuZ5WMl0IezWkVt0lwUlR6GepmJCgKt/Ufr20V9eUCWmfqxS2a0ol9ZIfIK1+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469430; c=relaxed/simple;
	bh=RX/t6MerktExpMKbfQkJZQmYXZCV0tobve1MAfY2Pf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TVXUlLEjsxhaWxvy/5zlhHk1JbLVQ+exzOSqRGzSzFk8V/Meeagb08aeu+fRu148Koj2WOiPdoRuoXu6Wv1/OjigLkxprF8Flg+PV33uluAa2SphphXU7iRKYFiKVWh3FBW2RqXGewa9V5Bn+OiwM6+wFN8FnMCGcyRRYpu1lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cM3d81N7Tz24j2j;
	Wed, 10 Sep 2025 09:53:48 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DF701A0188;
	Wed, 10 Sep 2025 09:57:03 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 09:57:02 +0800
Message-ID: <6a5c32ae-c897-40a4-a5b9-20c77496760d@huawei.com>
Date: Wed, 10 Sep 2025 09:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: arm64: Make ID_AA64MMFR1_EL1.HCX writable
 from userspace
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
CC: <yuzenghui@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<liuyonglong@huawei.com>, <wangzhou1@hisilicon.com>
References: <20250909034415.3822478-1-yangjinqian1@huawei.com>
 <20250909034415.3822478-2-yangjinqian1@huawei.com>
 <aL_SIwQiz3QO1fKe@linux.dev> <86ldmoc4x7.wl-maz@kernel.org>
 <aMCeY0vvWTORB6E_@linux.dev>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <aMCeY0vvWTORB6E_@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)



On 2025/9/10 5:38, Oliver Upton wrote:
> On Tue, Sep 09, 2025 at 11:10:28AM +0100, Marc Zyngier wrote:
>> On Tue, 09 Sep 2025 08:07:15 +0100,
>> Oliver Upton <oliver.upton@linux.dev> wrote:
>>>
>>> On Tue, Sep 09, 2025 at 11:44:13AM +0800, Jinqian Yang wrote:
>>>> Allow userspace to downgrade HCX in ID_AA64MMFR1_EL1. Userspace can
>>>> only change this value from high to low.
>>>>
>>>> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
>>>
>>> I'm not sure our quality of emulation is that great in this case. We
>>> have no way of trapping the register and it is always stateful. Better
>>> yet, our RESx infrastructure doesn't account for the presence of
>>> FEAT_HCX and we happily merge the contents with the host's HCRX.
>>
>> Yeah, that's not good, and definitely deserves a fix.
>>
>>> We should make a reasonable attempt at upholding the architecture before
>>> allowing userspace to de-feature FEAT_HCX.
>>
>> My concern here is the transitive implications of FEAT_HCX being
>> disabled: a quick look shows about 20 features that depend on
>> FEAT_HCX, and we don't really track this. I can probably generate the
>> dependency graph, but that's not going to be small. Or very useful.
>>
>> However, we should be able to let FEAT_HCX being disabled without
>> problem if the downgrading is limited to non-EL2 VMs. Same thing for
>> FEAT_VHE.
>>
>> What do you think?
> 
> So I'm a bit worried about making fields sometimes-writable, it creates
> a very confusing UAPI behavior. On top of that, our writable masks are
> currently static.
> 
> What if we treat the entire register as RES0 in this case? It seems to
> be consistent with all the underlying bits / features being NI. A
> mis-described VM isn't long for this world anyway (e.g. FEAT_SCTLR2 && !FEAT_HCX)
> and in that case I'd prefer an approach that keeps the KVM code as
> simple as possible.
> 
> We do, after all, expect some level of sanity from userspace of feature
> dependencies as we do not enforce the dependency graph at the moment.
> Hell, this could be useful for someone cross-migrating a nested VM from
> a machine w/o FEAT_HCX to one that has it.
> 

Making HCX writable is very useful, as it allows VMs to migrate between 
machines that support and do not support FEAT_HCX. For non-EL2 VMs, we 
have tested that migration works without issues :)

Thanks,
Jinqian


