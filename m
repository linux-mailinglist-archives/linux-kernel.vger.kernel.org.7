Return-Path: <linux-kernel+bounces-894835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A722FC4C32F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587D81887CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AE2D5930;
	Tue, 11 Nov 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGini1GH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cauVxr1x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7F28935A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847784; cv=none; b=oBLJtkA52REx1+o58WeBdpXycu5X7Nf4noiI/dOIyes1QChX4fA+8jHUIrIiKoocfq74E8Yu4N6XjJIPiUuZveFBAUV4HvgLqjZkshDKi7J5lqFIevIFJ5D4f804qqSG5ST2rqOBG/+nzINyaXPtI+VJUnKLY3EiMpnVZ5UFp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847784; c=relaxed/simple;
	bh=J9dHV+srVdCfKZ5lu2pApTYLFYdNVofhwohGyFX+2uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsvnzH7ozXJoykVIfInlIuUCrj+N2Nf90T0q2J8chcUwG0TK8CvzF5xq9Nq2UZ64S20z+zwZpAsCzHzvmU8YJCjAv68Mj6O9MlTM98LhvOm9dmbLmoU1BAks2C2xfCQwX5GNxT1xbE4cYwnvtm41oNG4jla6HXUiG/M46y4Huyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGini1GH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cauVxr1x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB1vtOY3985681
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=; b=dGini1GHVtbvFhXN
	MA2eDCyeQ+fpiiBRaF6XXD4lSAnejs6QZlN4xGYbzweuC3TWIXE2ZADR8NchmrVe
	K2Cq4t7KmqkcAo4HMFXZL4zqo7oSVVbORLv/IGBPDkDjPulbMK43/BOSNk0bYlDl
	F+C4fNonshs42PPEWlnX3i1T+FVH9tiEH82gJbuo01+Gndn1uxDv5AKlLAx81Q+b
	I9XcvsRg94cyIqfT/afxLZ96ONeq5XVSwyVPQIWU1bEs09U6GyDLVCIAKk6gHbmB
	QLr0Ev4MrH5NGPxfvA0ZxI3eY3t1DYUY1oFaGqcNtlA64p9tiIRWhWrzw/k5T4Mg
	duVNwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqjdwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297dde580c8so73668055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762847780; x=1763452580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=;
        b=cauVxr1xK03+NOEJRNuYG5LNyIfJjmXZ6F1froHS4skn5AYNADTWaeduZPQU1jH8OM
         SPyJS2dg46QHTHWsCfVSLdPmVt1+PiZ61Wn9X+msUMde7D+vR9ZGb5cn7Nfe8L8d8KyE
         EY0ESJu17KOPglL1rjBtrAJpbwBHwGpy8ZKaSyAWdVLubOYCpNcdnZrToHdrdYXHXHqi
         i4SSNYb/XKnyLZbh7uLjuNzlO3E77mnqOiqj4qr08/wLwoxazCkreP+hmewvLSY0Wvv1
         GdSY6ZmrHbZhUEk1f7vJ8KPYx+gjhhVhhCzCSFmJa3GM5KZcricl/75wcCD7rqB0d4lz
         zAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847780; x=1763452580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=;
        b=mK8Hnt1r6QnRr5HLE2n/xB/k3HYdCDZXIrQ+YMDlazK/++Mu6RDTI9fFsBrwE6nHP4
         zYwP9udIERzXuM9xhhfGeYOGRZyikPZ8BNZfCMtPSCqme8tJdwwB4C+yDXCNAVzUGYXs
         bWu8LQfdw1S3HwiqhsQ4wLUieTdHbBIV6GBfuHmb7gRJcumcJKtNzsbGsD1TVljif+qB
         EichgM4Nu9LEptQSVKkBS1x8QYUdb9Ay8+8wtcU3Ae58Zuiy5JKuWg24u3XH5iTZs7gt
         bHpQnZdsxZTwPmoJ26mnX5jSKvBLxC3FmMxNdlFb7tVcAJjazJ01H3wJsZw4lYGru4PB
         fakA==
X-Forwarded-Encrypted: i=1; AJvYcCV2InQpeMQFCDGyk+z5r17Z33CycBPLPq5ohM7u8B0sfH+YfMWsiMFcNtU695yo5bEHv8VRE46YM+qEKjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPjU9RenlQ/ZpdcHcBV2E7Cu2HZkQ5yQseQhCkkvKXRZzMCBy
	I4lYDvJ9aUC4N35Df7dS5myHAB0m9rqfUIMFT6B7tJnL6RBlXT3dwqDCGmna5nxCFoOVOc41TSP
	z355K+IDCiEuTJNvN0aqzCzS63sO3Uht5IANuSbFl+2FyhWYkXdg61vAISnL9BfzsVEg=
