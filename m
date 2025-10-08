Return-Path: <linux-kernel+bounces-845050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F4BC35E8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E72A189240F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47C2C0269;
	Wed,  8 Oct 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOHpaPM5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8365236451
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759900569; cv=none; b=c1WWB67zc0PCPGuiwMRAHPXlxbfugilku+Usy5S7urBy4puIBVnEwq48vrDGCRWhpuICjE+xyKs2qayjpLehdG0Y4LVy4DoxFdvHJsbOj8V8w4E5q510LAL5Sl5EQ7APhTbdhhT18Fsp3lHv5JFD60elJ589gOrX0RLxMCFYC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759900569; c=relaxed/simple;
	bh=Xk94Vuc6seJLdFlhJl0nzWNmxlsrdyIWoO3t0wdkjEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgEjo+c7kNc3UdP08mJMxgYbxGkLyp+Lov3zosnmlMmdjwr+WcEM/DVoSJnqOHXZagsXzoW85x6v1+fgGb2iMTa7lcnIUskICCIT0EeInyxbgXC34kxZDS0+Gxr4mnTolyWOh2UWnGcZBvk8EwCbw8YCfkGWoiFV2hICuJvC9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LOHpaPM5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598045Df018762
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 05:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zN3inemXqS9KNGoW5/uyVfSNbK9UhPopJTspFYvxv78=; b=LOHpaPM5Vf0Tp2cb
	fACNshV1ouHsFjzI5o50H3M2xZ8pCUMsYOcPoIKwpeUl0ImRUOGffZg4FkAYtUhV
	TVKpb/GJRRx4OrlExfio7NfBIfayAQyS4xd2v8MozB4xe2/5uOrJZHtcpK6/Blwk
	/QIMBRAfP7xX5QqOZXiExhQMfFw6UPBodmGPdpxKNE+2aeLavTNtAfqhM0LlBvXx
	61J40quY5u1S2wSUhui9/HdYnBvXJJZF1vVo9cq1nGCVlLhKWquHB0XXxbwB+GxP
	HNcAqelur5MjmEbG2G9QB6aS+Iqd6YGyNA5VWEOBfNVXCVl+GNhxZSY6KhvQ/H7Z
	JSHYew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0n526-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:16:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so6802855a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 22:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759900563; x=1760505363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zN3inemXqS9KNGoW5/uyVfSNbK9UhPopJTspFYvxv78=;
        b=pmeDy+wxlYyDg/fPh9LO1UP9oB0Y+12nrcA1oI2iBhu7rNLYE6wtldukpwP3dlqhM/
         7LUEV+KsWPzgm/a7Nm4J3APXB1RAdsWusLoTD6DzH/KTIzvyPvQRTglN2tD2dpN7peBZ
         nJMHcZi5s1UQTP7kljyUDEXHZDQpkW+sypNlEt7yEbaE/V8sdL4jjMo7KqULetRA8S+a
         Ez+uFz/aLEl2OnI7OKGa9bsYN4LUV+z666k1bkbSQ5yqftEhTVJfKV3k5VYV0r1tuDYH
         8CmxrwlZlBT2xudAJ+egm+iql102BIWKajwo27opx5ASAdBp5uvSXMngjqNpCZ9tfQvh
         Xtaw==
X-Forwarded-Encrypted: i=1; AJvYcCXu5QwKA28d7ULhoCMyHX2lMXNvkerrcBUO/YGkK1TOw1bgHaHZoiHoowsufPXBtUqRAZ2W8P/0t93YXDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkBVGGWmg9Vqi6wNuqAPRRchN2x7PnC+lD17agFwlg4C55Q8a
	xZUwiSkbVq/NjqPAxhG70mD2eRZh4q/hAjjnxNB2kIji8s18XCDhUhZBC/Rr7fGs616FiPvzjwx
	94CFfOXgJC7a1n0XnK8sFOzImMHyf8tO4pt5crq5OKSCGWQM2tsUOc6AZ8r0dZGUVr1I=
