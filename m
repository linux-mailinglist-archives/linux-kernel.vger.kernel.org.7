Return-Path: <linux-kernel+bounces-800390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8EDB43722
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A731C275A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B92F6573;
	Thu,  4 Sep 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIH6VLj7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA312F6198
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978262; cv=none; b=hTatNadW/BC0EpheJhg9c/gCjX98P5UH10e/dSepAv5+LJa4qmt78JhgT88kn1MbsIAVq5HmgerIPShHqW1kpTaCVl5aa8/bzAfHgNBuTqU54JHFc9RxFfxebnbQ+QUYkzyRZCX2HvAQCFoKRCjo7esDPVVoDkMls1ZGI99xAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978262; c=relaxed/simple;
	bh=/3akGTP1lkxwZtcmtPRlyFMRA5KFJLoGC10m6yCNL/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMKlLzo8PoKD1w9t5aOXdF9P+pAHpTfSQraHM2Xab2KqDW5s82V8nV4y6TgXWU2KbAwcCfa+l/oNfeCdlwQKI3eVjMD9A/jc2Dy9oNzj46weo9WzGUBDwLelQaMNCyaRDXh06mlbZXPAuzOMb3GGXjQU9O+UyWjrPmzrFMzgM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIH6VLj7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849TmfJ000754
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gjaZTDZ/aDD7rrhljwAWbgjgue+W9I7isKzXGnJxcQs=; b=EIH6VLj7d4SEajTq
	Q4X2BCIDmfej9ZKbihG5UfoQ6T6Qljw99MgWVr8Kv5msP8BpjpATcPTOjhNR4x0g
	EF1zSe9lqXSRQWLbDh2tdyx/XBW02e3AfdBzf7a+HPRbet7305Kyz6YidM+WxJjC
	J0VI1fb2ozPMUxq6XA2I/x2CVlQsjtG4DUUoGZkO0U5tPhyBe3j/lJizJxkd/GNk
	DS+1ZFG8bFGURb0bje4xsGJd6JYfNlH/nk9S78LckBEAvbIOgJ4eCZn4PNd2b+hP
	EvNGcyLDYTeirOH/ZcN83xOW7swxZGv9HHRQ2fwV0tWQNIAp9Hx/EsPWmSvcYSX1
	9DHXXQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8xvug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:30:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248942647c5so25726955ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978258; x=1757583058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjaZTDZ/aDD7rrhljwAWbgjgue+W9I7isKzXGnJxcQs=;
        b=r6Ev/9W1NIV6sdobmo7qeNC0Ndt0XeqQSkeEgGMNkAsTX9YODIAhy9yeikozMXMiVi
         BJg2IYK+NL4Rz49fL2gSLRPyc7GESPLbut0GBtWp9p+bVpG65WGGw5Cg7cItJwTxyGNg
         l8kCvTzzo8XrRD2yR/xAuQ37ifU5WaWJwDkknaAfBKhbtJuq7ycd9R766vWtSNguUWwT
         itXMC21ucPvzhcBd0puPmQNZKRzPob/xmFKpdCNP2/IAmzxHceDz1Gb1xxv0KEI2XvY8
         ycJyNKpaD+c2Gpf+sRCl3gi4cwLmt3pfGxs9B6XT9BhWbY2QtMF8utxX/9+P6F7MDjXe
         UIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLMC81wwehiQ9em2aruiqZs1EXrKvpwtuELSs4nuEpROf3CeyxHIWQlOcBHR24Yu1iHzqI7hJNf/t2yps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LpSLl02Uhj+JFCmvnmoGox95/aRrcccv0iSKaH76hVdxmq8R
	C3QO3K5t8st+gbbWkhSOvnSP0tYgg4iwsbsoChiXmsf1Qe+oOy6rVVv8O7913p8r9+HEPJ7GSpG
	fDxY7h0R+UVghtOjKrWsFPdT1aIOaMjL+YrviBMO6MKQ5nr4nJzWaQxntqH9WaaivA6k8Xs3rB3
	s=
X-Gm-Gg: ASbGnctYjYFwT70QYAb7+My3UsSgkAklH9QXybLQ+VZOad5SN2/glVBj9xNkWI4KWiO
	3VXt9CjCf+x3B3Ixyp1uB/MyZ3qW5vlEjE0j+bRvrzfp0g5wjCiKQVWbtju1St/iDkNpgyephKN
	AKX42s+n7nDozI45AGxGLYnqwCNji9Kot+CuqBynIVlTkzsVunMMPtepqp14WY91lFn3lRPvoRF
	zgUoIThtFB9Kt4dqRN49/pqFWMwtCzQsMstdB2Khf5MGgPeXHYF9Y5MsmgdbCzTLs6aaHA6Tf3w
	CdImGGvaJioxeK7/9BwUKWJ7RDzKEZt7BYMcxmwfE2kR3JKHujtKGW3m0ZD6sPYwxkxaPPpx
