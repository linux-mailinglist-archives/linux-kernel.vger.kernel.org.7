Return-Path: <linux-kernel+bounces-875284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0AEC18987
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F866351E44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C930DD00;
	Wed, 29 Oct 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKIEO51U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kZArwAC8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5130C348
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721937; cv=none; b=FpHzxmuxYp2mO63sX23Wu8LOmU2NDrpbayq8ihGF6pjZsQIiW4UIDPbZYtEbqeV4hDzrvFYJ89A+s278LgaB4jHkDsS4S0JfxupnqiziB0vNao1/iIgQTRBIVtmmJ+eOOETr4IEPzVH6wrwObdyFWJIlBz4TVj7/aCusrzvcb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721937; c=relaxed/simple;
	bh=rwDdWmG6X90uRcqoXDRG+H+UNTWRXJ8T/OsBaM+E4jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GihvT77FyV9K4PZNW9t5itzkFwcWR9riom8tYcxQvIJjDa6Pt+R1qZ4J22saGyiHsSu6K9eORn3KGPPk+JHa12eFquTcE4HixEEen07FdYzeUuhzYIMTLDXuGwiqg+3/s9Kpzm9/RPJHXVPr/zpLKwWLaALxPeheAO7yZyMVNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKIEO51U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZArwAC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uoeY3757460
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4el9iPVgZB2aGFoUjGQilQhpdmAQpRU2juC/C9AUGPw=; b=MKIEO51UEyRA9iGf
	cW8gpeO7h24x5PIcc2L3L/6tla/mSjIhXQOCk3PKnVGUU5qh7//vmPpUenseY7ki
	ieWV9q8ZMrqN2S20cK7Tu0zrotxpM4HWJsgm5j8ykF+VxRNRjNKEqF+Soai0EcWG
	RlRF7CnPOY7noOjFSaxcPlmwHggXx2Q2ajgHzpI9eaDQYkDro6NsSEkYDyqQs4hF
	/2X+T4Xmsz4Ut022+tHC1vd26RWxgev9o6Pw3HT6TXxdgJ0KFx+M1fqk2K1dtciu
	r8yXu3XdiGHKjLGBstijXARv+2TDlaDPyUON22IaFsDhW/R+PerKI68nydfX74UQ
	WkpwLA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y1j9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:12:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2924b3b9d47so61663945ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761721934; x=1762326734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4el9iPVgZB2aGFoUjGQilQhpdmAQpRU2juC/C9AUGPw=;
        b=kZArwAC8gPyrkhZA9L1onmXKiRS4ZiPUgFvVz/XBxrLMuKg7W/reBvduDZGKawGZnf
         St1RHIvfr18eF0j8Kky7FAe5kU6cL8LeVDlzXWqLd1nxc1L0zXk8mdXo09M5Oi3J4+ki
         KPHgOriwGeI/6TadbtGtBxz4l7By6gDAKUr3T3jIjDn/6gX7Onl3XI+U9v6kZLzgmQq+
         qJKaJmLcGtBFGHxkwfOt/AANaoi6QSdbg+382u1LNLyh6aeahEj2YVi8whLX/7RmZB66
         3+YTcy/N5sBJ0cOA4onLntwcwPHt7q9XoHOrblOYRrtK5EpWslxUgDvC8wnz2iAAoEEO
         /rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721934; x=1762326734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4el9iPVgZB2aGFoUjGQilQhpdmAQpRU2juC/C9AUGPw=;
        b=EZglYJZZvZNrIqoch27XJ8PhAwLGcZbO5+b4j8lMOddmbjdUzvMgfRF7M6cpB0QLbf
         2M27pGjRjytgvczKZkt9qGckq9uf9LSgs8F0+SNJoyRD/3wDf06MtHdT5dsPRDMvSL6Z
         BSEwLvjrRUR6oomnoxLvRToDzHqacheCWsGgOB+uwW4mYyKqiyPT4DPPxN0zZD+2eG22
         f9SdgDJ/+8YcY2F9l0Mumw/7fDKcuu1R1eBAx/1iIB5joKVMC1xiwoIaiYQE0E9TixhN
         K++fPWwgzvkp4FnK4oKCg2Xma7yN4GD2fYvuQz5+ddCWa17LQ3+c707p1vhlfJZppIhS
         FpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSS5U7p/9Y8KeMeWb6v9vqBvqnnQloI9dCfTjZlFpHDXbk+CDXqIQGHRw6cmHS3b3Djq/0J28tBb39PE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwND/UJ+sjL3baOT0IkYtX9rkCLLJVC4UOYqkcK1K0t2sDfzvyy
	OpN2Ana952HAhFEEnjcvKlHN0dipjeg0K2GPn3eWLYdnDXSd9kiBz9kxBE23DE2EQZ+FLJHJN/g
	bC/ZW2Ld6slWTQe7S/NHK0zg9NYyT9hs7KV2yx4OeiF081RTfrXoVTlJY8djac7HB65M=
