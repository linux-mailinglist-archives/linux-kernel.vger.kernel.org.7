Return-Path: <linux-kernel+bounces-864600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB56BFB265
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EE4E264B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723F31329E;
	Wed, 22 Oct 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IcFDykuW"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06116313272;
	Wed, 22 Oct 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125160; cv=none; b=pe1QHUjdrGfr+aKMlJHZ8CtW1weEI7PXmRGuXdtjHOWIHEpmk0iWpM/Ui5Oieh7xOxC/bfeaQHkr6xQzv+NU0NaLaqAnVxPn3tlsDhT+3fE3eYbkNS2wlCX+81qWoWcjUupa6ihhPKGD3fZvJNYEWQ/U1wukzUv2+ni1XOuTMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125160; c=relaxed/simple;
	bh=cpxkDaWD9t5lF3decGWZ8c57zEYskBH/2P5TRepaQlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NWZ/tWurSEb7J9tWarxt1Erkply9+3kr0SBJIaP7EI7vTgLCm+MgZgIhMO7yTY0YP5nGIBexPdne0/Vnp0UGIW8pQ0lV/M7iQDJg7GInkny2tRmSh/XjStMCM00AO6QkFb+ZvPzKMdxof0jSq6bw8IOMt1Sd5yRfS7qKxcs0xCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IcFDykuW; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Uy2pQANmt/EIY8vvrnFu49o9JdxiulocdSZxw8h3NM4=;
	b=IcFDykuWnJgWYfU5jyfCGXJCCFMA5VvuTnT6EN+Y6A4WEu/zeIyqVYstviUAVW6bl8I2lMXrb
	rUsnIbbD1u7WollSQS3WQ9r0jyJ/anyK3SvgjYy2uhsqm7KznG1Y3N584mwBWo5OIeminTOq+BF
	4ChSV3O9JlReQjL00kz1sgw=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cs3fM5f2gz1T4Fg;
	Wed, 22 Oct 2025 17:24:59 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EF32B140154;
	Wed, 22 Oct 2025 17:25:53 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 17:25:53 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 17:25:52 +0800
Message-ID: <de4f09aa-3216-4ac5-8d76-899a685e05f5@huawei.com>
Date: Wed, 22 Oct 2025 17:25:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Add kernel parameter to disable trap EL0 accesses
 to IMPDEF regs
To: Yicong Yang <yangyccccc@gmail.com>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<mingo@kernel.org>, <bp@alien8.de>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <maz@kernel.org>, <broonie@kernel.org>,
	<oliver.upton@linux.dev>, <yeoreum.yun@arm.com>, <james.morse@arm.com>,
	<ardb@kernel.org>, <hardevsinh.palaniya@siliconsignals.io>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20251021115428.557084-1-liaochang1@huawei.com>
 <1ad9d43b-fd1f-4a66-b67b-14f0b3217aec@gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <1ad9d43b-fd1f-4a66-b67b-14f0b3217aec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200011.china.huawei.com (7.202.195.155)

Hi, Yicong

在 2025/10/22 13:26, Yicong Yang 写道:
> On 2025/10/21 19:54, Liao Chang wrote:
>> Add kernel parameter to allow system-wide EL0 access to IMPDEF system
>> regregisters and instructions without trapping to EL1/EL2. Since trap
>> overhead will compromises benefits, and it's even worse in
>> virtualization on CPU where certain IMPDEF registers and instructions
>> are designed for EL0 performance use.
>>
>> More early discussion could be found from link below.
>>
>> Link: https://lore.kernel.org/all/24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com/
>> Tested-by: Xinyu Zheng <zhengxinyu6@huawei.com>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>>  arch/arm64/kernel/cpufeature.c                  | 14 +++++++++++++-
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 5a7a83c411e9..11ffa9f7b972 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -326,6 +326,15 @@
>>  			See Documentation/arch/arm64/asymmetric-32bit.rst for more
>>  			information.
>>  
>> +	no_trap_el0_impdef [Arm64,EARLY]
>> +			Allow system-wide EL0 access to IMPDEF system registers
>> +			and instructions without trapping to EL1/EL2.
>> +			Since trap overhead compromises benefits, and it's even
>> +			worse in virtualization on CPU where certain IMPDEF
>> +			registers and instructions are designed for EL0
>> +			performance use. This assumes the kernel adds the
>> +			support for Armv8.8 extension FEAT_TIDCP1.
>> +
>>  	amd_iommu=	[HW,X86-64]
>>  			Pass parameters to the AMD IOMMU driver in the system.
>>  			Possible values are:
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index ef269a5a37e1..d12e35d799ee 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2459,9 +2459,21 @@ static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, in
>>  }
>>  #endif /* CONFIG_KVM */
>>  
>> +static bool no_trap_el0_impdef;
>> +
>> +static int __init parse_no_trap_el0_impdef(char *p)
>> +{
>> +	no_trap_el0_impdef = true;
>> +	return 0;
>> +}
>> +early_param("no_trap_el0_impdef", parse_no_trap_el0_impdef);
>> +
>>  static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
>>  {
>> -	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
>> +	if (no_trap_el0_impdef)
>> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_TIDCP, 0);
>> +	else
>> +		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
> An id override for TIDCP1 seems simpler rather than an early param, and consistent to how we disable other 
> certain features through boot option like arm64.nosve or arm64.nompam. I see Catalin also suggested in that
> way in [1],any reason we cannot do it in that way?

Thanks for reminding me of that.

But the problem is on warm reset, SCTLR_ELx.tidcp resets to an unknown value.
This means using id_aa64mmfr1.tidcp1=0 override for TIDCP1 only skips setting
SCTLR_ELx.TIDCP to 1, it still can not guarantee the SCTLR_Ex.TIDCP is cleared.

BR,
Liao, Chang

> 
> [1] https://lore.kernel.org/all/aHqamaqueuk18NyS@arm.com/
> > Thanks.
>>  }
>>  
>>  static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)


