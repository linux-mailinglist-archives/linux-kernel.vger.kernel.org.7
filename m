Return-Path: <linux-kernel+bounces-845200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5CBC3D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99135188697E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D842EBDF0;
	Wed,  8 Oct 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mW93nNJx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FA2E22B4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912368; cv=none; b=bzHWR9Za9oYTyQeIpKmUbPfbYnSMg8QHOh91bM3PU2K7ElDJsGYMi+X+gdDGtV2saPdEDt1RfjhVKckcieWfl5TJPJTDbH8lIs3i5O+B70/e2itmfxC+Hb6QfjyB07KCvYG1j3B/9rFG/ptZPt9yrZFkbeuhi4OEJeSKTcrPyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912368; c=relaxed/simple;
	bh=8OfX1olNym2yuDElCFo+y+N8czgO6/khDBIoAQrlzsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyVx9aH38eICBL461HA0LrwLxyqDXQLtn1WuR6g1vx57XNBNDSM7ge+Y7QdpwqgCCWUQLulIJkFtiIzGzsy193+IjgAbd9efhmvLgGJgcpnfVQrwTLkIn9lbMhpIj73Bwjq2iuNV0PTuasQhWDF4SVgOHJFzEhFRWYLrHLMHiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mW93nNJx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so70969495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759912364; x=1760517164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s4t9BjYm06noPeILdvIoWKkJuRRVPbdNb9iIdV8a8A=;
        b=mW93nNJxrUT6YqyqJPnaI9Wd9sbiKCZO8dMJlaiQOAjLZAt7D1QjbL7koKXw0ZjFTc
         ylyTKUc+XtbrFFR0HdDif6CFcKUnyjOgn/bZ+uhTsuZ7IjYUshBuMWz9y7SDw3gKE/me
         l3FgQgW3VZLqXH1WIWEU88upjMm75tZfjgrg7b/8T8NonWEk8VUKf3r6LrlL0TH0wGfZ
         /5VRXU9sVA5aQHmUa5+4HVkepdKJEcCkwP7BYhsHPS94JSHUSA8ZSFQVa93gLJWH4auE
         VyZkYsbN+OzEATamh9wvlyyduic3N37hwSEKQet/qxCS8D0xIxEpjHGxyY/Ls954dq0S
         053A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912364; x=1760517164;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s4t9BjYm06noPeILdvIoWKkJuRRVPbdNb9iIdV8a8A=;
        b=rygeQsbLId4Uls02m3AEG8kdOFMbV0mCeSpz5TOxV8XWXMq4EeP1auZoMVMnDafBiA
         HYOel9xi38O5CIiaq1X9/bRFA31y/3XRJvRiETRPIyI/OG0El3PGody2bQ/fheq+Strj
         JXnTUBMYNkCiSs15HZdqV8BBG9pdPnJn9oBwexMSHbkzIZtA2OYQKRQLePZklnNn18Qd
         82k5VH/moLd0ziO9U9ofMKD9Eoe7Ph85UFq3qqc754NYKlfDW+oLMbviYgJ7oHf89PFO
         viKtZkAhmXM36VrH1otXZaluDPZK5kpBFpU26BekT2qS5nZwhNrnKbMMX6vJX2uloZW4
         AUIw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFI0WygJ/oOJglhY5qwqggIFITHyajVi1IahMOxvZHSe2XbtC6kc3MdD6bZ70qLsl9xQgXAW8k+Ijsc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0JZwWmzK73svRSuWTRGdltLAeq84gs+mPm8VLwFiRH4dlHpy
	KGqDwQIjp7GVjui1IgEkcBzkp+4eXWE1TWQkxm39aqZqp8QeXW558JllhR4vFBXsGtg=
X-Gm-Gg: ASbGncvksP72GZcqdAKWHTj+VO+BxqhlWT2BEwhB2BkDjBdJW7iw88BwrKCoAZg6V8O
	C5mK2KRUWOKRwQQb1BUWLnWQKxuK/FJnjNG0V/4LoMXBqqx5e/2ggVzGkIuQxMWQqYOZvapvhS+
	13nAIfMtzs8mbRIZigdI44gexMc7QsXo6WrcSrjoUdxj9BH7/SZKbHfck0amOAAJofJeGRVKkpl
	63gXQEktxwsBBBdJClEJBXKZC2CE1uAnGk+5uBQqxVrcmPo5EgHPpmFjVJYPlmjmxIrsyOb5E+w
	NpQgvZBgvyXxuv8SyJGhStvyfbbhhipRsyjCLcGJ6CvhuQAIAVOM4ZdR5k4ZS8XY0pd3clHdg9o
	n1t9NntV1EP2W/WBdFFlPBX4QNRpryDQBFV2qjUUwqdEk47JDYLPp9hgou/yIEgMzIy+TJ/U/1s
	9QoPOkK40YFMqn5gNw
