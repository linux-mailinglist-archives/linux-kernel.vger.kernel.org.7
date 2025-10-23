Return-Path: <linux-kernel+bounces-866528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7AC00054
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2311882E21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84A3054C3;
	Thu, 23 Oct 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRs4eHh4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84013043A9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209444; cv=none; b=kiQmIFa9iwtg4EGuJJtjUHzmoAQ338qdC4LPE0TKnqdeprQBwLEe7ncV5hTgddK+iCmy8To5YUQWRrobP6xE3BVeknR8LoscXPK1CKc9AzCZu4bHDwlK4OvJFUo/ZaKZoWc5u76HVFpvyAkOzpq1KXjY5ELBY2qBSx2CPwcB0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209444; c=relaxed/simple;
	bh=DcIZ+OIgf1s098RBDgUHrpmIMXeWvsYQYF0MMJfNfE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPxsgcw5NYaPchMRmD61Zf9rccIU+Nt2zDA4EHrpTN9SdQ5K74wAXz797V4uu4XeEkEXNhfkQnSURm6d1whM86QLToLng1sAkxaSnwR8nlYbDF9nhhmgBxG4eR9VXdPGrOcTRRrYEhRej0maulLTP/Y+d7ErWyDYX1hi0Da0ffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jRs4eHh4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6NGVA016465
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vy1YqsOZVuqc53Zk/keuj33ot9pS+RsiO564Vjjfgec=; b=jRs4eHh4WOkXyJqw
	qmZN1s69k86zmAMUY3rZoSqjdgkmVxsDef6Ht200VOszBkfBcy0fZaYEOAxaPU/w
	Slozyp4HwEqVPOQ+FQa0Ejfd1dIVPL8KHpciOBHQmv2RRF/NT1+NPJI55r2dVjfn
	OdDEFAnNLzlIlvNuWYSX6TFzQ8/7/EkGI83LvTwqgrQSrRHvxF20twMj6cY+w5mY
	pauTXXzEeHzqUydeCWnMx+R+2dCPjkm/DHIJQ9xNtLsk7HjaNqxrYmUL5w2bOCeB
	DxFw7BMzf17lkr0WBFk2TX1z9l9HcKLI4y+d2aZ1LtGsUObnQNjFQ3a2a34j9Ujx
	RPxqYg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsda8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:50:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e6e2c03so6316615ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209441; x=1761814241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy1YqsOZVuqc53Zk/keuj33ot9pS+RsiO564Vjjfgec=;
        b=KMpTOi6ZqiHUbkeQBkM9AeoSEQO1aAr39s6PM+esq8VsSCz+F208ZxC43RsWhL60KS
         WAf2tZ/BqzmnLTRp+mNHNJgEN8sRIgdkJ5hSo8BSRxIzxm9UlYm33jOGOaqzLTSHqWim
         RjnzMdmuEZsNerGfKnRRmCyTQN3q0DDD0xFECX8Qllno+O2q4ZnSbSDNwSn1b25B3tRD
         fMuttCbsOzmDFZcGdLapovOP9Wy1vO9gZBK7cy3bjWTBcWfAH+IfoH9m96ZiTyhwHar2
         1CkYac8gkLFIitGUtCYpx1ANXvQjv/pclwQEsaTU9bfdtLLU0Rd1Eb5BCS9jO6XH47BQ
         2dJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtnoRraDwf+gMPNWtlZ0Lv5ImGp+6TDSFZumIHUTFrNyqGr6n6iy5rUZAWkfGtSxS/2olfDNJn7FuSGy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fsmg8oJo6rUNtctsqJHu6G+zY9m/uFQKltA9FM1RfMDDczI8
	cEKHxuc+W1ojSFepz1imu4v4ZlDxIm/0dmKXDghpY3/hZ9nrn1End65lc5ZL2WbYVB00u3BprdO
	Aj+14msBVMdpWpY25PzqeGplMeC8MkE+QFbAUeA1SraLl0G6M4/tKuOJEUSmsWHcwBlY=
X-Gm-Gg: ASbGncvCi2+eknoeW0WgaFyo/Uxjb0T8O7/uHCgcLEQw9RBLScjkm7CpvuuzAY0+DHe
	tu0tLEwvFxKAFEo34AhgNe9X5IciwKBNqnjx9BY8zzqixE3JSFxcx8JrTsMlBP7kmw+VdQBn0XH
	YYmoWW0l2ZZlNu/uch0ZbOg7dZJx5zw/f8O+rpBUFs84saV5x1PmsR9PlL30Xa1kvL+bQ5PrRE7
	oDBXtvRrUI89GGS4hURAraLwtQx5Ybym+KsvL1XbyfjDhIW1kCIMbMQLP7zznqEOvVMSfJEfrkY
	f6YTAQotTcgE2kCgreQPam3BLT5ghyfWYSF5s27ZC+3KJT5gOiYJkFnjDzuUg+3cwy+gjtvogPU
	tmB/qZ/E1w4FLQJ6V+8EKPtJAccQHLMs=
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr274221905ad.9.1761209440902;
        Thu, 23 Oct 2025 01:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGidsCk6SAkbG2Drko6l/0sE1wrtY1HWZZpy5Z8oS/toxjjM0pNrE2O5NGTnLarM5LV8vXQPw==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr274221655ad.9.1761209440428;
        Thu, 23 Oct 2025 01:50:40 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f5de1sm16235145ad.87.2025.10.23.01.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:50:39 -0700 (PDT)
