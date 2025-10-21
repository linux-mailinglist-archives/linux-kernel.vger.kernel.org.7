Return-Path: <linux-kernel+bounces-863844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E59BF940F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CD544ECEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770522C21E6;
	Tue, 21 Oct 2025 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhFgDvNn"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9729A309
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089732; cv=none; b=HZAAGjVs9rvYiU3GodtJo68G7PNSmZXQ28VZmbAokCZNMBzGG+Rkr0CkI+ObqBJAncyvgrUKwpMqh34XfXl3l1LA5YsepSOzKvw9RAuUxMEDB/CZpYrLwFOlk5ejJ8+NDv0oCEpVT3QSewdwvh/2G8cZ+KHR1lgpAEa1jBofCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089732; c=relaxed/simple;
	bh=d0rri72HUDD7sLN8He2gM8MVhsCdzHnM4aRPUZ7Wp4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddvqIgfw0QSdHoN0BJK6ni3bTGdDj9v90RDOeuSLyg8V3e3m1m6IwklrowrKrLLAQTbXzSAPv7Bh7op27AD0tMMf2x3AGt6aFzgBNjjmYntJfO9/+TQ2NdReZkPfDN2jJ99xUQ7d/+df0HrH2EFFPBHFGrl3nwlx9jZnEVaKX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhFgDvNn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426edfffc66so273746f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761089729; x=1761694529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCXGcVVHwvNBqgCg7ypa7rVa+Pb3fcXZRoAO3UaaUjc=;
        b=zhFgDvNn+hyp9BQmFTgF5mrlXX36gbkNbP62cIhSVknHLzU6XPGCnuZxg+F8AFEn9p
         8cq3DvJ7EfbI8r+avwJeZ3TVE2W5CvwbExFKgOTDNnQYAg6k9gAGmuYN1N0qQM8+KpTL
         RuyDF8Y64WnUUJOmw0xvu+iQuKxhRJTrMLDm1ZnSOYDNKBQIytP6rrybVlQQ5e4TtOU+
         L0TOWuHdtT5TKMLc46nUKA0cieoJdgmZ7NTzEDQV01l8yVb1f/Vz7FjIBR8qTW/mXUEy
         gnpYEEgxJgXUH6EAto6XyfHevUO/YjfuHCtTrK+vaTXjwMLFn/7qqvDmuXWI6gBz8CUE
         +XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089729; x=1761694529;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCXGcVVHwvNBqgCg7ypa7rVa+Pb3fcXZRoAO3UaaUjc=;
        b=ncTqw+hFpUZAf2V/CS0OSiHiBOxPkWzkOKgVDs+oa0HBQq9H4b88jRnZcpvBOeEboR
         Swc4wGLqTty+D1AdFT417NjaJkj2UXwIFGms7qd6ZnrDM0fMHcQHWZOcYw4P1sboV4DM
         oZWLsgzLDSAJQSZfr67FGWtE1Fh78aUBgJ1IFZshaJ0Us9+EzI36FHIeMRKcyQJzinDE
         wT7c4XR18mk5P9Uj8p/Gg+MzK/0WQz56Msa5uObBcgZU8EBtI1PvZgz1Ax1h417QIcsL
         GxW9c5fO40bQI4YGUwMwvqpdHEuHdKpHXi1m7mkMOGU8G6RCmuUnncs9IiWXfFqd6LUB
         lsuw==
X-Forwarded-Encrypted: i=1; AJvYcCV6kTzOjBzq4EOjfgrvGWGpFUrM9UjV5SJqUdURxBWDaGDJC2G0yY6Pg5beD5gk7jZM/MTrLs+Xq3AKh0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WKF0LWMBOxIsWIaZM4nSQVRu3Gb4ipbvgaQuwkHNXiP8/O9M
	9wQSxbu7IIq7mYhYf73k79UrnIkmVhbxeLGAxMjek+1vqMmpTYMzJERiinZu8423x0s=
