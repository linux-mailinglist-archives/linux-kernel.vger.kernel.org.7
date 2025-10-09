Return-Path: <linux-kernel+bounces-846377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23777BC7C73
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A19A54EF135
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D52D0639;
	Thu,  9 Oct 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHRvISp/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE434BA49
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996236; cv=none; b=H8fGQS5d76Co7/Rq8ynE+AcVlPH3/UTBr6XLQpCi55+C/nkVC4d/hGcDH3rd5mUboIw0BD8xGfBitnbDbjv6GFv4n5ssvaObxkEBzfsHzU/o8eyw5B1F8VQscR9kR23CF3AejOQ3jYMgNO96H7ysgFHw5P53UsI7uyNfymkmRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996236; c=relaxed/simple;
	bh=B4Vj89Csg/2pPQICPMyNe8JOJW/7eU9JySvWVJZyBT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQL7sf/UZrpsQSxohHcFv1x2/hno2O1EW1N/8TIKwMm4ZWP555SJ9mNlfiz13CwxNWbOwykR456xKXBuj+XGeE4F1PP7Rxuv3Kt7pIGiWWwKOcUxhkvd+QWiwyTMRhO4nUDJohZOO7src15Pz14Jah16sHO71G6HbL/VXgr8iMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHRvISp/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EI7M028491
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 07:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoM3fHf9aKLa5x5Ru3bP13mn03nmNd2yNTc3MJOCNo4=; b=HHRvISp/uGXMiW2M
	KG5py2/1LefuUQ7IEVyAizFydZKxaHy5arXkaZWHcMKUgtoBArUxasXcquLNu7pd
	FZQl0TGK6dnWDNXzdRnsY2qZf0N92YVEW1WvY29bCQPzaK66wGIrs3WsaB1AqiUm
	fnKCjMHqMzm3eYyBK2DXxROm93dEUK1wY/cvYv9lDvdE7nHn1gj25zjD4JzvM5Ej
	UXAB/FHxKN7mxxEKmIqVIC7HEZtalBdfV5jWT6/sneve0IKdZ151+6J70Y+ilnNi
	qA1uRuh8fd2dtt2fKFwa3HiunMlbPHMtU42fpPsBCBZoETr4BGB7C3tBvyVyX9Pu
	tIVE6Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kswwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:50:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eed7bdff0so12439065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996227; x=1760601027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoM3fHf9aKLa5x5Ru3bP13mn03nmNd2yNTc3MJOCNo4=;
        b=BG3fwSL9YUh79Z8yVPEp3cEUPcNeJSKWOriYnMyDSp23lMsNzXQlFKiLRgN7+T5Yal
         Pjvbl97qFOB7McSyvmx1/rKrFoiioKs2D90hsUTtttZGAvbA2MI38arygNWs2bvacFbP
         LHCOUpkeG44nRTk58ILO72z333nLDdWf8G3B64lx8JVuFa2HfesUY8Q2bWmDcDt9Kfqo
         Vv4F57fT9E1gjNmSAi2TiSx6pqevkYbPdyfBvOCciu4UXgPEZVSZNuB461f1pSPGAIR9
         WLfoADCQB1Hco/kneqetloZ7VxOasBWgLk9LUzoD1m6LrH+eIakOZNq+oPqMSxJNDqXZ
         ognw==
X-Forwarded-Encrypted: i=1; AJvYcCWFA3uc6jSZw6oPwjvyIAznvhWgFPaQWLW6sWLVc4m7TvFWrt7E22y9CgB8q5ZxTVX9EuZ3CYhxCLhx7/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUjIU6c7sHozuUnd5pkYJXPmOoHhpwg6lgczewAj6tjjnfH9V
	MMy5S4HSRgzZpfZg0bBfeYSB3wr9R4PfSrVjS3W6Edul9r3cc7SFNpxwCVfdpNY1k77kCp8Rdw2
	nofxPw+YusPMhij3YZmKd56D6y57y+W+oQwST4O5MNNW3RzUmbxOHomkLQJWN6kX6NGk=
