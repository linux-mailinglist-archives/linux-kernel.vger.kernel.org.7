Return-Path: <linux-kernel+bounces-878068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5175C1FB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730E44E7865
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2702DC78F;
	Thu, 30 Oct 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNFLjVJO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhuPOhEz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5052135AD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822263; cv=none; b=ur8MracgOgHbbKtUscua7jHQ+oo2bajX8BZVB9W138/EDPOguReH/vk7N3OVO03RaIunANFkC3vdtrc97D2GnF7koQ83s+7UHGibLCfsE1+RioCvFvjh1SehpgFXQqAI/9FfGB/+NLIAXDmqDgyij/Ayvi8BPqNlg8FZ0tV2HoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822263; c=relaxed/simple;
	bh=l9cMvC/Bdx7ApaAEaOCjkhJrDDxNmTaoeqW9V0WqPzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hww857b/m4Y0s1vaBNrhFtfTOxtd3lgk3JAQyhCgyrDBo1NMfRCNVWfuinBjjMa3mthHzdeKyBAl0pIudO/wxA3IERk5qmFTMckTtNRs2JrSkgDlu/jOMOiijLA2k7VIIXGsisUcyJKdcblnQd2F4HGaDT0KpqcQsUdGYCTA8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNFLjVJO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhuPOhEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9SUvK1994626
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkbO7JtA2l05+kuFfUn1jkZdLBXtFJAG0KtFxR+o3Qg=; b=bNFLjVJOsDweYezT
	bjzPcm/tCq+1FcJeNuJvpuJ83Os/hCddH98GpPsj8Fx03nCo8pvq7gUqgk55GRwx
	RZBeDTUyhT62ArZdtpSmBxBYeA32WdoZ3YAVeF+7VSP8p8aEwdwVvTYMXF5vTnJc
	X/jQ5ueorLmXK21HgZmqQGFlULjM5dLtdZ+7LCIpLagL/Yv9VQQMnHg0l9hWxFgH
	+Eoq+sgG73xl7oQ/AVDhkM+Mf1RySgYzHMVj5hj/ribSRNn5yFx489yclFjDPG1E
	9D72gSgd3fuDn0BWK4j6Olw5vzfIyDfDZEQ3WewlRpyLAttwqiewv4EBFTawKwBk
	drv5wg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr71km8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-883618130f5so33327685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822260; x=1762427060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkbO7JtA2l05+kuFfUn1jkZdLBXtFJAG0KtFxR+o3Qg=;
        b=YhuPOhEzCmEa7CoURdIuo1wisJi70wvdcOZOQDwt5udJa5PCqjRRX3BH2yq4yuVALM
         +BPIjSqusos5v651c3BY2LmDRo5mXXuadLGcBiLOdlrAMiSD4ZHdbwtN12YfH1CZhEkz
         82X+gSZATG/x6nhLg8iQMMByEwy6LQ9NFb45x/FF2pDZq9db90m76XHYkj7IOjYvIwAi
         8QGD248xYA8hSDfDTvW6IRo1Qv39ogt+yD0MODah8YAZrGZzx30OQ0+Y1PWL58Q3B6Nk
         aHBIoJrTXsk0FRB8r6+7RMtOTXSRiX4YBwohiP8orbLcg3jd6MIeGXuy6G/ev5gQOQr9
         aG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822260; x=1762427060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkbO7JtA2l05+kuFfUn1jkZdLBXtFJAG0KtFxR+o3Qg=;
        b=nYZG6JL0SfPJEepAkrZLDPxoeFWLFi9x6KAm8R13gev08uXoxc6xPaIXqVowAp+110
         F7qHGZyLHZPbBYr5/qLd9MnLbxuCN2/Drja8T8W2TCTjRx2TJYzT0dLficirZphb1At+
         aRnIuxA3Vpqshc8U16RWZGT9jX+G5sCZfZtXjhfS8Z1mx3rXotEutUCAeM3y6+IKrLUn
         KmbKmMN4s9F5a9/9ateswg1JfF7dvo1J78fH94XIiHxHlAH0j88UVreUzYPTiHPcHUGL
         5Jqii73nvchBDwfVRWWWumE8mDfeg+LJkLGvG4WNGoU8LOao9AUuXp0uICgE4dU8GTbT
         G56g==
