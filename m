Return-Path: <linux-kernel+bounces-739142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ACBB0C24E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272B618C37F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593F293C6A;
	Mon, 21 Jul 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EvppDEKe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AA293B70
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096242; cv=none; b=O19iwDvp1+gNvsGosovN7Y17GSJN+4mCkwFoGDD8GJN2bBgbPkm2cJYJYjs+OcHNe9GqJ8NKIzB3TW4eEuWH6NbnxVusp67Hx8lLVK7LMt+JIfU+6H7RAd2gcSX2EXw8C42kpT5UN3kCkQDVs6nGnB9jZN+A2kNrKaLrY96twi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096242; c=relaxed/simple;
	bh=ayVnVg9eme40xDElnjkpZrNBmaTxXUTukfPtFjBG+MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsiyTcJydYyQYJ0F8dP3uTQtGX2B1mPqtD7xxo/ESUWm7TGqBrxFyjgAKVdO5kLd2BxxyQ59fuDsUJbJnV1v4fjXhENpgPGfnQ+yt4fliYL0FPsewLCjOLtQmr1F4tC/I6xGayF1uf6YaTCB9+9H2/u4fgp6Nt4iGdEU2Iecgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EvppDEKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L9mFQe017547
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMwMN9DSD/nnB6vD5iQlaXP8fE0DlL0JKkeqnocUKcI=; b=EvppDEKeILxJaBai
	yXsQH6Toq6ipyVJkIf3hxQPSA0+mUa7KmwBWf/JSRQguTNAklSiRFypwbRGzZxv3
	CVe3ahscsFPJDSfrhCs0vxCDvT4DF6TRklYKcfEYUOAP+xKujAk7fPp2zQLD9YEQ
	AvJXHh58ibrKz2x/9x0GcwkGXDVRmHx2wekLHjeteXlWamm+AyRE85xa+2LPwQfh
	XhgEto2Q0sCDC5q5jELTGIgYSdKBu2eH7Ofuqn6Kj0tByE0m/hHeSBAaND2kCAzs
	efB1ucCGNuYJWkXVNKT7MfBXHOq6ANWGt6uuF3CNooQK+Y4dBmYx1Dex1VMvszOU
	C3Desg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rvt46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:10:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab65611676so15843501cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096238; x=1753701038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMwMN9DSD/nnB6vD5iQlaXP8fE0DlL0JKkeqnocUKcI=;
        b=GpKEWgWW3Deqw2zUud5zgf+MS51BwKB8AOvgB68TjLYpzwRJoKYuv/y+1h5O2IbyMY
         x0tRytPEuEjoF9iSvUlCILguUKekBjVdEgnJQ6LzjEEPS8CpNtc2tP8bNPRf/GYnR4Fy
         deSqiT+uQFp33st/pInwnEkXKS65Y1z8rvkUaI44+p82XTX1I7vjEHvv0oFAS1fH1BQq
         1jdUX8QxdJMvWrlYkqPD4J5nV+ruG968KJzfPSfM7npl/uHpkq5jaLlNG6ICKwULVsUj
         u1LmfCjLlLiTOayx3NNbU0DWJQKp3YynMyIuRqsOaBzUgqGmaREjSCtiGIKNOh9BoWvA
         PhNg==
X-Forwarded-Encrypted: i=1; AJvYcCUsuAjHRtAfX9wCxoS5dWJgyYiJosU0CvVlIZfmK+/syBjjskUi9R2CQD8hXyy45EKmRYbEsIWXbM+bKPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyQ6h3P3vAjV58NJJpzYEyWbeAxQgYAj8OBCap3STvsVXcWXO
	+9qZkfI9D5WaojmCZ3SHUpFsqLySUNxi1qBaUKw396b6z/vg16h6UDX3Ngmd68iLLurg+fCuFzW
	7wMk3Fo9ZpJeA1KYUtAJPoX7aAAGhryUrV4DhrRXNv6lTaJ4oQ/sfP3a1HCWb6xSkpEw=
