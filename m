Return-Path: <linux-kernel+bounces-864155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02831BFA0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65E163530E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4352EA16A;
	Wed, 22 Oct 2025 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjU+3b5+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9302E9ECB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110825; cv=none; b=NNq1ATmMAjpMWNiQUJ+zqgddKHKS/WHYf8RwiiCFION0kzq25ACxHG7ZA/9e319Demz+DbOUqeiZMQKH9wcAtJ2G1+tIVt0TlGaVwyNCjwSzovqkpCH1K2h7/RfZx2Fh0VVxiaBFI+K18IsHTCf58JwZvTJx9I9E4WBWxak08mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110825; c=relaxed/simple;
	bh=6PcYgNUKdWIn2Ck+xpBBoxLCHwQgjGsmOR5AfWCpOFY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kOaWCCbqE2LzOHUM6SRmxj/jKoSt9Y9Yc+lkcOI/PU/6DlzqKzFx9XMY84WmxIDbSaS8MqTILx9yLqdkhOX8mBj72PtTlEHT9cj+dZN5Tv9NIRTX7os5zLfC7B31dF9Af6GpNgJ2o/cJmsqO0DL6Y6OKKzZwsRLLtXczPno77DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjU+3b5+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b62e55af64aso214451a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761110823; x=1761715623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMy1RVx5Qy0vPfZy8HmPzaiGS+prOdh9j7/eJWslVtk=;
        b=DjU+3b5+EOoZxqKkYKcZP3GOJgbDQR+0rNu05rvBRowGkLYi9Xa02qjbTM3bFXVpV4
         IIfpwgtOol7FxVXekqx8yoHtZcAkNtrcWJ5ZhX1lHuHQY6LByzzIMGSuEvtDc9cYJT7n
         Yiho/nCrbvlqWe5BTOCxmnBKCrTKfoC2ZjautrNJdbKtbxepnwstsJrx6xzDZi72p+JB
         8wDy8a3yck0HSQJrpaPz5/AZ6bc3maTCxvKa9m2+anFLuM/t6TPzYRghomBzjn/tNSqv
         ZmDmSoaVpsQUy/MQcIH7QI3O8KVuXeGx9sirV0fFpO3EteLNiF2x5IcZjbh1c0Sff1YN
         XNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761110823; x=1761715623;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EMy1RVx5Qy0vPfZy8HmPzaiGS+prOdh9j7/eJWslVtk=;
        b=TVEOJzso027/SDZ9wuvWmhAUMCaO//IrPT+koM9HOY9KAjSHZXeXNGhNw3St5Csz8A
         tmmqCYrsCCQO28sxvsBMMT4RsYq+l0W/fA4maQuvn0fu6+f6TWV2hI0OYY+mB2t/nQt+
         U8Y0du5Ogl7xhhvQhqvjLpiQnjfFtg9KIXZ7PI2+x9lp8+BzT4hN0LUePtxYA3YvuW5V
         7xCHLAHmUbVOMMCSRzaEMI7gNEc3oGN9sgYl+kz4Zhcl5Z1JNrtEgjW4OE3s0P5vtsgq
         AcoEcF9OdIkg1lXsEe5gCKjjQ/aFGe250vM5RfwjUqO3TU+c1vlVnOCRc0bVAZeT2B2V
         doxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlFIMXugp3vh5C0WuaL+HdNqOYJDAPSw80C01/Lm1CZIHuyasB7SnJbBKZAymG5xJa8eR9V0SIUEiGY4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQDonYAvL5YijAOG2TRyyTD3Gqp/HOI22IJY29ZieadcX50QP
	i7S76X3C185YvwAzoQH7kcw2wkFuLOrSznrP6XBeshc/+GLOVYHyk69I
