Return-Path: <linux-kernel+bounces-753951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64781B18A87
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5EE1AA66EA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B517332C;
	Sat,  2 Aug 2025 03:06:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E228F4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754103999; cv=none; b=XkUvNhvwTIp/s4yqTExcT7YdUxcUfVLUOI4CoAewoWdPNdlD+aNvsTnbrFrgxc2B/267BZ3exgmVE/1GajLy90yUYLHEryHW3FdiScxrclsMChHiidf3WMt1ZSDcyJuT8BZ8JvCn/wdzcdbvm54r+KJ0cm5wr9GbZ3HQPPmCvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754103999; c=relaxed/simple;
	bh=K8bdWHfuoEAzNQJuZ26PtlrLfng2ppjdMXAQsJYU5YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bbBTEH7mVdjNzBpoaHZBZ7eVMsGnbpUyLestxcsa5448TUa5uY7rWOM8IWH5J3IZmLGKV9A1j4BAlAAKTWVgrabg5L+qn1zT88cpaFUKYPsQKfW9Qph3Lh4IagAGBeCuT8kFvWmR9bYMJZHlEc7uOAzenXG0zlYdQWTihljg9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bv71b2ntLz2TSv1;
	Sat,  2 Aug 2025 11:03:31 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 31C0814027A;
	Sat,  2 Aug 2025 11:05:57 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 2 Aug 2025 11:05:56 +0800
Message-ID: <835eae02-3f7b-42b8-b237-437699c8103f@huawei.com>
Date: Sat, 2 Aug 2025 11:05:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding the Issue of vNMI Not Supporting Live Migration
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
	Luchunhua <luchunhua@huawei.com>, liuyonglong <liuyonglong@huawei.com>,
	"xuwei (O)" <xuwei5@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <c7bc0979-3721-49ba-89bd-ebcaa5ce70d9@huawei.com>
 <86wm7n6ya2.wl-maz@kernel.org>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <86wm7n6ya2.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)



On 2025/8/1 20:07, Marc Zyngier wrote:
> On Fri, 01 Aug 2025 09:00:07 +0100,
> Jinqian Yang <yangjinqian1@huawei.com> wrote:
>>
>> Hi，marc
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm64/nmi
>>
>> During the testing of this set of vNMI patches, it was discovered that
>> vNMI do not support live
>> migration. The reason is that GICD_INMIR/GICR_INMIR0 have not been
>> migrated, causing
>> irq->nmi to reset to 0 after migration. Therefore, to resolve this
>> issue, we need to complete the
>> migration of GICD_INMIR/GICR_INMIR0. This set of patches does not seem
>> to have been uploaded
>> to the mainline. I was wondering if these are scheduled for upload to
>> the mainline?
> 
> There patches are *dead*, and will *not* be upstreamed as such. You
> can tell from the date and the base commit that they are old and
> unmaintained.
> 
> Please do not pick random branches from my tree.
> 
> Thanks,
> 
> 	M.
> 
Noted with thanks — will avoid referencing outdated branches in the future.

Thanks,
Jinqian


