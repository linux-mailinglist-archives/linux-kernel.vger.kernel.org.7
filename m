Return-Path: <linux-kernel+bounces-776234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32699B2CA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64381BC8623
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614022F0680;
	Tue, 19 Aug 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDpVHwao"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFB28504F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623876; cv=none; b=n5mTLSwKqm0+xQtEzdzrlaqEsy9HQJSHkwUklWi7CkmAMDfEwNkupOLzUWXndjeXX/YxV/xLWWzPwofUq3HWM9xGtTD4iOPj4Myl7W7KbY7Twslwr9C9IFP8aK/LLvwMptcb2UhRa4YqnzWu1/xmChgl9AY43HP9KHYxGm/rXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623876; c=relaxed/simple;
	bh=nvWzzpqNpT6eJfaRE4PBD9zQF//aAwvkd8/k/iioYeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfbWwjsBQ4I+oEfv63CNWkdnWLOdVAh6G/S+TuWgmbmRvl+Z6BH2auvIWp5dH+vWoUZhkjaGGz7rxa22Ow945fyzhqKe3917Po5vGDm+tdiEtyhe+W42xmUT9qilsXxGDsiV7ITZis1H42haQbNGUYpsxWMfwh4ipy5nPj4ju4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDpVHwao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Yi0000864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jcJugMEmP+bjapXf/nEWeVTp
	niYytQQ7IyAUbp7KDGw=; b=YDpVHwaoiNDYc1EstbKRajG+5Bss+xcUqnjV8xew
	SHQq9vWf0M/krUsz0Oo02Wb4CR9CUL1wVSp3tFWLgLHDX8bpXVtDsQ/cKXYQxEfK
	ctDGkTLXNxOfhz3ggJEFFO8rXi27DGzstYB2dgbzC4XGnRTwtDkOy4NHFIxSmlLS
	CofzYV6sCtFJsOR/ZkP+xTKOz63pQjsEGo3bv2N2zDzBMBIilL8JJ4+Mf+uQWueK
	LWP2GAB1EJ7QnWaYl3AHuzqBqdtKHtRE19G73O68BmwHF/SRQPez54S9msIUEUsr
	NcnuZsLbN3Q86pLKMGUcRPobdK+HYTbZ+2WX8TVzDnAT7A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079bgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:17:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b474d5ff588so1521507a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755623872; x=1756228672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcJugMEmP+bjapXf/nEWeVTpniYytQQ7IyAUbp7KDGw=;
        b=UeWsZO3KOoSdA2AalJOK4NNFU+LXIZtiQRHsZJyxnVSY90BOnnX96GC6E7i9TPOiuj
         GM3Kj1PbNy2Y7ED30mn5HCJbNAx3XJ2I/7uJLaYiXlvrxhO8v8m9qDqGsf+u7wmE5u3R
         JzCfwJCO6ShaKsfRut8Od+DypVa4EuCI5seCApYhX9hNLtkHCpd/m9XjtzY3CK4HAwHM
         oCgP1H9IyWKPSEptQnzCsB/u7sk5qujw74RQ5O4yEVpKVQR+8ygydzV5fqbw4f5yS3Zn
         vxeUAz3nm51Ax7wSoCoi5aUDd7Zz9MuIMBBV/HZXvw39gV2SaZJ2BR+DQ6wmWzgs8uWB
         J45A==
X-Forwarded-Encrypted: i=1; AJvYcCVjSU0hKBgDWTnGKIXmFTNolTCioDPQ1VvmChU3Y1qAoXqUt1T2oja0IUrCs08p3+Hb+QPjHBHopeEE30o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfydToNLb9MJYFJ9mVHRCytvPzyQnbDYKvPZichR5HmNyk2M8
	Hr4MO2fCMoGWziX3dpgx07QmyxKc3Jgucn15+rUGp0Q+qRgVCElQQO36SsvDukCJ4bA7EYSQqtl
	WqjlupVpItIZZt7NO/ed/PVKaTB/G5sxvRwX+T1JnOHMucfLoEQA4MHj+L00dCnPORpA=
X-Gm-Gg: ASbGncuvMcFIMQ+worMhZmUPyi68DDfp5v8O3GH5BEixUzQFWJMIXiLUlfUr6SA417Y
	Dzj9CYfeq0aoZkEIb7XUhg1LQ6vf1xVzY1oL3EWyFXX1KZMpi6ZwrOdmQAbyJLwBJTGZeifXd+t
	kbpCGkU05duUb2/879YvNPb5ORxz0INE/M6BHN2nCVqgOBi0mRelqAAk+VRB3W0sbgbBPq8bMkt
	5k+Je6uQOaPdgJenR9wogvGM+YQ+OJOkydw8lae2lq1NKx1k82lBM7UNIPyoQUOuvrNL6VBogfj
	RmRwfgln+ncWJgccgliy6GjJoKRaOaNPer0Uy1Q9Bqqazuma8KGafSqyxQN1sbgwOqNGG7kWAw=
	=
