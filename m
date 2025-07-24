Return-Path: <linux-kernel+bounces-744256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CAB10A29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E74016B4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D11272813;
	Thu, 24 Jul 2025 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZ/bUx0L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F451272E66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360100; cv=none; b=RCI9EsjdHoaYMsHGN6nslhqhpF74X87X6Ssi77Ks2zY3Ldsaj+/xexgofEqbTE87SBU2AJUNgZ8n6Z3zrrCKtGnAsF/Xbryco4DLDWqJnxXCm5EhHcSgicXlheKCoxVJVK8hLepfvAqiIieQLkWSZ/M5jHPW5vVBB4FSNXEz3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360100; c=relaxed/simple;
	bh=PS/lPEJP/kn60OGyrwca/Om4b/q/eKQQkvFZLz9f3ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIpSxqYd+ZUNrnl63Wo0LXDfWFUyV+nkTpCs82yZv+7Pr4RI5qC3go/XfFEnIWCwyFMn3HklhLufiLBpWh9aO78vm7fR+bAV/aPwTs8MxpQLjffMRmMN+iq/4ALQ6qGu59vRr6zzzBMVwsbHNtXg0tGxsdsx3cNP87pg6OB5OSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZ/bUx0L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9Zg6X018368
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3ZLo2+2fJPY4hyQo6fk0rzcySBaD74Pvdlk+MHH6/U=; b=pZ/bUx0LPrL2GdhO
	LGFAos+lPY+CucStSNNS0Q0QtErvK1AMHffPLteTAo6QOHMDrCmEHKrGX2H4f0J2
	Jwa2Kpoe11XAnXRUDD85F1bnXabd11GGSjuC36nAtKHXW1z2LpGPWVDjtMYHEPOt
	VxOEfbPWkChvXQb56bG9pHcLOHSYFpO646b2EuWCLU+gXxUiLW4wfXQP8M86Hq20
	XZukhASBRyMlsJqFWVgRVn86bEmwD3N+58nFWjlyzejzvOe19muWqOLdNrNv73vK
	meC2cSzHSfwA0zgwQqycn5l3/5xyv3j/OiGk2Vr/gr2do1zSls54VapgoWnjzMBP
	h5LWKA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3euhbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4abd7342386so1900201cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360097; x=1753964897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3ZLo2+2fJPY4hyQo6fk0rzcySBaD74Pvdlk+MHH6/U=;
        b=Ag6PMYKyY3glXdJG+yAJfexQgl/Hi76A0lEJ7R0Ie81DBoIqOLpJZH0rS0R4IxMucy
         Ovoq+06XUD5VRvB0W3qnDFCH//JQmgpC8fRfeYRciKpAvLBAYzLWdZEs7aL9UoBG+4A6
         rMu7ClAcaTBhooCoDMnTv5v31BLKIBIdBdp9uzuMrmXGGiyJs/+lTOw5yxANG5800o5N
         NgehlSpYiqs05FN4blUQ3UYRfvG9sOHTNU/5sQv/ICaPgbRlsb8EDh0foSVANa2PyewB
         Mf1SEt+wq+xtKevkhLRj2cuAZl/4SBWI/75H789DNMtoj9+emyIN/qgabAf71Zwo3YAt
         rQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCXOLDQhjjSdyIlNtXHWhHiETQ19L9UrRFKQND3HfKdG9oOLuqD2t4o/xRmmUtEGeRCcn8l/8dr6+pMBATQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhkxxH29bL87sdOtlA3rwfCQNQDLsnmgGnr65fRDqOIRqajc8
	ntMMBbBrRiO9PwLe1Xvil23zFlMy7EU40KF3+zbNH3Lzryt+HK8p4r1vksBtdbGAls8T455K1bf
	X00RkJTyiDCuJHPkYgQjWNJL/6D4887tFnv8inlxiVMajR2vWZI+iB3IE05DnBUY1P5Y=
X-Gm-Gg: ASbGnct1r3wqrusF3pLfdf/EBXSEaxwM1TPvMiN6MdE5LFhL1ynh2lyPZX7NOzRph7B
	hEGbMEJ0cMdTp37parib9xG+OWvkMiJspHhqCy7rabwZkUUnAjb0g6Xv4uc/fw/MwHx802mRKa1
	OoNBI2OH9P9UjI7klJ4dONs9UkCoIp1H3/8dD5aY78W9HFK5w7Y9TJ1QcZQkH021Xr08Jhvj4k+
	1rgHA1390FGvmJZ1H/HNdVU/FsIZlmXYxfJ/o+9WYbIAJXBOWBmKgl8K3mfPt8DvAGhiWizm7uH
	oEpmyknkpcf3TDIpMozLrSNoyWRHjLhl9JieLaMqkwgl9hdkaYlx+WvsGCsptoDHfUwUopWTjoC
	bDMVvjk5O9Mvx2LoWYw==
X-Received: by 2002:a05:622a:1485:b0:47a:e81b:cca6 with SMTP id d75a77b69052e-4ae6df19501mr42399371cf.10.1753360096925;
        Thu, 24 Jul 2025 05:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04/Btn8OG5XttwObKWzhY9/1kfcycD5C2rV8n13Z+RV0wFel9k+duC5TJvgsreuW5Pjh9YA==
X-Received: by 2002:a05:622a:1485:b0:47a:e81b:cca6 with SMTP id d75a77b69052e-4ae6df19501mr42399071cf.10.1753360096374;
        Thu, 24 Jul 2025 05:28:16 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff439aesm104487066b.150.2025.07.24.05.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:28:15 -0700 (PDT)
Message-ID: <91857a0f-f21a-44b8-ac50-a551abe7c5e6@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:28:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: x1e80100: add empty mdss_dp3_out
 endpoint
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
 <20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rdLUSyffwlBl4XeiGQ3xooLTefgFpuXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NCBTYWx0ZWRfX3T7gBdk+Eo/5
 NFETN8m+OU8L2bshA42ccynrmbI4t9h8BI4AClYXpps9mOT2BKf8uNDTcOm4Ru7uPlPsGC5M/tQ
 aKlrklx2NHe6ogSc0u2d7uG2/6TpoTvWAVOHUqQupoaX4UrH6QVdkORWwo8UlD7jOYwhMK28uXD
 Whyzz2uM+3MRNv+1/F4XTuwA/Ve478HkoOUYuk4mEPHVSp9DMn1j8bFewYmA0kBm7EStGQlQAMC
 vb2wpnpkUtieF0TaFXD4+zQJfA6jftPBtadkn5F5/2YlIPj8tvUUlMujQzgrcBGHu+FrjbPpBT/
 9VAU8uwaCDbvwgGNHgiKyi6/tcZItO909+ac25fS9j1rCXGNjLtuJhOSvhQbGw+A6v237kR08Ln
 8P7XttiB/XtkTHFvZePcCQvdwPIqTBsHgAraDDv/2p0JXkWLIvqnfEWVgFkY5UsueWPToJkf
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688226e2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=6j0C0c8BI2W-d_oQNA0A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: rdLUSyffwlBl4XeiGQ3xooLTefgFpuXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=741 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240094

On 7/24/25 2:23 PM, Dmitry Baryshkov wrote:
> Follow the example of other DP controllers and also eDP controller on
> SC7280 and move mdss_dp3_out endpoint declaration to the SoC
> DTSI. This slightly reduces the boilerplate in the platform DT files and
> also reduces the difference between DP and eDP controllers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

