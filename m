Return-Path: <linux-kernel+bounces-832012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF53B9E240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8C1BC3C38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8592797AC;
	Thu, 25 Sep 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2sQHZc7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4EB277CB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790458; cv=none; b=Veo8lWWiPOwsd083ovLmCparqrmd9ZZmjjV1zKXAmVMIr4SWV3q0EhzwQtoqohb8uFYZ2H11D2smA6NbURwN0yGSDCgJjpy9UKihwBPhIroRr5jbC/hs5zQP/eszwgN1GkKQoMvkz6xq3gH+8T875HHHcxALy7R5g/KplqYo9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790458; c=relaxed/simple;
	bh=zyVDLpTb1jMDxgKVaGCjwF1ze9Ziar88z6Sg9oPwJe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEJFLHJ/OrpqXeJGAZD6MqvhAoSqkvV/ZmAk9rfpNTzfsT9wK4DYe9QPfvyz2hHUQaqPDlLqduWlFrW/LR2+HpYUBIwaMgy2NVr+oekMSiUqbC5Ile68u78V7Pab7b1BUw3YL9SsbqddAP3tF1lc/04EEO14eDth2qlGWZRrGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2sQHZc7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1GpSf018069
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kye4RDMtqb5e6RSBh0awG7vx+K9ggDIP1BsQPwuZHaM=; b=S2sQHZc7DPJlTJlR
	nMIv0M7gANoydGrNooVCc4H8TmoIIGVM3N3qmxzeOts5YoePkEMwZ7nbTFPCZaaR
	k2+p4SWi0FHTICybmNPrhYe1ixvdNLfl/OCkbyyG7zHyR34IlvHwKwqooG69yJhC
	3gSrObD5CkNBpTLtbw/WTneBMQk9soRSgZNK082yQzudFUwlyELkBIxrYNILqfEW
	E/vcj0UqUHwjS+YjZEfvgjvn8PqYBei6A8P24YfvbhkpWRcTWlYmVYdNYtJq0gcM
	DUQCLqhRqH2Ebz3yTiDGEKYx9lBINt9Djzx/6uLq+HMgJ57b0F7IY3hYPtbaHsq7
	5P4NWw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbdm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-798447d6dd6so2164366d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790454; x=1759395254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kye4RDMtqb5e6RSBh0awG7vx+K9ggDIP1BsQPwuZHaM=;
        b=qWcaMzaRKUf8DE/WPaTnOgu7sF7Ky8TD/1E1qqA0JzCl5n+yI32dx3FSS0C0QiVuTh
         IaJ2ADHW4dyVIuKqnFGVgZORp1WXAumphd799ui/R6BM2mgux9Tkld7fW9xOqTpnPJwr
         kR8wtKmqqPXNdL4ed1LE0eLs2lCZoLxOC10hF0XaOkrOj/KcR1PNKEDsCKbhbFAZQYfH
         s1TzbEBIOO3g8I4FTBelTKagHQ9x4T+WQ95X8GsPp7nRJZ94WUOiXQB3aObWqzWpzHDW
         3uZNly+LTWfmpRWmZQ4ElgzbYyhXPK9uSn8rGZ83WKWK1ObbcYlEFRSZF793mLypfk5S
         9zeA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHys4H8cKkTy6HvPYOYDSq7h8RvRyDrUfUbrvflXBQMGQCNxZJxTnY3l7phVjDrUPGgkWwBbRW+0+J5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1N/Sk8KQ1tkjozkXFyr13H4FqViqMgyyVJSuh9+8feAwzWprJ
	IX5tZMhuPPWPnfVEy5k8yvvxePh9RPK+Jh07to5jBfabNEGCv8YNbpqT+5VUPKz4Yl4kIKBxlCe
	IBYdaYhliL9Gbm0lqyMZljA8/zpTOePixcu84Ljbf7dBZ4uY4rvew6kBx/rUSNGCH7IM=
