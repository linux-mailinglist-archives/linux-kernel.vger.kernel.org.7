Return-Path: <linux-kernel+bounces-790824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1709B3ADA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0DB583351
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B16926F2BE;
	Thu, 28 Aug 2025 22:40:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8BD2264A3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420819; cv=none; b=q4p88E3fmcSZ/Rr2zWZJ+1s3FGyidRN9vqGts7/+gNluuKQdiAjTwJka58UhDu++dlR6JxCqD+AMIhLY5Cuq6dfaVebpoiIaBcVsqq9xaX9ejqWLmFocA1qj2AERQmlz6lo55uHqdeZnELzYOsBXbb5BBWRRC1B2s8V6FzBcW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420819; c=relaxed/simple;
	bh=3GiqgHj2UCdSsbG5WJ6XWydJWCGenb/LnjW5cFj29m0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YOPUStrbIPZaaaz9ZC4o/5v7y9MatZ0jyKJKjzB39A1XDHd1CBCNgdQx97qKbCHatjTLTM5owJZEx1zd4LWW25jnjEjeEzvT/MdW7gN3Ulk0g4KpNhAyH4Pt02pJ2A5oSs/DzpgFaI0PxUAAJOQlU7B8cQfezoqO0KUTv8q60YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCFF11655;
	Thu, 28 Aug 2025 15:40:07 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371A73F63F;
	Thu, 28 Aug 2025 15:40:15 -0700 (PDT)
Message-ID: <e381fd4b-fb90-41ae-a480-0dad1ce2aa9f@arm.com>
Date: Thu, 28 Aug 2025 23:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 yury.norov@gmail.com
Cc: Rik van Riel <riel@surriel.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] smp: Fix smp_call_function_any() if no CPU online
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

smp_call_function_any() used to handle a mask without any online
CPUs just fine, but when switching to use sched_numa_find_nth_cpu()
a previous check for online CPUs was removed.
smp_call_function_single() handles invalid CPUs just fine, so
just add the check back before calling sched_numa_find_nth_cpu().

An observed issue was when initializing PMUs on HMP if all CPUs
were offline (e.g. by booting with maxcpus):

[    1.192642] Call trace:
[    1.192868]  sched_numa_find_nth_cpu+0xc0/0x170 (P)
[    1.193323]  smp_call_function_any+0xc8/0xd0
[    1.193724]  armv8_pmu_init+0x58/0x27c
[    1.194079]  armv8_cortex_a72_pmu_init+0x20/0x2c
[    1.194507]  arm_pmu_device_probe+0x1e4/0x5e8
[    1.194911]  armv8_pmu_device_probe+0x1c/0x28
[    1.195316]  platform_probe+0x5c/0xac
[    1.195658]  really_probe+0xbc/0x298
[    1.195995]  __driver_probe_device+0x78/0x12c
[    1.196399]  driver_probe_device+0xdc/0x160
[    1.196787]  __driver_attach+0x94/0x19c
[    1.197146]  bus_for_each_dev+0x74/0xd4
[    1.197503]  driver_attach+0x24/0x30
[    1.197838]  bus_add_driver+0xe4/0x208
[    1.198187]  driver_register+0x60/0x128
[    1.198546]  __platform_driver_register+0x24/0x30
[    1.198974]  armv8_pmu_driver_init+0x28/0x4c
[    1.199372]  do_one_initcall+0x44/0x25c
[    1.199729]  kernel_init_freeable+0x1dc/0x3bc
[    1.200134]  kernel_init+0x20/0x1d8
[    1.200466]  ret_from_fork+0x10/0x20
[    1.200809] Code: 4b020264 eb04007f 54000129 51000402 (f860d825)
[    1.201355] ---[ end trace 0000000000000000 ]---

Fixes: 5f295519b42f ("smp: Improve locality in smp_call_function_any()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 56f83aa58ec8..cbce9699ced6 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -759,7 +759,9 @@ int smp_call_function_any(const struct cpumask *mask,
 
 	/* Try for same CPU (cheapest) */
 	cpu = get_cpu();
-	if (!cpumask_test_cpu(cpu, mask))
+	if (!cpumask_intersects(mask, cpu_online_mask))
+		cpu = nr_cpu_ids;
+	else if (!cpumask_test_cpu(cpu, mask))
 		cpu = sched_numa_find_nth_cpu(mask, 0, cpu_to_node(cpu));
 
 	ret = smp_call_function_single(cpu, func, info, wait);
-- 
2.34.1

