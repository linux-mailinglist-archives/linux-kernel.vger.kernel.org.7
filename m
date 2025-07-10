Return-Path: <linux-kernel+bounces-724760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2DAFF6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5D91895BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C427E7D2;
	Thu, 10 Jul 2025 02:18:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B35264FB3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113931; cv=none; b=HN0voGBy4XO8KvkqUs3iGBisr3DHxsj05wsNHPLeqHCUA4aEWaJGWjp0ttvVLISqywB72EoCe18Kh1Y/htLU54LqWBp+41Ni1eawh1+4MIgW0yNle1NA29G8IDZ1EhDPogZHTlsqFdrwS+Fro0/TV2SdDYhWdkX5gPRCKKc7mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113931; c=relaxed/simple;
	bh=QeQDLY81rPFHVtvw80daArJgXUXP+EQO9xhZktO2PaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XC5gJGJP3MDPyq2mmFteL+kykFc4PF8bP5MwfVo3qoDasmq9b8HugkJofT+8jea7kLFs+x6GMFKxR51N/wneXf1bFBo5HiOXx+ad/P6UcYfupAlHNH5iV9RKhrcOsevDuzL0SYaKEkQkkJkJ05j1BrO60wYBUj8ksOFUuemw6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bcydx6Txmz2CfnV;
	Thu, 10 Jul 2025 09:57:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 12486180043;
	Thu, 10 Jul 2025 10:01:30 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 10:01:29 +0800
Received: from [10.146.82.192] (10.146.82.192) by
 kwepemq100012.china.huawei.com (7.202.195.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 10:01:29 +0800
Message-ID: <d8588f5d-bccc-4791-9d44-bd3e383d21b9@huawei.com>
Date: Thu, 10 Jul 2025 10:01:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
References: <20250709093829.3213647-1-quzicheng@huawei.com>
 <20250709115317.GK1613200@noisy.programming.kicks-ass.net>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20250709115317.GK1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100012.china.huawei.com (7.202.195.195)

Hi,

Based on LTS 6.6. I also looked at the code logic around 
vruntime_eligible() in the mainline. It seems that if 
vruntime_eligible() consistently returned false, this could lead to null 
pointer dereferences.

I'm wondering if it's feasible to adjust the handling of integer 
overflows within vruntime_eligible() the way shown in my patch, or if 
there's a specific design rationale behind directly comparing integers 
that are susceptible to overflow in the current implementation?

Thanks

On 7/9/2025 7:53 PM, Peter Zijlstra wrote:
> On Wed, Jul 09, 2025 at 09:38:29AM +0000, Zicheng Qu wrote:
>
>> The best approach should be to dig deep into why overflow occurs, which
>> attributes lead to the overflow, whether it is normal, and how to avoid
>> it.
> What kernel version are you seeing this on?
>

