Return-Path: <linux-kernel+bounces-875591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E54C19652
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E434A4F87FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEC3081CE;
	Wed, 29 Oct 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZTLtbVI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="diWlTxH0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F532861E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730531; cv=none; b=iQAVPKAbGIB8RFEuti+ly6HcF/NQUjtO+YRJVjTRdS66T2mT2SygeE+PC8x789UXsjTCx66Syn9KoIEcIWynm6P9gu9CkLunm95hMRzYsa/wI+0JXJp4VREO5jFClF4qCYcKgE1907iwDs5uco9RDyRh5Mfx+jHtTjuYualQoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730531; c=relaxed/simple;
	bh=NgfyWXD4ZMuCkyaN3+/uoeoSemySMrT4tQNuxgJ6Tl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlUxPsabeWM3YEncqqJm/uscLxBouSvVhqLKzOHEhhkJdW5DvwsWNOzndeYfeGdpdtJDHM2iEcjuoIZJMRFhCnqfx5TUxdJ7UlFW0fRZ1+ymZEfq1hlv46U5xYQt53l5k0gSpVvI5yygfy1wya3o/xBlsTJ5XcZKr3QfofD6BWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZTLtbVI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=diWlTxH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3Pg3755366
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJeGESJ/n35Xq37cXnQAMlzhqerXJpjFv7StBPPW6Nc=; b=HZTLtbVIfaBwHupY
	1Gdt5SJCj7qX6I8zBP2cMp3lCgpuQh4uFGHmpTD3MOtoCEqeD5mbDUbMgFcVK9C/
	Qh6EPwOd3JmmWBopEa821c9asfvR62YsFGCHzo2+I8bordxus1H6wutc+ZZo9ci4
	eWQLIfPpo/hiHaeHB+TDn3cf2jP1P55UP9BlnbsB9ktNhsXKz4VBWnEnc73DmsiM
	nrXMwBI81mkw6v23ScllVWHIC+S3EmeQVXk2SoBRghcpfBwaMkx2gDrxjGjWiIzA
	Wj11JOM5iJrVkequeioJNMo8MWqFPhqoih3yuHcjcRmNBmmDcDdLYpCXeiIzN0cx
	5gQMug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0j0nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:35:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eceefa36d0so121941871cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730527; x=1762335327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJeGESJ/n35Xq37cXnQAMlzhqerXJpjFv7StBPPW6Nc=;
        b=diWlTxH0oibIWIoCpYXEAb1v4UNn+AcydGwRWs34tHGNsH6Ra2GnRieDNm2xJkc9ra
         n0+2QalcIGopycTpjwCHpbnfeqdzcBcFxwB3Inn5m7Mdn3tfqJSnKzowfXFRKP9cYSRp
         mGJGgzfKm2P5hRTMIpBRXk49BWAmyYVhlHGNcTf+qN1MFXTU11PQURwOdEC6IPaq9Jdq
         c1aOgF1NUP2tWfbuW01a+PUvRtRAGXmcWDilYDGS9Lo4AEoB9nzn2zstYby+KLNUnoGH
         DSxL+RibRyhhFdZup4WTzEci2fv/nHDrWG+U1QLFtGTKNAvHC2iih/iLhzs/J3I1DFmY
         nCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730527; x=1762335327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJeGESJ/n35Xq37cXnQAMlzhqerXJpjFv7StBPPW6Nc=;
        b=jxjbkJUjnF5KxGAkgsgUokXXDP6TFY0N4BrSBCtP0m5T9YhTY0S7MGpxnIC415FoLu
         LD7g5iYboSzrb43Jqz6wnX583nHdRW+UmamFc9zXr21Wy2q/gIjwfhlqYTV6z7X8/9dK
         0UnicBlz8a/TKa7D7OpywS/N3/dONHQkPA9IqFiwyfj7P54k4PjE6J4g8iYZtVRRFKjh
         ffzACHbErSUwi0IfaM+/rSUKinY9bFTSGRg0/UR+xecqxj3GOharRbZOU0Nkb3XJFlzA
         e3zPWHcGJU8vqxYcODer7A5UHXzQzJM+WZuwRNZ0uxwXbUQOpE23r3y8RTyYWGAgZ/Yo
         pUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw61MC1MGzumNJq3WotC+DWL9SM7AG97iyXEfAsdAZU7W08UC/oCY408OrDHu1/ZaUl6lSp1y7XXzjZwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqlv2jRrvcMUWjzs25O1TbPr3AgS3egppEKF5oZXwPY3G6aufO
	b8P+z7wCxBT56uUK0n7rqeVJFMjLATRG0XvZbzkGRu+qvUcoOjuLSSO21XK9qIfyHjk//2fN+/g
	nG44TwLNE1i3gPB3D6R6FghigVNLI+xzAdBCz7lK4pSQmcO/9jWj/hsIJHsayZwITktE=
