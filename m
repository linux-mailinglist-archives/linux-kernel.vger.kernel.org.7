Return-Path: <linux-kernel+bounces-851913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825AFBD79A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B673B1F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873E2D0C92;
	Tue, 14 Oct 2025 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqDQmER0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EA303CB6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424316; cv=none; b=cdoNYWoL1DQGKQAuqLW9kRZtRxul1DUTOaFPae1V7leEcOPRQMaVxuPo8tRlUb9jbhiHnn62NGI8XqeStnG1j50XYdYzlxnrKjSA6XQjMDrVRdMVnkvw4LR7alDKG46IrT94yduVrK/mexREAWCJSsxXsJOqFG77dgZeJgI0e2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424316; c=relaxed/simple;
	bh=J9jGOA7RxXG/uDKGkODr0T46+dPJuuy6/5vlmJdrTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvasDF7chtlCyXCc7HmWE/9+unM98PJmG3By2B2kKG5zY7kOKe1b9BJ9CJ1Cphrmaq2oCgyHEjvAq007fjBDfZiEsrV3/CzJVzu3zkBdtvQYiZTFLmoAfwD3BBCHan+vqrQ+Zc3VPXNMV7wTG1NP9y6yUqIeifIWb0aomwK3S8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqDQmER0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6LKe7016843
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	35L3kgBLgmTkcE9OZQQ81NyuPk6b0VIT/Ot8MyZGSBg=; b=FqDQmER04wRRQzlI
	5z+82KgMZuLRXUPZPE6+Q1LSa6XVoLkc543U1Pd5LHyOtWPnvRn95Nh/51JKZIPs
	Pp7xl4uqo29ZItFDPZ78XIHcQwrf94aZEsn1DeLTQLg1DYpRMAOp1dqYdya32rx2
	mJmKb0QnR9U/2bMdE5Is7CFYleA0XCQHLYocZ34yiUE9mbzphNw57Ok+5EUojSnR
	KodEiqmTh0lKK0hwPCHiYlQshuWDCr+xL5a31hx/+r75Vj0syYiL5X6K+Mk0+krX
	zfVcm/9ZVytOgpzobTFo4MCBtKUqnXnxGHfHcHqgPSNFgYmXzGjUzg8x89CqPxdI
	7dtPNg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1abrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:45:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so8568638a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424311; x=1761029111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35L3kgBLgmTkcE9OZQQ81NyuPk6b0VIT/Ot8MyZGSBg=;
        b=KdJR1RCpuvVst+Kq3LOM4NWzJ+4vqtn6EnDpt5fQP17dqZ6s0fBZyEuY8RGMyCyyWu
         J7N5NoFjA5paKNAeCi4hMn8ZZZQQ55UMD7MnI68exJuWyEiP8jARGKVrLZ+eh+n0pztd
         MpViNihsSSRAahw/td+dfKK2YyIk6IQGJOnKzowRTiq7PtclLGXh6XGrQ2YTkIl11gRt
         tLdswAxSdHG7peIPzAdIx2oxXU5l/SlKTOcYxxAGszJHtnd82NrdMFDORJIajCyrRHGa
         ekMEl7FHxKprSp33rFegZFsWFMHNp9RTyCCVoIN8fu55lfd1D7NDUOLPeQOj5pNNKGJz
         sbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW/b/u8cFGJP9JrrZmDmFObERXO2IK/t/06JChFHTFakq/zDQhPQBLAR1j7EpHob6kKfbuwqqxNyuuJcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXSla4Q8SQslAmaK4O0yDL090GMslDEFo5dK5+i08TW/Q7EGR
	03GykYXGDIkgoyfSeztlUcQMO9plm1QH+pRbSOqYFR6pIdXN0TJYpO+AU8Uw9HANzdSLl27oVKP
	AWAB0pZuKPkbxYQzGGZ8NV4rwSAsP+W8vHTZVNWHKT7npX1utibqp4ljv/1G8HeZMU0o=
X-Gm-Gg: ASbGncuEgVco7KLdrhPOxw98YrSXcTMMTVhq7mCu5WM9DOON0tSs8cAPu88HxCfkwdZ
	fuI2njdVwDH4Rp7b48uYuVOM27FBEaGeIzLUPtoMA0t0G5nXmJhZjsSAOIkfDwdw/+5bWDIcmCw
	eElsIA9BLSRNtszniJOk1pDAlhNUxRDuwuO6ZmeivRsHy1MDrhPxbnfZ7cnEBgtCOn/Jim2XwXB
	DMuJSiJCH0EbJG+TJL/i74NAhGizWwEg5TPbBlcD0FOG77WBoK3W2dQVQu2rhc4xZnPM77EJs/y
	cCUHh3TksvEjLkwI4CsG6WhWRXkSuXr0KLFEHc5zA/iv63dFoigQlsMgCDum1NgoNOQCAOBS
