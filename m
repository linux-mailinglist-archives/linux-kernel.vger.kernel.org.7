Return-Path: <linux-kernel+bounces-882660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E9C2B12E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09163B81B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395242FE599;
	Mon,  3 Nov 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BsWGaqtI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MERA8aAL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40FB2FDC4E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165863; cv=none; b=NKhM3MHKl8PFjMTMzPa30UN+caeeD3GV62MQmzaB8nKibQMV0qEgYViaeYrrfTZg3xHO4HtuIuv7sBYMRL6/WkfDTICrpfTa/W0ISbx235S2pHbat3Pvz94JStqDtLZrZA42VmBD7ZIy3N8DA6KB/jGRI8qMOekvTNYQR8loDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165863; c=relaxed/simple;
	bh=DUl/v+dDDeGqqyWq9yWVSUSXbQeJIusN+vU25wQ/e/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4hoHhBPhauhAMAiFYHN5DRUTrdecfp32Vk69Xd2FzJ4yVQsRJVv8PzXFjcaOKczSdfXWM+WsWY4hgcrifp2BvbL3K4VJglwrXjGsHeobYnDJyx858tOlrNVmAjd374WYYF2W46SbcT6UQ+z5vUmxREwXjqWuxymgSgzvHa2T1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BsWGaqtI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MERA8aAL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIK4J2755490
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 10:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=; b=BsWGaqtIqSlRSyOZ
	ja/kOMcXZ+vWZwhJyjM5cYka3YfJuSLcwRtK7nJaCZjTyYidO9yG25tcpL6FS2Wp
	yExKrgOVk0MVT2kpXeHxtEqV/UWbYiTv/58GYHN/baezMKkfT8QAwbilZYprUR4x
	f5Ei3TzdtVLGoLfLNlAB1qJ9B0KC1C6S4vNDRe+z12uPaXQTkCjNAoghCF1wPXL4
	WqNNnP32qLldY5extbEzZBPyBSFMy1fTVdpVrflH2h29Aw3nMS/01NBGZu8Pymrd
	q1eurZCadmdhdXOKL1mL3mYr0EVZtSfTyJ8oObnnWk1CZumZungxZBkhoCf/coIa
	fN1PzA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9r11m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:31:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-826b30ed087so14849146d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762165859; x=1762770659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=;
        b=MERA8aALj/qDbz+/oXVoCHKMPLPi1NBkTO6dcwgNwN8rKDt96Sqhv53tqgbDj3TZj2
         K/hr9CjDJ8Hsf6PsQdudgrgGn/2zI+/YHLh9IRxQS7FBYAGenYyvVV2IaDj/my0UIZE+
         ngYcUGZmHLC98vAa0s7YdrJJDFp0sW13Bx7Rx4vIibIsuw1psI3C4tSe6kVWSBimd8HH
         wEqUutFP6exOefI9mjTVUVZwIwkS6Qb1vC/uh5RCBURYDW/4TpKbqmeVKIzdFoHTLtLU
         Iek0yHep5Fx+WltUp8m+0Wt4gdwx2KE6kJzhB0N52b62liTpW4XanaIPJHwFshm25Y80
         t9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165859; x=1762770659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=;
        b=r1iaGkCQit7HBQnrCZAEHzrzmIXXJXFjbPaCxgkCqdlMq6CyLMY+WWcBy3MfeNz5CS
         nRrBMp0OTDIczMxJV7Ee0tU7b/P+9C61dfg9u+hNw9/cZXCuV8dShuIaqcoivh29NBqW
         qqP8b1J7rW+bzKazy2MBEWIFBwR9kdWlcHzA9yurtta/2ok7jdwyZCG6dA+GTv0CyHxw
         eZ4jAgBHvJmZyich+2Zhohcqja47yXJhmSYN1vr1LWStRaiGs2qKLOdR3w3LRKQUhp+i
         /HalkyWJUWshdVvyeoSZS04IuuAFUzMBTtxD5jX9XOnqa5XOhbOwl+1fCqJg1drXYpUp
         nvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3lhyoDEFgoDHsnqesjbfcnarQjPjGGXRIycEANx6CytKWd87iqblqC1ragkg5+uPnule+gU2PY/6hgHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+4M4MRktm3SE6r8QspaLEUIRv0Bb0Ctgztdaa7WsmO9OxH4S
	n1/Q1Y3sSaJ2UQz2eC5Zeci18I9WIHrwI94AnVYPhXBoq6cvZaWtQxoFqA17GH7LwsnQGWwr3Qi
	u5L+J0pFs8z+qO/gf/sqak9uooanuUWUouAOlubmw/6Dl/Z3v6HfE49Ozm1s6z6bCP0U=
