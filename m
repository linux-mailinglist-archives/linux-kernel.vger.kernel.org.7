Return-Path: <linux-kernel+bounces-826393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6AB8E637
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BA3BCA87
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B62C21DC;
	Sun, 21 Sep 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NP5Y6sVj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993A239E7D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490270; cv=none; b=Tt+oI+2qGoIFBKRczXqujrLN8uwJCc/d7n7bTvY2safTtADcYUlCJxw9E+x9eUAAWv1OQWod9mL/2KRSN+gQ5MeRanEanzaXl7Y75Wepf7sSBYpYJZa5X7OlIdvWDP2TH5QDFOdEKr/KVhx6LKOObala+rNTRoHY4grgQFgINUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490270; c=relaxed/simple;
	bh=DZpkHI4TD2hvKTQKBnBvZs/BblBW5gA4aYkqMLJjl5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcL0pOd6vShG+aN4nakll9hz0k2lBUuD7uBE6IPBgOa0vCcp0zkCXmgAq2ZtRDzIa8gr8wg1Va2BdQSc4oicP+/bdUIaiFggbm7bDJ2Hm7bHt9zqJFoVlbUrmUYcXDOG9T9M6JpJ0TNShbRt3QHCzXsgIM9AayZ9StgmPx1cQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NP5Y6sVj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso33476865e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758490266; x=1759095066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbZQorlrgA6b5A6SBj4ZBWzjR7Vw60RlID9QDg6+Jl0=;
        b=NP5Y6sVj36oU6fN92/xtCrZ6OAlf7AcTqY3omPIlLwr01wX6cXkYOItLz34qzq73cV
         s+MR+JcOv35XKG1/0rVfIex8u5755wSMXSbIMQfH6/lr+8smjIbSolW8sSJJQiJnskja
         JSWuzH2P57A9p3KQxrfWcJa0u34qt5tUYM4M+wcRrcAaa90YIwPDKNyu9uJiCltHOnMZ
         jhbzKsDQUUUm57u+CmA696QMzr9vRdzyOX0s4SowzTZ99QDILJ+b+WXwME+ioc8RR2JC
         3YCe9zhIip2LxYnZ5jODsyiybhseXiwFLaYLCHe8AJzxcZG19iIAWxX7Wjpupb9aKsmx
         zvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490266; x=1759095066;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbZQorlrgA6b5A6SBj4ZBWzjR7Vw60RlID9QDg6+Jl0=;
        b=RxFY+tB8uQ8ar4TOiiTbHBo5ljnW8I26YZO69/9NNCU2vN0C6lg7K6/sz1ej0Zuqmm
         InnJJZFFKeimv5orFuH2JebC3rmkg01KJXvJ4PVJ9Q2XnTjyI/mIaPSkE2vExBHbcBMe
         sDSR8heI25s1gZKqUsRhuZm4EHhOm4PbQrkAHdv1NI84XUaEKHDMjLLM+MCOYGlcVrTt
         re6kXD0P80wW8ZssoEifsJg23DnH3GYxkUUBlvPkVMKnpeSmZ/ZzQw4XcLQQpQT3jTB0
         JtWftWu/U1zcaUOW+HEo0bLrF+mLhtr4Y5AnersalJciQxtabo/bcQMtPndupcu01dX/
         A3eg==
X-Forwarded-Encrypted: i=1; AJvYcCWR3uxc1WNEtY5nEMEqp0HKBfPAoBUq9TbZbFDDh75U1NMQsSxUEAWwXa0Uu0NP76ZghNF/7eO90xBf+HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FYWt8HJIctjbOM2wy1VlELM/s6DaP8kxYkeaM/5SrIHrTEuR
	qWdVFO2nZjhQFvkpvcT5UssfK2Q6nGPWMjOFYNncziN7ke2wfcVraj454fM9IcgJU5JjHJEe5Nr
	tkbh5kVk=
X-Gm-Gg: ASbGnctL8JFW+psDg91X9hm4hCfD4DmPJgxiq/16w9l1GH+W4XRIuceH+eXQDxpCmQ1
	ALAVshIkwWlc3qVyzn8Bla5YuJThcrzfbwPm8mKEGdCkmiWOPeQvDrJE09E4Nw15mThNlGxIeC8
	AQ5WwaVdlTdps6e1AzRWzgXKtmsykBDVQxmVi3TyGfit87qPOt48jrFuaqHX1TQI5wFjAvUen2v
	YNt65kBuGYQXPS7pjnXJfZp6FTA6i/6IHhfXELCUsO4fb7ZhrNkAGLhP+KcHCQTZrShMZFYOkvk
	aiusbu1QwyxSHKez8VM6ZwIbzf6XIEkbUS1QVA1jT9fuPHDGvNCC2Sk1J11N83gDBT6luwDLkiv
	AtiIWkQNYQidNDmcP6UWJcXhw4rfmM8PxkEvcxu7jkvJVnRjNjuqX13KvtYKoGR61or+HIciIU1
	BPrD3DVvXeLk9z/XkQ5+k=
X-Google-Smtp-Source: AGHT+IGqFUiCUYgfnAodCkYRdOYe88jnjHMAVwRc+cHVKvA44NreuIhB2IHj2+gqeBMuaZ+h+lm2Ow==
X-Received: by 2002:a05:600c:450b:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-467eaa86fddmr108599635e9.31.1758490265825;
        Sun, 21 Sep 2025 14:31:05 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e09f879sm214454715e9.19.2025.09.21.14.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:31:05 -0700 (PDT)