X-Gm-Gg: ASbGncv1WemxaxMLzhhbnFn07rctNK10Z++JhCwSfqUI/3+RAnFY9TI6hlTxs1kcsei
	D1W16Zsf+Dl7TCz8q8paOvbGgTaSEKYfhJKJnCskWRgwhmdjiDcElwgnHnl5rYKaWENyDiJAhT4
	uTjQPhGaZQxf5ywiCJvt32siW6pH7qee+iWfs9VqQqFDixO7ZR/fMFfhz+rHxWw3DcKL1jCf2va
	fjuygLhILblYYmfF6gwpGdeXHCh+wVPkRvZchyzr1ac2x3+/v5MO0C27A8PcxzVXNuzbEIzFcYx
	F6UFz5qpC+XlPMjDlpSpo+4y1qIvuA9oPsyw1rRJvNYFEJjscTZo7ZYqpjwABt2YGVDh6fh0dYd
	oE3UM8o+tcLmogr/yUFecSw==
X-Received: by 2002:a05:6214:f61:b0:77a:fa17:551d with SMTP id 6a1803df08f44-7fc3b6e4e50mr25098966d6.4.1758790453974;
        Thu, 25 Sep 2025 01:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEakorkSBLEOdmThyOJ8GN46Tx95b3JhSL9S+j7VELQ35DZ3Pi6IlfY0vmurV54vCokfN/+Bw==
X-Received: by 2002:a05:6214:f61:b0:77a:fa17:551d with SMTP id 6a1803df08f44-7fc3b6e4e50mr25098736d6.4.1758790453344;
        Thu, 25 Sep 2025 01:54:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af4bd5sm831933a12.36.2025.09.25.01.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:54:12 -0700 (PDT)
Message-ID: <6f8583e8-2a73-4795-8eb8-5f1b763b36eb@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 10:54:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pd-mapper: Add Kaanapali compatible
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
References: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pUqVmDZigYSJBgpYK-6Rb-YFrUJDpsGL
X-Proofpoint-ORIG-GUID: pUqVmDZigYSJBgpYK-6Rb-YFrUJDpsGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXxC4RN4XLs8Q4
 jMJE0UTrvtu7Ih8KHKJb2+9ahBqZh9lwnUWyXHQ9kTiuFKsHH7hzbfH+BOZxw27byyse939po6x
 XSiRW2/9XjLUIN/3pH6BFhaLW735iM0SLMjMb6VMFYOftzRzMrX5D+y7sCZ41r4iaO9PWoaNcLz
 Wju6qCE+QwLfRK4fIIsMcdA9k9xdtIwlgDS69qN0oE8cX8kiW392fBf7zmyfqV/QOn5SpS6U1ci
 CO5ujXANJZEGx/8FvSd4tOk5BHdVbLTxBBQxVzrJtiPfIQ/IkhAn3rUgCy0sxko/22vRXAHdK3B
 IM2ADV+jGCJVZqvfY3/WRDZhfC0/2T5xcQ2l4qPvLE1tKHp5RR568tkwoF21PC+osyG9AwWMX5R
 zas0rzfs
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d50336 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YKJ5hw9_3qAu8eaH4PMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/25/25 1:58 AM, Jingyi Wang wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Add support for the Qualcomm Kaanapali SoC to the protection
> domain mapper. Kaanapali shares the same protection domain
> configuration as SM8550, so reuse the existing SM8550 domain data.
> 
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
> index 6384f271953d..bb2eeb955106 100644
> --- a/drivers/soc/qcom/qcom_pd_mapper.c
> +++ b/drivers/soc/qcom/qcom_pd_mapper.c
> @@ -552,6 +552,7 @@ static const struct of_device_id qcom_pdm_domains[] __maybe_unused = {
>  	{ .compatible = "qcom,apq8074", .data = NULL, },
>  	{ .compatible = "qcom,apq8084", .data = NULL, },
>  	{ .compatible = "qcom,apq8096", .data = msm8996_domains, },
> +	{ .compatible = "qcom,kaanapali", .data = sm8550_domains, },

Doesn't e.g. 'msm/adsp/charger_pd' need adjustments with the move to
SoCCP?

Konrad

