Return-Path: <linux-kernel+bounces-782722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47822B3241A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A95C580042
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23333471E;
	Fri, 22 Aug 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQS8Om7v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854017BA3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897756; cv=none; b=KRf20Ph3SniczNRxuF/ah0CKL4BVaQFt4TkzFIC/WJy9+AZEx6RQECOZBkiAI096mBrmVITUUucWs0L9AXy3Ddmj3x8X/vG6iJwXy92+l67Tw93mDVEO/gRulg/5/blTj/65djoCzaRo54JvNG8rhO3Lup7l6X4ejXxQ11GjS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897756; c=relaxed/simple;
	bh=fLNcQx0engoQmdLVWT3nsxi8NHNazUitXj86aoV4nI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpFUtmlSx5a8gk9he90h/IKRoisUyZ0AKJDFwmPTqXNsZAiLIjQCgp+wefaWE1SpAm6NjnwDlu5W6KGtowdm0f7GoM6vHVeRp9P/PxMuhMdAfwSz63X7HV+Ncbu9yPfzNkdyfhNkCzyK373NTtDu/dJdXHLqp2FEFRZr+Gjhf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gQS8Om7v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MKF2ff005583
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y04A3Fq2j9qagFY6krypelE5uzKnSvrs/VFzYky1PFg=; b=gQS8Om7vQtOyKzYk
	Fy41yFewp/AE82OFifGiQr6Rq+Zmao8xQeRDTu6nesE1TXyWnBUwaTp8ztldk0Zq
	rImQ6OLSJ9wzj2YrELxsUuD52qRalGZXUN/xiREzUKWV6u8PjB25m3OyML1S5mxg
	Muh8slscn3lggCPC2f7csqm2x/+hSOM4ttZmGEwsFGaVAKTvZ9/90DoMQKI4hoUB
	vfM6GPetebR5W/zyhtoN6HuMrpTiTRBa/b4tz3fEIveYq5j4xs0BmxYnMUQDuxt7
	ycv/Ok91yS8m3KrNuXIRhOHVSsja0cnbvkGEIgg0rKMa45f1j3X1EsecX5fzb2Si
	9gTNTg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw10gh1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:22:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e62284dso4857852b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897753; x=1756502553;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y04A3Fq2j9qagFY6krypelE5uzKnSvrs/VFzYky1PFg=;
        b=kObNbn015X+dhslSgaQDtZnVEXv3iG1c2XyWufXJWmyKfw/gP/iS2nKks3nKRoZhZP
         tLwgrbisYXEw/R4hUmNb5mZykMXyI4IsoOHKxONVPQ/pyokmgUjx+aG83PDSFPyjVlC2
         5t9AfauZEVnLr0QtgAaKj1wnTSMju3fLlHYIxE9sWrDtE05IDv7pZ9V+iZL+i65+nafA
         +bN5lpztulriKG8AlXpj1lh4geACSvWqOif1uF8i4WrBAnDCFCK4JDiWHrsOAPfwP9ZJ
         L8aM1pnMq+IcB0N/7ibjgOeEThtdUA9/CXlwUBhd/rK0cHO0dz9wf8EzxyLE+btLB3gb
         ViVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYPZymzVw9sRe28mt2fDoSRIt+77W/TLqyFV67yJcEDObMYwoPvtKnrOMk7LYd7bbK2/ZOTpEQcE+jDhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIWsuehGt5zZKCyhLAeETMjdiy8xla95YO5YngT/5eU+RTKrG
	qKMc8sFatj8ZVTjIQfKgubCrQ/WAFVSDfuYNJ9xhAH7rHXEw0/uE1dc/gKuzUaC9dKeA+53Qwar
	8PH0ogXNxxSc7oH0ghhuQB/TTMGcJmnSksCBKvj5/OjowD48qRGnr2ySyWsDZ+PCtlhc=