X-Gm-Gg: ASbGncsm9un/IjP/r1rzEejGWMLETYjNAqsSiixyL3oe4GhnVfK+ra/HQPwQQOWfuFZ
	KB8o1Tb1VGFLobGwQ4SeP1EO/FJGPBCgUASQcf/0dVWZ1KNaaOZ/TtTefQeVLePmazJv7sawfqQ
	E2z3Jd+tmYxGuioDaFCRUgMpmhFFQ4JtBthYOXkbLkoU0GzfqzyB0pTe0hyDQ0H6Xrnjm+PEM4j
	PW23NSGvlVTRRwrok7AzWQznwij+/6aQcQD5XJhS3Vs0mAtJ8xGdD20cacjCGuNAIpmXO04CEma
	5/w07/40HY2vPnIIKnYpBgcEKZ+knWElGNr/t02Vy/37QfBLXEkzjsu8Wpe2pULdh3QjH9NmEZ4
	lgy+cLeki4bYmHCQY0C6At86V8a38dOYqFho2lj8vCsvCezSBsF7gFq16gngoQekwj1rzS0bumq
	Pd5CRetiNmajQtcetKWVCzrstrEHY6bZh8IFfS0BKi2mHlCDwNmPpi7w==
X-Google-Smtp-Source: AGHT+IGAFLCl48Lc20o0k175qMA8ECYoPcsbHgJr1TYSq+qDL1SyBGQ/3qEO66SBlR5lpciSN2paDA==
X-Received: by 2002:a05:6000:4012:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-4285326765cmr879407f8f.18.1761089728509;
        Tue, 21 Oct 2025 16:35:28 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm22616463f8f.18.2025.10.21.16.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 16:35:27 -0700 (PDT)
Message-ID: <9e71bd5c-e4d9-4b2b-bec9-95b101bdd91c@linaro.org>
Date: Wed, 22 Oct 2025 00:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] media: iris: Add support for multiple TZ content
 protection(CP) configs
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vishnu Reddy <quic_bvisredd@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <vWebMQzqRdPJMtF45GS9wvdpHGc4w0O4Ft0KSmDAC54LhULoJZ_uNAW8KkJ8tbK4WKwvUVdeYtDuyZCH3Z_BBA==@protonmail.internalid>
 <20251017-knp_video-v2-3-f568ce1a4be3@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017-knp_video-v2-3-f568ce1a4be3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 15:16, Vikash Garodia wrote:
