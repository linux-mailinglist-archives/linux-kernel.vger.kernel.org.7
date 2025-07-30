Return-Path: <linux-kernel+bounces-750576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9EB15E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93043B0839
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BBA279783;
	Wed, 30 Jul 2025 10:33:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5526E140
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871611; cv=none; b=N9EyVpGBd8WWu1hZ/daewcdDio2MC/nPwA/GeHt9ntxU66UfUADvXNnmjpBakW+oebnNYPbp6gd6msj3yY7sINaX87r+j/whIPk+kGZCn/nOzL/Er6qJ7rQF6I+Sc7yGcVae3EB2I+GQcZN8fGuucUDPLjBa+dRruKOMvql/5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871611; c=relaxed/simple;
	bh=Mgtm+AZHgtiboO81D2klozRHFXTt27P6lDtPoA5yoPY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qYkLJweaho886r9TD0HKVh9Bnhl26382MYHRcupKJU7pi4RvC0cKiVmyJoGWRCX1hYBg0A29ayTmwo/+SlOyCnH7EoaKCioyG3ELDReAhYjTBU2SepQtf6bujnFrrhXfUOKuq8ssiwJ1FdHniHZxcBl0weH8oXL7oH7m6eHQ00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962ED1BC0;
	Wed, 30 Jul 2025 03:33:20 -0700 (PDT)
Received: from [192.168.3.124] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9ACD3F673;
	Wed, 30 Jul 2025 03:33:26 -0700 (PDT)
Message-ID: <43a9cbdc-5121-4dc8-8438-0f01c90a4687@arm.com>
Date: Wed, 30 Jul 2025 11:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: arighi@nvidia.com, Tejun Heo <tj@kernel.org>,
 David Vernet <dvernet@meta.com>
Cc: sched-ext@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
Mark it as such.
While kf_cpu_valid() will trigger scx_ops_error() that leads
to the BPF scheduler exiting, this isn't guaranteed to be immediate,
allowing for a dereference of a NULL scx_bpf_cpu_rq() return value.

Cc: stable@vger.kernel.org
Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
v2: Extended commit message and picked up Andrea's ACK.

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