X-Gm-Gg: ASbGncsrk5TcJK19oSNtcHsiaojtyMoGAl22iUPTRoSVSxZiMKeh9SsNErwNkRyeTJu
	pUsONSpNXboJlcTK4aK0qKwqyJg3Ka4LhT1RHyF41U6g8/26LtYZFkEtSQJVub73/vyaGMGIiO5
	1nkb782qvhJ8Mu0jnVMsHQ0dIyQaPkNuVpdtZDtgV+B06Qjn1Jt3u7Yvpn7rPOd0fghvFzvQ8zz
	Dt4N1n+raghTAshd7ewHCg5ooad6f45iqNE+788E/QLMXXnvgqJ6tvJx49AAN/B4eOn59oJOqYp
	l2qRg3fCEk7uLS4DflwMjyT5VfYK55gs3TK3Q3yEtcWdQG5lzNAA7GEXRlBMHrc=
X-Received: by 2002:a05:6a00:2991:b0:770:374c:6c60 with SMTP id d2e1a72fcca58-770375bb1b7mr3749751b3a.12.1755897752707;
        Fri, 22 Aug 2025 14:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqSDDQ1Oqep4mXvYQ0f5AHY2NlHaFudfMAfAYS8IQDadWgR54tO2EW+TnIYNX89ov0/SlHQg==
X-Received: by 2002:a05:6a00:2991:b0:770:374c:6c60 with SMTP id d2e1a72fcca58-770375bb1b7mr3749726b3a.12.1755897752210;
        Fri, 22 Aug 2025 14:22:32 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.235.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401af16bsm767687b3a.54.2025.08.22.14.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 14:22:31 -0700 (PDT)
Message-ID: <73ba625b-604d-44e7-a73b-9f727ec46917@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 02:52:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: make sure to not queue up recovery more than
 once
To: Antonino Maniscalco <antomani103@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250821-recovery-fix-v1-1-abfc518ba0a5@gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250821-recovery-fix-v1-1-abfc518ba0a5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: il_NipoF45_4feqlJo4EZli5oNdrpLeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX8XCjaMZzuZ6+
 rP+lSFrTpcTFQKGnUWWsHBarPLBTzLlEhbc6aPYGyvzhGLiUhtvApHkONkT4O8E2qIbnYAOoJAI
 Ir/AVRElsIbgYWVTtJBh/3BQkeFRgPygJLi06+TphzkIWTLLngmU+a4SMWjI0EwHpk2H24Mc5yz
 syNFL7bE4Jyrqy+DGWFliNInN8W22yfk0khJ0JQCKnYwENgSWS5cHtyoQe1KMLg3beGvfz68Xvj
 2/uK7xCIkhfLY9KiebWAdd5v74GCTbvd8aoakNThGToFdFD+a5yi8l7JdgWK4UBxiGUXWiBCSL7
 25NyC262LOEfYkwspN78TaWrvF+BBUQpLfn0jU2YGBA9jaSsyqrp/yh1mZmZ/YqDwo16Pu1SoFo
 sE7gQ8oP
X-Proofpoint-GUID: il_NipoF45_4feqlJo4EZli5oNdrpLeq
X-Authority-Analysis: v=2.4 cv=B4G50PtM c=1 sm=1 tr=0 ts=68a8df99 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=YJRzWv9GHcPC3W2cS631hg==:17
 a=xRKJ3yPZld0_iGqN:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=F5irVdaa_9mHTkytiuEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160

On 8/21/2025 6:36 PM, Antonino Maniscalco wrote:
> If two fault IRQs arrive in short succession recovery work will be
> queued up twice.
> 
> When recovery runs a second time it may end up killing an unrelated
> context.
> 
> Prevent this by masking off interrupts when triggering recovery.
> 
> Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 45dd5fd1c2bfcb0a01b71a326c7d95b0f9496d99..f8992a68df7fb77362273206859e696c1a52e02f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1727,6 +1727,9 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>  	/* Turn off the hangcheck timer to keep it from bothering us */
>  	timer_delete(&gpu->hangcheck_timer);
>  
> +	/* Turn off interrupts to avoid triggering recovery again */
> +	gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, 0);
> +
>  	kthread_queue_work(gpu->worker, &gpu->recover_work);
>  }
>  
> 
> ---
> base-commit: ba0f4c4c0f9d0f90300578fc8d081f43be281a71
> change-id: 20250821-recovery-fix-350c07a92f97
> 
> Best regards,


