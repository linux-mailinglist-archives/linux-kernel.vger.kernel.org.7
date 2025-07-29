Return-Path: <linux-kernel+bounces-749634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0488B150CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378C4163213
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104D220F20;
	Tue, 29 Jul 2025 16:03:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D40101E6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805024; cv=none; b=T4gzKo3O578fTYexVyjT0wyr97XqU+6X6abuslTYuwcw9UlIJkFRq7uyjpglxoyLdoEV1jC3gdu1d4ftzMLH+D/eEUZSIOYeb7gZgJNtwFhTibGbgq1TSeQ5nw5MVQ6n97u2BvYTJPW+N39FJSymwkt+etMcZgjfrQZ5cudqPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805024; c=relaxed/simple;
	bh=JALDSuCHo6yW/v3LgSW8wFxn0wXqBjCTPFZyDX9BKUE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=p8UE+ENyOObvPR8NpabfKjmfA4wNXej5UrEugbb+meOJMg6tzJeC+j5b42tuCVhNRNsjpMuM9Ds2DUedmG1zvMe1Lwm+rYkQN/NQx0YehMo+9F/wagzBsFNyFaJXBYlMJphR7ArztTxnwieEf5sN1JCOv8+/IprPrJXotNGf4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D541A113E;
	Tue, 29 Jul 2025 09:03:31 -0700 (PDT)
Received: from [10.57.69.185] (unknown [10.57.69.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3222E3F5A1;
	Tue, 29 Jul 2025 09:03:38 -0700 (PDT)
Message-ID: <0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com>
Date: Tue, 29 Jul 2025 17:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, void@manifault.com, arighi@nvidia.com
Cc: sched-ext@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
Mark it as such.

Cc: stable@vger.kernel.org
Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dd5cbcb7a06..b734f55f3318 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7599,7 +7599,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
-- 
2.34.1

