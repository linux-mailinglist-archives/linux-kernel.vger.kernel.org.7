Return-Path: <linux-kernel+bounces-845165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7FBC3BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34EB402221
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21E2F291A;
	Wed,  8 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="co+kXAzV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE836F2F2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910635; cv=none; b=DRz9d1wpvsg5KPGRk+hPQt6yJ97/zjYExVZKeUUeYwFdV9awkcUw1QNwdHLfXiT2Cbmqr6k2/lTOHimTEFVGwS2q/oYJcSyLGxm+ZgU7M4dHUBhojTSbL+RnLuEuUROpypiqg+H2hh3kEVSiAFVjcho77VE2ufH9jPB5dFH4f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910635; c=relaxed/simple;
	bh=cZ+CGhMJyte1AFBapr1UWxlFCeVreG3WjH6UVO2Zk+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF7T8pUgbI8kAt8b+ruiTEbRRu5L/mEl68Riau2UDkx6uOHco38hPnVqcBaKPe/tKo5YfOM1xF4mEfzMDGc+evt0yzlf44UenpCsLu2rgB/A1ru62gFMlKgJv1xBfWsiK2HdsF44ylcEUjEy2Ah8xyt6pWJ+LKBo4Yy96zwToaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=co+kXAzV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987aTot010178
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLFhrNT3xxkAGIPFcKIeeLwCuF2mI7yMFZU7xOawpq0=; b=co+kXAzVc1383Au7
	S9U3iiGAu8z8puHXRJJyLG5xU4KxQNk2cv4DrGPReFIu+8QXQbY3Q3wZXeJd5vvE
	ZWMGNpQBzta/vQF640X989SdXXgrtk2G0gXgIkl3zAmb1mZdkCMqlT3ZnjY8oV4J
	x+6Fmnct8czsA2W5j///VtR6OLo9rY7Zin+jXUNnrxV3OesbbmObddGFDeu1vLFC
	WWZtAjviQfukjIN1CMaMuEL6X0cxYR56oz6VhtGxj8Ov0/zztJ490L0LBW/zVpGe
	0PeOlfQ8za9uJpsleW2FG75RLWVysXGhu4qrhazfVUfUoDrx/g7BG57pY71hkPzY
	lr8u0w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9r6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:03:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85696c12803so304411585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910632; x=1760515432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLFhrNT3xxkAGIPFcKIeeLwCuF2mI7yMFZU7xOawpq0=;
        b=oH8yiSg6wo3AoJU6gSAn4ofxXS1h10z/x3AfMEJBU7d8slylqZL5OG94aQfO9nUz0D
         5n/E8fWtIiRUFQU0loL1vOfc/5q0i/LqeciZCNA+1hkb+Cb+yHdXR3LVOETeOalB14oy
         RCt6SXaM5tqtWB+rKuZKVkU80KxuZZSrHM+S4emutAifgDIT68geBt8x3mdh+1+MZT2J
         BebQhrIor18FL47MR47/vdQxtfTI8Pt1VzDPBtIU1puWFs4l/oXs0k+Zlbs6uPfUxKXC
         3FvWnHQ84AnWf7gLMDLv9ttFHiOPOqXB+uS6wvOekRKCamFOp7BgtyZ2KYXtMN9eYmg6
         68NA==
X-Forwarded-Encrypted: i=1; AJvYcCXvBc/+pmLDZDHvDLuPNdxOehXl3ZLgE4irfoBwyA7hQpmoc5zhu9NUZ27ixNA+S1QnamjCCPY9313gfQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AJKpX3wM2gJPCPUjUpkdkpnUAqGDz79+evPFrCxsmUQTx/93
	9Dx6WqMRWUW27A8MXbmd+cXMrEx6eHnXVn2KTXa2+V5VJEgvepoN4TUTDw+Yum4Wg+46Je1VVKq
	GddWHjekUZRLLp/NkC1AGMIegpjctgM62qzkwLmLHY/p7kb3bifbxs3b7KgDTZ6xnCq4=