X-Gm-Gg: ASbGncs4XsKRRyg25ed37BRcv8Xl4uSTCP7iZy5sm/CLhyoKbK1yybikgQHM/Nu69Ha
	uF9AF1/2S8a2rmd788g4TP2ldkPabKI1swklDP7FYr9Cfbb0U0IMg/+ve4jhrpiYfha9MF+ggwm
	x8pjUTHDVPGRz40PRd7CUH+nGp0HQVS3W91Sshf+nujK3EnFIm/d3NT4nxn/vmXisMVOruvZO9t
	BYQAFIs0f5HsGq3yeCdoY45qvoqzmFzH9hH2F7bx6bxSbeG8bx7S9ZWo0AJKbJjPOX0YotgdiVz
	9jvUZzRkOn0knnh+NvbfwriVfLn0rtHdb+9WUzaqpusoPOB/WtZEJhDVz18meaTTrbM0RdHobWx
	ySxKVja/o5hPoqCk8jW7hIEygv2oglLRLzPletFtpC/Wsv0MKczSmAbjiZ4crWnOO6wSuoxMADZ
	R3SA==
X-Received: by 2002:a05:622a:56:b0:4eb:a2ab:4182 with SMTP id d75a77b69052e-4ed15b5970emr27737521cf.22.1761730527377;
        Wed, 29 Oct 2025 02:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrRwSSecdIRfs936+1xe5RDYK9h1uyw0BYIZUGcu6vRuRGwPaVc++qS+lMTWMFUdJMj22VSw==
X-Received: by 2002:a05:622a:56:b0:4eb:a2ab:4182 with SMTP id d75a77b69052e-4ed15b5970emr27737401cf.22.1761730526925;
        Wed, 29 Oct 2025 02:35:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941566452esm133254e87.8.2025.10.29.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:35:26 -0700 (PDT)
Message-ID: <51f10d4e-3962-4c20-9d5f-afd0ac3f598e@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 11:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] arm64: dts: qcom: cleanup GPU's zap-shader node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <c83079bd-ebd2-49fc-ab62-1fba08276cc4@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <c83079bd-ebd2-49fc-ab62-1fba08276cc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=6901dfe0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VH_4oVhpAmBFcI_Eq3kA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: ZYL5zgApdXc3GR-ndYNNnhPYI9OXQuvz
X-Proofpoint-ORIG-GUID: ZYL5zgApdXc3GR-ndYNNnhPYI9OXQuvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MSBTYWx0ZWRfX6fsRbGgszNgD
 xFZ5EV/3exdQlTyNtyGzTnxdjq9Urcqt42E1rpYefwCF6kfMSnP7qT0gJWCgbd0MgPqDjUPp+13
 Iv2RHyzKuR4ISFzHkTDV6FmeXobLkhzn6/9sreROy7+45vO4cnxjy0enQ/GfF21pdScLXehQVV9
 CWlJz5jEseWURw8qSsBIAKIfAgzsjj/mQp0SnAUmDYUwLDSzlaTjYPCuOBKEN0fAC592rMDGNa5
 S/O/UJ8TMUKMu2lSrocCIxHXT7NSwtoj3PWKoytmfpIElqcBOqP6KN8I0yw4HkUAQvmPGCwU9zy
 QZgR1tBMq34fEIbcRdhZ17P/W5Eyg4ICgO3jTtOi2QtpQVmqLC8d00yo4w88wMVFb8Oeq+vsFLN
 uge321OwKmvj98qnURx0tNBIbU6h1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290071

On 29/10/2025 11:33, Konrad Dybcio wrote:
> On 10/28/25 9:59 PM, Dmitry Baryshkov wrote:
>> Historically all devices manually defined GPU zap-shader node in their
>> board DT files. This practice is frowned upon. Add the zap-shader node
>> on all platforms, define a label for it and use the label in order to
>> patch the node with the firmware name.
> 
> I'm not sure this is much of an improvement, since at the end of the
> series, boards still have a &gpu { zap-shader {} } section, with the
> inner one not being referred to through a label, which reduces
> duplication in the single LoC used to assign memory-region, but
> doesn't e.g. prevent typos in the zap-shader node name

By the end of the series the boards don't have zap-shader{}. They use 
&gpu_zap_shader { firmware-name = "something" ; };


-- 
With best wishes
Dmitry

