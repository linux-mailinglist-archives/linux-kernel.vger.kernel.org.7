Return-Path: <linux-kernel+bounces-895567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB8BC4E4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C191888A49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94767307499;
	Tue, 11 Nov 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hf+dU4YR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="emR6qel7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DB305E09
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869762; cv=none; b=DaQ43hTNaJXS/pEEuBCGVP3z9w4ZzmBiBjnBpWHj2VR9i8W7iptVB2eEpxIJlXy7wUrXO8ZGrF7Ygbf9Ts07PQYmwaULS88+ltq8Jfa930z2yMgbPHW8BXA5iqIJNbrRGfQvgpwT/hu2/MWy3IzvP+RLdcVVIJ2s+O2Jeuo+oRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869762; c=relaxed/simple;
	bh=3zBadCHd+/KC7ZT3xoUIUn7dtJivjsgHW8BdJhLYvtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+/55PJesmiVDft/4zmC2WqqCIkeJERxD5nRki0ANBXgg/aUaisG5ZEKR57z52o6QcZrVh8M5iS1t6ePPMvc51hyhO+6csICydJORIcP0aAG9KElwM3+Nn3gZbOqFpvF8SSjevC42QoWoB09hxCRdGZbyTvezDf2ezzvh/siHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hf+dU4YR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=emR6qel7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGWux2129971
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=; b=Hf+dU4YRLIcNKlJ2
	gsE2oqcvGqftfY55dYlz2tvEImqUMg+zak1iZQw0gFeTs24slS4jAFe6jb8f8+s3
	G/bJSaTa8zUmXad5g3x02ijwM289tY6YlMfeaalZxvaNKGl5P4BpkkPOZ7VJtzMs
	itGgCaNkaiHDoIrhUakom2LYrr/timiYMyFOOcvpgbt14f+xBXvlTkD6M4Jn4zyL
	a0+7M+Qs5gFTZLTR4x7omxmi6jhI/j6dWkLerdIpheuOA4yMwSZtqUSqEpYJufR0
	ckkMop/c7WlX09PYtktzACIcslNqrIZEk7hrsbIsryTI6WvIxtWBYAt6x099Zx2n
	Se3/0w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthtv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:02:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297df52c960so84991655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762869760; x=1763474560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=;
        b=emR6qel7VVWnIURrX7J4nd2wKVUtkaUflaQ2QOw053ycVoyu+Vm98ng+mU1F4htMxm
         do8AFGmK/Skaz5tA18N3Th7iLMa4d8PVa9h3sCIVW5eMIFbL/gAKJ9AKeoOSgRakHMjf
         DYry3F5uGfOiRlEDL9d3FVaS7W/ZJPh4Zyn6qbfzVVEeU4/wg0L3Pbf+Bm7+NMygaTa7
         ZjotTURV35NbmOW0PhXACQripAczDlwf+bJ5mUeoEoUI/QXRk4C1XuzQZrYqdMNmPEHM
         R5YimNc3rTdLdgDkXyjHQFdyfsYivXLdcTKOG6fLeAM2/sSsDV+oXH1Nmp0Xzoqyv8Js
         IbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869760; x=1763474560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=;
        b=TFxSgGTdkP2gC1gxpUqpSI6NISgkb2nRPvzSmAgb1vad0MzhenCL8voupwBQw8FUcd
         g+zcAWeD9vw2/fGN4LxUYQPd6HZRVUlGygEuIkpmwbX1h7f6vJA28IL8pAT3P1WW4+PU
         ahle9LnAbJoY3ga1/8p5iVjADAIr4KhbKvuPHgeBcXbJWPyJCu9rdIcDCy8u9Qp1DHWi
         IeOjr+8t7WWu3pgTaDWKxb+kq+Ch4XIekuW9hvbuL6rTA7HFuIn2lC16Uxsq83yFB+GB
         M66cDpv6PP3a3Vzs9pzER2bqk4EnHAFSMv0R0bP6YmtxxjHOl9svNmOE3u/9ipp1v3tS
         ahFw==
X-Forwarded-Encrypted: i=1; AJvYcCVw1S1yODQtDbWiZnQ6EUjYG8zwudqfMsAQMDbPeA93zFeptTYEJ2yjwsuZjEep207S+pg4mRODeEWFIy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Pl7fvTfNkw99BC5IULSOIV/NCNjSJMc95fnt5aOvllZ/Y5Gb
	2qFvArHc66g3Ic+vaEu16F9g02e0zLu4kpiQXQX/SHHCH/cr6Zd+9Pr8oiHAXhUZx1CgwaLtKyr
	F99/lvwdPNyr490M8AVHL/Re5iQrFUdb3oQcUHnT5bxVU+mT8qtvkBVOsaFPilxn4QPw=
