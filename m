Return-Path: <linux-kernel+bounces-826397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A2B8E69D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D2717C50C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE817A5BE;
	Sun, 21 Sep 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEFagO3U"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879449620
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490861; cv=none; b=lj5fn80fwLROSP6jQtyNNo79QfMWG+h4WxDfBCGV/vQkRJa4eW+Z2l31xnSkuHqVMXrDOb+dWoMjuI8+9QL2htA5l187tqSy2Ebg8AOiqbRnfZV7+z3Dy0/60PA5fexY5rriIRmUAZx3vlsksva6a2dBWUxzKonTFKWHLGIoO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490861; c=relaxed/simple;
	bh=1oNc0sJYdb9rX45c7syeiBdncY9kKRBhqLifXQ83cWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aw+Av8v8J7WvdWqg0KcryymKNE9nFTNTGh4FiE4LtVRxd6+fAqUlxdWS2CtL64uuTny2Xf4B/phqh/7osMV9ZSxHJskRxSLOBLa14bpyIWI2MZzA5WfVxCB4eRoRvLdKBPse44OZ1ZhraqzHsdY2FUuLdntpVHYy1pTl8X+a/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEFagO3U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b7580f09eso4825085e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758490858; x=1759095658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WosRKVT+AD3vASAmC7vYIumBFhKj0WFw859hR7TLepU=;
        b=IEFagO3U5hCLobCInDoUWdX+cA1L5BKqe7vFziLOlDQyrCIDGn404BS8nLOcd0LDXz
         MvIHk8jfT8ThEk7/VU5icdcJtU3OXQvyYVhBwPm9ftck7jbr88B70PIb0ClkiVaHz9fQ
         xSWOxwtchvSAzKP273aAWRSuqFDYyK61bp6TxIqOQ/3Ou7f1a8YWTmMRG15xG+pXkcJI
         dFlmlY4Qt2SFF/ssHHgA+8BuLtW80Ywt8h5lUXK/A0dwzGPjCOP2JlM5lD/Qz9cOzjE5
         hHRBqaV3FasUJz5r7RFIe/XnfLkSdWmRYdAnNwOqByxh/BwmgEvKOBSUX0p9RzIspj7v
         kizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490858; x=1759095658;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WosRKVT+AD3vASAmC7vYIumBFhKj0WFw859hR7TLepU=;
        b=lt1p6SFu3zHyhDlAa3ctgfNnQLbvdEH4I6CAMr2LgaZJz+3xz8eUzixu8nLt0ftFMF
         CykY9HenJiINrtB350i8a9ktQaXdJ9oBcAhdsIK8Ox+zEjn9BEJUmpy6KRitP1GC8NI/
         NCps2A7qSrkG1LOq0pQpF4pYfv6+sCzkNBFcPbI1uALb5zXaEAUw4SIIKJSMp98tJAJo
         EOUcoTp2be/p5e1mHr7w4kIrTIGwlO6TYxBdx84ElMUkYpVXBTW+tZI5nvEjWgzJVCy/
         IXpDjDuh/ULd5FKXU8DaQKDhWvrSXBMLy8qm71FxKCt9H2yLHeVMXNQTKj4Ao2AJc8ZV
         Houw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1BUm9s8Tw616I1YWpC0MsMSJhSG+gqbxipRUP3WAzImvvXMEM4Yq0lPhkgS+dzQBmhyY2g0mcYI45qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyxPbgAoE9rsX/4das0RfDUTcC48+3gfc6yT/0iLi2BVbgFM6
	uW77gAAc+DUkz/fBaAsf6DvHx9sJ046lS/Sbi7n0ZPCtlVFcIkSDctWui7vyR5x6eYKm83CRUGd
	BxM3iQE0=
X-Gm-Gg: ASbGncs5XfGWEbz5y0UnX7KniW65NmQbklhNja5yBxIlT0wyk6p5dzyYArFJgY2ZlKy
	+O8sKQBpghyhMEFH5d9vo84NwvhmQacPKlCEDNDntgF5ctoAj7+vmq7KCMrrvPG7I7uJicGDkit
	ShBZsIbEnyh4kh1cuuIg6ILDB0C1CfqZPg1rVv+Cl5edWNyQUCczDTjBO8hjkR2OI1RAQJYk+gA
	ro3SAJVd/bXpOLiJSMd5mgJfVusY3XIRSbbjZtZOBEbx2co1STLZY6WxpZJO5U8Gn9Kcb3QxLzK
	Eru7cxE+L8ms+kgf+oW5kGJuIWtQKLiLFU7ZyYW4bJg/g4rfMm6D8FQ2DBbDOwzSGXtnEOQ4Off
	7bjJ0YRjivqNb5kg+qBJxHt6IrqcvyojeKAYCy8KzNtuk6w/UG358qnk2jOcjKcJKfR04Pw/1Lt
	ouOEEOdDtaYM6RhaI1RHc=
