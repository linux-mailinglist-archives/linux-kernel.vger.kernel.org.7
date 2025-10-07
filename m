Return-Path: <linux-kernel+bounces-843817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD433BC0551
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C34189E471
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B560221F24;
	Tue,  7 Oct 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amH6AdCY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76434BA46
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818560; cv=none; b=BjGM+laV9XI3YYWKoMTc2+pOCdeIxqOw1314Uhwm+p2w6wqIE6q7tVZ8bsgk3N+qxJt74n/1XueuRWdCZt4UOwZfqix5g4CcLXnpdMPKcp33BSxZ8dhaAiUd67H2bx3r6sGlxvJpMU6moK+6A5FebzmDX3OQqM1eYDZQXfp8wgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818560; c=relaxed/simple;
	bh=UzKLGad+vXk1zXjOWaOEl+vXcwqlI2M59gvOtq+AVYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW5umRjwk81p681LKdWzWXZyxOxMfIJNg/eCXLwYtrhC+f2OmkdrzfyEHj4D2Yr0Ft/czYc+wz/nptrBsCjXIZGV1jPQD4V3YiSuSCcwr3H6F+bK1bbMNlUtWF44fCu+YxDndxCHidmzFQSZurYjxT8MW56Trqe8IkckYZERqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amH6AdCY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5971PYdS020199
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 06:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJ/mZMe9eQHwc6pMOqC3XAQFsV2a8LFAo3YiWpp0EbE=; b=amH6AdCYVNJDStLs
	8rJQRh4RiWhKmy/x9v+YSpBL8LVPr8cvHhOEpTI+CkfGVc9+y0Qd3+6ThG+/wvYH
	05Y8r/M+kGCi7TbDzFFU0nIoaEiifuTqcwcb5faHpDCZ5/a6Mtg4yYyINiZyVoex
	/OmdtSi4UO7Fay3bQu/7P7U+9wLb5k/y//5BilmxDZAEbqerbUq2RKYwPI6D302F
	bgOv8gc1i6XbnifgHtCSn7et/2DBel8wOJIXXmyzhR7rL4HN0s7CwArpc9faFZs0
	BC547KH8jwjLKQrxqea6zbb571OeXzPGA4/EEs6Z/0ATGglncWlnRDSGAGXBpdml
	o5rJ0A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7p532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:29:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b522037281bso4106135a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759818557; x=1760423357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ/mZMe9eQHwc6pMOqC3XAQFsV2a8LFAo3YiWpp0EbE=;
        b=URYHIeBERr7PrZoCPiq3lFFiqzSVzvjuQzEE2It/VbJ1ZWQdPTGvozMb1RZlUfdx8C
         7LuQ1QDLgpqV19HZRPV8Ge2huysGgp+8mqng7YyFUCIbplT03cZV2Qd5ubbxKuei6/WX
         DyxvuWkETSlsl/laSXK3+VlRypYDu5i3Aq2CjdgpHwBf65bzaB7mDThUqcbfqugg0sTU
         iBxGpXPYCiOk0dE+bR4V5hP+Ptxd8J8YCaviWk+GZ6C+bqB/3tNjWWK6u5iKd8OAukxG
         IsN32ZPbgjXQ1X5WMb1pF8iwvGTlTPG1dW1GFfCkBdxSn2N/x7UuG3cg+ShoOkivIrrR
         kwmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTjyBZ6QCh2asAqb8iAAgex7+soVt2AG4/Pf5OslbvAGZUcD7PVgaDkQ6liqpVcqgYt/zwIWPGWT/6+fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2ZZXxOe3v2/GQUw4t3Mvocr+7foAKwdR3a2ViTOAZa6+ydHM
	9YmSZDOhqrszMWSriZUDzpn+rw7/W3Cmw5TEhiM0pxtYzht6zWgpnMoB9emZQRmA7d+5DASp0Uj
	YdVuas1gV54vshVcBDtHcBZuqe0B/qL1+A+r5xwSh1Pw4tEasGYR6RHrotpOegREG9Iw=
X-Gm-Gg: ASbGncsitYxEZSn/pC5jHjMZVfE0LEpSQdn1U1UAOsnWMJWoAgrKQmmbwnNBoUpgWuB
	L/i4wWVjsp/i7V7ZR/auzFehA0SSvBhbclPrveaCLJ1Pm1O0odklcsQiKD7gv8+Lf1xztQEOIH5
	J/XqQ8dwaALI4npZFn5T2EuAfrArf5dBbq05q5lxQgqvQ0sKQZbSZy94yAZq7gnkIUSmqjS8eyo
	Et/0jWtd1krDihmGzS+CFYg+U+50SrrbUIUrEvSWq1OCGk31879s0wLZJPoL+787RTeyLBdWq4K
	e02HCW2C1++DpQ8qdLLMDCKvJPtI+oSQSWgKykCrXIePgb+l2+CuqcUuLkU5M/he6f+9797iI53
	fZA==