X-Gm-Gg: ASbGncsEimXNqb9799GA20f0qnRY3mjVwpMu7teNo8xtonPcLPO4qQe59l0qMz4Ym94
	eAKzwxUs4J5l9AMMKgmhsFdV+DtuIGu02tTJqkg+DgCMz2XD1qGoN7fqYo2kjuj4Cxnas4znQuH
	3FkQRejabE7HyZvcNHbjEshm7hkyloGJBn5F6Ox041j7k2z+X2m/DTDCVSTAMUxBC4/h917wmg6
	Uao2wVM9KPCQDMITfmGuEd9FMdyiCMVkjdKgu3P0XBsq8kLECL3i003syfVGnZKwVncnXec8Cpu
	B9R413PEWx5dM9i/FMU8s82RTTgY+J3kTvRqd9GV6YWYHw9EATrtQG49Df9LhdVPqp+MuY/kG40
	+T7ies8yDh0HsPzPkOiZx+QdLBIM=
X-Received: by 2002:a17:902:f64f:b0:298:1156:acd5 with SMTP id d9443c01a7336-2981156ad51mr97475725ad.39.1762847780288;
        Mon, 10 Nov 2025 23:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6hrGKFsEODF67hPKuu/GXPSRhYuLLhxF+PyTk/xwREJ4g4uK32OyhVOg7l+TWL2LTnadutw==
X-Received: by 2002:a17:902:f64f:b0:298:1156:acd5 with SMTP id d9443c01a7336-2981156ad51mr97475195ad.39.1762847779368;
        Mon, 10 Nov 2025 23:56:19 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm169109865ad.24.2025.11.10.23.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 23:56:18 -0800 (PST)
Message-ID: <fbd49b9e-5198-4825-a601-cf2b446f1150@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 13:26:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MSBTYWx0ZWRfX3g6qqd3hMPxa
 iHiZbAAwIU1G4ZV7AoKxVf682yWqfUgrXUrkseCDKTZpsQIXAnN/t4sizlUR3u2Tse+AZ1n7wCj
 l0HHJ+eGHNRisG4wm3Fuw5z+lWDmQ9dJSFCJyAFT5ns3GacdR+3fxjUgg/83ViQSQGDBRUBw8J0
 AWURPZIOSSfJbuWCL0HJKHEJbvvFxvOlrxqW//oNbRh7ffVLS1FXuSsvFlsK+Idgggo3c6nymw3
 NLAXr4ftKgsIGwMOP/1qBNiYzWF9Bc0n3NcIp8lc+vUWcFKtDs9j5PMZZAt8NjSsdp8HV2YCt1l
 z5l+ECYn/9Xwm/wbsXp5aVo/d/E2OpqikDp+NDAsEn6Lk+x+GmwAzU41u0u7VhF4tDwojZJ1Rqb
 Us1nR+6KU5guHCoIpIQ/TNu6NTxNtA==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=6912ec25 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=K3xFcsKITfcsgejFPk0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: nRSna1lAXfPAc1hBFfVeq9UgTWQ2J7Cy
X-Proofpoint-GUID: nRSna1lAXfPAc1hBFfVeq9UgTWQ2J7Cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110061



On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>> Add ACTLR settings for the device nodes with below compatibility
>> and is mainly targeted for sa8775p:
> The commit subject should mention it's the lemans MDSS specifically
>> 1) sa8775p-mdss
>> 2) qcom,fastrpc-compute-cb
>>
>> As a side note, "qcom,fastrpc" compatibility is already defined but that
>> seems inept as the devices that will be attached to the SMMU is going to
>> be with "qcom,fastrpc-compute-cb" compat string.
> If you say it's a NOP after all, please split the fastrpc change into
> a separate commit explaining the issue and removing the wrong entry
> 
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index c21a401c71eb..c76f6076f487 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -47,6 +47,10 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,sm8550-mdss",
>>  			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ .compatible = "qcom,sa8775p-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> This list should be sorted alphanumerically
> 
>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> This will be globally applied to all smmu-v2 targets with fastrpc,
> starting from MSM8996 ending at Kaanapali and everything inbetween
> 
> Are these settings always valid?
Let me separate out patches for mdss and w/ more details for fastrpc.

Thanks,
Charan