Message-ID: <8c75296f-2cd7-b0cb-f7ae-d433d2834bdd@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:20:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/6] media: iris: stop encoding PIPE value into fw_caps
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
 <20251019-iris-sc7280-v4-3-ee6dcee6e741@oss.qualcomm.com>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251019-iris-sc7280-v4-3-ee6dcee6e741@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX/P2ZiHc1q3ye
 PoGPXPyOzPF8X/KQtvX4EwVTXhJ2cXzt52dk6gFBnsS41UVDJIY+Rh0JGe9WahBZbL772xa7lra
 g12OKD2aEutzNcN2tT5WfuGnUTTsAG0o0OLH4dJY/yt5JlmCRplSX9WhCzQbwI3BSTQwc/N07Bs
 s7BCFXG9mi+aZwh1hTRtW9RsSl1rz3dcon8czbPOTgmjvb4NGZXpkihUyPappOA46LmaOM8fQYN
 AiyIqdMAxoBTY1lV+xOtJTe7zn6IKRQeXqG8lsI2RoJmMBVanxX55FpxBN+/wWOT2QG5XZ1JSvM
 b4kTWkM7Kr8tcrtJQamWISkNES4qN6xZMJvohxRMI/3UMR9wbNJ07JnUGVPCITQzQnwhgnU/M9i
 PNMFSnNhF1KoGlR5tykNinaEVSvQ5g==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f9ec61 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SvJZJoMY8oi3fNviAK8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tvyjgjWX4aY7DY2t5fUqHMLoMtL5rxQH
X-Proofpoint-ORIG-GUID: tvyjgjWX4aY7DY2t5fUqHMLoMtL5rxQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190



On 10/19/2025 1:26 PM, Dmitry Baryshkov wrote:
> The value of the PIPE property depends on the number of pipes available
> on the platform and is frequently the only difference between several
> fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> iris_platform_data rather than hardcoding the value into the fw_cap.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 16 +++++++++++++---
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  3 +--
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h |  3 +--
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  |  3 +--
>  4 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce..c0b3a09ad3e3dfb0a47e3603a8089cf61390fda8 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -313,13 +313,23 @@ void iris_session_init_caps(struct iris_core *core)
>  			continue;
>  
>  		core->inst_fw_caps_dec[cap_id].cap_id = caps[i].cap_id;
> -		core->inst_fw_caps_dec[cap_id].min = caps[i].min;
> -		core->inst_fw_caps_dec[cap_id].max = caps[i].max;
>  		core->inst_fw_caps_dec[cap_id].step_or_mask = caps[i].step_or_mask;
> -		core->inst_fw_caps_dec[cap_id].value = caps[i].value;
>  		core->inst_fw_caps_dec[cap_id].flags = caps[i].flags;
>  		core->inst_fw_caps_dec[cap_id].hfi_id = caps[i].hfi_id;
>  		core->inst_fw_caps_dec[cap_id].set = caps[i].set;
> +
> +		if (cap_id == PIPE) {
> +			core->inst_fw_caps_dec[cap_id].value =
> +				core->iris_platform_data->num_vpp_pipe;
> +			core->inst_fw_caps_dec[cap_id].min =
> +				core->iris_platform_data->num_vpp_pipe;
> +			core->inst_fw_caps_dec[cap_id].max =
> +				core->iris_platform_data->num_vpp_pipe;
> +		} else {
> +			core->inst_fw_caps_dec[cap_id].min = caps[i].min;
> +			core->inst_fw_caps_dec[cap_id].max = caps[i].max;
> +			core->inst_fw_caps_dec[cap_id].value = caps[i].value;
> +		}
>  	}
>  
>  	caps = core->iris_platform_data->inst_fw_caps_enc;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index b444e816355624bca8248cce9da7adcd7caf6c5b..03ce5c259c8491ae6882128795d18569baea6241 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -161,9 +161,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>  	{
>  		.cap_id = PIPE,
>  		.min = PIPE_1,

Do we still need min here?

Thanks,
Dikshita
> -		.max = PIPE_4,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_4,
>  		.hfi_id = HFI_PROP_PIPE,
>  		.set = iris_set_pipe,
>  	},
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> index 87517361a1cf4b6fe53b8a1483188670df52c7e7..310c48958018ae724d01c87e7977096cd86e1bfd 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> @@ -147,9 +147,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>  	{
>  		.cap_id = PIPE,
>  		.min = PIPE_1,
> -		.max = PIPE_2,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_2,
>  		.hfi_id = HFI_PROP_PIPE,
>  		.set = iris_set_pipe,
>  	},
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 66a5bdd24d8a0e98b0554a019438bf4caa1dc43c..9cb9ddc86ad73daf75383b3253e851394235093d 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -21,9 +21,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>  	{
>  		.cap_id = PIPE,
>  		.min = PIPE_1,
> -		.max = PIPE_4,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_4,
>  		.hfi_id = HFI_PROPERTY_PARAM_WORK_ROUTE,
>  		.set = iris_set_pipe,
>  	},
> 