X-Received: by 2002:a17:90b:3a92:b0:32b:dbf1:31b7 with SMTP id 98e67ed59e1d1-33b5114d4d5mr30890126a91.2.1760424310516;
        Mon, 13 Oct 2025 23:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvPCHkGaaKprkCCPU+pf+oJXyvbWCEPlFJfzmcC8Py5PD4JFWz4/0XSGO3LAjsjOsgGY96rQ==
X-Received: by 2002:a17:90b:3a92:b0:32b:dbf1:31b7 with SMTP id 98e67ed59e1d1-33b5114d4d5mr30890101a91.2.1760424310077;
        Mon, 13 Oct 2025 23:45:10 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a392cdsm15060370a91.7.2025.10.13.23.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:45:09 -0700 (PDT)
Message-ID: <fcb402a8-f0d1-d268-5bcb-0806433e5356@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 12:15:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: iris: Fix fps calculation
To: Ricardo Ribalda <ribalda@chromium.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013-iris-v1-1-6242a8c82ff7@chromium.org>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251013-iris-v1-1-6242a8c82ff7@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68edf179 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=0qo9UwXc1eKLUzRIyuAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cZmf-azdeEx5wt6JixnZT5xVY6Cl0u9Z
X-Proofpoint-ORIG-GUID: cZmf-azdeEx5wt6JixnZT5xVY6Cl0u9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX3I0P/bLHRMsv
 xk1xPOEma3NF0K8ed5W4SVHA7788NdUZTxRQYkGGLaluhARVsQr20LKGJ/SBNKDx8A4X990tqS8
 sl6tj2LzqEc34PkIJAbNn7IvQALf2lN5farVfTq4+N7UlcNkFL6ifNLZ/0CqzNcuEIjDzYFQoxY
 BGsETznRwnr4PRr5PZ4NkCsyh9UbL4MtJbbc69+QGu1CioCOrwUq0f2COeI/gNYjYYasN5ePAq1
 3wktnEtV8IgLrFFOYllxVpAueYUfcKrbauHnF+JYOH0i1zG2ctoMOWb90LZUlgiEjgF1IXjOJD4
 1h35NAp1Znsw+iYqA27y5RxzY+K5fdpdedGHYJ89csSjNFrRndzoypagRPXQb691GHpqK0SJJ87
 /pC3aenjHQsy2Ioi+lLt+jXcL3hhlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 10/13/2025 7:43 PM, Ricardo Ribalda wrote:
> iris_venc_s_param() uses do_div to divide two 64 bits operators, this is
> wrong. Luckily for us, both of the operators fit in 32 bits, so we can use
> a normal division.
> 
> Now that we are at it, mark the fps smaller than 1 as invalid, the code
> does not seem to handle them properly.
> 
> The following cocci warning is fixed with this patch:
> ./platform/qcom/iris/iris_venc.c:378:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead
> 
> Fixes: 4ff586ff28e3 ("media: iris: Add support for G/S_PARM for encoder video device")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/qcom/iris/iris_venc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
> index 099bd5ed4ae0294725860305254c4cad1ec88d7e..1234c61d9e44c632b065a5c44d3290f6e1491892 100644
> --- a/drivers/media/platform/qcom/iris/iris_venc.c
> +++ b/drivers/media/platform/qcom/iris/iris_venc.c
> @@ -371,11 +371,10 @@ int iris_venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
>  	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
>  	do_div(us_per_frame, timeperframe->denominator);
>  
> -	if (!us_per_frame)
> +	if (!us_per_frame || us_per_frame > USEC_PER_SEC)
>  		return -EINVAL;
>  
> -	fps = (u64)USEC_PER_SEC;
> -	do_div(fps, us_per_frame);
> +	fps = USEC_PER_SEC / (u32)us_per_frame;
>  	if (fps > max_rate) {
>  		ret = -ENOMEM;
>  		goto reset_rate;
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251013-iris-9addbd27ef76
> 
> Best regards,

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

