Return-Path: <linux-kernel+bounces-838579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE0BAF9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCE7AD8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1527A465;
	Wed,  1 Oct 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2DiGUIq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B51275AF5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307272; cv=none; b=t9aEQ3JufjzLVm3DfJmGQftI6+Wk62XdgaZooGViKRVT3JIIJ3pQA8ziKRH/6qVtMMMJud5XXmYuNnPKWms/Ph+MckZ2jJd9PApUUOezvTzBUhNuA1X+FQTova4ubZ/3XTk2HvSEvrJNCPXYWUilYrRqWMSD7KzMFujiJEOVTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307272; c=relaxed/simple;
	bh=eKDxOd/8infgGPrJNe1yhZvRW2gOa80XvT8nyZkZHoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGavl60Zf/uZXzBAQ0ZiTeqkyVihjvx2Ba1F9sn4jzmEx+LhDLnB88YGzeuJnk8Q2+d5tDubhpDBw2B11uYDdPdDSy2kHbNCRJ2YXbuMkTuHMNqNeSYVfWMO++zjYoRjMN8mgvkyAa3XpYe+ArgwrQRaSEOanAmuKBMku8Y9Z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2DiGUIq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMEsvF016891
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sRte5Fe52kG9pSHQFH/MbokFPbtdU+9oG1CqeyDC+9w=; b=l2DiGUIqY7SdY4wo
	uRnMahgndNelhmGeIXksnIzQmSDntX7sHyvleBhZkcvSWA9BAXdFfCxHIifmB5sn
	rAeKldqI43SZ81O8+sIiIxs2AF+rMzPkTMNnZqq7DwZaCwFvJT6U1x4GOqlX+frG
	wjrqeW5biyAYO+FBPNdbx8VQayJLiJ0Dne5J0WYm0L0V7xaI517n2sPAe5/il6LH
	n9YrpZxgkTtTkeAm16s54jNBj0kgDU79xIm2WHDC62kqKzRSbVcVlpMj37eb/UT1
	xym7Vtdt2bP3BNhbFGABKLnvPfHS6G3fshEKjbnp4pjH0n3gQGbKAQRzgqxbr+IP
	TiVJAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkjng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:27:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e231785cc3so7112441cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307269; x=1759912069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRte5Fe52kG9pSHQFH/MbokFPbtdU+9oG1CqeyDC+9w=;
        b=Wnqcy41WiH9YGVb4QBzpu36Rh4jAf8qNVW0PapFnpFPb94IpRCXi9fPLxdQK0vdhI2
         +3m1cOVCgbTLjAvfJRqdsmM93xQSv7b042hF1UWLGrIjm7YKbTjo4qzub53Ii78mkM9q
         7TzypPEcyY7s84+b6BBVXhPZw4us+1Yk+ISkVUETEMRHKoKvSj3lATbd+ngyPxlKk4A0
         rfLTYEa0+vUAklNP/Pw0Tlh7lJ66DbgOCZrPd7wdTfAOgygoKCChowYIGXm7Maei8uqq
         jAvOUaXqnqYWf9FsbihUaCl8DsA3FN47bLG0XjlimNnzpIttvIivZKyEUrQiFo2bRHDL
         9Aww==
X-Forwarded-Encrypted: i=1; AJvYcCXAuKYb0D5FEbt56eRU9JqphgVlPmB7TraoBBBfnGItYz5DUv8OsNWVtBa/UuEq6A3718rwxafjBZAflQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOy6s8kgNNHED5qyBILsWnNRo7mYN+UfeeeCcUR6xByyyKBHXk
	1xVVTuAw04WmA/6jXyVj0tqMryemmBp2JUwpNL62Ost179jtS5viaRRu21nnzfXOGFouI5YgnnW
	9IEiSGur+vP5tigQ73qxYOE9kOKoybkoHrOU9a+7kL8cC3rRq5y2S3bldKNNJPD6aeKA=
X-Gm-Gg: ASbGncsXFc++Qvr09hdlp4TGVId6con0SwjpA9XVLQ6GccuplmvIDF06frXgj2NRyJm
	opcdcfLXhdzvx3c2+tQgyb1Uk99+4dFUpyqwmCx/Q29LYJfDy8P+4pR5xBe7loq/bQinpK0RuBe
	B3rtV0U35Y3ffNhJ7WrEIuCio7JSxPkFKxq6EEwwWhJu8YgG3RRRZHiGPOBcQ9ECkJPGdwU06vA
	2JzD0HSPqyMtE2xTcyqb991gUOCGksuKZe7mjfuCNWP9NeYD86KBGtkSZVnoSLVM4S+EIn28xpX
	RFY60ghKHVciWhf+e4bHdeJIrJszPY+ZHPbI807dSZByeMfjqXaJZ+mclpSUg+QSHv2et6I8n9F
	RHMXxYr6GXTmZhCVDE8YENwXVzqg=
X-Received: by 2002:ac8:5e0b:0:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e41c547752mr22283461cf.6.1759307269180;
        Wed, 01 Oct 2025 01:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGazXCpf23PMH4PrA3/BHdRst7lhfzNEub7Fo50BJ0w2oAO8PQN8uTngF/EvP3RGSn97sQEKQ==
X-Received: by 2002:ac8:5e0b:0:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e41c547752mr22283201cf.6.1759307268641;
        Wed, 01 Oct 2025 01:27:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3b4271dea9sm831995666b.88.2025.10.01.01.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:27:48 -0700 (PDT)
Message-ID: <7b1286e5-f685-43f9-a5ea-c82a3ea8a1c6@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: qcm6490-shift-otter: Add missing
 reserved-memory
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-3-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-3-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX1ymfPFb5JA8c
 6jYjX9PbJ+V1Ziuv7BA3MvARkgz1abHO4XOBgxJoUOSMFIMb9Ts0vSIPwyXB6hrVMRHVDukcqkB
 kWtsL0A6Dq6M2mOXBLHUx8uhN+57DEv5EZmlpx9o9OR6thA8Y7MAG10C7zYsBnN49kFZz9qlgOv
 55+K5qY03y57ROiwUNnCeak6GaPI1hLGxjMzPllc0jIIFMmA47rDS0KlMgovDRGDpYVa1To6K5v
 rjxVqZ7b1xjmRxdhphLCgTXBQFjTZPyqFC91ravAisC346aSFvXvq9EQN3mwYdLPllMhNh+J1fD
 PCOGT/MWtkkovomzCj8sljrXlGxGQtvqtKJ/6XA5JhykMICgTUp4onVgjU41OEpeK2sQxHP+Mcw
 LQMx9jx/d8JHrK+1r74InioH1dVDgg==
X-Proofpoint-GUID: nxpdZp6DMmBzakq96phnjLwMC8N0-fbq
X-Proofpoint-ORIG-GUID: nxpdZp6DMmBzakq96phnjLwMC8N0-fbq
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dce606 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=Q9X1YL7jsAXwpJAzmCoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> It seems we also need to reserve a region of 81 MiB called "removed_mem"
> otherwise we can easily hit memory errors with higher RAM usage.
> 
> Fixes: 249666e34c24 ("arm64: dts: qcom: add QCM6490 SHIFTphone 8")
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

