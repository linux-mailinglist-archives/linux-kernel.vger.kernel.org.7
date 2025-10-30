Return-Path: <linux-kernel+bounces-877744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1202C1EEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC251883B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA70334C09;
	Thu, 30 Oct 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+yO0p9B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Akoqr9/h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251630E0EA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811841; cv=none; b=ejmuoSLg5ZIal5v30jKUQaqf/zi1c6Ac5WucPgjR/g+LWOWqmR15nVqbufHg3vW0tqw6HMt/1EDw1oaJz8ltXYODfJOZwolFSaKejrjASANMygS87ArpoJJ4DYeaPy+L7DZ5HyZoHTgFoP2auLyia33STtZ8r0WjVWAiFmMCwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811841; c=relaxed/simple;
	bh=AbFlfNka/LMULfTYtozLlcZUbwq2UCX+dbWn5XbxTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSfP8sBU5aIrN0mIEyJki9nm3PLgU05Gxgs7y1tizybm71i5HaOAmR/8JqpwSDzmVYpeBSaTTP4wRbBCPPcNnOeci6KbF8MKh7TqXNKYTPv3MgMT6d6b081HI9jbhmH7QCw5OeeFdWb2k2IjpNzbG3FvEKWOXS49Q6BOtTnx0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+yO0p9B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Akoqr9/h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U2Jws24135755
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sKQ5jVf0l4p+IXXgicmYUBfd
	OUjcnM90HD067+of6oU=; b=O+yO0p9BDKyV8PNn4MnfKFPmGYM6YDHn6ZBQiHeo
	BK9qB9UmT2+yrEpng4Ytd04oZ3GhJU6ix1gjQtGbXnR7uX0YUWbTM3oIrHBHdcDv
	8nd5/qgkyVEfbNQ/cKQG008O7J6qEU378LWWS6BfV9ggbGfVciHqLpSKJ9TeOFcQ
	gb2WakR+4GUa+a/96Few+2O3EGE1s3+a2GJF4jmxJu/RBmCrtMWjWOKjV9eehUGd
	VQVg5ORBQ4QGw0H+P9sbvB0DHs9T4tnH3+fNaAu3zBMfNus/JQ5bfLIfut6c6eWA
	27FPTj3cxJdU8brWEcrhwtr9ej/6Eu5383EuPCEQtzrGcw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9uusg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so1531581a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761811838; x=1762416638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKQ5jVf0l4p+IXXgicmYUBfdOUjcnM90HD067+of6oU=;
        b=Akoqr9/hTeZYDrcdzlGM+p6jolo/LuwccEQDW5/d7ys5ljmDLa+lY4u6Q2R3ct7ibo
         W8o2vL+zwebjwlKbEFw5kJ/AicWwWwMeEdJlkHHgo1BEkeK7gCL8Pg4YxDJSqRErqaPf
         Qloyd43r1cuCJfmyaevAnzQdsJ9RUgwHw0HufkoG9edzohP/4f9Wtvnmqn5TQfkTrWwI
         CCj++p9zg9nWOTqZNHVlJ3lF35MA2chqJ0QCI7EEUTryv0Sfgs5GQPbiyoOqswbPvner
         MkaD3UJjPU28bpY8hXVwiH4k6Ue4Yilslqz0/4JTSEjymFDZeRHpQDnYjAN0R3ySIriV
         gRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811838; x=1762416638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKQ5jVf0l4p+IXXgicmYUBfdOUjcnM90HD067+of6oU=;
        b=S21xTUnl6nGURwMfCveSH8AKixl9IYSlv1RF3Ohw97AdEQY/srYMfs51Do/uj/iXTc
         kNuce1tJ7QBlZ+x20LNlXQRMervysEhpqO+HD6Ey/0YvxgM6qFlF3VJB8NPMTqPrvB4M
         rNDvkT0oveDnyIOevwHvn12WhwhNAb+pYSTABUcTEnmVOAb5zc8V8KmHF4lH1g/iTrMq
         C3h+0FN5qsBxyPCs4TCsSzOCITLjS2sDHSzz1srCRv5ISlLYZhFdscxirvOZNt3Dr5Xn
         WEDKhRnDywyLELpLQaFWCTASVyGwE6FYeQp/y+Ex0fwXx4fTVFlHg+knvUAWBIhnNVLH
         YFsA==
X-Gm-Message-State: AOJu0YwOyQ4y+Sf27IeyPGucOWInR6ISUAYjql7cXxPY3Vakrynrb3O0
	xvS1JaDv/zL+RuLEgFRkVn2ELtcO/c5opzxmAv6FRQQxu6hGzAPNh/f5zN/+o2myXutlYJTcYo7
	vgTuGD1gq/V1+Jpk4vGA8rCN7UAASIlCCsp64UjFDB2IlHF+REvPdBLd3IG4r6YLvBew=
