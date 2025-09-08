Return-Path: <linux-kernel+bounces-805166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD23B484CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A34177EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341D2E5437;
	Mon,  8 Sep 2025 07:10:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CC747F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315418; cv=none; b=FA/R4Zf58s7MExyvO78ou0DRXg/4dNnw8CrUDZs1DlMuel3p+AWVtzOED4nofZiWO+263InjWa/n4P3cbvP88SJmTeJLriRd7f4zKV0nwqF4NwYZJEooZ8dfq38ZrUyI9PWie2fHOxtKjSyP5/T+zR/PKg54FsSlWT9IORBoqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315418; c=relaxed/simple;
	bh=k9XX2yWsBgDP1A4zgn9Z+KD0lDb36jnMjgYurCpjVNg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fEev1fkSHgnvYO0eVtFhJyYAbbcClmr0mUmOQSQjVDuXqV3YBpp/neTtcOK2S6VooF6AQTpi0YI1eOXa7T19j8n3KmjqK1jHA5qHiAFMV4fjL1q72bUrkkqxSU55Fw7CCYSBp/R0sFHJwozljR3lmynfnY7gjLdiskbcIgQX7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cKyk42QfCztTbY;
	Mon,  8 Sep 2025 15:09:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D4C3B18006C;
	Mon,  8 Sep 2025 15:10:11 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 15:10:11 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 15:10:10 +0800
CC: <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v6 0/3] drivers/perf: hisi: Add support for HiSilicon NOC
 and MN PMU driver
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250814091622.23269-1-yangyicong@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <5b727add-e48e-5857-42a4-97586e1e02e1@huawei.com>
Date: Mon, 8 Sep 2025 15:10:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814091622.23269-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200018.china.huawei.com (7.202.195.108)

a gentle ping...

On 2025/8/14 17:16, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add support for two new Uncore PMUs to monitor the events of the system bus
> (by NoC PMU) and the DVM operations (by MN PMU).
> 
> Change since v5:
> - Rebase on 6.17-rc1 and update the maintainer entry
> Link: https://lore.kernel.org/linux-arm-kernel/20250717121727.61057-1-yangyicong@huawei.com/
> 
> Change since v4:
> - Rename ovflow_status to .overflow_status with Jonathan's Tag, thanks!
> Link: https://lore.kernel.org/linux-arm-kernel/20250717074138.39903-1-yangyicong@huawei.com/
> 
> Change since v3:
> - Use ACPI driver data to retrieve the hardware capabilities
> Link: https://lore.kernel.org/linux-arm-kernel/20250619125557.57372-1-yangyicong@huawei.com/
> 
> Junhao He (1):
>   drivers/perf: hisi: Add support for HiSilicon MN PMU driver
> 
> Yicong Yang (2):
>   drivers/perf: hisi: Add support for HiSilicon NoC PMU
>   MAINTAINERS: Remove myself from HiSilicon PMU maintainers
> 
>  Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
>  MAINTAINERS                                  |   1 -
>  drivers/perf/hisilicon/Makefile              |   3 +-
>  drivers/perf/hisilicon/hisi_uncore_mn_pmu.c  | 411 +++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 443 +++++++++++++++++++
>  5 files changed, 867 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
> 

