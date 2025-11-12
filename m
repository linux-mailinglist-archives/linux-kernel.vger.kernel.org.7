Return-Path: <linux-kernel+bounces-896828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0CC51519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359A93A7F54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CA2BD5AD;
	Wed, 12 Nov 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Doa5BFkw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0zDt9PE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081E21FF30
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938946; cv=none; b=NCptrRNvr9RWtz3faxZBNPXDF/AZZQPjmOO5lJhJQcJ7xCMGnK8gvbBhaDWnFX3acnUE5ENp6NgpZtCspjOpGlIu3mlpAsrbOOhh6HbiUA4vswlggjd+osbyF9vX6vAOtSCvPBOa61YfkysEFS+XDMORXkg/awdebJ2NxwLdSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938946; c=relaxed/simple;
	bh=rlf8y0snDV9ee74P7g1N2IjYrAAhAKaZER9lUpbbuiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIGu/ATGuHjbZZFpVC6qrK6S4Ia+CV2y22ivU+J/yTn3a83ekb2xCwjVNi8KosA08UHUBUPEE4LI9KLBAGfCoWBk85jn472rEAT5r3EVMGMdylc3IGDKAjoA/0L9EQ4PZT0NUwxYe0JwmeMUYw47+xUfqUC9S06ZGFN8AXayJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Doa5BFkw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0zDt9PE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC2dpSY2820769
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PUnj++Jn64hBRSEDXwukit2wa8UGEl9FRtBeYAMRBk=; b=Doa5BFkw/Zs/X+nL
	KBN+Vxy4zE9s1VKhe18qUQVuzoiGeq4eoywSmAVOIRZDYMEYUSzPUZNGyKqj5CKJ
	3IwGEUkhoGWeqUR1m3nwseJIrk6pFcgCOZyoemObsjRNQsvusohGHhukTGaJV13C
	d7mR95RO38IWA9QHPSF+IMEu1n2CTJYcmrBwi62jBW0fLiuEQyX3UsMKOGZN01J/
	LIjth3N0Y8Ym4N+V+2o+v1DL2EW/lYbvHjM8E9KR+RPjObZeNSqdU4SCscxqR0Kx
	sobE4YgDUwt8CdIQ0VjNdRQlk7Ld6nUMMph2zXuPDoe0nyT2M7fLwPNQyNz2EkyF
	wFFvlA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac855jmqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:15:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed861df509so1739821cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762938944; x=1763543744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PUnj++Jn64hBRSEDXwukit2wa8UGEl9FRtBeYAMRBk=;
        b=M0zDt9PEqK66vfpAzzSbXJrKNPYCzOscPIniJXqJ5fhqxt7+v/oeSTfrpcSasM/OeP
         Q2d1xPUyz0eW1e+pB0n+OX9WyWv3FBZt/fH+s5EwJuaml9lZr2e7Il3SchGn/ebuHbQl
         S1WyiJyIkhY6hyw9zFSMuSajR2nBDQS59KM68FoHmOJ+0I59bJVmqQPnD+zPFPBHfiuP
         JMoceHVeOeuKuyw8uDa/RGlvj5caRy1RzlTOLiYjhsWngqBKGLmok2GcpS/6+KEo6six
         sqAdH12x1Nlx3xVuKjLcF/Apl3agY+F6sz1RqU6CmIfSmqzUb0C6OX4XYJ7RXcQN4GvD
         Q2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938944; x=1763543744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PUnj++Jn64hBRSEDXwukit2wa8UGEl9FRtBeYAMRBk=;
        b=LaKNRe4Rk9oR9o4FDsIrd+AjNojXRiBEx1msc7ej2CfxybxCQVO8yJXv15VkHY1OvO
         Zjz58/ZRQumKqFeBW2BMu6dZIlRHGn5/v2ykxNg9cMcsyVdukpsKd6IIWY1SN+fPyND3
         qrDASiGRRPpGZDukJBawUTL6sT3+TR6KScffSHGXmbQdCUeOlcBZPJ5AllgEAm/vBEZp
         Qb3/5amgxXQsSRhHKmopoAUHNeXFIUiGwidhlCQ4+EFQQNpjkzv8MgKuFv7WR4Fmj7/D
         3KGBdZP2+6rPqi/FtzXvu2gLEdw/8IIo9EXSGcW2H8/1LZFO74M4AW6D+LlofBWcPaIF
         jb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUae8cZBlmu1sZP4KeIvH7gRi+SRZIB1iC625n65fSH4ExVGKEXlsTw56kEqczMUf+CUpYs42ZjZaSFZL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Wks5MXGA4ZNbQYRS7DnySPueCcl6ZkMX2ahCR/3FeEeeF+js
	4XAZmFAZmd35IdQoZeUi+2IK8ncHr/ye9fEIneo313xAXYAZocXc0wZgCSDOa+38Y66w8fgxnxi
	l74rKwxx+4d7KAXfzepRxMcc6U4bjwaNPHs6iBsOv1duW++SnwSAAfureef1j/cRPsXE=
