Return-Path: <linux-kernel+bounces-799020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266ABB425EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFBC4872E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4431DE2C2;
	Wed,  3 Sep 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2+sutGY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE788287268
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914608; cv=none; b=aR2PoY2vVvgThg1tDIc147JMG3X3/FUZuwdvdhEnICdRvb9Y6pqF+OO+bcwlPeMcHJLem7pP0PoQRhhU6LjRN5Qot6VWl9wmSHulQ/X5h8as44qeqoWnaaoXBdcWf2NJzazJYb3wsjPg556d9K/fnck5iu3+uaWsT6xIFv/2hQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914608; c=relaxed/simple;
	bh=H5qfSjclHJYp6VlMCGtyMvRXByBYpsPV4yiw5eNY7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHqEqc6WCXFmyriosA38jS2VpXRXACmB5zYCpxWNj7pBXiR+hW/+T4jU7d0QYtZU2hrR41L41pmlLmc+Ja/BsA4BeMWdRp0ve7j30aXp1U9LxCOigXgXWmMDlpvSr9KGXXr5LkW2HeWEtfe7BRGooZ7C7XMF/Hl5kEw7xhuQxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2+sutGY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxR0w030324
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=; b=p2+sutGYPslM6Z2C
	j5bJtXi8oO7ulNmoKt2MenR5taVhx+NdfhbmAHyq2GpQfZ+/kNTELUfVaBaKqkAN
	C0fb1Z15DYrLLhlwpWMWBpIuYuaxi1hj773G9nIunQkRH/aOFK49y6E+6aN+AXqT
	NkgDVHvVjodweK3/0SiOUM9V3j/KzauwIuPixykixjLBVzR/ar/000pLuY3ca3Rd
	aNdTLLHG4br25j4f6s8eCHn+jONf2tPzTReOrRLPq1ipf2KO2YAFbJFQL0IcrcMe
	zl9x7R1TBj8k0l6Wji5EZkktqJdIyOVMbDUNcBNNr445xB9l/gYo6LQ3aS7lcq7o
	IgWBWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpcdje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:50:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f7e24d88acso2157985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914605; x=1757519405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=;
        b=ZLE/SyW89jaNO+Z9gFq0tm0d7VJTKHH4vzF9CshGWHFxpXxQBNyQhGeMCV0RPCkMUr
         9TAXk2J/aHlHp+FQ+/8yx3sBHzFk1ESJtgV8V8+fv+eThLtuxLWd0Va1nY/VJvihYhbU
         dMaflguMnJkwaUaYDyLyVa9kirlQZQubr3gK2xKhECqBHk9bQiWzzwVZPF27+ghNAsQm
         9TM/z8bC2wgN9U+SVtliBUetHpTySZGKSzCtCJzOUUMwLR+YCMYpcIL7DYyNJuml3GMt
         Cj53cn4ingPT3u/lyQE8QtkrSlWjGflmbj1QGH8FVCTqN897xjEBaaEF/f2FKTGsoml1
         C5pw==
X-Forwarded-Encrypted: i=1; AJvYcCWSMoWD+0vEMkhkujQSd05W4KfLnngicOJOwzdXtwkmL4EuNmlquCjdsaW+ehze7hMfPOZnHLiBZSkYNK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TKKF8fh3B3lMNzdz1Aq8Edf+EwrexsjfZHsM9nR5vwHTKENJ
	kixhGKF1lmXLZleBZWjkaEyT/d5IIo0VR71nFHRY+4N0to0ZsSw+Kolee/7OaElUwMFzLNglWoj
	L503TavHGpomIqZ88h9VM2XLUcukJBbCMVwOjAcG5fuagDvHoS1w+HjNaZV3T3lExylg=
X-Gm-Gg: ASbGncu2a4moMngUsuYFcQdeuXHVlE33grWNKXrBbXvrKo4gOvnc6txF/JllY4rRyM1
	yd6NtgqyuNZKfwXHJ8C0QXUk+HxR4hIp0u2ImGq7xLXEU9izaOipGnzTM3ex+8SWgtKXCxbiS9v
	tZGJCEDT34q347GR4DoYFOZwCeHMyS3nLomiheGu8YtmRL06h04NsQfCp9UY6y4BVCiuojoqhQg
	hQUGXjYrNe3ThH8lcPu+G5NZwbR3WWzR1u2qIxTkdUAo5Lo/v1w8hm4YTxQGtYnBCUD0Ueq7MML
	JrkxcZev2IK/p2pD0extA4uOSMk0970ZSwZTC5BVMvUDpuDYQu71ovY/DmMs/RYKg2ttjmOEMef
	m4l7nDnqCxI7bbTx98ZCCYQ==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162338991cf.4.1756914604647;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKt+soWuAENoVdQ9j/e/O6Qu8NlsHabjBSI6xYSgRI5GQL7c5Sk7w14RsYRKa3ZHe4HcE9A==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162338661cf.4.1756914604015;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm12116057a12.47.2025.09.03.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:50:03 -0700 (PDT)
Message-ID: <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 50btrtaScAD1_7y4BFnLIBMuMhxUB4b8
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b863ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=g-wiT8vaiPKb6nfFgJ4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 50btrtaScAD1_7y4BFnLIBMuMhxUB4b8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXxTP+AHy3xq37
 dnjPtfzE5Pi1KR0ep0fm0NJ9npaRFVU527unqfhpSByWERUcSjDN09zfr6dFsvJU4Q2S8MaTMcA
 yTuVCnIvZPkvSbl5k62igC2Xnf3LgVSXfjSRVXm+mN90yj1j+aXlj2j0L7pIBTFWXBJFr6hs+cw
 dp0yOoV/x+2zNnkvlTaZ9QojzlRSCCWKmkJWcRMf49LhqypiuPUxciY3j7ng8w63e0vOG71Xmss
 xQgqIs3D26irulP1e6tSy9LI2deysarvxrTNOsel4pXnvqD7qrLmkeOU84iNqnsxhCMtc+ma45C
 KRj3XebfS1yaLlpUvlaxquKqxkkioHmsocpfgWpa/C4HYtMEUFT8SA9KMeD1kRgD7Ax7v5WKG3G
 E+6ohvXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 196c5ee0dd34..7528fa1c661a 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -379,6 +379,40 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;

property-n
property-names

in this order, please

Konrad

