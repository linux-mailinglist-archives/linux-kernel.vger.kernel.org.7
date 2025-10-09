Return-Path: <linux-kernel+bounces-846997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF921BC99EF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29A404FDC94
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F9D2EBBA6;
	Thu,  9 Oct 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZM2f7S7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697020B21E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021278; cv=none; b=utPfR2qSjSBEDM0zTN/Us5JRrJ1xZCUSh3bBdYhxGok8VIxzE+8mILq8igY9hBobF+Yfk8fwLxaQAoxswrzWZt1WW+6fpKyw38Mw3EszRsEFjD+cUZrWyYgBjTBQZ0uQbcVRQV2S1RcNGSkkzXR2nGiN7sB+/+crdWlEAqKxExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021278; c=relaxed/simple;
	bh=JebSc/8bvcUimgMsNd/lWd6nM62WGBHCTAHCfkSxQWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZI9TxCuA0OiEUtBC2I9RpltG2EjSWiG12Pra1KwHuPho0u67Opp8zkULhIQj+Vxnf4s+/rEWOtY7QElXBHFne7Ljkxgq4mMQ/jDnWu65wBtL9yHTHT+XbGCQ3v8LSsZdbdogP3/RE/vPqpR+p1ujT78r1QS9nli0aaTBMtNl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZM2f7S7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EVURQ004118
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	keuwE60fL3CMGjPR1k/+ByDPG5LTHeSrV5RbukXg+LE=; b=SZM2f7S7PIqjbWJ9
	+9J8GwCkD1+bfzo2VJrkjNyx7Ezihft6ecbEG8trPG6arcDuw7BNYQxO27S284OS
	gjZ13Fyd1GmPsKgRm0mdZ1SOkJEDF82dhQ72fELRXjdR8uqfI/j4a5qCnb13WyLH
	ghb0Oag1ARok/vHkoCwfVVFTF85QuoixMONNjR53JXfateJqdslvT4w9i7Z0W/uk
	Ms3iEfoCLvA+9zTbn0r0TBfuM1GxuR4eyVsa21F2DvK+luw95VfEnyHK/a4z7OPU
	waYNpKqvKZl8jajCxZQ5Kr956BcH9JKdkEmEX/7LOgp4Mi1flYrqP3SkQOePmgcc
	JFwNBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j38xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:47:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85d43cd080eso44537385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021274; x=1760626074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keuwE60fL3CMGjPR1k/+ByDPG5LTHeSrV5RbukXg+LE=;
        b=RHS7vmm5YyYsrNQkk8Sf522ANsBqhDRmRYCeZZI3BhQWEvFFXgJnQIm5/RMg+f8wDU
         KjGS25R8HSVh3mv/jIxD1GVplQaOhdvqgJxGCX6zlPXILFKiMFFf2Xk9a1wTuNiYg9wr
         b9KKWKIyUIbClxN1VLEPM/AS8ClbeAp7iq6TaTZH1u8wo2lFmYLTEEASlOmntZIGpGL1
         Bcrrs0B4lc16dgpkWVAc84TQACSl0+4eGd7UebhAxjPM8bvWhWKdV+HjQyLSVWvPJksJ
         E0OXrtJxg65N/YXgXWTxrb3NWcNXCG+6Ew7suRtTJPm1u7flGB5lsvgQkkHd1wdKcpTI
         Ryqw==
X-Forwarded-Encrypted: i=1; AJvYcCVmMei5SSg/24MvuNWE157L96To8lSSM6rshU6lKAlcgK/HbVWeFFZZXMVT3AawnlDhnonAkVuHJDZOYDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bqTz+iqyzwHCIdlHKFMli9Rec5Ljtv4k0DzRrf1FTUvSTJor
	g4pnYULjKUoijeQd/uSX9LodnpCAAmyN85wIH6m+W19eqb83XxSIFxDADcItNkz/fLT/R8KrArJ
	4FpYCizTbvPkrm25zn1C5UsZhwZPFum2k1ts0gPNHBcvhwyDQAcS+E5hTMtiEMtkCHlw=
X-Gm-Gg: ASbGncv0kW4tEny8SxsF9nSynd3yAj5edfDMu0aX/BBj06/qKFweBYuGPwaSxkXKsEA
	XOakrEpfajTFDzcctGAKOYa1YnQT2CVdBOHQ1LH539H200p5xGjkQvpuuSM7GZLpzKJToxP39Iu
	ka226jzfz21DZggK03pwyqlOTx2Iv7Tc3FYLROS3UBGia56HJNNCO5yBLsam5AvMinLihl8fxaB
	+v1yzyXt+Y/cBXOI4ngId7Ikc7TGWyD8RPnH6IiqK9xmIkzU7+fEm8Ri5kFn/HrnhuR5wojkz1x
	t6bX+OBic99L9cyAGeTWPo9tyhxOk3SAUm03fzTNiYmVqcDq/o9uQCBNEJsWNF1K8wgBJwIV8qb
	x2bpYzY10QcjftiV1O8pZrXspQRw=
X-Received: by 2002:a05:622a:6788:b0:4e6:fa1b:3c74 with SMTP id d75a77b69052e-4e6fa1b3dc0mr21484071cf.4.1760021274315;
        Thu, 09 Oct 2025 07:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucPuwt48acjEjaqleOEWnw/8ACTq2+92kgGJ2zdigPQCuo5wdaNFzwbwUde+dJsC4Wv8fgA==
X-Received: by 2002:a05:622a:6788:b0:4e6:fa1b:3c74 with SMTP id d75a77b69052e-4e6fa1b3dc0mr21483571cf.4.1760021273550;
        Thu, 09 Oct 2025 07:47:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7c47fsm1928735666b.37.2025.10.09.07.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:47:53 -0700 (PDT)
Message-ID: <d597ca50-c52a-46f5-b884-17ab8fa780c1@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 16:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW
 cam actuator
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
 <20251009-dw9800-driver-v2-4-3c33ccd1d741@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-dw9800-driver-v2-4-3c33ccd1d741@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CkAOe_ijFB8FBncZgyUblheQANw-8a8-
X-Proofpoint-ORIG-GUID: CkAOe_ijFB8FBncZgyUblheQANw-8a8-
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7cb1b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwotLCA55hXwW
 AbP6vbggjDUZNujvo/GBda7oljfShWsVwo854WgfSNx6hKjKVyemMKZj848WQffTspE0fJ6TbHv
 sV8VO1T/pPRNfIYd8G4sTyjGrPT5J8uGj4wFE9+nMgD+eanr+74fTgOmaevr2OYIPAfd/MvadY9
 iFeaQlpPYG2th+KDXONh0Lm2awgnweVbHCkd3oQiwk+j1s5FtGqD9EskozxgNrPJ+3t1RDOjWFC
 imrIADWPZjnQRn3sGxFuHsfUlezJnum3Q3w5WGClvTVbbnqwN1XZRzPU/jJJ+RpwMf/v2P7pPwO
 OfuKje/VDkQOnaqEI0fWBSuB9cw9F3e4ASBMD3R+RU+KdLZQjUs//LzClBlP2Wx6z8ZlXQLTH6S
 8Qlrswy0Te7f9RJ/DyW9ohhCcAxyrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 4:35 PM, Griffin Kroah-Hartman wrote:
> Add a node for the Dongwoon DW9800K actuator, used for focus of the
> ultra-wide camera sensor.
> 
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