X-Google-Smtp-Source: AGHT+IFEhXVT1pfSNTwPur3KNe2uf9XZsC40/sb4jcVizQ0HFclkkqo2tT3ku67t+UACu1zLc9b1yA==
X-Received: by 2002:a05:600c:3b2a:b0:461:8bdb:e8 with SMTP id 5b1f17b1804b1-46fa9b06c50mr19760695e9.30.1759912364417;
        Wed, 08 Oct 2025 01:32:44 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm28037695e9.2.2025.10.08.01.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:32:43 -0700 (PDT)
Message-ID: <a0bf546d-e91a-49f9-a06c-8ef1186a9eae@linaro.org>
Date: Wed, 8 Oct 2025 09:32:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] media: iris: turn platform caps into constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <FhzvOpI3xnjmzE7G_aLgkpk24bRAD2ad_O2BvQLHWV6C-W2WK5EpE1CDMS_yp87JZwsfuMf0f9egHDu8bOp3Tg==@protonmail.internalid>
 <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2025 05:32, Dmitry Baryshkov wrote:
> Make all struct platform_inst_fw_cap instances constant, they are not
> modified at runtime.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
>   drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
>   drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
>   drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
>   drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 754a5ad718bc37630bb861012301df7a2e7342a1..9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -301,7 +301,7 @@ int iris_ctrls_init(struct iris_inst *inst)
> 
>   void iris_session_init_caps(struct iris_core *core)
>   {
> -	struct platform_inst_fw_cap *caps;
> +	const struct platform_inst_fw_cap *caps;
>   	u32 i, num_cap, cap_id;
> 
>   	caps = core->iris_platform_data->inst_fw_caps_dec;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 58d05e0a112eed25faea027a34c719c89d6c3897..17ed86bf78bb3b0bc3f0862253fba6505ac3d164 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -215,9 +215,9 @@ struct iris_platform_data {
>   	const char *fwname;
>   	u32 pas_id;
>   	struct platform_inst_caps *inst_caps;
> -	struct platform_inst_fw_cap *inst_fw_caps_dec;
> +	const struct platform_inst_fw_cap *inst_fw_caps_dec;
>   	u32 inst_fw_caps_dec_size;
> -	struct platform_inst_fw_cap *inst_fw_caps_enc;
> +	const struct platform_inst_fw_cap *inst_fw_caps_enc;
>   	u32 inst_fw_caps_enc_size;
>   	struct tz_cp_config *tz_cp_config_data;
>   	u32 core_arch;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index 36d69cc73986b74534a2912524c8553970fd862e..cbf38e13f89e5c4c46e759fbb86777854d751552 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -19,7 +19,7 @@
>   #define VIDEO_ARCH_LX 1
>   #define BITRATE_MAX				245000000
> 
> -static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>   	{
>   		.cap_id = PROFILE_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> @@ -203,7 +203,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>   	},
>   };
> 
> -static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
>   	{
>   		.cap_id = PROFILE_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> index 35ea0efade73caa687d300779c5b1dc3b17a0128..87517361a1cf4b6fe53b8a1483188670df52c7e7 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> @@ -5,7 +5,7 @@
> 
>   #define BITRATE_MAX				245000000
> 
> -static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>   	{
>   		.cap_id = PROFILE_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> @@ -189,7 +189,7 @@ static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>   	},
>   };
> 
> -static struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
>   	{
>   		.cap_id = PROFILE_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 16486284f8acccf6a95a27f6003e885226e28f4d..e29cba993fde922b579eb7e5a59ae34bb46f9f0f 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -17,7 +17,7 @@
>   #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
>   #define BITRATE_STEP		100
> 
> -static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>   	{
>   		.cap_id = PIPE,
>   		.min = PIPE_1,
> @@ -38,7 +38,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>   	},
>   };
> 
> -static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
>   	{
>   		.cap_id = STAGE,
>   		.min = STAGE_1,
> 
> --
> 2.47.3
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

