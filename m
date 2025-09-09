Return-Path: <linux-kernel+bounces-808229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF34EB4FC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7BF3BF8CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C036340D85;
	Tue,  9 Sep 2025 13:11:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798C33CE91
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423487; cv=none; b=V42NHyIGdVfam0Av/GemdK3G6cQTCIikGBcZZqZfg6AucMO6pFiZPIXD6VjGhSfFTymqQPcFPycB8ZLTSe6l+SuSRBpgdY0DEyfybkwCU6ePG+Fl5+IrCwPzBdkI3CXj5Q9W1pg80xO4iakppi7cCJo7Jy1CFVXLRvHL/H2CtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423487; c=relaxed/simple;
	bh=kkyiI6Tgg1ITwd1ffn20lopgGOnWXc+LSunT8SFF5Fg=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C6bk9aL+KcPfsKjbqcSnw2OKYg2wqWuDnV+Mb5GBQ1McLl2fNs+38pXEQ0p63HM6To1QrFFSWsJt9yF8NHQbO/kK65Ms/NVbekzBVeTF/vo3hT5NI7kEPuRcsRiDv9/N+sKobsxi2Q0mBQaahWpMCBXYg7gOAim3lArsqiiu7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cLkds31l0z1R96G;
	Tue,  9 Sep 2025 21:08:17 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 948CB14022E;
	Tue,  9 Sep 2025 21:11:19 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 21:11:19 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 21:11:18 +0800
Subject: Re: [PATCH v3 0/3] Coresight TMC-ETR some bugfixes and cleanups
To: <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>, <leo.yan@arm.com>
References: <20250818080600.418425-1-hejunhao3@huawei.com>
CC: Junhao He <hejunhao3@huawei.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@h-partners.com>
Message-ID: <80b5a705-19bc-452c-dd46-911deb60cdbd@h-partners.com>
Date: Tue, 9 Sep 2025 21:11:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250818080600.418425-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn500004.china.huawei.com (7.202.194.145)

a gentle ping...


On 2025/8/18 16:05, Junhao He wrote:
> This patchset builds upon Yicong's previous patches [1].
>
> Introducing fix two race issues found by using TMC-ETR and CATU, Two
> cleanups found when debugging the issues.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-1-yangyicong@huawei.com/
>
> ---
> Changes in v3:
>   - Patches 1: Additional comment for tmc_drvdata::etr_mode. Update
>   comment for tmc_drvdata::reading with Jonathan's Tag.
>   - Patches 2: Replace scoped_guard with guard with Jonathan's Tag.
>   - Patches 2: Fix spinlock to raw_spinlock, and refactor this code based
>   on Leo's suggested solution.
>   - Patches 3: change the size's type to ssize_t and use max_t to simplify
>   the code with Leo's Tag.
> Link: https://lore.kernel.org/linux-arm-kernel/20250620075412.952934-1-hejunhao3@huawei.com/
>
> Changes in v2:
> - Updated the commit of patch2.
> - Rebase to v6.16-rc1
>
> Junhao He (1):
>    coresight: tmc: refactor the tmc-etr mode setting to avoid race
>      conditions
>
> Yicong Yang (2):
>    coresight: tmc: Add missing doc including reading and etr_mode of
>      struct tmc_drvdata
>    coresight: tmc: Decouple the perf buffer allocation from sysfs mode
>
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 110 ++++++++----------
>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>   2 files changed, 53 insertions(+), 59 deletions(-)
>