> vpu4 needs an additional configuration with respect to CP regions. Make
> the CP configuration as array such that the multiple configuration can be
> managed per platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_firmware.c   | 23 ++++++++++++---------
>   .../platform/qcom/iris/iris_platform_common.h      |  3 ++-
>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 24 ++++++++++++++--------
>   .../platform/qcom/iris/iris_platform_sm8250.c      | 15 ++++++++------
>   4 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 9ab499fad946446a87036720f49c9c8d311f3060..9186e0144dc0df4045c9995adc5fc93993cc3fba 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -70,9 +70,9 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
> 
>   int iris_fw_load(struct iris_core *core)
>   {
> -	struct tz_cp_config *cp_config = core->iris_platform_data->tz_cp_config_data;
> +	const struct tz_cp_config *cp_config;
>   	const char *fwpath = NULL;
> -	int ret;
> +	int i, ret;
> 
>   	ret = of_property_read_string_index(core->dev->of_node, "firmware-name", 0,
>   					    &fwpath);
> @@ -91,14 +91,17 @@ int iris_fw_load(struct iris_core *core)
>   		return ret;
>   	}
> 
> -	ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
> -					     cp_config->cp_size,
> -					     cp_config->cp_nonpixel_start,
> -					     cp_config->cp_nonpixel_size);
> -	if (ret) {
> -		dev_err(core->dev, "protect memory failed\n");
> -		qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> -		return ret;
> +	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
> +		cp_config = &core->iris_platform_data->tz_cp_config_data[i];
> +		ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
> +						     cp_config->cp_size,
> +						     cp_config->cp_nonpixel_start,
> +						     cp_config->cp_nonpixel_size);
> +		if (ret) {
> +			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> +			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			return ret;
> +		}
>   	}
> 
>   	return ret;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index df03de08c44839c1b6c137874eb7273c638d5f2c..ae49e95ba2252fc1442f7c81d8010dbfd86da0da 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -220,7 +220,8 @@ struct iris_platform_data {
>   	u32 inst_fw_caps_dec_size;
>   	struct platform_inst_fw_cap *inst_fw_caps_enc;
>   	u32 inst_fw_caps_enc_size;
> -	struct tz_cp_config *tz_cp_config_data;
> +	const struct tz_cp_config *tz_cp_config_data;
> +	u32 tz_cp_config_data_size;
>   	u32 core_arch;
>   	u32 hw_response_timeout;
>   	struct ubwc_config_data *ubwc_config;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index fea800811a389a58388175c733ad31c4d9c636b0..00c6b9021b98aac80612b1bb9734c8dac8146bd9 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -648,11 +648,13 @@ static struct ubwc_config_data ubwc_config_sm8550 = {
>   	.bank_spreading = 1,
>   };
> 
> -static struct tz_cp_config tz_cp_config_sm8550 = {
> -	.cp_start = 0,
> -	.cp_size = 0x25800000,
> -	.cp_nonpixel_start = 0x01000000,
> -	.cp_nonpixel_size = 0x24800000,
> +static const struct tz_cp_config tz_cp_config_sm8550[] = {
> +	{
> +		.cp_start = 0,
> +		.cp_size = 0x25800000,
> +		.cp_nonpixel_start = 0x01000000,
> +		.cp_nonpixel_size = 0x24800000,
> +	},
>   };
> 
>   static const u32 sm8550_vdec_input_config_params_default[] = {
> @@ -771,7 +773,8 @@ struct iris_platform_data sm8550_data = {
>   	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
>   	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
>   	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
> -	.tz_cp_config_data = &tz_cp_config_sm8550,
> +	.tz_cp_config_data = tz_cp_config_sm8550,
> +	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
>   	.core_arch = VIDEO_ARCH_LX,
>   	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
>   	.ubwc_config = &ubwc_config_sm8550,
> @@ -864,7 +867,8 @@ struct iris_platform_data sm8650_data = {
>   	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
>   	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
>   	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
> -	.tz_cp_config_data = &tz_cp_config_sm8550,
> +	.tz_cp_config_data = tz_cp_config_sm8550,
> +	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
>   	.core_arch = VIDEO_ARCH_LX,
>   	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
>   	.ubwc_config = &ubwc_config_sm8550,
> @@ -947,7 +951,8 @@ struct iris_platform_data sm8750_data = {
>   	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
>   	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
>   	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
> -	.tz_cp_config_data = &tz_cp_config_sm8550,
> +	.tz_cp_config_data = tz_cp_config_sm8550,
> +	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
>   	.core_arch = VIDEO_ARCH_LX,
>   	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
>   	.ubwc_config = &ubwc_config_sm8550,
> @@ -1035,7 +1040,8 @@ struct iris_platform_data qcs8300_data = {
>   	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_qcs8300_dec),
>   	.inst_fw_caps_enc = inst_fw_cap_qcs8300_enc,
>   	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_qcs8300_enc),
> -	.tz_cp_config_data = &tz_cp_config_sm8550,
> +	.tz_cp_config_data = tz_cp_config_sm8550,
> +	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
>   	.core_arch = VIDEO_ARCH_LX,
>   	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
>   	.ubwc_config = &ubwc_config_sm8550,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 1b1b6aa751106ee0b0bc71bb0df2e78340190e66..8927c3ff59dab59c7d2cbcd92550f9ee3a2b5c1e 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -278,11 +278,13 @@ static const char * const sm8250_opp_clk_table[] = {
>   	NULL,
>   };
> 
> -static struct tz_cp_config tz_cp_config_sm8250 = {
> -	.cp_start = 0,
> -	.cp_size = 0x25800000,
> -	.cp_nonpixel_start = 0x01000000,
> -	.cp_nonpixel_size = 0x24800000,
> +static const struct tz_cp_config tz_cp_config_sm8250[] = {
> +	{
> +		.cp_start = 0,
> +		.cp_size = 0x25800000,
> +		.cp_nonpixel_start = 0x01000000,
> +		.cp_nonpixel_size = 0x24800000,
> +	},
>   };
> 
>   static const u32 sm8250_vdec_input_config_param_default[] = {
> @@ -348,7 +350,8 @@ struct iris_platform_data sm8250_data = {
>   	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8250_dec),
>   	.inst_fw_caps_enc = inst_fw_cap_sm8250_enc,
>   	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8250_enc),
> -	.tz_cp_config_data = &tz_cp_config_sm8250,
> +	.tz_cp_config_data = tz_cp_config_sm8250,
> +	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8250),
>   	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
>   	.num_vpp_pipe = 4,
>   	.max_session_count = 16,
> 
> --
> 2.34.1
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

