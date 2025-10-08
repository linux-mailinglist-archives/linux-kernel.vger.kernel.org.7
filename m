Return-Path: <linux-kernel+bounces-845188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15449BC3D11
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF541887CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D512EC559;
	Wed,  8 Oct 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Et1yirwh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4C13D521
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911974; cv=none; b=Nlr42tyrUWb81/PbmDNizok/9KvNR5QjgLTcnZcF8mj0UjT5Tu5ubRaU+j6ExPLHXHPpBAWjqmz4qDxRzT1+DWvx3zImV9JNK+idXhU9evLCiSzKzvCrZGZqXbtbr80rTpNNtsvkDFXwlbNRXWqKhIMdq9YZbwhaXtEbHNSv9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911974; c=relaxed/simple;
	bh=RQQz6gD6jkUfEsyMDktDwFYO/gAk14u/fR2P+lyiYhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVb7YaFQSf0pWPDrdVJM5qun2h/+7jBYYIyea2p8IDVEqpKhFQlx3PWZYehG0hFs71+yh1e6TYN9+y90KKTg7cGdorDuRjpIpgXTpS46pzpfCHSUHRQPOuP+Hax4wpyBsitNyWxLvc7DBhlt0YNIbMh5GS7c5+8wZDLvvNj6uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Et1yirwh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987ak2U014218
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	53dlOd9NZ/agGEGJTr5I49jgU3gY6VcWx+OSG0tx7Xs=; b=Et1yirwh55V6Iwk1
	xyv10jihz1ffcDxLfCa0Ys3pUAi4BpGvooXF6oRPL+e9Wi+Scm8Bql+JNakrWfC5
	9sEHvMFK2KE5QhBvSe5lWpnQgB0ldGnxMEZjTPg8ddR5Y94Aetl2KWQZAcHJV93v
	W5wL3sVyFFBip5hR/oIwMvPp7/ozK5jTZ+D92qJqLeaTQsfBV98c4tXpjfa0DXTx
	VYfN0pO/EzSQ3z8lIuwdgVs3ELoV0itllbRHyR6fzy0WgrAub0czmv2SDbAa8TSq
	KhjPIL7g4BVA3R5e3mfKlFyRbXh8RE1NOV5DBoLWaEBp3ax1lOe+HfCb/BIT1AAc
	FAgtrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpvmma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:26:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e6d173e2a2so9343271cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911966; x=1760516766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53dlOd9NZ/agGEGJTr5I49jgU3gY6VcWx+OSG0tx7Xs=;
        b=mc0wrrdIg6r6zKuW02WpeQfOfaeF5QIGxfyn6kT4Y6LAcBo7nC7MBSup5YJlCLoHet
         kbtIT2Q6BeLFYOxNRXUD/IVtmA5/Q4mdWqSb3tZI4WrmS546aZ/D3roNG8EwFxHP9hwH
         QFRdepjBIqXtqwrZK5tZRagwc7L3JjQNBqbySai6ZhZUGKRh/OJ3ndOMeC2tZKYfunXW
         K18eAaH59tXdTdeE8PCp7ZeUuiWSR9NJX+ON0XeJooUfLrgB0sHUAHfpVOkpd1ysWlZ3
         OlbHMKeyY/i6o9+oYAv2u6dOsFOit9f0Oaqo4dlL0FUfUruv+u4X3r0aV54i4JjO6a79
         lPYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ihd4sfaPuzOF5IYr9rWkMXb48BhGG3yx9sWC5XUxMgdwgsI0kaFPv/Ox0PRhDhBJPdzX2ghZOcEyKn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJ/SQFO64+NfSbzNhJiY3njXEJddjTApBrNYKZmMuQTyi0KBe
	SEEje3a7gImLN1omhYOaPiZ7E1Vk2v7uc3+Xq3Zi7L5Mp2RpkgY8oAt82/+tiSwAl0X4ERh/oi1
	2EUKZqiEgzyGx+XYTXC6rysJBRSPNjsANV/7zchTO/KByBODKtj/f2v3YlqQi9WYwUvk=
X-Gm-Gg: ASbGncuHp6/jIhC0Q8Cwx1qlWohVGsNJaCBSTC/u5fwXE/CCO3rvanQlKgaIbu4Ipmv
	MN3GXYCsxJFP7v2qierpU7EhWoKkkExHQt2L6vlaba8cr9W3igm+4hD39hlhzkKe5DW0uASZIXf
	I7Wrvo0RmbH2cKWTCY8dV9dbSagHNXuy22H0MNODAfibfTSn6UsXWqlQLCJW2hMg7cFz2xmkJ8/
	4fuoO5olY5kszumppTAH1BdYqsFHeLppR5du06msJ5RrvsgRPC77HhBpESR+0jiVgg4WOGKe0MG
	VA9RIFQ6Zuv2iGunOjjOR6XDyfCFziwDOqrLA3bku4bzfs6jq9zsv8rIxzrR93Qzgy8/2TLlN+9
	oSR9qgyeysiAvliQgNQcnjfet3ak=
X-Received: by 2002:ac8:58d2:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e6eacd4f8cmr22760741cf.2.1759911965915;
        Wed, 08 Oct 2025 01:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRmlkTLXnDeFKjuXAj+nAZgfp3XEota8uGT19bdbXw/d2N3FbwbUJmqTziYryrjb8SIWhx+g==
X-Received: by 2002:ac8:58d2:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e6eacd4f8cmr22760541cf.2.1759911965444;
        Wed, 08 Oct 2025 01:26:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm14431758a12.36.2025.10.08.01.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:26:04 -0700 (PDT)