X-Google-Smtp-Source: AGHT+IFxQ7JkZZfaB476dGmISNTL1lZ3jMkfAy+OvS9OYEaehjoDsIOQ0nLG6IoE+CEVTZH9/YurZA==
X-Received: by 2002:a05:600c:4ed1:b0:45d:d291:5dc1 with SMTP id 5b1f17b1804b1-467eb8e216emr94817635e9.15.1758490857615;
        Sun, 21 Sep 2025 14:40:57 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm201206795e9.23.2025.09.21.14.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:40:57 -0700 (PDT)
Message-ID: <9139706a-708c-4be6-a994-120cce0cd0e6@linaro.org>
Date: Sun, 21 Sep 2025 22:40:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] firmware: qcom_scm: Introduce PAS context
 initialization and destroy helper
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <VaE1QImrKf8gxtMr-dFBEHJ0Mv9-1ugwsOz5I1Uaz1PXt6aJMrWR7G3c5bN74hJYzy5v6_obB1OqKgtgdbCUcw==@protonmail.internalid>
 <20250921-kvm_rproc_pas-v3-3-458f09647920@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250921-kvm_rproc_pas-v3-3-458f09647920@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2025 20:41, Mukesh Ojha wrote:
> When Secure Peripheral Authentication Service (PAS) method runs on a
> SoC where Linux runs at EL2 (Gunyah absence) where reset sequences

"i.e. runs without the Gynyah Hypervisor then, reset sequences"

> move to EL3 and Linux need to do some extra stuff before calling PAS
> SMC calls like creating SHMbridge. So, PAS SMC call need awareness and
> need handling of things required when Linux run at EL2.

"Therefore the PAS SMC call"

> 
> Currently, remoteproc and non-remoteproc subsystems use different

"Currently remoteproc"

> variants of the MDT loader helper API, primarily due to the handling of
> the metadata context. Remoteproc subsystems retain metadata context
> until authentication and reset is done, while non-remoteproc subsystems
> (e.g., video, graphics, ipa etc.) do not need to retain it and can free

"do not need to retain metadata context"

> the context right inside qcom_scm_pas_init() call based on passed context
> parameter as NULL.
> 
> So, in an attempt to unify the metadata API process for both remoteproc

"In an attempt to unify"

> and non-remoteproc subsystems and to make the SMC helper function
> cleaner whether SoC running with Gunyah presence or absence by introducing
> a dedicated PAS context initialization and destroy function. Context
> initialization beforehand would help all SMC function to carry it and do
> the right thing whether SoC is running with Gunyah presence or absence.

Since you need to do another version of this patch re: below, please 
tidy up the commit log here a bit too.

> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>   drivers/firmware/qcom/qcom_scm.c       | 53 ++++++++++++++++++++++++++++++++++
>   include/linux/firmware/qcom/qcom_scm.h | 11 +++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 3379607eaf94..1c6b4c6f5513 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -558,6 +558,59 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
>   		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
>   }
> 
> +/**
> + * qcom_scm_pas_ctx_init() - Initialize peripheral authentication service
> + *			     context for a given peripheral and it can be
> + *			     destroyed with qcom_scm_pas_ctx_destroy() to
> + *			     release the context
> + *
> + * @dev:	  PAS firmware device
> + * @pas_id:	  peripheral authentication service id
> + * @mem_phys:	  Subsystem reserve memory start address
> + * @mem_size:	  Subsystem reserve memory size
> + *
> + * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
> + */
> +void *qcom_scm_pas_ctx_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
> +			    size_t mem_size)
> +{
> +	struct qcom_scm_pas_ctx *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->dev = dev;
> +	ctx->pas_id = pas_id;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +
> +	ctx->metadata = kzalloc(sizeof(*ctx->metadata), GFP_KERNEL);
> +	if (!ctx->metadata) {
> +		kfree(ctx);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
> +
> +/**
> + * qcom_scm_pas_ctx_destroy() - release PAS context
> + * @ctx:	PAS context
> + */
> +void qcom_scm_pas_ctx_destroy(struct qcom_scm_pas_ctx *ctx)
> +{
> +	kfree(ctx->metadata);
> +	ctx->metadata = NULL;
> +	ctx->dev = NULL;
> +	ctx->pas_id = 0;
> +	ctx->mem_phys = 0;
> +	ctx->mem_size = 0;
> +	kfree(ctx);
> +}

This looks a bit strange, manually destructing an object you then free. 
I get the argument you might make about use-after-free but, I don't 
think this level of defensive coding is necessary.

> +EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_destroy);
> +
>   /**
>    * qcom_scm_pas_init_image() - Initialize peripheral authentication service
>    *			       state machine for a given peripheral, using the
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index a13f703b16cd..e3e9e9e9077f 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
>   	ssize_t size;
>   };
> 
> +struct qcom_scm_pas_ctx {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	struct qcom_scm_pas_metadata *metadata;
> +};
> +
> +void *qcom_scm_pas_ctx_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
> +			    size_t mem_size);
> +void qcom_scm_pas_ctx_destroy(struct qcom_scm_pas_ctx *ctx);
>   int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
>   			    struct qcom_scm_pas_metadata *ctx);
>   void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
> 
> --
> 2.50.1
> 
> 

Once fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

