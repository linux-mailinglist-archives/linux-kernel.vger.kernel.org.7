Return-Path: <linux-kernel+bounces-721742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA47AFCD55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02481BC6D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AAE2E06D7;
	Tue,  8 Jul 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qh/MNwF7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B942E041E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984436; cv=none; b=YIGap2Jku4lue6d+s4/aeAwBzzZx9CQyyK8nHQ+cKneKN+vRZGfrv0zALOcHtdiWy/h4EXKqGeZiSuomU4ZW7z3h4y4lzEEcwTbq1Wg/HV9TdmvZBAcbYKUM7PMNHKD1IpxOmRL/NU42p9OB+nbvUJsDXlzue9zw/WyrqIqxCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984436; c=relaxed/simple;
	bh=ugicuqbU1yS1yCvIzcXqiNr1oJADRuqRGHGqN3D/WO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwkMbaGnEyY3F6NzLUUjfR5IumaSnzW4X85vi2brnQ2y6A+JcDrSom3bSGcaomxf/lFzvy6O+6WnSKCe8TKjdWOSIYnHgBG1ygLg0pJLNHFCuL637oeSsGJbGyLDSmC0r4cK4nAf2DcmTP6CO/3yd9jhB4txRHlsKLhFnusC9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qh/MNwF7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AADoB032593
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cQuSWDFSA70+qgC1klmaXdIjk5aF+kYMGvQICocunPY=; b=Qh/MNwF7SRV0euQb
	YMp7a+6AkLGtKjF0AimX7Xmm9HT9Prog+tHhaJmgL4Xuy2oT3WoN6jdX700wTiMW
	d9gVQl+BYER3+Kp0SUbVfD3f+hamKIorZ3ZFeU3t6yi3uaLOsFre/mO/Xtq76ixM
	t+wt+pt8huE652GmWeKEUgYt1MG1T9aBWcnBRyfbCzer8shMW231s4n8zUDfZ2VB
	6msy5sV28nCslRSbED+6p9JNHQn0Y70V+8iee5khpM3fu1iTM6XyvWkN56xRTbGT
	7W/rPKc4jzohLc7K3qLpTtZduUK+9LdgWF3iSLVfSFdEUiq28AaHalp6zrYVuXIj
	h0eY3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkp3vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:20:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7cfb7ee97c5so25464985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984433; x=1752589233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQuSWDFSA70+qgC1klmaXdIjk5aF+kYMGvQICocunPY=;
        b=PzgGYJx6k5RuWtHYPb6aAKjcy5LOfipQsP+64Y8NH0WXrzf8fff+BpoW+OphgBOo5w
         SAsPqUAtQFn7sskWbmj0eLB28PDIWSmGCWLt8Uvqxcd7mugYQSN4bVheP/oH1XtP+PzV
         AhOTawi3/F+E17ZeHR8e2ONXZ1vLUwuQMTJ82OvRiXIQF16Pw9iJVLEobaaBq3NrWVPT
         mjm9Ab51an70UMb7fAOmK6RL92GiFGP6TT7oOADcwHWi8JzTNScpDDEfAGsSjIoVR6Ax
         fRGm+rmhXex8dVM5yKv/YJpYJxzT2hT81WbCviFZEatLakdkebzMfLsgY/cuVkK+dSm5
         eelg==
X-Forwarded-Encrypted: i=1; AJvYcCXKKZXWUwc+Gi4AycocrKgAG0OEi35zKSXZ12E+htnWnjusy/lyWtSgE31tL5ELmtT2lb0GhtNhTxUc4tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywij1AxFTBYL7EYIAEH+c/hRUbdDvWjnDuflE6I7B7h3C8KT0FR
	SaLpArkWFLq2fGV80xLvBuAF0Upcb7lwsDNsFM1F7jXvYM/vcCOqzY4rZn2xDvnsg0Tv2EV3No/
	K21Q+pkWcYTg5Ec0LUmCHLxUnfLV4IXdm9b+itsKJ0nQtlAoa8/puUNH9lh4GHkZ0fRU=
X-Gm-Gg: ASbGncvIllqItv5UA4qDgyE9aHQI2n4zH1IGZqZO2KeZh0y2JSH2+vGa8ujQgF14T7c
	mfVTpH7lf7vu5AYqTPMNuhH8l15amJ/3gIEJD1nXFd+CV8qawBfUGs31RbJG5YUqNz7hoe6LNtB
	7OLBiixCOdB9+wIzgRVo5P3ybTv8bLQgYGasLbsiTRNwY8ZmDnquYv2WWCgQVYXZkgJto8jvK4q
	TNPL8BYt4xAg87ElyOXmOYbIrnlL3uES62MwSrVkSVitFk693mi5hXS1PA7kwsRMPBShGQI4F8d
	jmhhVVOSCDdYAA16BDw1GBrmFhJRHFik03JpG1qKq1o3u1HLq2Lum6a8MDue9zfLNQ0qLg3OBb+
	sNEc=
X-Received: by 2002:a05:620a:6284:b0:7d3:c688:a590 with SMTP id af79cd13be357-7d5ddb7222amr682445485a.4.1751984432537;
        Tue, 08 Jul 2025 07:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGQfU3IAQ16JyA/2/logP1lSj0oVrbcVrPhvRhtLenSjjIj9jAf8svRkGdzskpKDe5H2LReg==
X-Received: by 2002:a05:620a:6284:b0:7d3:c688:a590 with SMTP id af79cd13be357-7d5ddb7222amr682442685a.4.1751984431967;
        Tue, 08 Jul 2025 07:20:31 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1060sm909050266b.177.2025.07.08.07.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:20:31 -0700 (PDT)
Message-ID: <861bca9a-bf6e-400c-b4e5-58f3617698d6@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: ipq5018: Add the IMEM node
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-4-692eb92b228e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-4-692eb92b228e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: izNNeAZGsujuBQGKgYLPCuOOATiebroS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyMCBTYWx0ZWRfXxtj9ay/W32wv
 W6bg7CYS4oJKP6mLAMhkILZhaa5nzRid/3G2QVoBe18aec8IAV9jjWEC7Xbns0VCdaPpDXMKfPf
 auMWV9M/DtKVov91BD2AbpwN2UPR541JbCFGdu4e5aHg8CuShLLKy4hVF/r3D9/FyiCf1MmF3kt
 tS/aF/5c1t8nUbWA0dEZ0Rt1QTUmzrWzf1KMTqaMpA4pfDpUsHGJ4NY9yZjitLEv/pJc+oMBoeg
 LWzdu+MQM4B8arL4c6ytarBa5Q/RPRC+rTcn6S2c/Y2yOZtz/sHvsJDtns0vKRXVLllP9FS7RkX
 +5pBWsv9ERGGYG6pl0iYxQiiORig7NuqgDQFzFV88G6+KfYNzji6Ump8e2ugz3AvWhqc+siHv4o
 7DbVrkZu0wKeTXS5+zFOPKS0X8XWaP9BgKDaALhVDbrlxs7k9rPZ33//tcwEJisKB4woM+eh
X-Proofpoint-GUID: izNNeAZGsujuBQGKgYLPCuOOATiebroS
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d2932 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=owAxAYLDMf__z6yt7SIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=744 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080120

On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
> Add the IMEM node to the device tree to extract debugging information
> like system restart reason, which is populated via IMEM. Define the
> IMEM region to enable this functionality.
> 
> As described, overall IMEM region is 80KB but only initial 4KB is
> accessible by all masters in the SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