X-Gm-Gg: ASbGnctJ4hHbx5umoxyNFVjc9Hm+WftzCheNajsFZPW+q/jlIQ5WE4Wy7dOsHGnxvSm
	waCOxIBXqntEaKCsNEx7C7okfxBWnnMGRzg/0E6VzOegI3R1z4dNI7kfX0GTBCX3sfj0TXOW2uL
	401pQjFOynpIyTcpKipkTxmgB+KpleEzXEbLew4BS+HWn19ZIlVtHYx2AHiv8gIxe2fZK6jLqk8
	G/tSTRP50JshiK4gn5Q8WfXGZYB6wh8Ui7o9PGaWP/6sohcjxAOYGSZYHw3nGBPKAUpThUzPvIi
	3/IlM35QupZUwgPvf1lfyKT4UhbEqGTG5QKkISzFsEpao/gmWvZ7HwN5rfcHYvpsXemVej/V+yD
	dSA==
X-Received: by 2002:a17:90b:3ec4:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-33b5116b782mr2662520a91.16.1759900562240;
        Tue, 07 Oct 2025 22:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJfXchZYLk7AwCGFqllzQgE2NliGSPz5KcimSGlsyuUs5e0R13CuQuC6i02t0y4fizJxZ2tA==
X-Received: by 2002:a17:90b:3ec4:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-33b5116b782mr2662477a91.16.1759900561622;
        Tue, 07 Oct 2025 22:16:01 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5114acb7sm1714505a91.24.2025.10.07.22.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 22:16:01 -0700 (PDT)
Message-ID: <1530abc3-158b-a3e5-54a6-d96b24178406@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:45:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: venus: prevent potential integer overflow in
 decide_core()
Content-Language: en-US
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251007103043.1969715-1-Pavel.Zhigulin@kaspersky.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251007103043.1969715-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QKa8qhMIs-H7-QkR4aCoYr6J-2mK7iIh
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e5f394 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=ACEZY41XAAAA:8
 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8 a=E45_vJ1-3OPGenHQyXEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: QKa8qhMIs-H7-QkR4aCoYr6J-2mK7iIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfXxgNsb3aOZFtk
 V/ti3OqiTlW2FvuK/G8zfYcPUZKXh+iEzbC1xSVE5xKzlmtzLYvSLvvTf3cfKNmXM9PbOZUVzdm
 AWPcuobsY1rdMFll8AtL1wpiiG3KyjjUUez+TgrEDZ0Qzw3uqwQqQ3m6KHdNc6sKpTZPEKShtOm
 2y+63lWNONaLszKNxKCLM3mOnJf3Mz4aCkhhlah5FvzY6mS4okdgM1LM0k0GGhcdiqkVBNS7bSM
 yZS+wLtHQVBB4FenlTkJA++hZlEzXaR5qN0O1IuqoCghISdGx1HkqDStWcTKNxVtrpsqeUHzc/X
 ptKpgbYRFyRKOpDvp341ioHSP3i/Ebg5LyH6iH7C2hs6syX4jQrqavMZvRcfhjhmuTeb3I6F7PG
 GWzCEaiAFVIsHEUeDyoz64w242kzkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123



On 10/7/2025 4:00 PM, Pavel Zhigulin wrote:
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
> v2: Revert min_coreid and min_lp_coreid to u32 as
>     Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com> suggested
> 	during review
> v1: https://lore.kernel.org/all/20251006154041.1804800-1-Pavel.Zhigulin@kaspersky.com/
>  drivers/media/platform/qcom/venus/pm_helpers.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index f0269524ac70..eec49590e806 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -582,9 +582,9 @@ static int move_core_to_power_save_mode(struct venus_core *core,
>  }
> 
>  static void
> -min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool low_power)
> +min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u64 *min_load, bool low_power)
>  {
> -	u32 mbs_per_sec, load, core1_load = 0, core2_load = 0;
> +	u64 mbs_per_sec, load, core1_load = 0, core2_load = 0;
>  	u32 cores_max = core_num_max(inst);
>  	struct venus_core *core = inst->core;
>  	struct venus_inst *inst_pos;
> @@ -639,8 +639,9 @@ static int decide_core(struct venus_inst *inst)
>  {
>  	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
>  	struct venus_core *core = inst->core;
> -	u32 min_coreid, min_load, cur_inst_load;
> -	u32 min_lp_coreid, min_lp_load, cur_inst_lp_load;
> +	u32 min_coreid, min_lp_coreid;
> +	u64 min_load, cur_inst_load;
> +	u64 min_lp_load, cur_inst_lp_load;
>  	struct hfi_videocores_usage_type cu;
>  	unsigned long max_freq = ULONG_MAX;
>  	struct device *dev = core->dev;
> --
> 2.43.0
> 
LGTM now.

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

