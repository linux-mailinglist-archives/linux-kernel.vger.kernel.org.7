Return-Path: <linux-kernel+bounces-846826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E5BC9242
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4257E3E3C18
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA512E62D4;
	Thu,  9 Oct 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLRg7YqF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340E2E0B42
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014500; cv=none; b=m5sWVciL1Lz4uEHk1CO7VWl9ufThnfhPnQTkvAr3Z9wEAbVO/mCxLkKHlQqKlkDCMG+t/fwXv/tYTM9vOJ6+IwqddSiFidUhdfbdghnLQc6GDR+sxnkC/MH2bSJklKwGNuTsB4N8girb21uJy/3SNRA1FfYHnFqRZK2MjxyNXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014500; c=relaxed/simple;
	bh=L48gd4bUY0iY0RmLNqg8Qnr65EJUPqeXnSrEl3McFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbvSDLEh8uSGvAfRjCKLj861Tv49+mPk80BsWH27T3dQHizPuUepr4pdOlU9vWqhgXTwlqfPPgmGBbT6IXOego1aAIqLi6g/dDyG88NFsLaqSDj3BkJL76xpwaV3hKn15tboaFYQm7+wLyilzczqE7EhvrvIZStOWjqX/4YPq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLRg7YqF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOlb010864
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 12:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4x8fFSQ8NWhJBwrNV1vx5VXfQmCnGeigKLq2KnoY1LU=; b=SLRg7YqFiIrQ1lPE
	HxPLUZq3yZZj8Q5DeiJi5m6x4PXLMRRhEwrZcCpl3ttbOdGECbfQMJBE5QE3VsxA
	iCKo8lcK/4cCCC3y4P8yBOC3F5VE7F+IIjWaJhGMAH5jv/QPyiXaAerm6HXkVuh1
	51leb8oUthYCfIVHO+Ez6G5i1qwMotkesJOZ/kHyJ0RAZ0h6dirMFKBIetPLCzQj
	yqbwqUsDpgGf8i5CE9/wRO/5ozxn6IYAHlSnhRLr1kd8WEutwtv0LeJWFpZRV6Yx
	Ca1dQOsm9kB90uHfgq0OjPp0mOQCy2d9EoHtYft5SprMcN8iYvJ04CAkOy8vdOlv
	JkRBcw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9aataw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:54:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56b12ea56so2918291cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014497; x=1760619297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x8fFSQ8NWhJBwrNV1vx5VXfQmCnGeigKLq2KnoY1LU=;
        b=Pab/HkmUtKl2hj6NF36JVlmXQIbVXDl0YH64C0jeS3Laea8xdEQtew5Fhakb8KmDiS
         mObyGBX6WI63+OwzDOu7w8oG3Zc1ZRw/CECrhHZrkb7iyJ7X+pIadPXg1hVK6MEhARm+
         oUeNR7RYPqhjbUiqgz+U8ph7lcuKtFu+nh0xFJQWx5CYipPDHv5WtYqVqg/4PQzJnIFq
         CcoqIFLhcVZ0n0hV4qJXZyLNdw1OBDlRJcrZ83Yo5Im9lak5hU5c8dvyrHCaIagAe9JZ
         qW2Q4FchGdFn7yjKNZ7gCjprmm7eYxQS9FiCN9qOLH8bd0IDamiyYgXJXgZ3DL7n7UYq
         7jjA==
X-Forwarded-Encrypted: i=1; AJvYcCUiBLZaW5jbxE+mMD1w9GAW3tBfJ8knZb9TahvjPPR12AM4nmd47QDeIbp4J/Q44wYzb7AdHVIEq++Cjx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CEeJ5a4KniC6W1VDp6+aaFNKwNUVmsB+Jlh2dqaaeI7lURFg
	XChALtFcmSLwrpa9I2t5MbXcKD/Pv28bWO2ecljl1M/28M8ZXta9NwB9sb0oks0zsvKvjP9Bekb
	vGCKAH+b2hNK2BF/709mh9zPzmSL4na4948Zf1UGrco86EzbBH8STfMHHm5ILocysqCs=