X-Gm-Gg: ASbGnctzjQr2TnCZgTUkB0fiIKvU9t2doo0Zg5a7yhNk7SGwFYewuwj0VDaT3GXOaSP
	rZvctx05v1zkEOg/DsTRKuD2l1Hi6MhkjPMFi98hSSxlNaGtU+mbw72OPIsKVhE2+l/m/1VoI5P
	8jBXhMrlqgoFQZfCqlZagIT2Pd90ez/1jsTzK2Lcc9I1vKzny9rVKqxGTPfcIPpqFr2nAByAY3r
	D+YeUwkxRDlKx+EgCR+BKvzkyoydq+v7vcbyoJhhPze4EjfvKb28YNgOCTpgpNsOU4EzwY45ZIc
	XstBjgbpXfPKU41xKMOtpCEBfpt+E2jgya1dPifuZgbu2/tzQeUMAkkTD++SCCx2NN070E1xeCi
	BjkR8IaGPi76dyIdNK8liyIJ/Sc9ytk7FYWqby0002EBo8tvi9snpC+GI
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr19011791cf.10.1762938943563;
        Wed, 12 Nov 2025 01:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIdhR2DGreZqzZEtahMhnF+t1wp8gNXxchmAbpfq57uIBaqNWhaIUDo4VDLqiBRn37Rf8YVQ==
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr19011641cf.10.1762938943105;
        Wed, 12 Nov 2025 01:15:43 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm1602419566b.52.2025.11.12.01.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:15:42 -0800 (PST)
Message-ID: <66b634ef-6a69-4275-b28d-2b148df22b24@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: monaco-evk: Enable PCIe0 and PCIe1 on
 monaco-evk
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ziyue.zhang@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com
References: <20251111-monaco-evk-pci-v1-1-8013d0d6a7ca@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251111-monaco-evk-pci-v1-1-8013d0d6a7ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hD6NKwWA7zWC63uRTG9XaAKp2n2mLa1D
X-Authority-Analysis: v=2.4 cv=DYwaa/tW c=1 sm=1 tr=0 ts=69145040 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9FffyO56NNMGgoAXEYMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hD6NKwWA7zWC63uRTG9XaAKp2n2mLa1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MyBTYWx0ZWRfX3TvkTQQZryPb
 38UyzMl/IItv4c8DE48/9Fcgr2xBrYAFCN+uAtGhJC/uPmvP0oeg0QkU2I5mGE/eq+04j17h8LI
 XKNRmsB1Lcpdihnlk2wdteKNKjXWshGjhxTOePGz+N9zCs22+L0KIdAPBRaNh1ui2fuh7FQ932V
 dmf+KrZRcZ2Ls2qBJ5OA/0wNcKSYJGAGic4OJM2xy0xFWJBt3DCoYO5+qVOv/Etbqb0kqIl3LJw
 KpTOVovcdh0EBqnwN5B2fIer3INyo+O6fDAJHqXyDAHH4+gAdLPXh2plTkcfJZf00ogBW1zBPk+
 J2UfZrgwlZIbrrJ/9VTovr36RsUg+sX+CZJZrmPev1MlE4Nq3OxmpYSF/d+kLHZjuXGWekPUsTY
 q/kek33W9CLAKFBkv6YUr8xl+X0UtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120073

On 11/11/25 11:08 AM, Sushrut Shree Trivedi wrote:
> Enables PCIe0 and PCIe1 controller and phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> ---
> This patch depends on the series:
> https://lore.kernel.org/all/20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com/
> ---

[...]

> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};

Neither of the two active-low reset pins should be pull-down, use
bias-disable to avoid spurious assertions

Konrad

