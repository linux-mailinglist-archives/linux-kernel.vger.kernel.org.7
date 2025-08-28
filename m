Return-Path: <linux-kernel+bounces-789152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B22B391AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4688D1753E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FDF226D04;
	Thu, 28 Aug 2025 02:32:04 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1A1C01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348324; cv=none; b=nsn0D3BXxdxGqSEKQxT3zcQ62WmO5ObbatfVBwvh7ah+eIQvB2s3lxMw2sVXw4UKj3z912BdROdrfELbRCQhOASP+AIZCd5KDCM2CZXmAEgyQn1HY8wWBUKI3rv2zbgMKF85K/4fyXqtN8TIvOtWbyfzDMNH4zcx7DiROBPDv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348324; c=relaxed/simple;
	bh=E2e1HE+0Wd4ZP6WtuDKMSe82Vya7T6c9PFVzu8LaOfE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I6V4x3+jfORvzgJFTg+o83iHV+fUVbIEOxGHS0EBMwNC4E/4W0WJ30f8uvwfUCmaU29EvnY8PBMYDJMWh14fAnvvSv2ct1/sVVhNKm2NBcv8BXiBgMxQNqx7RulgdlZwVCwy+g+RmpZa/q0hkrNkauNqG5A92+yZS31lxW/7mWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cC56M3ZxMz27j3Z;
	Thu, 28 Aug 2025 10:32:59 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C04BB14025A;
	Thu, 28 Aug 2025 10:31:52 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 10:31:52 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 10:31:51 +0800
Subject: Re: [PATCH] Revert "hugetlb: make hugetlb depends on SYSFS or SYSCTL"
To: Andrew Morton <akpm@linux-foundation.org>
CC: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20250826030955.2898709-1-linmiaohe@huawei.com>
 <20250826203552.b4340b12b16a374396f49343@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0138514f-c580-c066-c16d-2a0b207e0604@huawei.com>
Date: Thu, 28 Aug 2025 10:31:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250826203552.b4340b12b16a374396f49343@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/8/27 11:35, Andrew Morton wrote:
> On Tue, 26 Aug 2025 11:09:55 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Commit f8142cf94d47 ("hugetlb: make hugetlb depends on SYSFS or SYSCTL")
>> added dependency on SYSFS or SYSCTL but hugetlb can be used without SYSFS
>> or SYSCTL. So this dependency is wrong and should be removed.
>>
>> This reverts commit f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b.
> 
> f8142cf94d47 said:
> 
>     If CONFIG_SYSFS and CONFIG_SYSCTL are both undefined, hugetlb
>     doesn't work now as there's no way to set max huge pages.  Make
>     sure at least one of the above configs is defined to make hugetlb
>     works as expected.
> 
> So there is now a way to set max huge pages?  A reference tot he
> commit which made f8142cf94d47 unneeded might be helpful?

The commit is just wrong. It overlooked the scenario of using hugetlb through boot parameters
when it was submitted.

Thanks.
.

