Return-Path: <linux-kernel+bounces-820055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28BB7D6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462391C03145
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E71271468;
	Wed, 17 Sep 2025 06:26:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8610F1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090398; cv=none; b=HqDP+7FmvuGlpmkvqzcFMbm3mJ5f47FCNu9UMNuxCe4D6K7UUOZs9C0HD8mKiJep0yppbQzkEh5UjECvK10Teycvr9PuOfGtkX1NP9cMywTuKAR943NPM/j0aXbURwK2o8vQ9DMDun4kJCmtqVyI3A+ZhWBrS+X/MPMgD+1Ve/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090398; c=relaxed/simple;
	bh=eOoStHpwaMHkIg+qXETNeclkfibVS3GTBGJXhbk/6Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GosEUSz4Dbwl74YKdOY9FGbw04xLvhC5Ho3au7TL+6c7nV5MXnIDJoQOi8BBbEoRgWn6KPp+w/7d4KUb9eO2BnsvBsGXBKMKI3f4OHgKmfvXz+a+jmYUeBItMpdo1yjxG+/s4ENYmEZjmY7s73xmPPh1eXJIDwSsAVDoGpl4Js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cRTFC5zdXzddDh;
	Wed, 17 Sep 2025 14:21:51 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id 656DF180B63;
	Wed, 17 Sep 2025 14:26:27 +0800 (CST)
Received: from [10.67.109.25] (10.67.109.25) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 14:26:26 +0800
Message-ID: <19eb0973-02fd-4823-8221-fc8af9b30a74@huawei.com>
Date: Wed, 17 Sep 2025 14:26:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
To: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <tanghui20@huawei.com>,
	<tglx@linutronix.de>, <vincent.guittot@linaro.org>, <zhangqiao22@huawei.com>,
	Waiman Long <longman@redhat.com>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
 <aML41e2csdTdSTNU@localhost.localdomain>
From: "wangtao (EQ)" <wangtao554@huawei.com>
In-Reply-To: <aML41e2csdTdSTNU@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100009.china.huawei.com (7.185.36.128)

Do we have plans to merge this patch into the mainline?

Thanks,

Tao

在 2025/9/12 0:29, Frederic Weisbecker 写道:
> Le Thu, Sep 11, 2025 at 12:13:00PM -0400, Phil Auld a écrit :
>> Increase the sched_tick_remote WARN_ON timeout to remove false
>> positives due to temporarily busy HK cpus. The suggestion
>> was 30 seconds to catch really stuck remote tick processing
>> but not trigger it too easily.
>>
>> Signed-off-by: Phil Auld <pauld@redhat.com>
>> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>

