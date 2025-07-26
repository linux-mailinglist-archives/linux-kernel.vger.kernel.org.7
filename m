Return-Path: <linux-kernel+bounces-746676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63761B129F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D2C547EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C3213E7A;
	Sat, 26 Jul 2025 09:50:18 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0267259C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753523418; cv=none; b=VhldQ9m7J2u1g3gUA7ZZ53J9hJZvm5bZ9CmzsQfvi3yixiiygBbWJFLP5tPTj/JNk6Ihe/t8pnxdHEH9OVAG+91CiRo3LK9YjV20uRZx5beeA2DdmAlnuI2NA+9iCcCbmQ2RUq7Aa5ieyka3uqF4cdkhhKD81qkJVgYK+nz/TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753523418; c=relaxed/simple;
	bh=AEAqFsXIzEOB+z9nSI27F28ea9NszvZQ0qucHN9VDZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cCde9+4cueQaaj1QrbbBolk+gYiBD3jGL3zed1/FfNlYaWLeurKdTMoGjvaAQzrz2s3TLiwIlHwrJjdXv7jCGZcKtwaNdPgAuQSgvWFaeHC9ZIcOhsQw62egmyDOrChHyyZNpK2YP/V6NvVXnsUSC0xs9ynQKRrDb89GC4vsNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bq0KS0yKqz2RVYc;
	Sat, 26 Jul 2025 17:47:56 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 50B9018001B;
	Sat, 26 Jul 2025 17:50:13 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 17:50:12 +0800
Message-ID: <b31a5b91-bc94-46ce-8191-c6576c04f05b@huawei.com>
Date: Sat, 26 Jul 2025 17:50:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
Content-Language: en-US
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <sohil.mehta@intel.com>, <rui.zhang@intel.com>,
	<arnd@arndb.de>, <yuntao.wang@linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250604083319.144500-1-zouyipeng@huawei.com>
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20250604083319.144500-1-zouyipeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100018.china.huawei.com (7.185.36.183)

Hi Thomas：

     I skipped sending the NMI in native_stop_other_cpus(), and the test 
passed.

     However, this change reverts the fix introduced by commit [1], 
which was intended to handle cases where the reboot IPI is not properly 
handled by all CPUs.

     Given this, is there an alternative way to resolve the issue, or 
can we simply mask the IPI directly at that point?

     [1] 747d5a1bf293 ("x86/reboot: Always use NMI fallback when 
shutdown via reboot vector IPI fails")

在 2025/6/4 16:33, Yipeng Zou 写道:
> Recently, A issue has been reported that CPU hang in x86 VM.
>
> The CPU halted during Kdump likely due to IPI issues when one CPU was
> rebooting and another was in Kdump:
>
> CPU0			  CPU2
> ========================  ======================
> reboot			  Panic
> machine shutdown	  Kdump
> 			  machine shutdown
> stop other cpus
> 			  stop other cpus
> ...			  ...
> local_irq_disable	  local_irq_disable
> send_IPIs(REBOOT)	  [critical regions]
> [critical regions]	  1) send_IPIs(REBOOT)
> 			  wait timeout
> 			  2) send_IPIs(NMI);
> Halt,NMI context
> 			  3) lapic_shutdown [IPI is pending]
> 			  ...
> 			  second kernel start
> 			  4) init_bsp_APIC [IPI is pending]
> 			  ...
> 			  local irq enable
> 			  Halt, IPI context
>
> In simple terms, when the Kdump jump to the second kernel, the IPI that
> was pending in the first kernel remains and is responded to by the
> second kernel.
>
> I was thinking maybe we need mask IPI in clear_local_APIC() to solve this
> problem. In that way, it will clear the pending IPI in both 3) and 4).
>
> I can't seem to find a solution in the SDM manual. I want to ask if this
> approach is feasible, or if there are other ways to fix the issue.
>
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>   arch/x86/kernel/apic/apic.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index d73ba5a7b623..68c41d579303 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1117,6 +1117,8 @@ void clear_local_APIC(void)
>   	}
>   #endif
>   
> +	// Mask IPI here
> +
>   	/*
>   	 * Clean APIC state for other OSs:
>   	 */

-- 
Regards,
Yipeng Zou


