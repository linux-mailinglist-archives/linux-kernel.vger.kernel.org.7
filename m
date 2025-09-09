Return-Path: <linux-kernel+bounces-807505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8759B4A54A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539B916B8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023D1F8677;
	Tue,  9 Sep 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXecIJdm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF01E5207
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406698; cv=none; b=mQ7NfC9GzUTaVWNC0aerxJd0+YfaJ3MznS/E4yu+xaeqXs7wvYkKeRK+QRiosncqibaTWvLpN+N/V5FkQ0GKnMGxe/ScYwmgvw5oafpPf+kPoZPhS4E4Aqt/hEVNOZq1XvVeXnoEplpdd/T4ombTqwM9r+Zpd+WgClu3k/wfhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406698; c=relaxed/simple;
	bh=Q3tkmiFsZJm37YxiC2B+AnN9v8rzwEJsKzvyIscck8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFzJ5U+A57URhwIMOC68lAmW4eVUQST5fCXIGNpXQ/rU1N6BZl/STO/S6S95dfkzFi6xcctMkjenQLU7rJDGij0e+ZXfUmYXfhfm0eZJ8Ty0NTF3B8S5Kvs+eE/yEMzoSwDBFW/KsHVV7hkkU+4VFkzlF0q2Cnj24NfT7K7N4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXecIJdm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896T348005260
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R7eITHZjo81f81b5RbKzWZ5Utg4ySiLXReDKdi+aAZk=; b=OXecIJdmhLNXRsX9
	97HOkojdeBBfs3VJ8ArdF+MybavsBOIkKvscuENImJT7T+FZSbF/0TXkjYx7VFt4
	dioYLMck09m/UDp4g28tVVbJumDGos3g+pXUzp0kVH+D4FGlnkJ577PfLhOj+/V9
	v0/sDc87Oj6sts8jVd1rAg8y3fgeYgP9RdxXWvD+tfjWhloqA1i+lvECBcy2H/sc
	6YlLOU/2eq94Df3j3mcUN6vFtuMeVTWde6d0ByVDZ8OQ4O9CYbFQAUPJ+YrI9eup
	L87igay6e842zCEYR1d/X/Xlaj4qVD8PvLL5wcHPv3nFi9AlyxJO5rOR/skCWb+6
	oWT3tw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdvba4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:31:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72a3a4a41a0so8362476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406695; x=1758011495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7eITHZjo81f81b5RbKzWZ5Utg4ySiLXReDKdi+aAZk=;
        b=hMMLQBbgP2/7+hkEWUg/gaXlGV6kDQdHMvwMHPKdOc+Ukc8/29/9v14lN847lt2HH8
         d3t0aXgL0HGURnPGS7GJIa/G6CATOubXPB327j6+DJH7kIvIGlAofKLkvdPjdv5ChDLx
         YyGwQayAcNlmkJEoEXCr/nA50Y5fMn3Fw0Uqag8EV69qC0HfZutXqZeQHMRFIswdP86J
         /qOLfRvqggI9QBceWmvbiaQxHKgKYisy3CzTMuKuhY7dDI8lr7GWVnJFraGWeZzh1FbL
         y2gZzOXwlI8lXUrcMhVHm3ZCNhhKar12GWMkn/iAu/yTRUKVIu32gQatTHWlKSicz8tW
         cLIA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8VYyO6m6n3/njy+eHTnNqqcSlLyUNwvdunJ/dt87JqQRThjLDQsJ0XXLvV0uO3tQIvmEpYgEjSNIxWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIneCUh84H+tTSJ39PtjGYiPG6LaHVEGwWfUpxr1jqU5tbFuNo
	L02RgcN3fDSAKDZEwK4UI3PwUaTW12OiFil/A9cHZ17aNvMOGdU170VSdCZINIb8FIeCq+SVggZ
	ub+GROjkXMAGFcPOcMVAZtXUGBtteLiGs3SrdhwtMHZU/l0ppjNJ40u3nV2LtoPdFy2w=
X-Gm-Gg: ASbGncu88uZtxYbiRmYWw2rHPiocYMp1XzPIdqgbKsN1KtVKqHQBRWm7L1V6uAl9yFH
	99NYsUs+c8Yd7lJ8e+7LZO3Z395plfbDZoa1R6AMi2+vtiBtyFZ7jGdEILUgjwuiui5BGvxHwPM
	Kg9oVanT+CxSL+LMMgNsMlbWkgwlhq3qjif9lY0+EyJhhOBF8zgj2SPQs05oa2QG9IHZqustk1v
	8nVGcfjj2ebu9d5+lqhFYfvC2ns3dq2HInlzJ9Awu07k8ceLUllDiYLAOGexJbn3+JNBWepy93h
	r4ojkcu4aXSVqZyCgj8l82Z34W8Q8K20SHokKd16zPgeeWrJZxfUsKTSIGTa+oOJUoQOw1h3bwN
	rIm/q9UESIS9l07ESJXukeg==
