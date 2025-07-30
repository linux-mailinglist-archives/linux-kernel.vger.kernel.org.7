Return-Path: <linux-kernel+bounces-750840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A6B161A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D02F1896ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623BD2D77E9;
	Wed, 30 Jul 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjxE+z2k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A42D640E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882640; cv=none; b=nCHzMBK6N78Pzkr+cPTtv/bnMChFyVBOsdm7dCe+CZcZLBBwcUjy20HI51EHHP3aA+lrsu+9r/eK7MkjF0shXpt9mBuu9OC7mTxDsNY3j4sd8RHBrhzreGcBT2/j2z0A4nsnVU+12nhnkBh6u3CojRjyFGOYOrXJj3+Q7Ipws2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882640; c=relaxed/simple;
	bh=UnGEp/P/b1gtgq5NHRnGprOfMT8kawtFXgke6jFNnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1VE0hJJlEmDJFxU1dbjfjEDqIRKTPl6UlGA+o6GK3ynzJxUfpQ4b0sM0TrWlqnLb9NIFIqAP2WZwH0BALIOo/hvCDMZw+xFHKKgwqVBLpvwUGJuXSB5tCUEMba/LJWXdauwt6hdfGdtIfKRI0rfIy8XlPkkcgUP22CTaFL+MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjxE+z2k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBI2024575
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eaYzJi77qoY0VmQGa6ne9vwLY2SP/8VbDbQMvWMF+cI=; b=BjxE+z2krMPHv9mC
	nZ/HdkNRxQL85QbmrzQOXo/2TpAXFokT0ecefclEGDouYYouViGAIHDi7pokR2Mi
	0LRDl5N2uBJGliTzH/CgG9QjRnrNA+ZQsy+oCnmSALfTarN03ZazfPsSSAwEv3Lu
	/xOZRAadmJzKnE16ktOY512JmbFsZADelgJpGw3RL4JtbOsi5bGMvOq1EtV3a176
	Mv2mLEJ+LHCQLq2caKw4Yg6FBNov0crdZFNOmGzgR7F/KuKx9VTGgVtBGyu7JV+b
	p1dqRTwUBUIoZKha5cQWFzfsMyWTpQYv6b7ZW+cZiQSsr45mYmAfh6pN37mZuUlY
	+Sv5DA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aku0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:37:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e48325048aso52671885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882637; x=1754487437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaYzJi77qoY0VmQGa6ne9vwLY2SP/8VbDbQMvWMF+cI=;
        b=bwpWeZkmPEKgM0PAG87gqiSvLW6ApzOwzMOxps2oUVwJi1thFe8iA6YiAgtCQH0mRE
         tnIeb5YBXub/V2OHjD6CrzZasshpAdtAd4d37OrUSxxvNjQb1GYMNLstM46dNayvYDbj
         5eifSrTRchVVKix9VnITK3yQWzzMrE+NQnf5KclO2q3aZWc01beg4oHZYJr5PXxC1Z8B
         8xyYvvbwQ/9vs3fXVfPy1c9ae87p2rZal8fwbm63VVLA/HiWZ4R+237oeAC06tJIeQ/S
         EdHVhvVj4lio4KJUpe4/opERl1b/RwK+jMloMobDlJU5Ts7H+0N+05iEmIB1w4eN5u32
         i/OA==
X-Forwarded-Encrypted: i=1; AJvYcCW65bC27QU8uXRgH3uanvnebKgg81DioM8mD5IWMsOT3f8xPOqQJW7GazqX1cbu65THWQK3j44BO76cIbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUB0sbjOAO7OPKi0QBGUNj0o2V4mYFnxuRfF4iukwitLmpXAU
	V3jmAgeHofamhdngOohqG/Nef6j6Vdz317cHaJnEW5w87gL3lQQ1OFAmSuFa0AvXGoS3AixfREz
	LTAFObnoM2wO4qh1OY0D5Neyy7DdkS/hG49t8+4OH6jaexUfln6xKLuHS2anMzcOZ2BM=
X-Gm-Gg: ASbGnctiusz0OLyYggI5802sddXi+YVyDTvxa1/QbuOAaJjvc3eU1TH5PcSLZdGUyPC
	jsrX+wNOLDjPWhCHyzviCR1UgZv3pDhlxociQ9LoLsRy6W++qDr3tGBq9Ih2A8w6Fk4UzkC2/Zh
	jUchzgeueFQ2PmsAfhu1zcNk+wK+Eg39sNOLN2z8C/DZsCt6g2WJL/OhRyee2LPOpIl910Oan+G
	6kRidWWks++dSlhXX1b6g+cpvigibpDUG9yeZUK3qUtSwdvqlDmu/pG9lEHImdWxA44EuYn2Kdw
	1Izu+mzwtwoPBX8NIzfr2ghC84/lwPiqN/wHJjh15IVPfFiCXwEfeOwa1JSe3Piq1tcs4qXO+A+
	Net1beuhklZovR1lM5w==
X-Received: by 2002:a05:620a:2544:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e66ef809f9mr252142385a.3.1753882637239;
        Wed, 30 Jul 2025 06:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGZha2wMgFradgQDb9BJZKrBTTWzQSZkHlvvJvibbYOb1WpJSfTIlhyvZmnFC6wRLBq3+92Q==
X-Received: by 2002:a05:620a:2544:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e66ef809f9mr252138485a.3.1753882636620;
        Wed, 30 Jul 2025 06:37:16 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157dc6b61fsm1525857a12.3.2025.07.30.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:37:16 -0700 (PDT)
Message-ID: <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VggDos4R1DpsH_wnNLzAfKDmUW7yVXLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5OCBTYWx0ZWRfX+7QgnDsV8oq9
 pmV10nd7GN3XJBdOawmN8N3q7isonTiD5c1Up0QfXjzKHE8bPa0utOyOTbv50CX7XIIdAsj7MyS
 pUXCAd20at8dM7lUxK4QUKrhOH9F+WaDrzYlQrrObdtJXle8bBr3r2QNP9LBEB1CPq8cQvX3B1H
 HW0TxQkAvDDyBQEIWze9lwNOnEsVCmq9UHrZGuxiaVatbEO/Ir98qrxsmQdBdADNQuSRejcFgZx
 f/zJzShau8as+CA7JWVcDJYS9A/ow1tE3nw1DHrj854Y4LdvS/5QhOb+HPVi1ncvBt5z0Kfqrhz
 bnJ7JSxRy6V2Z9+T82v564IlOn7TzRUgnetLMttPSLursb5L3iKGn5KWYfTeJAC3TPfNW1gQhCW
 VrM2F3+HJNKLnumOw+YJup/G7fzB7Ne0N/JUcaMUkohsfkA+FNUNtLRrhUYo3VNQbSxlOLbh
X-Proofpoint-GUID: VggDos4R1DpsH_wnNLzAfKDmUW7yVXLF
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688a200e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=vwtPc_hCN_QQCO2tyN8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300098

On 7/2/25 11:13 AM, Taniya Das wrote:
> Add support for video, camera, display and gpu clock controller nodes
> for QCS615 platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Bjorn mentioned offline that these controllers should
probably have power-domains attached to them (perhaps bar
GPU_CC, that's under discussion..)

Konrad

