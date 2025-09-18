Return-Path: <linux-kernel+bounces-809241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCCB50A67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583DA565C39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAB214A97;
	Wed, 10 Sep 2025 01:42:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EC212FA0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468558; cv=none; b=COxXab4EFEO5O8Eu8GAO1+PsarLYyaBUZQC9DGzMhbHSXyhpL3qsZw87z6XtsUK3xf90Gvn226SYokY2PXT9UcsqqVQVNWyhUliFjz+wAnFhyrKjT+TTeN2kPOx9XcgyqCb/5TxiRMm9UTB9zZ2mlmruEPOp6iC4PWwhXHkmjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468558; c=relaxed/simple;
	bh=h5ic6/9akUbwtAWeg2F7MKdX9r1RkY/8JNuc6bC+cjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YFtqpsk+vxw4fTaYv01iO54hBj8Lkp7eKaV2NDedtm/th7yQfXIo3zbjbEgDd9FGTqL0L+mexmsDfeJ3cFKCZULZuI1vRhBtLhPVGL715G0RRAAeHjowBakQfiONHcssxQdHjYKnGWOuNUYHn0V62uI/EZ5k9oCYb0ikmESfo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cM3Gs2y4DzRk6r;
	Wed, 10 Sep 2025 09:37:57 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 63692180491;
	Wed, 10 Sep 2025 09:42:34 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 09:42:33 +0800
Message-ID: <6a1ec9d7-f41b-4ea2-a42c-26eec9591195@huawei.com>
Date: Wed, 10 Sep 2025 09:42:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] KVM: arm64: make EL2 feature fields writable in
 ID_AA64MMFR1_EL1
To: Oliver Upton <oliver.upton@linux.dev>
CC: <yuzenghui@huawei.com>, <maz@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>
References: <20250909034415.3822478-1-yangjinqian1@huawei.com>
 <aL_QjZbkvHsYIRt6@linux.dev>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <aL_QjZbkvHsYIRt6@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)



On 2025/9/9 15:00, Oliver Upton wrote:
> On Tue, Sep 09, 2025 at 11:44:12AM +0800, Jinqian Yang wrote:
>> Allow userspace to downgrade EL2 features (VH, TWED, HCX) to ensure VM live
>> migration compatibility between hosts with varying feature support.
>>
>> v1: https://lore.kernel.org/linux-arm-kernel/20250325121126.1380681-1-yangjinqian1@huawei.com/
>>
>> Change Log:
>> v1->v2:
>>    -Added support for downgrading TWED and VH fields.
>>    -Added corresponding test cases to the set_id_regs selftest.
>>
>> Jinqian Yang (3):
>>    KVM: arm64: Make ID_AA64MMFR1_EL1.HCX writable from userspace
>>    KVM: arm64: Make ID_AA64MMFR1_EL1.TWED writable from userspace
>>    KVM: arm64: Make ID_AA64MMFR1_EL1.VH writable from userspace
>>
>>   arch/arm64/kvm/sys_regs.c                       | 3 ---
>>   tools/testing/selftests/kvm/arm64/set_id_regs.c | 3 +++
> 
> General comment: please make do kernel and selftest changes in separate
> patches.
> 

Will be changed in v3.

Thanks,
Jinqian