X-Gm-Gg: ASbGncvJMZ3pdxSJ490vxpHIlYKoUfhLWP5TyaQSVbY4OhDbTOr5htqsNa0xQDzbHAT
	6aC4r4beBOLpbE8k6eOHvpvEo2H9QndfB8rkCHZbFLr34dfv3Vw9tFoiybsNzcMF6KeOOv0KSnN
	yGKAA8+PzrlZxdxGCotyFtdEK/sZS0xzs/VwV0j3V0Mf3E/P8PjHhGQx3KPDqGnfuMXd3g4W8eW
	f26VH0ZQaqVFNmf7XlLV3+JZCEIlthqEhRq0dthhpl18e3tJkACwc8N8yQjk3DRp2rX6okVZU5K
	wnJvyVH66By6Oc+q2H7yBGBSbfOh8jLOjO2kcxk6b9ixufd+ZruvqxfDCHUyfc1FsQ3N3ofLjzl
	zIuZTXRbja600HnqZCfJzNQdAXYOKZFkq
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr7057765a91.19.1761811838241;
        Thu, 30 Oct 2025 01:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcXwJ16VDmZHn89sViUhOlCtgQOUsBXdbwSglJJN9TfXEZWwsHddtgf4n3/AsvcnxW7oW5+Q==
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr7057701a91.19.1761811837588;
        Thu, 30 Oct 2025 01:10:37 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340291158c0sm4612475a91.1.2025.10.30.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:10:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:40:31 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] ACPI: GTDT: Generate platform devices for MMIO timers
Message-ID: <1eafe745-068b-4c15-a3d0-14e7222970fd@quicinc.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807160243.1970533-2-maz@kernel.org>
X-Proofpoint-ORIG-GUID: v6XP2vbTmRyEK9YCGTsVsGTbDVezOaLd
X-Proofpoint-GUID: v6XP2vbTmRyEK9YCGTsVsGTbDVezOaLd
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=69031d7f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=XE_7NARKTCcpHfg7NDIA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2NSBTYWx0ZWRfX0/D85kn4J6T0
 +qFWl3v3OxskiOEd9ubEsc8wv9QNC6A6zre4lM5zps6XNJlqHYTNsE3jRbGQL47F9CZHYHIKDOl
 mtUHYKWVVXep+rW38aXNBhblSCgbRT5SnEB4dp+CeNLXrscFGMCvNRaGDjS76Nfjh4P4B93fN1t
 tTYCwn/mI91E/lBfwNEVkkH0tsAI9tBUf60l+/HCStTXeOH87ohi6FDy8Zu5A3LKVzIFjsvUD0i
 9OKO93Dn79s6wQw5IRIc1d/hGHvyKqFWCWxEoJm4la3k0tYbgEEfyR1IaTYO7xbtXIqzGvdffKD
 NPsRtT3CGWkPJsnClONfTs75DHbuo+6PXaoFiwp8D9DyENvDhHj+CtY6+RJMaRHlwUUzhLX+Luw
 vcLr+87MT21E3SRSOkytFJ3np6wIzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300065

On Thu, Aug 07, 2025 at 05:02:40PM +0100, Marc Zyngier wrote:
> In preparation for the MMIO timer support code becoming an actual
> driver, mimic what is done for the SBSA watchdog and expose
> a synthetic device for each MMIO timer block.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 70f8290b659de..fd995a1d3d248 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -388,11 +388,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>  	return 0;
>  }
>  
> -static int __init gtdt_sbsa_gwdt_init(void)
> +static int __init gtdt_platform_timer_init(void)
>  {
>  	void *platform_timer;
>  	struct acpi_table_header *table;
> -	int ret, timer_count, gwdt_count = 0;
> +	int ret, timer_count, gwdt_count = 0, mmio_timer_count = 0;
>  
>  	if (acpi_disabled)
>  		return 0;
> @@ -414,20 +414,41 @@ static int __init gtdt_sbsa_gwdt_init(void)
>  		goto out_put_gtdt;
>  
>  	for_each_platform_timer(platform_timer) {
> +		ret = 0;
> +
>  		if (is_non_secure_watchdog(platform_timer)) {
>  			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
>  			if (ret)
> -				break;
> +				continue;
>  			gwdt_count++;
> +		} else 	if (is_timer_block(platform_timer)) {
> +			struct arch_timer_mem atm = {};
> +			struct platform_device *pdev;
> +
> +			ret = gtdt_parse_timer_block(platform_timer, &atm);
> +			if (ret)
> +				continue;
> +
> +			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
> +							     gwdt_count, &atm,
> +							     sizeof(atm));

Did you mean to pass `mmio_timer_count` as the `id` argument to
platform_device_register_data()?


> +			if (IS_ERR(pdev)) {
> +				pr_err("Can't register timer %d\n", gwdt_count);
> +				continue;
> +			}

and here too.

Thanks,
Pavan

