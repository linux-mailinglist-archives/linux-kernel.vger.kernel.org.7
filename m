Return-Path: <linux-kernel+bounces-763981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61343B21C71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B598E2A795C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814852D97BF;
	Tue, 12 Aug 2025 04:57:29 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3932DECD6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974649; cv=none; b=HXHfGr8yc2wGUKxEOvr9tFsw09UnbKSl3PQfU3vawKTugOQ0z/iru5L9lCJFguggFX4Rz4j+KesIS8QDu1Ygx1lViBC/qam2a2h62aWGUw+N+JepLgSmfcluD4bZ6Ne0MS8XYlIno016183WczaGKzB/vDMpJzOlnFYPXfuROjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974649; c=relaxed/simple;
	bh=D01XI/JAeJfXnrxe+doIJAhyADO5nSpLgPxgq9q+lvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLBBo8WjJVzT0hkKyAj17tcAUsTwP/AsTyME4/dmokcXjflCnNzacF7uyMFNIi9XjAPKe5sHu4ebnIhIH3yp44MSKmUO4irq1J2M+ni+6nME1BJTPojT+p+MVQrD7omqxeURh6/SX4ZbGlBom98nAhFU/jt4JFu20o/AyabkgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <sshegde@linux.ibm.com>
CC: <christophe.leroy@csgroup.eu>, <frederic@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <wangfushuai@baidu.com>
Subject: Re: [PATCH] soc/fsl/qbman: Use for_each_online_cpu() instead of for_each_cpu()
Date: Tue, 12 Aug 2025 12:56:42 +0800
Message-ID: <20250812045642.54968-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <f3ecce9f-22cf-48e2-843e-63f08a577e69@linux.ibm.com>
References: <f3ecce9f-22cf-48e2-843e-63f08a577e69@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

>> Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
>> more readable and equivalent for_each_online_cpu(cpu) macro.
>> 
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>> ---
>>   drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
>> index f4d3c2146f4f..6f7597950aa3 100644
>> --- a/drivers/soc/fsl/qbman/qman_test_stash.c
>> +++ b/drivers/soc/fsl/qbman/qman_test_stash.c
>> @@ -103,7 +103,7 @@ static int on_all_cpus(int (*fn)(void))
>>   {
>>   	int cpu;
>>   
>> -	for_each_cpu(cpu, cpu_online_mask) {
>> +	for_each_online_cpu(cpu) {
>>   		struct bstrap bstrap = {
>>   			.fn = fn,
>>   			.started = ATOMIC_INIT(0)
> 
> Yes. This change makes sense given that for_each_online_cpu expands into the same.
> 
> Why not do for the remaining ones too?

I’m working on updating the remaining instances as well.
To keep the commits clear, I’m sending separate patches for each file/subsystem.

Regards,
Wang.

> linux_tip$ grep -Rw "for_each_cpu" * | grep  cpu_online_mask
> arch/riscv/kernel/unaligned_access_speed.c:     for_each_cpu(cpu, cpu_online_mask) {
> arch/riscv/kernel/unaligned_access_speed.c:     for_each_cpu(cpu, cpu_online_mask) {
> drivers/soc/fsl/qbman/qman_test_stash.c:        for_each_cpu(cpu, cpu_online_mask) {    ** current patch addresses this.
> drivers/infiniband/hw/hfi1/sdma.c:      for_each_cpu(cpu, cpu_online_mask) {
> drivers/cpuidle/cpuidle-tegra.c:        for_each_cpu(lcpu, cpu_online_mask) {
> include/rv/da_monitor.h:        for_each_cpu(cpu, cpu_online_mask) {
> kernel/trace/trace_osnoise.c:   for_each_cpu(cpu, cpu_online_mask) {
> kernel/trace/trace_osnoise.c:   for_each_cpu(cpu, cpu_online_mask) {
> 
> 
> Rest everyone seems to have moved.
> linux_tip$ grep -Rw "for_each_online_cpu" * | wc
>      416    1141   23047