X-Received: by 2002:a17:90b:3ec6:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-339c2759dfamr19030222a91.9.1759818556777;
        Mon, 06 Oct 2025 23:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYeZYBRgOmwNar8K7RG4m6Nmim2fQTWAJstBfmo588K6ZiICRgELHRhWh7xlFRNNjzYpceg==
X-Received: by 2002:a17:90b:3ec6:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-339c2759dfamr19030191a91.9.1759818556330;
        Mon, 06 Oct 2025 23:29:16 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d25bsm18903319a91.5.2025.10.06.23.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 23:29:15 -0700 (PDT)
Message-ID: <0b448507-5e5f-20a4-a9a0-191447362809@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 11:59:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: prevent potential integer overflow in
 decide_core()
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251006154041.1804800-1-Pavel.Zhigulin@kaspersky.com>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251006154041.1804800-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX8PgGSZs/Y5kG
 J1Q2HZcc64e4W4G6I/jhHvQX+cETLrhYv0zADA0woo8pKV1hVNc6dj3bSVAbZ14E0WMZBF89xoF
 +7xuVxpAp7ipGw2ojZOnvuIOdRvbRDXqLic70tBl/kZMWDWiK/HnTVpkTL2YEyQNErQ97a+5yJL
 8XO72ZPA3JvXYdWjoLtIF7opIVaOZeFJhgVd9MY6htyT2RzJ9Z2S/AthuI3G1QhCks7gK67qcbu
 CNonFGDzXdraRUcYj/o852Pv0Izk4YrNF7mTvOqfuG8bbrspz8dB3t90gtog1uoLWU6iAhUYHdG
 /brxJPW7u871R3Ujg6mGnJ1rhDNJ/2zB0pUorMhZMKhVPLB9tv2K0pvinnGxtH5gPfGVgcbVY8A
 SbDZTjlla2/eARHyD0mC1/5tLTyuQg==
X-Proofpoint-ORIG-GUID: QzLr8Bgx7CEMYx0NZCgieKY0x__-oWPe
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e4b33e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=HH5vDtPzAAAA:8 a=ACEZY41XAAAA:8
 a=m0Ah2RrY1ua3onEXlJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-GUID: QzLr8Bgx7CEMYx0NZCgieKY0x__-oWPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037



On 10/6/2025 9:10 PM, Pavel Zhigulin wrote:
> The function 'decide_core()' contains the following code:
> 
> 	cur_inst_load = load_per_instance(inst);
> 	cur_inst_load *= inst->clk_data.vpp_freq;
> 	...
> 	cur_inst_lp_load = load_per_instance(inst);
> 	cur_inst_lp_load *= inst->clk_data.low_power_freq;
> 
> This can lead to an integer overflow because the variables
> 'cur_inst_load' and 'cur_inst_lp_load' are of type u32.
> 
> The overflow can occur in the following scenario:
> 
>   1. The current FPS is 240 (VENUS_MAX_FPS constant).
>      The processed image frame has a resolution of 4096x4096 pixels.
>   2. According to 'codec_freq_data':
>        - 'inst->clk_data.low_power_freq' can be up to 320
>        - 'inst->clk_data.vpp_freq' can be up to 675
>      (see drivers/media/platform/qcom/venus/hfi_platform_v4.c
>       and drivers/media/platform/qcom/venus/hfi_platform_v6.c)
>   3. 'load_per_instance()' returns 15728640 under these conditions.
>   4. As a result:
>        cur_inst_load *= inst->clk_data.vpp_freq → 10616832000
>        cur_inst_lp_load *= inst->clk_data.low_power_freq → 5033164800
> 
> The proposed fix changes the type of these variables from u32 to u64
> to prevent overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3cfe5815ce0e ("media: venus: Enable low power setting for encoder")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index f0269524ac70..caaab097a04d 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -582,9 +582,9 @@ static int move_core_to_power_save_mode(struct venus_core *core,
>  }
> 
>  static void
> -min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool low_power)
> +min_loaded_core(struct venus_inst *inst, u64 *min_coreid, u64 *min_load, bool low_power)
>  {
> -	u32 mbs_per_sec, load, core1_load = 0, core2_load = 0;
> +	u64 mbs_per_sec, load, core1_load = 0, core2_load = 0;
>  	u32 cores_max = core_num_max(inst);
>  	struct venus_core *core = inst->core;
>  	struct venus_inst *inst_pos;
> @@ -639,8 +639,8 @@ static int decide_core(struct venus_inst *inst)
>  {
>  	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
>  	struct venus_core *core = inst->core;
> -	u32 min_coreid, min_load, cur_inst_load;
> -	u32 min_lp_coreid, min_lp_load, cur_inst_lp_load;
> +	u64 min_coreid, min_load, cur_inst_load;
> +	u64 min_lp_coreid, min_lp_load, cur_inst_lp_load;

why update type for min_coreid and min_lp_coreid, the number of cores will
never approach the u32 limit.

Thanks,
Dikshita
>  	struct hfi_videocores_usage_type cu;
>  	unsigned long max_freq = ULONG_MAX;
>  	struct device *dev = core->dev;
> --
> 2.43.0
> 
> 

