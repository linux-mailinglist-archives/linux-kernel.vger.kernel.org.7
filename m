Return-Path: <linux-kernel+bounces-824241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7898B887BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818EA587C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777312EB5C4;
	Fri, 19 Sep 2025 08:54:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B9191F6A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272090; cv=none; b=RFscnNDlNndm1JyQLIW1hQQLDTncfVJVxxVs72PO90Q5yETMK7AltXiBj92nrNK25eXFUfhF3aIgoOnQ2l1XFLfHrW9mwDF4O5V3l4F2Cq5rrcNgIDllaEYs3AEcQHLoP+QHwyKxw71GScjTk6Yo+6T7bBMHZ9nhS8F5NgcqFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272090; c=relaxed/simple;
	bh=rgjfMMUsMADXATPPOL7S3ciH9se9F+sFsHglER8or8Y=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tSKqrQYyagkZL3N6dpumnOC8z8/Y8Vi0q6USudEJYFdLc85+e/Fi645wf4dWLxPMsC7N8bDAfMYomnEKtzGgq+RqsWoFt+ACFf6SvTfIHGb77uiB6ym/oW5vNmDxyhirrSP/NEehmaI7N9IleLcRTZ35n/tfsOSGr2RgHQYfPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cSmWY2dmpztTJ4;
	Fri, 19 Sep 2025 16:53:45 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 02DB7180464;
	Fri, 19 Sep 2025 16:54:39 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 16:54:38 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 16:54:38 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>, <hejunhao3@h-partners.com>
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Remove myself from HiSilicon PMU
 maintainers
To: Will Deacon <will@kernel.org>
References: <20250814091622.23269-1-yangyicong@huawei.com>
 <20250814091622.23269-4-yangyicong@huawei.com>
 <aMwOjne-iiFCdo9n@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b476874a-8b09-5777-98c8-dc1efaa23a31@huawei.com>
Date: Fri, 19 Sep 2025 16:54:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aMwOjne-iiFCdo9n@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/18 21:52, Will Deacon wrote:
> On Thu, Aug 14, 2025 at 05:16:22PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Remove myself as I'm leaving HiSilicon and not suitable for maintaining
>> this. Thanks for the journey.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Thanks, Yicong, for all your contributions to the perf drivers and help
> with reviewing over the years.
> 

my pleasure. learnt a lot and happy to help. lots of fun :)

> We will miss you :(
> 

thanks. hopefully will still work with you and the community :)

thanks.