X-Received: by 2002:a05:6a20:7d86:b0:243:78a:82b9 with SMTP id adf61e73a8af0-2431b980068mr162621637.51.1755623872482;
        Tue, 19 Aug 2025 10:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN9cn2Ql/5avNFjiCvAWCZGwnNNwM92fq94h29uNQopaI93fMSoUy7tmgOUYUQhdeGK5VXtQ==
X-Received: by 2002:a05:6a20:7d86:b0:243:78a:82b9 with SMTP id adf61e73a8af0-2431b980068mr162576637.51.1755623872003;
        Tue, 19 Aug 2025 10:17:52 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm198078a12.46.2025.08.19.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:17:51 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:47:45 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 01/11] firmware: qcom_scm: Introduce PAS context
 initialization helper
Message-ID: <3b74157a-3f2a-4533-acf6-7cab8154709c@quicinc.com>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-2-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819165447.4149674-2-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FmuL__gitjHGRJ949OWeqhx3Ut6upqH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX6RZzMdfniiPD
 o9oCMrOBckeXGiB0XrdDvKfgaJDmsPxQCFes11nQeBGRuvZ3v0BmN7BXd8LtSkUIKALGQ+9QWk1
 4tVimQ1Bq0khIMKBee17SZ8OiA0rcMpLphhNQHNhBpJvczPtIPnKjLHKmStqtZZdFYteDvn4HSw
 oI3W6YozGiZ8ok0e4qgfZRZ4QDq58zU/K32fA3E89jAaTxnqO/pHzaZxLtAzZ0aHAaoRoBdBKYI
 cPPfJXsK6Aoq0G0GTjy7PUJm1KmEm/GQmwUQZeNkdaVTDIv2ZomZdGqI+jFxBKsYNMzDJL/jzdz
 cDPPxJC73Zz+Eo9WFCrL84BLrxBl19ZRgH3Tks7tMgbp4rPWsQkCWL4ogEIoa2IURMQn2st1pSW
 SLvCk3Jl
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4b1c1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1sDHh0GgXtZW7FQMFNoA:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: FmuL__gitjHGRJ949OWeqhx3Ut6upqH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

On Tue, Aug 19, 2025 at 10:24:36PM +0530, Mukesh Ojha wrote:
> Currently, remoteproc and non-remoteproc subsystems use different
> variants of the MDT loader helper API, primarily due to the handling of
> the metadata context. Remoteproc subsystems retain this context until
> authentication and reset, while non-remoteproc subsystems (e.g., video,
> graphics) do not require it.
> 
> Unify the metadata loading process for both remoteproc and
> non-remoteproc subsystems by introducing a dedicated PAS context
> initialization function.
> 
> By introducing qcom_scm_pas_ctx_init(), we can standardize the API usage
> across subsystems and reduce the number of parameters passed to MDT
> loader functions, improving code clarity and maintainability.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h | 11 +++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 96d5cf40a74c..33187d4f4aef 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -558,6 +558,32 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
>  		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
>  }
>  
> +void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_phys,
> +			    size_t mem_size, bool save_mdt_ctx)

Since we export this for other drivers/module, consider adding kerneldoc
comments.

> +{
> +	struct qcom_scm_pas_ctx *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->dev = dev;
> +	ctx->peripheral = peripheral;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +	ctx->save_mdt_ctx = save_mdt_ctx;
> +	ctx->metadata = NULL;

This seems unnecessary.

> +
> +	if (save_mdt_ctx) {
> +		ctx->metadata = devm_kzalloc(dev, sizeof(*ctx->metadata), GFP_KERNEL);
> +		if (!ctx->metadata)
> +			return NULL;

Do we really need to pass this burden to the caller to pass save_mdt_ctx
as true/false? What happens if we always keep metadata in qcom_scm_pas_ctx struct
and let clients use it if needed.

> +	}
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);

Is there an equivalant ctx_destroy() function? It would be confusing for
drivers to call this in their probe and not doing anything upon error or
in their bus::remove callbacks. I don't know if we really want to
convert the whole function under devres or just provide a destroy
callback.

> +
>  /**
>   * qcom_scm_pas_init_image() - Initialize peripheral authentication service
>   *			       state machine for a given peripheral, using the
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index a55ca771286b..b7eb206561a9 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
>  	ssize_t size;
>  };
>  
> +struct qcom_scm_pas_ctx {
> +	struct device *dev;
> +	u32 peripheral;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	struct qcom_scm_pas_metadata *metadata;
> +	bool save_mdt_ctx;

As mentioned above, can we just include qcom_scm_pas_metadata struct all
the time?

Thanks,
Pavan

