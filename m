Return-Path: <linux-kernel+bounces-846298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BBBC77E4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC41890F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4582989B0;
	Thu,  9 Oct 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aN7JfwTw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB772291C3F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990159; cv=none; b=s42HH3eXS2dAwHssmmcwAe8vRYIGfSMweSFKzoAhiOiorF51E5sr/CS8WhuJaOsIf2iuv0lBe2vW1IrphMnLVgr2mOKfydzt9GWkPY86/UJaYaNSXlIfbwYyBjMMaYefpnD63qZRqrjHHSeCsCqYvFo3KkkeaGH8RexR5CCEb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990159; c=relaxed/simple;
	bh=GOjgXUiOC9EalwRg32Htt3OW+Yig5C3e9pGvlU4vMbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHf2AcOiLQWDBxSuJQjp3sj1FLjxxCxL2jjlX4cKOJA9ag9l85DOj97BIRo/fe921WcriBbvQpFVChHINuYvWpZXpdHYKMBsztzYPpQDc24CPq7kp08f/pJT2V2cLnbBYfz0kklyGkRF0aZRu0L5SIQDTdCUtGe//bS+cSXkGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aN7JfwTw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Nw3029309
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8IvL17W/Id1+6m6ZexrF987wVVzaR9/r+cvN2NSP1Og=; b=aN7JfwTwQOlSeOlA
	2qe5sgBzSLAaRM4vgoBRkE+wVc6un083lwOqaStMo+3NPj9nTWZ//HinLDzwZ0yZ
	jez7SzkRg99f5KrMDE0iCqq+d2oNGtbBTntLba0W5oqppeaTA0djWw6ogNPqFnwC
	IwGz1mssz/qyPz2EgayNDqujUW/6pHia2EVgtawVLy0c+hpN9lC1zz2ZlwlrLZlF
	UFH8fcwJTQSSsHc7koqyjigh+S1nujg1OZ94y0ZfMzmFUZd5BZc8Lv0gNCBACk04
	ghgQlW51x0Isv+9xV8Z73r39PYvH4v+59wjvbyCvOS2I25YN2PQWNVOspJyiz2xR
	Gh2oug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4shn8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:09:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso12491965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990155; x=1760594955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IvL17W/Id1+6m6ZexrF987wVVzaR9/r+cvN2NSP1Og=;
        b=EMy/HUHwsQvOLrpuVYyPmwyK24hSsH9520KTzjaQLk+TOwWc1hoNihgOQeVlFK0O0j
         USXhy+QtAuXaeGvoEb9SVkwpw2HbZcMUs3szTfYAMSbmaTovRup/40yTR5qV1xL+cmi/
         2qgN396o/QogaADVDof0Zw+A1asrmXIah8o44lX+N6tUVWJEqqdGGXjr4t02Oo5erbuP
         78/EMFHN55ZK1gm8hLSoF4M31nkRKi+4i2El/Dc3LWruW2LE54oYa7hEh5SCopH72yaM
         II1HsuIDLPwyxWp6YAprECkzUKwNrnPEzWqtrdpQwNmmv/tbC5fgnFrqzpg5uv19AJ1u
         Ah5A==
X-Forwarded-Encrypted: i=1; AJvYcCWCKbzWgIMTj2SxRQaEI/PzsmTkwbaKrH4c/v02xHFPP5v2asMdt6hvRVWSMWMh6RnMSlBEMLBDc1gkfFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwnzLsVT9GbQ3xdRf7jDcGIXB/8GT3A8n7YPecJfYPE9pnFGF
	fTVrt4zXMrwl98JqiIR0u3qPE3ZsCIKF0ft9XeQEfcU5g8/LCesoC7UECWIvFB/zBRNMgaz4anW
	bZr0p1XrfxyemN3QcQTWTuyZQRD5Xb5eJlcNttl9rKGKRJTMLUOXQkUj+tJFmfvP5MS0=
X-Gm-Gg: ASbGncvBL3VOtyhWBTJnVVRzYRDSDkifhNuJKmSqcH+/gPWYZc6pIA6Fn/N7IkaVBto
	S2PFJj1rcbzH8mYFeu7X/G/WoBhqv3c+HB/X2mg14Qwe9MJIIZ11RicigD65X8u7954bZSeuDBg
	ejHkRy4eW8Kr0QjznNXm8SjwFOg08PHko8LeAFDBS5U6UXOgiVb5Mn46oMHo8vBbosJxmkeSAtl
	FmR3M+8nfByQWvgnLx6ze7N7cOaf+as7AsURE35YyqrFJZ096Oss77Ywap4im4WQH/CHav6PuE2
	TuFPznwXThM84ydV4yqcSOLcxcArOAqnqzkibvicqXdKb32aPxpfyDz9PLi+8x23bqie+UIJiQL
	XVQ==
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id d9443c01a7336-290272b54b6mr71066245ad.29.1759990154989;
        Wed, 08 Oct 2025 23:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH4qaK8++GdSK4a9nJINH772gWn0nUmeHNyLqRwvjmnbfqBBysBHMmIHywGEilc0MnfbnNrQ==
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id d9443c01a7336-290272b54b6mr71066025ad.29.1759990154515;
        Wed, 08 Oct 2025 23:09:14 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08ddasm16250015ad.65.2025.10.08.23.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 23:09:13 -0700 (PDT)