X-Gm-Gg: ASbGncvj325C9aIGB9AQftMIOCMwXrEXFK+Lo+696d8RG2ptR9M1B2NepGm9RtzAiGd
	d3joMhpmXyvg0zVd2FO37nB+PnThF+VkZCkMKAa508nMqSclcFR7p3ec5qfBcYCCtq9d8PjCJ2+
	Sye9Ncc5IOG3EMoKgsipihWcyx3X4q6JYbrEkHOTfemkdzsOwJyrF9n9U5msFU/gOBkFLGQ+bdS
	Kr2tpB/Xf4P97cmIZP7gOKSeyMiJYbam/KN+EegKWIdWZ0OmgFDEmRpgzr9UtdKsWyDLmspssPP
	aUQw7o6VtGsAuZ7c6cpZAsleblo9ZasdsyZm8+wvJ1Rkcm0zeZNicQF7UoOr74DE+0Gbfa/c9f2
	QcVEfjyd2TE1KPGh/ClQx
X-Received: by 2002:a05:620a:2850:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e342b69642mr1175958585a.13.1753096237841;
        Mon, 21 Jul 2025 04:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+usxYJ0rcx0aY5PomFcpe95e/guIMzZOIesQD8S5mJPCtrTQdxUcKX9zEaBa9XZtr7TlJTA==
X-Received: by 2002:a05:620a:2850:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e342b69642mr1175955585a.13.1753096237196;
        Mon, 21 Jul 2025 04:10:37 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f09d99sm5298795a12.3.2025.07.21.04.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:10:36 -0700 (PDT)
Message-ID: <4d7aa1c4-9dd9-424c-bce1-fd000ba2a56c@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 13:10:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: dts: qcom: sc7280: Flatten primary usb
 controller node
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250720072125.1514823-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720072125.1514823-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA5OSBTYWx0ZWRfXzF+rhcI97upv
 yaMZr8/EOj+FMsYjEwVVm5vEHDBSKSLCp1WsefcrrtWqZNES83hJ4gBWRez3h9TFfY110+Dz4Tn
 OH16b6v44fsY6Oyq+OZm1Umz85QrC4pxcblZDGYWngEMgJ4pMgwfWW+pPsgrbwBilQTFhZSgo4l
 nZxHNnqmsTje9vm/Q+z0H/jPVGYCacUvJEUtcGqLFsdc5ffBJ5G13IKFyd/PZRj+VNjXWTv4LX7
 8ZYk6SotgeJeGG8UToEBsHkRmnIq+XQDVxH8mmTYLHVZEBgCk8tyvtJJsxKnncf1Je35UTk49aW
 XZQdWGgFj/lMbbH0rYaFLKbnB1ybhOv5wHXoxRLHV0UDBIUepT6pGavXnVJVqQ3bAsV9gpIecVK
 9ic6fQ++7yPWy8Dv0dw1jVZpZQz/JN6YzYTMo79Xc+L4cUC7NjVK2P7h2Vxdg3GAxwnQZp+e
X-Proofpoint-ORIG-GUID: bVxWsf2V1BeCJcnprQ5E0m7oReEviXE6
X-Proofpoint-GUID: bVxWsf2V1BeCJcnprQ5E0m7oReEviXE6
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e202e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=3thKaPtOxDKtY4w2F4IA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=876 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210099

On 7/20/25 9:21 AM, Krishna Kurapati wrote:
> Flatten primary usb controller node and update to using latest
> bindings and flattened driver approach.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index b1cc3bc1aec8..e94e21301bdd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4245,13 +4245,9 @@ compute-cb@14 {
>  		};
>  
>  		usb_1: usb@a6f8800 {
> -			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> -			reg = <0 0x0a6f8800 0 0x400>;
> +			compatible = "qcom,sc7280-dwc3", "qcom,snps-dwc3";
> +			reg = <0 0x0a6f8800 0 0xfc100>;

You forgot to change the base address

Konrad

