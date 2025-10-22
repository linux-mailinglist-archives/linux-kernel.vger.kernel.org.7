Return-Path: <linux-kernel+bounces-864693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA0BFB5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C994E924A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8860287246;
	Wed, 22 Oct 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axk+K+TI"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA682367B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128144; cv=none; b=oOdwI6+WzuUEVHWuzMCylp/i+OGus3sN4UoAvcvT1Tmu5rbdQA2rW4OWo6kphyqsMIHj3kV1wlY7T+v1LJwkZGZg9V6ULMgtcnrCeo2PJGDI+18u2tJn4HRpGlMQIaKYkE4sIhwzlwdeaDSonRxOy2UF1ZrU23l7u66zvr0//vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128144; c=relaxed/simple;
	bh=b3zx74eORyrBFlaXkxOWHxuXnk9jsL1abC64l2VhvF0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aRQy4ZEH6afQPvPzN8qATbWx+T7+9R9g3ImE/u7fwcRyqHyy8hfafkrvav8/Mz6rHvcR395kWuaRi5csDHPEAm5IJ28Zbi77dWr+utwMAOQSI98GQIMCTk4STYVmyLTcAZXXrtoIsSRimC0K/CSXG5p8vnPzuBh3nyODDwEEknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Axk+K+TI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-783ad9c784cso498674b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761128142; x=1761732942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvcenKsgZMzYl+VycmeKBfTwKhJWtnezcECNx2hwtSg=;
        b=Axk+K+TI45HrfkEhAtX9kOmsjC2RnLTqUlBtNz2yaF0Sl6phtLy3e/F5HBfPT+dnSa
         6GSiI8/J+kJPYqxft5ijf3+CmZKykka+D8k3WqRAGcvhwq+7/JI0mgJwNYtt5OTbUnub
         XegVOPwxKabXlmBZS8PbkBiKZys6YB3gTqOoJpRlNwKwlQTGV7sgZ4A7b7EiJ16vibIJ
         Cn55+oMXo1Y3LvtdltVutIiOIdxCeQN/Eshz843x21Mgsw3DSKbzx5uEPMLSN8gwhSgD
         K4Mo4X7532Fhdw3Uzxcwv6UlQn2apZ+auq43FeymP3hOs2DFuCgVDERXMe5gpMfmv+8J
         Dywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128142; x=1761732942;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvcenKsgZMzYl+VycmeKBfTwKhJWtnezcECNx2hwtSg=;
        b=qutz1OM5mgRkWV+KZleM7Ufj2md4zfBmVM7m2iueVt3utMDBrdJAjkdWJXyslg7zK3
         oXvQW5/CwMolKpyGUjLRc9LakdOt7Tc7xHSBseuC1TPKy0LLa6b/GeAbJc+BhY4hz386
         b/PL7WwAYil9hYdSOCt9/2xc9LN/h65I4u/3BHn69uaKXtfBtsmD3BQq4BpDMLzOyri/
         QEBMR7pJPq0JzV1xwLwNeNHwzzhefuT+REojRhicTV3e7pLDc9B52jqUNxeHbSVwfKHh
         Gz40LoeaeQOHjUl1L+kxNonIgHha+5ULBMnM/ujGqtK/EMmlmYCgaoNva5jzIvAzCjxZ
         zQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJWgxeMCdyxOEo10KUhvhIbFSSBjh27jNH4Ycsf+NR2TExq6yzbemWx4aXFUNnnBiH6EoQ0K+2jIoqU+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2Hhss52Y8yuEfw8n3IKO8cuhYIOO4l5XKpU0SdNfXULN3e7E
	K8geHaX7bx3VS3YHudV0d1uDQAEjApWd3HlZfzHKb5yLKThjqbgiuKXD
X-Gm-Gg: ASbGnct7BBdIaF706pDyqOAmpp0jGRvfAR3bEhfn/hP5Cz9BmJ2UarEhCTzoJKeCtqq
	acscok/ymMATbxJn1LNCxQaMH/NxH4kl6+Lgoqb7f6Ap/9Kdo/71mas2WA+5yCPCgcC6Th5qYFx
	IBVpApFsHGwGky1GmUlaSYz7GFAlhcq+YfNu5878pYGb6jf9XUTiIXJm2vyjcDbMWWFT9ObqUJq
	Mvm0AWG5DUeXgCZXiuy18Do8RQhIFIrzVnyefPSh7JDTZjaOq7UQlZrnu9RquMA6DL2RRT/oYTC
	OqTXeE+XvBeQHNi4vC7P4rIK8t714o5v5nEwawzrU7YwASLWufgBbAfxO030b4M8t593jbEgDXl
	TaVRFtv8NCQh9aO3xCvDjRdeFH3sE/+IQtiGxiPuYpapXkJ26LGBwquzJLSWJrtl0sNtb6f6EdE
	DZhdXDraB3qseHQ3VefyS06O0rTPUsS8gL