X-Gm-Gg: ASbGncsrmBhgny71D0qVRh/SEtlm5mpgu+cy9EWWnKjeEHOgPVvn6kd8r003Rj9z74u
	HDu4h/dOUCqtniFLhtaKbCobVsMTmAsTR6oWkkNGTyKi7h95cavWnrVt3jUWUl5Jdc+S/JHW1ec
	gpt3TFKfNfBk3VCx0SliyfMaXgnfOpmmNZXvi3nic2rGOKMhcTTpqfbbxBBs1O0wvC1NP4dK8nC
	XeVRLULpfS9gzdCU4GRKHmBLcOBAj5a74y/zfsgsJ4HRuQUbwiDQGd3Qf1PvR81ODlJv1z5MIjd
	0rXridJBKqvaA98GhogQ0W1oUK4BlZNk2RYVDtk0ku0bdAUkdb/+//xsXz6TWgMMNWohX4+IFa3
	IVUBXHbY5ZPqhjYwuEn+9MGLJTh8=
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr250960785a.8.1759910631555;
        Wed, 08 Oct 2025 01:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUen+p7TkoJJtINpFELadPj734JpkHmGQl5lhM+jJkqG23scWPoS+3uXq/eIFHltmLRIhShw==
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr250958785a.8.1759910631027;
        Wed, 08 Oct 2025 01:03:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a786sm1649182766b.46.2025.10.08.01.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:03:50 -0700 (PDT)
Message-ID: <d9b6ed42-d70f-46d2-a0c6-a98df4b46607@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] media: iris: stop encoding PIPE value into fw_caps
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-4-def050ba5e1f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-4-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RP-B_H01-yLOcCvoS06yovePuXYGsgAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX/Zhc1ll8XuUU
 t65cn2gHIUxiZc+1nyRZcXzWjMwKCEOzYEcpUz3+FyUDye3fonDOdnaaUBatdYIt39a+koSW1tZ
 vuH+V3WTGiVV03NzuJqoemKqRFXu/0/0KKri0Tn+zYnhlNK6YDB6ifTBwck6NzWQXt5nK/AcfeO
 QXf8hIBA39jpC4w+NFDceZu95UmJlnYaanIXfDRa966OojWgSfsXxtQysDQMC+UypkuUP+sT3Zl
 rFne240R0qhWRMR4N547AAg8hr2jB4p1wYi7KJqJNoZnW5CgdxR67wpRojwTyNBnok82Pny9I5o
 SWzx1gCkMkd+GSHcNss9Y9KK6ToWXrgKanitCOzI7JdGxzhzhP+kdDN50//4cGAX2s61K7KmZqQ
 hwbDYQJJYIO8wzVRvHp3TjcaaD+wsw==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e61ae8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=yRfd9HfqWQK8yE8Ax7UA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: RP-B_H01-yLOcCvoS06yovePuXYGsgAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> The value of the PIPE property depends on the number of pipes available
> on the platform and is frequently the only difference between several
> fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> iris_platform_data rather than hardcoding the value into the fw_cap.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 6 +++++-
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 0e9adb3982a49cfd7cbe5110cfd5f573f0f7bb38..8db3fa222bdb92a7ffff3dfe62d33f16c0550757 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -318,7 +318,11 @@ void iris_session_init_caps(struct iris_core *core)
>  			continue;
>  
>  		core->inst_fw_caps_dec[cap_id].idx = i;
> -		core->inst_fw_caps_dec[cap_id].value = caps[i].value;
> +		if (cap_id == PIPE)
> +			core->inst_fw_caps_dec[cap_id].value =
> +				core->iris_platform_data->num_vpp_pipe;
> +		else
> +			core->inst_fw_caps_dec[cap_id].value = caps[i].value;

I really hope this if-else won't grow in the future

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

