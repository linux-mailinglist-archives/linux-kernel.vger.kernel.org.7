Return-Path: <linux-kernel+bounces-794340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F48B3E041
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035A416666C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4B30F54A;
	Mon,  1 Sep 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9InaxCt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E930DD34
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722976; cv=none; b=JxeoTFgknQhTtmzbaAcP2BCHndjq3//HkZIansGHz/Oxddq7zD7t+nA1ZX0PZUowCy0P6JVWYgrFU5o9dmUOnXKorgpN06s0W8QVkXb9VZEEzepizJMXfrLEJMDrg04d0sesSI6Pi+gr95A8XmSvYFptsl3dsGS7ypSxEjvCvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722976; c=relaxed/simple;
	bh=cX4xW+wuCiPdTnfFxi6/ITymE0ZAMVnLHY/t+kS6+mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdXZg2nIoC+6irES1ykkVwPivmEhYNWKwL+yynHzZKW0WPFnD6qZQGIKUxymDHXic1j5BkZ9KA/ocJMZ4p4AZ8ZqJDT1nmRBhTZhpavbvT8Wgj0BXdfXMbkDlmI74Sw0cX5+NCwSqYgRbnmGXr+kj7fzizuPjPsbvRtY4ePZuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9InaxCt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1021686f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756722973; x=1757327773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpExexnZOKJ7iqaCQ+poNcR7uax4pW5z9HIKRX8sboo=;
        b=X9InaxCtwZeXyiLDtltSpjyPCESPjhgL2bAn09iTUBQdt2OlQwcet5GEO1e6XwhnRZ
         7W8bI8Mvuzu09ImZODrINC234i0Qgmz7RiwtA5gXo2puxRNVe7SHddptQ3dk25GlnyuX
         GEacfR23bMKJEIcbpb2DpLZrotP36KKEcLlpNU22nNX15g1esq2MDL/9zqAc+awWOUgM
         SN68MSY7PLn1LEjUEQsPX248slgd+OS25UyL7rjgm4r72+MiX+EnBWl7lXilb8dTiOr1
         35HO2BF8Epvqd+j8xSndixKDE0IpzWe9373U2+z7loFxMso5B2RnvNmkHSwAI0bsnu9c
         LVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722973; x=1757327773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpExexnZOKJ7iqaCQ+poNcR7uax4pW5z9HIKRX8sboo=;
        b=Drh9Ga8smDfnW07RWcRjuTpWS1mmY0r1PxNX+HwG6wFrcmbrNy/xcO/hr80crvrEko
         HsHocJVybVtIm3n4aCezLanlUpiL66HGVoMn0tCjLV+wTUEDtuLZYBmmV+MCH+jwPC18
         x18m9Ra4XgQwBKTRFdHFYx9KzLHcwvX8507O9JELgZseMn2a2Z7iyh4X6e0HIKQ9BnWc
         5WWL4S1D2Ss6Ve+PuUfC6a/NAAari6zsu4+7MQ1au8UMT7Ne45nOva7xBcQjzT0BYJ1I
         i7Y7WLt2com9QdFmOux32VsXafrOkpWI/ifMzzbGBkqOoU/0JoEBDH4+I2d9yuNzIg9U
         klWw==
X-Forwarded-Encrypted: i=1; AJvYcCU/FEk/xCeSN4CvancbCdvAgLWGlvAZb6xFbid4IfGMjuS5pGjW+SgD1Z63GceXJdIktVq/jYOiRfVmsZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXdHlezP+3dXvEareEDLGL5XmtKqEYOi4Eu6ypFSL/CxhSMGO
	af7qgWBZHRFg3MfT/tc0qqVlRM0jifMpf1RyPVZ0iv1PbOBvvn2WXYkcfmNEW5vZh2E=
X-Gm-Gg: ASbGncsiKxao0QKBRh381ptDumgU9DuRfD9+X/sROdbnniqy/SNS+CrN3cygdSfJdXC
	AAYLGyT/6O2qaqLZa6MMyN3yFKaRBkswDHgrdAs1hzG41xPut+vBjYggKs339UJ7I+lznc6WniQ
	zenBiVY4Kd6IHxbV10loyVPs/Z4Iq18scrSHWThByAYoAL7Xre7wtwnqY+sBVyMqpPxhYVdKbdR
	NoI69iHqSH7MeKZtnMMNCg5DAqg+8mExU+xPHDWnNuz6bCN393bT1FOkz7eG83W7eHJ0f4pEx26
	b6vhRongriivtSmT4QYT6szLoe7FB1iZzHRwK06MWUr4fBbkby0pcMwty62tIp2WrtJlo4eo5Fj
	Z37M2iOA/DalYXM+Cm7c98jMENfOeO2CS6GEP2g==