X-Forwarded-Encrypted: i=1; AJvYcCWoxlxqzLw5xc5nAp1FGou57VSzZ6HfEhs3gYuTZFQnAbPMkLLKguWI3mPW97fFg8tcbAG/R8fWra3+nAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUqSb3OAmu9oBp6bxWh60BBbRWvA733AhXQ56x10/33vb7L8Z
	1ua+GaVxgZGaAQxeGd+xXqObsZS2EVRtijdsFcSScOAVmAkPIWLMSDBrICSv9NGKjoWjXyn1H+q
	vQqfja7dFTpZ63j3D3x4oCsNSTGbUk1hXvMkl1bN3yLw0QUo+hyZYWlxV56Y8vW5TpZ4=
X-Gm-Gg: ASbGncujDXTIWT3umIBvIS+ANVA+EPAdmX045wz6SOBsHB/n3i2xwuWp2bQX1CAB5kn
	/2qEC77sgFFX2fqHc74f5rz1FYyNJ1M64PW6kW5h21vy9WDelNxnBVJha3mwb7h9VOiMYE/7dtP
	UE9GMZar7s0cUVtMPgSrqbKPnEToKeOJZSO0fur70RqfVTrlZVLRlw+v7CencvfGJ5+5qgfXwEf
	BmYsM1xj1bh0wDkfIsWiLELT/ZO8dP/F95e17rjL2jG2cb4OiLFAS+b+gh4STqr3VrhTC1weLW+
	znkVR7KZEtCC30MBZ+MHf3ynyZ6FYKprAgd0dxHc286ENRvYsq3auYufCJUtHApZE7z4lnD473x
	vF+WU2tyoBhz2bz7S+R3vk8SJJ5G/Djgi/zPlRKkZ22iAQWMyzJ1z+mPD
X-Received: by 2002:a05:622a:155:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed15c06266mr56987801cf.9.1761822260036;
        Thu, 30 Oct 2025 04:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHDBCBzdYODWamLmkDbBUuXY29vrJ8tqPdGT2NUt4Gx1O3hoobdrBluCz/hkhrbJVlKxHHiw==
X-Received: by 2002:a05:622a:155:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed15c06266mr56987301cf.9.1761822259508;
        Thu, 30 Oct 2025 04:04:19 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6dad195456sm1178555666b.72.2025.10.30.04.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:04:19 -0700 (PDT)
Message-ID: <d94cbbf7-9720-4d5d-aaf3-fbb79a47c7d9@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:04:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: add gpu_zap_shader label
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-7-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-7-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX67ZbdUnwwfJ4
 HtL9F4U6O55IEZbCnLyqYIji18ykIeiUFDlBulJvE4mG5RN2uNEJ5M3jzw/PVRU451b0kYcdihR
 lKvczpOE8qNr0I5bAZFFCP41J7at1TR6u7IQWmT4DKXLlS7+Jt2F4QP3cOxv2WlyvC4CFG5G6af
 JMOfAeWGH0zItH7R5idcCt10i1YRaFDIvHyfbehHr2ViY3mWUeNhBfOJVkIEuW/HdSH5itsA/YP
 VYOSi795JmuFZzdpSt3jRq4rKjEAjz3fhTvjbNnl7R8JSM0KP67SZwfYpF2719iFfVwylAZ8Xmb
 +TUZPrJmd8Uy8HuznlgksNw76wMoY7nVQPTM3NgpS7ThrlX/nraftvTNLPx9TBMJaRHXqollYyk
 TfG0+fm+azlwtuoWfZHkBf2YUX0yzA==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=69034634 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S6OGlrJxYZSBbBCeTXAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: IYClTATlCQPMj8AvfMfeiNfOiDNHelQ3
X-Proofpoint-GUID: IYClTATlCQPMj8AvfMfeiNfOiDNHelQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300090

On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> Patching existing DT nodes based on full path is error prone and
> generally not recommended. Follow the pattern introduced in the last
> platforms, add gpu_zap_shader label to the ZAP node and use it in the
> board files.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Let's pray this gets merged in an order that doesn't wreck havoc
or require resolving conflicts across 64 files..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