X-Gm-Gg: ASbGncsxcGTur3j5LUzfrjE426mcKMzVMX4f1wUW+x32oegjNNNDynQ1wuS3FOsXV+q
	IInCfAsIO/2cEqHZdaBHWGSygTViSfD1yGaFZNqp0BpIuYyzsC7yUN7dtMKmH3eY0KIGfvvtNJ/
	T3BnzUzEKQtngprIFeMV7uTFnXqbnnBgpcaablG6z7Wu96XuxNJzjGOijlEhoXKiwqyMRZ5Ub5Z
	4MP1MRRDH3kqj+1su3e8FFCWXynxyRw2eEQ+HkhuXc+u9rktjZjC27lOnyjXKDNAW9wVsbhNc0e
	szwf3p/I2sOe1uEpLnC2FBw4sQ8J+6honpd2F2pK3V8WLH5LXPeME4VXQvvTKXLHlh/AaQMjWGH
	o8QgysKqk8nWYoWQT/BEMLkIejdnXvl0=
X-Received: by 2002:a17:902:e382:b0:27d:6777:2833 with SMTP id d9443c01a7336-294deec92afmr15468645ad.47.1761721934319;
        Wed, 29 Oct 2025 00:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo4Qluv/4LPjKCYl6LkuhjN5aWgs2yWaDqP2nizkpIZtyYnzkFDuNxrskuDUwxbVD+zGItow==
X-Received: by 2002:a17:902:e382:b0:27d:6777:2833 with SMTP id d9443c01a7336-294deec92afmr15468425ad.47.1761721933736;
        Wed, 29 Oct 2025 00:12:13 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e3d2aasm143529375ad.88.2025.10.29.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:12:13 -0700 (PDT)
Message-ID: <87b3871d-88b3-2851-07ee-db8f2ca1d58f@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 12:42:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/6] media: iris: stop encoding PIPE value into fw_caps
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
 <20251028-iris-sc7280-v6-3-48b1ea9169f6@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-3-48b1ea9169f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901be4f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SvJZJoMY8oi3fNviAK8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ueU6VFhvOYoC9vNj_TeFJVvZMqgDkMdn
X-Proofpoint-ORIG-GUID: ueU6VFhvOYoC9vNj_TeFJVvZMqgDkMdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1MSBTYWx0ZWRfX5ajsRDL09UT8
 x069ThWFtCcT8jngauL2n1QGmlBb43RIeE9xUkspVSeQRqPn7X921NFGHanEMEmgBVgFlwubcFu
 C3c9YWneQz4LJXE/k8vqUQ4wMHBsAOARermzWxOZ58YaltSBnT2yxU3JV8MTdfVS0TaFsB0ZFfB
 OTLn5uRhJi/hTjLwAECI9w+GPka10b+74NnijW+Br9b7X0jdMuZHsURBsA95aU+hh5F+1+2y5ie
 4NaQKlZQWl9s5KWAetar+mq48H2s3/dAKWXYtrxBAThwtrFmK54RTvJjIRta5WnC3yRmA9rbaqU
 FNK6M8Jn8AwE1I52To/vkwqBdV8fakxBeeb+z/aTJRh2VPZF/Ji7W01UZv4v5vgNUr/LkWxhLPF
 unrzmaffBllbz8G0bE/IaPSxjPTQ9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290051



On 10/28/2025 5:16 PM, Dmitry Baryshkov wrote:
> The value of the PIPE property depends on the number of pipes available
> on the platform and is frequently the only difference between several
> fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> iris_platform_data rather than hardcoding the value into the fw_cap.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 16 +++++++++++++---
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  4 +---
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h |  4 +---
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  |  4 +---
>  4 files changed, 16 insertions(+), 12 deletions(-)
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

The same change would be needed for encoder as well.
Pls fix this.

Thanks,
Dikshita
>  	}
>  
>  	caps = core->iris_platform_data->inst_fw_caps_enc;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index b444e816355624bca8248cce9da7adcd7caf6c5b..fb3fa1665c523fbe01df590f14d8012da3a8dd09 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -160,10 +160,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>  	},
>  	{
>  		.cap_id = PIPE,
> -		.min = PIPE_1,
> -		.max = PIPE_4,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_4,
>  		.hfi_id = HFI_PROP_PIPE,
>  		.set = iris_set_pipe,
>  	},
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> index 87517361a1cf4b6fe53b8a1483188670df52c7e7..7ae50ab22f8c577675a10b767e1d5f3cfe16d439 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> @@ -146,10 +146,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>  	},
>  	{
>  		.cap_id = PIPE,
> -		.min = PIPE_1,
> -		.max = PIPE_2,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_2,
>  		.hfi_id = HFI_PROP_PIPE,
>  		.set = iris_set_pipe,
>  	},
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 66a5bdd24d8a0e98b0554a019438bf4caa1dc43c..805179fba0c41bd7c9e3e5de365912de2b56c182 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -20,10 +20,8 @@
>  static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>  	{
>  		.cap_id = PIPE,
> -		.min = PIPE_1,
> -		.max = PIPE_4,
> +		/* .max, .min and .value are set via platform data */
>  		.step_or_mask = 1,
> -		.value = PIPE_4,
>  		.hfi_id = HFI_PROPERTY_PARAM_WORK_ROUTE,
>  		.set = iris_set_pipe,
>  	},
> 