Message-ID: <fb4ce572-5fd7-4533-a783-f98c191dc910@linaro.org>
Date: Sun, 21 Sep 2025 22:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] firmware: qcom_scm: Rename peripheral as pas_id
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <h5BhHaTRDvnuxhBvoD8fUGJ_NA7Kg29dqnpXWxtR36TI4j3KPZ1lC5cARb92L7F9mPrWcZtsjIb3aI7ASr0V8w==@protonmail.internalid>
 <20250921-kvm_rproc_pas-v3-2-458f09647920@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250921-kvm_rproc_pas-v3-2-458f09647920@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2025 20:41, Mukesh Ojha wrote:
> Peripheral and pas_id refers to unique id for a subsystem and used only
> when peripheral authentication service from secure world is utilized.
> 
> Lets rename peripheral to pas_id to reflect closer to its meaning.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>   drivers/firmware/qcom/qcom_scm.c       | 30 +++++++++++++++---------------
>   include/linux/firmware/qcom/qcom_scm.h | 10 +++++-----
>   2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index e777b7cb9b12..3379607eaf94 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -562,7 +562,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
>    * qcom_scm_pas_init_image() - Initialize peripheral authentication service
>    *			       state machine for a given peripheral, using the
>    *			       metadata
> - * @peripheral: peripheral id
> + * @pas_id:	peripheral authentication service id
>    * @metadata:	pointer to memory containing ELF header, program header table
>    *		and optional blob of data used for authenticating the metadata
>    *		and the rest of the firmware
> @@ -575,7 +575,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
>    * track the metadata allocation, this needs to be released by invoking
>    * qcom_scm_pas_metadata_release() by the caller.
>    */
> -int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> +int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
>   			    struct qcom_scm_pas_metadata *ctx)
>   {
>   	dma_addr_t mdata_phys;
> @@ -585,7 +585,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>   		.svc = QCOM_SCM_SVC_PIL,
>   		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
>   		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
> -		.args[0] = peripheral,
> +		.args[0] = pas_id,
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   	struct qcom_scm_res res;
> @@ -658,20 +658,20 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
>   /**
>    * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
>    *			      for firmware loading
> - * @peripheral:	peripheral id
> + * @pas_id:	peripheral authentication service id
>    * @addr:	start address of memory area to prepare
>    * @size:	size of the memory area to prepare
>    *
>    * Returns 0 on success.
>    */
> -int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
> +int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
>   {
>   	int ret;
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_PIL,
>   		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
>   		.arginfo = QCOM_SCM_ARGS(3),
> -		.args[0] = peripheral,
> +		.args[0] = pas_id,
>   		.args[1] = addr,
>   		.args[2] = size,
>   		.owner = ARM_SMCCC_OWNER_SIP,
> @@ -699,18 +699,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
>   /**
>    * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
>    *				   and reset the remote processor
> - * @peripheral:	peripheral id
> + * @pas_id:	peripheral authentication service id
>    *
>    * Return 0 on success.
>    */
> -int qcom_scm_pas_auth_and_reset(u32 peripheral)
> +int qcom_scm_pas_auth_and_reset(u32 pas_id)
>   {
>   	int ret;
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_PIL,
>   		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
>   		.arginfo = QCOM_SCM_ARGS(1),
> -		.args[0] = peripheral,
> +		.args[0] = pas_id,
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   	struct qcom_scm_res res;
> @@ -735,18 +735,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
> 
>   /**
>    * qcom_scm_pas_shutdown() - Shut down the remote processor
> - * @peripheral: peripheral id
> + * @pas_id:	peripheral authentication service id
>    *
>    * Returns 0 on success.
>    */
> -int qcom_scm_pas_shutdown(u32 peripheral)
> +int qcom_scm_pas_shutdown(u32 pas_id)
>   {
>   	int ret;
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_PIL,
>   		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
>   		.arginfo = QCOM_SCM_ARGS(1),
> -		.args[0] = peripheral,
> +		.args[0] = pas_id,
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   	struct qcom_scm_res res;
> @@ -772,18 +772,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
>   /**
>    * qcom_scm_pas_supported() - Check if the peripheral authentication service is
>    *			      available for the given peripherial
> - * @peripheral:	peripheral id
> + * @pas_id:	peripheral authentication service id
>    *
>    * Returns true if PAS is supported for this peripheral, otherwise false.
>    */
> -bool qcom_scm_pas_supported(u32 peripheral)
> +bool qcom_scm_pas_supported(u32 pas_id)
>   {
>   	int ret;
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_PIL,
>   		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
>   		.arginfo = QCOM_SCM_ARGS(1),
> -		.args[0] = peripheral,
> +		.args[0] = pas_id,
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   	struct qcom_scm_res res;
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index a55ca771286b..a13f703b16cd 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -72,13 +72,13 @@ struct qcom_scm_pas_metadata {
>   	ssize_t size;
>   };
> 
> -int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> +int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
>   			    struct qcom_scm_pas_metadata *ctx);
>   void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
> -int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size);
> -int qcom_scm_pas_auth_and_reset(u32 peripheral);
> -int qcom_scm_pas_shutdown(u32 peripheral);
> -bool qcom_scm_pas_supported(u32 peripheral);
> +int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> +int qcom_scm_pas_auth_and_reset(u32 pas_id);
> +int qcom_scm_pas_shutdown(u32 pas_id);
> +bool qcom_scm_pas_supported(u32 pas_id);
> 
>   int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>   int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> 
> --
> 2.50.1
> 
> 

Thanks, thats a more comprehensive patch than I had expected.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