X-Gm-Gg: ASbGncuboTd9TvJzjqJlfDtMa4acCWyCRFVclxZ4Plm9YF2d8BUCF0Qh8wbskPJsKZP
	npQEEZ9zs32L0AFY7lZ29NMMWw1UyQIpArEoS1WSRskDNut7o/gQUssNtjgYRyN9nfxOAFcvFcH
	oD5hTE/ijpmsMkkxXuaYgZvGkyNoSoZlkUnpVrMakoiDkajVdraFuASq7o+maVpgR2FQP5FJUF0
	utU3nCQsqpIEra3s2Nbs+KN73YxObphfqvQ68e8j+3/+FfyKMXF6pwJgRFtdzJKqOAe4UjPcQki
	CoDd600hxaECJAjtwpFtZTaeEhMMK9NjGQDOjabTyJ9eJnCmDTOOJ0nEwd/MM/Zw/Avvle9eIfi
	qUw==
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr122961985ad.16.1759996227597;
        Thu, 09 Oct 2025 00:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRCIIEFNL9PxfVqSmk3+kqmgoJIsJR45HHjyjsfNgmlte+wJI3PPCLMHzRAxBj2NQ2sHRABQ==
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr122961665ad.16.1759996227124;
        Thu, 09 Oct 2025 00:50:27 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de56desm20060245ad.19.2025.10.09.00.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:50:26 -0700 (PDT)
Message-ID: <c11dec36-a477-26f2-4081-fb0dc8188cec@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 13:20:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] media: iris: rename sm8250 platform file to gen1
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-6-def050ba5e1f@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-6-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8PEcRvsFHxzs
 pu7KElPXn+u5I54V2W+14VKDSlyTTNsfRIaOoCmL7syJW/OUQhYGcyv0Zrg3+4nhzBfiJNkeiDp
 qtgo1+8UemZ3rbZ37+od36q1No+bWKDMQqfVIU8Dt+zihZsYQGzejYZqgPYY4xpwqC6TnpZuSIu
 QCYyIZqtYECuNEep0jO6Nh8T6dy9XAwmXfpHCVeezjVE0Rq0oa7fpTLNpaWnu46YWhf0Sb1g39M
 x4zMZb2yniVwkUrdrxhwRHm8BnqYPr4bpwKV013x9Y/ybBSB8WQdaODaR6LadqX/QMZWQfxdgOd
 H9q56FozH7HbKwQXLBX7NXu+Z/IaT5GcgPBGUDZX8r9JmgE3NNF3QImdKoZbSxLllLFQYe7Wlx9
 PwGYqkIdCY1vstmcpCfo/6cjTMjDbA==
X-Proofpoint-GUID: c0T1Y7gknAYiyWyAcc1V8WRPElwJjXMG
X-Proofpoint-ORIG-GUID: c0T1Y7gknAYiyWyAcc1V8WRPElwJjXMG
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e76944 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=6XGvkFmkmJ0ZWo89MKgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
> In preparation to adding more Gen1 platforms, which will share a
> significant amount of data, rename the SM8250 platform file to
> iris_platform_gen1.c.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Makefile                               | 2 +-
>  .../platform/qcom/iris/{iris_platform_sm8250.c => iris_platform_gen1.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> index 13270cd6d899852dded675b33d37f5919b81ccba..fad3be044e5fe783db697a592b4f09de4d42d0d2 100644
> --- a/drivers/media/platform/qcom/iris/Makefile
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -26,7 +26,7 @@ qcom-iris-objs += iris_buffer.o \
>               iris_vpu_common.o \
>  
>  ifeq ($(CONFIG_VIDEO_QCOM_VENUS),)
> -qcom-iris-objs += iris_platform_sm8250.o
> +qcom-iris-objs += iris_platform_gen1.o
>  endif
>  
>  obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> similarity index 100%
> rename from drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> rename to drivers/media/platform/qcom/iris/iris_platform_gen1.c
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