Message-ID: <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:26:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] media: iris: enable support for SC7280 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mllC6vPDDchmlEk0Zaj2aXlatjD-doD6
X-Proofpoint-ORIG-GUID: mllC6vPDDchmlEk0Zaj2aXlatjD-doD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX02SFbdKQgsp0
 CvgHXZwoQGTWZZMkx8qs2Al5bFZAKWm0pfT2O+3UFnh2WKb2xADsIIKwlRBonqKaA0jgX1v3ZcI
 TbPFBD5zVtCiJenmaZB3gvs9etXdHofwXFhkN4OvQlgz+LcP7pegwFHD/YbaeDDbv1bJ5xTa/q/
 GB5TCz8JPqleo64dGT5aEHrwoXPdLQfj9Z39TXXiSW2383C17KReYQR+Ui7Kj//iVTspOAfYYrf
 UbASwl2TTYvJRHC6QRU5dWni14ucOSxl2rD2TkJQtjvh4xv0qEKbR0e9wS8uiqTLwiARlWQzRf2
 +niWG8svZz9zgAFxA/kmcri9w4rjZ6MgHUuWkz2mfRk57AD65e5kaPy9sUZjWsbiceT0MZA8gsc
 3enNBpmtEST+s22QC81XNoCvLupCdA==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e6201f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=j50RDpsK6yXKt_5VL_0A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> As a part of migrating code from the old Venus driver to the new Iris
> one, add support for the SC7280 platform. It is very similar to SM8250,
> but it (currently) uses no reset controls (there is an optional
> GCC-generated reset, it will be added later) and no AON registers
> region. The Venus driver names this platform "IRIS2_1", so the ops in

Which we've learnt in the past is "IRIS2, 1-pipe"

> the driver are also now called iris_vpu21_ops.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |   3 +
>  .../media/platform/qcom/iris/iris_platform_gen1.c  |  66 +++++++++++
>  drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
>  drivers/media/platform/qcom/iris/iris_vpu2.c       | 130 +++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>  5 files changed, 204 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 104ff38219e30e6d52476d44b54338c55ef2ca7b..36e33eb05a6918de590feca37b41c07a92e9c434 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -42,6 +42,7 @@ enum pipe_type {
>  };
>  
>  extern const struct iris_platform_data qcs8300_data;
> +extern const struct iris_platform_data sc7280_data;
>  extern const struct iris_platform_data sm8250_data;
>  extern const struct iris_platform_data sm8550_data;
>  extern const struct iris_platform_data sm8650_data;
> @@ -50,7 +51,9 @@ extern const struct iris_platform_data sm8750_data;
>  enum platform_clk_type {
>  	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
>  	IRIS_CTRL_CLK,
> +	IRIS_AHB_CLK,

Interestingly, 8250 also has an AHB clock, but the clock driver keeps it
always-on..

>  	IRIS_HW_CLK,
> +	IRIS_HW_AXI_CLK,

This exists on SC7280 and SM6350, perhaps as a result of the bus topology

>  	IRIS_AXI1_CLK,
>  	IRIS_CTRL_FREERUN_CLK,
>  	IRIS_HW_FREERUN_CLK,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> index 2b3b8bd00a6096acaae928318d9231847ec89855..d5288a71a6a8289e5ecf69b6f38231500f2bf8b4 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> @@ -364,3 +364,69 @@ const struct iris_platform_data sm8250_data = {
>  	.enc_ip_int_buf_tbl = sm8250_enc_ip_int_buf_tbl,
>  	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8250_enc_ip_int_buf_tbl),
>  };
> +
> +static const struct bw_info sc7280_bw_table_dec[] = {
> +	{ ((3840 * 2160) / 256) * 60, 1896000, },
> +	{ ((3840 * 2160) / 256) * 30,  968000, },
> +	{ ((1920 * 1080) / 256) * 60,  618000, },
> +	{ ((1920 * 1080) / 256) * 30,  318000, },
> +};
> +
> +static const char * const sc7280_opp_pd_table[] = { "cx" };

Wonder why this is different..

Oh, I can bet good money SM8250's Venus isn't fed off of MX alone..

Let's check the sauce..

It was always supposed to be M*MC*X with MX just for the VIDEO_CC
PLLs..

[...]

> +/*
> + * This is the same as iris_vpu_power_off_controller except
> + * AON_WRAPPER_MVP_NOC_LPI_CONTROL / AON_WRAPPER_MVP_NOC_LPI_STATUS programming
> + * and with added IRIS_AHB_CLK handling
> + */
> +static int iris_vpu21_power_off_controller(struct iris_core *core)

This is 1 : 1 the existing sm8250 code except...> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	writel(MSK_SIGNAL_FROM_TENSILICA | MSK_CORE_POWER_ON, core->reg_base + CPU_CS_X2RPMH);
> +
> +	writel(REQ_POWER_DOWN_PREP, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
> +
> +	ret = readl_poll_timeout(core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
> +				 val, val & BIT(0), 200, 2000);
> +	if (ret)
> +		goto disable_power;
> +
> +	writel(0x0, core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_CONTROL);
> +
> +	ret = readl_poll_timeout(core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_STATUS,
> +				 val, val == 0, 200, 2000);
> +	if (ret)
> +		goto disable_power;
> +
> +	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
> +	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> +	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> +	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> +	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> +
> +disable_power:
> +	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);

..for this line

but this could be added to that one instead, since both clk APIs and the
Iris wrappers around it are happy to consume a null pointer (funnily
enough this one returns !void and is never checked)

similar story for other func additions

Konrad