Message-ID: <fac9eae2-3ae0-9638-8767-ef4a26718c00@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:39:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] media: iris: turn platform data into constants
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-2-def050ba5e1f@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-2-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tTHQS2ca0Opl4TBg0LyBWhODbLxlZ88t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9Q5joJvbSbge
 tBH3WoWL+ut+6xHntYOUnPvL2crrBhj1KguqoT6/9dV300q4NZPqTF/sU2giC5jQnEMJMmRScQF
 OHRAAI+TRHMqaBMV1G8Kcjfl5fVWjAcK7J1i2jaRMvwY25yI1pudpCCmJSMukDVnU+SyPVHAOfp
 hS7LH7kLd8bXLhassGIZ/Ss1ihgi1j53VSQ4EjlMqcAHv/CgQsDrSYS7aZr7kjhVrpg/+N5sDjd
 O0ujsGZT8ucOB8GACZp9VtQZFPGF7QV6myS9PRxHC3bD+lCt6R0naxrVhY8kJeNUUNxZGMZJrqe
 7BVJ364g9int1jzu93Ybji0lwYW+VioMWTuVsFhnU7eD+tR3NjoGGfO9Fhv16L+O7dFP05TPhbd
 SQT2VgSY6KWTA1As0kpRGf1xEm+Zzw==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7518c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=L4P4cphVmhIBbhJv2lsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: tTHQS2ca0Opl4TBg0LyBWhODbLxlZ88t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
> Make all struct iris_platform_data instances constant, they are not
> modified at runtime.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_platform_common.h | 10 +++++-----
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c   |  8 ++++----
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 17ed86bf78bb3b0bc3f0862253fba6505ac3d164..5ffc1874e8c6362b1c650e912c230e9c4e3bd160 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -41,11 +41,11 @@ enum pipe_type {
>  	PIPE_4 = 4,
>  };
>  
> -extern struct iris_platform_data qcs8300_data;
> -extern struct iris_platform_data sm8250_data;
> -extern struct iris_platform_data sm8550_data;
> -extern struct iris_platform_data sm8650_data;
> -extern struct iris_platform_data sm8750_data;
> +extern const struct iris_platform_data qcs8300_data;
> +extern const struct iris_platform_data sm8250_data;
> +extern const struct iris_platform_data sm8550_data;
> +extern const struct iris_platform_data sm8650_data;
> +extern const struct iris_platform_data sm8750_data;
>  
>  enum platform_clk_type {
>  	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index cbf38e13f89e5c4c46e759fbb86777854d751552..b444e816355624bca8248cce9da7adcd7caf6c5b 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -737,7 +737,7 @@ static const u32 sm8550_enc_op_int_buf_tbl[] = {
>  	BUF_SCRATCH_2,
>  };
>  
> -struct iris_platform_data sm8550_data = {
> +const struct iris_platform_data sm8550_data = {
>  	.get_instance = iris_hfi_gen2_get_instance,
>  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
>  	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
> @@ -827,7 +827,7 @@ struct iris_platform_data sm8550_data = {
>   * - controller_rst_tbl to sm8650_controller_reset_table
>   * - fwname to "qcom/vpu/vpu33_p4.mbn"
>   */
> -struct iris_platform_data sm8650_data = {
> +const struct iris_platform_data sm8650_data = {
>  	.get_instance = iris_hfi_gen2_get_instance,
>  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
>  	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
> @@ -912,7 +912,7 @@ struct iris_platform_data sm8650_data = {
>  	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
>  };
>  
> -struct iris_platform_data sm8750_data = {
> +const struct iris_platform_data sm8750_data = {
>  	.get_instance = iris_hfi_gen2_get_instance,
>  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
>  	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
> @@ -998,7 +998,7 @@ struct iris_platform_data sm8750_data = {
>   * - inst_caps to platform_inst_cap_qcs8300
>   * - inst_fw_caps to inst_fw_cap_qcs8300
>   */
> -struct iris_platform_data qcs8300_data = {
> +const struct iris_platform_data qcs8300_data = {
>  	.get_instance = iris_hfi_gen2_get_instance,
>  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
>  	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index e29cba993fde922b579eb7e5a59ae34bb46f9f0f..66a5bdd24d8a0e98b0554a019438bf4caa1dc43c 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -314,7 +314,7 @@ static const u32 sm8250_enc_ip_int_buf_tbl[] = {
>  	BUF_SCRATCH_2,
>  };
>  
> -struct iris_platform_data sm8250_data = {
> +const struct iris_platform_data sm8250_data = {
>  	.get_instance = iris_hfi_gen1_get_instance,
>  	.init_hfi_command_ops = &iris_hfi_gen1_command_ops_init,
>  	.init_hfi_response_ops = iris_hfi_gen1_response_ops_init,
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