X-Gm-Gg: ASbGnctEHSs9R121p7wX3w+Ii91BjFMXHGsB4G6Ia4WwjCvUUQlebn+IGDxM6uUL0TD
	EUPb3bW8pWrgBjvda7VlonMab8Vcjw9HQbCxeQkQrguVo4mAuz47mHqlyBLLZI5COjgsZJMVuV+
	dfGIG7SKp8lmy21Z+M46us/BDHpT/SFD4ecZobB0c4a4gKesowKJr61kxhOxaobOySTaoknX7WW
	0RmsMhs5owxZlzdkDdiEuTlhbPbsFHJ3i5NZ22ujGf4nZjV0sUA6YMwSoqaQitR076O8XLRtdII
	7x9H5+fK/RhDl/SqjqiqZyQqWWAjK/am64Yh1Xxr4ORS8C6ctlGD+25Y12d440Z094jnaxpf2Uj
	pj76DDhmb8PaUYqVdQDfHZ5DKoy4=
X-Received: by 2002:a05:622a:4586:b0:4e7:462:76fb with SMTP id d75a77b69052e-4e7046278bbmr3443401cf.4.1760014496711;
        Thu, 09 Oct 2025 05:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX5/sWgll0CtsSoWnbnw8OuK/4gzjMQpFI0vobMt8d6Sm2EXkMS+OFvldQCCANHXNk1w5jSA==
X-Received: by 2002:a05:622a:4586:b0:4e7:462:76fb with SMTP id d75a77b69052e-4e7046278bbmr3443201cf.4.1760014496195;
        Thu, 09 Oct 2025 05:54:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1926375966b.2.2025.10.09.05.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 05:54:55 -0700 (PDT)
Message-ID: <6b9ae65c-08f0-4b13-94cb-b899764bfc8c@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 14:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: sdm845-oneplus: Describe TE gpio
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-4-21eca1d5c289@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-s6e3fc2x01-v2-4-21eca1d5c289@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfXzchoecOl/U5E
 8PNN/phSOoYVC7RGCs2kEnihVyEvDmIo24wjH/bXexubzmEiFW9BDvE5p+rbD7rd0fySmk1uNro
 4G184IVCViRnDm9VB3Y3agTrh6p7T3hbj+Mk/4k5M56EFF1bLtwXEFL+GckjvR/nmBEtdexfMzT
 KVkMaaMeq5EybXBxbUIA02yeKS/8vF+ZMW0aM4LZBdIqLiYILW6PtNgG6mHALFqchoJWt90pK38
 Y/gln4cKxjQi3Wbz9u4jQ4Es/S0DCstp3NlYUx6LlbmMxjsqF/ZPRnbmWjnKj7UH0JrIUGnUkV9
 kJZLpVpfkkNZB06rT/PAQCo64qIURMxau9gV4FCJv4SZ3dkqIvSzdlRFM9o7AHuIEECW3lws3rB
 1Uc6TpEFZlQSHD+H+ktR3USm8MN4Cg==
X-Proofpoint-GUID: qRiiLJIzYoD7mKUqCZvNwZwkt7LoIsTR
X-Proofpoint-ORIG-GUID: qRiiLJIzYoD7mKUqCZvNwZwkt7LoIsTR
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e7b0a1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=qaMgwUmbLaqo04ox7REA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

On 10/8/25 4:05 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Describe panel Tearing Effect (TE) GPIO line.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 1cf03047dd7ae..75989b377f8bc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -460,6 +460,7 @@ display_panel: panel@0 {
>  		vci-supply = <&panel_vci_3v3>;
>  		poc-supply = <&panel_vddi_poc_1p8>;
>  
> +		te-gpios = <&tlmm 30 GPIO_ACTIVE_HIGH>;

Wait, I just noticed nothing consumes this..

Konrad