X-Google-Smtp-Source: AGHT+IEusUyvpzGTFZ+MI8lsnkKYt5dsttV6VWwq3/MdNt28CRdwWKratkBzJoTnQ6bNa1MHsKujcA==
X-Received: by 2002:a05:6000:1a8c:b0:3cf:3477:6bbd with SMTP id ffacd0b85a97d-3d1df1568b2mr5850878f8f.54.1756722973005;
        Mon, 01 Sep 2025 03:36:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2ebb9sm4115919f8f.20.2025.09.01.03.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:36:12 -0700 (PDT)
Message-ID: <450f11c2-6c11-4ffa-ae20-db4ea419a3ca@linaro.org>
Date: Mon, 1 Sep 2025 11:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Fix NULL pointer access issue
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, quic_yingdeng@quicinc.com,
 jinlong.mao@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20250901-etm_crash-v1-1-ce65e44c137c@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901-etm_crash-v1-1-ce65e44c137c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 11:01 am, Yingchao Deng wrote:
> When linux is booted in EL1, macro "host_data_ptr()" is a wrapper that
> resolves to "&per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)",
> is_hyp_mode_available() return false during kvm_arm_init, the per-CPU base
> pointer __kvm_nvhe_kvm_arm_hyp_percpu_base[cpu] remains uninitialized.
> Consequently, any access via per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)
> will result in a NULL pointer.
> 
> Add is_kvm_arm_initialised() condition check to ensure that kvm_arm_init
> completes all necessary initialization steps, including init_hyp_mode.
> 
> Fixes: 054b88391bbe2 ("KVM: arm64: Support trace filtering for guests")
> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> ---
> Add a check to prevent accessing uninitialized per-CPU data.
> ---
>   arch/arm64/kvm/debug.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 381382c19fe4741980c79b08bbdab6a1bcd825ad..add58056297293b4eb337028773b1b018ecc9d35 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -233,7 +233,7 @@ void kvm_debug_handle_oslar(struct kvm_vcpu *vcpu, u64 val)
>   void kvm_enable_trbe(void)
>   {
>   	if (has_vhe() || is_protected_kvm_enabled() ||
> -	    WARN_ON_ONCE(preemptible()))
> +	    WARN_ON_ONCE(preemptible()) || !is_kvm_arm_initialised())

Hi Yingchao,

There shouldn't be a warning for this, at least for the case where it's 
not initialized and never will be. If you're never going to run a guest 
these functions can all skip, the same way for !has_vhe() etc.

A warning would only make sense if it's not initialized but will be in 
the future. I'm not sure if we need to worry about that though, because 
the KVM init stuff happens before the ETM driver is used.

Thanks
James

>   		return;
>   
>   	host_data_set_flag(TRBE_ENABLED);
> @@ -243,7 +243,7 @@ EXPORT_SYMBOL_GPL(kvm_enable_trbe);
>   void kvm_disable_trbe(void)
>   {
>   	if (has_vhe() || is_protected_kvm_enabled() ||
> -	    WARN_ON_ONCE(preemptible()))
> +	    WARN_ON_ONCE(preemptible()) || !is_kvm_arm_initialised())
>   		return;
>   
>   	host_data_clear_flag(TRBE_ENABLED);
> @@ -252,7 +252,8 @@ EXPORT_SYMBOL_GPL(kvm_disable_trbe);
>   
>   void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest)
>   {
> -	if (is_protected_kvm_enabled() || WARN_ON_ONCE(preemptible()))
> +	if (is_protected_kvm_enabled() || WARN_ON_ONCE(preemptible()) ||
> +	    !is_kvm_arm_initialised())
>   		return;
>   
>   	if (has_vhe()) {
> 
> ---
> base-commit: 8cd53fb40a304576fa86ba985f3045d5c55b0ae3
> change-id: 20250901-etm_crash-0ee923eee98c
> 
> Best regards,