X-Received: by 2002:a05:622a:409:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b5f824786cmr71643921cf.0.1757406694444;
        Tue, 09 Sep 2025 01:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw4k1HxsrxxCB989pCSBZXp1N3A5thT3d8CW6byohkVI2BrFWDomLFgQWaPLslSwKMDUaaAw==
X-Received: by 2002:a05:622a:409:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b5f824786cmr71643811cf.0.1757406693919;
        Tue, 09 Sep 2025 01:31:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046eb335f5sm1400382866b.28.2025.09.09.01.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:31:33 -0700 (PDT)
Message-ID: <c1dff274-4b71-4d18-be2d-eb5959111243@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 10:31:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
 <20250909-hamoa_initial-v10-4-ec10057ffcd2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-hamoa_initial-v10-4-ec10057ffcd2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H_dtPjTXRv9K2YKHEErVzF-kdHX7qfQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX3qg043mVK6Tr
 deBz/bLWfe7NDErJdK8z9DzlXqw4SbT5tQXCv7QKDMOFFFLs+yY0KgnctrAshvnRix7ngYpouSm
 zHBN3kz+7LdiD81RPRAf2WeS8T1GSAnGMQaKtcVLu+IFt9mPF9lJvGImpS8n2bTrIXhW42AanZG
 +GjYqErXAOPz2Xpbev9QPGRnSzcbaOCHLJr+XygMt/TNfu+nGK3eWoA6B5AdBINcWrLmCkI6fxy
 E40sy1lwnpqVwUmadJ/qMPjB5X4gND16afq6N0qRIQi0ylutxDK/UBBSU+aHVXnG23q6MUZ67mi
 zcQDwIgQJ/G1J+8+Bzlm9spNZDVcIxinQo00PCwq1N3pou3GF3sZm2uHhmPJCEcrBU3qFuCY/Xj
 6COXA2wl
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bfe5e8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Kyid7Z_SZgMD8xIH7KUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: H_dtPjTXRv9K2YKHEErVzF-kdHX7qfQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On 9/9/25 5:56 AM, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> Make the following peripherals on the carrier board enabled:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> - Bluetooth
> - WLAN
> - Audio
> 
> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---

[...]

> +	sound {
> +		compatible = "qcom,x1e80100-sndcard";
> +		model = "X1E80100-EVK";
> +		audio-routing = "WooferLeft IN",
> +				"WSA WSA_SPK1 OUT",
> +				"TweeterLeft IN",
> +				"WSA WSA_SPK2 OUT",
> +				"WooferRight IN",
> +				"WSA2 WSA_SPK2 OUT",
> +				"TweeterRight IN",
> +				"WSA2 WSA_SPK2 OUT",
> +				"IN1_HPHL",
> +				"HPHL_OUT",
> +				"IN2_HPHR",
> +				"HPHR_OUT",
> +				"AMIC2",
> +				"MIC BIAS2",
> +				"VA DMIC0",
> +				"MIC BIAS3",
> +				"VA DMIC1",
> +				"MIC BIAS3",
> +				"VA DMIC2",
> +				"MIC BIAS1",
> +				"VA DMIC3",
> +				"MIC BIAS1",
> +				"VA DMIC0",
> +				"VA MIC BIAS3",
> +				"VA DMIC1",
> +				"VA MIC BIAS3",
> +				"VA DMIC2",
> +				"VA MIC BIAS1",
> +				"VA DMIC3",
> +				"VA MIC BIAS1",
> +				"TX SWR_INPUT1",
> +				"ADC2_OUTPUT";

It's good to write these entries in pairs, as that's what they
correspond to.

Please also take a look at this commit:
b49e37de8e70 ("arm64: dts: qcom: x1e80100-crd: Drop duplicate DMIC supplies")

[...]

> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";

A '\n' before status is customary

[...]

> +&usb_mp_hsphy0 {
> +	phys = <&eusb6_repeater>;
> +};
> +
> +&usb_mp_hsphy1 {
> +	phys = <&eusb3_repeater>;
> +};

See:

https://lore.kernel.org/linux-arm-msm/20250819-x1e80100-fix-usb-mp-repeaters-v1-4-0f8c186458d3@linaro.org/

Konrad