X-Gm-Gg: ASbGncsoRhzcKWi/Lx5/UGi0Lt4iqW8cPA9niVQruSK4C1RwAE2/fvj0j4VDupxGehO
	TjD7L1UARbgHgasf1fHQd4BlY9IuuWbrOkBIbVmWsvCEgX0zwnrhQqQLgSxVQbLK6JhqhSQczku
	m8WVL6+d7dBP5YkiFejiLuh+BhB25muH8Ru39eikGO+x31kXvaTDXUh736n6xFnHyuB0arAt7QE
	kqoG82vTGYiynNZic1o9nijWA4bW1qWdXTfY8lRSExie+/4c3L21WGeQh9GeixyhTlThIBW7SLg
	y5eu/zmO4O2Te7T4uF6fBO/gLPHhOxa9QfQeLu+MFlw0w87WauGWy3uZLJr57PKtt29ZZHPGuPV
	zbs+YlEU7RxMleUR/+vDzr1A51419tslmIhauE5aVaM8Fd5ctQSsF30CGprRmAt+YVPlgR4fahy
	ikXissMpizhUxZ9R9n
X-Google-Smtp-Source: AGHT+IGhGdOmH2B7aouX3Oqkd7p74ev3sL8pZK6NfUPz74y/pmwymDvftWw11uDanLvIHrYSspqiBA==
X-Received: by 2002:a05:6a00:23d6:b0:77e:543e:3f3d with SMTP id d2e1a72fcca58-7a2572e9cc8mr3676024b3a.5.1761110822910;
        Tue, 21 Oct 2025 22:27:02 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.181.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ebfsm13188175b3a.70.2025.10.21.22.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:27:02 -0700 (PDT)
Message-ID: <1ad9d43b-fd1f-4a66-b67b-14f0b3217aec@gmail.com>
Date: Wed, 22 Oct 2025 13:26:40 +0800
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
To: Liao Chang <liaochang1@huawei.com>, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, mingo@kernel.org,
 bp@alien8.de, kees@kernel.org, arnd@arndb.de, fvdl@google.com,
 maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
 yeoreum.yun@arm.com, james.morse@arm.com, ardb@kernel.org,
 hardevsinh.palaniya@siliconsignals.io
References: <20251021115428.557084-1-liaochang1@huawei.com>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20251021115428.557084-1-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/10/21 19:54, Liao Chang wrote:
> Add kernel parameter to allow system-wide EL0 access to IMPDEF system
> regregisters and instructions without trapping to EL1/EL2. Since trap
> overhead will compromises benefits, and it's even worse in
> virtualization on CPU where certain IMPDEF registers and instructions
> are designed for EL0 performance use.
>
> More early discussion could be found from link below.
>
> Link: https://lore.kernel.org/all/24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com/
> Tested-by: Xinyu Zheng <zhengxinyu6@huawei.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  arch/arm64/kernel/cpufeature.c                  | 14 +++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5a7a83c411e9..11ffa9f7b972 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -326,6 +326,15 @@
>  			See Documentation/arch/arm64/asymmetric-32bit.rst for more
>  			information.
>  
> +	no_trap_el0_impdef [Arm64,EARLY]
> +			Allow system-wide EL0 access to IMPDEF system registers
> +			and instructions without trapping to EL1/EL2.
> +			Since trap overhead compromises benefits, and it's even
> +			worse in virtualization on CPU where certain IMPDEF
> +			registers and instructions are designed for EL0
> +			performance use. This assumes the kernel adds the
> +			support for Armv8.8 extension FEAT_TIDCP1.
> +
>  	amd_iommu=	[HW,X86-64]
>  			Pass parameters to the AMD IOMMU driver in the system.
>  			Possible values are:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ef269a5a37e1..d12e35d799ee 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2459,9 +2459,21 @@ static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, in
>  }
>  #endif /* CONFIG_KVM */
>  
> +static bool no_trap_el0_impdef;
> +
> +static int __init parse_no_trap_el0_impdef(char *p)
> +{
> +	no_trap_el0_impdef = true;
> +	return 0;
> +}
> +early_param("no_trap_el0_impdef", parse_no_trap_el0_impdef);
> +
>  static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
>  {
> -	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
> +	if (no_trap_el0_impdef)
> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_TIDCP, 0);
> +	else
> +		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
An id override for TIDCP1 seems simpler rather than an early param, and consistent to how we disable other 
certain features through boot option like arm64.nosve or arm64.nompam. I see Catalin also suggested in that
way in [1],any reason we cannot do it in that way?

[1] https://lore.kernel.org/all/aHqamaqueuk18NyS@arm.com/

Thanks.
>  }
>  
>  static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)

