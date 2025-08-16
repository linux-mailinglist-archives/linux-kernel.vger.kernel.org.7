Return-Path: <linux-kernel+bounces-771929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60072B28CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B71A28B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13B8298CB6;
	Sat, 16 Aug 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZ5U0gRD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DF293C42
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341063; cv=none; b=J/4YPMIze9PqDQ2D/6tt/nwQmQt8eYqLx6aB4SfwX2wWwxSCvzdAnJ2OD19knkq6TVXi9JmouLx5Sy/q1TD0+4TD0+zKasB/uwMQ/Hkae9kH9ccIw7/fDnHNm0Dzj/Vfrq7jSpJQVHE7NliQ8BB/dh+xoqYXLpXSiEKfT4kVnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341063; c=relaxed/simple;
	bh=giznPJefi0bbTBjqBQghdivjTXIbW2Tpm3pqNYK8uew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxbHSEcll532/yCbf51jppw7SESxwo9K0X3ovqTh7LpEKMPtv6PlUPeSNZRBQ27/QobGGc3nqMh0CrvLaezQ4ED+MSb3X/eWHBI5/ByYwtsntJuLqaJr/gRtoEFYusKQ+B+UHmrMppjZOp9zX3/2faG/GW1o9wPghFImOSXsH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZ5U0gRD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e414ef53so2551119f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755341058; x=1755945858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+87OkgEg+mw0Fep350vzSqyIISt8PfhGghcXUeltSrE=;
        b=yZ5U0gRDkM7kCXTL/9zVrdkctEbAXMdBrIUeNeqjQpxROUQo165qBqfAqMPzaN2CdU
         veUFHhisNRhDT3+kSrWDTN2mkPYYZqZwj0GnURS+cFUXzMBPeg7qy1VgD86CwnBo9pq4
         FW1s+X36OdQp8wTj/4mTCkq9UMnVbkJdzwh+BEqaAJZ5yZEHpZ5d+mkxZfOuimMaFAUl
         HSwjmtUjiEuYZOrVpeMdG+zYO7fb5M4gbKlwg90ToPt7WU2yaca2PkqAyGGkilmpNbVo
         DDbshKvbANytRkpIZACRkcKw7OD7Hl8r2F+7snbiAbBkYq56oeouFKNsjGZh5+qlmWFp
         RmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341058; x=1755945858;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+87OkgEg+mw0Fep350vzSqyIISt8PfhGghcXUeltSrE=;
        b=RSPOhV6yiVy2AQDOfHx5PfQN6nrAxZM3UphnYdppB5OjeM+6yiKew9kH43MhBKqaDn
         VJh762U4v9vbVXo06clPfbsNc2xWJPtPT97zeXXpvEGv+2+IxjJPB0PoftjRsm1CIn1f
         jcqZJZDCk3MK2I+IiD9oWNgeGJ6zK+2B7ye06baTd2MbDMeq5nviqWXn687vpKYZwBSb
         huY9OrbZqUyYo7Cek+cBEzPcC6njJaRnfG+5fNuIHemGUjwGF9g09qTfxrxAotv1e31j
         92MbRszfkoaA9s5jeXaj8rzVaevfol3Z8JTUoIdXVFjw0deytKUs4aNDy3z26jRqy+u+
         WQAw==
X-Forwarded-Encrypted: i=1; AJvYcCXX2RRV0wejbSgGOrObJUjtDp+JQL5XxM7VTfuNEtkl1K+HnQyI8RM0oRJdX8DIi4ScS1sqlJbR8IA/ESI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJqytzau3M0/OtuWYA6xZDmQsOjeQyKsYyAbizOnWgwNv2fwm
	0nQQewdVjoL/JpG1RVkU9KyyPjkp2SXqi8v/+a+bJCa5/XeVZAlVs7HP+yLaLVlC7Wk=
X-Gm-Gg: ASbGnctVMpAIasVoSpDUFbm+eQveH6WlX9KJlvuaC265FIClAUlLzLBh0kiVgS7GvKD
	h/hv8KtUyXXswfZmqs1TyNNZ/Ku0IdFBslSKmJUuUDxlSI9dHsizQVo36ss2U+jt2roDYArAp96
	7JPDs36mafWoeXh5WaOOcHSlA+5D1aA/WcOBQP3Vv/RWCxvalIv8YVW2+fRfrlO6G0Oxqkt5gsg
	QeHwgoFDbr+PgiB1ccV0qmyJNTlDik5C5OuPtwW1ARqVHK9OqnC47JLaS1MKu2chXnUQusehEl0
	V6jqD2kc79aaIRwuDU+7JEqDSjPsWagzcrfwCV55qjbfkpj+ZwhoWy7FfgioqxAC7uEoXId2sdt
	btuHIy2ykkCKkP8xcIQ8+VhVnKlow3o341wqjNwjsTaxSYJARqNWvwiFknQOWxaba
X-Google-Smtp-Source: AGHT+IGatrxnRyuYHYANVLY/7vM/kOG3lSGdbl/URxjLIRGA2WFL+5tKlpJurr0CG4KYGcBT0PnDvw==
X-Received: by 2002:adf:e651:0:b0:3bd:148e:212 with SMTP id ffacd0b85a97d-3bd148e0419mr701845f8f.14.1755341058318;
        Sat, 16 Aug 2025 03:44:18 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079d3fsm5491248f8f.55.2025.08.16.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 03:44:17 -0700 (PDT)
Message-ID: <de539f3c-e048-4e75-8f4f-7d953b2b1942@linaro.org>
Date: Sat, 16 Aug 2025 11:44:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/24] media: iris: Always destroy internal buffers on
 firmware release response
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-6-c725ff673078@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813-iris-video-encoder-v2-6-c725ff673078@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 10:37, Dikshita Agarwal wrote:
> Currently, internal buffers are destroyed only if 'PENDING_RELEASE' flag
> is set when a release response is received from the firmware, which is
> incorrect. Internal buffers should always be destroyed when the firmware
> explicitly releases it, regardless of whether the 'PENDING_RELEASE' flag
> was set by the driver. This is specially important during force-stop
> scenarios, where the firmware may release buffers without driver marking
> them for release.
> Fix this by removing the incorrect check and ensuring all buffers are
> properly cleaned up.
> 
> Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue internal buffers")
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Tested-by: Vikash Garodia <quic_vgarodia@quicinc.com> # X1E80100
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> index a8c30fc5c0d0668cc9980f2fcfcf21072cf9ef0a..dda775d463e916f70da0b879702d96df18ea8bf7 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> @@ -424,7 +424,6 @@ static int iris_hfi_gen2_handle_release_internal_buffer(struct iris_inst *inst,
>   	struct iris_buffers *buffers = &inst->buffers[buf_type];
>   	struct iris_buffer *buf, *iter;
>   	bool found = false;
> -	int ret = 0;
>   
>   	list_for_each_entry(iter, &buffers->list, list) {
>   		if (iter->device_addr == buffer->base_address) {
> @@ -437,10 +436,8 @@ static int iris_hfi_gen2_handle_release_internal_buffer(struct iris_inst *inst,
>   		return -EINVAL;
>   
>   	buf->attr &= ~BUF_ATTR_QUEUED;
> -	if (buf->attr & BUF_ATTR_PENDING_RELEASE)
> -		ret = iris_destroy_internal_buffer(inst, buf);
>   
> -	return ret;
> +	return iris_destroy_internal_buffer(inst, buf);
>   }
>   
>   static int iris_hfi_gen2_handle_session_stop(struct iris_inst *inst,
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

