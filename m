Return-Path: <linux-kernel+bounces-795772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9BB3F7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358543AEBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30B2E54AA;
	Tue,  2 Sep 2025 08:08:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84F32F757
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800522; cv=none; b=qsVyhnaiFb6xDbIXLxzD9TDg38rLqVkJEzIVjdhVe0FzoglBy+MwF9i9QBeNEIfHRtyAkaWTmoI/uWVTOtd/DeDOnBmGUCds+tyhjTGS445mcTvfTGMA6Y3dzWNtWVurjvZ0vs7mcct+llca1PAJEiKLvmtPCWnQJaVAPPMH5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800522; c=relaxed/simple;
	bh=qbro9DR9KvkbcPWOFnfFJ1ltcCdjKB6XeyDy9QzDW08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sF+RwB9egISdKAYUaWyaTvcilPnDUUW40+oCuM1vpshg+MY8XvNFah+Qroh156fw/L0hhzS471MJPttklicIY0M5C7NN6RyVE9UQGHmrmKDWVtOl2cJLgz5N7c0aHPNkQ2LNYX3vtD626MsCQ4oJOsHYhrqWKIpbuHnRYz6RtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cGJCz6t4YzPqkf;
	Tue,  2 Sep 2025 16:03:59 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C01218049C;
	Tue,  2 Sep 2025 16:08:36 +0800 (CST)
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 16:08:29 +0800
Received: from [10.67.110.89] (10.67.110.89) by kwepemn500008.china.huawei.com
 (7.202.194.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Sep
 2025 16:08:28 +0800
Message-ID: <6c22bdba-00d2-4f5a-a83e-de7dfbf92f22@huawei.com>
Date: Tue, 2 Sep 2025 16:08:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix division-by-zero error in task_scan_max()
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <mgorman@suse.de>, <riel@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250827123427.1229183-1-xiafukun@huawei.com>
Content-Language: en-US
From: Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <20250827123427.1229183-1-xiafukun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn500008.china.huawei.com (7.202.194.149)

On 8/27/2025 8:34 PM, Xia Fukun wrote:
> The error can be reproduced by following these steps:
> First, set sysctl_numa_balancing_scan_size to 0:
> 
> echo 0 > /sys/kernel/debug/sched/numa_balancing/scan_size_mb
> 
> Then trigger the clone system call, for example, by using
> pthread_create to create a new thread.
> 
> 	Oops: divide error: 0000 [#1] SMP NOPTI
> 	CPU: 11 UID: 0 PID: 1 Comm: systemd Tainted: G S 6.17.0xfk_v2 #6
> 	Tainted: [S]=CPU_OUT_OF_SPEC
> 	Hardware name: SuperCloud R5210 G12/X12DPi-N6, BIOS 1.1c 08/30/2021
> 	RIP: 0010:task_scan_max+0x24/0x190

Gentle ping ...