X-Gm-Gg: ASbGncssQg4C50CDrscFTqg1whOXFGMoNgNtpuqnCGYPx+s1QN9TTwL5VBozGXekbB/
	mXFZI70RS6IBe3EXJs3Sv5vLGiFTAhpAn4gwwGFjK7FpOmCERhH27ytQHsqg2GMpQ7vCw+DPHwk
	mEyEhkJtMus29pJekAc0YLD+29VRfsaVCtxxdNvaa2ITIBdyl/MLAL8Y+5otkaWLNu9bVgRab+7
	bHQgWLaoocB81qbZ0/juqyMxiD2X+ZOGAJab2vKxPGIn4q2m0y95E8xaZIsCXDOlSudUf8jZR1a
	mgEt4uWMD8kgLOGMC4qxr0DPeS556ZTc/DEOhec9EyF9OW6pgxC/QUNie7MZhLd91eTa2XAOQE1
	JP8ZEQtKA+i2E9qDdPO4fwNHg/6I=
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr148629125ad.27.1762869758216;
        Tue, 11 Nov 2025 06:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiZPxmew9Sypb7WTasJeWopHkpr+MEmcvloHkOX1op3HrOtm8qCTT3mhOislac4qaeDoTYnQ==
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr148628355ad.27.1762869757396;
        Tue, 11 Nov 2025 06:02:37 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff848bsm15461660b3a.29.2025.11.11.06.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:02:36 -0800 (PST)
Message-ID: <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:32:31 +0530
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bibek.patro@oss.qualcomm.com
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0LVd6i3M-qu1qcrNz4mzx3kPuzu7jhu2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMyBTYWx0ZWRfX8RjlQkxHiBn2
 /NCWdrDdA3vRL3zMfJ+Ul774dqWQSCxQhQhHdxuPJpxAS+MjsGbaZYMZwvPjVzxlm8woRNrhTjo
 0AwvCDGnhDpASzpLbEePYiYKWSVUflCbPcwNJs6hFTcNMDtOLVVKEkE1891UwQ+ZiG8ql6NGI4b
 7/TlMUrPvAU79WgJAaEsFWeCAtcVso1pIWTCqzfwl187MXhe3kilTIUvIopLKXb296TDJ2CcfJZ
 HpvZv8Odl4vqF3MBGqzwJJyPJWqWJZB1wL8OGKFr7lEveKS6kzviH09cXTD2pk5Gp9N4QohKmHN
 fLu5qMfcLS3H0x1O+YnCDfuRpagWvUETjkS6Fto0DsgpVBzzqqG7ZCJWUAjCSqhsWtguUyNRWpE
 GeJL3tpYcTCR4TZ1vQV0FfY4coQaGA==
X-Proofpoint-ORIG-GUID: 0LVd6i3M-qu1qcrNz4mzx3kPuzu7jhu2
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=69134200 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=K3xFcsKITfcsgejFPk0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110113



On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> This will be globally applied to all smmu-v2 targets with fastrpc,
> starting from MSM8996 ending at Kaanapali and everything inbetween
> 
> Are these settings always valid?
Oops, you are correct...this settings are not always applicable it seems.

Example: lpass compute and cdsp compute node uses the
"qcom,fastrpc-compute-cb", but it is for the later that ACTLR settings
are valid.

Then for these cases, should we be extending the actlr match array with
additional compatible string and then add them in all the device nodes
that require actlr setting? example:

@@ -3119,7 +3119,8 @@ fastrpc {
      compute-cb@1 {
-         compatible = "qcom,fastrpc-compute-cb";
+         compatible = "qcom,fastrpc-compute-cb",
+                      "qcom,fastrpc-compute-cb-actlr";


--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -49,7 +49,7 @@ static const struct of_device_id
qcom_smmu_actlr_client_of_match[] = {
+       { .compatible = "qcom,fastrpc-compute-cb-actlr",
                        .data = (const void *) (PREFETCH_DEEP | CPRE |
CMTLB) },
        { }


or any other better way, please lmk.

Thanks,
Charan