X-Received: by 2002:a05:6a20:430c:b0:243:a7f1:ffd9 with SMTP id adf61e73a8af0-243d6f03220mr25742560637.14.1756978258539;
        Thu, 04 Sep 2025 02:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkvfv7QM1gNoAVHNThaAcgLHPGgeMYdHu4pMt4ULdHgTWcrUFnW10134ZoHlO5C/MUQvZQg==
X-Received: by 2002:a05:6a20:430c:b0:243:a7f1:ffd9 with SMTP id adf61e73a8af0-243d6f03220mr25742533637.14.1756978258059;
        Thu, 04 Sep 2025 02:30:58 -0700 (PDT)
Received: from [10.92.206.21] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f2c990296sm12110931a12.39.2025.09.04.02.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:30:57 -0700 (PDT)
Message-ID: <3202167b-9403-4b68-9b99-55be190f7e2c@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 15:00:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] bus: mhi: host: Fix potential kernel panic by calling
 dev_err
To: Adam Xue <zxue@semtech.com>, mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        quic_yabdulra@quicinc.com, chentao@kylinos.cn,
        quic_mattleun@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: imocanu@semtech.com
References: <20250902165635.18951-1-zxue@semtech.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250902165635.18951-1-zxue@semtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J3pnVnBelRT7n97JxeuvbVdT-DMPs1CO
X-Proofpoint-GUID: J3pnVnBelRT7n97JxeuvbVdT-DMPs1CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX2YgfWc5Quypv
 xivmRBw43t9vrANjDoH7C23EHxl5fnclTxQWlCIfzVuKgoDRZ6H+hon4QXtvCN6Xzk1qCYAqld5
 YDImMMvOisZvczh6QVL5n+BR3HbwLzI+7dlHWqrYg5IAaE7b4Mo96iuF5djP5wF9dbs3Kwrmbh7
 twKV755FLqUAxxqx12jtGOku4OICIl2iW8YbXI7aweee6TsKxDmv25HIZ7WJYL2//AFKYhglmIW
 XjST109pHM6UA9+8rnH2p+p1dHMrHPpVooO9hFDCBVEN37UdKd30uQ6TuhHQ/PCZG3VysMAVMn0
 YAxFjBWbxFqoA9q1l/cf1N7b8gwD4QKDZ5yKaHuQ8EJ5E5WrsZ1XfjfGLm+LpNY9VfGFyGJrBDZ
 gA+XoXxT
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b95c54 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SfXQzQb2AAAA:8 a=xogcm1YOMVM3hb4W_dUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=187EmVsF5pRpP46aC3wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020



On 9/2/2025 10:26 PM, Adam Xue wrote:
> In mhi_init_irq_setup, the device pointer used for dev_err
> was not initialized. Use the pointer from pci_dev instead.
> 
> Signed-off-by: Adam Xue <zxue@semtech.com>
> ---
>   drivers/bus/mhi/host/init.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 13e7a55f54ff..93eddf302a49 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -18,6 +18,7 @@
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include <linux/wait.h>
> +#include <linux/pci.h>
>   #include "internal.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -194,7 +195,7 @@ void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
>   int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   {
>   	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
>   	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
>   	int i, ret;
>   
> @@ -221,7 +222,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   			continue;
>   
>   		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
> -			dev_err(dev, "irq %d not available for event ring\n",
> +			dev_err(&pdev->dev, "irq %d not available for event ring\n",
>   				mhi_event->irq);
Don't use pci_dev in mhi as mhi agnostic of the underlying transfer
protocol like PCIe.

Use dev_err(mhi_cntrl->cntrl_dev, here.

- Krishna Chaitanya.
>   			ret = -EINVAL;
>   			goto error_request;
> @@ -232,7 +233,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   				  irq_flags,
>   				  "mhi", mhi_event);
>   		if (ret) {
> -			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
> +			dev_err(&pdev->dev, "Error requesting irq:%d for ev:%d\n",
>   				mhi_cntrl->irq[mhi_event->irq], i);
>   			goto error_request;
>   		}