X-Google-Smtp-Source: AGHT+IFpnOvJJQR2OJ1DVFdDdw/vCuwAtRRJ5/FcdtkXTsQQy2/ztS8oGEFmref9mDQ9jgu8/MffSQ==
X-Received: by 2002:a17:903:234d:b0:290:8d7b:4041 with SMTP id d9443c01a7336-290cc7d4ac9mr124602835ad.10.1761128141590;
        Wed, 22 Oct 2025 03:15:41 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.181.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcdefsm134940515ad.16.2025.10.22.03.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:15:41 -0700 (PDT)
Message-ID: <9951e03a-06c8-4ca5-a585-f4d190550649@gmail.com>
Date: Wed, 22 Oct 2025 18:15:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yangyccccc@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add kernel parameter to disable trap EL0 accesses
 to IMPDEF regs
To: "Liao, Chang" <liaochang1@huawei.com>, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, mingo@kernel.org,
 bp@alien8.de, kees@kernel.org, arnd@arndb.de, fvdl@google.com,
 maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
 yeoreum.yun@arm.com, james.morse@arm.com, ardb@kernel.org,
 hardevsinh.palaniya@siliconsignals.io
References: <20251021115428.557084-1-liaochang1@huawei.com>
 <1ad9d43b-fd1f-4a66-b67b-14f0b3217aec@gmail.com>
 <de4f09aa-3216-4ac5-8d76-899a685e05f5@huawei.com>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <de4f09aa-3216-4ac5-8d76-899a685e05f5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/10/22 17:25, Liao, Chang wrote:
> Hi, Yicong
>
> 在 2025/10/22 13:26, Yicong Yang 写道:
>> On 2025/10/21 19:54, Liao Chang wrote:
>>> Add kernel parameter to allow system-wide EL0 access to IMPDEF system
>>> regregisters and instructions without trapping to EL1/EL2. Since trap
>>> overhead will compromises benefits, and it's even worse in
>>> virtualization on CPU where certain IMPDEF registers and instructions
>>> are designed for EL0 performance use.
>>>
>>> More early discussion could be found from link below.
>>>
>>> Link: https://lore.kernel.org/all/24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com/
>>> Tested-by: Xinyu Zheng <zhengxinyu6@huawei.com>
>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>>>  arch/arm64/kernel/cpufeature.c                  | 14 +++++++++++++-
>>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 5a7a83c411e9..11ffa9f7b972 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -326,6 +326,15 @@
>>>  			See Documentation/arch/arm64/asymmetric-32bit.rst for more
>>>  			information.
>>>  
>>> +	no_trap_el0_impdef [Arm64,EARLY]
>>> +			Allow system-wide EL0 access to IMPDEF system registers
>>> +			and instructions without trapping to EL1/EL2.
>>> +			Since trap overhead compromises benefits, and it's even
>>> +			worse in virtualization on CPU where certain IMPDEF
>>> +			registers and instructions are designed for EL0
>>> +			performance use. This assumes the kernel adds the
>>> +			support for Armv8.8 extension FEAT_TIDCP1.
>>> +
>>>  	amd_iommu=	[HW,X86-64]
>>>  			Pass parameters to the AMD IOMMU driver in the system.
>>>  			Possible values are:
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index ef269a5a37e1..d12e35d799ee 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -2459,9 +2459,21 @@ static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, in
>>>  }
>>>  #endif /* CONFIG_KVM */
>>>  
>>> +static bool no_trap_el0_impdef;
>>> +
>>> +static int __init parse_no_trap_el0_impdef(char *p)
>>> +{
>>> +	no_trap_el0_impdef = true;
>>> +	return 0;
>>> +}
>>> +early_param("no_trap_el0_impdef", parse_no_trap_el0_impdef);
>>> +
>>>  static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
>>>  {
>>> -	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
>>> +	if (no_trap_el0_impdef)
>>> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_TIDCP, 0);
>>> +	else
>>> +		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
>> An id override for TIDCP1 seems simpler rather than an early param, and consistent to how we disable other 
>> certain features through boot option like arm64.nosve or arm64.nompam. I see Catalin also suggested in that
>> way in [1],any reason we cannot do it in that way?
> Thanks for reminding me of that.
>
> But the problem is on warm reset, SCTLR_ELx.tidcp resets to an unknown value.
> This means using id_aa64mmfr1.tidcp1=0 override for TIDCP1 only skips setting
> SCTLR_ELx.TIDCP to 1, it still can not guarantee the SCTLR_Ex.TIDCP is cleared.

it seems impossible to me. the sctlr_elx is initialized to INIT_SCTLR_EL1_MMU_ON and other bits are set
according to the feature detected. sctlr_elx is saved/restored in cpu_do_{suspend,resume} in CPU
suspend/resume so it won't be changed. so sctlr_elx.tidcp1 will remain 0 if TIDCP1 is not detected by
id_aa64mmfr1.tidcp1.