X-Gm-Gg: ASbGncuTfDoNtM6nCqqx0KbBl64h9Nw061qdn1rgVOFQbrSDf8gQqFQsf6hnaHwsU2C
	laY2Tsv+cT7hP08HqEiNUsytpCCeh8lzwVrb0pjgnaa6ZSNv4bIEcxrqbkr3/Gunvd2d1Nc1OQe
	LvgQgc8ast+HXevrqmHFRFBcpwK8ejYHaKpTuNjPBmifhkl99tLvRpP4VUSpEfi5mETsJVCv88E
	2jWFsP3PfD6B50Edr31oQfXAaLdciQFFTzw+PpyRr41AY867KFDAnZSnCiuhwnyjkiUgG8CB4kY
	hKPZCDAlEhGbpM9XqYnM2KJRSJfqulgay8gzBNIxt1rLtlWEz5ve1/jmThb5Ngx9Lq8Z4n3rWP9
	zc4pPbe9wem93PRrp3XF3IZ3FYezIRIE/mQ7R9DheZ8BL1/1YTuSHF+wU
X-Received: by 2002:a05:6214:415:b0:880:5cc1:693e with SMTP id 6a1803df08f44-8805cc16b70mr6734596d6.7.1762165859023;
        Mon, 03 Nov 2025 02:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQp+B6BbASeIJWfxPDgxaNj/gsZ2jj9hIlPnMzU22TpzxNI//yIFYM2vt+axjIO4e746PIRg==
X-Received: by 2002:a05:6214:415:b0:880:5cc1:693e with SMTP id 6a1803df08f44-8805cc16b70mr6734366d6.7.1762165858569;
        Mon, 03 Nov 2025 02:30:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975cfesm1000680166b.4.2025.11.03.02.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:30:58 -0800 (PST)
Message-ID: <801d8e09-276b-427d-8419-7f2355df2295@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 11:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
 <20251101-tc9563-v9-7-de3429f7787a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-7-de3429f7787a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RUsWO7RbCQP-u3NfIf0XsFO2N9hAcwk8
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=69088464 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=gkRObvzxmN_HJK3DEhcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RUsWO7RbCQP-u3NfIf0XsFO2N9hAcwk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NSBTYWx0ZWRfX1vWN+K+uSGaA
 a/+gqbSGsOBYbN+6DwD08c9Mbh0LUzGFgBktOFycNUrbQkGk7/K3cWFunU5cvUdZUsK8XT6y46Y
 bL3ZtlYERDsgIUoUczFCyhU6cFhiAABSKWuoLTT9D1ukEWnEIvxhfto/Ziyjv1NdCKPb747roY0
 sveo3y1sZw/cBYgR84UrTWTFJ7e7LRh5Qb9J6cr5UXY5/xNAn+5ABpxTAKf6wF17pNpIfLOcxIY
 rJCInuABFDYOjznM2U+g7ZN+KFKVhs9ax7BLrBoDvFODMV3ESRPATpXXeKEOf+AdB5s2VSyC8QH
 rNekP5xhINZEHsS9NH451nRB1JJ6/dl5BkSzDNVK1/ysG3fhWB9H+3gpgQg+nwwFZ54/FsxWxUG
 xuuezWKdeUc4sFbDGnZXTeGkCeDOoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030095

On 11/1/25 4:59 AM, Krishna Chaitanya Chundru wrote:
> Add a node for the TC9563 PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> As all these ports are present in the node represent the downstream
> ports and embedded endpoints.
> 
> Power to the TC9563 is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC9563
> through I2C.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +	tc9563_rsex_n: tc9563-resx-state {

The label and node name disagree about the pin name

> +		pins = "gpio1";
> +		function = "normal";
> +
> +		bias-disable;

Odd \n above

Konrad

